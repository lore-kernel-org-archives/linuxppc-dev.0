Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5E892C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 18:19:38 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Mar 2013 12:46:33 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C5418E0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 12:50:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2C7JKeD28639280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 12:49:20 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2C7JM1F017212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 18:19:23 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
In-Reply-To: <20130312042547.GC9351@truffula.fritz.box>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130312042547.GC9351@truffula.fritz.box>
Date: Tue, 12 Mar 2013 12:49:22 +0530
Message-ID: <87vc8xrsp1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
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

David Gibson <dwg@au1.ibm.com> writes:

> On Fri, Feb 15, 2013 at 09:09:38PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 

.... snip....

>> - *	- We allow for USER_ESID_BITS significant bits of ESID and
>> - * CONTEXT_BITS  bits of context for user addresses.
>> - *  i.e. 64T (46 bits) of address space for up to half a million contexts.
>> - *
>> - *	- The scramble function gives robust scattering in the hash
>> - * table (at least based on some initial results).  The previous
>> - * method was more susceptible to pathological cases giving excessive
>> - * hash collisions.
>> + * We also need to avoid the last segment of the last context, because that
>> + * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
>> + * because of the modulo operation in vsid scramble. But the vmemmap
>> + * (which is what uses region 0xf) will never be close to 64TB in size
>> + * (it's 56 bytes per page of system memory).
>>   */
>>  
>>  #define CONTEXT_BITS		19
>> @@ -386,15 +382,25 @@ extern void slb_set_size(u16 size);
>>  #define USER_ESID_BITS_1T	6
>
> USER_ESID_BITS should probably be renamed just ESID_BITS, since it's
> now relevant to kernel addresses too.

Done. I added this as a patch on top of the series. 

>
>>  /*
>> + * 256MB segment
>> + * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
>> + * available for user + kernel mapping. The top 4 contexts are used for
>> + * kernel mapping. Each segment contains 2^28 bytes. Each
>> + * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
>> + * (19 == 37 + 28 - 46).
>> + */
>> +#define MAX_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 1)
>
> Hrm.  I think it would be clearer to have MAX_CONTEXT (still) be the
> maximum usable *user* context (i.e. 0x80000 - 5) and put the kernel
> ones above that still.
>

Done as

-#define MAX_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 1)
+#define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 5)

Also updated the reference of MAX_CONTEXT in the code to
MAX_USER_CONTEXT
 
>> +
>> +/*
>>   * This should be computed such that protovosid * vsid_mulitplier
>>   * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
>>   */
>>  #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
>> -#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS + 1)
>> +#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS)
>>  #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
>>  
>>  #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
>> -#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T + 1)
>> +#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T)
>>  #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
>>  
>>  

.... snip......

>>  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index 4665e82..0e9c48c 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -1268,20 +1268,39 @@ do_ste_alloc:
>>  _GLOBAL(do_stab_bolted)
>
> The stab path certainly hasn't been tested, since we've been broken on
> stab machines for a long time.
>
>>  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
>>  	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
>> +	mfspr	r11,SPRN_DAR			/* ea */
>>  
>> +	/*
>> +	 * check for bad kernel/user address
>> +	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
>> +	 */
>> +	clrldi  r9,r11,4
>> +	li	r10,-1
>> +	clrldi  r10,r10,(64 - 46)
>> +	cmpld	cr7,r9,r10
>
> You can replace the above 4 instructions with just:
> 	rldicr. r9,r11,4,(64-46-4)
>

nice, updated as below

-	clrldi  r9,r11,4
-	li	r10,-1
-	clrldi  r10,r10,(64 - 46)
-	cmpld	cr7,r9,r10
+	rldicr. r9,r11,4,(64 - 46 - 4)
 	li	r9,0	/* VSID = 0 for bad address */
-	bgt	cr7,0f
+	bne-	0f


>> +	li	r9,0	/* VSID = 0 for bad address */
>> +	bgt	cr7,0f
>> +
>> +	/*


.... snip....

>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 3a292be..bfeab83 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -194,6 +194,11 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
>>  		unsigned long vpn  = hpt_vpn(vaddr, vsid, ssize);
>>  		unsigned long tprot = prot;
>>  
>> +		/*
>> +		 * If we hit a bad address return error.
>> +		 */
>> +		if (!vsid)
>> +			return -1;
>>  		/* Make kernel text executable */
>>  		if (overlaps_kernel_text(vaddr, vaddr + step))
>>  			tprot &= ~HPTE_R_N;
>> @@ -921,11 +926,6 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>>  	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
>>  		ea, access, trap);
>>  
>> -	if ((ea & ~REGION_MASK) >= PGTABLE_RANGE) {
>> -		DBG_LOW(" out of pgtable range !\n");
>> - 		return 1;
>> -	}
>> -
>
> Hrm.  This test is conceptually different, even if the logic is the
> same as the vsid availablility test you may have performed earlier.
> Perhaps add BUILD_BUG_ON()s to ensure that they really are the same.
>

can you elaborate that ? What BUILD_BUG_ON test are you suggesting ?



>
>>  	/* Get region & vsid */
>>   	switch (REGION_ID(ea)) {
>>  	case USER_REGION_ID:
>> @@ -956,6 +956,11 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>>  	}
>>  	DBG_LOW(" mm=%p, mm->pgdir=%p, vsid=%016lx\n", mm, mm->pgd, vsid);
>>  
>> +	/* Bad address. */
>> +	if (!vsid) {
>> +		DBG_LOW("Bad address!\n");
>> +		return 1;
>> +	}
>>  	/* Get pgdir */
>>  	pgdir = mm->pgd;
>>  	if (pgdir == NULL)
>> @@ -1125,6 +1130,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>>  	/* Get VSID */
>>  	ssize = user_segment_size(ea);
>>  	vsid = get_vsid(mm->context.id, ea, ssize);
>> +	if (!vsid)
>> +		return;
>>  
>>  	/* Hash doesn't like irqs */
>>  	local_irq_save(flags);
>> @@ -1217,6 +1224,9 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
>>  	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
>>  	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
>>  
>> +	/* Don't create HPTE entries for bad address */
>> +	if (!vsid)
>> +		return;
>>  	ret = ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr),
>>  				 mode, HPTE_V_BOLTED,
>>  				 mmu_linear_psize, mmu_kernel_ssize);
>> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
>> index 40bc5b0..59cd773 100644
>> --- a/arch/powerpc/mm/mmu_context_hash64.c
>> +++ b/arch/powerpc/mm/mmu_context_hash64.c
>> @@ -29,15 +29,6 @@
>>  static DEFINE_SPINLOCK(mmu_context_lock);
>>  static DEFINE_IDA(mmu_context_ida);
>>  
>> -/*
>> - * 256MB segment
>> - * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
>> - * available for user mappings. Each segment contains 2^28 bytes. Each
>> - * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
>> - * (19 == 37 + 28 - 46).
>> - */
>> -#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
>> -
>>  int __init_new_context(void)
>>  {
>>  	int index;
>> @@ -56,7 +47,8 @@ again:
>>  	else if (err)
>>  		return err;
>>  
>> -	if (index > MAX_CONTEXT) {
>> +	if (index > (MAX_CONTEXT - 4)) {
>> +		/* Top 4 context id values are used for kernel */
>
> This change would not be necessary if you changed MAX_CONTEXT as
> suggested above.
>

done now have

-	if (index > (MAX_CONTEXT - 4)) {
-		/* Top 4 context id values are used for kernel */
+	if (index > (MAX_USER_CONTEXT) {


>>  		spin_lock(&mmu_context_lock);
>>  		ida_remove(&mmu_context_ida, index);
>>  		spin_unlock(&mmu_context_lock);
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index 1a16ca2..c066d00 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -31,13 +31,20 @@
>>   * No other registers are examined or changed.
>>   */
>>  _GLOBAL(slb_allocate_realmode)
>> -	/* r3 = faulting address */
>> +	/*
>> +	 * check for bad kernel/user address
>> +	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
>> +	 */
>> +	clrldi  r9,r3,4
>> +	li	r10,-1
>> +	clrldi  r10,r10,(64 - 46)
>> +	cmpld	cr7,r9,r10
>> +	bgt	cr7,8f
>
> As in the stab path, you can accomplish this with a single rldicr.
>
>>  
>>  	srdi	r9,r3,60		/* get region */
>> -	srdi	r10,r3,28		/* get esid */
>>  	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
>>  
>> -	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
>> +	/* r3 = address, cr7 = <> PAGE_OFFSET */
>>  	blt	cr7,0f			/* user or kernel? */
>>  
>>  	/* kernel address: proto-VSID = ESID */
>> @@ -56,18 +63,26 @@ _GLOBAL(slb_allocate_realmode)
>>  	 */
>>  _GLOBAL(slb_miss_kernel_load_linear)
>>  	li	r11,0
>> -	li	r9,0x1
>> +	/*
>> +	 * context = (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
>> +	 */
>> +	srdi	r9,r3,60
>> +	subi	r9,r9,(0xc + 3 + 1)
>> +	lis	r10, 8
>> +	add	r9,r9,r10
>
> Hrm.  You can avoid clobbering r10, which I assume is why you removed
> the computation of esid from the common path by doing this instead:
>
> 	rldicl	r9,r3,4,62
> 	addis	r9,r9,8
> 	subi	r9,r9,4

nice. Updated. I am inlining the final patch below. 

>
>> +	srdi	r10,r3,SID_SHIFT	/* get esid */
>>  	/*
>>  	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
>>  	 * the necessary adjustment
>>  	 */
>> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>> +	rldimi  r10,r9,USER_ESID_BITS,0
>>  BEGIN_FTR_SECTION
>>  	b	slb_finish_load
>>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>  	b	slb_finish_load_1T
>>  
>>  1:
>> +	srdi	r10,r3,SID_SHIFT	/* get esid */
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>  	/* Check virtual memmap region. To be patches at kernel boot */
>>  	cmpldi	cr0,r9,0xf
>> @@ -91,23 +106,26 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>>  	_GLOBAL(slb_miss_kernel_load_io)
>>  	li	r11,0
>>  6:
>> -	li	r9,0x1
>> +	/*
>> +	 * context = (MAX_CONTEXT - 3) + ((ea >> 60) - 0xc)
>> +	 */
>> +	srdi	r9,r3,60
>> +	subi	r9,r9,(0xc + 3 + 1)
>> +	lis	r10,8
>> +	add	r9,r9,r10
>> +	srdi	r10,r3,SID_SHIFT
>
> Same here.  Can you put the kernel context calculation into a common
> path?  In fact, now that kernel vsids, like user vsids are made of a
> context and vsid component, can you put the rldimi which combines them
> into a common path for both kernel and user addresses?


will do.

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ffa0c48..f0351b5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1274,12 +1274,9 @@ _GLOBAL(do_stab_bolted)
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
 	 */
-	clrldi  r9,r11,4
-	li	r10,-1
-	clrldi  r10,r10,(64 - 46)
-	cmpld	cr7,r9,r10
+	rldicr. r9,r11,4,(64 - 46 - 4)
 	li	r9,0	/* VSID = 0 for bad address */
-	bgt	cr7,0f
+	bne-	0f
 
 	/*
 	 * Calculate VSID:
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 80fd644..349411e 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -35,16 +35,14 @@ _GLOBAL(slb_allocate_realmode)
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
 	 */
-	clrldi  r9,r3,4
-	li	r10,-1
-	clrldi  r10,r10,(64 - 46)
-	cmpld	cr7,r9,r10
-	bgt	cr7,8f
+	rldicr. r9,r3,4,(64 - 46 - 4)
+	bne-	8f
 
 	srdi	r9,r3,60		/* get region */
+	srdi	r10,r3,SID_SHIFT	/* get esid */
 	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
 
-	/* r3 = address, cr7 = <> PAGE_OFFSET */
+	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
 	blt	cr7,0f			/* user or kernel? */
 
 	/* kernel address: proto-VSID = ESID */
@@ -66,11 +64,10 @@ _GLOBAL(slb_miss_kernel_load_linear)
 	/*
 	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
 	 */
-	srdi	r9,r3,60
-	subi	r9,r9,(0xc + 4)
-	lis	r10, 8
-	add	r9,r9,r10
-	srdi	r10,r3,SID_SHIFT	/* get esid */
+	rldicl	r9,r3,4,62
+	addis	r9,r9,8
+	subi	r9,r9,4
+
 	/*
 	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
 	 * the necessary adjustment
@@ -82,7 +79,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
 1:
-	srdi	r10,r3,SID_SHIFT	/* get esid */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
@@ -109,11 +105,9 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	/*
 	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
 	 */
-	srdi	r9,r3,60
-	subi	r9,r9,(0xc + 4)
-	lis	r10,8
-	add	r9,r9,r10
-	srdi	r10,r3,SID_SHIFT
+	rldicl	r9,r3,4,62
+	addis	r9,r9,8
+	subi	r9,r9,4
 	/*
 	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
 	 * the necessary adjustment
@@ -125,8 +119,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
 0:
-	srdi	r10,r3,SID_SHIFT	/* get esid */
-
 	/* when using slices, we extract the psize off the slice bitmaps
 	 * and then we need to get the sllp encoding off the mmu_psize_defs
 	 * array.
