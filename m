Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 2ACAFB7C00
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Dec 2009 02:31:04 +1100 (EST)
Date: Thu, 24 Dec 2009 18:31:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 1/3] ucc_geth: Fix empty TX queue processing
Message-ID: <20091224153103.GA1206@oksana.dev.rtsoft.ru>
References: <20091224153034.GA32535@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091224153034.GA32535@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following oops was seen with the ucc_geth driver:

 Unable to handle kernel paging request for data at address 0x00000058
 Faulting instruction address: 0xc024f2fc
 Oops: Kernel access of bad area, sig: 11 [#1]
 [...]
 NIP [c024f2fc] skb_recycle_check+0x14/0x100
 LR [e30aa0a4] ucc_geth_poll+0xd8/0x4e0 [ucc_geth_driver]
 Call Trace:
 [df857d50] [c000b03c] __ipipe_grab_irq+0x3c/0xa4 (unreliable)
 [df857d60] [e30aa0a4] ucc_geth_poll+0xd8/0x4e0 [ucc_geth_driver]
 [df857dd0] [c0258cf8] net_rx_action+0xf8/0x1b8
 [df857e10] [c0032a38] __do_softirq+0xb8/0x13c
 [df857e60] [c00065cc] do_softirq+0xa0/0xac
 [...]

This is because ucc_geth_tx() tries to process an empty queue when
queues are logically stopped. Stopping the queues doesn't disable
polling, and since nowadays ucc_geth_tx() is actually called from
the polling routine, the oops above might pop up.

Fix this by removing 'netif_queue_stopped() == 0' check.

Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Tested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Stable <stable@vger.kernel.org> [2.6.32]
---
 drivers/net/ucc_geth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index afaf088..0f8c99e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3273,7 +3273,7 @@ static int ucc_geth_tx(struct net_device *dev, u8 txQ)
 		/* Handle the transmitted buffer and release */
 		/* the BD to be used with the current frame  */
 
-		if ((bd == ugeth->txBd[txQ]) && (netif_queue_stopped(dev) == 0))
+		if (bd == ugeth->txBd[txQ]) /* queue empty? */
 			break;
 
 		dev->stats.tx_packets++;
-- 
1.6.3.3
