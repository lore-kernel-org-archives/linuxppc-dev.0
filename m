Return-Path: <Manfred.Rudigier@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A62F2B7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 20:24:10 +1000 (EST)
From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
To: "'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>
Date: Wed, 7 Apr 2010 11:46:24 +0200
Subject: [RFC PATCH net-next 2/4] gianfar: Added timer feature for eTSEC
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E311A9F4E0@alice.at.omicron.at>
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

The timer clock module is an intrinsic feature of every eTSEC. It supports
hardware time stamping of all incoming and outgoing network packets. This
patch checks if the underlying hardware is an eTSEC and adds the
new FSL_GIANFAR_DEV_HAS_TIMER flag to the device flags. This flag is then
used in the SIOCSHWTSTAMP ioctl command to determine if HW time stamping
support is available.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
---
 drivers/net/gianfar.c |   12 +++++++++++-
 drivers/net/gianfar.h |    3 +++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 309bab0..41e7726 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -743,7 +743,8 @@ static int gfar_of_init(struct of_device *ofdev, struct=
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
@@ -777,6 +778,7 @@ static int gfar_hwtstamp_ioctl(struct net_device *netde=
v,
 			struct ifreq *ifr, int cmd)
 {
 	struct hwtstamp_config config;
+	struct gfar_private *priv =3D netdev_priv(netdev);
=20
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
@@ -787,8 +789,12 @@ static int gfar_hwtstamp_ioctl(struct net_device *netd=
ev,
=20
 	switch (config.tx_type) {
 	case HWTSTAMP_TX_OFF:
+		priv->hwts_tx_en =3D 0;
 		break;
 	case HWTSTAMP_TX_ON:
+		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
+			return -ERANGE;
+		priv->hwts_tx_en =3D 1;
 		return -ERANGE;
 	default:
 		return -ERANGE;
@@ -796,8 +802,12 @@ static int gfar_hwtstamp_ioctl(struct net_device *netd=
ev,
=20
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
+		priv->hwts_rx_en =3D 0;
 		break;
 	default:
+		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
+			return -ERANGE;
+		priv->hwts_rx_en =3D 1;
 		return -ERANGE;
 	}
=20
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 17d25e7..380ea48 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -885,6 +885,7 @@ struct gfar {
 #define FSL_GIANFAR_DEV_HAS_MAGIC_PACKET	0x00000100
 #define FSL_GIANFAR_DEV_HAS_BD_STASHING		0x00000200
 #define FSL_GIANFAR_DEV_HAS_BUF_STASHING	0x00000400
+#define FSL_GIANFAR_DEV_HAS_TIMER		0x00000800
=20
 #if (MAXGROUPS =3D=3D 2)
 #define DEFAULT_MAPPING 	0xAA
@@ -1084,6 +1085,8 @@ struct gfar_private {
 		extended_hash:1,
 		bd_stash_en:1,
 		rx_filer_enable:1,
+		hwts_tx_en:1, /* HW time stamping enabled for TX packets */
+		hwts_rx_en:1, /* HW time stamping enabled for RX packets */
 		wol_en:1; /* Wake-on-LAN enabled */
 	unsigned short padding;
=20
--=20
1.6.3.3
