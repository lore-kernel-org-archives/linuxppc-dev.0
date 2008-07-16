Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3206FDE0AD
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:23:10 +1000 (EST)
Date: Wed, 16 Jul 2008 18:22:23 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 5/6] crypto: talitos - stop leaking memory in error path
Message-Id: <20080716182223.08b2ee07.kim.phillips@freescale.com>
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

free edescriptor when returning error (such as -EAGAIN).

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Acked-by: Lee Nipper <lee.nipper@freescale.com>
---
 drivers/crypto/talitos.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 79fdba2..a81265b 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -880,7 +880,7 @@ static int ipsec_esp(struct ipsec_esp_edesc *edesc, struct aead_request *areq,
 	unsigned int cryptlen = areq->cryptlen;
 	unsigned int authsize = ctx->authsize;
 	unsigned int ivsize;
-	int sg_count;
+	int sg_count, ret;
 
 	/* hmac key */
 	map_single_talitos_ptr(dev, &desc->ptr[0], ctx->authkeylen, &ctx->key,
@@ -984,7 +984,12 @@ static int ipsec_esp(struct ipsec_esp_edesc *edesc, struct aead_request *areq,
 	map_single_talitos_ptr(dev, &desc->ptr[6], ivsize, ctx->iv, 0,
 			       DMA_FROM_DEVICE);
 
-	return talitos_submit(dev, desc, callback, areq);
+	ret = talitos_submit(dev, desc, callback, areq);
+	if (ret != -EINPROGRESS) {
+		ipsec_esp_unmap(dev, edesc, areq);
+		kfree(edesc);
+	}
+	return ret;
 }
 
 
-- 
1.5.6
