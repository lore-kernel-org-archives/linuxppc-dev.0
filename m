Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E327B713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 07:27:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00754DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 07:27:12 +1000 (EST)
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A3645EE.5060103@in.ibm.com>
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
	<4A34E12B.4010000@in.ibm.com> <1245027396.7705.23.camel@concordia>
	<4A3645EE.5060103@in.ibm.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 07:26:22 +1000
Message-Id: <1245101183.12400.33.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-15 at 18:30 +0530, Sachin Sant wrote:

> The corresponding C code is :
> 
>  278:   2f 80 00 00     cmpwi   cr7,r0,0
>         } else {
>                 vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
>                 ssize = mmu_kernel_ssize;
>         }
>         vaddr = hpt_va(addr, vsid, ssize);
>         rpte = __real_pte(__pte(pte), ptep);

That's interesting... __real_pte() is used to reconstruct
a PTE two halves but maybe our huge pages page tables don't have
the second half ! In which case we are just going to peek into
la-la-land. I'm also worried by the negative offset since the second
halves are at +0x8000 iirc, unless it flipped the pointers around but
that would be strange....

I'll have a look later today.

Cheers,
Ben.

>  27c:   eb 89 80 00     ld      r28,-32768(r9)  
> ^^^^ %pc points to the above line. ^^^^^
>          * Check if we have an active batch on this CPU. If not, just
>          * flush now and return. For now, we don global invalidates
>          * in that case, might be worth testing the mm cpu mask though
>          * and decide to use local invalidates instead...
> 
> I have attached the objdump o/p for tlb_hash64.o.
> 
> I could not recreate this issue with git8 kernel
> (45e3e1935e2857c54783291107d33323b3ef33c8).
> 
> Thanks
> -Sachin
> 
> plain text document attachment (tlb_hash64_objlist)
> arch/powerpc/mm/tlb_hash64.o:     file format elf64-powerpc
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <.__flush_tlb_pending>:
>  * in a batch.
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
> {
>    0:	fb e1 ff f8 	std     r31,-8(r1)
>    4:	7c 08 02 a6 	mflr    r0
>    8:	f8 01 00 10 	std     r0,16(r1)
> extern const unsigned long
> 	cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)];
> 
> static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
> {
> 	const unsigned long *p = cpu_bit_bitmap[1 + cpu % BITS_PER_LONG];
>    c:	e8 02 00 00 	ld      r0,0(r2)
>   10:	7c 7f 1b 78 	mr      r31,r3
>   14:	fb c1 ff f0 	std     r30,-16(r1)
> 			const unsigned long *src2, int nbits)
> {
> 	if (small_const_nbits(nbits))
> 		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
> 	else
> 		return __bitmap_equal(src1, src2, nbits);
>   18:	38 a0 04 00 	li      r5,1024
>   1c:	f8 21 ff 81 	stdu    r1,-128(r1)
> 	const struct cpumask *tmp;
> 	int i, local = 0;
> 
> 	i = batch->index;
> 	tmp = cpumask_of(smp_processor_id());
>   20:	a0 8d 00 0a 	lhz     r4,10(r13)
>   24:	e8 63 00 10 	ld      r3,16(r3)
>   28:	78 89 06 a0 	clrldi  r9,r4,58
>   2c:	78 84 d1 82 	rldicl  r4,r4,58,6
>   30:	39 29 00 01 	addi    r9,r9,1
>   34:	78 84 1f 24 	rldicr  r4,r4,3,60
>   38:	79 29 3e 24 	rldicr  r9,r9,7,56
>   3c:	38 63 03 10 	addi    r3,r3,784
>   40:	7c 00 4a 14 	add     r0,r0,r9
> void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
> {
> 	const struct cpumask *tmp;
> 	int i, local = 0;
> 
> 	i = batch->index;
>   44:	eb df 00 0e 	lwa     r30,12(r31)
>   48:	7c 84 00 50 	subf    r4,r4,r0
>   4c:	48 00 00 01 	bl      4c <.__flush_tlb_pending+0x4c>
>   50:	60 00 00 00 	nop
>   54:	7c 69 fe 70 	srawi   r9,r3,31
> 	tmp = cpumask_of(smp_processor_id());
> 	if (cpumask_equal(mm_cpumask(batch->mm), tmp))
> 		local = 1;
> 	if (i == 1)
>   58:	2f 9e 00 01 	cmpwi   cr7,r30,1
>   5c:	7d 20 1a 78 	xor     r0,r9,r3
>   60:	7c 00 48 50 	subf    r0,r0,r9
>   64:	54 00 0f fe 	rlwinm  r0,r0,1,31,31
>   68:	7c 04 07 b4 	extsw   r4,r0
>   6c:	40 9e 00 28 	bne-    cr7,94 <.__flush_tlb_pending+0x94>
> 		flush_hash_page(batch->vaddr[0], batch->pte[0],
>   70:	7c 88 23 78 	mr      r8,r4
>   74:	e8 7f 0c 18 	ld      r3,3096(r31)
>   78:	e8 df 12 1a 	lwa     r6,4632(r31)
>   7c:	e8 ff 12 1e 	lwa     r7,4636(r31)
>   80:	e8 9f 00 18 	ld      r4,24(r31)
>   84:	e8 bf 00 20 	ld      r5,32(r31)
>   88:	48 00 00 01 	bl      88 <.__flush_tlb_pending+0x88>
>   8c:	60 00 00 00 	nop
>   90:	48 00 00 10 	b       a0 <.__flush_tlb_pending+0xa0>
> 				batch->psize, batch->ssize, local);
> 	else
> 		flush_hash_range(i, local);
>   94:	7f c3 f3 78 	mr      r3,r30
>   98:	48 00 00 01 	bl      98 <.__flush_tlb_pending+0x98>
>   9c:	60 00 00 00 	nop
> 	batch->index = 0;
> }
>   a0:	38 21 00 80 	addi    r1,r1,128
> 	if (i == 1)
> 		flush_hash_page(batch->vaddr[0], batch->pte[0],
> 				batch->psize, batch->ssize, local);
> 	else
> 		flush_hash_range(i, local);
> 	batch->index = 0;
>   a4:	38 00 00 00 	li      r0,0
>   a8:	f8 1f 00 08 	std     r0,8(r31)
> }
>   ac:	e8 01 00 10 	ld      r0,16(r1)
>   b0:	eb c1 ff f0 	ld      r30,-16(r1)
>   b4:	7c 08 03 a6 	mtlr    r0
>   b8:	eb e1 ff f8 	ld      r31,-8(r1)
>   bc:	4e 80 00 20 	blr
> 
> 00000000000000c0 <.hpte_need_flush>:
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>   c0:	fa c1 ff b0 	std     r22,-80(r1)
>   c4:	7c 08 02 a6 	mflr    r0
>   c8:	f8 01 00 10 	std     r0,16(r1)
> 	 * NOTE: when using special 64K mappings in 4K environment like
> 	 * for SPEs, we obtain the page size from the slice, which thus
> 	 * must still exist (and thus the VMA not reused) at the time
> 	 * of this call
> 	 */
> 	if (huge) {
>   cc:	2f a7 00 00 	cmpdi   cr7,r7,0
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>   d0:	fb 21 ff c8 	std     r25,-56(r1)
> #else
> 		BUG();
> 		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
> #endif
> 	} else
> 		psize = pte_pagesize_index(mm, addr, pte);
>   d4:	6c c0 10 00 	xoris   r0,r6,4096
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>   d8:	fb 41 ff d0 	std     r26,-48(r1)
>   dc:	7c d9 33 78 	mr      r25,r6
>   e0:	fb 61 ff d8 	std     r27,-40(r1)
>   e4:	7c b6 2b 78 	mr      r22,r5
>   e8:	fb 81 ff e0 	std     r28,-32(r1)
> 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>   ec:	eb 82 00 08 	ld      r28,8(r2)
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>   f0:	fb c1 ff f0 	std     r30,-16(r1)
> #else
> 		BUG();
> 		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
> #endif
> 	} else
> 		psize = pte_pagesize_index(mm, addr, pte);
>   f4:	78 1b 27 e2 	rldicl  r27,r0,36,63
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>   f8:	fb e1 ff f8 	std     r31,-8(r1)
>   fc:	7c 7a 1b 78 	mr      r26,r3
>  100:	fa e1 ff b8 	std     r23,-72(r1)
> 	i = batch->index;
> 
> 	/* We mask the address for the base page size. Huge pages will
> 	 * have applied their own masking already
> 	 */
> 	addr &= PAGE_MASK;
>  104:	78 9f 03 e4 	rldicr  r31,r4,0,47
>  *
>  * Must be called from within some kind of spinlock/non-preempt region...
>  */
> void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> 		     pte_t *ptep, unsigned long pte, int huge)
> {
>  108:	fb 01 ff c0 	std     r24,-64(r1)
>  10c:	fb a1 ff e8 	std     r29,-24(r1)
>  110:	f8 21 ff 41 	stdu    r1,-192(r1)
> 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>  114:	ea ed 00 40 	ld      r23,64(r13)
>  118:	7f dc ba 14 	add     r30,r28,r23
> 	unsigned int psize;
> 	int ssize;
> 	real_pte_t rpte;
> 	int i;
> 
> 	i = batch->index;
>  11c:	eb 1e 00 08 	ld      r24,8(r30)
> 	 * NOTE: when using special 64K mappings in 4K environment like
> 	 * for SPEs, we obtain the page size from the slice, which thus
> 	 * must still exist (and thus the VMA not reused) at the time
> 	 * of this call
> 	 */
> 	if (huge) {
>  120:	41 9e 00 14 	beq-    cr7,134 <.hpte_need_flush+0x74>
> #ifdef CONFIG_HUGETLB_PAGE
> 		psize = get_slice_psize(mm, addr);;
>  124:	7f e4 fb 78 	mr      r4,r31
>  128:	48 00 00 01 	bl      128 <.hpte_need_flush+0x68>
>  12c:	60 00 00 00 	nop
>  130:	7c 7b 1b 78 	mr      r27,r3
> #endif
> 	} else
> 		psize = pte_pagesize_index(mm, addr, pte);
> 
> 	/* Build full vaddr */
> 	if (!is_kernel_addr(addr)) {
>  134:	e8 02 00 10 	ld      r0,16(r2)
>  138:	7f bf 00 40 	cmpld   cr7,r31,r0
>  13c:	41 9d 00 a8 	bgt-    cr7,1e4 <.hpte_need_flush+0x124>
> 
> /* Returns the segment size indicator for a user address */
> static inline int user_segment_size(unsigned long addr)
> {
> 	/* Use 1T segments if possible for addresses >= 1T */
> 	if (addr >= (1UL << SID_SHIFT_1T))
>  140:	38 00 ff ff 	li      r0,-1
>  144:	3b a0 00 00 	li      r29,0
>  148:	78 00 06 00 	clrldi  r0,r0,24
>  14c:	7f bf 00 40 	cmpld   cr7,r31,r0
>  150:	40 9d 00 0c 	ble-    cr7,15c <.hpte_need_flush+0x9c>
> 		return mmu_highuser_ssize;
>  154:	e9 22 00 18 	ld      r9,24(r2)
>  158:	eb a9 00 02 	lwa     r29,0(r9)
> 
> /* This is only valid for user addresses (which are below 2^44) */
> static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
> 				     int ssize)
> {
> 	if (ssize == MMU_SEGSIZE_256M)
>  15c:	2f bd 00 00 	cmpdi   cr7,r29,0
> 		ssize = user_segment_size(addr);
> 		vsid = get_vsid(mm->context.id, addr, ssize);
>  160:	e9 7a 03 90 	ld      r11,912(r26)
>  164:	40 9e 00 3c 	bne-    cr7,1a0 <.hpte_need_flush+0xe0>
> 		return vsid_scramble((context << USER_ESID_BITS)
>  168:	79 6b 83 e4 	rldicr  r11,r11,16,47
>  16c:	7b e0 27 02 	rldicl  r0,r31,36,28
>  170:	3d 20 0b f6 	lis     r9,3062
>  174:	7c 00 5b 78 	or      r0,r0,r11
>  178:	61 29 e6 1b 	ori     r9,r9,58907
>  17c:	7c 00 49 d2 	mulld   r0,r0,r9
> 				     | (ea >> SID_SHIFT), 256M);
>  180:	78 09 07 00 	clrldi  r9,r0,28
>  184:	78 00 e1 20 	rldicl  r0,r0,28,36
>  188:	7d 29 02 14 	add     r9,r9,r0
>  18c:	38 09 00 01 	addi    r0,r9,1
>  190:	78 00 e1 20 	rldicl  r0,r0,28,36
>  194:	7c 00 4a 14 	add     r0,r0,r9
>  198:	78 09 07 00 	clrldi  r9,r0,28
>  19c:	48 00 00 38 	b       1d4 <.hpte_need_flush+0x114>
> 	return vsid_scramble((context << USER_ESID_BITS_1T)
>  1a0:	79 6b 26 e4 	rldicr  r11,r11,4,59
>  1a4:	7b e0 c2 20 	rldicl  r0,r31,24,40
>  1a8:	3d 20 00 bf 	lis     r9,191
>  1ac:	7c 00 5b 78 	or      r0,r0,r11
>  1b0:	61 29 50 d9 	ori     r9,r9,20697
>  1b4:	7c 00 49 d2 	mulld   r0,r0,r9
> 			     | (ea >> SID_SHIFT_1T), 1T);
>  1b8:	78 09 02 20 	clrldi  r9,r0,40
>  1bc:	78 00 46 02 	rldicl  r0,r0,40,24
>  1c0:	7d 29 02 14 	add     r9,r9,r0
>  1c4:	38 09 00 01 	addi    r0,r9,1
>  1c8:	78 00 46 02 	rldicl  r0,r0,40,24
>  1cc:	7c 00 4a 14 	add     r0,r0,r9
>  1d0:	78 09 02 20 	clrldi  r9,r0,40
> 		WARN_ON(vsid == 0);
>  1d4:	7d 20 00 74 	cntlzd  r0,r9
>  1d8:	78 00 d1 82 	rldicl  r0,r0,58,6
>  1dc:	0b 00 00 00 	tdnei   r0,0
>  1e0:	48 00 00 70 	b       250 <.hpte_need_flush+0x190>
> 	} else {
> 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
>  1e4:	e9 22 00 20 	ld      r9,32(r2)
>  1e8:	eb a9 00 02 	lwa     r29,0(r9)
> #endif /* 1 */
> 
> /* This is only valid for addresses >= PAGE_OFFSET */
> static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
> {
> 	if (ssize == MMU_SEGSIZE_256M)
>  1ec:	2f bd 00 00 	cmpdi   cr7,r29,0
>  1f0:	40 9e 00 34 	bne-    cr7,224 <.hpte_need_flush+0x164>
> 		return vsid_scramble(ea >> SID_SHIFT, 256M);
>  1f4:	3d 20 0b f6 	lis     r9,3062
>  1f8:	7b e0 27 02 	rldicl  r0,r31,36,28
>  1fc:	61 29 e6 1b 	ori     r9,r9,58907
>  200:	7c 00 49 d2 	mulld   r0,r0,r9
>  204:	78 09 07 00 	clrldi  r9,r0,28
>  208:	78 00 e1 20 	rldicl  r0,r0,28,36
>  20c:	7d 29 02 14 	add     r9,r9,r0
>  210:	38 09 00 01 	addi    r0,r9,1
>  214:	78 00 e1 20 	rldicl  r0,r0,28,36
>  218:	7c 00 4a 14 	add     r0,r0,r9
>  21c:	78 09 07 00 	clrldi  r9,r0,28
>  220:	48 00 00 38 	b       258 <.hpte_need_flush+0x198>
> 	return vsid_scramble(ea >> SID_SHIFT_1T, 1T);
>  224:	3d 20 00 bf 	lis     r9,191
>  228:	7b e0 c2 20 	rldicl  r0,r31,24,40
>  22c:	61 29 50 d9 	ori     r9,r9,20697
>  230:	7c 00 49 d2 	mulld   r0,r0,r9
>  234:	78 09 02 20 	clrldi  r9,r0,40
>  238:	78 00 46 02 	rldicl  r0,r0,40,24
>  23c:	7d 29 02 14 	add     r9,r9,r0
>  240:	38 09 00 01 	addi    r0,r9,1
>  244:	78 00 46 02 	rldicl  r0,r0,40,24
>  248:	7c 00 4a 14 	add     r0,r0,r9
>  24c:	78 09 02 20 	clrldi  r9,r0,40
>  * Build a VA given VSID, EA and segment size
>  */
> static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
> 				   int ssize)
> {
> 	if (ssize == MMU_SEGSIZE_256M)
>  250:	2f bd 00 00 	cmpdi   cr7,r29,0
>  254:	40 9e 00 10 	bne-    cr7,264 <.hpte_need_flush+0x1a4>
> 		return (vsid << 28) | (ea & 0xfffffffUL);
>  258:	79 29 e0 e4 	rldicr  r9,r9,28,35
>  25c:	7b e0 01 20 	clrldi  r0,r31,36
>  260:	48 00 00 0c 	b       26c <.hpte_need_flush+0x1ac>
> 	return (vsid << 40) | (ea & 0xffffffffffUL);
>  264:	79 29 45 c6 	rldicr  r9,r9,40,23
>  268:	7b e0 06 00 	clrldi  r0,r31,24
>  26c:	7d 3f 03 78 	or      r31,r9,r0
> 	 * Check if we have an active batch on this CPU. If not, just
> 	 * flush now and return. For now, we don global invalidates
> 	 * in that case, might be worth testing the mm cpu mask though
> 	 * and decide to use local invalidates instead...
> 	 */
> 	if (!batch->active) {
>  270:	7c 1c b8 2e 	lwzx    r0,r28,r23
> 	} else {
> 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
> 		ssize = mmu_kernel_ssize;
> 	}
> 	vaddr = hpt_va(addr, vsid, ssize);
> 	rpte = __real_pte(__pte(pte), ptep);
>  274:	3d 36 00 01 	addis   r9,r22,1
> 	 * Check if we have an active batch on this CPU. If not, just
> 	 * flush now and return. For now, we don global invalidates
> 	 * in that case, might be worth testing the mm cpu mask though
> 	 * and decide to use local invalidates instead...
> 	 */
> 	if (!batch->active) {
>  278:	2f 80 00 00 	cmpwi   cr7,r0,0
> 	} else {
> 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
> 		ssize = mmu_kernel_ssize;
> 	}
> 	vaddr = hpt_va(addr, vsid, ssize);
> 	rpte = __real_pte(__pte(pte), ptep);
>  27c:	eb 89 80 00 	ld      r28,-32768(r9)
> 	 * Check if we have an active batch on this CPU. If not, just
> 	 * flush now and return. For now, we don global invalidates
> 	 * in that case, might be worth testing the mm cpu mask though
> 	 * and decide to use local invalidates instead...
> 	 */
> 	if (!batch->active) {
>  280:	40 9e 00 28 	bne-    cr7,2a8 <.hpte_need_flush+0x1e8>
> 		flush_hash_page(vaddr, rpte, psize, ssize, 0);
>  284:	7f e3 fb 78 	mr      r3,r31
>  288:	7f 24 cb 78 	mr      r4,r25
>  28c:	7f 85 e3 78 	mr      r5,r28
>  290:	7f 66 07 b4 	extsw   r6,r27
>  294:	7f a7 eb 78 	mr      r7,r29
>  298:	39 00 00 00 	li      r8,0
>  29c:	48 00 00 01 	bl      29c <.hpte_need_flush+0x1dc>
>  2a0:	60 00 00 00 	nop
>  2a4:	48 00 00 bc 	b       360 <.hpte_need_flush+0x2a0>
> 	 * will change mid stream.
> 	 *
> 	 * We also need to ensure only one page size is present in a given
> 	 * batch
> 	 */
> 	if (i != 0 && (mm != batch->mm || batch->psize != psize ||
>  2a8:	7f 0b 07 b5 	extsw.  r11,r24
>  2ac:	41 82 00 30 	beq-    2dc <.hpte_need_flush+0x21c>
>  2b0:	e8 1e 00 10 	ld      r0,16(r30)
>  2b4:	7f ba 00 00 	cmpd    cr7,r26,r0
>  2b8:	40 9e 00 1c 	bne-    cr7,2d4 <.hpte_need_flush+0x214>
>  2bc:	80 1e 12 18 	lwz     r0,4632(r30)
>  2c0:	7f 80 d8 00 	cmpw    cr7,r0,r27
>  2c4:	40 9e 00 10 	bne-    cr7,2d4 <.hpte_need_flush+0x214>
>  2c8:	80 1e 12 1c 	lwz     r0,4636(r30)
>  2cc:	7f 80 e8 00 	cmpw    cr7,r0,r29
>  2d0:	41 9e 00 1c 	beq-    cr7,2ec <.hpte_need_flush+0x22c>
> 		       batch->ssize != ssize)) {
> 		__flush_tlb_pending(batch);
>  2d4:	7f c3 f3 78 	mr      r3,r30
>  2d8:	48 00 00 01 	bl      2d8 <.hpte_need_flush+0x218>
> 		i = 0;
> 	}
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
>  2dc:	39 60 00 00 	li      r11,0
> 		       batch->ssize != ssize)) {
> 		__flush_tlb_pending(batch);
> 		i = 0;
> 	}
> 	if (i == 0) {
> 		batch->mm = mm;
>  2e0:	fb 5e 00 10 	std     r26,16(r30)
> 		batch->psize = psize;
>  2e4:	93 7e 12 18 	stw     r27,4632(r30)
> 		batch->ssize = ssize;
>  2e8:	93 be 12 1c 	stw     r29,4636(r30)
> 	}
> 	batch->pte[i] = rpte;
> 	batch->vaddr[i] = vaddr;
> 	batch->index = ++i;
>  2ec:	38 0b 00 01 	addi    r0,r11,1
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
> 	}
> 	batch->pte[i] = rpte;
>  2f0:	39 2b 00 01 	addi    r9,r11,1
> 	batch->vaddr[i] = vaddr;
>  2f4:	39 6b 01 82 	addi    r11,r11,386
> 	batch->index = ++i;
>  2f8:	7c 00 07 b4 	extsw   r0,r0
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
> 	}
> 	batch->pte[i] = rpte;
>  2fc:	79 29 26 e4 	rldicr  r9,r9,4,59
> 	batch->vaddr[i] = vaddr;
>  300:	79 6b 1f 24 	rldicr  r11,r11,3,60
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
> 	}
> 	batch->pte[i] = rpte;
>  304:	7d 3e 4a 14 	add     r9,r30,r9
> 	batch->vaddr[i] = vaddr;
>  308:	7d 7e 5a 14 	add     r11,r30,r11
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
> 	}
> 	batch->pte[i] = rpte;
>  30c:	fb 29 00 08 	std     r25,8(r9)
> 	batch->vaddr[i] = vaddr;
> 	batch->index = ++i;
> 	if (i >= PPC64_TLB_BATCH_NR)
>  310:	2f 80 00 bf 	cmpwi   cr7,r0,191
> 	if (i == 0) {
> 		batch->mm = mm;
> 		batch->psize = psize;
> 		batch->ssize = ssize;
> 	}
> 	batch->pte[i] = rpte;
>  314:	fb 89 00 10 	std     r28,16(r9)
> 	batch->vaddr[i] = vaddr;
>  318:	fb eb 00 08 	std     r31,8(r11)
> 	batch->index = ++i;
>  31c:	f8 1e 00 08 	std     r0,8(r30)
> 	if (i >= PPC64_TLB_BATCH_NR)
>  320:	40 9d 00 40 	ble-    cr7,360 <.hpte_need_flush+0x2a0>
> 		__flush_tlb_pending(batch);
> }
>  324:	38 21 00 c0 	addi    r1,r1,192
> 	}
> 	batch->pte[i] = rpte;
> 	batch->vaddr[i] = vaddr;
> 	batch->index = ++i;
> 	if (i >= PPC64_TLB_BATCH_NR)
> 		__flush_tlb_pending(batch);
>  328:	7f c3 f3 78 	mr      r3,r30
> }
>  32c:	e8 01 00 10 	ld      r0,16(r1)
>  330:	ea c1 ff b0 	ld      r22,-80(r1)
>  334:	7c 08 03 a6 	mtlr    r0
>  338:	ea e1 ff b8 	ld      r23,-72(r1)
>  33c:	eb 01 ff c0 	ld      r24,-64(r1)
>  340:	eb 21 ff c8 	ld      r25,-56(r1)
>  344:	eb 41 ff d0 	ld      r26,-48(r1)
>  348:	eb 61 ff d8 	ld      r27,-40(r1)
>  34c:	eb 81 ff e0 	ld      r28,-32(r1)
>  350:	eb a1 ff e8 	ld      r29,-24(r1)
>  354:	eb c1 ff f0 	ld      r30,-16(r1)
>  358:	eb e1 ff f8 	ld      r31,-8(r1)
> 	}
> 	batch->pte[i] = rpte;
> 	batch->vaddr[i] = vaddr;
> 	batch->index = ++i;
> 	if (i >= PPC64_TLB_BATCH_NR)
> 		__flush_tlb_pending(batch);
>  35c:	48 00 00 00 	b       35c <.hpte_need_flush+0x29c>
> }
>  360:	38 21 00 c0 	addi    r1,r1,192
>  364:	e8 01 00 10 	ld      r0,16(r1)
>  368:	ea c1 ff b0 	ld      r22,-80(r1)
>  36c:	7c 08 03 a6 	mtlr    r0
>  370:	ea e1 ff b8 	ld      r23,-72(r1)
>  374:	eb 01 ff c0 	ld      r24,-64(r1)
>  378:	eb 21 ff c8 	ld      r25,-56(r1)
>  37c:	eb 41 ff d0 	ld      r26,-48(r1)
>  380:	eb 61 ff d8 	ld      r27,-40(r1)
>  384:	eb 81 ff e0 	ld      r28,-32(r1)
>  388:	eb a1 ff e8 	ld      r29,-24(r1)
>  38c:	eb c1 ff f0 	ld      r30,-16(r1)
>  390:	eb e1 ff f8 	ld      r31,-8(r1)
>  394:	4e 80 00 20 	blr
> 
> 0000000000000398 <.__flush_hash_table_range>:
>  */
> #ifdef CONFIG_HOTPLUG
> 
> void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
> 			      unsigned long end)
> {
>  398:	fb 81 ff e0 	std     r28,-32(r1)
>  39c:	7c 08 02 a6 	mflr    r0
>  3a0:	fb c1 ff f0 	std     r30,-16(r1)
> 	unsigned long flags;
> 
> 	start = _ALIGN_DOWN(start, PAGE_SIZE);
> 	end = _ALIGN_UP(end, PAGE_SIZE);
>  3a4:	3c a5 00 01 	addis   r5,r5,1
>  */
> #ifdef CONFIG_HOTPLUG
> 
> void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
> 			      unsigned long end)
> {
>  3a8:	f8 01 00 10 	std     r0,16(r1)
>  3ac:	7c 7e 1b 78 	mr      r30,r3
>  3b0:	fb a1 ff e8 	std     r29,-24(r1)
> 	unsigned long flags;
> 
> 	start = _ALIGN_DOWN(start, PAGE_SIZE);
> 	end = _ALIGN_UP(end, PAGE_SIZE);
>  3b4:	38 a5 ff ff 	addi    r5,r5,-1
>  */
> #ifdef CONFIG_HOTPLUG
> 
> void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
> 			      unsigned long end)
> {
>  3b8:	fb e1 ff f8 	std     r31,-8(r1)
>  3bc:	f8 21 ff 71 	stdu    r1,-144(r1)
> 	unsigned long flags;
> 
> 	start = _ALIGN_DOWN(start, PAGE_SIZE);
> 	end = _ALIGN_UP(end, PAGE_SIZE);
>  3c0:	78 bc 03 e4 	rldicr  r28,r5,0,47
> 
> 	BUG_ON(!mm->pgd);
>  3c4:	e8 03 00 48 	ld      r0,72(r3)
>  3c8:	7c 00 00 74 	cntlzd  r0,r0
>  3cc:	78 00 d1 82 	rldicl  r0,r0,58,6
>  3d0:	0b 00 00 00 	tdnei   r0,0
> void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
> 			      unsigned long end)
> {
> 	unsigned long flags;
> 
> 	start = _ALIGN_DOWN(start, PAGE_SIZE);
>  3d4:	78 9f 03 e4 	rldicr  r31,r4,0,47
> 
> static inline unsigned long raw_local_irq_disable(void)
> {
> 	unsigned long flags, zero;
> 
> 	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
>  3d8:	38 00 00 00 	li      r0,0
>  3dc:	8b ad 01 da 	lbz     r29,474(r13)
>  3e0:	98 0d 01 da 	stb     r0,474(r13)
> 
> static inline void arch_enter_lazy_mmu_mode(void)
> {
> 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
> 
> 	batch->active = 1;
>  3e4:	38 00 00 01 	li      r0,1
>  3e8:	e9 6d 00 40 	ld      r11,64(r13)
> 
> #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> 
> static inline void arch_enter_lazy_mmu_mode(void)
> {
> 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>  3ec:	e9 22 00 08 	ld      r9,8(r2)
> 
> 	batch->active = 1;
>  3f0:	7c 09 59 2e 	stwx    r0,r9,r11
>  3f4:	48 00 00 58 	b       44c <.__flush_hash_table_range+0xb4>
> 	pte_t *pt = NULL;
> 
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
>  3f8:	e9 3e 00 48 	ld      r9,72(r30)
>  3fc:	7c 09 00 2a 	ldx     r0,r9,r0
>  400:	2f a0 00 00 	cmpdi   cr7,r0,0
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  404:	78 09 05 a4 	rldicr  r9,r0,0,54
> 	pte_t *pt = NULL;
> 
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
>  408:	41 9e 00 40 	beq-    cr7,448 <.__flush_hash_table_range+0xb0>
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  40c:	7d 2b 48 2a 	ldx     r9,r11,r9
> 				pt = pte_offset_kernel(pm, ea);
>  410:	7b e0 85 22 	rldicl  r0,r31,48,52
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  414:	2f a9 00 00 	cmpdi   cr7,r9,0
> 				pt = pte_offset_kernel(pm, ea);
>  418:	78 0b 1f 24 	rldicr  r11,r0,3,60
>  41c:	79 26 05 a4 	rldicr  r6,r9,0,54
> 	arch_enter_lazy_mmu_mode();
> 	for (; start < end; start += PAGE_SIZE) {
> 		pte_t *ptep = find_linux_pte(mm->pgd, start);
> 		unsigned long pte;
> 
> 		if (ptep == NULL)
>  420:	7c a6 5a 15 	add.    r5,r6,r11
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  424:	41 9e 00 24 	beq-    cr7,448 <.__flush_hash_table_range+0xb0>
>  428:	41 c2 00 20 	beq-    448 <.__flush_hash_table_range+0xb0>
> 			continue;
> 		pte = pte_val(*ptep);
>  42c:	7c c6 58 2a 	ldx     r6,r6,r11
> 		if (!(pte & _PAGE_HASHPTE))
>  430:	54 c0 01 27 	rlwinm. r0,r6,0,4,19
>  434:	41 82 00 14 	beq-    448 <.__flush_hash_table_range+0xb0>
> 			continue;
> 		hpte_need_flush(mm, start, ptep, pte, 0);
>  438:	7f e4 fb 78 	mr      r4,r31
>  43c:	7f c3 f3 78 	mr      r3,r30
>  440:	38 e0 00 00 	li      r7,0
>  444:	48 00 00 01 	bl      444 <.__flush_hash_table_range+0xac>
> 	 * to being hashed). This is not the most performance oriented
> 	 * way to do things but is fine for our needs here.
> 	 */
> 	local_irq_save(flags);
> 	arch_enter_lazy_mmu_mode();
> 	for (; start < end; start += PAGE_SIZE) {
>  448:	3f ff 00 01 	addis   r31,r31,1
>  44c:	7f bf e0 40 	cmpld   cr7,r31,r28
> 	pte_t *pt = NULL;
> 
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
>  450:	7b e0 c5 e0 	rldicl  r0,r31,24,55
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  454:	7b e9 25 22 	rldicl  r9,r31,36,52
> 	pte_t *pt = NULL;
> 
> 	pg = pgdir + pgd_index(ea);
> 	if (!pgd_none(*pg)) {
> 		pu = pud_offset(pg, ea);
> 		if (!pud_none(*pu)) {
>  458:	78 00 1f 24 	rldicr  r0,r0,3,60
> 			pm = pmd_offset(pu, ea);
> 			if (pmd_present(*pm))
>  45c:	79 2b 1f 24 	rldicr  r11,r9,3,60
>  460:	41 9c ff 98 	blt+    cr7,3f8 <.__flush_hash_table_range+0x60>
> }
> 
> static inline void arch_leave_lazy_mmu_mode(void)
> {
> 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
>  464:	eb cd 00 40 	ld      r30,64(r13)
>  468:	eb e2 00 08 	ld      r31,8(r2)
>  46c:	7c 7f f2 14 	add     r3,r31,r30
> 
> 	if (batch->index)
>  470:	e8 03 00 08 	ld      r0,8(r3)
>  474:	2f a0 00 00 	cmpdi   cr7,r0,0
>  478:	41 9e 00 08 	beq-    cr7,480 <.__flush_hash_table_range+0xe8>
> 		__flush_tlb_pending(batch);
>  47c:	48 00 00 01 	bl      47c <.__flush_hash_table_range+0xe4>
> 		if (!(pte & _PAGE_HASHPTE))
> 			continue;
> 		hpte_need_flush(mm, start, ptep, pte, 0);
> 	}
> 	arch_leave_lazy_mmu_mode();
> 	local_irq_restore(flags);
>  480:	2f bd 00 00 	cmpdi   cr7,r29,0
> 	batch->active = 0;
>  484:	38 00 00 00 	li      r0,0
>  488:	38 60 00 00 	li      r3,0
>  48c:	7c 1f f1 2e 	stwx    r0,r31,r30
>  490:	41 9e 00 08 	beq-    cr7,498 <.__flush_hash_table_range+0x100>
>  494:	7f a3 eb 78 	mr      r3,r29
>  498:	48 00 00 01 	bl      498 <.__flush_hash_table_range+0x100>
>  49c:	60 00 00 00 	nop
> }
>  4a0:	38 21 00 90 	addi    r1,r1,144
>  4a4:	e8 01 00 10 	ld      r0,16(r1)
>  4a8:	eb 81 ff e0 	ld      r28,-32(r1)
>  4ac:	7c 08 03 a6 	mtlr    r0
>  4b0:	eb a1 ff e8 	ld      r29,-24(r1)
>  4b4:	eb c1 ff f0 	ld      r30,-16(r1)
>  4b8:	eb e1 ff f8 	ld      r31,-8(r1)
>  4bc:	4e 80 00 20 	blr
