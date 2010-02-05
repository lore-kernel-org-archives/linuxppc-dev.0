Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 06574B884F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:44:16 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 05/11] powerpc/mpc5121: create and register NFC device
Date: Fri,  5 Feb 2010 14:42:51 +0100
Message-Id: <1265377377-29327-6-git-send-email-agust@denx.de>
In-Reply-To: <1265377377-29327-1-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instantiate NAND Flash Controller device if it's
description is found in the device tree.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index ac0400e..8bb34b2 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -86,9 +86,17 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 void __init mpc512x_declare_of_platform_devices(void)
 {
+	struct device_node *np;
+
 	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
 		printk(KERN_ERR __FILE__ ": "
 			"Error while probing of_platform bus\n");
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-nfc");
+	if (np) {
+		of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
+	}
 }
 
 void __init mpc512x_init(void)
-- 
1.6.3.3
