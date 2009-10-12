Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6FCAAB7E7E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 03:00:34 +1100 (EST)
Date: Mon, 12 Oct 2009 20:00:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 3/8] gianfar: Don't needlessly set the wrap bit for the
	last RX BD
Message-ID: <20091012160033.GC2463@oksana.dev.rtsoft.ru>
References: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Andy Fleming <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

startup_gfar() sets the wrap bit for the last rxbd just after
gfar_new_rxbdp() call, which is issued for all rxbds. And
gfar_new_rxbdp() has the following check already:

	if (bdp == priv->rx_bd_base + priv->rx_ring_size - 1)
		lstatus |= BD_LFLAG(RXBD_WRAP);

So we don't need to set the bit again.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index b7881e6..ee23431 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1028,10 +1028,6 @@ int startup_gfar(struct net_device *ndev)
 		rxbdp++;
 	}
 
-	/* Set the last descriptor in the ring to wrap */
-	rxbdp--;
-	rxbdp->status |= RXBD_WRAP;
-
 	/* If the device has multiple interrupts, register for
 	 * them.  Otherwise, only register for the one */
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
-- 
1.6.3.3
