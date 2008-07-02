Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF372DE9CC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:03:25 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m62F3KfR016356
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 10:03:21 -0500
Date: Wed, 2 Jul 2008 10:03:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: minor fixes for MPC85xx DS board port
Message-ID: <Pine.LNX.4.64.0807021002560.15410@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These issues were reported by Stephen Rothwell for another 85xx board
port and pointed out by Chen Gong as issues in the DS port.

* mpic OF node reference counting was off
* of_device_id struct should be marked as __initdata

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
in my powerpc-next tree.

- k

 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index b010dc9..8b2d63d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -58,14 +58,13 @@ void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
 	struct resource r;
-	struct device_node *np = NULL;
+	struct device_node *np;
 #ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif

 	np = of_find_node_by_type(np, "open-pic");
-
 	if (np == NULL) {
 		printk(KERN_ERR "Could not find open-pic node\n");
 		return;
@@ -82,6 +81,7 @@ void __init mpc85xx_ds_pic_init(void)
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
+	of_node_put(np);

 	mpic_init(mpic);

@@ -185,7 +185,7 @@ static int __init mpc8544_ds_probe(void)
 	}
 }

-static struct of_device_id mpc85xxds_ids[] = {
+static struct of_device_id __initdata mpc85xxds_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{},
-- 
1.5.5.1
