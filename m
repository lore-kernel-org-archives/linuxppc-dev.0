Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 66ABFDDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 05:49:28 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l27InOJI018398
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 11:49:25 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l27InO0H028572
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 12:49:24 -0600 (CST)
Subject: [PATCH] Better timer and RTC handling for 8641HPCN.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173293364.23776.128.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 12:49:24 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Give more IRQ numbers for MPIC IPIs and TIMERs use.
Added generic RTC support for MPC8641HPCN.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f42f801..5ef6d61 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -28,7 +28,7 @@
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
-
+#include <asm-generic/rtc.h>
 #include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
@@ -81,7 +81,7 @@ mpc86xx_hpcn_init_irq(void)
 	/* Alloc mpic structure and per isu has 16 INT entries. */
 	mpic1 = mpic_alloc(np, res.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			16, NR_IRQS - 4,
+			16, NR_IRQS - 10,
 			" MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
@@ -452,4 +452,10 @@ define_machine(mpc86xx_hpcn) {
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+
+#ifdef CONFIG_GEN_RTC
+	/* RTC interface, using functions in include/asm-generic/rtc.h */
+	.get_rtc_time		= get_rtc_time,
+	.set_rtc_time		= set_rtc_time,
+#endif
 };
-- 
1.5.0.1.213.g509b
