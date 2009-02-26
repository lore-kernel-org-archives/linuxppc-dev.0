Return-Path: <rini@arvoo.nl>
Received: from smtp3.euronet.nl (smtp3.euronet.nl [194.134.35.173])
	by ozlabs.org (Postfix) with ESMTP id 34FF3DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 21:25:58 +1100 (EST)
Message-ID: <49A66E2D.3060204@arvoo.nl>
Date: Thu, 26 Feb 2009 11:25:49 +0100
From: Rini van Zetten <rini@arvoo.nl>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2 net] gianfar : Do right check on num_txbdfree
References: <49A6595A.9000405@arvoo.nl>
	<20090226.020318.50178027.davem@davemloft.net>
In-Reply-To: <20090226.020318.50178027.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a wrong check on num_txbdfree. It could lead to num_txbdfree become nagative.
Result was that the gianfar stops sending data.

Changes from first version :
- removed a space between parens (David Millers comment)
- full email address in signed off line


Signed-off-by: Rini van Zetten <rini@arvoo.nl>
---
  drivers/net/gianfar.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 7ef1ffd..2dc3bd3 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1284,9 +1284,8 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
      spin_lock_irqsave(&priv->txlock, flags);

      /* check if there is space to queue this packet */
-    if (nr_frags > priv->num_txbdfree) {
+    if ((nr_frags+1) > priv->num_txbdfree) {
          /* no space, stop the queue */
          netif_stop_queue(dev);
          dev->stats.tx_fifo_errors++;
          spin_unlock_irqrestore(&priv->txlock, flags);
-- 
