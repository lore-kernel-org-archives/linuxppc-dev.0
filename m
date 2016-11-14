Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHLfL3cpJzDvXC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 17:46:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: Move CMO code from plapr_wrappers.h to
 platforms/pseries
Date: Mon, 14 Nov 2016 17:46:45 +1100
Message-Id: <1479106005-18460-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there's some CMO (Cooperative Memory Overcommit) code, in
plpar_wrappers.h. Some of it is #ifdef CONFIG_PSERIES and some of it
isn't. The end result being if a file includes plpar_wrappers.h it won't
build with CONFIG_PSERIES=n.

Fix it by moving the CMO code into platforms/pseries. The two hcall
wrappers can just be moved into their only caller, cmm.c, and the
accessors can go in pseries.h.

Note we need the accessors because cmm.c can be built as a module, so
there needs to be a split between the built-in code vs the module, and
that's achieved by using those accessors.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvcall.h         | 21 --------------------
 arch/powerpc/include/asm/plpar_wrappers.h | 32 -------------------------------
 arch/powerpc/platforms/pseries/cmm.c      | 32 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h  | 19 ++++++++++++++++++
 4 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edebcf147..1acdcad5f773 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -412,27 +412,6 @@ static inline unsigned int get_longbusy_msecs(int longbusy_rc)
 	}
 }
 
-#ifdef CONFIG_PPC_PSERIES
-extern int CMO_PrPSP;
-extern int CMO_SecPSP;
-extern unsigned long CMO_PageSize;
-
-static inline int cmo_get_primary_psp(void)
-{
-	return CMO_PrPSP;
-}
-
-static inline int cmo_get_secondary_psp(void)
-{
-	return CMO_SecPSP;
-}
-
-static inline unsigned long cmo_get_page_size(void)
-{
-	return CMO_PageSize;
-}
-#endif /* CONFIG_PPC_PSERIES */
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1b394247afc2..034a588b122c 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -93,38 +93,6 @@ static inline long register_dtl(unsigned long cpu, unsigned long vpa)
 	return vpa_call(H_VPA_REG_DTL, cpu, vpa);
 }
 
-static inline long plpar_page_set_loaned(unsigned long vpa)
-{
-	unsigned long cmo_page_sz = cmo_get_page_size();
-	long rc = 0;
-	int i;
-
-	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
-		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa + i, 0);
-
-	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
-		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE,
-				   vpa + i - cmo_page_sz, 0);
-
-	return rc;
-}
-
-static inline long plpar_page_set_active(unsigned long vpa)
-{
-	unsigned long cmo_page_sz = cmo_get_page_size();
-	long rc = 0;
-	int i;
-
-	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
-		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa + i, 0);
-
-	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
-		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED,
-				   vpa + i - cmo_page_sz, 0);
-
-	return rc;
-}
-
 extern void vpa_init(int cpu);
 
 static inline long plpar_pte_enter(unsigned long flags,
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 66e7227469b8..4412f12374d3 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -109,6 +109,38 @@ static int hotplug_occurred; /* protected by the hotplug mutex */
 
 static struct task_struct *cmm_thread_ptr;
 
+static long plpar_page_set_loaned(unsigned long vpa)
+{
+	unsigned long cmo_page_sz = cmo_get_page_size();
+	long rc = 0;
+	int i;
+
+	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
+		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa + i, 0);
+
+	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
+}
+
+static long plpar_page_set_active(unsigned long vpa)
+{
+	unsigned long cmo_page_sz = cmo_get_page_size();
+	long rc = 0;
+	int i;
+
+	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
+		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa + i, 0);
+
+	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
+}
+
 /**
  * cmm_alloc_pages - Allocate pages and mark them as loaned
  * @nr:	number of pages to allocate
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index b1be7b713fe6..1361a9db534b 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -79,4 +79,23 @@ extern struct pci_controller_ops pseries_pci_controller_ops;
 
 unsigned long pseries_memory_block_size(void);
 
+extern int CMO_PrPSP;
+extern int CMO_SecPSP;
+extern unsigned long CMO_PageSize;
+
+static inline int cmo_get_primary_psp(void)
+{
+	return CMO_PrPSP;
+}
+
+static inline int cmo_get_secondary_psp(void)
+{
+	return CMO_SecPSP;
+}
+
+static inline unsigned long cmo_get_page_size(void)
+{
+	return CMO_PageSize;
+}
+
 #endif /* _PSERIES_PSERIES_H */
-- 
2.7.4
