Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id D822F2BF13
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Dec 2004 11:52:02 +1100 (EST)
Date: Thu, 16 Dec 2004 17:51:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: torvalds@osdl.org
Message-ID: <20041216175159.A12028@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Fix io_remap_page_range for 36-bit phys platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes io_remap_page_range() to use the 32-bit address translator
similar to ioremap(). Someday u64 start/end resources should make
this unnecessary. Fixes set_pte() to handle a long long pte_t
properly.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-12-16 17:31:53 -07:00
+++ b/arch/ppc/Kconfig	2004-12-16 17:31:53 -07:00
@@ -97,6 +97,11 @@
 	depends on 44x
 	default y
 
+config PHYS_64BIT
+	bool
+	depends on 44x
+	default y
+
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on 6xx || POWER4
diff -Nru a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c	2004-12-16 17:31:53 -07:00
+++ b/arch/ppc/syslib/ibm44x_common.c	2004-12-16 17:31:53 -07:00
@@ -19,6 +19,7 @@
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/serial.h>
+#include <linux/module.h>
 
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>
@@ -47,6 +48,7 @@
 
 	return (page_4gb | addr);
 };
+EXPORT_SYMBOL(fixup_bigphys_addr);
 
 void __init ibm44x_calibrate_decr(unsigned int freq)
 {
diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2004-12-16 17:31:53 -07:00
+++ b/include/asm-ppc/pgtable.h	2004-12-16 17:31:53 -07:00
@@ -431,7 +431,7 @@
 #define pte_pfn(x)		(pte_val(x) >> PAGE_SHIFT)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((pte_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 /*
@@ -714,8 +714,22 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
+#ifdef CONFIG_PHYS_64BIT
+extern int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+			unsigned long paddr, unsigned long size, pgprot_t prot);
+static inline int io_remap_page_range(struct vm_area_struct *vma,
+					unsigned long vaddr,
+					unsigned long paddr,
+					unsigned long size,
+					pgprot_t prot)
+{
+	phys_addr_t paddr64 = fixup_bigphys_addr(paddr, size);
+	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
+}
+#else
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+#endif
 
 /*
  * No page table caches to initialise
