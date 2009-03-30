Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id C45CEDDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 05:53:17 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so2179066rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 11:53:16 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] net/fec_mpc52xx: fix BUG on missing dma_ops
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
Date: Mon, 30 Mar 2009 12:53:14 -0600
Message-ID: <20090330184423.31699.61150.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The driver triggers a BUG_ON() when allocating DMA buffers if the
arch/powerpc dma_ops from the of_platform device are not copied
into net_device structure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
David, do you want to pick this one up right away, or should I merge it
through Ben's powerpc tree?

g.

 drivers/net/fec_mpc52xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 049b0a7..215207d 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -928,6 +928,9 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 	if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec), DRIVER_NAME))
 		return -EBUSY;
 
+	/* Copy the PowerPC dma_ops from the of_device */
+	set_dma_ops(&ndev->dev, get_dma_ops(&op->dev));
+
 	/* Init ether ndev with what we have */
 	ndev->open		= mpc52xx_fec_open;
 	ndev->stop		= mpc52xx_fec_close;
