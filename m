Return-Path: <Manfred.Rudigier@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 307CBB7CFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Apr 2010 19:10:15 +1000 (EST)
From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 9 Apr 2010 11:10:03 +0200
Subject: [PATCH v2 net-next 1/2] gianfar: Add hardware RX timestamping support
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E311B26A77@alice.at.omicron.at>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: 'Scott Wood' <scottwood@freescale.com>,
	"'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>, 'David
	Miller' <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device is configured to insert hardware timestamps into all
received packets. The RX timestamps are extracted from the padding
alingment bytes during the clean_rx_ring operation and copied into the
skb_shared_hwtstamps struct of the skb. This extraction only happens if
the rx_filter was set to something else than HWTSTAMP_FILTER_NONE with
the SIOCSHWTSTAMP ioctl command.

Hardware timestamping is only supported for eTSEC devices. To indicate
device support the new FSL_GIANFAR_DEV_HAS_TIMER flag was introduced.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
---
 drivers/net/gianfar.c |   66 +++++++++++++++++++++++++++++++++++++++++++++=
---
 drivers/net/gianfar.h |    5 +++
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 080d1ce..552e10d 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -82,6 +82,7 @@
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/in.h>
+#include <linux/net_tstamp.h>
=20
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -377,6 +378,13 @@ static void gfar_init_mac(struct net_device *ndev)
 		rctrl |=3D RCTRL_PADDING(priv->padding);
 	}
=20
+	/* Insert receive time stamps into padding alignment bytes */
+	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER) {
+		rctrl &=3D ~RCTRL_PAL_MASK;
+		rctrl |=3D RCTRL_PRSDEP_INIT | RCTRL_TS_ENABLE | RCTRL_PADDING(8);
+		priv->padding =3D 8;
+	}
+
 	/* keep vlan related bits if it's enabled */
 	if (priv->vlgrp) {
 		rctrl |=3D RCTRL_VLEX | RCTRL_PRSDEP_INIT;
@@ -501,7 +509,8 @@ void unlock_tx_qs(struct gfar_private *priv)
 /* Returns 1 if incoming frames use an FCB */
 static inline int gfar_uses_fcb(struct gfar_private *priv)
 {
-	return priv->vlgrp || priv->rx_csum_enable;
+	return priv->vlgrp || priv->rx_csum_enable ||
+		(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER);
 }
=20
 static void free_tx_pointers(struct gfar_private *priv)
@@ -742,7 +751,8 @@ static int gfar_of_init(struct of_device *ofdev, struct=
 net_device **pdev)
 			FSL_GIANFAR_DEV_HAS_CSUM |
 			FSL_GIANFAR_DEV_HAS_VLAN |
 			FSL_GIANFAR_DEV_HAS_MAGIC_PACKET |
-			FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
+			FSL_GIANFAR_DEV_HAS_EXTENDED_HASH |
+			FSL_GIANFAR_DEV_HAS_TIMER;
=20
 	ctype =3D of_get_property(np, "phy-connection-type", NULL);
=20
@@ -772,6 +782,38 @@ err_grp_init:
 	return err;
 }
=20
+static int gfar_hwtstamp_ioctl(struct net_device *netdev,
+			struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config config;
+	struct gfar_private *priv =3D netdev_priv(netdev);
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (config.flags)
+		return -EINVAL;
+
+	if (config.tx_type)
+		return -ERANGE;
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		priv->hwts_rx_en =3D 0;
+		break;
+	default:
+		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
+			return -ERANGE;
+		priv->hwts_rx_en =3D 1;
+		config.rx_filter =3D HWTSTAMP_FILTER_ALL;
+		break;
+	}
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
 /* Ioctl MII Interface */
 static int gfar_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
@@ -780,6 +822,9 @@ static int gfar_ioctl(struct net_device *dev, struct if=
req *rq, int cmd)
 	if (!netif_running(dev))
 		return -EINVAL;
=20
+	if (cmd =3D=3D SIOCSHWTSTAMP)
+		return gfar_hwtstamp_ioctl(dev, rq, cmd);
+
 	if (!priv->phydev)
 		return -ENODEV;
=20
@@ -982,7 +1027,8 @@ static int gfar_probe(struct of_device *ofdev,
 	else
 		priv->padding =3D 0;
=20
-	if (dev->features & NETIF_F_IP_CSUM)
+	if (dev->features & NETIF_F_IP_CSUM ||
+			priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
 		dev->hard_header_len +=3D GMAC_FCB_LEN;
=20
 	/* Program the isrg regs only if number of grps > 1 */
@@ -2474,6 +2520,17 @@ static int gfar_process_frame(struct net_device *dev=
, struct sk_buff *skb,
 		skb_pull(skb, amount_pull);
 	}
=20
+	/* Get receive timestamp from the skb */
+	if (priv->hwts_rx_en) {
+		struct skb_shared_hwtstamps *shhwtstamps =3D skb_hwtstamps(skb);
+		u64 *ns =3D (u64 *) skb->data;
+		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+		shhwtstamps->hwtstamp =3D ns_to_ktime(*ns);
+	}
+
+	if (priv->padding)
+		skb_pull(skb, priv->padding);
+
 	if (priv->rx_csum_enable)
 		gfar_rx_checksum(skb, fcb);
=20
@@ -2510,8 +2567,7 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queu=
e, int rx_work_limit)
 	bdp =3D rx_queue->cur_rx;
 	base =3D rx_queue->rx_bd_base;
=20
-	amount_pull =3D (gfar_uses_fcb(priv) ? GMAC_FCB_LEN : 0) +
-		priv->padding;
+	amount_pull =3D (gfar_uses_fcb(priv) ? GMAC_FCB_LEN : 0);
=20
 	while (!((bdp->status & RXBD_EMPTY) || (--rx_work_limit < 0))) {
 		struct sk_buff *newskb;
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 17d25e7..1ea287c 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -262,6 +262,7 @@ extern const char gfar_driver_version[];
=20
 #define next_bd(bdp, base, ring_size) skip_bd(bdp, 1, base, ring_size)
=20
+#define RCTRL_TS_ENABLE 	0x01000000
 #define RCTRL_PAL_MASK		0x001f0000
 #define RCTRL_VLEX		0x00002000
 #define RCTRL_FILREN		0x00001000
@@ -885,6 +886,7 @@ struct gfar {
 #define FSL_GIANFAR_DEV_HAS_MAGIC_PACKET	0x00000100
 #define FSL_GIANFAR_DEV_HAS_BD_STASHING		0x00000200
 #define FSL_GIANFAR_DEV_HAS_BUF_STASHING	0x00000400
+#define FSL_GIANFAR_DEV_HAS_TIMER		0x00000800
=20
 #if (MAXGROUPS =3D=3D 2)
 #define DEFAULT_MAPPING 	0xAA
@@ -1100,6 +1102,9 @@ struct gfar_private {
=20
 	/* Network Statistics */
 	struct gfar_extra_stats extra_stats;
+
+	/* HW time stamping enabled flag */
+	int hwts_rx_en;
 };
=20
 extern unsigned int ftp_rqfpr[MAX_FILER_IDX + 1];
--=20
1.6.3.3
