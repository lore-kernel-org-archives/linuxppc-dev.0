Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A59F367CB4
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:39:38 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8TBxZfY011763
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:59:35 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8TAdYsg023974
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:39:36 -0500 (CDT)
Message-ID: <451CF80D.10605@freescale.com>
Date: Fri, 29 Sep 2006 18:40:13 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update for ucc_geth driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
index a2bd811..e0bd799 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2258,7 +2258,7 @@ config UGETH_TX_ON_DEMOND
 
 config UGETH_HAS_GIGA
 	bool
-	depends on UCC_GETH && MPC836x
+	depends on UCC_GETH && PPC_MPC836x
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 47f49ef..6ca380b 100644
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
@@ -3302,7 +3302,7 @@ static int ucc_geth_startup(ucc_geth_pri
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
