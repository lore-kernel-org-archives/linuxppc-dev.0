Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 5012CDDDE9
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 16:10:06 +1100 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JSE00L24P0SAV00@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 22:10:04 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSE004WZP0TNI20@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 01 Dec 2007 22:10:05 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JSE007C6P0SDM40@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 22:10:04 -0700 (MST)
Date: Sat, 01 Dec 2007 22:10:03 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] gianfar: fix compile warning
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, galak@kernel.crashing.org,
	jgarzik@pobox.com, afleming@freescale.com
Message-id: <20071202050927.8827.27154.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Eliminate an uninitialized variable warning.  The code is correct, but
a pointer to the automatic variable 'addr' is passed to dma_alloc_coherent.
Since addr has never been initialized, and the compiler doesn't know
what dma_alloc_coherent will do with it, it complains.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Jeff, this one should go in for 2.6.24

Cheers,
g.

 drivers/net/gianfar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 38268d7..0431e9e 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -696,7 +696,7 @@ int startup_gfar(struct net_device *dev)
 {
 	struct txbd8 *txbdp;
 	struct rxbd8 *rxbdp;
-	dma_addr_t addr;
+	dma_addr_t addr = 0;
 	unsigned long vaddr;
 	int i;
 	struct gfar_private *priv = netdev_priv(dev);
