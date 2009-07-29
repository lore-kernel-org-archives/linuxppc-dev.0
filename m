Return-Path: <LeoLi@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB404B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 18:19:52 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 633C1DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 18:19:51 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6T8JZuX014277
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 01:19:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n6T8JkjE016704
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 03:19:47 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: davem@davemloft.net
Subject: [PATCH] gianfar: fix coalescing setup in ethtool support 
Date: Wed, 29 Jul 2009 16:51:57 +0800
Message-Id: <1248857517-8270-1-git-send-email-leoli@freescale.com>
Cc: netdev@vger.kernel.org, Jiajun Wu <b06378@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiajun Wu <b06378@freescale.com>

Parameter order for using mk_ic_value(count, time) was reversed,
the patch fixes this.

Signed-off-by: Jiajun Wu <b06378@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/gianfar_ethtool.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 2a7edfa..3109f4b 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -373,9 +373,8 @@ static int gfar_scoalesce(struct net_device *dev, struct ethtool_coalesce *cvals
 		return -EINVAL;
 	}
 
-	priv->rxic = mk_ic_value(
-		gfar_usecs2ticks(priv, cvals->rx_coalesce_usecs),
-		cvals->rx_max_coalesced_frames);
+	priv->rxic = mk_ic_value(cvals->rx_max_coalesced_frames,
+		gfar_usecs2ticks(priv, cvals->rx_coalesce_usecs));
 
 	/* Set up tx coalescing */
 	if ((cvals->tx_coalesce_usecs == 0) ||
@@ -397,9 +396,8 @@ static int gfar_scoalesce(struct net_device *dev, struct ethtool_coalesce *cvals
 		return -EINVAL;
 	}
 
-	priv->txic = mk_ic_value(
-		gfar_usecs2ticks(priv, cvals->tx_coalesce_usecs),
-		cvals->tx_max_coalesced_frames);
+	priv->txic = mk_ic_value(cvals->tx_max_coalesced_frames,
+		gfar_usecs2ticks(priv, cvals->tx_coalesce_usecs));
 
 	gfar_write(&priv->regs->rxic, 0);
 	if (priv->rxcoalescing)
-- 
1.5.6.3
