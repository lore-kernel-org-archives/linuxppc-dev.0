Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 31588B7FCB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 11:11:10 +1100 (EST)
Date: Wed, 11 Nov 2009 03:11:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 5/6] gianfar: Fix race between gfar_error() and
	gfar_start_xmit()
Message-ID: <20091111001108.GE8817@oksana.dev.rtsoft.ru>
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

gfar_error() can arrive at the middle of gfar_start_xmit() processing,
and so it can trigger transfers of BDs that we don't yet expect to
be transmitted.

Fix this by locking the tx queues in gfar_error().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index a5b0038..fde430a 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -2943,14 +2943,22 @@ static irqreturn_t gfar_error(int irq, void *grp_id)
 		if (events & IEVENT_CRL)
 			dev->stats.tx_aborted_errors++;
 		if (events & IEVENT_XFUN) {
+			unsigned long flags;
+
 			if (netif_msg_tx_err(priv))
 				printk(KERN_DEBUG "%s: TX FIFO underrun, "
 				       "packet dropped.\n", dev->name);
 			dev->stats.tx_dropped++;
 			priv->extra_stats.tx_underrun++;
 
+			local_irq_save(flags);
+			lock_tx_qs(priv);
+
 			/* Reactivate the Tx Queues */
 			gfar_write(&regs->tstat, gfargrp->tstat);
+
+			unlock_tx_qs(priv);
+			local_irq_restore(flags);
 		}
 		if (netif_msg_tx_err(priv))
 			printk(KERN_DEBUG "%s: Transmit Error\n", dev->name);
-- 
1.6.3.3
