Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29C96DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 02:05:45 +1000 (EST)
To: Jeff Garzik <jeff@garzik.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/2] [FS_ENET] Add polling support
Date: Tue, 18 Sep 2007 20:05:35 +0400
Message-ID: <20070918160535.13525.28254.stgit@localhost.localdomain>
In-Reply-To: <20070918160527.13525.80935.stgit@localhost.localdomain>
References: <20070918160527.13525.80935.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 drivers/net/fs_enet/fs_enet-main.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)


diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 927cd9e..0e2d2b2 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -61,6 +61,9 @@ module_param(fs_enet_debug, int, 0);
 MODULE_PARM_DESC(fs_enet_debug,
 		 "Freescale bitmapped debugging message enable value");
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fs_enet_netpoll(struct net_device *dev);
+#endif
 
 static void fs_set_multicast_list(struct net_device *dev)
 {
@@ -1049,6 +1052,10 @@ static struct net_device *fs_init_instance(struct device *dev,
 	ndev->stop = fs_enet_close;
 	ndev->get_stats = fs_enet_get_stats;
 	ndev->set_multicast_list = fs_set_multicast_list;
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+       ndev->poll_controller = fs_enet_netpoll;
+#endif
 	if (fpi->use_napi) {
 		ndev->poll = fs_enet_rx_napi;
 		ndev->weight = fpi->napi_weight;
@@ -1275,6 +1282,15 @@ static void __exit fs_cleanup(void)
 	cleanup_immap();
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fs_enet_netpoll(struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       fs_enet_interrupt(dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+#endif
+
 /**************************************************************************************/
 
 module_init(fs_init);
