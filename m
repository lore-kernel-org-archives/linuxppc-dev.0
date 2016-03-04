Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 121821A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:02:13 +1100 (AEDT)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7645B140326
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 16:02:12 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 10:32:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u245289J57737268
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:32:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24AV9dr022023
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 16:01:12 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] Fix misleading comment for hard_irq_disable() in
 pmao_restore_workaround
Date: Fri,  4 Mar 2016 10:31:49 +0530
Message-Id: <1457067709-15720-2-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1457067709-15720-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1457067709-15720-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current comment added in pmao_restore_workaround() for
hard_irq_disable is misleading. Comment should say to hard
"disable" interrupts instead of "enable" it. Patch to fix the typo.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index d1e65ce545b3..97a1d40d8696 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -651,7 +651,7 @@ static void pmao_restore_workaround(bool ebb)
 
 	/*
 	 * We are already soft-disabled in power_pmu_enable(). We need to hard
-	 * enable to actually prevent the PMU exception from firing.
+	 * disable to actually prevent the PMU exception from firing.
 	 */
 	hard_irq_disable();
 
-- 
1.9.1
