Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4811D140180
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:12:52 +1000 (EST)
Message-ID: <5368A78D.4070509@suse.de>
Date: Tue, 06 May 2014 11:12:45 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_book3s_64.h | 146 ++++++++++++++++++++++++++-----
>   arch/powerpc/kvm/book3s_hv.c             |   7 ++
>   2 files changed, 130 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 51388befeddb..f03ea8f90576 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -77,34 +77,122 @@ static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
>   	return old == 0;
>   }
>   
> +static inline int __hpte_actual_psize(unsigned int lp, int psize)
> +{
> +	int i, shift;
> +	unsigned int mask;
> +
> +	/* start from 1 ignoring MMU_PAGE_4K */
> +	for (i = 1; i < MMU_PAGE_COUNT; i++) {
> +
> +		/* invalid penc */
> +		if (mmu_psize_defs[psize].penc[i] == -1)
> +			continue;
> +		/*
> +		 * encoding bits per actual page size
> +		 *        PTE LP     actual page size
> +		 *    rrrr rrrz		>=8KB
> +		 *    rrrr rrzz		>=16KB
> +		 *    rrrr rzzz		>=32KB
> +		 *    rrrr zzzz		>=64KB
> +		 * .......
> +		 */
> +		shift = mmu_psize_defs[i].shift - LP_SHIFT;
> +		if (shift > LP_BITS)
> +			shift = LP_BITS;
> +		mask = (1 << shift) - 1;
> +		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
> +			return i;
> +	}
> +	return -1;
> +}
> +
>   static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
>   					     unsigned long pte_index)
>   {
> -	unsigned long rb, va_low;
> +	int b_size, a_size;
> +	unsigned int penc;
> +	unsigned long rb = 0, va_low, sllp;
> +	unsigned int lp = (r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
> +
> +	if (!(v & HPTE_V_LARGE)) {
> +		/* both base and actual psize is 4k */
> +		b_size = MMU_PAGE_4K;
> +		a_size = MMU_PAGE_4K;
> +	} else {
> +		for (b_size = 0; b_size < MMU_PAGE_COUNT; b_size++) {
> +
> +			/* valid entries have a shift value */
> +			if (!mmu_psize_defs[b_size].shift)
> +				continue;
>   
> +			a_size = __hpte_actual_psize(lp, b_size);
> +			if (a_size != -1)
> +				break;
> +		}
> +	}
> +	/*
> +	 * Ignore the top 14 bits of va
> +	 * v have top two bits covering segment size, hence move
> +	 * by 16 bits, Also clear the lower HPTE_V_AVPN_SHIFT (7) bits.
> +	 * AVA field in v also have the lower 23 bits ignored.
> +	 * For base page size 4K we need 14 .. 65 bits (so need to
> +	 * collect extra 11 bits)
> +	 * For others we need 14..14+i
> +	 */
> +	/* This covers 14..54 bits of va*/
>   	rb = (v & ~0x7fUL) << 16;		/* AVA field */
> +	/*
> +	 * AVA in v had cleared lower 23 bits. We need to derive
> +	 * that from pteg index
> +	 */
>   	va_low = pte_index >> 3;
>   	if (v & HPTE_V_SECONDARY)
>   		va_low = ~va_low;
> -	/* xor vsid from AVA */
> +	/*
> +	 * get the vpn bits from va_low using reverse of hashing.
> +	 * In v we have va with 23 bits dropped and then left shifted
> +	 * HPTE_V_AVPN_SHIFT (7) bits. Now to find vsid we need
> +	 * right shift it with (SID_SHIFT - (23 - 7))
> +	 */
>   	if (!(v & HPTE_V_1TB_SEG))
> -		va_low ^= v >> 12;
> +		va_low ^= v >> (SID_SHIFT - 16);
>   	else
> -		va_low ^= v >> 24;
> +		va_low ^= v >> (SID_SHIFT_1T - 16);
>   	va_low &= 0x7ff;
> -	if (v & HPTE_V_LARGE) {
> -		rb |= 1;			/* L field */
> -		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
> -		    (r & 0xff000)) {
> -			/* non-16MB large page, must be 64k */
> -			/* (masks depend on page size) */
> -			rb |= 0x1000;		/* page encoding in LP field */
> -			rb |= (va_low & 0x7f) << 16; /* 7b of VA in AVA/LP field */
> -			rb |= ((va_low << 4) & 0xf0);	/* AVAL field (P7 doesn't seem to care) */
> -		}
> -	} else {
> -		/* 4kB page */
> -		rb |= (va_low & 0x7ff) << 12;	/* remaining 11b of VA */
> +
> +	switch (b_size) {
> +	case MMU_PAGE_4K:
> +		sllp = ((mmu_psize_defs[a_size].sllp & SLB_VSID_L) >> 6) |
> +			((mmu_psize_defs[a_size].sllp & SLB_VSID_LP) >> 4);
> +		rb |= sllp << 5;	/*  AP field */
> +		rb |= (va_low & 0x7ff) << 12;	/* remaining 11 bits of AVA */
> +		break;
> +	default:
> +	{
> +		int aval_shift;
> +		/*
> +		 * remaining 7bits of AVA/LP fields
> +		 * Also contain the rr bits of LP
> +		 */
> +		rb |= (va_low & 0x7f) << 16;
> +		/*
> +		 * Now clear not needed LP bits based on actual psize
> +		 */
> +		rb &= ~((1ul << mmu_psize_defs[a_size].shift) - 1);
> +		/*
> +		 * AVAL field 58..77 - base_page_shift bits of va
> +		 * we have space for 58..64 bits, Missing bits should
> +		 * be zero filled. +1 is to take care of L bit shift
> +		 */
> +		aval_shift = 64 - (77 - mmu_psize_defs[b_size].shift) + 1;
> +		rb |= ((va_low << aval_shift) & 0xfe);
> +
> +		rb |= 1;		/* L field */
> +		penc = mmu_psize_defs[b_size].penc[a_size];
> +		rb |= penc << 12;	/* LP field */
> +		break;
> +	}
>   	}
>   	rb |= (v >> 54) & 0x300;		/* B field */
>   	return rb;
> @@ -112,14 +200,26 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
>   
>   static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
>   {
> +	int size, a_size;
> +	/* Look at the 8 bit LP value */
> +	unsigned int lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
> +
>   	/* only handle 4k, 64k and 16M pages for now */
>   	if (!(h & HPTE_V_LARGE))
> -		return 1ul << 12;		/* 4k page */
> -	if ((l & 0xf000) == 0x1000 && cpu_has_feature(CPU_FTR_ARCH_206))
> -		return 1ul << 16;		/* 64k page */
> -	if ((l & 0xff000) == 0)
> -		return 1ul << 24;		/* 16M page */
> -	return 0;				/* error */
> +		return 1ul << 12;
> +	else {
> +		for (size = 0; size < MMU_PAGE_COUNT; size++) {
> +			/* valid entries have a shift value */
> +			if (!mmu_psize_defs[size].shift)
> +				continue;
> +
> +			a_size = __hpte_actual_psize(lp, size);

a_size as psize is probably a slightly confusing namer. Just call it 
a_psize.

So if I understand this patch correctly, it simply introduces logic to 
handle page sizes other than 4k, 64k, 16M by analyzing the actual page 
size field in the HPTE. Mind to explain why exactly that enables us to 
use THP?

What exactly is the flow if the pages are not backed by huge pages? What 
is the flow when they start to get backed by huge pages?

> +			if (a_size != -1)
> +				return 1ul << mmu_psize_defs[a_size].shift;
> +		}
> +
> +	}
> +	return 0;
>   }
>   
>   static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8227dba5af0f..a38d3289320a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1949,6 +1949,13 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
>   	 * support pte_enc here
>   	 */
>   	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
> +	/*
> +	 * Add 16MB MPSS support
> +	 */
> +	if (linux_psize != MMU_PAGE_16M) {
> +		(*sps)->enc[1].page_shift = 24;
> +		(*sps)->enc[1].pte_enc = def->penc[MMU_PAGE_16M];
> +	}

So this basically indicates that every segment (except for the 16MB one) 
can also handle 16MB MPSS page sizes? I suppose you want to remove the 
comment in kvm_vm_ioctl_get_smmu_info_hv() that says we don't do MPSS here.

Can we also ensure that every system we run on can do MPSS?


Alex
