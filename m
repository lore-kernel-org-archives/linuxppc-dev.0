Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 008C46887F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 23:34:22 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: ebs@ebshome.net
Content-Type: multipart/mixed; boundary="=-tdsJvyrRFoqmxXyo9r8q"
Date: Thu, 08 Dec 2005 15:34:15 +0300
Message-Id: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Netpoll controller support for PPC EMAC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-tdsJvyrRFoqmxXyo9r8q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds netpoll controller support for PPC EMAC driver

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>




--=-tdsJvyrRFoqmxXyo9r8q
Content-Disposition: attachment; filename=ppc_emac_napi_netpoll.patch
Content-Type: text/x-patch; name=ppc_emac_napi_netpoll.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch adds netpoll controller support for PPC EMAC driver

---
commit a482261f165edb7e6af363d13ea94e8e7429f085
tree b5bee5eb8a971c3f40867946225051e1ff320763
parent e4f5c82a92c2a546a16af1614114eec19120e40a
author Ruslan V. Sushko <rsushko@ru.mvista.com> Thu, 08 Dec 2005 15:22:38 +0300
committer Ruslan V. Sushko <rsushko@ru.mvista.com> Thu, 08 Dec 2005 15:22:38 +0300

 drivers/net/ibm_emac/ibm_emac_core.c |   42 +++++++++++++++++++++++++++++++++-
 drivers/net/ibm_emac/ibm_emac_mal.c  |   14 -----------
 drivers/net/ibm_emac/ibm_emac_mal.h  |   12 ++++++++++
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -1071,8 +1071,16 @@ static int emac_start_xmit(struct sk_buf
 	struct ocp_enet_private *dev = ndev->priv;
 	unsigned int len = skb->len;
 	int slot;
+	u16 ctrl;
 
-	u16 ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	if (unlikely(dev->tx_cnt == NUM_TX_BUFF)) {
+		netif_stop_queue(ndev);
+		return -EBUSY;
+	}
+#endif
+
+	ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
 	    MAL_TX_CTRL_LAST | emac_tx_csum(dev, skb);
 
 	slot = dev->tx_slot++;
@@ -1938,6 +1946,33 @@ static int emac_ioctl(struct net_device 
 		return -EOPNOTSUPP;
 	}
 }
+#ifdef CONFIG_NET_POLL_CONTROLLER
+void
+poll_ctrl(struct net_device *dev)
+{
+	int budget = 16;
+	struct ibm_ocp_mal *mal = ((struct ocp_enet_private*)(dev->priv))->mal;
+	struct net_device *poll_dev = &(mal->poll_dev);
+
+	/* disable  MAL interrupts */
+	mal_disable_eob_irq(mal);
+	netif_poll_disable(poll_dev);
+
+	emac_poll_rx(dev->priv, budget);
+	emac_poll_tx(dev->priv);
+
+	netif_poll_enable(poll_dev);
+	/* Enable mal interrupts */
+	mal_enable_eob_irq(mal);
+}
+
+int
+poll_fake(struct net_device *dev, int *budget)
+{
+	/* It will be never invoked */
+	return 0;
+}
+#endif
 
 static int __init emac_probe(struct ocp_device *ocpdev)
 {
@@ -2188,6 +2223,11 @@ static int __init emac_probe(struct ocp_
 	netif_carrier_off(ndev);
 	netif_stop_queue(ndev);
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	ndev->poll_controller = poll_ctrl;
+	ndev->poll = poll_fake;
+#endif
+
 	err = register_netdev(ndev);
 	if (err) {
 		printk(KERN_ERR "emac%d: failed to register net device (%d)!\n",
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.c b/drivers/net/ibm_emac/ibm_emac_mal.c
--- a/drivers/net/ibm_emac/ibm_emac_mal.c
+++ b/drivers/net/ibm_emac/ibm_emac_mal.c
@@ -155,20 +155,6 @@ void mal_poll_del(struct ibm_ocp_mal *ma
 	local_bh_enable();
 }
 
-/* synchronized by mal_poll() */
-static inline void mal_enable_eob_irq(struct ibm_ocp_mal *mal)
-{
-	MAL_DBG2("%d: enable_irq" NL, mal->def->index);
-	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) | MAL_CFG_EOPIE);
-}
-
-/* synchronized by __LINK_STATE_RX_SCHED bit in ndev->state */
-static inline void mal_disable_eob_irq(struct ibm_ocp_mal *mal)
-{
-	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) & ~MAL_CFG_EOPIE);
-	MAL_DBG2("%d: disable_irq" NL, mal->def->index);
-}
-
 static irqreturn_t mal_serr(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ibm_ocp_mal *mal = dev_instance;
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -216,6 +216,18 @@ static inline void set_mal_dcrn(struct i
 	mtdcr(mal->dcrbase + reg, val);
 }
 
+/* synchronized by mal_poll() */
+static inline void mal_enable_eob_irq(struct ibm_ocp_mal *mal)
+{
+	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) | MAL_CFG_EOPIE);
+}
+
+/* synchronized by __LINK_STATE_RX_SCHED bit in ndev->state */
+static inline void mal_disable_eob_irq(struct ibm_ocp_mal *mal)
+{
+	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) & ~MAL_CFG_EOPIE);
+}
+
 /* Register MAL devices */
 int mal_init(void) __init;
 void mal_exit(void) __exit;



!-------------------------------------------------------------flip-



--=-tdsJvyrRFoqmxXyo9r8q--
