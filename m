Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E88C2B7090
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2011 08:20:55 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9MLKq0C009744
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2011 16:20:52 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/11] powerpc/85xx: Add 'fsl,
 pq3-gpio' compatiable for GPIO driver
Date: Sat, 22 Oct 2011 16:20:42 -0500
Message-Id: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support MPC85xx platforms outside of MPC8572/MPC8536.  The
MPC8572/MPC8536 have an erratum that is worked around based on having
"fsl,mpc8572-gpio" in the compatiable list.  All other MPC85xx SoCs
don't require this workaround and thus utilize the 'fsl,pq3-gpio'
compatiable.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/gpio/gpio-mpc8xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index fb4963a..d74d19b 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -310,6 +310,7 @@ static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
 	{ .compatible = "fsl,mpc8572-gpio", },
 	{ .compatible = "fsl,mpc8610-gpio", },
 	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
+	{ .compatible = "fsl,pq3-gpio",     },
 	{ .compatible = "fsl,qoriq-gpio",   },
 	{}
 };
-- 
1.7.3.4
