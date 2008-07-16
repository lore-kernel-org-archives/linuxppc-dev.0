Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 085A4DE0A3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:23:05 +1000 (EST)
Date: Wed, 16 Jul 2008 18:22:15 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 4/6] crypto: talitos - fix GFP flag usage
Message-Id: <20080716182215.36c1bd11.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

use GFP_ATOMIC when necessary; use atomic_t when allocating submit_count.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Acked-by: Lee Nipper <lee.nipper@freescale.com>
---
 drivers/crypto/talitos.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index fdb0680..79fdba2 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1015,6 +1015,8 @@ static struct ipsec_esp_edesc *ipsec_esp_edesc_alloc(struct aead_request *areq,
 	struct talitos_ctx *ctx = crypto_aead_ctx(authenc);
 	struct ipsec_esp_edesc *edesc;
 	int src_nents, dst_nents, alloc_len, dma_len;
+	gfp_t flags = areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL :
+		      GFP_ATOMIC;
 
 	if (areq->cryptlen + ctx->authsize > TALITOS_MAX_DATA_LEN) {
 		dev_err(ctx->dev, "cryptlen exceeds h/w max limit\n");
@@ -1046,7 +1048,7 @@ static struct ipsec_esp_edesc *ipsec_esp_edesc_alloc(struct aead_request *areq,
 		alloc_len += icv_stashing ? ctx->authsize : 0;
 	}
 
-	edesc = kmalloc(alloc_len, GFP_DMA);
+	edesc = kmalloc(alloc_len, GFP_DMA | flags);
 	if (!edesc) {
 		dev_err(ctx->dev, "could not allocate edescriptor\n");
 		return ERR_PTR(-ENOMEM);
@@ -1508,7 +1510,7 @@ static int talitos_probe(struct of_device *ofdev,
 		}
 	}
 
-	priv->submit_count = kmalloc(sizeof(int) * priv->num_channels,
+	priv->submit_count = kmalloc(sizeof(atomic_t) * priv->num_channels,
 				     GFP_KERNEL);
 	if (!priv->submit_count) {
 		dev_err(dev, "failed to allocate fifo submit count space\n");
-- 
1.5.6
