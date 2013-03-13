Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E6D6F2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 01:43:31 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc512x: create SoC devices for more nodes
Date: Wed, 13 Mar 2013 15:43:22 +0100
Message-Id: <1363185802-25427-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create devices for mbx, sram, pci and gpio-leds nodes and
also move nfc compatible to of_bus_id list for automatic
nfc device creation.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index d30235b..2765cd1 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -330,22 +330,19 @@ void __init mpc512x_init_IRQ(void)
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .compatible = "fsl,mpc5121-immr", },
 	{ .compatible = "fsl,mpc5121-localbus", },
+	{ .compatible = "fsl,mpc5121-mbx", },
+	{ .compatible = "fsl,mpc5121-nfc", },
+	{ .compatible = "fsl,mpc5121-sram", },
+	{ .compatible = "fsl,mpc5121-pci", },
+	{ .compatible = "gpio-leds", },
 	{},
 };
 
 void __init mpc512x_declare_of_platform_devices(void)
 {
-	struct device_node *np;
-
 	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
 		printk(KERN_ERR __FILE__ ": "
 			"Error while probing of_platform bus\n");
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-nfc");
-	if (np) {
-		of_platform_device_create(np, NULL, NULL);
-		of_node_put(np);
-	}
 }
 
 #define DEFAULT_FIFO_SIZE 16
-- 
1.7.5.4
