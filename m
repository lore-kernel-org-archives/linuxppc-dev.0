Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EFCF2B722F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:29 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/13] powerpc: Add gpages reservation code for 64-bit FSL
 BOOKE
Date: Mon, 10 Oct 2011 15:50:43 -0500
Message-Id: <1318279883564-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798791090-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
 <13182798791090-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

For 64-bit FSL_BOOKE implementations, gigantic pages need to be
reserved at boot time by the memblock code based on the command line.
This adds the call that handles the reservation, and fixes some code
comments.

It also removes the previous pr_err when reserve_hugetlb_gpages
is called on a system without hugetlb enabled - the way the code is
structured, the call is unconditional and the resulting error message
spurious and confusing.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/hugetlb.h |   19 ++++++++++++++-----
 arch/powerpc/kernel/setup_64.c     |   10 ++++++++++
 arch/powerpc/mm/hugetlbpage.c      |    8 ++++----
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 273acfa..555044c 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -5,7 +5,6 @@
 #include <asm/page.h>
 
 extern struct kmem_cache *hugepte_cache;
-extern void __init reserve_hugetlb_gpages(void);
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
@@ -153,14 +152,24 @@ static inline void arch_release_hugepage(struct page *page)
 }
 
 #else /* ! CONFIG_HUGETLB_PAGE */
-static inline void reserve_hugetlb_gpages(void)
-{
-	pr_err("Cannot reserve gpages without hugetlb enabled\n");
-}
 static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 				      unsigned long vmaddr)
 {
 }
+#endif /* CONFIG_HUGETLB_PAGE */
+
+
+/*
+ * FSL Book3E platforms require special gpage handling - the gpages
+ * are reserved early in the boot process by memblock instead of via
+ * the .dts as on IBM platforms.
+ */
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_FSL_BOOK3E)
+extern void __init reserve_hugetlb_gpages(void);
+#else
+static inline void reserve_hugetlb_gpages(void)
+{
+}
 #endif
 
 #endif /* _ASM_POWERPC_HUGETLB_H */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d4168c9..2e334d4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -35,6 +35,8 @@
 #include <linux/pci.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
+#include <linux/hugetlb.h>
+
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -64,6 +66,7 @@
 #include <asm/mmu_context.h>
 #include <asm/code-patching.h>
 #include <asm/kvm_ppc.h>
+#include <asm/hugetlb.h>
 
 #include "setup.h"
 
@@ -217,6 +220,13 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
 
+	/*
+	 * Reserve any gigantic pages requested on the command line.
+	 * memblock needs to have been initialized by the time this is
+	 * called since this will reserve memory.
+	 */
+	reserve_hugetlb_gpages();
+
 	DBG(" <- early_setup()\n");
 }
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9a34606..51855a0 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -28,10 +28,10 @@ unsigned int HPAGE_SHIFT;
 
 /*
  * Tracks gpages after the device tree is scanned and before the
- * huge_boot_pages list is ready.  On 64-bit implementations, this is
- * just used to track 16G pages and so is a single array.  32-bit
- * implementations may have more than one gpage size due to limitations
- * of the memory allocators, so we need multiple arrays
+ * huge_boot_pages list is ready.  On non-Freescale implementations, this is
+ * just used to track 16G pages and so is a single array.  FSL-based
+ * implementations may have more than one gpage size, so we need multiple
+ * arrays
  */
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #define MAX_NUMBER_GPAGES	128
-- 
1.5.6.5
