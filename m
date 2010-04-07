Return-Path: <Manfred.Rudigier@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75274B7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 20:24:14 +1000 (EST)
From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
To: "'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>
Date: Wed, 7 Apr 2010 11:46:38 +0200
Subject: [RFC PATCH net-next 3/4] gianfar: Added raw hardware receive time
	stamp generation
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E311A9F4E1@alice.at.omicron.at>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch configures the eTSEC to insert time stamps into all received
packets as padding alignment bytes. During the clean_rx_ring operation
these raw time stamps are extracted and copied into the
skb_shared_hwtstamps struct of the skb if required.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
---
 drivers/net/gianfar.c |   30 +++++++++++++++++++++++++-----
 drivers/net/gianfar.h |    1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 41e7726..9119879 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -378,6 +378,13 @@ static void gfar_init_mac(struct net_device *ndev)
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
@@ -502,7 +509,8 @@ void unlock_tx_qs(struct gfar_private *priv)
 /* Returns 1 if incoming frames use an FCB */
 static inline int gfar_uses_fcb(struct gfar_private *priv)
 {
-	return priv->vlgrp || priv->rx_csum_enable;
+	return priv->vlgrp || priv->rx_csum_enable ||
+		(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER);
 }
=20
 static void free_tx_pointers(struct gfar_private *priv)
@@ -808,7 +816,8 @@ static int gfar_hwtstamp_ioctl(struct net_device *netde=
v,
 		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
 			return -ERANGE;
 		priv->hwts_rx_en =3D 1;
-		return -ERANGE;
+		config.rx_filter =3D HWTSTAMP_FILTER_ALL;
+		break;
 	}
=20
 	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
@@ -1028,7 +1037,8 @@ static int gfar_probe(struct of_device *ofdev,
 	else
 		priv->padding =3D 0;
=20
-	if (dev->features & NETIF_F_IP_CSUM)
+	if (dev->features & NETIF_F_IP_CSUM ||
+			priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
 		dev->hard_header_len +=3D GMAC_FCB_LEN;
=20
 	/* Program the isrg regs only if number of grps > 1 */
@@ -2520,6 +2530,17 @@ static int gfar_process_frame(struct net_device *dev=
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
@@ -2556,8 +2577,7 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queu=
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
index 380ea48..cba2756 100644
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
--=20
1.6.3.3
