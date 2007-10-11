Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18189.64726.824152.697844@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 20:37:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 or so] Use 1TB segments
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the kernel use 1TB segments for all kernel mappings and for
user addresses of 1TB and above, on machines which support them
(currently POWER5+, POWER6 and PA6T).

We detect that the machine supports 1TB segments by looking at the
ibm,processor-segment-sizes property in the device tree.

We don't currently use 1TB segments for user addresses < 1T, since
that would effectively prevent 32-bit processes from using huge pages
unless we also had a way to revert to using 256MB segments.  That
would be possible but would involve extra complications (such as
keeping track of which segment size was used when HPTEs were inserted)
and is not addressed here.

Parts of this patch were originally written by Ben Herrenschmidt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Will, do you want to send in a Reviewed-by or a Tested-by for this?

PA6T mentioned in commit message, duplicate MMU_SEGSIZE_* definitions
removed.  I hope that's everything.  :)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index fbbd3f6..0ec1340 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -373,8 +373,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 	ld	r8,KSP(r4)	/* new stack pointer */
 BEGIN_FTR_SECTION
+	b	2f
+END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+BEGIN_FTR_SECTION
 	clrrdi	r6,r8,28	/* get its ESID */
 	clrrdi	r9,r1,28	/* get current sp ESID */
+END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
+BEGIN_FTR_SECTION
+	clrrdi	r6,r8,40	/* get its 1T ESID */
+	clrrdi	r9,r1,40	/* get current sp 1T ESID */
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	clrldi.	r0,r6,2		/* is new ESID c00000000? */
 	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
 	cror	eq,4*cr1+eq,eq
@@ -384,6 +392,11 @@ BEGIN_FTR_SECTION
 	ld	r7,KSP_VSID(r4)	/* Get new stack's VSID */
 	oris	r0,r6,(SLB_ESID_V)@h
 	ori	r0,r0,(SLB_NUM_BOLTED-1)@l
+BEGIN_FTR_SECTION
+	li	r9,MMU_SEGSIZE_1T	/* insert B field */
+	oris	r6,r6,(MMU_SEGSIZE_1T << SLBIE_SSIZE_SHIFT)@h
+	rldimi	r7,r9,SLB_VSID_SSIZE_SHIFT,0
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 
 	/* Update the last bolted SLB.  No write barriers are needed
 	 * here, provided we only update the current CPU's SLB shadow
@@ -401,7 +414,6 @@ BEGIN_FTR_SECTION
 	isync
 
 2:
-END_FTR_SECTION_IFSET(CPU_FTR_SLB)
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 22ac245..97c5857 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -935,7 +935,7 @@ _GLOBAL(do_stab_bolted)
 
 	/* Calculate VSID */
 	/* This is a kernel address, so protovsid = ESID */
-	ASM_VSID_SCRAMBLE(r11, r9)
+	ASM_VSID_SCRAMBLE(r11, r9, 256M)
 	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
 	/* Search the primary group for a free entry */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 15998b5..7949c20 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -564,10 +564,15 @@ int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 
 #ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_SLB)) {
-		unsigned long sp_vsid = get_kernel_vsid(sp);
+		unsigned long sp_vsid;
 		unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
 
-		sp_vsid <<= SLB_VSID_SHIFT;
+		if (cpu_has_feature(CPU_FTR_1T_SEGMENT))
+			sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
+				<< SLB_VSID_SHIFT_1T;
+		else
+			sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_256M)
+				<< SLB_VSID_SHIFT;
 		sp_vsid |= SLB_VSID_KERNEL | llp;
 		p->thread.ksp_vsid = sp_vsid;
 	}
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 35eabfb..ad253b9 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -54,7 +54,7 @@
 
 /*
  * _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, int local)
+ *		 pte_t *ptep, unsigned long trap, int local, int ssize)
  *
  * Adds a 4K page to the hash table in a segment of 4K pages only
  */
@@ -66,6 +66,7 @@ _GLOBAL(__hash_page_4K)
 	/* Save all params that we need after a function call */
 	std	r6,STK_PARM(r6)(r1)
 	std	r8,STK_PARM(r8)(r1)
+	std	r9,STK_PARM(r9)(r1)
 	
 	/* Add _PAGE_PRESENT to access */
 	ori	r4,r4,_PAGE_PRESENT
@@ -117,6 +118,10 @@ _GLOBAL(__hash_page_4K)
 	 * r4 (access) is re-useable, we use it for the new HPTE flags
 	 */
 
+BEGIN_FTR_SECTION
+	cmpdi	r9,0			/* check segment size */
+	bne	3f
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28
 	rldicl	r3,r3,0,36
@@ -126,9 +131,20 @@ _GLOBAL(__hash_page_4K)
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
 	rldicl	r0,r3,64-12,48		/* (ea >> 12) & 0xffff */
 	xor	r28,r5,r0
+	b	4f
+
+3:	/* Calc VA and hash in r29 and r28 for 1T segment */
+	sldi	r29,r5,40		/* vsid << 40 */
+	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
+	clrldi	r5,r5,40		/* vsid & 0xffffff */
+	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
+	xor	r28,r28,r5
+	or	r29,r3,r29		/* VA */
+	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
-	andi.	r3,r30,0x1fe		/* Get basic set of flags */
+4:	andi.	r3,r30,0x1fe		/* Get basic set of flags */
 	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
 	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
 	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
@@ -183,6 +199,7 @@ htab_insert_pte:
 	mr	r4,r29			/* Retreive va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -205,6 +222,7 @@ _GLOBAL(htab_call_hpte_insert1)
 	mr	r4,r29			/* Retreive va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -273,7 +291,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(r9)(r1)	/* segment size */
+	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* Patched by htab_finish_init() */
 
@@ -325,6 +344,7 @@ _GLOBAL(__hash_page_4K)
 	/* Save all params that we need after a function call */
 	std	r6,STK_PARM(r6)(r1)
 	std	r8,STK_PARM(r8)(r1)
+	std	r9,STK_PARM(r9)(r1)
 
 	/* Add _PAGE_PRESENT to access */
 	ori	r4,r4,_PAGE_PRESENT
@@ -383,18 +403,33 @@ _GLOBAL(__hash_page_4K)
 	/* Load the hidx index */
 	rldicl	r25,r3,64-12,60
 
+BEGIN_FTR_SECTION
+	cmpdi	r9,0			/* check segment size */
+	bne	3f
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28		/* r29 = (vsid << 28) */
 	rldicl	r3,r3,0,36		/* r3 = (ea & 0x0fffffff) */
-	or	r29,r3,r29		/* r29 = va
+	or	r29,r3,r29		/* r29 = va */
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
 	rldicl	r0,r3,64-12,48		/* (ea >> 12) & 0xffff */
 	xor	r28,r5,r0
+	b	4f
+
+3:	/* Calc VA and hash in r29 and r28 for 1T segment */
+	sldi	r29,r5,40		/* vsid << 40 */
+	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
+	clrldi	r5,r5,40		/* vsid & 0xffffff */
+	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
+	xor	r28,r28,r5
+	or	r29,r3,r29		/* VA */
+	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
-	andi.	r3,r30,0x1fe		/* Get basic set of flags */
+4:	andi.	r3,r30,0x1fe		/* Get basic set of flags */
 	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
 	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
 	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
@@ -462,6 +497,7 @@ htab_special_pfn:
 	mr	r4,r29			/* Retreive va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -488,6 +524,7 @@ _GLOBAL(htab_call_hpte_insert1)
 	mr	r4,r29			/* Retreive va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -586,7 +623,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(r9)(r1)	/* segment size */
+	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -634,6 +672,7 @@ _GLOBAL(__hash_page_64K)
 	/* Save all params that we need after a function call */
 	std	r6,STK_PARM(r6)(r1)
 	std	r8,STK_PARM(r8)(r1)
+	std	r9,STK_PARM(r9)(r1)
 
 	/* Add _PAGE_PRESENT to access */
 	ori	r4,r4,_PAGE_PRESENT
@@ -690,6 +729,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
 	 * r4 (access) is re-useable, we use it for the new HPTE flags
 	 */
 
+BEGIN_FTR_SECTION
+	cmpdi	r9,0			/* check segment size */
+	bne	3f
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28
 	rldicl	r3,r3,0,36
@@ -699,9 +742,20 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
 	rldicl	r0,r3,64-16,52		/* (ea >> 16) & 0xfff */
 	xor	r28,r5,r0
+	b	4f
+
+3:	/* Calc VA and hash in r29 and r28 for 1T segment */
+	sldi	r29,r5,40		/* vsid << 40 */
+	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
+	clrldi	r5,r5,40		/* vsid & 0xffffff */
+	rldicl	r0,r3,64-16,40		/* (ea >> 16) & 0xffffff */
+	xor	r28,r28,r5
+	or	r29,r3,r29		/* VA */
+	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
-	andi.	r3,r30,0x1fe		/* Get basic set of flags */
+4:	andi.	r3,r30,0x1fe		/* Get basic set of flags */
 	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
 	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
 	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
@@ -756,6 +810,7 @@ ht64_insert_pte:
 	mr	r4,r29			/* Retreive va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_64K
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -778,6 +833,7 @@ _GLOBAL(ht64_call_hpte_insert1)
 	mr	r4,r29			/* Retreive va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_64K
+	ld	r9,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -846,7 +902,8 @@ ht64_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_64K
-	ld	r7,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(r9)(r1)	/* segment size */
+	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(ht64_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6ba9b47..34e5c0b 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -38,7 +38,7 @@
 
 static DEFINE_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long va, unsigned int psize)
+static inline void __tlbie(unsigned long va, int psize, int ssize)
 {
 	unsigned int penc;
 
@@ -48,18 +48,20 @@ static inline void __tlbie(unsigned long va, unsigned int psize)
 	switch (psize) {
 	case MMU_PAGE_4K:
 		va &= ~0xffful;
+		va |= ssize << 8;
 		asm volatile("tlbie %0,0" : : "r" (va) : "memory");
 		break;
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
+		va |= ssize << 8;
 		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
 		break;
 	}
 }
 
-static inline void __tlbiel(unsigned long va, unsigned int psize)
+static inline void __tlbiel(unsigned long va, int psize, int ssize)
 {
 	unsigned int penc;
 
@@ -69,6 +71,7 @@ static inline void __tlbiel(unsigned long va, unsigned int psize)
 	switch (psize) {
 	case MMU_PAGE_4K:
 		va &= ~0xffful;
+		va |= ssize << 8;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
 			     : : "r"(va) : "memory");
 		break;
@@ -76,6 +79,7 @@ static inline void __tlbiel(unsigned long va, unsigned int psize)
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
+		va |= ssize << 8;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
 		break;
@@ -83,7 +87,7 @@ static inline void __tlbiel(unsigned long va, unsigned int psize)
 
 }
 
-static inline void tlbie(unsigned long va, int psize, int local)
+static inline void tlbie(unsigned long va, int psize, int ssize, int local)
 {
 	unsigned int use_local = local && cpu_has_feature(CPU_FTR_TLBIEL);
 	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
@@ -94,10 +98,10 @@ static inline void tlbie(unsigned long va, int psize, int local)
 		spin_lock(&native_tlbie_lock);
 	asm volatile("ptesync": : :"memory");
 	if (use_local) {
-		__tlbiel(va, psize);
+		__tlbiel(va, psize, ssize);
 		asm volatile("ptesync": : :"memory");
 	} else {
-		__tlbie(va, psize);
+		__tlbie(va, psize, ssize);
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
@@ -126,7 +130,7 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 
 static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
 			unsigned long pa, unsigned long rflags,
-			unsigned long vflags, int psize)
+			unsigned long vflags, int psize, int ssize)
 {
 	struct hash_pte *hptep = htab_address + hpte_group;
 	unsigned long hpte_v, hpte_r;
@@ -153,7 +157,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
-	hpte_v = hpte_encode_v(va, psize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
@@ -215,13 +219,14 @@ static long native_hpte_remove(unsigned long hpte_group)
 }
 
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
-				 unsigned long va, int psize, int local)
+				 unsigned long va, int psize, int ssize,
+				 int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
 	int ret = 0;
 
-	want_v = hpte_encode_v(va, psize);
+	want_v = hpte_encode_v(va, psize, ssize);
 
 	DBG_LOW("    update(va=%016lx, avpnv=%016lx, hash=%016lx, newpp=%x)",
 		va, want_v & HPTE_V_AVPN, slot, newpp);
@@ -243,39 +248,32 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(va, psize, local);
+	tlbie(va, psize, ssize, local);
 
 	return ret;
 }
 
-static long native_hpte_find(unsigned long va, int psize)
+static long native_hpte_find(unsigned long va, int psize, int ssize)
 {
 	struct hash_pte *hptep;
 	unsigned long hash;
-	unsigned long i, j;
+	unsigned long i;
 	long slot;
 	unsigned long want_v, hpte_v;
 
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift);
-	want_v = hpte_encode_v(va, psize);
+	hash = hpt_hash(va, mmu_psize_defs[psize].shift, ssize);
+	want_v = hpte_encode_v(va, psize, ssize);
 
-	for (j = 0; j < 2; j++) {
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		for (i = 0; i < HPTES_PER_GROUP; i++) {
-			hptep = htab_address + slot;
-			hpte_v = hptep->v;
+	/* Bolted mappings are only ever in the primary group */
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	for (i = 0; i < HPTES_PER_GROUP; i++) {
+		hptep = htab_address + slot;
+		hpte_v = hptep->v;
 
-			if (HPTE_V_COMPARE(hpte_v, want_v)
-			    && (hpte_v & HPTE_V_VALID)
-			    && ( !!(hpte_v & HPTE_V_SECONDARY) == j)) {
-				/* HPTE matches */
-				if (j)
-					slot = -slot;
-				return slot;
-			}
-			++slot;
-		}
-		hash = ~hash;
+		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
+			/* HPTE matches */
+			return slot;
+		++slot;
 	}
 
 	return -1;
@@ -289,16 +287,16 @@ static long native_hpte_find(unsigned long va, int psize)
  * No need to lock here because we should be the only user.
  */
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
-				       int psize)
+				       int psize, int ssize)
 {
 	unsigned long vsid, va;
 	long slot;
 	struct hash_pte *hptep;
 
-	vsid = get_kernel_vsid(ea);
-	va = (vsid << 28) | (ea & 0x0fffffff);
+	vsid = get_kernel_vsid(ea, ssize);
+	va = hpt_va(ea, vsid, ssize);
 
-	slot = native_hpte_find(va, psize);
+	slot = native_hpte_find(va, psize, ssize);
 	if (slot == -1)
 		panic("could not find page to bolt\n");
 	hptep = htab_address + slot;
@@ -308,11 +306,11 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 		(newpp & (HPTE_R_PP | HPTE_R_N));
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(va, psize, 0);
+	tlbie(va, psize, ssize, 0);
 }
 
 static void native_hpte_invalidate(unsigned long slot, unsigned long va,
-				   int psize, int local)
+				   int psize, int ssize, int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v;
@@ -323,7 +321,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 
 	DBG_LOW("    invalidate(va=%016lx, hash: %x)\n", va, slot);
 
-	want_v = hpte_encode_v(va, psize);
+	want_v = hpte_encode_v(va, psize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
@@ -335,7 +333,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 		hptep->v = 0;
 
 	/* Invalidate the TLB */
-	tlbie(va, psize, local);
+	tlbie(va, psize, ssize, local);
 
 	local_irq_restore(flags);
 }
@@ -345,7 +343,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
 
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
-			int *psize, unsigned long *va)
+			int *psize, int *ssize, unsigned long *va)
 {
 	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
@@ -401,6 +399,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 
 	*va = avpn;
 	*psize = size;
+	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 }
 
 /*
@@ -417,7 +416,7 @@ static void native_hpte_clear(void)
 	struct hash_pte *hptep = htab_address;
 	unsigned long hpte_v, va;
 	unsigned long pteg_count;
-	int psize;
+	int psize, ssize;
 
 	pteg_count = htab_hash_mask + 1;
 
@@ -443,9 +442,9 @@ static void native_hpte_clear(void)
 		 * already hold the native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
-			hpte_decode(hptep, slot, &psize, &va);
+			hpte_decode(hptep, slot, &psize, &ssize, &va);
 			hptep->v = 0;
-			__tlbie(va, psize);
+			__tlbie(va, psize, ssize);
 		}
 	}
 
@@ -468,6 +467,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 	real_pte_t pte;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 	unsigned long psize = batch->psize;
+	int ssize = batch->ssize;
 	int i;
 
 	local_irq_save(flags);
@@ -477,14 +477,14 @@ static void native_flush_hash_range(unsigned long number, int local)
 		pte = batch->pte[i];
 
 		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-			hash = hpt_hash(va, shift);
+			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
-			want_v = hpte_encode_v(va, psize);
+			want_v = hpte_encode_v(va, psize, ssize);
 			native_lock_hpte(hptep);
 			hpte_v = hptep->v;
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
@@ -504,7 +504,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize, va, index,
 						    shift) {
-				__tlbiel(va, psize);
+				__tlbiel(va, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("ptesync":::"memory");
@@ -521,7 +521,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize, va, index,
 						    shift) {
-				__tlbie(va, psize);
+				__tlbie(va, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d525f2e..611ad08 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -93,6 +93,8 @@ int mmu_linear_psize = MMU_PAGE_4K;
 int mmu_virtual_psize = MMU_PAGE_4K;
 int mmu_vmalloc_psize = MMU_PAGE_4K;
 int mmu_io_psize = MMU_PAGE_4K;
+int mmu_kernel_ssize = MMU_SEGSIZE_256M;
+int mmu_highuser_ssize = MMU_SEGSIZE_256M;
 #ifdef CONFIG_HUGETLB_PAGE
 int mmu_huge_psize = MMU_PAGE_16M;
 unsigned int HPAGE_SHIFT;
@@ -145,7 +147,8 @@ struct mmu_psize_def mmu_psize_defaults_gp[] = {
 
 
 int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
-		      unsigned long pstart, unsigned long mode, int psize)
+		      unsigned long pstart, unsigned long mode,
+		      int psize, int ssize)
 {
 	unsigned long vaddr, paddr;
 	unsigned int step, shift;
@@ -158,8 +161,8 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	for (vaddr = vstart, paddr = pstart; vaddr < vend;
 	     vaddr += step, paddr += step) {
 		unsigned long hash, hpteg;
-		unsigned long vsid = get_kernel_vsid(vaddr);
-		unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
+		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
+		unsigned long va = hpt_va(vaddr, vsid, ssize);
 
 		tmp_mode = mode;
 		
@@ -167,14 +170,14 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 		if (!in_kernel_text(vaddr))
 			tmp_mode = mode | HPTE_R_N;
 
-		hash = hpt_hash(va, shift);
+		hash = hpt_hash(va, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 		DBG("htab_bolt_mapping: calling %p\n", ppc_md.hpte_insert);
 
 		BUG_ON(!ppc_md.hpte_insert);
 		ret = ppc_md.hpte_insert(hpteg, va, paddr,
-				tmp_mode, HPTE_V_BOLTED, psize);
+				tmp_mode, HPTE_V_BOLTED, psize, ssize);
 
 		if (ret < 0)
 			break;
@@ -186,6 +189,37 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	return ret < 0 ? ret : 0;
 }
 
+static int __init htab_dt_scan_seg_sizes(unsigned long node,
+					 const char *uname, int depth,
+					 void *data)
+{
+	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	u32 *prop;
+	unsigned long size = 0;
+
+	/* We are scanning "cpu" nodes only */
+	if (type == NULL || strcmp(type, "cpu") != 0)
+		return 0;
+
+	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,processor-segment-sizes",
+					  &size);
+	if (prop == NULL)
+		return 0;
+	for (; size >= 4; size -= 4, ++prop) {
+		if (prop[0] == 40) {
+			DBG("1T segment support detected\n");
+			cur_cpu_spec->cpu_features |= CPU_FTR_1T_SEGMENT;
+		}
+		return 1;
+	}
+	return 0;
+}
+
+static void __init htab_init_seg_sizes(void)
+{
+	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
+}
+
 static int __init htab_dt_scan_page_sizes(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -265,7 +299,6 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	return 0;
 }
 
-
 static void __init htab_init_page_sizes(void)
 {
 	int rc;
@@ -398,7 +431,7 @@ void create_section_mapping(unsigned long start, unsigned long end)
 {
 		BUG_ON(htab_bolt_mapping(start, end, __pa(start),
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX,
-			mmu_linear_psize));
+			mmu_linear_psize, mmu_kernel_ssize));
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
@@ -449,9 +482,18 @@ void __init htab_initialize(void)
 
 	DBG(" -> htab_initialize()\n");
 
+	/* Initialize segment sizes */
+	htab_init_seg_sizes();
+
 	/* Initialize page sizes */
 	htab_init_page_sizes();
 
+	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+		mmu_kernel_ssize = MMU_SEGSIZE_1T;
+		mmu_highuser_ssize = MMU_SEGSIZE_1T;
+		printk(KERN_INFO "Using 1TB segments\n");
+	}
+
 	/*
 	 * Calculate the required size of the htab.  We want the number of
 	 * PTEGs to equal one half the number of real pages.
@@ -523,18 +565,20 @@ void __init htab_initialize(void)
 			if (base != dart_tablebase)
 				BUG_ON(htab_bolt_mapping(base, dart_tablebase,
 							__pa(base), mode_rw,
-							mmu_linear_psize));
+							mmu_linear_psize,
+							mmu_kernel_ssize));
 			if ((base + size) > dart_table_end)
 				BUG_ON(htab_bolt_mapping(dart_tablebase+16*MB,
 							base + size,
 							__pa(dart_table_end),
 							 mode_rw,
-							 mmu_linear_psize));
+							 mmu_linear_psize,
+							 mmu_kernel_ssize));
 			continue;
 		}
 #endif /* CONFIG_U3_DART */
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
-					mode_rw, mmu_linear_psize));
+				mode_rw, mmu_linear_psize, mmu_kernel_ssize));
        }
 
 	/*
@@ -553,7 +597,7 @@ void __init htab_initialize(void)
 
 		BUG_ON(htab_bolt_mapping(tce_alloc_start, tce_alloc_end,
 					 __pa(tce_alloc_start), mode_rw,
-					 mmu_linear_psize));
+					 mmu_linear_psize, mmu_kernel_ssize));
 	}
 
 	htab_finish_init();
@@ -621,7 +665,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 	pte_t *ptep;
 	cpumask_t tmp;
 	int rc, user_region = 0, local = 0;
-	int psize;
+	int psize, ssize;
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
 		ea, access, trap);
@@ -640,20 +684,22 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 			DBG_LOW(" user region with no mm !\n");
 			return 1;
 		}
-		vsid = get_vsid(mm->context.id, ea);
 #ifdef CONFIG_PPC_MM_SLICES
 		psize = get_slice_psize(mm, ea);
 #else
 		psize = mm->context.user_psize;
 #endif
+		ssize = user_segment_size(ea);
+		vsid = get_vsid(mm->context.id, ea, ssize);
 		break;
 	case VMALLOC_REGION_ID:
 		mm = &init_mm;
-		vsid = get_kernel_vsid(ea);
+		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
 		if (ea < VMALLOC_END)
 			psize = mmu_vmalloc_psize;
 		else
 			psize = mmu_io_psize;
+		ssize = mmu_kernel_ssize;
 		break;
 	default:
 		/* Not a valid range
@@ -758,10 +804,10 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 
 #ifdef CONFIG_PPC_HAS_HASH_64K
 	if (psize == MMU_PAGE_64K)
-		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local);
+		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
+		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize);
 
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
@@ -783,6 +829,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	cpumask_t mask;
 	unsigned long flags;
 	int local = 0;
+	int ssize;
 
 	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
 
@@ -815,7 +862,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get VSID */
-	vsid = get_vsid(mm->context.id, ea);
+	ssize = user_segment_size(ea);
+	vsid = get_vsid(mm->context.id, ea, ssize);
 
 	/* Hash doesn't like irqs */
 	local_irq_save(flags);
@@ -828,28 +876,29 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	/* Hash it in */
 #ifdef CONFIG_PPC_HAS_HASH_64K
 	if (mm->context.user_psize == MMU_PAGE_64K)
-		__hash_page_64K(ea, access, vsid, ptep, trap, local);
+		__hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		__hash_page_4K(ea, access, vsid, ptep, trap, local);
+		__hash_page_4K(ea, access, vsid, ptep, trap, local, ssize);
 
 	local_irq_restore(flags);
 }
 
-void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int local)
+void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int ssize,
+		     int local)
 {
 	unsigned long hash, index, shift, hidx, slot;
 
 	DBG_LOW("flush_hash_page(va=%016x)\n", va);
 	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-		hash = hpt_hash(va, shift);
+		hash = hpt_hash(va, shift, ssize);
 		hidx = __rpte_to_hidx(pte, index);
 		if (hidx & _PTEIDX_SECONDARY)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		DBG_LOW(" sub %d: hash=%x, hidx=%x\n", index, slot, hidx);
-		ppc_md.hpte_invalidate(slot, va, psize, local);
+		ppc_md.hpte_invalidate(slot, va, psize, ssize, local);
 	} pte_iterate_hashed_end();
 }
 
@@ -864,7 +913,7 @@ void flush_hash_range(unsigned long number, int local)
 
 		for (i = 0; i < number; i++)
 			flush_hash_page(batch->vaddr[i], batch->pte[i],
-					batch->psize, local);
+					batch->psize, batch->ssize, local);
 	}
 }
 
@@ -890,17 +939,19 @@ void low_hash_fault(struct pt_regs *regs, unsigned long address)
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
-	unsigned long hash, hpteg, vsid = get_kernel_vsid(vaddr);
-	unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
+	unsigned long hash, hpteg;
+	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
+	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
 	unsigned long mode = _PAGE_ACCESSED | _PAGE_DIRTY |
 		_PAGE_COHERENT | PP_RWXX | HPTE_R_N;
 	int ret;
 
-	hash = hpt_hash(va, PAGE_SHIFT);
+	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
 	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 	ret = ppc_md.hpte_insert(hpteg, va, __pa(vaddr),
-				 mode, HPTE_V_BOLTED, mmu_linear_psize);
+				 mode, HPTE_V_BOLTED,
+				 mmu_linear_psize, mmu_kernel_ssize);
 	BUG_ON (ret < 0);
 	spin_lock(&linear_map_hash_lock);
 	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
@@ -910,10 +961,11 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 
 static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 {
-	unsigned long hash, hidx, slot, vsid = get_kernel_vsid(vaddr);
-	unsigned long va = (vsid << 28) | (vaddr & 0x0fffffff);
+	unsigned long hash, hidx, slot;
+	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
+	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
 
-	hash = hpt_hash(va, PAGE_SHIFT);
+	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
 	spin_lock(&linear_map_hash_lock);
 	BUG_ON(!(linear_map_hash_slots[lmi] & 0x80));
 	hidx = linear_map_hash_slots[lmi] & 0x7f;
@@ -923,7 +975,7 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 		hash = ~hash;
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	slot += hidx & _PTEIDX_GROUP_IX;
-	ppc_md.hpte_invalidate(slot, va, mmu_linear_psize, 0);
+	ppc_md.hpte_invalidate(slot, va, mmu_linear_psize, mmu_kernel_ssize, 0);
 }
 
 void kernel_map_pages(struct page *page, int numpages, int enable)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index ba5f12a..08f0d9f 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -403,11 +403,12 @@ int hash_huge_page(struct mm_struct *mm, unsigned long access,
 	unsigned long va, rflags, pa;
 	long slot;
 	int err = 1;
+	int ssize = user_segment_size(ea);
 
 	ptep = huge_pte_offset(mm, ea);
 
 	/* Search the Linux page table for a match with va */
-	va = (vsid << 28) | (ea & 0x0fffffff);
+	va = hpt_va(ea, vsid, ssize);
 
 	/*
 	 * If no pte found or not present, send the problem up to
@@ -458,19 +459,19 @@ int hash_huge_page(struct mm_struct *mm, unsigned long access,
 		/* There MIGHT be an HPTE for this pte */
 		unsigned long hash, slot;
 
-		hash = hpt_hash(va, HPAGE_SHIFT);
+		hash = hpt_hash(va, HPAGE_SHIFT, ssize);
 		if (old_pte & _PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (old_pte & _PAGE_F_GIX) >> 12;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, va, mmu_huge_psize,
-					 local) == -1)
+					 ssize, local) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
 	if (likely(!(old_pte & _PAGE_HASHPTE))) {
-		unsigned long hash = hpt_hash(va, HPAGE_SHIFT);
+		unsigned long hash = hpt_hash(va, HPAGE_SHIFT, ssize);
 		unsigned long hpte_group;
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
@@ -489,7 +490,7 @@ repeat:
 
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags, 0,
-					  mmu_huge_psize);
+					  mmu_huge_psize, ssize);
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
@@ -497,7 +498,7 @@ repeat:
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
 						  HPTE_V_SECONDARY,
-						  mmu_huge_psize);
+						  mmu_huge_psize, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
 					hpte_group = ((hash & htab_hash_mask) *
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 60fd52c..3ef0ad2 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -87,8 +87,8 @@ static int map_io_page(unsigned long ea, unsigned long pa, int flags)
 		 * entry in the hardware page table.
 		 *
 		 */
-		if (htab_bolt_mapping(ea, (unsigned long)ea + PAGE_SIZE,
-				      pa, flags, mmu_io_psize)) {
+		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
+				      mmu_io_psize, mmu_kernel_ssize)) {
 			printk(KERN_ERR "Failed to do bolted mapping IO "
 			       "memory at %016lx !\n", pa);
 			return -ENOMEM;
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 4bee1cf..6c164ce 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -43,17 +43,26 @@ static void slb_allocate(unsigned long ea)
 	slb_allocate_realmode(ea);
 }
 
-static inline unsigned long mk_esid_data(unsigned long ea, unsigned long slot)
+static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
+					 unsigned long slot)
 {
-	return (ea & ESID_MASK) | SLB_ESID_V | slot;
+	unsigned long mask;
+
+	mask = (ssize == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T;
+	return (ea & mask) | SLB_ESID_V | slot;
 }
 
-static inline unsigned long mk_vsid_data(unsigned long ea, unsigned long flags)
+#define slb_vsid_shift(ssize)	\
+	((ssize) == MMU_SEGSIZE_256M? SLB_VSID_SHIFT: SLB_VSID_SHIFT_1T)
+
+static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
+					 unsigned long flags)
 {
-	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
+	return (get_kernel_vsid(ea, ssize) << slb_vsid_shift(ssize)) | flags |
+		((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
 }
 
-static inline void slb_shadow_update(unsigned long ea,
+static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
 				     unsigned long entry)
 {
@@ -63,8 +72,8 @@ static inline void slb_shadow_update(unsigned long ea,
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
 	get_slb_shadow()->save_area[entry].esid = 0;
-	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, flags);
-	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, entry);
+	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, ssize, flags);
+	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, ssize, entry);
 }
 
 static inline void slb_shadow_clear(unsigned long entry)
@@ -72,7 +81,8 @@ static inline void slb_shadow_clear(unsigned long entry)
 	get_slb_shadow()->save_area[entry].esid = 0;
 }
 
-static inline void create_shadowed_slbe(unsigned long ea, unsigned long flags,
+static inline void create_shadowed_slbe(unsigned long ea, int ssize,
+					unsigned long flags,
 					unsigned long entry)
 {
 	/*
@@ -80,11 +90,11 @@ static inline void create_shadowed_slbe(unsigned long ea, unsigned long flags,
 	 * we don't get a stale entry here if we get preempted by PHYP
 	 * between these two statements.
 	 */
-	slb_shadow_update(ea, flags, entry);
+	slb_shadow_update(ea, ssize, flags, entry);
 
 	asm volatile("slbmte  %0,%1" :
-		     : "r" (mk_vsid_data(ea, flags)),
-		       "r" (mk_esid_data(ea, entry))
+		     : "r" (mk_vsid_data(ea, ssize, flags)),
+		       "r" (mk_esid_data(ea, ssize, entry))
 		     : "memory" );
 }
 
@@ -93,7 +103,7 @@ void slb_flush_and_rebolt(void)
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * appropriately too. */
 	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
-	unsigned long ksp_esid_data;
+	unsigned long ksp_esid_data, ksp_vsid_data;
 
 	WARN_ON(!irqs_disabled());
 
@@ -102,13 +112,15 @@ void slb_flush_and_rebolt(void)
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
-	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET) {
+	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, 2);
+	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
+		ksp_vsid_data = 0;
 		slb_shadow_clear(2);
 	} else {
 		/* Update stack entry; others don't change */
-		slb_shadow_update(get_paca()->kstack, lflags, 2);
+		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
+		ksp_vsid_data = get_slb_shadow()->save_area[2].vsid;
 	}
 
 	/* We need to do this all in asm, so we're sure we don't touch
@@ -120,9 +132,9 @@ void slb_flush_and_rebolt(void)
 		     /* Slot 2 - kernel stack */
 		     "slbmte	%2,%3\n"
 		     "isync"
-		     :: "r"(mk_vsid_data(VMALLOC_START, vflags)),
-		        "r"(mk_esid_data(VMALLOC_START, 1)),
-		        "r"(mk_vsid_data(ksp_esid_data, lflags)),
+		     :: "r"(mk_vsid_data(VMALLOC_START, mmu_kernel_ssize, vflags)),
+		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, 1)),
+		        "r"(ksp_vsid_data),
 		        "r"(ksp_esid_data)
 		     : "memory");
 }
@@ -132,7 +144,7 @@ void slb_vmalloc_update(void)
 	unsigned long vflags;
 
 	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	slb_shadow_update(VMALLOC_START, vflags, 1);
+	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
 	slb_flush_and_rebolt();
 }
 
@@ -140,7 +152,7 @@ void slb_vmalloc_update(void)
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
 	unsigned long offset = get_paca()->slb_cache_ptr;
-	unsigned long esid_data = 0;
+	unsigned long slbie_data = 0;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
@@ -149,9 +161,12 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		int i;
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
-			esid_data = ((unsigned long)get_paca()->slb_cache[i]
-				<< SID_SHIFT) | SLBIE_C;
-			asm volatile("slbie %0" : : "r" (esid_data));
+			slbie_data = (unsigned long)get_paca()->slb_cache[i]
+				<< SID_SHIFT; /* EA */
+			slbie_data |= user_segment_size(slbie_data)
+				<< SLBIE_SSIZE_SHIFT;
+			slbie_data |= SLBIE_C; /* C set for user addresses */
+			asm volatile("slbie %0" : : "r" (slbie_data));
 		}
 		asm volatile("isync" : : : "memory");
 	} else {
@@ -160,7 +175,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 
 	/* Workaround POWER5 < DD2.1 issue */
 	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
-		asm volatile("slbie %0" : : "r" (esid_data));
+		asm volatile("slbie %0" : : "r" (slbie_data));
 
 	get_paca()->slb_cache_ptr = 0;
 	get_paca()->context = mm->context;
@@ -243,9 +258,9 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_shadowed_slbe(PAGE_OFFSET, lflags, 0);
+	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
 
-	create_shadowed_slbe(VMALLOC_START, vflags, 1);
+	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
 
 	/* We don't bolt the stack for the time being - we're in boot,
 	 * so the stack is in the bolted segment.  By the time it goes
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index cd1a93d..1328a81 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -57,7 +57,10 @@ _GLOBAL(slb_allocate_realmode)
 	 */
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
+BEGIN_FTR_SECTION
 	b	slb_finish_load
+END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
+	b	slb_finish_load_1T
 
 1:	/* vmalloc/ioremap mapping encoding bits, the "li" instructions below
 	 * will be patched by the kernel at boot
@@ -68,13 +71,16 @@ BEGIN_FTR_SECTION
 	cmpldi	r11,(VMALLOC_SIZE >> 28) - 1
 	bgt	5f
 	lhz	r11,PACAVMALLOCSLLP(r13)
-	b	slb_finish_load
+	b	6f
 5:
 END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
 _GLOBAL(slb_miss_kernel_load_io)
 	li	r11,0
+6:
+BEGIN_FTR_SECTION
 	b	slb_finish_load
-
+END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
+	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
 	 * if the address is within the boundaries of the user region
@@ -122,7 +128,13 @@ _GLOBAL(slb_miss_kernel_load_io)
 #endif /* CONFIG_PPC_MM_SLICES */
 
 	ld	r9,PACACONTEXTID(r13)
+BEGIN_FTR_SECTION
+	cmpldi	r10,0x1000
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	rldimi	r10,r9,USER_ESID_BITS,0
+BEGIN_FTR_SECTION
+	bge	slb_finish_load_1T
+END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	b	slb_finish_load
 
 8:	/* invalid EA */
@@ -188,7 +200,7 @@ _GLOBAL(slb_allocate_user)
  * r3 = EA, r10 = proto-VSID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
  */
 slb_finish_load:
-	ASM_VSID_SCRAMBLE(r10,r9)
+	ASM_VSID_SCRAMBLE(r10,r9,256M)
 	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
 
 	/* r3 = EA, r11 = VSID data */
@@ -213,7 +225,7 @@ BEGIN_FW_FTR_SECTION
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif /* CONFIG_PPC_ISERIES */
 
-	ld	r10,PACASTABRR(r13)
+7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
 	/* use a cpu feature mask if we ever change our slb size */
 	cmpldi	r10,SLB_NUM_ENTRIES
@@ -259,3 +271,20 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	crclr	4*cr0+eq		/* set result to "success" */
 	blr
 
+/*
+ * Finish loading of a 1T SLB entry (for the kernel linear mapping) and return.
+ * We assume legacy iSeries will never have 1T segments.
+ *
+ * r3 = EA, r10 = proto-VSID, r11 = flags, clobbers r9
+ */
+slb_finish_load_1T:
+	srdi	r10,r10,40-28		/* get 1T ESID */
+	ASM_VSID_SCRAMBLE(r10,r9,1T)
+	rldimi	r11,r10,SLB_VSID_SHIFT_1T,16	/* combine VSID and flags */
+	li	r10,MMU_SEGSIZE_1T
+	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
+
+	/* r3 = EA, r11 = VSID data */
+	clrrdi	r3,r3,SID_SHIFT_1T	/* clear out non-ESID bits */
+	b	7b
+
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 28492bb..9e85bda 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -122,12 +122,12 @@ static int __ste_allocate(unsigned long ea, struct mm_struct *mm)
 
 	/* Kernel or user address? */
 	if (is_kernel_addr(ea)) {
-		vsid = get_kernel_vsid(ea);
+		vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
 	} else {
 		if ((ea >= TASK_SIZE_USER64) || (! mm))
 			return 1;
 
-		vsid = get_vsid(mm->context.id, ea);
+		vsid = get_vsid(mm->context.id, ea, MMU_SEGSIZE_256M);
 	}
 
 	stab_entry = make_ste(get_paca()->stab_addr, GET_ESID(ea), vsid);
@@ -261,7 +261,7 @@ void __init stabs_alloc(void)
  */
 void stab_initialize(unsigned long stab)
 {
-	unsigned long vsid = get_kernel_vsid(PAGE_OFFSET);
+	unsigned long vsid = get_kernel_vsid(PAGE_OFFSET, MMU_SEGSIZE_256M);
 	unsigned long stabreal;
 
 	asm volatile("isync; slbia; isync":::"memory");
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index cbd34fc..eafbca5 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -132,6 +132,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 	unsigned long vsid, vaddr;
 	unsigned int psize;
+	int ssize;
 	real_pte_t rpte;
 	int i;
 
@@ -161,11 +162,14 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 
 	/* Build full vaddr */
 	if (!is_kernel_addr(addr)) {
-		vsid = get_vsid(mm->context.id, addr);
+		ssize = user_segment_size(addr);
+		vsid = get_vsid(mm->context.id, addr, ssize);
 		WARN_ON(vsid == 0);
-	} else
-		vsid = get_kernel_vsid(addr);
-	vaddr = (vsid << 28 ) | (addr & 0x0fffffff);
+	} else {
+		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
+		ssize = mmu_kernel_ssize;
+	}
+	vaddr = hpt_va(addr, vsid, ssize);
 	rpte = __real_pte(__pte(pte), ptep);
 
 	/*
@@ -175,7 +179,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * and decide to use local invalidates instead...
 	 */
 	if (!batch->active) {
-		flush_hash_page(vaddr, rpte, psize, 0);
+		flush_hash_page(vaddr, rpte, psize, ssize, 0);
 		return;
 	}
 
@@ -189,13 +193,15 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * We also need to ensure only one page size is present in a given
 	 * batch
 	 */
-	if (i != 0 && (mm != batch->mm || batch->psize != psize)) {
+	if (i != 0 && (mm != batch->mm || batch->psize != psize ||
+		       batch->ssize != ssize)) {
 		__flush_tlb_pending(batch);
 		i = 0;
 	}
 	if (i == 0) {
 		batch->mm = mm;
 		batch->psize = psize;
+		batch->ssize = ssize;
 	}
 	batch->pte[i] = rpte;
 	batch->vaddr[i] = vaddr;
@@ -222,7 +228,7 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 		local = 1;
 	if (i == 1)
 		flush_hash_page(batch->vaddr[0], batch->pte[0],
-				batch->psize, local);
+				batch->psize, batch->ssize, local);
 	else
 		flush_hash_range(i, local);
 	batch->index = 0;
diff --git a/arch/powerpc/platforms/iseries/htab.c b/arch/powerpc/platforms/iseries/htab.c
index b4e2c7a..5ab0f90 100644
--- a/arch/powerpc/platforms/iseries/htab.c
+++ b/arch/powerpc/platforms/iseries/htab.c
@@ -41,7 +41,7 @@ static inline void iSeries_hunlock(unsigned long slot)
 
 long iSeries_hpte_insert(unsigned long hpte_group, unsigned long va,
 			 unsigned long pa, unsigned long rflags,
-			 unsigned long vflags, int psize)
+			 unsigned long vflags, int psize, int ssize)
 {
 	long slot;
 	struct hash_pte lhpte;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ea327ca..9142e46 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -284,7 +284,7 @@ void vpa_init(int cpu)
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
  			      unsigned long va, unsigned long pa,
  			      unsigned long rflags, unsigned long vflags,
- 			      int psize)
+ 			      int psize, int ssize)
 {
 	unsigned long lpar_rc;
 	unsigned long flags;
@@ -296,7 +296,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			"rflags=%lx, vflags=%lx, psize=%d)\n",
 		hpte_group, va, pa, rflags, vflags, psize);
 
- 	hpte_v = hpte_encode_v(va, psize) | vflags | HPTE_V_VALID;
+ 	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
@@ -392,6 +392,22 @@ static void pSeries_lpar_hptab_clear(void)
 }
 
 /*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long hpte_encode_avpn(unsigned long va, int psize,
+					     int ssize)
+{
+	unsigned long v;
+
+	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+
+/*
  * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
  * the low 3 bits of flags happen to line up.  So no transform is needed.
  * We can probably optimize here and assume the high bits of newpp are
@@ -400,18 +416,18 @@ static void pSeries_lpar_hptab_clear(void)
 static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       unsigned long newpp,
 				       unsigned long va,
-				       int psize, int local)
+				       int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
 	unsigned long flags = (newpp & 7) | H_AVPN;
 	unsigned long want_v;
 
-	want_v = hpte_encode_v(va, psize);
+	want_v = hpte_encode_avpn(va, psize, ssize);
 
 	DBG_LOW("    update: avpnv=%016lx, hash=%016lx, f=%x, psize: %d ... ",
-		want_v & HPTE_V_AVPN, slot, flags, psize);
+		want_v, slot, flags, psize);
 
-	lpar_rc = plpar_pte_protect(flags, slot, want_v & HPTE_V_AVPN);
+	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
 		DBG_LOW("not found !\n");
@@ -444,32 +460,25 @@ static unsigned long pSeries_lpar_hpte_getword0(unsigned long slot)
 	return dword0;
 }
 
-static long pSeries_lpar_hpte_find(unsigned long va, int psize)
+static long pSeries_lpar_hpte_find(unsigned long va, int psize, int ssize)
 {
 	unsigned long hash;
-	unsigned long i, j;
+	unsigned long i;
 	long slot;
 	unsigned long want_v, hpte_v;
 
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift);
-	want_v = hpte_encode_v(va, psize);
-
-	for (j = 0; j < 2; j++) {
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		for (i = 0; i < HPTES_PER_GROUP; i++) {
-			hpte_v = pSeries_lpar_hpte_getword0(slot);
-
-			if (HPTE_V_COMPARE(hpte_v, want_v)
-			    && (hpte_v & HPTE_V_VALID)
-			    && (!!(hpte_v & HPTE_V_SECONDARY) == j)) {
-				/* HPTE matches */
-				if (j)
-					slot = -slot;
-				return slot;
-			}
-			++slot;
-		}
-		hash = ~hash;
+	hash = hpt_hash(va, mmu_psize_defs[psize].shift, ssize);
+	want_v = hpte_encode_avpn(va, psize, ssize);
+
+	/* Bolted entries are always in the primary group */
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	for (i = 0; i < HPTES_PER_GROUP; i++) {
+		hpte_v = pSeries_lpar_hpte_getword0(slot);
+
+		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
+			/* HPTE matches */
+			return slot;
+		++slot;
 	}
 
 	return -1;
@@ -477,14 +486,14 @@ static long pSeries_lpar_hpte_find(unsigned long va, int psize)
 
 static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
-					     int psize)
+					     int psize, int ssize)
 {
 	unsigned long lpar_rc, slot, vsid, va, flags;
 
-	vsid = get_kernel_vsid(ea);
-	va = (vsid << 28) | (ea & 0x0fffffff);
+	vsid = get_kernel_vsid(ea, ssize);
+	va = hpt_va(ea, vsid, ssize);
 
-	slot = pSeries_lpar_hpte_find(va, psize);
+	slot = pSeries_lpar_hpte_find(va, psize, ssize);
 	BUG_ON(slot == -1);
 
 	flags = newpp & 7;
@@ -494,7 +503,7 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 }
 
 static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
-					 int psize, int local)
+					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
@@ -503,9 +512,8 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d",
 		slot, va, psize, local);
 
-	want_v = hpte_encode_v(va, psize);
-	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v & HPTE_V_AVPN,
-				   &dummy1, &dummy2);
+	want_v = hpte_encode_avpn(va, psize, ssize);
+	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
 	if (lpar_rc == H_NOT_FOUND)
 		return;
 
@@ -533,18 +541,19 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	unsigned long va;
 	unsigned long hash, index, shift, hidx, slot;
 	real_pte_t pte;
-	int psize;
+	int psize, ssize;
 
 	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
 
 	psize = batch->psize;
+	ssize = batch->ssize;
 	pix = 0;
 	for (i = 0; i < number; i++) {
 		va = batch->vaddr[i];
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-			hash = hpt_hash(va, shift);
+			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
@@ -552,11 +561,11 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 			slot += hidx & _PTEIDX_GROUP_IX;
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
 				pSeries_lpar_hpte_invalidate(slot, va, psize,
-							     local);
+							     ssize, local);
 			} else {
 				param[pix] = HBR_REQUEST | HBR_AVPN | slot;
-				param[pix+1] = hpte_encode_v(va, psize) &
-					HPTE_V_AVPN;
+				param[pix+1] = hpte_encode_avpn(va, psize,
+								ssize);
 				pix += 2;
 				if (pix == 8) {
 					rc = plpar_hcall9(H_BULK_REMOVE, param,
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index c9b8f64..24ec7e2 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -163,6 +163,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
 #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
+#define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -373,7 +374,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_CELL | CPU_FTRS_PA6T)
+	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 71c6e7e..9fad19c 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -51,22 +51,22 @@ struct machdep_calls {
 #ifdef CONFIG_PPC64
 	void            (*hpte_invalidate)(unsigned long slot,
 					   unsigned long va,
-					   int psize,
+					   int psize, int ssize,
 					   int local);
 	long		(*hpte_updatepp)(unsigned long slot, 
 					 unsigned long newpp, 
 					 unsigned long va,
-					 int pize,
+					 int psize, int ssize,
 					 int local);
 	void            (*hpte_updateboltedpp)(unsigned long newpp, 
 					       unsigned long ea,
-					       int psize);
+					       int psize, int ssize);
 	long		(*hpte_insert)(unsigned long hpte_group,
 				       unsigned long va,
 				       unsigned long prpn,
 				       unsigned long rflags,
 				       unsigned long vflags,
-				       int psize);
+				       int psize, int ssize);
 	long		(*hpte_remove)(unsigned long hpte_group);
 	void		(*flush_hash_range)(unsigned long number, int local);
 
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index b22b0d2..0ede62a 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -47,6 +47,8 @@ extern char initial_stab[];
 
 /* Bits in the SLB VSID word */
 #define SLB_VSID_SHIFT		12
+#define SLB_VSID_SHIFT_1T	24
+#define SLB_VSID_SSIZE_SHIFT	62
 #define SLB_VSID_B		ASM_CONST(0xc000000000000000)
 #define SLB_VSID_B_256M		ASM_CONST(0x0000000000000000)
 #define SLB_VSID_B_1T		ASM_CONST(0x4000000000000000)
@@ -66,6 +68,7 @@ extern char initial_stab[];
 #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS|SLB_VSID_C)
 
 #define SLBIE_C			(0x08000000)
+#define SLBIE_SSIZE_SHIFT	25
 
 /*
  * Hash table
@@ -77,7 +80,7 @@ extern char initial_stab[];
 #define HPTE_V_AVPN_SHIFT	7
 #define HPTE_V_AVPN		ASM_CONST(0x3fffffffffffff80)
 #define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
-#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & HPTE_V_AVPN))
+#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & 0xffffffffffffff80))
 #define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
 #define HPTE_V_LOCK		ASM_CONST(0x0000000000000008)
 #define HPTE_V_LARGE		ASM_CONST(0x0000000000000004)
@@ -164,16 +167,19 @@ struct mmu_psize_def
 #define MMU_SEGSIZE_256M	0
 #define MMU_SEGSIZE_1T		1
 
+
 #ifndef __ASSEMBLY__
 
 /*
- * The current system page sizes
+ * The current system page and segment sizes
  */
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
 extern int mmu_vmalloc_psize;
 extern int mmu_io_psize;
+extern int mmu_kernel_ssize;
+extern int mmu_highuser_ssize;
 
 /*
  * If the processor supports 64k normal pages but not 64k cache
@@ -195,13 +201,15 @@ extern int mmu_huge_psize;
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
  */
-static inline unsigned long hpte_encode_v(unsigned long va, int psize)
+static inline unsigned long hpte_encode_v(unsigned long va, int psize,
+					  int ssize)
 {
-	unsigned long v =
+	unsigned long v;
 	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
 	if (psize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
 
@@ -226,20 +234,40 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
 }
 
 /*
- * This hashes a virtual address for a 256Mb segment only for now
+ * Build a VA given VSID, EA and segment size
  */
+static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
+				   int ssize)
+{
+	if (ssize == MMU_SEGSIZE_256M)
+		return (vsid << 28) | (ea & 0xfffffffUL);
+	return (vsid << 40) | (ea & 0xffffffffffUL);
+}
 
-static inline unsigned long hpt_hash(unsigned long va, unsigned int shift)
+/*
+ * This hashes a virtual address
+ */
+
+static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
+				     int ssize)
 {
-	return ((va >> 28) & 0x7fffffffffUL) ^ ((va & 0x0fffffffUL) >> shift);
+	unsigned long hash, vsid;
+
+	if (ssize == MMU_SEGSIZE_256M) {
+		hash = (va >> 28) ^ ((va & 0x0fffffffUL) >> shift);
+	} else {
+		vsid = va >> 40;
+		hash = vsid ^ (vsid << 25) ^ ((va & 0xffffffffffUL) >> shift);
+	}
+	return hash & 0x7fffffffffUL;
 }
 
 extern int __hash_page_4K(unsigned long ea, unsigned long access,
 			  unsigned long vsid, pte_t *ptep, unsigned long trap,
-			  unsigned int local);
+			  unsigned int local, int ssize);
 extern int __hash_page_64K(unsigned long ea, unsigned long access,
 			   unsigned long vsid, pte_t *ptep, unsigned long trap,
-			   unsigned int local);
+			   unsigned int local, int ssize);
 struct mm_struct;
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap);
 extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
@@ -248,7 +276,7 @@ extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
 
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long mode,
-			     int psize);
+			     int psize, int ssize);
 
 extern void htab_initialize(void);
 extern void htab_initialize_secondary(void);
@@ -317,12 +345,17 @@ extern void slb_vmalloc_update(void);
  * which are used by the iSeries firmware.
  */
 
-#define VSID_MULTIPLIER	ASM_CONST(200730139)	/* 28-bit prime */
-#define VSID_BITS	36
-#define VSID_MODULUS	((1UL<<VSID_BITS)-1)
+#define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
+#define VSID_BITS_256M		36
+#define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
-#define CONTEXT_BITS	19
-#define USER_ESID_BITS	16
+#define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
+#define VSID_BITS_1T		24
+#define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
+
+#define CONTEXT_BITS		19
+#define USER_ESID_BITS		16
+#define USER_ESID_BITS_1T	4
 
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
 
@@ -336,17 +369,17 @@ extern void slb_vmalloc_update(void);
  *	rx = scratch register (clobbered)
  *
  * 	- rt and rx must be different registers
- * 	- The answer will end up in the low 36 bits of rt.  The higher
+ * 	- The answer will end up in the low VSID_BITS bits of rt.  The higher
  * 	  bits may contain other garbage, so you may need to mask the
  * 	  result.
  */
-#define ASM_VSID_SCRAMBLE(rt, rx)	\
-	lis	rx,VSID_MULTIPLIER@h;					\
-	ori	rx,rx,VSID_MULTIPLIER@l;				\
+#define ASM_VSID_SCRAMBLE(rt, rx, size)					\
+	lis	rx,VSID_MULTIPLIER_##size@h;				\
+	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
 	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
 									\
-	srdi	rx,rt,VSID_BITS;					\
-	clrldi	rt,rt,(64-VSID_BITS);					\
+	srdi	rx,rt,VSID_BITS_##size;					\
+	clrldi	rt,rt,(64-VSID_BITS_##size);				\
 	add	rt,rt,rx;		/* add high and low bits */	\
 	/* Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
 	 * 2^36-1+2^28-1.  That in particular means that if r3 >=	\
@@ -355,7 +388,7 @@ extern void slb_vmalloc_update(void);
 	 * doesn't, the answer is the low 36 bits of r3+1.  So in all	\
 	 * cases the answer is the low 36 bits of (r3 + ((r3+1) >> 36))*/\
 	addi	rx,rt,1;						\
-	srdi	rx,rx,VSID_BITS;	/* extract 2^36 bit */		\
+	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
 	add	rt,rt,rx
 
 
@@ -377,36 +410,58 @@ typedef struct {
 } mm_context_t;
 
 
-static inline unsigned long vsid_scramble(unsigned long protovsid)
-{
 #if 0
-	/* The code below is equivalent to this function for arguments
-	 * < 2^VSID_BITS, which is all this should ever be called
-	 * with.  However gcc is not clever enough to compute the
-	 * modulus (2^n-1) without a second multiply. */
-	return ((protovsid * VSID_MULTIPLIER) % VSID_MODULUS);
-#else /* 1 */
-	unsigned long x;
+/*
+ * The code below is equivalent to this function for arguments
+ * < 2^VSID_BITS, which is all this should ever be called
+ * with.  However gcc is not clever enough to compute the
+ * modulus (2^n-1) without a second multiply.
+ */
+#define vsid_scrample(protovsid, size) \
+	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
 
-	x = protovsid * VSID_MULTIPLIER;
-	x = (x >> VSID_BITS) + (x & VSID_MODULUS);
-	return (x + ((x+1) >> VSID_BITS)) & VSID_MODULUS;
+#else /* 1 */
+#define vsid_scramble(protovsid, size) \
+	({								 \
+		unsigned long x;					 \
+		x = (protovsid) * VSID_MULTIPLIER_##size;		 \
+		x = (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
+		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
+	})
 #endif /* 1 */
-}
 
 /* This is only valid for addresses >= KERNELBASE */
-static inline unsigned long get_kernel_vsid(unsigned long ea)
+static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
-	return vsid_scramble(ea >> SID_SHIFT);
+	if (ssize == MMU_SEGSIZE_256M)
+		return vsid_scramble(ea >> SID_SHIFT, 256M);
+	return vsid_scramble(ea >> SID_SHIFT_1T, 1T);
 }
 
-/* This is only valid for user addresses (which are below 2^41) */
-static inline unsigned long get_vsid(unsigned long context, unsigned long ea)
+/* Returns the segment size indicator for a user address */
+static inline int user_segment_size(unsigned long addr)
 {
-	return vsid_scramble((context << USER_ESID_BITS)
-			     | (ea >> SID_SHIFT));
+	/* Use 1T segments if possible for addresses >= 1T */
+	if (addr >= (1UL << SID_SHIFT_1T))
+		return mmu_highuser_ssize;
+	return MMU_SEGSIZE_256M;
 }
 
+/* This is only valid for user addresses (which are below 2^44) */
+static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
+				     int ssize)
+{
+	if (ssize == MMU_SEGSIZE_256M)
+		return vsid_scramble((context << USER_ESID_BITS)
+				     | (ea >> SID_SHIFT), 256M);
+	return vsid_scramble((context << USER_ESID_BITS_1T)
+			     | (ea >> SID_SHIFT_1T), 1T);
+}
+
+/*
+ * This is only used on legacy iSeries in lparmap.c,
+ * hence the 256MB segment assumption.
+ */
 #define VSID_SCRAMBLE(pvsid)	(((pvsid) * VSID_MULTIPLIER) % VSID_MODULUS)
 #define KERNEL_VSID(ea)		VSID_SCRAMBLE(GET_ESID(ea))
 
diff --git a/include/asm-powerpc/page_64.h b/include/asm-powerpc/page_64.h
index 56a2df0..4ee82c6 100644
--- a/include/asm-powerpc/page_64.h
+++ b/include/asm-powerpc/page_64.h
@@ -26,12 +26,18 @@
  */
 #define PAGE_FACTOR		(PAGE_SHIFT - HW_PAGE_SHIFT)
 
-/* Segment size */
+/* Segment size; normal 256M segments */
 #define SID_SHIFT		28
 #define SID_MASK		ASM_CONST(0xfffffffff)
 #define ESID_MASK		0xfffffffff0000000UL
 #define GET_ESID(x)		(((x) >> SID_SHIFT) & SID_MASK)
 
+/* 1T segments */
+#define SID_SHIFT_1T		40
+#define SID_MASK_1T		0xffffffUL
+#define ESID_MASK_1T		0xffffff0000000000UL
+#define GET_ESID_1T(x)		(((x) >> SID_SHIFT_1T) & SID_MASK_1T)
+
 #ifndef __ASSEMBLY__
 #include <asm/cache.h>
 
diff --git a/include/asm-powerpc/tlbflush.h b/include/asm-powerpc/tlbflush.h
index 99a0439..a022f80 100644
--- a/include/asm-powerpc/tlbflush.h
+++ b/include/asm-powerpc/tlbflush.h
@@ -97,6 +97,7 @@ struct ppc64_tlb_batch {
 	real_pte_t		pte[PPC64_TLB_BATCH_NR];
 	unsigned long		vaddr[PPC64_TLB_BATCH_NR];
 	unsigned int		psize;
+	int			ssize;
 };
 DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
@@ -127,7 +128,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 
 
 extern void flush_hash_page(unsigned long va, real_pte_t pte, int psize,
-			    int local);
+			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
 
 
