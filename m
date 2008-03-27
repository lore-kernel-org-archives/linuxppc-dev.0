Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C27D3DE3AE
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:06 +1100 (EST)
Message-ID: <47EAECC3.1030200@am.sony.com>
Date: Wed, 26 Mar 2008 17:39:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 6/6] PS3: Gelic network driver Wake-on-LAN support
References: <20080327001821.827672589@am.sony.com>
In-Reply-To: <20080327001821.827672589@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masakazu Mokuno <mokuno@sm.sony.co.jp>

Add Wake-on-LAN support to the PS3 Gelic network driver.
Other OS WOL support was introduced in PS3 system firmware
2.20.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/net/ps3_gelic_net.c |   81 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ps3_gelic_net.h |   20 ++++++++++
 2 files changed, 101 insertions(+)

--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -1266,6 +1266,85 @@ int gelic_net_set_rx_csum(struct net_dev
 	return 0;
 }
 
+static void gelic_net_get_wol(struct net_device *netdev,
+			      struct ethtool_wolinfo *wol)
+{
+	if (0 <= ps3_compare_firmware_version(2, 2, 0))
+		wol->supported = WAKE_MAGIC;
+	else
+		wol->supported = 0;
+
+	wol->wolopts = ps3_sys_manager_get_wol() ? wol->supported : 0;
+	memset(&wol->sopass, 0, sizeof(wol->sopass));
+}
+static int gelic_net_set_wol(struct net_device *netdev,
+			     struct ethtool_wolinfo *wol)
+{
+	int status;
+	struct gelic_card *card;
+	u64 v1, v2;
+
+	if (ps3_compare_firmware_version(2, 2, 0) < 0 ||
+	    !capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (wol->wolopts & ~WAKE_MAGIC)
+		return -EINVAL;
+
+	card = netdev_card(netdev);
+	if (wol->wolopts & WAKE_MAGIC) {
+		status = lv1_net_control(bus_id(card), dev_id(card),
+					 GELIC_LV1_SET_WOL,
+					 GELIC_LV1_WOL_MAGIC_PACKET,
+					 0, GELIC_LV1_WOL_MP_ENABLE,
+					 &v1, &v2);
+		if (status) {
+			pr_info("%s: enabling WOL failed %d\n", __func__,
+				status);
+			status = -EIO;
+			goto done;
+		}
+		status = lv1_net_control(bus_id(card), dev_id(card),
+					 GELIC_LV1_SET_WOL,
+					 GELIC_LV1_WOL_ADD_MATCH_ADDR,
+					 0, GELIC_LV1_WOL_MATCH_ALL,
+					 &v1, &v2);
+		if (!status)
+			ps3_sys_manager_set_wol(1);
+		else {
+			pr_info("%s: enabling WOL filter failed %d\n",
+				__func__, status);
+			status = -EIO;
+		}
+	} else {
+		status = lv1_net_control(bus_id(card), dev_id(card),
+					 GELIC_LV1_SET_WOL,
+					 GELIC_LV1_WOL_MAGIC_PACKET,
+					 0, GELIC_LV1_WOL_MP_DISABLE,
+					 &v1, &v2);
+		if (status) {
+			pr_info("%s: disabling WOL failed %d\n", __func__,
+				status);
+			status = -EIO;
+			goto done;
+		}
+		status = lv1_net_control(bus_id(card), dev_id(card),
+					 GELIC_LV1_SET_WOL,
+					 GELIC_LV1_WOL_DELETE_MATCH_ADDR,
+					 0, GELIC_LV1_WOL_MATCH_ALL,
+					 &v1, &v2);
+		if (!status)
+			ps3_sys_manager_set_wol(0);
+		else {
+			pr_info("%s: removing WOL filter failed %d\n",
+				__func__, status);
+			status = -EIO;
+		}
+	}
+done:
+	return status;
+}
+
 static struct ethtool_ops gelic_ether_ethtool_ops = {
 	.get_drvinfo	= gelic_net_get_drvinfo,
 	.get_settings	= gelic_ether_get_settings,
@@ -1274,6 +1353,8 @@ static struct ethtool_ops gelic_ether_et
 	.set_tx_csum	= ethtool_op_set_tx_csum,
 	.get_rx_csum	= gelic_net_get_rx_csum,
 	.set_rx_csum	= gelic_net_set_rx_csum,
+	.get_wol	= gelic_net_get_wol,
+	.set_wol	= gelic_net_set_wol,
 };
 
 /**
--- a/drivers/net/ps3_gelic_net.h
+++ b/drivers/net/ps3_gelic_net.h
@@ -182,12 +182,32 @@ enum gelic_lv1_net_control_code {
 	GELIC_LV1_GET_ETH_PORT_STATUS	= 2,
 	GELIC_LV1_SET_NEGOTIATION_MODE	= 3,
 	GELIC_LV1_GET_VLAN_ID		= 4,
+	GELIC_LV1_SET_WOL		= 5,
 	GELIC_LV1_GET_CHANNEL           = 6,
 	GELIC_LV1_POST_WLAN_CMD		= 9,
 	GELIC_LV1_GET_WLAN_CMD_RESULT	= 10,
 	GELIC_LV1_GET_WLAN_EVENT	= 11
 };
 
+/* for GELIC_LV1_SET_WOL */
+enum gelic_lv1_wol_command {
+	GELIC_LV1_WOL_MAGIC_PACKET	= 1,
+	GELIC_LV1_WOL_ADD_MATCH_ADDR	= 6,
+	GELIC_LV1_WOL_DELETE_MATCH_ADDR	= 7,
+};
+
+/* for GELIC_LV1_WOL_MAGIC_PACKET */
+enum gelic_lv1_wol_mp_arg {
+	GELIC_LV1_WOL_MP_DISABLE	= 0,
+	GELIC_LV1_WOL_MP_ENABLE		= 1,
+};
+
+/* for GELIC_LV1_WOL_{ADD,DELETE}_MATCH_ADDR */
+enum gelic_lv1_wol_match_arg {
+	GELIC_LV1_WOL_MATCH_INDIVIDUAL	= 0,
+	GELIC_LV1_WOL_MATCH_ALL		= 1,
+};
+
 /* status returened from GET_ETH_PORT_STATUS */
 enum gelic_lv1_ether_port_status {
 	GELIC_LV1_ETHER_LINK_UP		= 0x0000000000000001L,

-- 
