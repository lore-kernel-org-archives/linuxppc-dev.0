Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B8D92B7B3E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 11:11:04 +1100 (EST)
Date: Wed, 11 Nov 2009 03:11:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 2/6] gianfar: Remove 'Interrupt problem!' warning
Message-ID: <20091111001103.GB8817@oksana.dev.rtsoft.ru>
References: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
Cc: Jon Loeliger <jdl@jdl.com>, Kumar Gopalpet-B05799 <B05799@freescale.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is OK to poll with disabled IRQs, so remove the warning.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 197b358..79c28f5 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -2504,8 +2504,6 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
 				skb_put(skb, pkt_len);
 				dev->stats.rx_bytes += pkt_len;
 
-				if (in_irq() || irqs_disabled())
-					printk("Interrupt problem!\n");
 				gfar_process_frame(dev, skb, amount_pull);
 
 			} else {
-- 
1.6.3.3
