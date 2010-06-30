Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3F3FAB6F17
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 02:39:15 +1000 (EST)
Date: Wed, 30 Jun 2010 20:39:13 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2 2/3] gianfar: Implement workaround for eTSEC76 erratum
Message-ID: <20100630163913.GB23337@oksana.dev.rtsoft.ru>
References: <20100630163804.GA636@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100630163804.GA636@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	Manfred Rudigier <manfred.rudigier@omicron.at>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8313ECE says:

"For TOE=1 huge or jumbo frames, the data required to generate the
 checksum may exceed the 2500-byte threshold beyond which the controller
 constrains itself to one memory fetch every 256 eTSEC system clocks.

 This throttling threshold is supposed to trigger only when the
 controller has sufficient data to keep transmit active for the duration
 of the memory fetches. The state machine handling this threshold,
 however, fails to take large TOE frames into account. As a result,
 TOE=1 frames larger than 2500 bytes often see excess delays before start
 of transmission."

This patch implements the workaround as suggested by the errata
document, i.e.:

"Limit TOE=1 frames to less than 2500 bytes to avoid excess delays due to
 memory throttling.
 When using packets larger than 2700 bytes, it is recommended to turn TOE
 off."

To be sure, we limit the TOE frames to 2500 bytes, and do software
checksumming instead.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/net/gianfar.c |   19 +++++++++++++++++++
 drivers/net/gianfar.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 9abcb39..8ba2973 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -942,6 +942,11 @@ static void gfar_detect_errata(struct gfar_private *priv)
 			(pvr == 0x80861010 && (mod & 0xfff9) == 0x80c0))
 		priv->errata |= GFAR_ERRATA_74;
 
+	/* MPC8313 and MPC837x all rev */
+	if ((pvr == 0x80850010 && mod == 0x80b0) ||
+			(pvr == 0x80861010 && (mod & 0xfff9) == 0x80c0))
+		priv->errata |= GFAR_ERRATA_76;
+
 	if (priv->errata)
 		dev_info(dev, "enabled errata workarounds, flags: 0x%x\n",
 			 priv->errata);
@@ -2011,6 +2016,20 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int nr_frags, nr_txbds, length;
 	union skb_shared_tx *shtx;
 
+	/*
+	 * TOE=1 frames larger than 2500 bytes may see excess delays
+	 * before start of transmission.
+	 */
+	if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_76) &&
+			skb->ip_summed == CHECKSUM_PARTIAL &&
+			skb->len > 2500)) {
+		int ret;
+
+		ret = skb_checksum_help(skb);
+		if (ret)
+			return ret;
+	}
+
 	rq = skb->queue_mapping;
 	tx_queue = priv->tx_queue[rq];
 	txq = netdev_get_tx_queue(dev, rq);
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 0a0483c..c414374 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -1027,6 +1027,7 @@ struct gfar_priv_grp {
 
 enum gfar_errata {
 	GFAR_ERRATA_74		= 0x01,
+	GFAR_ERRATA_76		= 0x02,
 };
 
 /* Struct stolen almost completely (and shamelessly) from the FCC enet source
-- 
1.7.0.5
