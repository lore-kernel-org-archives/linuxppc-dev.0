Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7qbs1vcnzDqlP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:04:40 +1100 (AEDT)
Message-Id: <f3ecd958dfa21d5020d51cbe74fcb36150bae38c.1507284818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1507284818.git.christophe.leroy@c-s.fr>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/18] crypto: talitos - fix setkey to check key weakness
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri,  6 Oct 2017 15:04:37 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Crypto manager test report the following failures:
[    3.061081] alg: skcipher: setkey failed on test 5 for ecb-des-talitos: flags=100
[    3.069342] alg: skcipher-ddst: setkey failed on test 5 for ecb-des-talitos: flags=100
[    3.077754] alg: skcipher-ddst: setkey failed on test 5 for ecb-des-talitos: flags=100

This is due to setkey being expected to detect weak keys.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 1e799886c57d..8aa1212086f4 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1507,12 +1507,20 @@ static int ablkcipher_setkey(struct crypto_ablkcipher *cipher,
 			     const u8 *key, unsigned int keylen)
 {
 	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
+	u32 tmp[DES_EXPKEY_WORDS];
 
 	if (keylen > TALITOS_MAX_KEY_SIZE) {
 		crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 
+	if (unlikely(crypto_ablkcipher_get_flags(cipher) &
+		     CRYPTO_TFM_REQ_WEAK_KEY) &&
+	    !des_ekey(tmp, key)) {
+		crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_WEAK_KEY);
+		return -EINVAL;
+	}
+
 	memcpy(&ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-- 
2.13.3
