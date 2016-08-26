Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL6Wg5XGrzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 13:50:21 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7Q3hvC0104394
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:50:19 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2525tw0utd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:50:19 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 23:50:18 -0400
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Clean up tm_abort duplication in hash_utils_64.c
Date: Fri, 26 Aug 2016 11:50:10 +0800
Message-Id: <1472183410-18522-1-git-send-email-rui.teng@linux.vnet.ibm.com>
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
 arch/powerpc/mm/hash_utils_64.c | 45 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..69ef702 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1460,6 +1460,23 @@ out_exit:
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
+void local_tm_abort(int local)
+{
+	if (local && cpu_has_feature(CPU_FTR_TM) && current->thread.regs &&
+		MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+}
+
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
@@ -1487,19 +1504,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 	} pte_iterate_hashed_end();
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
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
+	local_tm_abort(local);
 #endif
 }
 
@@ -1558,19 +1563,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 	}
 tm_abort:
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
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
+	local_tm_abort(local);
 #endif
 	return;
 }
-- 
2.7.4
