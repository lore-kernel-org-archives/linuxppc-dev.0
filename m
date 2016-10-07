Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srMM55lRszDrVW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 07:58:57 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: qiang.zhao@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] wan/fsl_ucc_hdlc: Fix size used in dma_free_coherent()
Date: Fri,  7 Oct 2016 22:58:47 +0200
Message-Id: <1475873927-14999-1-git-send-email-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Size used with 'dma_alloc_coherent()' and 'dma_free_coherent()' should be
consistent.
Here, the size of a pointer is used in dma_alloc... and the size of the
pointed structure is used in dma_free...

This has been spotted with coccinelle, using the following script:
////////////////////
@r@
expression x0, x1, y0, y1, z0, z1, t0, t1, ret;
@@

*   ret = dma_alloc_coherent(x0, y0, z0, t0);
    ...
*   dma_free_coherent(x1, y1, ret, t1);


@script:python@
y0 << r.y0;
y1 << r.y1;

@@
if y1.find(y0) == -1:
 print "WARNING: sizes look different:  '%s'   vs   '%s'" % (y0, y1)
////////////////////

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 5fbf83d5aa57..65647533b401 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -295,11 +295,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	qe_muram_free(priv->ucc_pram_offset);
 free_tx_bd:
 	dma_free_coherent(priv->dev,
-			  TX_BD_RING_LEN * sizeof(struct qe_bd),
+			  TX_BD_RING_LEN * sizeof(struct qe_bd *),
 			  priv->tx_bd_base, priv->dma_tx_bd);
 free_rx_bd:
 	dma_free_coherent(priv->dev,
-			  RX_BD_RING_LEN * sizeof(struct qe_bd),
+			  RX_BD_RING_LEN * sizeof(struct qe_bd *),
 			  priv->rx_bd_base, priv->dma_rx_bd);
 free_uccf:
 	ucc_fast_free(priv->uccf);
@@ -688,7 +688,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_bd_base) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * sizeof(struct qe_bd),
+				  RX_BD_RING_LEN * sizeof(struct qe_bd *),
 				  priv->rx_bd_base, priv->dma_rx_bd);
 
 		priv->rx_bd_base = NULL;
@@ -697,7 +697,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->tx_bd_base) {
 		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * sizeof(struct qe_bd),
+				  TX_BD_RING_LEN * sizeof(struct qe_bd *),
 				  priv->tx_bd_base, priv->dma_tx_bd);
 
 		priv->tx_bd_base = NULL;
-- 
2.7.4
