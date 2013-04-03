Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F79E2C01E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:54 +1100 (EST)
Received: from mail101-co9 (localhost [127.0.0.1])	by
 mail101-co9-R.bigfish.com (Postfix) with ESMTP id 976692202EC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:45 +0000 (UTC)
Received: from CO9EHSMHS018.bigfish.com (unknown [10.236.132.240])	by
 mail101-co9.bigfish.com (Postfix) with ESMTP id 6B1974E0068	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:43 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 17/17] powerpc/rcpm: add sleep support for T4/B4 chips
Date: Wed, 3 Apr 2013 21:09:25 +0800
Message-ID: <1364994565-16010-17-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen-Hui Zhao <chenhui.zhao@freescale.com>

RCPM unit controls the power managment of T4/B4 chips. Software can
access RCPM registers to put specific thread/core in PH10/PH15/PH20/PH30
state or put the device in LPM10/LPM20/LPM40 mode.

The RCPM unit supports several wake up sources through internal timers
and internal and external interrupts.

When the device enter sleep state, it will be put in LPM20 mode.
The command is "echo standby > /sys/power/state".

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/sysdev/fsl_rcpm.c |   54 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
index fd789da..6bd344b 100644
--- a/arch/powerpc/sysdev/fsl_rcpm.c
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -20,6 +20,7 @@
 #include <asm/fsl_guts.h>
 
 static struct ccsr_rcpm __iomem *rcpm_regs;
+static struct ccsr_rcpm_v2 __iomem *rcpm2_regs;
 
 static int rcpm_suspend_enter(suspend_state_t state)
 {
@@ -53,6 +54,41 @@ static int rcpm_suspend_enter(suspend_state_t state)
 	return ret;
 }
 
+static int rcpm_v2_suspend_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+
+		/* clear previous LPM20 status */
+		setbits32(&rcpm2_regs->powmgtcsr, RCPM_POWMGTCSR_P_LPM20_ST);
+		/* enter LPM20 status */
+		setbits32(&rcpm2_regs->powmgtcsr, RCPM_POWMGTCSR_LPM20_RQ);
+
+		/* At this point, the device is in LPM20 status. */
+
+		/* resume ... */
+		ret = spin_event_timeout(
+		      (in_be32(&rcpm2_regs->powmgtcsr) & RCPM_POWMGTCSR_LPM20_ST)
+		      == 0, 10000, 10);
+		if (!ret) {
+			pr_err("%s: timeout waiting for LPM20 bit to be cleared\n",
+				__func__);
+			ret = -EINVAL;
+		}
+
+		break;
+
+	default:
+		ret = -EINVAL;
+
+	}
+
+	return ret;
+
+}
+
 static int rcpm_suspend_valid(suspend_state_t state)
 {
 	if (state == PM_SUSPEND_STANDBY)
@@ -63,16 +99,25 @@ static int rcpm_suspend_valid(suspend_state_t state)
 
 static const struct platform_suspend_ops rcpm_suspend_ops = {
 	.valid = rcpm_suspend_valid,
-	.enter = rcpm_suspend_enter,
 };
 
 static int rcpm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 
-	rcpm_regs = of_iomap(np, 0);
-	if (!rcpm_regs)
-		return -ENOMEM;
+	if (of_device_is_compatible(np, "fsl,qoriq-rcpm-2")) {
+		rcpm2_regs = of_iomap(np, 0);
+		if (!rcpm2_regs)
+			return -ENOMEM;
+
+		rcpm_suspend_ops.enter = rcpm_v2_suspend_enter;
+	} else {
+		rcpm_regs = of_iomap(np, 0);
+		if (!rcpm_regs)
+			return -ENOMEM;
+
+		rcpm_suspend_ops.enter = rcpm_suspend_enter;
+	}
 
 	suspend_set_ops(&rcpm_suspend_ops);
 
@@ -82,6 +127,7 @@ static int rcpm_probe(struct platform_device *pdev)
 
 static const struct of_device_id rcpm_ids[] = {
 	{ .compatible = "fsl,qoriq-rcpm-1.0", },
+	{ .compatible = "fsl,qoriq-rcpm-2", },
 	{ },
 };
 
-- 
1.7.3
