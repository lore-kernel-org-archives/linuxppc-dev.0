Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97EBC1A0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 18:30:57 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 727A114011D
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 18:30:57 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 18:30:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH 02/15] powerpc/cell: Move data segment faulting code out
 of cell platform
In-Reply-To: <1411028820-29933-3-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-3-git-send-email-mikey@neuling.org>
Date: Mon, 29 Sep 2014 14:00:43 +0530
Message-ID: <8738barfpo.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 imunsie@au1.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> __spu_trap_data_seg() currently contains code to determine the VSID and ESID
> required for a particular EA and mm struct.
>
> This code is generically useful for other co-processors.  This moves the code
> of the cell platform so it can be used by other powerpc code.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h  |  2 ++
>  arch/powerpc/mm/copro_fault.c          | 48 ++++++++++++++++++++++++++++++++++
>  arch/powerpc/mm/slb.c                  |  3 ---
>  arch/powerpc/platforms/cell/spu_base.c | 41 +++--------------------------
>  4 files changed, 54 insertions(+), 40 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index d765144..fd19a53 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -180,6 +180,8 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
>   * we work in all cases including 4k page size.
>   */
>  #define VPN_SHIFT	12
> +#define slb_vsid_shift(ssize)	\
> +	((ssize) == MMU_SEGSIZE_256M ? SLB_VSID_SHIFT : SLB_VSID_SHIFT_1T)

can it be static inline similar to segment_shift() ?

>  
>  /*
>   * HPTE Large Page (LP) details
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index ba7df14..4105a63 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -90,3 +90,51 @@ out_unlock:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
> +
> +int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *vsid)
> +{
> +	int psize, ssize;
> +
> +	*esid = (ea & ESID_MASK) | SLB_ESID_V;
> +
> +	switch (REGION_ID(ea)) {
> +	case USER_REGION_ID:
> +		pr_devel("copro_data_segment: 0x%llx -- USER_REGION_ID\n", ea);
> +#ifdef CONFIG_PPC_MM_SLICES
> +		psize = get_slice_psize(mm, ea);
> +#else
> +		psize = mm->context.user_psize;
> +#endif

We don't need that.

#ifdef CONFIG_PPC_STD_MMU_64
#define get_slice_psize(mm, addr)	((mm)->context.user_psize)



> +		ssize = user_segment_size(ea);
> +		*vsid = (get_vsid(mm->context.id, ea, ssize)
> +			<< slb_vsid_shift(ssize)) | SLB_VSID_USER
> +			| (ssize == MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> +		break;
> +	case VMALLOC_REGION_ID:
> +		pr_devel("copro_data_segment: 0x%llx -- VMALLOC_REGION_ID\n", ea);
> +		if (ea < VMALLOC_END)
> +			psize = mmu_vmalloc_psize;
> +		else
> +			psize = mmu_io_psize;
> +		*vsid = (get_kernel_vsid(ea, mmu_kernel_ssize)
> +			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
> +			| (mmu_kernel_ssize == MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> +		break;
> +	case KERNEL_REGION_ID:
> +		pr_devel("copro_data_segment: 0x%llx -- KERNEL_REGION_ID\n", ea);
> +		psize = mmu_linear_psize;
> +		*vsid = (get_kernel_vsid(ea, mmu_kernel_ssize)
> +			<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL
> +			| (mmu_kernel_ssize == MMU_SEGSIZE_1T ? SLB_VSID_B_1T : 0);
> +		break;
> +	default:
> +		/* Future: support kernel segments so that drivers can use the
> +		 * CoProcessors */
> +		pr_debug("invalid region access at %016llx\n", ea);
> +		return 1;
> +	}
> +	*vsid |= mmu_psize_defs[psize].sllp;
> +
> +	return 0;
> +}

large part of this is same as what we do in hash_page. And we are not
really updating vsid here, it is vsid slb encoding. So why not abstract
the vsid part and use that in hash_page also ? That would have also taken
care of the above #ifdef.

> +EXPORT_SYMBOL_GPL(copro_data_segment);
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 0399a67..6e450ca 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -46,9 +46,6 @@ static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
>  	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | slot;
>  }
>  
> -#define slb_vsid_shift(ssize)	\
> -	((ssize) == MMU_SEGSIZE_256M? SLB_VSID_SHIFT: SLB_VSID_SHIFT_1T)
> -
>  static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
>  					 unsigned long flags)
>  {
> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> index 2930d1e..fe004b1 100644
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -167,45 +167,12 @@ static inline void spu_load_slb(struct spu *spu, int slbe, struct spu_slb *slb)
>  
>  static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
>  {
> -	struct mm_struct *mm = spu->mm;
>  	struct spu_slb slb;
> -	int psize;
> -
> -	pr_debug("%s\n", __func__);
> -
> -	slb.esid = (ea & ESID_MASK) | SLB_ESID_V;
> +	int ret;
>  
> -	switch(REGION_ID(ea)) {
> -	case USER_REGION_ID:
> -#ifdef CONFIG_PPC_MM_SLICES
> -		psize = get_slice_psize(mm, ea);
> -#else
> -		psize = mm->context.user_psize;
> -#endif
> -		slb.vsid = (get_vsid(mm->context.id, ea, MMU_SEGSIZE_256M)
> -				<< SLB_VSID_SHIFT) | SLB_VSID_USER;
> -		break;
> -	case VMALLOC_REGION_ID:
> -		if (ea < VMALLOC_END)
> -			psize = mmu_vmalloc_psize;
> -		else
> -			psize = mmu_io_psize;
> -		slb.vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M)
> -				<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
> -		break;
> -	case KERNEL_REGION_ID:
> -		psize = mmu_linear_psize;
> -		slb.vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M)
> -				<< SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
> -		break;
> -	default:
> -		/* Future: support kernel segments so that drivers
> -		 * can use SPUs.
> -		 */
> -		pr_debug("invalid region access at %016lx\n", ea);
> -		return 1;
> -	}
> -	slb.vsid |= mmu_psize_defs[psize].sllp;
> +	ret = copro_data_segment(spu->mm, ea, &slb.esid, &slb.vsid);
> +	if (ret)
> +		return ret;
>  
>  	spu_load_slb(spu, spu->slb_replace, &slb);
>  

-aneesh
