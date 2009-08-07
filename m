Return-Path: <kim.phillips@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0CE69B7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 09:40:39 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9084BDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 09:40:37 +1000 (EST)
Date: Fri, 7 Aug 2009 18:39:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 1/3] crypto: talitos - simplify hmac data size calculation
Message-Id: <20090807183958.94650fb7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

don't do request->src vs. assoc pointer math - it's the same as adding
assoclen and ivsize (just with more effort).

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/talitos.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index c70775f..b1a651c 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -970,7 +970,7 @@ static int ipsec_esp(struct talitos_edesc *edesc, struct aead_request *areq,
 	struct talitos_desc *desc = &edesc->desc;
 	unsigned int cryptlen = areq->cryptlen;
 	unsigned int authsize = ctx->authsize;
-	unsigned int ivsize;
+	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int sg_count, ret;
 	int sg_link_tbl_len;
 
@@ -978,11 +978,9 @@ static int ipsec_esp(struct talitos_edesc *edesc, struct aead_request *areq,
 	map_single_talitos_ptr(dev, &desc->ptr[0], ctx->authkeylen, &ctx->key,
 			       0, DMA_TO_DEVICE);
 	/* hmac data */
-	map_single_talitos_ptr(dev, &desc->ptr[1], sg_virt(areq->src) -
-			       sg_virt(areq->assoc), sg_virt(areq->assoc), 0,
-			       DMA_TO_DEVICE);
+	map_single_talitos_ptr(dev, &desc->ptr[1], areq->assoclen + ivsize,
+			       sg_virt(areq->assoc), 0, DMA_TO_DEVICE);
 	/* cipher iv */
-	ivsize = crypto_aead_ivsize(aead);
 	map_single_talitos_ptr(dev, &desc->ptr[2], ivsize, giv ?: areq->iv, 0,
 			       DMA_TO_DEVICE);
 
-- 
1.6.3
