Return-Path: <Manfred.Rudigier@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD77CB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 20:24:05 +1000 (EST)
From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
To: "'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>
Date: Wed, 7 Apr 2010 11:46:08 +0200
Subject: [RFC PATCH net-next 1/4] gianfar: Added stub support for SIOCSHWTSTAMP
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E311A9F4DF@alice.at.omicron.at>
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

This ioctl command is required for enabling hardware time stamping support
for network packets, see Documentation/networking/timestamping.txt. At the
moment nothing will be done for all requests that enable time stamping and
thus ERANGE will be returned.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
---
 drivers/net/gianfar.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 080d1ce..309bab0 100644
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
@@ -772,6 +773,38 @@ err_grp_init:
 	return err;
 }
=20
+static int gfar_hwtstamp_ioctl(struct net_device *netdev,
+			struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (config.flags)
+		return -EINVAL;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+	case HWTSTAMP_TX_ON:
+		return -ERANGE;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
 /* Ioctl MII Interface */
 static int gfar_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
@@ -780,6 +813,9 @@ static int gfar_ioctl(struct net_device *dev, struct if=
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
--=20
1.6.3.3
