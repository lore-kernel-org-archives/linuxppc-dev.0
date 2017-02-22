Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSdDt0mn3zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:15:42 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id s67so10093213pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:15:41 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 11:15:33 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 04/10] powerpc/mm/hash: Support 68 bit VA
Message-ID: <20170222001533.GA10842@balbir.ozlabs.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487498837-12017-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 03:37:11PM +0530, Aneesh Kumar K.V wrote:
> Inorder to support large effective address range (512TB), we want to increase
> the virtual address bits to 68. But we do have platforms like p4 and p5 that can
> only do 65 bit VA. We support those platforms by limiting context bits on them
> to 16.
> 
> The protovsid -> vsid conversion is verified to work with both 65 and 68 bit
> va values. I also documented the restrictions in a table format as part of code
> comments.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  /*
>   * This should be computed such that protovosid * vsid_mulitplier
>   * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
> + * We also need to make sure that number of bits in divisor is less
> + * than twice the number of protovsid bits for our modulus optmization to work.

Could you please explain why?

I am also beginning to wonder if we need the modulus optimization.
On my compiler (a * b) % (2^n - 1) generated reasonable code with just
one multiplication and a few shifts and boolean operations.

> + * The below table shows the current values used.
> + *
> + * |-------+------------+----------------+------------+--------------|
> + * |       | Prime Bits | VSID_BITS_65VA | Total Bits | 2* VSID_BITS |
> + * |-------+------------+----------------+------------+--------------|
> + * | 1T    |         24 |             25 |         49 |           50 |
> + * |-------+------------+----------------+------------+--------------|
> + * | 256MB |         24 |             37 |         61 |           74 |
> + * |-------+------------+----------------+------------+--------------|
> + *
> + * |-------+------------+----------------+------------+--------------|
> + * |       | Prime Bits | VSID_BITS_68VA | Total Bits | 2* VSID_BITS |
> + * |-------+------------+----------------+------------+--------------|
> + * | 1T    |         24 |             28 |         52 |           56 |
> + * |-------+------------+----------------+------------+--------------|
> + * | 256MB |         24 |             40 |         64 |           80 |
> + * |-------+------------+----------------+------------+--------------|
> + *
>   */
>  #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
> -#define VSID_BITS_256M		(CONTEXT_BITS + ESID_BITS)
> +#define VSID_BITS_256M		(VA_BITS - SID_SHIFT)
>  #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
> +#define VSID_BITS_65_256M	(65 - SID_SHIFT)
>  
>  #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
> -#define VSID_BITS_1T		(CONTEXT_BITS + ESID_BITS_1T)
> +#define VSID_BITS_1T		(VA_BITS - SID_SHIFT_1T)
>  #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
> -
> +#define VSID_BITS_65_1T		(65 - SID_SHIFT_1T)
>  
>  #define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
>  
> -/*
> - * This macro generates asm code to compute the VSID scramble
> - * function.  Used in slb_allocate() and do_stab_bolted.  The function
> - * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
> - *
> - *	rt = register containing the proto-VSID and into which the
> - *		VSID will be stored
> - *	rx = scratch register (clobbered)
> - *
> - * 	- rt and rx must be different registers
> - * 	- The answer will end up in the low VSID_BITS bits of rt.  The higher
> - * 	  bits may contain other garbage, so you may need to mask the
> - * 	  result.
> - */
> -#define ASM_VSID_SCRAMBLE(rt, rx, size)					\
> -	lis	rx,VSID_MULTIPLIER_##size@h;				\
> -	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
> -	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
> -									\
> -	srdi	rx,rt,VSID_BITS_##size;					\
> -	clrldi	rt,rt,(64-VSID_BITS_##size);				\
> -	add	rt,rt,rx;		/* add high and low bits */	\
> -	/* NOTE: explanation based on VSID_BITS_##size = 36		\
> -	 * Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
> -	 * 2^36-1+2^28-1.  That in particular means that if r3 >=	\
> -	 * 2^36-1, then r3+1 has the 2^36 bit set.  So, if r3+1 has	\
> -	 * the bit clear, r3 already has the answer we want, if it	\
> -	 * doesn't, the answer is the low 36 bits of r3+1.  So in all	\
> -	 * cases the answer is the low 36 bits of (r3 + ((r3+1) >> 36))*/\

I see that this comment is lost in the new definition, could we please
retain it.

> -	addi	rx,rt,1;						\
> -	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
> -	add	rt,rt,rx
> -
>  /* 4 bits per slice and we have one slice per 1TB */
>  #define SLICE_ARRAY_SIZE  (H_PGTABLE_RANGE >> 41)
>  
> @@ -629,7 +632,7 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
>  #define vsid_scramble(protovsid, size) \
>  	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
>  
> -#else /* 1 */
> +/* simplified form avoiding mod operation */
>  #define vsid_scramble(protovsid, size) \
>  	({								 \
>  		unsigned long x;					 \
> @@ -637,6 +640,21 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
>  		x = (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
>  		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
>  	})
> +
> +static inline unsigned long vsid_scramble(unsigned long protovsid,
> +				  unsigned long vsid_multiplier, int vsid_bits)
> +{
> +	unsigned long vsid;
> +	unsigned long vsid_modulus = ((1UL << vsid_bits) - 1);
> +	/*
> +	 * We have same multipler for both 256 and 1T segements now
> +	 */
> +	vsid = protovsid * vsid_multiplier;
> +	vsid = (vsid >> vsid_bits) + (vsid & vsid_modulus);
> +	return (vsid + ((vsid + 1) >> vsid_bits)) & vsid_modulus;
> +}
> +
>  #endif /* 1 */
>  
>  /* Returns the segment size indicator for a user address */
> @@ -651,17 +669,32 @@ static inline int user_segment_size(unsigned long addr)
>  static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
>  				     int ssize)
>  {
> +	unsigned long va_bits = VA_BITS;

Is there a reason to convert the constant into unsigned long?

> +	unsigned long vsid_bits;
> +	unsigned long protovsid;
> +
>  	/*
>  	 * Bad address. We return VSID 0 for that
>  	 */
>  	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
>  		return 0;
>  
> -	if (ssize == MMU_SEGSIZE_256M)
> -		return vsid_scramble((context << ESID_BITS)
> -				     | ((ea >> SID_SHIFT) & ESID_BITS_MASK), 256M);
> -	return vsid_scramble((context << ESID_BITS_1T)
> -			     | ((ea >> SID_SHIFT_1T) & ESID_BITS_1T_MASK), 1T);
> +	if (!mmu_has_feature(MMU_FTR_68_BIT_VA))
> +		va_bits = 65;
> +
> +	if (ssize == MMU_SEGSIZE_256M) {
> +		vsid_bits = va_bits - SID_SHIFT;
> +		protovsid = (context << ESID_BITS) |
> +			((ea >> SID_SHIFT) & ESID_BITS_MASK);
> +		return vsid_scramble(protovsid,
> +				     VSID_MULTIPLIER_256M, vsid_bits);
> +	}
> +	/* 1T segment */
> +	vsid_bits = va_bits - SID_SHIFT_1T;
> +	protovsid = (context << ESID_BITS_1T) |
> +		((ea >> SID_SHIFT_1T) & ESID_BITS_1T_MASK);
> +	return vsid_scramble(protovsid,
> +			     VSID_MULTIPLIER_1T, vsid_bits);

We seem to be passing an unsigned long to a prototype above that expects
an int

>  }
>  
>  /*
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 065e762fae85..78260409dc9c 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -29,6 +29,10 @@
>   */
>  
>  /*
> + * Support for 68 bit VA space. We added that from ISA 2.05
> + */
> +#define MMU_FTR_68_BIT_VA		ASM_CONST(0x00002000)
> +/*
>   * Kernel read only support.
>   * We added the ppp value 0b110 in ISA 2.04.
>   */
> @@ -109,10 +113,10 @@
>  #define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
>  #define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
>  #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
> -#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
> -#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
> -#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
> -#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
> +#define MMU_FTRS_POWER6		MMU_FTRS_POWER5 | MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA
> +#define MMU_FTRS_POWER7		MMU_FTRS_POWER6
> +#define MMU_FTRS_POWER8		MMU_FTRS_POWER6
> +#define MMU_FTRS_POWER9		MMU_FTRS_POWER6
>  #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
>  				MMU_FTR_CI_LARGE_PAGE
>  #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
> @@ -136,7 +140,7 @@ enum {
>  		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
>  		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
>  		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
> -		MMU_FTR_KERNEL_RO |
> +		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
>  #ifdef CONFIG_PPC_RADIX_MMU
>  		MMU_FTR_TYPE_RADIX |
>  #endif
> @@ -290,7 +294,10 @@ static inline bool early_radix_enabled(void)
>  #define MMU_PAGE_16G	14
>  #define MMU_PAGE_64G	15
>  
> -/* N.B. we need to change the type of hpte_page_sizes if this gets to be > 16 */
> +/*
> + * N.B. we need to change the type of hpte_page_sizes if this gets to be > 16
> + * Also we need to change he type of mm_context.low/high_slices_psize.
> + */
>  #define MMU_PAGE_COUNT	16
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
> index d6041101a5e2..bed699ab7654 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
> @@ -229,6 +229,7 @@ void kvmppc_mmu_unmap_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
>  
>  static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
>  {
> +	unsigned long vsid_bits = VSID_BITS_65_256M;
>  	struct kvmppc_sid_map *map;
>  	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
>  	u16 sid_map_mask;
> @@ -257,7 +258,12 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
>  		kvmppc_mmu_pte_flush(vcpu, 0, 0);
>  		kvmppc_mmu_flush_segments(vcpu);
>  	}
> -	map->host_vsid = vsid_scramble(vcpu_book3s->proto_vsid_next++, 256M);
> +
> +	if (mmu_has_feature(MMU_FTR_68_BIT_VA))
> +		vsid_bits = VSID_BITS_256M;
> +
> +	map->host_vsid = vsid_scramble(vcpu_book3s->proto_vsid_next++,
> +				       VSID_MULTIPLIER_256M, vsid_bits);
>  
>  	map->guest_vsid = gvsid;
>  	map->valid = true;
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index a6450c7f9cf3..e6a5bcbf8abe 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -33,6 +33,12 @@ static DEFINE_IDA(mmu_context_ida);
>  int hash__get_new_context(void)
>  {
>  	int index, err;
> +	unsigned long max_user_context;
> +
> +	if (mmu_has_feature(MMU_FTR_68_BIT_VA))
> +		max_user_context = MAX_USER_CONTEXT;
> +	else
> +		max_user_context = MAX_USER_CONTEXT_65BIT_VA;
>  
>  again:
>  	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
> @@ -50,7 +56,7 @@ int hash__get_new_context(void)
>  	else if (err)
>  		return err;
>  
> -	if (index > MAX_USER_CONTEXT) {
> +	if (index > max_user_context) {
>  		spin_lock(&mmu_context_lock);
>  		ida_remove(&mmu_context_ida, index);
>  		spin_unlock(&mmu_context_lock);
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 4ce050ea4200..bb75a667483e 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -23,6 +23,48 @@
>  #include <asm/pgtable.h>
>  #include <asm/firmware.h>
>  
> +/*
> + * This macro generates asm code to compute the VSID scramble
> + * function.  Used in slb_allocate() and do_stab_bolted.  The function
> + * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
> + *
> + *	rt = register containing the proto-VSID and into which the
> + *		VSID will be stored
> + *	rx = scratch register (clobbered)
> + *	rf = flags
> + *
> + *	- rt and rx must be different registers
> + *	- The answer will end up in the low VSID_BITS bits of rt.  The higher
> + *	  bits may contain other garbage, so you may need to mask the
> + *	  result.
> + */
> +#define ASM_VSID_SCRAMBLE(rt, rx, rf, size)				\
> +	lis	rx,VSID_MULTIPLIER_##size@h;				\
> +	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
> +	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
> +/*									\
> + * powermac get slb fault before feature fixup, so make 65 bit part     \
> + * the default part of feature fixup					\
> + */									\
> +BEGIN_MMU_FTR_SECTION							\
> +	srdi	rx,rt,VSID_BITS_65_##size;				\
> +	clrldi	rt,rt,(64-VSID_BITS_65_##size);				\
> +	add	rt,rt,rx;						\
> +	addi	rx,rt,1;						\
> +	srdi	rx,rx,VSID_BITS_65_##size;				\
> +	add	rt,rt,rx;						\
> +	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_65_##size)); \
> +MMU_FTR_SECTION_ELSE							\
> +	srdi	rx,rt,VSID_BITS_##size;					\
> +	clrldi	rt,rt,(64-VSID_BITS_##size);				\
> +	add	rt,rt,rx;		/* add high and low bits */	\
> +	addi	rx,rt,1;						\
> +	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
> +	add	rt,rt,rx;						\
> +	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_##size)); \

Don't like this bit, it does more than scramble, it adds the flags to the generated
scramble bits, could we please revisit what ASM_VSID_SCRAMBLE should do?

Otherwise,

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir
