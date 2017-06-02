Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf8TF3d3xzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 13:14:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: machine check handle ifetch from foreign
 real address for POWER9
In-Reply-To: <20170529062644.21634-1-npiggin@gmail.com>
References: <20170529062644.21634-1-npiggin@gmail.com>
Date: Fri, 02 Jun 2017 13:14:40 +1000
Message-ID: <8760gf2i8v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The i-side 0111b case was missed by 7b9f71f974 ("powerpc/64s: POWER9
> machine check handler").
>
> It is possible to trigger this exception by branching to a foreign real
> address (bits [8:12] != 0) with instruction relocation off, and verify
> the exception cause is found after this patch.

Can you define "foreign" for people who aren't reading the chip docs :)

cheers

> Fixes: 7b9f71f974 ("powerpc/64s: POWER9 machine check handler")
> Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/mce.h  | 15 ++++++++-------
>  arch/powerpc/kernel/mce.c       |  1 +
>  arch/powerpc/kernel/mce_power.c |  3 +++
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index 81eff8631434..190d69a7f701 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -90,13 +90,14 @@ enum MCE_UserErrorType {
>  enum MCE_RaErrorType {
>  	MCE_RA_ERROR_INDETERMINATE = 0,
>  	MCE_RA_ERROR_IFETCH = 1,
> -	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
> -	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN = 3,
> -	MCE_RA_ERROR_LOAD = 4,
> -	MCE_RA_ERROR_STORE = 5,
> -	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 6,
> -	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN = 7,
> -	MCE_RA_ERROR_LOAD_STORE_FOREIGN = 8,
> +	MCE_RA_ERROR_IFETCH_FOREIGN = 2,
> +	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH = 3,
> +	MCE_RA_ERROR_PAGE_TABLE_WALK_IFETCH_FOREIGN = 4,
> +	MCE_RA_ERROR_LOAD = 5,
> +	MCE_RA_ERROR_STORE = 6,
> +	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 7,
> +	MCE_RA_ERROR_PAGE_TABLE_WALK_LOAD_STORE_FOREIGN = 8,
> +	MCE_RA_ERROR_LOAD_STORE_FOREIGN = 9,
>  };
>  
>  enum MCE_LinkErrorType {
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index 5f9eada3519b..92f185875694 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -268,6 +268,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
>  	static const char *mc_ra_types[] = {
>  		"Indeterminate",
>  		"Instruction fetch (bad)",
> +		"Instruction fetch (foreign)",
>  		"Page table walk ifetch (bad)",
>  		"Page table walk ifetch (foreign)",
>  		"Load (bad)",
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index f913139bb0c2..d24e689e893f 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -236,6 +236,9 @@ static const struct mce_ierror_table mce_p9_ierror_table[] = {
>  { 0x00000000081c0000, 0x0000000000180000, true,
>    MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
>    MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x00000000001c0000, true,
> +  MCE_ERROR_TYPE_RA,  MCE_RA_ERROR_IFETCH_FOREIGN,
> +  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
>  { 0x00000000081c0000, 0x0000000008000000, true,
>    MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
>    MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
> -- 
> 2.11.0
