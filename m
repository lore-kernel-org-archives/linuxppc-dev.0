Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Mar 2007 13:59:40 +1100
Subject: [PATCH 2/4] powerpc: Fix 32 bits mm operations when not using BATs
Message-Id: <20070322030114.D5B9FDDF2B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On hash table based 32 bits powerpc's, the hash management code runs with
a big spinlock. It's thus important that it never causes itself a hash
fault. That code is generally safe (it does memory accesses in real mode
among other things) with the exception of the actual access to the code
itself. That is, the kernel text needs to be accessible without taking
a hash miss exceptions.

This is currently guaranteed by having a BAT register mapping part of the
linear mapping permanently, which includes the kernel text. But this is
not true if using the "nobats" kernel command line option (which can be
useful for debugging) and will not be true when using DEBUG_PAGEALLOC
implemented in a subsequent patch.

This patch fixes this by pre-faulting in the hash table pages that hit
the kernel text, and making sure we never evict such a page under hash
pressure.

Signed-off-by: Benjamin Herrenchmidt <benh@kernel.crashing.org>

 arch/powerpc/mm/hash_low_32.S |   22 ++++++++++++++++++++--
 arch/powerpc/mm/mem.c         |    3 ---
 arch/powerpc/mm/mmu_decl.h    |    3 +++
 arch/powerpc/mm/pgtable_32.c  |   11 +++++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

Index: linux-cell/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_low_32.S	2007-03-22 13:09:34.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hash_low_32.S	2007-03-22 13:15:08.000000000 +1100
@@ -283,6 +283,7 @@ Hash_msk = (((1 << Hash_bits) - 1) * 64)
 #define PTEG_SIZE	64
 #define LG_PTEG_SIZE	6
 #define LDPTEu		lwzu
+#define LDPTE		lwz
 #define STPTE		stw
 #define CMPPTE		cmpw
 #define PTE_H		0x40
@@ -389,13 +390,30 @@ _GLOBAL(hash_page_patch_C)
 	 * and we know there is a definite (although small) speed
 	 * advantage to putting the PTE in the primary PTEG, we always
 	 * put the PTE in the primary PTEG.
+	 *
+	 * In addition, we skip any slot that is mapping kernel text in
+	 * order to avoid a deadlock when not using BAT mappings if
+	 * trying to hash in the kernel hash code itself after it has
+	 * already taken the hash table lock. This works in conjunction
+	 * with pre-faulting of the kernel text.
+	 *
+	 * If the hash table bucket is full of kernel text entries, we'll
+	 * lockup here but that shouldn't happen
 	 */
-	addis	r4,r7,next_slot@ha
+
+1:	addis	r4,r7,next_slot@ha		/* get next evict slot */
 	lwz	r6,next_slot@l(r4)
-	addi	r6,r6,PTE_SIZE
+	addi	r6,r6,PTE_SIZE			/* search for candidate */
 	andi.	r6,r6,7*PTE_SIZE
 	stw	r6,next_slot@l(r4)
 	add	r4,r3,r6
+	LDPTE	r0,PTE_SIZE/2(r4)		/* get PTE second word */
+	clrrwi	r0,r0,12
+	lis	r6,etext@h
+	ori	r6,r6,etext@l			/* get etext */
+	tophys(r6,r6)
+	cmpl	cr0,r0,r6			/* compare and try again */
+	blt	1b
 
 #ifndef CONFIG_SMP
 	/* Store PTE in PTEG */
Index: linux-cell/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:10:49.000000000 +1100
+++ linux-cell/arch/powerpc/mm/pgtable_32.c	2007-03-22 13:27:56.000000000 +1100
@@ -282,16 +282,19 @@ int map_page(unsigned long va, phys_addr
 void __init mapin_ram(void)
 {
 	unsigned long v, p, s, f;
+	int ktext;
 
 	s = mmu_mapin_ram();
 	v = KERNELBASE + s;
 	p = PPC_MEMSTART + s;
 	for (; s < total_lowmem; s += PAGE_SIZE) {
-		if ((char *) v >= _stext && (char *) v < etext)
-			f = _PAGE_RAM_TEXT;
-		else
-			f = _PAGE_RAM;
+		ktext = ((char *) v >= _stext && (char *) v < etext);
+		f = ktext ?_PAGE_RAM_TEXT : _PAGE_RAM;
 		map_page(v, p, f);
+#ifdef CONFIG_PPC_STD_MMU_32
+		if (ktext)
+			hash_preload(&init_mm, v, 0, 0x300);
+#endif
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
Index: linux-cell/arch/powerpc/mm/mem.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/mem.c	2007-03-22 13:09:34.000000000 +1100
+++ linux-cell/arch/powerpc/mm/mem.c	2007-03-22 13:15:08.000000000 +1100
@@ -58,9 +58,6 @@ int init_bootmem_done;
 int mem_init_done;
 unsigned long memory_limit;
 
-extern void hash_preload(struct mm_struct *mm, unsigned long ea,
-			 unsigned long access, unsigned long trap);
-
 int page_is_ram(unsigned long pfn)
 {
 	unsigned long paddr = (pfn << PAGE_SHIFT);
Index: linux-cell/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-cell.orig/arch/powerpc/mm/mmu_decl.h	2007-03-22 13:09:34.000000000 +1100
+++ linux-cell/arch/powerpc/mm/mmu_decl.h	2007-03-22 13:15:08.000000000 +1100
@@ -31,6 +31,9 @@ extern void settlbcam(int index, unsigne
 		      unsigned int size, int flags, unsigned int pid);
 extern void invalidate_tlbcam_entry(int index);
 
+extern void hash_preload(struct mm_struct *mm, unsigned long ea,
+			 unsigned long access, unsigned long trap);
+
 extern int __map_without_bats;
 extern unsigned long ioremap_base;
 extern unsigned int rtas_data, rtas_size;
