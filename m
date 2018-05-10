Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hFPK43lZzF2RZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 11:04:36 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id p9-v6so190646pgc.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 18:04:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/pmu/fsl: fix is_nmi test for irq mask change
Date: Thu, 10 May 2018 11:04:23 +1000
Message-Id: <20180510010424.16854-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When soft enabled was changed to irq disabled mask, this test missed
being converted (although the equivalent book3s test was converted).

The PMU drivers consider it an NMI when they take a PMI while general
interrupts are disabled. This change restores that behaviour.

Fixes: 01417c6cc7 ("powerpc/64: Change soft_enabled from flag to bitmask")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/perf/core-fsl-emb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 85f1d18e5fd3..ba485844d506 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -42,7 +42,7 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
 #ifdef __powerpc64__
-	return !regs->softe;
+	return (regs->softe & IRQS_DISABLED);
 #else
 	return 0;
 #endif
-- 
2.17.0
