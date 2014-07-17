Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF23F1A0197
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 15:29:47 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Document how we set AIL on guest kernels
Date: Thu, 17 Jul 2014 15:29:45 +1000
Message-Id: <1405574985-21097-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I spent ten minutes scratching my head, trying to work out where we
enabled relocation on interrupts for guest kernels. Expand the doco to
make it clear.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ee082d771178..d600b3fe5f5c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -201,7 +201,11 @@ static void cpu_ready_for_interrupts(void)
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
 
-	/* Enable AIL if supported */
+	/*
+	 * Enable AIL if supported, and we are in hypervisor mode. If we are
+	 * not in hypervisor mode, we enable relocation-on interrupts later
+	 * in pSeries_setup_arch() using the H_SET_MODE hcall.
+	 */
 	if (cpu_has_feature(CPU_FTR_HVMODE) &&
 	    cpu_has_feature(CPU_FTR_ARCH_207S)) {
 		unsigned long lpcr = mfspr(SPRN_LPCR);
-- 
1.9.1
