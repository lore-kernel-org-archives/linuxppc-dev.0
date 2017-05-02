Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHMnZ3znSzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 23:38:42 +1000 (AEST)
Date: Tue, 2 May 2017 09:38:35 -0400
From: Martin Hicks <mort@bork.org>
To: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Cc: stable@vger.kernel.org, horia.geanta@nxp.com
Subject: [PATCH v2] crypto: talitos: Extend max key length for
 SHA384/512-HMAC and AEAD
Message-ID: <20170502133835.GA17402@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


An updated patch that also handles the additional key length requirements
for the AEAD algorithms.

The max keysize is not 96.  For SHA384/512 it's 128, and for the AEAD
algorithms it's longer still.  Extend the max keysize for the
AEAD size for AES256 + HMAC(SHA512).

Cc: <stable@vger.kernel.org> # 3.6+
Fixes: 357fb60502ede ("crypto: talitos - add sha224, sha384 and sha512 to existing AEAD algorithms")
Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/crypto/talitos.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 0bba6a1..79791c6 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -816,7 +816,7 @@ static void talitos_unregister_rng(struct device *dev)
  * HMAC_SNOOP_NO_AFEA (HSNA) instead of type IPSEC_ESP
  */
 #define TALITOS_CRA_PRIORITY_AEAD_HSNA	(TALITOS_CRA_PRIORITY - 1)
-#define TALITOS_MAX_KEY_SIZE		96
+#define TALITOS_MAX_KEY_SIZE		(AES_MAX_KEY_SIZE + SHA512_BLOCK_SIZE)
 #define TALITOS_MAX_IV_LENGTH		16 /* max of AES_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE */
 
 struct talitos_ctx {
@@ -1495,6 +1495,11 @@ static int ablkcipher_setkey(struct crypto_ablkcipher *cipher,
 {
 	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
 
+	if (keylen > TALITOS_MAX_KEY_SIZE) {
+		crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+
 	memcpy(&ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-- 
1.7.10.4


-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
