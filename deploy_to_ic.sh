#! /bin/bash

# Change the variable to "ic" to deploy the ledger on the mainnet.
export NETWORK=ic

# Change the variable to the principal that can mint and burn tokens.
# https://github.com/tomkoom/dao
DAO_BACKEND="3kz64-niaaa-aaaag-abvta-cai"
export MINTER_PRINCIPAL=$DAO_BACKEND

# Change the variable to the principal that controls archive canisters.
export ARCHIVE_CONTROLLER=$DAO_BACKEND

export TOKEN_NAME="tkn"
export TOKEN_SYMBOL="TKN"

# reinstall
dfx canister --network ${NETWORK} install icrc1-ledger --argument '(variant { Init = 
      record {
        token_name = "'${TOKEN_NAME}'";
        token_symbol = "'${TOKEN_SYMBOL}'";
        minting_account = record { owner = principal "'${MINTER_PRINCIPAL}'";};
        initial_balances = vec {};
        metadata = vec {};
        transfer_fee = 100000;
        archive_options = record {
          trigger_threshold = 2000;
          num_blocks_to_archive = 1000;
          controller_id = principal "'${ARCHIVE_CONTROLLER}'";
        }
}})' --mode reinstall

# dfx deploy --network ${NETWORK} icrc1-ledger --argument '(variant { Init = 
#       record {
#         token_name = "'${TOKEN_NAME}'";
#         token_symbol = "'${TOKEN_SYMBOL}'";
#         minting_account = record { owner = principal "'${MINTER_PRINCIPAL}'";};
#         initial_balances = vec {};
#         metadata = vec {};
#         transfer_fee = "'${TRANSFER_FEE}'";
#         archive_options = record {
#           trigger_threshold = 2000;
#           num_blocks_to_archive = 1000;
#           controller_id = principal "'${ARCHIVE_CONTROLLER}'";
#         }
# }})'