Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 205DDB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  9 Jan 2011 02:51:12 +1100 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 248EA1C1DA02
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Jan 2011 16:51:08 +0100 (CET)
Received: from localhost (p4FE3E9C3.dip.t-dialin.net [79.227.233.195])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA id A22151C00142
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Jan 2011 16:51:08 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc8xxx_gpio: simplify searching for 'fsl,
	qoriq-gpio' compatiable
Date: Sat,  8 Jan 2011 16:51:16 +0100
Message-Id: <1294501876-9331-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit da3ed89e7ce272ebcc918487e2a28736ca0dd6bb added
'fsl,qoriq-gpio' compatiable searching in the old way
using for_each_compatible_node(). But the driver have
previously been changed to use a struct of_device_id
compatible list passed to for_each_matching_node().

Add 'fsl,qoriq-gpio' compatiable to the existing
compatible list instead of adding another
for_each_compatible_node() loop.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index c48cd81..0c2a91a 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -310,6 +310,7 @@ static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
 	{ .compatible = "fsl,mpc8572-gpio", },
 	{ .compatible = "fsl,mpc8610-gpio", },
 	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
+	{ .compatible = "fsl,qoriq-gpio",   },
 	{}
 };
 
@@ -389,9 +390,6 @@ static int __init mpc8xxx_add_gpiochips(void)
 	for_each_matching_node(np, mpc8xxx_gpio_ids)
 		mpc8xxx_add_controller(np);
 
-	for_each_compatible_node(np, NULL, "fsl,qoriq-gpio")
-		mpc8xxx_add_controller(np);
-
 	return 0;
 }
 arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.7.1
