Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id AA054DDF0A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 06:29:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH 5/5] Tsi108_eth: Add ethtool support
Date: Fri, 8 Feb 2008 14:17:48 -0500
Message-ID: <1B5F013528140F45B5C671039279CA5702A960A5@NANUK.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: <jgarzik@pobox.com>, <netdev@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add ethtool support to tsi108_eth network driver.
=20=20=20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06
17:10:53.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
18:09:43.000000000 -0500
@@ -36,6 +36,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -1519,12 +1520,46 @@ static void tsi108_init_mac(struct net_d
 	TSI_WRITE(TSI108_EC_INTMASK, ~0);
 }
=20
+static int tsi108_get_settings(struct net_device *dev, struct
ethtool_cmd *cmd)
+{
+	struct tsi108_prv_data *data =3D netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+=09
+	spin_lock_irqsave(&data->txlock, flags);
+	rc =3D mii_ethtool_gset(&data->mii_if, cmd);
+	spin_unlock_irqrestore(&data->txlock, flags);
+
+	return rc;
+}
+
+static int tsi108_set_settings(struct net_device *dev, struct
ethtool_cmd *cmd)
+{
+	struct tsi108_prv_data *data =3D netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	rc =3D mii_ethtool_sset(&data->mii_if, cmd);
+	spin_unlock_irqrestore(&data->txlock, flags);
+=09
+	return rc;
+}
+
 static int tsi108_do_ioctl(struct net_device *dev, struct ifreq *rq,
int cmd)
 {
 	struct tsi108_prv_data *data =3D netdev_priv(dev);
+	if (!netif_running(dev))
+		return -EINVAL;
 	return generic_mii_ioctl(&data->mii_if, if_mii(rq), cmd, NULL);
 }
=20
+static const struct ethtool_ops tsi108_ethtool_ops =3D {
+	.get_link 	=3D ethtool_op_get_link,
+	.get_settings	=3D tsi108_get_settings,
+	.set_settings	=3D tsi108_set_settings,
+};
+
 static int
 tsi108_init_one(struct platform_device *pdev)
 {
@@ -1589,6 +1624,7 @@ tsi108_init_one(struct platform_device *
 	dev->get_stats =3D tsi108_get_stats;
 	netif_napi_add(dev, &data->napi, tsi108_poll, 64);
 	dev->do_ioctl =3D tsi108_do_ioctl;
+	dev->ethtool_ops =3D &tsi108_ethtool_ops;
=20
 	/* Apparently, the Linux networking code won't use
scatter-gather
 	 * if the hardware doesn't do checksums.  However, it's faster



---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D
