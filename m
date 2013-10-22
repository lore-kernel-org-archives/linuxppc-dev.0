Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F38962C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 00:47:56 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 19:17:46 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4E283DA8064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:59:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBSXpe49086646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSYfR023167
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 5/9] powerpc: mm: book3s: Enable _PAGE_NUMA for book3s
Date: Tue, 22 Oct 2013 16:58:16 +0530
Message-Id: <1382441300-1513-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We steal the _PAGE_COHERENCE bit and use that for indicating NUMA ptes.
This patch still disables the numa hinting using pmd entries. That
require further changes to pmd entry format which is done in later
patches.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h     | 66 +++++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/pte-hash64.h  |  6 ++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 7d6eacf..9d87125 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #ifndef __ASSEMBLY__
+#include <linux/mmdebug.h>
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -33,10 +34,73 @@ static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
-static inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_PRESENT; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static inline int pte_present(pte_t pte)
+{
+	return pte_val(pte) & (_PAGE_PRESENT | _PAGE_NUMA);
+}
+
+#define pte_numa pte_numa
+static inline int pte_numa(pte_t pte)
+{
+	return (pte_val(pte) &
+		(_PAGE_NUMA|_PAGE_PRESENT)) == _PAGE_NUMA;
+}
+
+#define pte_mknonnuma pte_mknonnuma
+static inline pte_t pte_mknonnuma(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_NUMA;
+	pte_val(pte) |=  _PAGE_PRESENT | _PAGE_ACCESSED;
+	return pte;
+}
+
+#define pte_mknuma pte_mknuma
+static inline pte_t pte_mknuma(pte_t pte)
+{
+	/*
+	 * We should not set _PAGE_NUMA on non present ptes. Also clear the
+	 * present bit so that hash_page will return 1 and we collect this
+	 * as numa fault.
+	 */
+	if (pte_present(pte)) {
+		pte_val(pte) |= _PAGE_NUMA;
+		pte_val(pte) &= ~_PAGE_PRESENT;
+	} else
+		VM_BUG_ON(1);
+	return pte;
+}
+
+#define pmd_numa pmd_numa
+static inline int pmd_numa(pmd_t pmd)
+{
+	return 0;
+}
+
+#define pmd_mknonnuma pmd_mknonnuma
+static inline pmd_t pmd_mknonnuma(pmd_t pmd)
+{
+	return pmd;
+}
+
+#define pmd_mknuma pmd_mknuma
+static inline pmd_t pmd_mknuma(pmd_t pmd)
+{
+	return pmd;
+}
+
+# else
+
+static inline int pte_present(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_PRESENT;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 /* Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  *
diff --git a/arch/powerpc/include/asm/pte-hash64.h b/arch/powerpc/include/asm/pte-hash64.h
index 55aea0c..2505d8e 100644
--- a/arch/powerpc/include/asm/pte-hash64.h
+++ b/arch/powerpc/include/asm/pte-hash64.h
@@ -27,6 +27,12 @@
 #define _PAGE_RW		0x0200 /* software: user write access allowed */
 #define _PAGE_BUSY		0x0800 /* software: PTE & hash are busy */
 
+/*
+ * Used for tracking numa faults
+ */
+#define _PAGE_NUMA	0x00000010 /* Gather numa placement stats */
+
+
 /* No separate kernel read-only */
 #define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
 #define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6704e2e..c9d6223 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -72,6 +72,7 @@ config PPC_BOOK3S_64
 	select PPC_HAVE_PMU_SUPPORT
 	select SYS_SUPPORTS_HUGETLBFS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
+	select ARCH_SUPPORTS_NUMA_BALANCING
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
-- 
1.8.3.2
