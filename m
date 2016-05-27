Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGLQk3pLgzDqbh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 19:32:46 +1000 (AEST)
Message-Id: <8eb87766b51532f61114e903973a7abbee080dff.1464330501.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1464330501.git.christophe.leroy@c-s.fr>
References: <cover.1464330501.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/6] crypto: talitos - implement cra_priority
To: Kim Phillips <kim.phillips@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Fri, 27 May 2016 11:32:43 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SEC1 doesn't have IPSEC_ESP descriptor type but it is able to perform
IPSEC using HMAC_SNOOP_NO_AFEU, which is also existing on SEC2
In order to be able to define descriptors templates for SEC1 without
breaking SEC2+, we have to give lower priority to HMAC_SNOOP_NO_AFEU
so that SEC2+ selects IPSEC_ESP and not HMAC_SNOOP_NO_AFEU which is
less performant.

This is done by adding a priority field in the template. If the field
is 0, we use the default priority, otherwise we used the one in the
field.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index fcdf83b..b554f56 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2103,6 +2103,7 @@ static int ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 struct talitos_alg_template {
 	u32 type;
+	u32 priority;
 	union {
 		struct crypto_alg crypto;
 		struct ahash_alg hash;
@@ -2880,7 +2881,10 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 	}
 
 	alg->cra_module = THIS_MODULE;
-	alg->cra_priority = TALITOS_CRA_PRIORITY;
+	if (t_alg->algt.priority)
+		alg->cra_priority = t_alg->algt.priority;
+	else
+		alg->cra_priority = TALITOS_CRA_PRIORITY;
 	alg->cra_alignmask = 0;
 	alg->cra_ctxsize = sizeof(struct talitos_ctx);
 	alg->cra_flags |= CRYPTO_ALG_KERN_DRIVER_ONLY;
-- 
2.1.0
