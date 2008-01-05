Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18303.25551.433692.29677@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jan 2008 22:02:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] Provide a way to protect 4k subpages
	when using 64k pages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using 64k pages on 64-bit PowerPC systems makes life difficult for
emulators that are trying to emulate an ISA, such as x86, which use a
smaller page size, since the emulator can no longer use the MMU and
the normal system calls for controlling page protections.  Of course,
the emulator can emulate the MMU by checking and possibly remapping
the address for each memory access in software, but that is pretty
slow.

This provides a facility for such programs to control the access
permissions on individual 4k sub-pages of 64k pages.  The idea is
that the emulator supplies an array of protection masks to apply to a
specified range of virtual addresses.  These masks are applied at the
level where hardware PTEs are inserted into the hardware page table
based on the Linux PTEs, so the Linux PTEs are not affected.  Note
that this new mechanism does not allow any access that would otherwise
be prohibited; it can only prohibit accesses that would otherwise be
allowed.  This new facility is only available on 64-bit PowerPC and
only when the kernel is configured for 64k pages.

The masks are supplied using a new subpage_prot system call, which
takes a starting virtual address and length, and a pointer to an array
of protection masks in memory.  The array has a 32-bit word per 64k
page to be protected; each 32-bit word consists of 16 2-bit fields,
for which 0 allows any access (that is otherwise allowed), 1 prevents
write accesses, and 2 or 3 prevent any access.

Implicit in this is that the regions of the address space that are
protected are switched to use 4k hardware pages rather than 64k
hardware pages (on machines with hardware 64k page support).  In fact
the whole process is switched to use 4k hardware pages when the
subpage_prot system call is used, but this could be improved in future
to switch only the affected segments.

The subpage protection bits are stored in a 3 level tree akin to the
page table tree.  The top level of this tree is stored in a structure
that is appended to the top level of the page table tree, i.e., the
pgd array.  Since it will often only be 32-bit addresses (below 4GB)
that are protected, the pointers to the first four bottom level pages
are also stored in this structure (each bottom level page contains the
protection bits for 1GB of address space), so the protection bits for
addresses below 4GB can be accessed with one fewer loads than those
for higher addresses.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This version allocates a new system call number for the subpage_prot
syscall.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..53d0955 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -342,6 +342,14 @@ config PPC_64K_PAGES
 	  while on hardware with such support, it will be used to map
 	  normal application pages.
 
+config PPC_SUBPAGE_PROT
+	bool "Support setting protections for 4k subpages"
+	depends on PPC_64K_PAGES
+	help
+	  This option adds support for a system call to allow user programs
+	  to set access permissions (read/write, readonly, or no access)
+	  on the 4k subpages of each 64k page.
+
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on PPC64 && SMP
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index c349868..11b4f6d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -903,6 +903,7 @@ handle_page_fault:
  * the PTE insertion
  */
 12:	bl	.save_nvgprs
+	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
 	bl	.low_hash_fault
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 3b1d5dd..18be22e 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -328,3 +328,7 @@ void do_show_syscall_exit(unsigned long r3)
 {
 	printk(" -> %lx, current=%p cpu=%d\n", r3, current, smp_processor_id());
 }
+
+#ifndef CONFIG_PPC_SUBPAGE_PROT
+cond_syscall(subpage_prot);
+#endif
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 20629ae..41649a5 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
+obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index e935edd..21d2484 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -331,7 +331,8 @@ htab_pte_insert_failure:
  *****************************************************************************/
 
 /* _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, int local, int ssize)
+ *		 pte_t *ptep, unsigned long trap, int local, int ssize,
+ *		 int subpg_prot)
  */
 
 /*
@@ -429,12 +430,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
-4:	andi.	r3,r30,0x1fe		/* Get basic set of flags */
-	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
+4:
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+	andc	r10,r30,r10
+	andi.	r3,r10,0x1fe		/* Get basic set of flags */
+	rlwinm	r0,r10,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
+#else
+	andi.	r3,r30,0x1fe		/* Get basic set of flags */
 	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
+#endif
+	xori	r3,r3,HPTE_R_N		/* _PAGE_EXEC -> NOEXEC */
 	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY ->r0 bit 30*/
-	andc	r0,r30,r0		/* r0 = pte & ~r0 */
+	andc	r0,r3,r0		/* r0 = pte & ~r0 */
 	rlwimi	r3,r0,32-1,31,31	/* Insert result into PP lsb */
 	ori	r3,r3,HPTE_R_C		/* Always add "C" bit for perf. */
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index cbbd8b0..9567b17 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -644,7 +644,7 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
  * For now this makes the whole process use 4k pages.
  */
 #ifdef CONFIG_PPC_64K_PAGES
-static void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
+void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
 	if (mm->context.user_psize == MMU_PAGE_4K)
 		return;
@@ -652,13 +652,62 @@ static void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 #ifdef CONFIG_SPU_BASE
 	spu_flush_all_slbs(mm);
 #endif
+	if (get_paca()->context.user_psize != MMU_PAGE_4K) {
+		get_paca()->context = mm->context;
+		slb_flush_and_rebolt();
+	}
 }
 #endif /* CONFIG_PPC_64K_PAGES */
 
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+/*
+ * This looks up a 2-bit protection code for a 4k subpage of a 64k page.
+ * Userspace sets the subpage permissions using the subpage_prot system call.
+ *
+ * Result is 0: full permissions, _PAGE_RW: read-only,
+ * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
+ */
+static int subpage_protection(pgd_t *pgdir, unsigned long ea)
+{
+	struct subpage_prot_table *spt = pgd_subpage_prot(pgdir);
+	u32 spp = 0;
+	u32 **sbpm, *sbpp;
+
+	if (ea >= spt->maxaddr)
+		return 0;
+	if (ea < 0x100000000) {
+		/* addresses below 4GB use spt->low_prot */
+		sbpm = spt->low_prot;
+	} else {
+		sbpm = spt->protptrs[ea >> SBP_L3_SHIFT];
+		if (!sbpm)
+			return 0;
+	}
+	sbpp = sbpm[(ea >> SBP_L2_SHIFT) & (SBP_L2_COUNT - 1)];
+	if (!sbpp)
+		return 0;
+	spp = sbpp[(ea >> PAGE_SHIFT) & (SBP_L1_COUNT - 1)];
+
+	/* extract 2-bit bitfield for this 4k subpage */
+	spp >>= 30 - 2 * ((ea >> 12) & 0xf);
+
+	/* turn 0,1,2,3 into combination of _PAGE_USER and _PAGE_RW */
+	spp = ((spp & 2) ? _PAGE_USER : 0) | ((spp & 1) ? _PAGE_RW : 0);
+	return spp;
+}
+
+#else /* CONFIG_PPC_SUBPAGE_PROT */
+static inline int subpage_protection(pgd_t *pgdir, unsigned long ea)
+{
+	return 0;
+}
+#endif
+
 /* Result code is:
  *  0 - handled
  *  1 - normal page fault
  * -1 - critical hash insertion error
+ * -2 - access not permitted by subpage protection mechanism
  */
 int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 {
@@ -809,7 +858,14 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize);
+	{
+		int spp = subpage_protection(pgdir, ea);
+		if (access & spp)
+			rc = -2;
+		else
+			rc = __hash_page_4K(ea, access, vsid, ptep, trap,
+					    local, ssize, spp);
+	}
 
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
@@ -881,7 +937,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 		__hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		__hash_page_4K(ea, access, vsid, ptep, trap, local, ssize);
+		__hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
+			       subpage_protection(pgdir, ea));
 
 	local_irq_restore(flags);
 }
@@ -926,19 +983,17 @@ void flush_hash_range(unsigned long number, int local)
  * low_hash_fault is called when we the low level hash code failed
  * to instert a PTE due to an hypervisor error
  */
-void low_hash_fault(struct pt_regs *regs, unsigned long address)
+void low_hash_fault(struct pt_regs *regs, unsigned long address, int rc)
 {
 	if (user_mode(regs)) {
-		siginfo_t info;
-
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
-		return;
-	}
-	bad_page_fault(regs, address, SIGBUS);
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+		if (rc == -2)
+			_exception(SIGSEGV, regs, SEGV_ACCERR, address);
+		else
+#endif
+			_exception(SIGBUS, regs, BUS_ADRERR, address);
+	} else
+		bad_page_fault(regs, address, SIGBUS);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
new file mode 100644
index 0000000..4cafc0c
--- /dev/null
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -0,0 +1,213 @@
+/*
+ * Copyright 2007-2008 Paul Mackerras, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/tlbflush.h>
+
+/*
+ * Free all pages allocated for subpage protection maps and pointers.
+ * Also makes sure that the subpage_prot_table structure is
+ * reinitialized for the next user.
+ */
+void subpage_prot_free(pgd_t *pgd)
+{
+	struct subpage_prot_table *spt = pgd_subpage_prot(pgd);
+	unsigned long i, j, addr;
+	u32 **p;
+
+	for (i = 0; i < 4; ++i) {
+		if (spt->low_prot[i]) {
+			free_page((unsigned long)spt->low_prot[i]);
+			spt->low_prot[i] = NULL;
+		}
+	}
+	addr = 0;
+	for (i = 0; i < 2; ++i) {
+		p = spt->protptrs[i];
+		if (!p)
+			continue;
+		spt->protptrs[i] = NULL;
+		for (j = 0; j < SBP_L2_COUNT && addr < spt->maxaddr;
+		     ++j, addr += PAGE_SIZE)
+			if (p[j])
+				free_page((unsigned long)p[j]);
+		free_page((unsigned long)p);
+	}
+	spt->maxaddr = 0;
+}
+
+static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
+			     int npages)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return;
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud))
+		return;
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return;
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	arch_enter_lazy_mmu_mode();
+	for (; npages > 0; --npages) {
+		pte_update(mm, addr, pte, 0, 0);
+		addr += PAGE_SIZE;
+		++pte;
+	}
+	arch_leave_lazy_mmu_mode();
+	pte_unmap_unlock(pte - 1, ptl);
+}
+
+/*
+ * Clear the subpage protection map for an address range, allowing
+ * all accesses that are allowed by the pte permissions.
+ */
+static void subpage_prot_clear(unsigned long addr, unsigned long len)
+{
+	struct mm_struct *mm = current->mm;
+	struct subpage_prot_table *spt = pgd_subpage_prot(mm->pgd);
+	u32 **spm, *spp;
+	int i, nw;
+	unsigned long next, limit;
+
+	down_write(&mm->mmap_sem);
+	limit = addr + len;
+	if (limit > spt->maxaddr)
+		limit = spt->maxaddr;
+	for (; addr < limit; addr = next) {
+		next = pmd_addr_end(addr, limit);
+		if (addr < 0x100000000) {
+			spm = spt->low_prot;
+		} else {
+			spm = spt->protptrs[addr >> SBP_L3_SHIFT];
+			if (!spm)
+				continue;
+		}
+		spp = spm[(addr >> SBP_L2_SHIFT) & (SBP_L2_COUNT - 1)];
+		if (!spp)
+			continue;
+		spp += (addr >> PAGE_SHIFT) & (SBP_L1_COUNT - 1);
+
+		i = (addr >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+		nw = PTRS_PER_PTE - i;
+		if (addr + (nw << PAGE_SHIFT) > next)
+			nw = (next - addr) >> PAGE_SHIFT;
+
+		memset(spp, 0, nw * sizeof(u32));
+
+		/* now flush any existing HPTEs for the range */
+		hpte_flush_range(mm, addr, nw);
+	}
+	up_write(&mm->mmap_sem);
+}
+
+/*
+ * Copy in a subpage protection map for an address range.
+ * The map has 2 bits per 4k subpage, so 32 bits per 64k page.
+ * Each 2-bit field is 0 to allow any access, 1 to prevent writes,
+ * 2 or 3 to prevent all accesses.
+ * Note that the normal page protections also apply; the subpage
+ * protection mechanism is an additional constraint, so putting 0
+ * in a 2-bit field won't allow writes to a page that is otherwise
+ * write-protected.
+ */
+long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
+{
+	struct mm_struct *mm = current->mm;
+	struct subpage_prot_table *spt = pgd_subpage_prot(mm->pgd);
+	u32 **spm, *spp;
+	int i, nw;
+	unsigned long next, limit;
+	int err;
+
+	/* Check parameters */
+	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
+	    addr >= TASK_SIZE || len >= TASK_SIZE || addr + len > TASK_SIZE)
+		return -EINVAL;
+
+	if (is_hugepage_only_range(mm, addr, len))
+		return -EINVAL;
+
+	if (!map) {
+		/* Clear out the protection map for the address range */
+		subpage_prot_clear(addr, len);
+		return 0;
+	}
+
+	if (!access_ok(VERIFY_READ, map, (len >> PAGE_SHIFT) * sizeof(u32)))
+		return -EFAULT;
+
+	down_write(&mm->mmap_sem);
+	for (limit = addr + len; addr < limit; addr = next) {
+		next = pmd_addr_end(addr, limit);
+		err = -ENOMEM;
+		if (addr < 0x100000000) {
+			spm = spt->low_prot;
+		} else {
+			spm = spt->protptrs[addr >> SBP_L3_SHIFT];
+			if (!spm) {
+				spm = (u32 **)get_zeroed_page(GFP_KERNEL);
+				if (!spm)
+					goto out;
+				spt->protptrs[addr >> SBP_L3_SHIFT] = spm;
+			}
+		}
+		spm += (addr >> SBP_L2_SHIFT) & (SBP_L2_COUNT - 1);
+		spp = *spm;
+		if (!spp) {
+			spp = (u32 *)get_zeroed_page(GFP_KERNEL);
+			if (!spp)
+				goto out;
+			*spm = spp;
+		}
+		spp += (addr >> PAGE_SHIFT) & (SBP_L1_COUNT - 1);
+
+		local_irq_disable();
+		demote_segment_4k(mm, addr);
+		local_irq_enable();
+
+		i = (addr >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+		nw = PTRS_PER_PTE - i;
+		if (addr + (nw << PAGE_SHIFT) > next)
+			nw = (next - addr) >> PAGE_SHIFT;
+
+		up_write(&mm->mmap_sem);
+		err = -EFAULT;
+		if (__copy_from_user(spp, map, nw * sizeof(u32)))
+			goto out2;
+		map += nw;
+		down_write(&mm->mmap_sem);
+
+		/* now flush any existing HPTEs for the range */
+		hpte_flush_range(mm, addr, nw);
+	}
+	if (limit > spt->maxaddr)
+		spt->maxaddr = limit;
+	err = 0;
+ out:
+	up_write(&mm->mmap_sem);
+ out2:
+	return err;
+}
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index 12e5e77..8f40d63 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -265,7 +265,7 @@ static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
 
 extern int __hash_page_4K(unsigned long ea, unsigned long access,
 			  unsigned long vsid, pte_t *ptep, unsigned long trap,
-			  unsigned int local, int ssize);
+			  unsigned int local, int ssize, int subpage_prot);
 extern int __hash_page_64K(unsigned long ea, unsigned long access,
 			   unsigned long vsid, pte_t *ptep, unsigned long trap,
 			   unsigned int local, int ssize);
@@ -278,6 +278,7 @@ extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long mode,
 			     int psize, int ssize);
+extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
 extern void htab_initialize(void);
 extern void htab_initialize_secondary(void);
diff --git a/include/asm-powerpc/pgalloc-64.h b/include/asm-powerpc/pgalloc-64.h
index 94d0294..43214c8 100644
--- a/include/asm-powerpc/pgalloc-64.h
+++ b/include/asm-powerpc/pgalloc-64.h
@@ -12,6 +12,10 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 
+#ifndef CONFIG_PPC_SUBPAGE_PROT
+static inline void subpage_prot_free(pgd_t *pgd) {}
+#endif
+
 extern struct kmem_cache *pgtable_cache[];
 
 #define PGD_CACHE_NUM		0
@@ -27,6 +31,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 static inline void pgd_free(pgd_t *pgd)
 {
+	subpage_prot_free(pgd);
 	kmem_cache_free(pgtable_cache[PGD_CACHE_NUM], pgd);
 }
 
diff --git a/include/asm-powerpc/pgtable-64k.h b/include/asm-powerpc/pgtable-64k.h
index bd54b77..1cbd6b3 100644
--- a/include/asm-powerpc/pgtable-64k.h
+++ b/include/asm-powerpc/pgtable-64k.h
@@ -13,12 +13,49 @@
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
-#endif	/* __ASSEMBLY__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+/*
+ * For the sub-page protection option, we extend the PGD with one of
+ * these.  Basically we have a 3-level tree, with the top level being
+ * the protptrs array.  To optimize speed and memory consumption when
+ * only addresses < 4GB are being protected, pointers to the first
+ * four pages of sub-page protection words are stored in the low_prot
+ * array.
+ * Each page of sub-page protection words protects 1GB (4 bytes
+ * protects 64k).  For the 3-level tree, each page of pointers then
+ * protects 8TB.
+ */
+struct subpage_prot_table {
+	unsigned long maxaddr;	/* only addresses < this are protected */
+	unsigned int **protptrs[2];
+	unsigned int *low_prot[4];
+};
+
+#undef PGD_TABLE_SIZE
+#define PGD_TABLE_SIZE		((sizeof(pgd_t) << PGD_INDEX_SIZE) + \
+				 sizeof(struct subpage_prot_table))
+
+#define SBP_L1_BITS		(PAGE_SHIFT - 2)
+#define SBP_L2_BITS		(PAGE_SHIFT - 3)
+#define SBP_L1_COUNT		(1 << SBP_L1_BITS)
+#define SBP_L2_COUNT		(1 << SBP_L2_BITS)
+#define SBP_L2_SHIFT		(PAGE_SHIFT + SBP_L1_BITS)
+#define SBP_L3_SHIFT		(SBP_L2_SHIFT + SBP_L2_BITS)
+
+extern void subpage_prot_free(pgd_t *pgd);
+
+static inline struct subpage_prot_table *pgd_subpage_prot(pgd_t *pgd)
+{
+	return (struct subpage_prot_table *)(pgd + PTRS_PER_PGD);
+}
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+#endif	/* __ASSEMBLY__ */
+
 /* With 4k base page size, hugepage PTEs go at the PMD level */
 #define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
 
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 11d5383..0c8b0d6 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -313,3 +313,4 @@ COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
 COMPAT_SYS(fallocate)
+SYSCALL(subpage_prot)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 97d82b6..fedc4b8 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -332,10 +332,11 @@
 #define __NR_eventfd		307
 #define __NR_sync_file_range2	308
 #define __NR_fallocate		309
+#define __NR_subpage_prot	310
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		310
+#define __NR_syscalls		311
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
