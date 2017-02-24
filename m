Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVD0d5BCfzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 01:25:37 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1OEOjOG011214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 09:25:35 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28teteu4r1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 09:25:35 -0500
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 11:25:31 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id CA3B11DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 09:25:28 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1OEPJYk31129664
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:25:27 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1OEOtDt030935
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:24:56 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] crypto: vmx - Use skcipher for cbc fallback
Date: Fri, 24 Feb 2017 11:23:54 -0300
In-Reply-To: <20170223112052.GA14019@gondor.apana.org.au>
References: <20170223112052.GA14019@gondor.apana.org.au>
Message-Id: <20170224142354.10231-1-pfsmorigo@linux.vnet.ibm.com>
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
 drivers/crypto/vmx/aes_cbc.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
index 94ad5c0..2bb5910 100644
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -27,11 +27,12 @@
 #include <asm/switch_to.h>
 #include <crypto/aes.h>
 #include <crypto/scatterwalk.h>
+#include <crypto/skcipher.h>
 
 #include "aesp8-ppc.h"
 
 struct p8_aes_cbc_ctx {
-	struct crypto_blkcipher *fallback;
+	struct crypto_skcipher *fallback;
 	struct aes_key enc_key;
 	struct aes_key dec_key;
 };
@@ -39,7 +40,7 @@ struct p8_aes_cbc_ctx {
 static int p8_aes_cbc_init(struct crypto_tfm *tfm)
 {
 	const char *alg;
-	struct crypto_blkcipher *fallback;
+	struct crypto_skcipher *fallback;
 	struct p8_aes_cbc_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (!(alg = crypto_tfm_alg_name(tfm))) {
@@ -47,8 +48,9 @@ static int p8_aes_cbc_init(struct crypto_tfm *tfm)
 		return -ENOENT;
 	}
 
-	fallback =
-	    crypto_alloc_blkcipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
+	fallback = crypto_alloc_skcipher(alg, 0,
+			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+
 	if (IS_ERR(fallback)) {
 		printk(KERN_ERR
 		       "Failed to allocate transformation for '%s': %ld\n",
@@ -58,9 +60,9 @@ static int p8_aes_cbc_init(struct crypto_tfm *tfm)
 	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
 	       crypto_tfm_alg_driver_name((struct crypto_tfm *) fallback));
 
-	crypto_blkcipher_set_flags(
+	crypto_skcipher_set_flags(
 		fallback,
-		crypto_blkcipher_get_flags((struct crypto_blkcipher *)tfm));
+		crypto_skcipher_get_flags((struct crypto_skcipher *)tfm));
 	ctx->fallback = fallback;
 
 	return 0;
@@ -71,7 +73,7 @@ static void p8_aes_cbc_exit(struct crypto_tfm *tfm)
 	struct p8_aes_cbc_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback) {
-		crypto_free_blkcipher(ctx->fallback);
+		crypto_free_skcipher(ctx->fallback);
 		ctx->fallback = NULL;
 	}
 }
@@ -91,7 +93,7 @@ static int p8_aes_cbc_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_enable();
 	preempt_enable();
 
-	ret += crypto_blkcipher_setkey(ctx->fallback, key, keylen);
+	ret += crypto_skcipher_setkey(ctx->fallback, key, keylen);
 	return ret;
 }
 
@@ -103,15 +105,14 @@ static int p8_aes_cbc_encrypt(struct blkcipher_desc *desc,
 	struct blkcipher_walk walk;
 	struct p8_aes_cbc_ctx *ctx =
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
-	struct blkcipher_desc fallback_desc = {
-		.tfm = ctx->fallback,
-		.info = desc->info,
-		.flags = desc->flags
-	};
 
 	if (in_interrupt()) {
-		ret = crypto_blkcipher_encrypt(&fallback_desc, dst, src,
-					       nbytes);
+		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_tfm(req, ctx->fallback);
+		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
+		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
+		ret = crypto_skcipher_encrypt(req);
+		skcipher_request_zero(req);
 	} else {
 		preempt_disable();
 		pagefault_disable();
@@ -144,15 +145,14 @@ static int p8_aes_cbc_decrypt(struct blkcipher_desc *desc,
 	struct blkcipher_walk walk;
 	struct p8_aes_cbc_ctx *ctx =
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
-	struct blkcipher_desc fallback_desc = {
-		.tfm = ctx->fallback,
-		.info = desc->info,
-		.flags = desc->flags
-	};
 
 	if (in_interrupt()) {
-		ret = crypto_blkcipher_decrypt(&fallback_desc, dst, src,
-					       nbytes);
+		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_tfm(req, ctx->fallback);
+		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
+		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
+		ret = crypto_skcipher_decrypt(req);
+		skcipher_request_zero(req);
 	} else {
 		preempt_disable();
 		pagefault_disable();
-- 
2.7.4
