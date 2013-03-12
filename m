Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 212192C029D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 15:26:35 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Tue, 12 Mar 2013 14:21:29 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 20EA03578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 15:25:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2C4Cv6n7209360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 15:12:59 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2C4PnQO005810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 15:25:49 +1100
Date: Tue, 12 Mar 2013 15:25:47 +1100
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
Message-ID: <20130312042547.GC9351@truffula.fritz.box>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
In-Reply-To: <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: phileas-fogg@mail.ru, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 geoff@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2013 at 09:09:38PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
> we have boot hangs on platforms that only support 65 bit VA.
>=20
> With this patch we now have proto vsid generated as below:
>=20
> We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
> from mmu context id and effective segment id of the address.
>=20
> For user processes max context id is limited to ((1ul << 19) - 6)
> for kernel space, we use the top 4 context ids to map address as below
> 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h |  115 +++++++++++++++++----------=
------
>  arch/powerpc/kernel/exceptions-64s.S  |   37 ++++++++---
>  arch/powerpc/mm/hash_utils_64.c       |   20 ++++--
>  arch/powerpc/mm/mmu_context_hash64.c  |   12 +---
>  arch/powerpc/mm/slb_low.S             |   44 +++++++++----
>  arch/powerpc/mm/tlb_hash64.c          |    2 +-
>  6 files changed, 136 insertions(+), 94 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include=
/asm/mmu-hash64.h
> index 5f8c2bd..35bb51e 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -343,17 +343,16 @@ extern void slb_set_size(u16 size);
>  /*
>   * VSID allocation (256MB segment)
>   *
> - * We first generate a 38-bit "proto-VSID".  For kernel addresses this
> - * is equal to the ESID | 1 << 37, for user addresses it is:
> - *	(context << USER_ESID_BITS) | (esid & ((1U << USER_ESID_BITS) - 1)
> + * We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
> + * from mmu context id and effective segment id of the address.
>   *
> - * This splits the proto-VSID into the below range
> - *  0 - (2^(CONTEXT_BITS + USER_ESID_BITS) - 1) : User proto-VSID range
> - *  2^(CONTEXT_BITS + USER_ESID_BITS) - 2^(VSID_BITS) : Kernel proto-VSI=
D range
> - *
> - * We also have CONTEXT_BITS + USER_ESID_BITS =3D VSID_BITS - 1
> - * That is, we assign half of the space to user processes and half
> - * to the kernel.
> + * For user processes max context id is limited to ((1ul << 19) - 6)
> + * for kernel space, we use the top 4 context ids to map address as below
> + * NOTE: each context only support 64TB now.
> + * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> + * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> + * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> + * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
>   *
>   * The proto-VSIDs are then scrambled into real VSIDs with the
>   * multiplicative hash:
> @@ -363,22 +362,19 @@ extern void slb_set_size(u16 size);
>   * VSID_MULTIPLIER is prime, so in particular it is
>   * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
>   * Because the modulus is 2^n-1 we can compute it efficiently without
> - * a divide or extra multiply (see below).
> - *
> - * This scheme has several advantages over older methods:
> + * a divide or extra multiply (see below). The scramble function gives
> + * robust scattering in the hash * table (at least based on some initial
> + * results).
>   *
> - *	- We have VSIDs allocated for every kernel address
> - * (i.e. everything above 0xC000000000000000), except the very top
> - * segment, which simplifies several things.
> + * We also consider VSID 0 special. We use VSID 0 for slb entries mapping
> + * bad address. This enables us to consolidate bad address handling in
> + * hash_page.
>   *
> - *	- We allow for USER_ESID_BITS significant bits of ESID and
> - * CONTEXT_BITS  bits of context for user addresses.
> - *  i.e. 64T (46 bits) of address space for up to half a million context=
s.
> - *
> - *	- The scramble function gives robust scattering in the hash
> - * table (at least based on some initial results).  The previous
> - * method was more susceptible to pathological cases giving excessive
> - * hash collisions.
> + * We also need to avoid the last segment of the last context, because t=
hat
> + * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
> + * because of the modulo operation in vsid scramble. But the vmemmap
> + * (which is what uses region 0xf) will never be close to 64TB in size
> + * (it's 56 bytes per page of system memory).
>   */
> =20
>  #define CONTEXT_BITS		19
> @@ -386,15 +382,25 @@ extern void slb_set_size(u16 size);
>  #define USER_ESID_BITS_1T	6

USER_ESID_BITS should probably be renamed just ESID_BITS, since it's
now relevant to kernel addresses too.

>  /*
> + * 256MB segment
> + * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
> + * available for user + kernel mapping. The top 4 contexts are used for
> + * kernel mapping. Each segment contains 2^28 bytes. Each
> + * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
> + * (19 =3D=3D 37 + 28 - 46).
> + */
> +#define MAX_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 1)

Hrm.  I think it would be clearer to have MAX_CONTEXT (still) be the
maximum usable *user* context (i.e. 0x80000 - 5) and put the kernel
ones above that still.

> +
> +/*
>   * This should be computed such that protovosid * vsid_mulitplier
>   * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
>   */
>  #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
> -#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS + 1)
> +#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS)
>  #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
> =20
>  #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
> -#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T + 1)
> +#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T)
>  #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
> =20
> =20
> @@ -422,7 +428,8 @@ extern void slb_set_size(u16 size);
>  	srdi	rx,rt,VSID_BITS_##size;					\
>  	clrldi	rt,rt,(64-VSID_BITS_##size);				\
>  	add	rt,rt,rx;		/* add high and low bits */	\
> -	/* Now, r3 =3D=3D VSID (mod 2^36-1), and lies between 0 and		\
> +	/* NOTE: explanation based on VSID_BITS_##size =3D 36		\
> +	 * Now, r3 =3D=3D VSID (mod 2^36-1), and lies between 0 and		\
>  	 * 2^36-1+2^28-1.  That in particular means that if r3 >=3D	\
>  	 * 2^36-1, then r3+1 has the 2^36 bit set.  So, if r3+1 has	\
>  	 * the bit clear, r3 already has the answer we want, if it	\
> @@ -514,34 +521,6 @@ typedef struct {
>  	})
>  #endif /* 1 */
> =20
> -/*
> - * This is only valid for addresses >=3D PAGE_OFFSET
> - * The proto-VSID space is divided into two class
> - * User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
> - * kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1
> - *
> - * With KERNEL_START at 0xc000000000000000, the proto vsid for
> - * the kernel ends up with 0xc00000000 (36 bits). With 64TB
> - * support we need to have kernel proto-VSID in the
> - * [2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.
> - */
> -static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
> -{
> -	unsigned long proto_vsid;
> -	/*
> -	 * We need to make sure proto_vsid for the kernel is
> -	 * >=3D 2^(CONTEXT_BITS + USER_ESID_BITS[_1T])
> -	 */
> -	if (ssize =3D=3D MMU_SEGSIZE_256M) {
> -		proto_vsid =3D ea >> SID_SHIFT;
> -		proto_vsid |=3D (1UL << (CONTEXT_BITS + USER_ESID_BITS));
> -		return vsid_scramble(proto_vsid, 256M);
> -	}
> -	proto_vsid =3D ea >> SID_SHIFT_1T;
> -	proto_vsid |=3D (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T));
> -	return vsid_scramble(proto_vsid, 1T);
> -}
> -
>  /* Returns the segment size indicator for a user address */
>  static inline int user_segment_size(unsigned long addr)
>  {
> @@ -551,10 +530,15 @@ static inline int user_segment_size(unsigned long a=
ddr)
>  	return MMU_SEGSIZE_256M;
>  }
> =20
> -/* This is only valid for user addresses (which are below 2^44) */
>  static inline unsigned long get_vsid(unsigned long context, unsigned lon=
g ea,
>  				     int ssize)
>  {
> +	/*
> +	 * Bad address. We return VSID 0 for that
> +	 */
> +	if ((ea & ~REGION_MASK) >=3D PGTABLE_RANGE)
> +		return 0;
> +
>  	if (ssize =3D=3D MMU_SEGSIZE_256M)
>  		return vsid_scramble((context << USER_ESID_BITS)
>  				     | (ea >> SID_SHIFT), 256M);
> @@ -562,6 +546,25 @@ static inline unsigned long get_vsid(unsigned long c=
ontext, unsigned long ea,
>  			     | (ea >> SID_SHIFT_1T), 1T);
>  }
> =20
> +/*
> + * This is only valid for addresses >=3D PAGE_OFFSET
> + *
> + * For kernel space, we use the top 4 context ids to map address as below
> + * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> + * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> + * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> + * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
> + */
> +static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
> +{
> +	unsigned long context;
> +
> +	/*
> +	 * kernel take the top 4 context from the available range
> +	 */
> +	context =3D (MAX_CONTEXT - 3) +  ((ea >> 60) - 0xc);
> +	return get_vsid(context, ea, ssize);
> +}
>  #endif /* __ASSEMBLY__ */
> =20
>  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/e=
xceptions-64s.S
> index 4665e82..0e9c48c 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1268,20 +1268,39 @@ do_ste_alloc:
>  _GLOBAL(do_stab_bolted)

The stab path certainly hasn't been tested, since we've been broken on
stab machines for a long time.

>  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
>  	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
> +	mfspr	r11,SPRN_DAR			/* ea */
> =20
> +	/*
> +	 * check for bad kernel/user address
> +	 * (ea & ~REGION_MASK) >=3D PGTABLE_RANGE
> +	 */
> +	clrldi  r9,r11,4
> +	li	r10,-1
> +	clrldi  r10,r10,(64 - 46)
> +	cmpld	cr7,r9,r10

You can replace the above 4 instructions with just:
	rldicr. r9,r11,4,(64-46-4)

> +	li	r9,0	/* VSID =3D 0 for bad address */
> +	bgt	cr7,0f
> +
> +	/*
> +	 * Calculate VSID:
> +	 * This is the kernel vsid, we take the top for context from
> +	 * the range. context =3D (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
> +	 * Here we know that (ea >> 60) =3D=3D 0xc
> +	 */
> +	lis	r9,8
> +	subi	r9,r9,(3 + 1)		/* context */
> +
> +	srdi	r10,r11,SID_SHIFT
> +	rldimi  r10,r9,USER_ESID_BITS,0 /* proto vsid */
> +	ASM_VSID_SCRAMBLE(r10, r9, 256M)
> +	rldic	r9,r10,12,16	/* r9 =3D vsid << 12 */
> +
> +0:
>  	/* Hash to the primary group */
>  	ld	r10,PACASTABVIRT(r13)
> -	mfspr	r11,SPRN_DAR
> -	srdi	r11,r11,28
> +	srdi	r11,r11,SID_SHIFT
>  	rldimi	r10,r11,7,52	/* r10 =3D first ste of the group */
> =20
> -	/* Calculate VSID */
> -	/* This is a kernel address, so protovsid =3D ESID | 1 << 37 */
> -	li	r9,0x1
> -	rldimi  r11,r9,(CONTEXT_BITS + USER_ESID_BITS),0
> -	ASM_VSID_SCRAMBLE(r11, r9, 256M)
> -	rldic	r9,r11,12,16	/* r9 =3D vsid << 12 */
> -
>  	/* Search the primary group for a free entry */
>  1:	ld	r11,0(r10)	/* Test valid bit of the current ste	*/
>  	andi.	r11,r11,0x80
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 3a292be..bfeab83 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -194,6 +194,11 @@ int htab_bolt_mapping(unsigned long vstart, unsigned=
 long vend,
>  		unsigned long vpn  =3D hpt_vpn(vaddr, vsid, ssize);
>  		unsigned long tprot =3D prot;
> =20
> +		/*
> +		 * If we hit a bad address return error.
> +		 */
> +		if (!vsid)
> +			return -1;
>  		/* Make kernel text executable */
>  		if (overlaps_kernel_text(vaddr, vaddr + step))
>  			tprot &=3D ~HPTE_R_N;
> @@ -921,11 +926,6 @@ int hash_page(unsigned long ea, unsigned long access=
, unsigned long trap)
>  	DBG_LOW("hash_page(ea=3D%016lx, access=3D%lx, trap=3D%lx\n",
>  		ea, access, trap);
> =20
> -	if ((ea & ~REGION_MASK) >=3D PGTABLE_RANGE) {
> -		DBG_LOW(" out of pgtable range !\n");
> - 		return 1;
> -	}
> -

Hrm.  This test is conceptually different, even if the logic is the
same as the vsid availablility test you may have performed earlier.
Perhaps add BUILD_BUG_ON()s to ensure that they really are the same.


>  	/* Get region & vsid */
>   	switch (REGION_ID(ea)) {
>  	case USER_REGION_ID:
> @@ -956,6 +956,11 @@ int hash_page(unsigned long ea, unsigned long access=
, unsigned long trap)
>  	}
>  	DBG_LOW(" mm=3D%p, mm->pgdir=3D%p, vsid=3D%016lx\n", mm, mm->pgd, vsid);
> =20
> +	/* Bad address. */
> +	if (!vsid) {
> +		DBG_LOW("Bad address!\n");
> +		return 1;
> +	}
>  	/* Get pgdir */
>  	pgdir =3D mm->pgd;
>  	if (pgdir =3D=3D NULL)
> @@ -1125,6 +1130,8 @@ void hash_preload(struct mm_struct *mm, unsigned lo=
ng ea,
>  	/* Get VSID */
>  	ssize =3D user_segment_size(ea);
>  	vsid =3D get_vsid(mm->context.id, ea, ssize);
> +	if (!vsid)
> +		return;
> =20
>  	/* Hash doesn't like irqs */
>  	local_irq_save(flags);
> @@ -1217,6 +1224,9 @@ static void kernel_map_linear_page(unsigned long va=
ddr, unsigned long lmi)
>  	hash =3D hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
>  	hpteg =3D ((hash & htab_hash_mask) * HPTES_PER_GROUP);
> =20
> +	/* Don't create HPTE entries for bad address */
> +	if (!vsid)
> +		return;
>  	ret =3D ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr),
>  				 mode, HPTE_V_BOLTED,
>  				 mmu_linear_psize, mmu_kernel_ssize);
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_c=
ontext_hash64.c
> index 40bc5b0..59cd773 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -29,15 +29,6 @@
>  static DEFINE_SPINLOCK(mmu_context_lock);
>  static DEFINE_IDA(mmu_context_ida);
> =20
> -/*
> - * 256MB segment
> - * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
> - * available for user mappings. Each segment contains 2^28 bytes. Each
> - * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
> - * (19 =3D=3D 37 + 28 - 46).
> - */
> -#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
> -
>  int __init_new_context(void)
>  {
>  	int index;
> @@ -56,7 +47,8 @@ again:
>  	else if (err)
>  		return err;
> =20
> -	if (index > MAX_CONTEXT) {
> +	if (index > (MAX_CONTEXT - 4)) {
> +		/* Top 4 context id values are used for kernel */

This change would not be necessary if you changed MAX_CONTEXT as
suggested above.

>  		spin_lock(&mmu_context_lock);
>  		ida_remove(&mmu_context_ida, index);
>  		spin_unlock(&mmu_context_lock);
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 1a16ca2..c066d00 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -31,13 +31,20 @@
>   * No other registers are examined or changed.
>   */
>  _GLOBAL(slb_allocate_realmode)
> -	/* r3 =3D faulting address */
> +	/*
> +	 * check for bad kernel/user address
> +	 * (ea & ~REGION_MASK) >=3D PGTABLE_RANGE
> +	 */
> +	clrldi  r9,r3,4
> +	li	r10,-1
> +	clrldi  r10,r10,(64 - 46)
> +	cmpld	cr7,r9,r10
> +	bgt	cr7,8f

As in the stab path, you can accomplish this with a single rldicr.

> =20
>  	srdi	r9,r3,60		/* get region */
> -	srdi	r10,r3,28		/* get esid */
>  	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
> =20
> -	/* r3 =3D address, r10 =3D esid, cr7 =3D <> PAGE_OFFSET */
> +	/* r3 =3D address, cr7 =3D <> PAGE_OFFSET */
>  	blt	cr7,0f			/* user or kernel? */
> =20
>  	/* kernel address: proto-VSID =3D ESID */
> @@ -56,18 +63,26 @@ _GLOBAL(slb_allocate_realmode)
>  	 */
>  _GLOBAL(slb_miss_kernel_load_linear)
>  	li	r11,0
> -	li	r9,0x1
> +	/*
> +	 * context =3D (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
> +	 */
> +	srdi	r9,r3,60
> +	subi	r9,r9,(0xc + 3 + 1)
> +	lis	r10, 8
> +	add	r9,r9,r10

Hrm.  You can avoid clobbering r10, which I assume is why you removed
the computation of esid from the common path by doing this instead:

	rldicl	r9,r3,4,62
	addis	r9,r9,8
	subi	r9,r9,4

> +	srdi	r10,r3,SID_SHIFT	/* get esid */
>  	/*
>  	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
>  	 * the necessary adjustment
>  	 */
> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
> +	rldimi  r10,r9,USER_ESID_BITS,0
>  BEGIN_FTR_SECTION
>  	b	slb_finish_load
>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>  	b	slb_finish_load_1T
> =20
>  1:
> +	srdi	r10,r3,SID_SHIFT	/* get esid */
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  	/* Check virtual memmap region. To be patches at kernel boot */
>  	cmpldi	cr0,r9,0xf
> @@ -91,23 +106,26 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>  	_GLOBAL(slb_miss_kernel_load_io)
>  	li	r11,0
>  6:
> -	li	r9,0x1
> +	/*
> +	 * context =3D (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
> +	 */
> +	srdi	r9,r3,60
> +	subi	r9,r9,(0xc + 3 + 1)
> +	lis	r10,8
> +	add	r9,r9,r10
> +	srdi	r10,r3,SID_SHIFT

Same here.  Can you put the kernel context calculation into a common
path?  In fact, now that kernel vsids, like user vsids are made of a
context and vsid component, can you put the rldimi which combines them
into a common path for both kernel and user addresses?

>  	/*
>  	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
>  	 * the necessary adjustment
>  	 */
> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
> +	rldimi  r10,r9,USER_ESID_BITS,0
>  BEGIN_FTR_SECTION
>  	b	slb_finish_load
>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>  	b	slb_finish_load_1T
> =20
> -0:	/* user address: proto-VSID =3D context << 15 | ESID. First check
> -	 * if the address is within the boundaries of the user region
> -	 */
> -	srdi.	r9,r10,USER_ESID_BITS
> -	bne-	8f			/* invalid ea bits set */
> -
> +0:
> +	srdi	r10,r3,SID_SHIFT	/* get esid */
> =20
>  	/* when using slices, we extract the psize off the slice bitmaps
>  	 * and then we need to get the sllp encoding off the mmu_psize_defs
> diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
> index 0d82ef5..023ec8a 100644
> --- a/arch/powerpc/mm/tlb_hash64.c
> +++ b/arch/powerpc/mm/tlb_hash64.c
> @@ -82,11 +82,11 @@ void hpte_need_flush(struct mm_struct *mm, unsigned l=
ong addr,
>  	if (!is_kernel_addr(addr)) {
>  		ssize =3D user_segment_size(addr);
>  		vsid =3D get_vsid(mm->context.id, addr, ssize);
> -		WARN_ON(vsid =3D=3D 0);
>  	} else {
>  		vsid =3D get_kernel_vsid(addr, mmu_kernel_ssize);
>  		ssize =3D mmu_kernel_ssize;
>  	}
> +	WARN_ON(vsid =3D=3D 0);
>  	vpn =3D hpt_vpn(addr, vsid, ssize);
>  	rpte =3D __real_pte(__pte(pte), ptep);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlE+rksACgkQaILKxv3ab8bKjgCeIuXOVfDJVHyvrMI1fp+sTDLn
bZUAn0xzc+V8zDKD8I4Lr/yhfG8qpaI1
=EKxC
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
