Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 095371A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 17:16:45 +1100 (AEDT)
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>
Date: Thu,  3 Mar 2016 00:16:38 -0600
Message-Id: <1456985798-31675-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/fsl-book3e: Avoid lbarx on e5500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lbarx/stbcx. are implemented on e6500, but not on e5500.
Likewise, SMT is on e6500, but not on e5500.

So, avoid executing an unimplemented instruction by only locking
when needed (i.e. in the presence of SMT).

Signed-off-by: Scott Wood <oss@buserror.net>
---
This fixes a regression that was introduced in v4.5-rc1.

 arch/powerpc/mm/hugetlbpage-book3e.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 7e6d088..83a8be7 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -8,6 +8,8 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 
+#include <asm/mmu.h>
+
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #ifdef CONFIG_PPC64
 static inline int tlb1_next(void)
@@ -60,6 +62,14 @@ static inline void book3e_tlb_lock(void)
 	unsigned long tmp;
 	int token = smp_processor_id() + 1;
 
+	/*
+	 * Besides being unnecessary in the absence of SMT, this
+	 * check prevents trying to do lbarx/stbcx. on e5500 which
+	 * doesn't implement either feature.
+	 */
+	if (!cpu_has_feature(CPU_FTR_SMT))
+		return;
+
 	asm volatile("1: lbarx %0, 0, %1;"
 		     "cmpwi %0, 0;"
 		     "bne 2f;"
@@ -80,6 +90,9 @@ static inline void book3e_tlb_unlock(void)
 {
 	struct paca_struct *paca = get_paca();
 
+	if (!cpu_has_feature(CPU_FTR_SMT))
+		return;
+
 	isync();
 	paca->tcd_ptr->lock = 0;
 }
-- 
2.5.0
