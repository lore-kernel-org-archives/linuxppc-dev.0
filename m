Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtVMl1NrbzDr0W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:22:43 +1000 (AEST)
Date: Thu, 22 Jun 2017 15:22:36 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/radix: GR field got removed in ISA 3.0B
Message-ID: <20170622052236.GA25486@fergus.ozlabs.ibm.com>
References: <1498022412-30339-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498022412-30339-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2017 at 10:50:12AM +0530, Aneesh Kumar K.V wrote:
> The bit position is now marked reserved. Hence don't set the bit to 1.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h | 1 -
>  arch/powerpc/kvm/book3s_hv.c             | 6 +-----
>  arch/powerpc/mm/pgtable-radix.c          | 2 +-
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 77529a3e3811..e28ce2793e7d 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -55,7 +55,6 @@ extern struct patb_entry *partition_tb;
>  #define RPDS_MASK	0x1f		/* root page dir. size field */
>  
>  /* Bits in patb1 field */
> -#define PATB_GR		(1UL << 63)	/* guest uses radix; must match HR */
>  #define PRTS_MASK	0x1f		/* process table size field */
>  #define PRTB_MASK	0x0ffffffffffff000UL
>  
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 42b7a4fd57d9..657729a433f9 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3185,7 +3185,7 @@ static void kvmppc_setup_partition_table(struct kvm *kvm)
>  	} else {
>  		dw0 = PATB_HR | radix__get_tree_size() |
>  			__pa(kvm->arch.pgtable) | RADIX_PGD_INDEX_SIZE;
> -		dw1 = PATB_GR | kvm->arch.process_table;
> +		dw1 = kvm->arch.process_table;
>  	}
>  
>  	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
> @@ -3840,10 +3840,6 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
>  	if (radix != kvm_is_radix(kvm))
>  		return -EINVAL;
>  
> -	/* GR (guest radix) bit in process_table field must match */
> -	if (!!(cfg->process_table & PATB_GR) != radix)
> -		return -EINVAL;
> -

It's OK to take out the check, but we should also clear the GR bit,
and preferably any other reserved bits, before we put the value into
the partition table.

Paul.
