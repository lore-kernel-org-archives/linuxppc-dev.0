Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 0204D2C064
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 04:54:43 +1100 (EST)
Date: Tue, 7 Dec 2004 10:54:39 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: jgarzik@pobox.com
Message-ID: <20041207105439.D13540@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][EMAC] Add netpoll support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add netpoll support to the EMAC driver.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== drivers/net/ibm_emac/ibm_emac_core.c 1.5 vs edited =====
--- 1.5/drivers/net/ibm_emac/ibm_emac_core.c	2004-12-03 00:25:48 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_core.c	2004-12-07 10:06:23 -07:00
@@ -1700,6 +1700,15 @@
 	.rxde = &emac_rxde_dev,
 };
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static int emac_netpoll(struct net_device *ndev)
+{
+	emac_rxeob_dev((void *)ndev, 0);
+	emac_txeob_dev((void *)ndev, 0);
+	return 0;
+}
+#endif
+
 static int emac_init_device(struct ocp_device *ocpdev, struct ibm_ocp_mal *mal)
 {
 	int deferred_init = 0;
@@ -1882,6 +1891,9 @@
 	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);
 	if (emacdata->tah_idx >= 0)
 		ndev->features = NETIF_F_IP_CSUM | NETIF_F_SG;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	ndev->poll_controller = emac_netpoll;
+#endif
 
 	SET_MODULE_OWNER(ndev);
 
