Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DF08679E1
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2006 11:17:50 +1100 (EST)
Subject: [PATCH] powermac: Fix loss of ethernet PHY on sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 11:17:30 +1100
Message-Id: <1140394650.32374.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some recent PowerBook models tend to lose the ethernet PHY on
suspend/resume. It -seems- that they use a combo ethernet-firewire PHY
chip and the firewire PHY seems to die the same way when that happens.
Not trying to toggle the firewire cable power appears to fix it. So this
patch disables changes to the firewire cable power control GPIO on those
models. Please apply for 2.6.16.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-02-20 11:10:07.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-02-20 11:13:25.000000000 +1100
@@ -1648,10 +1648,10 @@
 		  KL0_SCC_CELL_ENABLE);
 
 	MACIO_BIC(KEYLARGO_FCR1,
-		  /*KL1_USB2_CELL_ENABLE |*/
 		KL1_I2S0_CELL_ENABLE | KL1_I2S0_CLK_ENABLE_BIT |
 		KL1_I2S0_ENABLE | KL1_I2S1_CELL_ENABLE |
-		KL1_I2S1_CLK_ENABLE_BIT | KL1_I2S1_ENABLE);
+		KL1_I2S1_CLK_ENABLE_BIT | KL1_I2S1_ENABLE |
+		KL1_EIDE0_ENABLE);
 	if (pmac_mb.board_flags & PMAC_MB_MOBILE)
 		MACIO_BIC(KEYLARGO_FCR1, KL1_UIDE_RESET_N);
 
@@ -2185,7 +2185,7 @@
 	},
 	{	"PowerMac10,1",			"Mac mini",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER,
+		PMAC_MB_MAY_SLEEP,
 	},
 	{	"iMac,1",			"iMac (first generation)",
 		PMAC_TYPE_ORIG_IMAC,		paddington_features,
@@ -2297,11 +2297,11 @@
 	},
 	{	"PowerBook5,8",			"PowerBook G4 15\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP  | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook5,9",			"PowerBook G4 17\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE,
 	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
