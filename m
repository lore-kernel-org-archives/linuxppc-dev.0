Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F5CE1A0D70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 21:04:52 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1B84140213
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 21:04:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 16:34:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C1F62125805F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 16:36:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LB4luo55640064
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 16:34:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LAf7mS030676
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 16:11:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc,
 mm: Fix build failure due to CONFIG_PPC_TRANSACTIONAL_MEM
Date: Tue, 21 Apr 2015 16:34:44 +0530
Message-Id: <1429614284-16528-1-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function flush_hash_page fails to compile when the transaction memory
config option is turned off because there is a label at end of compound
statement. This patch moves the code block into a function tm_abort_tlbi
and calls it after the label thus fixing the build problem.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
arch/powerpc/mm/hash_utils_64.c: In function ‘flush_hash_hugepage’:
arch/powerpc/mm/hash_utils_64.c:1381:1: error: label at end of compound statement
 tm_abort:
 ^
make[1]: *** [arch/powerpc/mm/hash_utils_64.o] Error 1
make: *** [arch/powerpc/mm] Error 2

 arch/powerpc/mm/hash_utils_64.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2c2022d..b30b2b5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1326,6 +1326,25 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void tm_abort_tlbi(int local)
+{
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Transactions are not aborted by tlbiel, only tlbie.
+	 * Without, syncing a page back to a block device w/ PIO could pick up
+	 * transactional data (bad!) so we force an abort here.  Before the
+	 * sync the page will be made read-only, which will flush_hash_page.
+	 * BIG ISSUE here: if the kernel uses a page from userspace without
+	 * unmapping it first, it may see the speculated version.
+	 */
+	if (local && cpu_has_feature(CPU_FTR_TM) &&
+	    current->thread.regs &&
+	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+#endif
+}
+
 void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 			 pmd_t *pmdp, unsigned int psize, int ssize,
 			 unsigned long flags)
@@ -1379,21 +1398,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
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
+	tm_abort_tlbi(local);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
1.9.3
