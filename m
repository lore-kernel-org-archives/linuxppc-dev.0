Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7534CDDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 01:34:47 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6IFYgaW1563088
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:34:42 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6IFYgtU2060438
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 17:34:42 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6IFYPcD031051
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 17:34:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] eHEA: Fix bonding support
Date: Wed, 18 Jul 2007 17:34:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707181734.09278.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver didn't allow an interface's MAC address to be modified if the
respective interface wasn't setup - a failing Hcall was the result. Thus
bonding wasn't usable. The fix moves the failing Hcall which was registering
a MAC address for the reception of BC packets in firmware from the port up
and down functions to the port resources setup functions. Additionally the
missing update of the last_rx member of the netdev structure was added.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   37 +++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 6628fa6..489c8b2 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0070"
+#define DRV_VERSION	"EHEA_0071"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 1d1571c..4c70a93 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -466,6 +466,8 @@ static struct ehea_cqe *ehea_proc_rwqes(struct net_device *dev,
 							 cqe->vlan_tag);
 			else
 				netif_receive_skb(skb);
+
+			dev->last_rx = jiffies;
 		} else {
 			pr->p_stats.poll_receive_errors++;
 			port_reset = ehea_treat_poll_error(pr, rq, cqe,
@@ -1433,7 +1435,8 @@ static int ehea_broadcast_reg_helper(struct ehea_port *port, u32 hcallid)
 				     port->logical_port_id,
 				     reg_type, port->mac_addr, 0, hcallid);
 	if (hret != H_SUCCESS) {
-		ehea_error("reg_dereg_bcmc failed (tagged)");
+		ehea_error("%sregistering bc address failed (tagged)",
+                           hcallid == H_REG_BCMC ? "" : "de");
 		ret = -EIO;
 		goto out_herr;
 	}
@@ -1444,7 +1447,8 @@ static int ehea_broadcast_reg_helper(struct ehea_port *port, u32 hcallid)
 				     port->logical_port_id,
 				     reg_type, port->mac_addr, 0, hcallid);
 	if (hret != H_SUCCESS) {
-		ehea_error("reg_dereg_bcmc failed (vlan)");
+		ehea_error("%sregistering bc address failed (vlan)",
+			   hcallid == H_REG_BCMC ? "" : "de");
 		ret = -EIO;
 	}
 out_herr:
@@ -2170,7 +2174,6 @@ static int ehea_up(struct net_device *dev)
 {
 	int ret, i;
 	struct ehea_port *port = netdev_priv(dev);
-	u64 mac_addr = 0;
 
 	if (port->state == EHEA_PORT_UP)
 		return 0;
@@ -2189,18 +2192,10 @@ static int ehea_up(struct net_device *dev)
 		goto out_clean_pr;
 	}
 
-	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
-	if (ret) {
-		ret = -EIO;
-		ehea_error("out_clean_pr");
-		goto out_clean_pr;
-	}
-	mac_addr = (*(u64*)dev->dev_addr) >> 16;
-
 	ret = ehea_reg_interrupts(dev);
 	if (ret) {
-		ehea_error("out_dereg_bc");
-		goto out_dereg_bc;
+		ehea_error("reg_interrupts failed. ret:%d", ret);
+		goto out_clean_pr;
 	}
 
 	for(i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
@@ -2226,9 +2221,6 @@ static int ehea_up(struct net_device *dev)
 out_free_irqs:
 	ehea_free_interrupts(dev);
 
-out_dereg_bc:
-	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
-
 out_clean_pr:
 	ehea_clean_all_portres(port);
 out:
@@ -2273,7 +2265,6 @@ static int ehea_down(struct net_device *dev)
 				&port->port_res[i].d_netdev->state))
 			msleep(1);
 
-	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
 	port->state = EHEA_PORT_DOWN;
 
 	ret = ehea_clean_all_portres(port);
@@ -2655,12 +2646,18 @@ struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 
 	INIT_WORK(&port->reset_task, ehea_reset_port);
 
+	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+	if (ret) {
+		ret = -EIO;
+		goto out_unreg_port;
+	}
+
 	ehea_set_ethtool_ops(dev);
 
 	ret = register_netdev(dev);
 	if (ret) {
 		ehea_error("register_netdev failed. ret=%d", ret);
-		goto out_unreg_port;
+		goto out_dereg_bc;
 	}
 
 	ret = ehea_get_jumboframe_status(port, &jumbo);
@@ -2675,6 +2672,9 @@ struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 
 	return port;
 
+out_dereg_bc:
+	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+
 out_unreg_port:
 	ehea_unregister_port(port);
 
@@ -2694,6 +2694,7 @@ static void ehea_shutdown_single_port(struct ehea_port *port)
 {
 	unregister_netdev(port->netdev);
 	ehea_unregister_port(port);
+	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
 	kfree(port->mc_list);
 	free_netdev(port->netdev);
 	port->adapter->active_ports--;
-- 
1.5.2
