Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fxxq1nhRzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 23:25:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VDJMit083092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 09:25:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjr2shk3u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 09:24:59 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Tue, 31 Jul 2018 14:24:58 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, vaibhav@linux.ibm.com, npiggin@gmail.com
Cc: felix@linux.ibm.com, clombard@linux.ibm.com
Subject: [PATCH] powerpc/64s/radix: Fix missing global invalidations when
 removing copro
Date: Tue, 31 Jul 2018 15:24:52 +0200
Message-Id: <20180731132452.15994-1-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the optimizations for TLB invalidation from commit 0cef77c7798a
("powerpc/64s/radix: flush remote CPUs out of single-threaded
mm_cpumask"), the scope of a TLBI (global vs. local) can now be
influenced by the value of the 'copros' counter of the memory context.

When calling mm_context_remove_copro(), the 'copros' counter is
decremented first before flushing. It may have the unintended side
effect of sending local TLBIs when we explicitly need global
invalidations in this case. Thus breaking any nMMU user in a bad and
unpredictable way.

Fix it by flushing first, before updating the 'copros' counter, so
that invalidations will be global.

Fixes: 0cef77c7798a ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h | 33 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 79d570cbf332..b2f89b621b15 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -143,24 +143,33 @@ static inline void mm_context_remove_copro(struct mm_struct *mm)
 {
 	int c;
 
-	c = atomic_dec_if_positive(&mm->context.copros);
-
-	/* Detect imbalance between add and remove */
-	WARN_ON(c < 0);
-
 	/*
-	 * Need to broadcast a global flush of the full mm before
-	 * decrementing active_cpus count, as the next TLBI may be
-	 * local and the nMMU and/or PSL need to be cleaned up.
-	 * Should be rare enough so that it's acceptable.
+	 * When removing the last copro, we need to broadcast a global
+	 * flush of the full mm, as the next TLBI may be local and the
+	 * nMMU and/or PSL need to be cleaned up.
+	 *
+	 * Both the 'copros' and 'active_cpus' counts are looked at in
+	 * flush_all_mm() to determine the scope (local/global) of the
+	 * TLBIs, so we need to flush first before decrementing
+	 * 'copros'. If this API is used by several callers for the
+	 * same context, it can lead to over-flushing. It's hopefully
+	 * not common enough to be a problem.
 	 *
 	 * Skip on hash, as we don't know how to do the proper flush
 	 * for the time being. Invalidations will remain global if
-	 * used on hash.
+	 * used on hash. Note that we can't drop 'copros' either, as
+	 * it could make some invalidations local with no flush
+	 * in-between.
 	 */
-	if (c == 0 && radix_enabled()) {
+	if (radix_enabled()) {
 		flush_all_mm(mm);
-		dec_mm_active_cpus(mm);
+
+		c = atomic_dec_if_positive(&mm->context.copros);
+		/* Detect imbalance between add and remove */
+		WARN_ON(c < 0);
+
+		if (c == 0)
+			dec_mm_active_cpus(mm);
 	}
 }
 #else
-- 
2.17.1
