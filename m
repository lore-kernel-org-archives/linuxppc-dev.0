Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 13710B7D27
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 05:19:01 +1100 (EST)
Date: Wed, 3 Mar 2010 21:18:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] gianfar: Fix TX ring processing on SMP machines
Message-ID: <20100303181858.GA458@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Martyn Welch <martyn.welch@ge.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Starting with commit a3bc1f11e9b867a4f49505 ("gianfar: Revive SKB
recycling") gianfar driver sooner or later stops transmitting any
packets on SMP machines.

start_xmit() prepares new skb for transmitting, generally it does
three things:

1. sets up all BDs (marks them ready to send), except the first one.
2. stores skb into tx_queue->tx_skbuff so that clean_tx_ring()
   would cleanup it later.
3. sets up the first BD, i.e. marks it ready.

Here is what clean_tx_ring() does:

1. reads skbs from tx_queue->tx_skbuff
2. checks if the *last* BD is ready. If it's still ready [to send]
   then it it isn't transmitted, so clean_tx_ring() returns.
   Otherwise it actually cleanups BDs. All is OK.

Now, if there is just one BD, code flow:

- start_xmit(): stores skb into tx_skbuff. Note that the first BD
  (which is also the last one) isn't marked as ready, yet.
- clean_tx_ring(): sees that skb is not null, *and* its lstatus
  says that it is NOT ready (like if BD was sent), so it cleans
  it up (bad!)
- start_xmit(): marks BD as ready [to send], but it's too late.

We can fix this simply by reordering lstatus/tx_skbuff writes.

Reported-by: Martyn Welch <martyn.welch@ge.com>
Bisected-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Tested-by: Martyn Welch <martyn.welch@ge.com>
Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>
Cc: Stable <stable@vger.kernel.org> [2.6.33]
---
 drivers/net/gianfar.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 8bd3c9f..cccb409 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -2021,7 +2021,6 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* setup the TxBD length and buffer pointer for the first BD */
-	tx_queue->tx_skbuff[tx_queue->skb_curtx] = skb;
 	txbdp_start->bufPtr = dma_map_single(&priv->ofdev->dev, skb->data,
 			skb_headlen(skb), DMA_TO_DEVICE);
 
@@ -2053,6 +2052,10 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	txbdp_start->lstatus = lstatus;
 
+	eieio(); /* force lstatus write before tx_skbuff */
+
+	tx_queue->tx_skbuff[tx_queue->skb_curtx] = skb;
+
 	/* Update the current skb pointer to the next entry we will use
 	 * (wrapping if necessary) */
 	tx_queue->skb_curtx = (tx_queue->skb_curtx + 1) &
-- 
1.7.0
