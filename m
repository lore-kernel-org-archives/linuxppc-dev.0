Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 69772DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 20:54:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
Date: Fri, 14 Mar 2008 10:52:28 +0100
Message-Id: <1205488348-22536-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Pravin M. Bathija <pbathija@amcc.com>

Problem Description and Fix
---------------------------
When a pause packet(with destination as reserved Multicast address) is
received by the EMAC hardware to control the flow of frames being
transmitted by it, it is dropped by the hardware unless the reserved
Multicast address is hashed in to the GAHT[1-4] registers. This code fix
adds the default reserved multicast address to the GAHT[1-4] registers
in the EMAC(s) present on the chip. The flow control with Pause packets
will only work if the following register bits are programmed in EMAC:
EMACx_MR1[APP] = 1
EMACx_RMR[BAE] = 1
EMACx_RMR[MAE] = 1

Behavior that may be observed in a running system
-------------------------------------------------
A host transferring data from a PPC based system may send a Pause packet
to the PPC EMAC requesting it to slow down the flow of packets. If the
default reserved multicast MAC address is not programmed into the
GAHT[1-4] registers this Pause packet will be dropped by PPC EMAC and no
Flow Control will be done.

Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index e6c69f7..0789802 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -143,6 +143,10 @@ static inline void emac_report_timeout_error(struct emac_instance *dev,
 #define STOP_TIMEOUT_1000	13
 #define STOP_TIMEOUT_1000_JUMBO	73
 
+static unsigned char default_mcast_addr[] = {
+	0x01, 0x80, 0xC2, 0x00, 0x00, 0x01
+};
+
 /* Please, keep in sync with struct ibm_emac_stats/ibm_emac_error_stats */
 static const char emac_stats_keys[EMAC_ETHTOOL_STATS_COUNT][ETH_GSTRING_LEN] = {
 	"rx_packets", "rx_bytes", "tx_packets", "tx_bytes", "rx_packets_csum",
@@ -618,6 +622,9 @@ static int emac_configure(struct emac_instance *dev)
 	if (emac_phy_gpcs(dev->phy.mode))
 		emac_mii_reset_phy(&dev->phy);
 
+	/* Required for Pause packet support in EMAC */
+	dev_mc_add(ndev, default_mcast_addr, sizeof(default_mcast_addr), 1);
+
 	return 0;
 }
 
-- 
1.5.4.4
