Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45EEB68665
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 04:12:14 +1100 (EST)
Date: Mon, 7 Nov 2005 10:11:01 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>, support@abatron.ch
Message-ID: <20051107121101.GI15522@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: BDI2000 and Linux 2.6 kernel
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

Currently gdb over BDI (and I've seen other reports on this list) fails to
translate virtual->physical addresses on PPC 8xx:

*** MMU: address translation for 0xC000C66C failed
*** MMU: address translation for 0xC000C66C failed

Thats because the v2.6 kernel was changed to use physical addresses on the
first level page.

Dan informed me there might be a firmware update available to address 
this problem. Is this true?

With the following the kernel stores the virtual address on the PMD 
getting the BDI "to work".

A newer firmware would be much better though.

--- linux-2.6.14-rc4.orig/arch/ppc/kernel/head_8xx.S	2005-10-18 16:59:34.000000000 -0500
+++ linux-2.6.14-rc4/arch/ppc/kernel/head_8xx.S	2005-11-01 05:45:00.000000000 -0600
@@ -320,11 +320,12 @@ InstructionTLBMiss:
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
+	tophys(r11,r11)
 
 	/* We have a pte table, so load the MI_TWC with the attributes
 	 * for this "segment."
 	 */
-	ori	r11,r11,1		/* Set valid bit */
+	/*ori	r11,r11,1		 Set valid bit */
 	DO_8xx_CPU6(0x2b80, r3)
 	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 	DO_8xx_CPU6(0x3b80, r3)
@@ -379,6 +380,7 @@ DataStoreTLBMiss:
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
+	tophys(r11,r11)
 
 	/* We have a pte table, so load fetch the pte from the table.
 	 */
@@ -493,6 +495,7 @@ DataTLBError:
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, bail */
+	tophys(r11,r11)
 
 	/* We have a pte table, so fetch the pte from the table.
 	 */
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/include/asm-ppc/pgalloc.h linux-2.6.14-rc4/include/asm-ppc/pgalloc.h
--- linux-2.6.14-rc4.orig/include/asm-ppc/pgalloc.h	2005-10-18 17:00:09.000000000 -0500
+++ linux-2.6.14-rc4/include/asm-ppc/pgalloc.h	2005-11-01 08:02:08.000000000 -0600
@@ -19,16 +19,16 @@ extern void pgd_free(pgd_t *pgd);
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
 
-#ifndef CONFIG_BOOKE
+#if defined(CONFIG_BOOKE) || defined(CONFIG_8xx)
 #define pmd_populate_kernel(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = (unsigned long)page_to_virt(pte) | _PMD_PRESENT)
 #else
 #define pmd_populate_kernel(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (unsigned long)page_to_virt(pte) | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
 #endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
diff -Nur -p --exclude-from=linux-2.6.14-rc4/Documentation/dontdiff linux-2.6.14-rc4.orig/include/asm-ppc/pgtable.h linux-2.6.14-rc4/include/asm-ppc/pgtable.h
--- linux-2.6.14-rc4.orig/include/asm-ppc/pgtable.h	2005-10-18 17:00:09.000000000 -0500
+++ linux-2.6.14-rc4/include/asm-ppc/pgtable.h	2005-11-01 08:01:34.000000000 -0600
@@ -719,16 +719,16 @@ extern pgprot_t phys_mem_access_prot(str
  * handler).  On everything else the pmd contains the physical address
  * of the pte page.  -- paulus
  */
-#ifndef CONFIG_BOOKE
+#if defined (CONFIG_BOOKE) || defined CONFIG_8xx
 #define pmd_page_kernel(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 #else
 #define pmd_page_kernel(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
+	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
 #endif
 
 /* to find an entry in a kernel page-table-directory */
