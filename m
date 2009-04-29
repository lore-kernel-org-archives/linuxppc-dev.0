Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53720DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 04:14:29 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 1/6] powerpc/85xx: clean up for mpc8568_mds name
Date: Wed, 29 Apr 2009 14:14:33 -0400
Message-Id: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Keep an unique machine def for the MPC8568 MDS board to handle some
subtle differences between the future MDS board. Also set the bcsrs in
setup_arch() only for mpc8568_mds because other mds has different bcsr settings.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 7dd0290..d34d29a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -206,23 +206,24 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}
 
 	if (bcsr_regs) {
+		if (machine_is(mpc8568_mds)) {
 #define BCSR_UCC1_GETH_EN	(0x1 << 7)
 #define BCSR_UCC2_GETH_EN	(0x1 << 7)
 #define BCSR_UCC1_MODE_MSK	(0x3 << 4)
 #define BCSR_UCC2_MODE_MSK	(0x3 << 0)
 
-		/* Turn off UCC1 & UCC2 */
-		clrbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
-		clrbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+			/* Turn off UCC1 & UCC2 */
+			clrbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+			clrbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
 
-		/* Mode is RGMII, all bits clear */
-		clrbits8(&bcsr_regs[11], BCSR_UCC1_MODE_MSK |
-					 BCSR_UCC2_MODE_MSK);
-
-		/* Turn UCC1 & UCC2 on */
-		setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
-		setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+			/* Mode is RGMII, all bits clear */
+			clrbits8(&bcsr_regs[11], BCSR_UCC1_MODE_MSK |
+						 BCSR_UCC2_MODE_MSK);
 
+			/* Turn UCC1 & UCC2 on */
+			setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
+			setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
+		}
 		iounmap(bcsr_regs);
 	}
 #endif	/* CONFIG_QUICC_ENGINE */
@@ -257,7 +258,7 @@ static int __init board_fixups(void)
 
 	return 0;
 }
-machine_arch_initcall(mpc85xx_mds, board_fixups);
+machine_arch_initcall(mpc8568_mds, board_fixups);
 
 static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
@@ -276,7 +277,7 @@ static int __init mpc85xx_publish_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mpc85xx_mds, mpc85xx_publish_devices);
+machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
 
 static void __init mpc85xx_mds_pic_init(void)
 {
@@ -321,8 +322,8 @@ static int __init mpc85xx_mds_probe(void)
         return of_flat_dt_is_compatible(root, "MPC85xxMDS");
 }
 
-define_machine(mpc85xx_mds) {
-	.name		= "MPC85xx MDS",
+define_machine(mpc8568_mds) {
+	.name		= "MPC8568 MDS",
 	.probe		= mpc85xx_mds_probe,
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
-- 
1.6.0.2
