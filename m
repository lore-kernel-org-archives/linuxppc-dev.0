Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35FFC1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 10:07:07 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p44072NL004015
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2011 19:07:03 -0500
Subject: [PATCH] powerpc: Rename slb0_limit() to safe_stack_limit() and add
	Book3E support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 10:07:01 +1000
Message-ID: <1304467621.2513.320.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

slb0_limit() wasn't a very descriptive name. This changes it along with
a comment explaining what it's used for, and provides a 64-bit BookE
implementation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/setup_64.c
b/arch/powerpc/kernel/setup_64.c
index 959c63c..c2ec0a1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -434,17 +434,30 @@ void __init setup_system(void)
 	DBG(" <- setup_system()\n");
 }
 
-static u64 slb0_limit(void)
+/* This returns the limit below which memory accesses to the linear
+ * mapping are guarnateed not to cause a TLB or SLB miss. This is
+ * used to allocate interrupt or emergency stacks for which our
+ * exception entry path doesn't deal with being interrupted.
+ */
+static u64 safe_stack_limit(void)
 {
-	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
+#ifdef CONFIG_PPC_BOOK3E
+	/* Freescale BookE bolts the entire linear mapping */
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
+		return linear_map_top;
+	/* Other BookE, we assume the first GB is bolted */
+	return 1ul << 30;
+#else
+	/* BookS, the first segment is bolted */
+	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return 1UL << SID_SHIFT_1T;
-	}
 	return 1UL << SID_SHIFT;
+#endif
 }
 
 static void __init irqstack_early_init(void)
 {
-	u64 limit = slb0_limit();
+	u64 limit = safe_stack_limit();
 	unsigned int i;
 
 	/*
@@ -497,7 +510,7 @@ static void __init emergency_stack_init(void)
 	 * bringup, we need to get at them in real mode. This means they
 	 * must also be within the RMO region.
 	 */
-	limit = min(slb0_limit(), ppc64_rma_size);
+	limit = min(safe_stack_limit(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
 		unsigned long sp;
