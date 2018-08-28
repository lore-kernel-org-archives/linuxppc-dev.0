Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205lh0HMpzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:44 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 6/6] net/wan/fsl_ucc_hdlc: tx timeout handler
Date: Tue, 28 Aug 2018 13:09:21 +0200
Message-Id: <20180828110921.2542-7-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-1-david.gounaris@infinera.com>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added tx timerout handler. This helps
when troubleshooting.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index e6154a6547e6..30f416bace2c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1001,11 +1001,15 @@ static const struct dev_pm_ops uhdlc_pm_ops = {
 #define HDLC_PM_OPS NULL
 
 #endif
+static void uhdlc_tx_timeout(struct net_device *ndev) {
+	netdev_err(ndev, "%s\n", __FUNCTION__);
+}
 static const struct net_device_ops uhdlc_ops = {
 	.ndo_open       = uhdlc_open,
 	.ndo_stop       = uhdlc_close,
 	.ndo_start_xmit = hdlc_start_xmit,
 	.ndo_do_ioctl   = uhdlc_ioctl,
+	.ndo_tx_timeout	= uhdlc_tx_timeout,
 };
 
 static int ucc_hdlc_probe(struct platform_device *pdev)
@@ -1121,6 +1125,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	hdlc = dev_to_hdlc(dev);
 	dev->tx_queue_len = 16;
 	dev->netdev_ops = &uhdlc_ops;
+	dev->watchdog_timeo = 2*HZ;
 	hdlc->attach = ucc_hdlc_attach;
 	hdlc->xmit = ucc_hdlc_tx;
 	netif_napi_add(dev, &uhdlc_priv->napi, ucc_hdlc_poll, 32);
-- 
2.13.6
