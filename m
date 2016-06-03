Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLQmD1BmXzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 11:02:03 +1000 (AEST)
Message-ID: <1464915711.26773.6.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/radix: Update LPCR HR bit as per ISA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Jun 2016 11:01:51 +1000
In-Reply-To: <1464860457-29253-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464860457-29253-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-02 at 15:10 +0530, Aneesh Kumar K.V wrote:
> We need to se HR bit LPCR for radix partitions.

Again (:-) pleaaaaase.... a better changeset description. In fact this
one is actually incorrect, this is not a partition.

Something like "The processor requires the MMU mode (radix vs. hash) of
the hypervisor to be mirrored in the LPCR register, in addition to the
partition table, so as to avoid fetching from the table when deciding,
among other things, how to perform transitions to HV mode on some
interrupts. So let's set it up appropriately".

Cheers,
Ben.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h  | 1 +
>  arch/powerpc/mm/pgtable-radix.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h
> b/arch/powerpc/include/asm/reg.h
> index c1e82e968506..652147ef5ae3 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -348,6 +348,7 @@
>  #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit
> */
>  #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE)
> */
>  #define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3)
> */
> +#define	  LPCR_HR      0x00100000
>  #ifndef SPRN_LPID
>  #define SPRN_LPID	0x13F	/* Logical Partition
> Identifier */
>  #endif
> diff --git a/arch/powerpc/mm/pgtable-radix.c
> b/arch/powerpc/mm/pgtable-radix.c
> index c939e6e57a9e..73aa402047ef 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -340,7 +340,7 @@ void __init radix__early_init_mmu(void)
>  	radix_init_page_sizes();
>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>  		lpcr = mfspr(SPRN_LPCR);
> -		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
> +		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  		radix_init_partition_table();
>  	}
>  
> @@ -355,7 +355,7 @@ void radix__early_init_mmu_secondary(void)
>  	 */
>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>  		lpcr = mfspr(SPRN_LPCR);
> -		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
> +		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  
>  		mtspr(SPRN_PTCR,
>  		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
