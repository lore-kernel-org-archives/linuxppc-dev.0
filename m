Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id E6C37B7C8E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 02:47:53 +1100 (EST)
Date: Mon, 18 Jan 2010 18:47:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] ucc_geth: Fix full TX queue processing
Message-ID: <20100118154750.GA9224@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Wu Jiajun-B06378 <B06378@freescale.com>, lsorense@csclub.uwaterloo.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiajun Wu <b06378@freescale.com>

commit 7583605b6d29f1f7f6fc505b883328089f3485ad ("ucc_geth: Fix empty
TX queue processing") fixed empty TX queue mishandling, but didn't
account another corner case: when TX queue becomes full.

Without this patch the driver will stop transmiting when TX queue
becomes full since 'bd == ugeth->txBd[txQ]' actually checks for
two things: queue empty or full.

Let's better check for NULL skb, which unambiguously signals an empty
queue.

Signed-off-by: Jiajun Wu <b06378@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Stable <stable@vger.kernel.org> [2.6.32]
---

On Mon, Jan 11, 2010 at 07:52:26PM +0800, Wu Jiajun-B06378 wrote:
> Yes,'if (!skb)' is enough.
> You can reproduce transmitting stopping if you use
> 'if ((bd == ugeth->txBd[txQ])' and run ipforwarding with MTU=64
> 1Gbps 100%linerate.

OK, let's resend the patch with just !skb check?

 drivers/net/ucc_geth.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 96bdc0b..eb8fe7e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3279,13 +3279,12 @@ static int ucc_geth_tx(struct net_device *dev, u8 txQ)
 		/* Handle the transmitted buffer and release */
 		/* the BD to be used with the current frame  */
 
-		if (bd == ugeth->txBd[txQ]) /* queue empty? */
+		skb = ugeth->tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]];
+		if (!skb)
 			break;
 
 		dev->stats.tx_packets++;
 
-		skb = ugeth->tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]];
-
 		if (skb_queue_len(&ugeth->rx_recycle) < RX_BD_RING_LEN &&
 			     skb_recycle_check(skb,
 				    ugeth->ug_info->uf_info.max_rx_buf_length +
-- 
1.6.5.7
