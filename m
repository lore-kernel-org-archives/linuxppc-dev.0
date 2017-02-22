Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT4tY0N8lzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 05:01:24 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MHsck5000949
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:01:23 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sdfp6fyh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:01:22 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 15:01:20 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 131DB352006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:00:43 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MI1GAV37290024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:01:16 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MI1F3q014341
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:01:16 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Subject: [PATCH 2/2] crypto: vmx - Use skcipher for xts fallback
Date: Wed, 22 Feb 2017 15:00:45 -0300
Message-Id: <20170222180045.28341-1-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
---
 drivers/crypto/vmx/aes_xts.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/vmx/aes_xts.c b/drivers/crypto/vmx/aes_xts.c
index 24353ec3..a8245e1 100644
--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -28,11 +28,12 @@
 #include <crypto/aes.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/xts.h>
+#include <crypto/internal/skcipher.h>
 
 #include "aesp8-ppc.h"
 
 struct p8_aes_xts_ctx {
-	struct crypto_blkcipher *fallback;
+	struct crypto_skcipher *fallback;
 	struct aes_key enc_key;
 	struct aes_key dec_key;
 	struct aes_key tweak_key;
@@ -41,7 +42,7 @@ struct p8_aes_xts_ctx {
 static int p8_aes_xts_init(struct crypto_tfm *tfm)
 {
 	const char *alg;
-	struct crypto_blkcipher *fallback;
+	struct crypto_skcipher *fallback;
 	struct p8_aes_xts_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (!(alg = crypto_tfm_alg_name(tfm))) {
@@ -50,7 +51,7 @@ static int p8_aes_xts_init(struct crypto_tfm *tfm)
 	}
 
 	fallback =
-		crypto_alloc_blkcipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
+		crypto_alloc_skcipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback)) {
 		printk(KERN_ERR
 			"Failed to allocate transformation for '%s': %ld\n",
@@ -60,9 +61,9 @@ static int p8_aes_xts_init(struct crypto_tfm *tfm)
 	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
 		crypto_tfm_alg_driver_name((struct crypto_tfm *) fallback));
 
-	crypto_blkcipher_set_flags(
+	crypto_skcipher_set_flags(
 		fallback,
-		crypto_blkcipher_get_flags((struct crypto_blkcipher *)tfm));
+		crypto_skcipher_get_flags((struct crypto_skcipher *)tfm));
 	ctx->fallback = fallback;
 
 	return 0;
@@ -73,7 +74,7 @@ static void p8_aes_xts_exit(struct crypto_tfm *tfm)
 	struct p8_aes_xts_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback) {
-		crypto_free_blkcipher(ctx->fallback);
+		crypto_free_skcipher(ctx->fallback);
 		ctx->fallback = NULL;
 	}
 }
@@ -98,7 +99,7 @@ static int p8_aes_xts_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_enable();
 	preempt_enable();
 
-	ret += crypto_blkcipher_setkey(ctx->fallback, key, keylen);
+	ret += crypto_skcipher_setkey(ctx->fallback, key, keylen);
 	return ret;
 }
 
@@ -113,15 +114,18 @@ static int p8_aes_xts_crypt(struct blkcipher_desc *desc,
 	struct blkcipher_walk walk;
 	struct p8_aes_xts_ctx *ctx =
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
-	struct blkcipher_desc fallback_desc = {
-		.tfm = ctx->fallback,
-		.info = desc->info,
-		.flags = desc->flags
-	};
 
 	if (in_interrupt()) {
-		ret = enc ? crypto_blkcipher_encrypt(&fallback_desc, dst, src, nbytes) :
-                            crypto_blkcipher_decrypt(&fallback_desc, dst, src, nbytes);
+		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_tfm(req, ctx->fallback);
+		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
+		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
+		ret = crypto_skcipher_encrypt(req);
+		if (enc)
+			crypto_skcipher_encrypt(req);
+		else
+			crypto_skcipher_decrypt(req);
+		skcipher_request_zero(req);
 	} else {
 		preempt_disable();
 		pagefault_disable();
-- 
2.9.3
