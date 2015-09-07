Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5E941A2352
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 17:25:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Sep 2015 17:25:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7CDA22BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 17:24:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t877Oof041418780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 17:24:58 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t877OO6r021440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 17:24:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Disable hugepd for 64K page size.
Date: Mon,  7 Sep 2015 12:53:53 +0530
Message-Id: <1441610633-8077-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After commit e2b3d202d1dba8f3546ed28224ce485bc50010be
("powerpc: Switch 16GB and 16MB explicit hugepages to a
different page table format"), we don't need to support
is_hugepd() for 64K page size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page.h | 15 +++++++++++++++
 arch/powerpc/mm/hugetlbpage.c   | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6e976e..d90247b017b3 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -362,6 +362,20 @@ typedef struct { signed long pd; } hugepd_t;
 
 #ifdef CONFIG_HUGETLB_PAGE
 #ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_64K_PAGES
+/*
+ * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
+ * need to setup hugepage directory for them. Our pte and page directory format
+ * enable us to have this enabled. But to avoid errors when implementing new
+ * features disable hugepd for 64K. We enable a debug version here, So we catch
+ * wrong usage.
+ */
+#ifdef CONFIG_DEBUG_VM
+extern int hugepd_ok(hugepd_t hpd);
+#else
+#define hugepd_ok(x)	(0)
+#endif
+#else
 static inline int hugepd_ok(hugepd_t hpd)
 {
 	/*
@@ -370,6 +384,7 @@ static inline int hugepd_ok(hugepd_t hpd)
 	 */
 	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
 }
+#endif
 #else
 static inline int hugepd_ok(hugepd_t hpd)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bb0bd7025cb8..8f4936e6a3db 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -89,6 +89,25 @@ int pgd_huge(pgd_t pgd)
 	 */
 	return ((pgd_val(pgd) & 0x3) != 0x0);
 }
+
+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_DEBUG_VM)
+/*
+ * This enables us to catch the wrong page directory format
+ * Moved here so that we can use WARN() in the call.
+ */
+int hugepd_ok(hugepd_t hpd)
+{
+	bool is_hugepd;
+
+	/*
+	 * We should not find this format in page directory, warn otherwise.
+	 */
+	is_hugepd = (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+	WARN(is_hugepd, "Found wrong page directory format\n");
+	return 0;
+}
+#endif
+
 #else
 int pmd_huge(pmd_t pmd)
 {
-- 
2.5.0
