Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQTSQ6qy1zDrht
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 16:17:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u826DBAY009383
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 02:17:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2569vhgdj3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 02:17:40 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Fri, 2 Sep 2016 02:17:39 -0400
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] [v2] powerpc: Clean up tm_abort duplication in hash_utils_64.c
Date: Fri,  2 Sep 2016 14:17:26 +0800
Message-Id: <1472797046-3505-1-git-send-email-rui.teng@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The same logic appears twice and should probably be pulled out into a function.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
Changes in V2:
- Change function to static and inline
- Use #else block to define an empty static inline function

---
 arch/powerpc/mm/hash_utils_64.c | 55 +++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..b68f6d0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1460,6 +1460,29 @@ out_exit:
 	local_irq_restore(flags);
 }
 
+/*
+ * Transactions are not aborted by tlbiel, only tlbie.
+ * Without, syncing a page back to a block device w/ PIO could pick up
+ * transactional data (bad!) so we force an abort here.  Before the
+ * sync the page will be made read-only, which will flush_hash_page.
+ * BIG ISSUE here: if the kernel uses a page from userspace without
+ * unmapping it first, it may see the speculated version.
+ */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline void local_tm_abort(int local)
+{
+	if (local && cpu_has_feature(CPU_FTR_TM) && current->thread.regs &&
+	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+}
+#else
+static inline void local_tm_abort(int local)
+{
+}
+#endif
+
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
@@ -1486,21 +1509,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 					     ssize, local);
 	} pte_iterate_hashed_end();
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	/* Transactions are not aborted by tlbiel, only tlbie.
-	 * Without, syncing a page back to a block device w/ PIO could pick up
-	 * transactional data (bad!) so we force an abort here.  Before the
-	 * sync the page will be made read-only, which will flush_hash_page.
-	 * BIG ISSUE here: if the kernel uses a page from userspace without
-	 * unmapping it first, it may see the speculated version.
-	 */
-	if (local && cpu_has_feature(CPU_FTR_TM) &&
-	    current->thread.regs &&
-	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
-		tm_enable();
-		tm_abort(TM_CAUSE_TLBI);
-	}
-#endif
+	local_tm_abort(local);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1557,21 +1566,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 					     MMU_PAGE_16M, ssize, local);
 	}
 tm_abort:
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	/* Transactions are not aborted by tlbiel, only tlbie.
-	 * Without, syncing a page back to a block device w/ PIO could pick up
-	 * transactional data (bad!) so we force an abort here.  Before the
-	 * sync the page will be made read-only, which will flush_hash_page.
-	 * BIG ISSUE here: if the kernel uses a page from userspace without
-	 * unmapping it first, it may see the speculated version.
-	 */
-	if (local && cpu_has_feature(CPU_FTR_TM) &&
-	    current->thread.regs &&
-	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
-		tm_enable();
-		tm_abort(TM_CAUSE_TLBI);
-	}
-#endif
+	local_tm_abort(local);
 	return;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.7.4
