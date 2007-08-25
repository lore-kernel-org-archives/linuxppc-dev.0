Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5EE57DDDFB
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 04:32:59 +1000 (EST)
Date: Sat, 25 Aug 2007 20:32:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: [PATCH] bmac: add simple ethtool support for network manager
Message-ID: <20070825183259.GA14478@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


NetworkManager will not start dhcpd on an interface unless it reports
link-up state via ethtool.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/net/bmac.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/bmac.c
+++ b/drivers/net/bmac.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/crc32.h>
 #include <linux/bitrev.h>
+#include <linux/ethtool.h>
 #include <asm/prom.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
@@ -1246,6 +1247,17 @@ static void bmac_reset_and_enable(struct
 	}
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
+static void bmac_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct bmac_data *bp = netdev_priv(dev);
+	strcpy(info->driver, "bmac");
+	strcpy(info->bus_info, bp->mdev->ofdev.dev.bus_id);
+}
+
+static const struct ethtool_ops bmac_ethtool_ops = {
+	.get_drvinfo		= bmac_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+};
 
 static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
@@ -1311,6 +1323,7 @@ static int __devinit bmac_probe(struct m
 
 	dev->open = bmac_open;
 	dev->stop = bmac_close;
+	dev->ethtool_ops = &bmac_ethtool_ops;
 	dev->hard_start_xmit = bmac_output;
 	dev->get_stats = bmac_stats;
 	dev->set_multicast_list = bmac_set_multicast;
