Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C6310DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 13:56:17 +1000 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ300JL19JGQYB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 21:54:52 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ300EMS9JG5F40@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 17 Oct 2007 21:54:52 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ3008BZ9JFXLA2@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 21:54:51 -0600 (MDT)
Date: Wed, 17 Oct 2007 21:54:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] gianfar: fix compile warning
To: Li Yang <leoli@freescale.com>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Message-id: <20071018035458.22355.99460.stgit@trillian.cg.shawcable.net>
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

 drivers/net/gianfar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index cc288d8..c009ab6 100644
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
