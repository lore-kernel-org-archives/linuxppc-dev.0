Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 115FBB6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 00:08:34 +1000 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/83xx: fix RGMII AC values workaround for km83xx
Date: Tue,  8 May 2012 15:57:20 +0200
Message-Id: <1336485442-24190-2-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
Cc: Christian Herzig <christian.herzig@keymile.com>,
 Holger Brunck <holger.brunck@keymile.com>, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian Herzig <christian.herzig@keymile.com>

Fix RGMII workaround code in km83xx.c for MPC8360E and MPC8358E that it
correctly identifes all affected SoC chip models and applies the
workarounds appropriate for 2.0 and 2.1 revisions as per Freescale
MPC8360ECE Errata document Rev.5(9/2011) item QE_ENET10.

Signed-off-by: Christian Herzig <christian.herzig@keymile.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Heiko Schocher <hs@denx.de>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/km83xx.c |   98 +++++++++++++++++++++++-----------
 1 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index e827c6c..89923d7 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -3,7 +3,7 @@
  * Author: Heiko Schocher <hs@denx.de>
  *
  * Description:
- * Keymile KMETER1 board specific routines.
+ * Keymile 83xx platform specific routines.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -76,48 +76,82 @@ static void __init mpc83xx_km_setup_arch(void)
 
 	np = of_find_compatible_node(NULL, "network", "ucc_geth");
 	if (np != NULL) {
-		uint svid;
+		/*
+		 * handle mpc8360E Erratum QE_ENET10:
+		 * RGMII AC values do not meet the specification
+		 */
+		uint svid = mfspr(SPRN_SVR);
+		struct	device_node *np_par;
+		struct	resource res;
+		void	__iomem *base;
+		int	ret;
+
+		np_par = of_find_node_by_name(NULL, "par_io");
+		if (np_par == NULL) {
+			printk(KERN_WARNING "%s couldn;t find par_io node\n",
+				__func__);
+			return;
+		}
+		/* Map Parallel I/O ports registers */
+		ret = of_address_to_resource(np_par, 0, &res);
+		if (ret) {
+			printk(KERN_WARNING "%s couldn;t map par_io registers\n",
+				__func__);
+			return;
+		}
+
+		base = ioremap(res.start, res.end - res.start + 1);
+
+		/*
+		 * set output delay adjustments to default values according
+		 * table 5 in Errata Rev. 5, 9/2011:
+		 *
+		 * write 0b01 to UCC1 bits 18:19
+		 * write 0b01 to UCC2 option 1 bits 4:5
+		 * write 0b01 to UCC2 option 2 bits 16:17
+		 */
+		clrsetbits_be32((base + 0xa8), 0x0c00f000, 0x04005000);
+
+		/*
+		 * set output delay adjustments to default values according
+		 * table 3-13 in Reference Manual Rev.3 05/2010:
+		 *
+		 * write 0b01 to UCC2 option 2 bits 16:17
+		 * write 0b0101 to UCC1 bits 20:23
+		 * write 0b0101 to UCC2 option 1 bits 24:27
+		 */
+		clrsetbits_be32((base + 0xac), 0x0000cff0, 0x00004550);
 
-		/* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
-		svid = mfspr(SPRN_SVR);
 		if (SVR_REV(svid) == 0x0021) {
-			struct	device_node *np_par;
-			struct	resource res;
-			void	__iomem *base;
-			int	ret;
-
-			np_par = of_find_node_by_name(NULL, "par_io");
-			if (np_par == NULL) {
-				printk(KERN_WARNING "%s couldn;t find par_io node\n",
-					__func__);
-				return;
-			}
-			/* Map Parallel I/O ports registers */
-			ret = of_address_to_resource(np_par, 0, &res);
-			if (ret) {
-				printk(KERN_WARNING "%s couldn;t map par_io registers\n",
-					__func__);
-				return;
-			}
-			base = ioremap(res.start, resource_size(&res));
+			/*
+			 * UCC2 option 1: write 0b1010 to bits 24:27
+			 * at address IMMRBAR+0x14AC
+			 */
+			clrsetbits_be32((base + 0xac), 0x000000f0, 0x000000a0);
+		} else if (SVR_REV(svid) == 0x0020) {
+			/*
+			 * UCC1: write 0b11 to bits 18:19
+			 * at address IMMRBAR+0x14A8
+			 */
+			setbits32((base + 0xa8), 0x00003000);
 
 			/*
-			 * IMMR + 0x14A8[4:5] = 11 (clk delay for UCC 2)
-			 * IMMR + 0x14A8[18:19] = 11 (clk delay for UCC 1)
+			 * UCC2 option 1: write 0b11 to bits 4:5
+			 * at address IMMRBAR+0x14A8
 			 */
-			setbits32((base + 0xa8), 0x0c003000);
+			setbits32((base + 0xa8), 0x0c000000);
 
 			/*
-			 * IMMR + 0x14AC[20:27] = 10101010
-			 * (data delay for both UCC's)
+			 * UCC2 option 2: write 0b11 to bits 16:17
+			 * at address IMMRBAR+0x14AC
 			 */
-			clrsetbits_be32((base + 0xac), 0xff0, 0xaa0);
-			iounmap(base);
-			of_node_put(np_par);
+			setbits32((base + 0xac), 0x0000c000);
 		}
+		iounmap(base);
+		of_node_put(np_par);
 		of_node_put(np);
 	}
-#endif				/* CONFIG_QUICC_ENGINE */
+#endif	/* CONFIG_QUICC_ENGINE */
 }
 
 machine_device_initcall(mpc83xx_km, mpc83xx_declare_of_platform_devices);
-- 
1.7.1
