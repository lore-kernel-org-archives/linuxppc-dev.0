Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0CA1C67B22
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:33:14 +1000 (EST)
Date: Sat, 30 Sep 2006 18:33:11 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/15] Update for ucc_geth driver
Message-Id: <20060930183311.1d50638c.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the ucc_geth driver according to qe_lib changes.
Fix l3qt bug.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/Kconfig        |    2 +-
 drivers/net/ucc_geth.c     |    6 +++---
 drivers/net/ucc_geth_phy.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6315477..74db2c1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2285,7 +2285,7 @@ config UGETH_TX_ON_DEMOND
 
 config UGETH_HAS_GIGA
 	bool
-	depends on UCC_GETH && MPC836x
+	depends on UCC_GETH && PPC_MPC836x
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 700ebd7..625a9ab 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1722,7 +1722,7 @@ static void adjust_link(struct net_devic
 		if (mii_info->speed != ugeth->oldspeed) {
 			switch (mii_info->speed) {
 			case 1000:
-#ifdef CONFIG_MPC836x
+#ifdef CONFIG_PPC_MPC836x
 /* FIXME: This code is for 100Mbs BUG fixing,
 remove this when it is fixed!!! */
 				if (ugeth->ug_info->enet_interface ==
@@ -1768,7 +1768,7 @@ #endif				/* CONFIG_MPC8360 */
 				break;
 			case 100:
 			case 10:
-#ifdef CONFIG_MPC836x
+#ifdef CONFIG_PPC_MPC836x
 /* FIXME: This code is for 100Mbs BUG fixing,
 remove this lines when it will be fixed!!! */
 				ugeth->ug_info->enet_interface = ENET_100_RGMII;
@@ -3300,7 +3300,7 @@ static int ucc_geth_startup(ucc_geth_pri
 		l3qt = 0;
 		for (i = 0; i < 8; i++)
 			l3qt |= (ug_info->l3qt[j + i] << (28 - 4 * i));
-		out_be32(&ugeth->p_rx_glbl_pram->l3qt[j], l3qt);
+		out_be32(&ugeth->p_rx_glbl_pram->l3qt[j/8], l3qt);
 	}
 
 	/* vlantype */
diff --git a/drivers/net/ucc_geth_phy.c b/drivers/net/ucc_geth_phy.c
index f91028c..cc4fffb 100644
--- a/drivers/net/ucc_geth_phy.c
+++ b/drivers/net/ucc_geth_phy.c
@@ -638,7 +638,7 @@ static int dm9161_ack_interrupt(struct u
 /* FIXME: This lines are for BUG fixing in the mpc8325.
 Remove this from here when it's fixed */
 	if (bcsr_regs == NULL)
-		bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+		bcsr_regs = get_bcsr();
 	bcsr_regs[14] |= 0x40;
 	ugphy_vdbg("%s: IN", __FUNCTION__);
 
@@ -654,7 +654,7 @@ static int dm9161_config_intr(struct uge
 /* FIXME: This lines are for BUG fixing in the mpc8325.
 Remove this from here when it's fixed */
 	if (bcsr_regs == NULL) {
-		bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+		bcsr_regs = get_bcsr();
 		bcsr_regs[14] &= ~0x40;
 	}
 	ugphy_vdbg("%s: IN", __FUNCTION__);
-- 
1.4.2.1
