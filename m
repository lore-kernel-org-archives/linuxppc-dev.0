Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0785867B52
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 22:12:57 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7ICCqV5045066
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:12:52 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7ICEjbe107700
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 13:14:45 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7ICCpQR000546
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 13:12:52 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 4/7] ehea: ethtool interface
Date: Fri, 18 Aug 2006 13:33:22 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608181333.23031.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/ehea_ethtool.c |  264 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_ethtool.c	2006-08-18 00:01:02.841367875 -0700
@@ -0,0 +1,264 @@
+/*
+ *  linux/drivers/net/ehea/ehea_ethtool.c
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "ehea.h"
+#include "ehea_phyp.h"
+
+
+static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_4 *cb4 = NULL;
+
+	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if(!cb4) {
+		ehea_error("no mem for cb4");
+		goto get_settings_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB4,
+				      H_PORT_CB4_ALL,
+				      cb4);
+
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_port failed");
+		kfree(cb4);
+		goto get_settings_exit;
+	}
+
+	if (netif_msg_hw(port))
+		ehea_dump(cb4, sizeof(struct hcp_query_ehea_port_cb_4),
+			  "netdev_get_settings");
+
+	if (netif_carrier_ok(dev)) {
+		switch(cb4->port_speed){
+		case H_PORT_SPEED_10M_H:
+			cmd->speed = SPEED_10;
+			cmd->duplex = DUPLEX_HALF;
+			break;
+		case H_PORT_SPEED_10M_F:
+			cmd->speed = SPEED_10;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_100M_H:
+			cmd->speed = SPEED_100;
+			cmd->duplex = DUPLEX_HALF;
+			break;
+		case H_PORT_SPEED_100M_F:
+			cmd->speed = SPEED_100;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_1G_F:
+			cmd->speed = SPEED_1000;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_10G_F:
+			cmd->speed = SPEED_10000;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		}
+	} else {
+		cmd->speed = -1;
+		cmd->duplex = -1;
+	}
+
+	cmd->supported = (SUPPORTED_10000baseT_Full | SUPPORTED_1000baseT_Full
+		       | SUPPORTED_100baseT_Full |  SUPPORTED_100baseT_Half
+		       | SUPPORTED_10baseT_Full | SUPPORTED_10baseT_Half
+		       | SUPPORTED_Autoneg | SUPPORTED_FIBRE);
+
+	cmd->advertising = (ADVERTISED_10000baseT_Full | ADVERTISED_Autoneg
+			 | ADVERTISED_FIBRE);
+
+	cmd->port = PORT_FIBRE;
+	cmd->autoneg = AUTONEG_ENABLE;
+
+	kfree(cb4);
+	return 0;
+
+get_settings_exit:
+	return 1;
+}
+
+static void netdev_get_drvinfo(struct net_device *dev,
+			       struct ethtool_drvinfo *info)
+{
+	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
+	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
+}
+
+static u32 netdev_get_msglevel(struct net_device *dev)
+{
+	struct ehea_port *port = netdev_priv(dev);
+	return port->msg_enable;
+}
+
+static void netdev_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct ehea_port *port = netdev_priv(dev);
+	port->msg_enable = value;
+}
+
+static char ehea_ethtool_stats_keys[][ETH_GSTRING_LEN] = {
+	{"poll_max_processed"},
+	{"queue_stopped"},
+	{"min_swqe_avail"},
+	{"poll_receive_err"},
+	{"pkt_send"},
+	{"pkt_xmit"},
+	{"send_tasklet"},
+	{"ehea_poll"},
+	{"nwqe"},
+	{"swqe_available_0"},
+	{"rxo"},
+	{"rx64"},
+	{"rx65"},
+	{"rx128"},
+	{"rx256"},
+	{"rx512"},
+	{"rx1024"},
+	{"txo"},
+	{"tx64"},
+	{"tx65"},
+	{"tx128"},
+	{"tx256"},
+	{"tx512"},
+	{"tx1024"},
+};
+
+static void netdev_get_strings(struct net_device *dev,
+				     u32 stringset, u8 * data)
+{
+	switch (stringset) {
+	case ETH_SS_TEST:
+		break;
+	case ETH_SS_STATS:
+		memcpy(data, &ehea_ethtool_stats_keys,
+		       sizeof(ehea_ethtool_stats_keys));
+	}
+}
+
+static int netdev_get_stats_count(struct net_device *dev)
+{
+	return ARRAY_SIZE(ehea_ethtool_stats_keys);
+}
+
+static void netdev_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	int i = 0;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+	struct ehea_port_res *pr = &port->port_res[0];
+	struct port_state *p_state = &pr->p_state;
+	struct hcp_query_ehea_port_cb_6 *cb6 = NULL;
+
+	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if(!cb6) {
+		ehea_error("no mem for cb6");
+		goto stats_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB6,
+				      H_PORT_CB6_ALL,
+				      cb6);
+	if (hret != H_SUCCESS)
+		ehea_error("query_ehea_port failed");
+
+	if (netif_msg_hw(port))
+		ehea_dump(cb6, sizeof(struct hcp_query_ehea_port_cb_6),
+			  "netdev_get_ethtool_stats");
+
+	data[i++] = p_state->poll_max_processed;
+	data[i++] = p_state->queue_stopped;
+	data[i++] = p_state->min_swqe_avail;
+	data[i++] = p_state->poll_receive_errors;
+	data[i++] = p_state->pkt_send;
+	data[i++] = p_state->pkt_xmit;
+	data[i++] = p_state->send_tasklet;
+	data[i++] = p_state->ehea_poll;
+	data[i++] = p_state->nwqe;
+	data[i++] = atomic_read(&port->port_res[0].swqe_avail);
+
+	data[i++] = cb6->rxo;
+	data[i++] = cb6->rx64;
+	data[i++] = cb6->rx65;
+	data[i++] = cb6->rx128;
+	data[i++] = cb6->rx256;
+	data[i++] = cb6->rx512;
+	data[i++] = cb6->rx1024;
+	data[i++] = cb6->txo;
+	data[i++] = cb6->tx64;
+	data[i++] = cb6->tx65;
+	data[i++] = cb6->tx128;
+	data[i++] = cb6->tx256;
+	data[i++] = cb6->tx512;
+	data[i++] = cb6->tx1024;
+
+	kfree(cb6);
+stats_exit:
+	return;
+}
+
+struct ethtool_ops ehea_ethtool_ops = {
+	.get_settings = netdev_get_settings,
+	.get_drvinfo = netdev_get_drvinfo,
+	.get_msglevel = netdev_get_msglevel,
+	.set_msglevel = netdev_set_msglevel,
+        .get_link = ethtool_op_get_link,
+        .get_tx_csum = ethtool_op_get_tx_csum,
+	.set_tx_csum = ethtool_op_set_tx_csum,
+	.get_sg = ethtool_op_get_sg,
+	.set_sg = ethtool_op_set_sg,
+	.get_tso = ethtool_op_get_tso,
+	.set_tso = ethtool_op_set_tso,
+	.get_strings = netdev_get_strings,
+	.get_stats_count = netdev_get_stats_count,
+	.get_ethtool_stats = netdev_get_ethtool_stats,
+	.set_settings = NULL,
+	.nway_reset = NULL,
+	.get_pauseparam = NULL,
+	.set_pauseparam = NULL,
+	.get_rx_csum = NULL,
+	.set_rx_csum = NULL,
+	.phys_id = NULL,
+	.self_test = NULL,
+	.self_test_count = NULL
+};
+
+void ehea_set_ethtool_ops(struct net_device *netdev)
+{
+	SET_ETHTOOL_OPS(netdev, &ehea_ethtool_ops);
+}
