Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B2C6688F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 05:00:47 +1100 (EST)
Date: Tue, 20 Dec 2005 15:37:30 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051220173730.GB6404@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: TLB preloading on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi, 

Been playing with TLB preloading on 8xx for the past weeks, and I must
say that results are frustrating.

Most of the TLB setup work involves writing to special purpose
registers, using "mtspr", which is a serializing instruction (it blocks
all execution units). 

Sum up the costs of disabling interrupts and disabling translation, and you
end up with a slow dog. Damn, the TLB exceptions are indeed efficient.

The test used to measure pagefault latency is LMbench's "lat_pagefault".

vanilla:
[root@CAS /]# ./lat_pagefault -N10 out.prof                                     
Pagefaults on out.prof: 36.3728 microseconds               

d-tlb-preload:
[root@CAS /]# ./lat_pagefault -N10 out.prof                                     
Pagefaults on out.prof: 43.7793 microseconds                                   


diff -Nur --exclude-from=linux-2.6-git-dec01/Documentation/dontdiff linux-2.6-git-dec01.orig/arch/ppc/kernel/head_8xx.S linux-2.6-git-dec01/arch/ppc/kernel/head_8xx.S
--- linux-2.6-git-dec01.orig/arch/ppc/kernel/head_8xx.S	2005-12-05 09:47:27.000000000 -0600
+++ linux-2.6-git-dec01/arch/ppc/kernel/head_8xx.S	2005-12-15 12:37:07.449818656 -0600
@@ -804,7 +828,156 @@
 	SYNC
 	blr
 
+
+_GLOBAL(__tlb_data_load)
+	rlwinm	r8, r4, 0, 0, 19	/* extract page address */
+	ori	r8, r8, MD_EVALID	/* set valid bit */
+	slw	r3, r3, 28
+	rlwimi	r8, r3, 0, 28, 31	/* load ASID from r3 */
+#ifdef CONFIG_8xx_CPU6
+	li	r9, 0x3780;
+	stw	r9, 4(r7);
+	lwz	r9, 4(r7);
+#endif
+	mtspr	SPRN_MD_EPN, r8
+
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
+	lwz	r11, 0(r10)	/* Get the level 1 entry */
+	ori	r11,r11,1	/* Set valid bit */
+
+	/* Insert the Guarded flag into the TWC from the Linux PTE.
+         * It is bit 27 of both the Linux PTE and the TWC (at least
+         * I got that right :-).  It will be better when we can put
+         * this into the Linux pgd/pmd and load it in the operation
+         * above.
+         */
+	mr	r12, r5
+	rlwimi r11, r12, 0, 27, 27
+
+	/* 
+	 * Some fields of MD_TWC are cleared by the CPU on a DTLB miss.
+	 * Must do it manually for TLB preload.
+	 * clear 23-26 (access protection group)
+	 * clear 28-29 (page size) and 30 (write-through)
+	 */
+	li	r12, 0
+	rlwimi r11, r12, 0, 23, 26
+	rlwimi r11, r12, 0, 28, 30
+#ifdef CONFIG_8xx_CPU6
+	li	r9, 0x3b80;
+	stw	r9, 4(r7);
+	lwz	r9, 4(r7);
+#endif
+	mtspr	SPRN_MD_TWC, r11		/* Set segment attributes */
+
+	mr	r8, r5
+	mr	r11, r8
+	rlwinm	r8, r8, 0, 0, 20
+	ori	r8, r8, 1			/* set valid bit */
+	/* Update 'changed', among others.
+	*/
+	andi.	r11, r11, _PAGE_RW
+	li	r11, 0x00f0
+	beq	1f
+	ori	r8, r8, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
+//	stw	r8, 0(r5)		/* and update pte in table */
+	ori	r11, r11, _PAGE_HWWRITE
+	/* The Linux PTE won't go exactly into the MMU TLB.
+	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 24, 25, 26, and 27 must be
+	 * set.  All other Linux PTE bits control the behavior
+	 * of the MMU.
+	 */
+1:
+	rlwimi	r8, r11, 0, 23, 28	/* Set 24-27, clear 28 */
+					/* 23 is set if page is _PAGE_RW */
+#ifdef CONFIG_8xx_CPU6
+	li	r9, 0x3d80;
+	stw	r9, 4(r7);
+	lwz	r9, 4(r7);
+#endif
+	mtspr	SPRN_MD_RPN, r8		/* Update TLB entry */
+
+	mfmsr	r11
+	lwz	r6, 0(r7)	/* restore Link Register */
+	mtlr	r6
+	li 	r6, 0x7fff
+	rlwimi	r11, r6, 0, 27, 27	/* set DR */
+	mtmsr	r11
+	tovirt(r7, r7)
+	blr
+
+/*
+ * Load a D-TLB entry.
+ * r3: context number
+ * r4: effective address
+ * r5: PTE pointer
+ * r6: PMD (level-1 entry)
+ * r7: temp location 
+ */
+_GLOBAL(tlb_data_load)
+	lwz	r5, 0(r5)
+	mflr	r6
+	stw	r6, 0(r7)	/* save Link Register */
+	mfmsr	r11
+	li 	r6, 0
+	rlwimi	r11, r6, 0, 27, 27	/* clear DR (data translat.)*/
+	mtmsr	r11
+	lis	r6, __tlb_data_load@h
+	ori	r6, r6, __tlb_data_load@l
+	tophys(r7, r7)
+	mtlr	r6
+	blr
+
+/*
+ * Load a I-TLB entry.
+ * r3: context number
+ * r4: effective address
+ * r5: PTE pointer
+ * r6: PMD (level-1 entry)
+ * r7: temp location 
+ */
+_GLOBAL(tlb_instr_load)
+	rlwinm	r8, r4, 0, 0, 19	/* extract page address */
+	ori	r8, r8, MI_EVALID	/* set valid bit */
+	slw	r3, r3, 28
+	rlwimi	r8, r3, 0, 28, 31	/* load ASID from r3 */
 #ifdef CONFIG_8xx_CPU6
+	li	r9, 0x2780;
+	stw	r9, 0(r7);
+	lwz	r9, 0(r7);
+#endif
+	
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
+	tovirt(r10, r10)
+	lwz	r11, 0(r10)	/* Get the level 1 entry */
+	ori	r11,r11,1	/* Set valid bit */
+#ifdef CONFIG_8xx_CPU6
+	li	r9, 0x2b80;
+	stw	r9, 0(r7);
+	lwz	r9, 0(r7);
+#endif
+	mtspr	SPRN_MI_TWC, r11		/* Set segment attributes */
+
+	lwz	r8, 0(r5)
+	rlwinm	r8, r8, 0, 0, 19 
+	ori	r8, r8, 1			/* set valid bit */
+	/* The Linux PTE won't go exactly into the MMU TLB.
+	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 24, 25, 26, and 27 must be
+	 * set.  All other Linux PTE bits control the behavior
+	 * of the MMU.
+	 */
+	li	r11, 0x00f0
+	rlwimi	r8, r11, 0, 24, 28	/* Set 24-27, clear 28 */
+#ifdef CONFIG_8xx_CPU6
+	li	r9, 0x2d80;
+	stw	r9, 0(r7);
+	lwz	r9, 0(r7);
+#endif
+	mtspr	SPRN_MI_RPN, r8		/* Update TLB entry */
+	blr
+
 /* It's here because it is unique to the 8xx.
  * It is important we get called with interrupts disabled.  I used to
  * do that, but it appears that all code that calls this already had
@@ -820,7 +993,6 @@
         mtspr   22, r3		/* Update Decrementer */
 	SYNC
 	blr
-#endif
 
 /*
  * We put a few things here that have to be page-aligned.
diff -Nur --exclude-from=linux-2.6-git-dec01/Documentation/dontdiff linux-2.6-git-dec01.orig/arch/ppc/mm/init.c linux-2.6-git-dec01/arch/ppc/mm/init.c
--- linux-2.6-git-dec01.orig/arch/ppc/mm/init.c	2005-12-05 09:47:28.000000000 -0600
+++ linux-2.6-git-dec01/arch/ppc/mm/init.c	2005-12-15 13:16:42.787712408 -0600
@@ -583,6 +583,54 @@
 	kunmap(page);
 }
 
+extern void tlb_data_load(unsigned long id, unsigned long address, pte_t *pte,
+			  unsigned long pmdval, unsigned long *tmpval);
+
+extern void tlb_instr_load(unsigned long id, unsigned long address, pte_t *pte,
+			   unsigned long pmdval, unsigned long *tmpval);
+
+void tlb_preload(struct vm_area_struct *vma, unsigned long address,
+		 pte_t pte)
+{
+	struct mm_struct *mm;
+	pmd_t *pmd;
+	pte_t *ptep;
+	int mapping_executable = 0;
+	unsigned long flags, tmpval;
+	unsigned long tmp[4];
+
+	if ((vma->vm_flags & VM_EXEC) == VM_EXEC)
+		mapping_executable = 1;
+
+	local_irq_save(flags);
+
+	mm = vma->vm_mm;
+	pmd = pmd_offset(pgd_offset(mm, address), address);
+	if (!pmd_none(*pmd)) {
+		if (mfspr(SPRN_M_CASID) != (mm->context)) {
+			printk(KERN_ERR "CASID:%lx mm->context:%lx\n",
+				mfspr(SPRN_M_CASID), (mm->context));
+			BUG();
+		}
+		ptep = pte_offset_map(pmd, address);
+		if (!pte_present(pte) || !ptep)
+			goto out;
+		if (!mapping_executable)
+			tlb_data_load(mm->context, address, ptep,
+					pmd_val(*pmd), &tmp);
+#ifdef NOTYET
+		else 
+			tlb_instr_load(mm->context, address, ptep,
+					pmd_val(*pmd), &tmp);
+#endif
+out:
+		pte_unmap(ptep);
+	}
+	local_irq_restore(flags);
+}
+
+extern void tlbie_efficient(unsigned long address, struct vm_area_struct *vma);
+
 /*
  * This is called at the end of handling a user page fault, when the
  * fault has been handled by updating a PTE in the linux page tables.
@@ -614,6 +662,7 @@
 				flush_dcache_icache_page(page);
 			set_bit(PG_arch_1, &page->flags);
 		}
+		tlb_preload(vma, address, pte);
 	}
 
 #ifdef CONFIG_PPC_STD_MMU
