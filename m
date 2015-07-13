Return-Path: <leosilva@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A03C1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 02:51:48 +1000 (AEST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leosilva@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 13:51:44 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 375E0352005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 12:50:36 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6DGoBkt60227612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 13:50:11 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6DGpdWC031584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 13:51:40 -0300
Date: Mon, 13 Jul 2015 13:51:39 -0300
From: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
 pfsmorigo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] Adding enable_kernel_vsx() to access VSX instructions
Message-ID: <20150713165136.GA6719@bluepex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vmx-crypto driver make use of some VSX instructions which are
only available if VSX is enabled. Running in cases where VSX
are not enabled vmx-crypto fails in a VSX exception.

In order to fix this enable_kernel_vsx() was added to turn on
VSX instructions for vmx-crypto.

Signed-off-by: Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
---
 drivers/crypto/vmx/aes.c     | 3 +++
 drivers/crypto/vmx/aes_cbc.c | 3 +++
 drivers/crypto/vmx/aes_ctr.c | 3 +++
 drivers/crypto/vmx/ghash.c   | 4 ++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/crypto/vmx/aes.c b/drivers/crypto/vmx/aes.c
index e79e567..263af70 100644
--- a/drivers/crypto/vmx/aes.c
+++ b/drivers/crypto/vmx/aes.c
@@ -84,6 +84,7 @@ static int p8_aes_setkey(struct crypto_tfm *tfm, const u8 *key,
 	preempt_disable();
 	pagefault_disable();
 	enable_kernel_altivec();
+	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
 	pagefault_enable();
@@ -103,6 +104,7 @@ static void p8_aes_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		preempt_disable();
 		pagefault_disable();
 		enable_kernel_altivec();
+		enable_kernel_vsx();
 		aes_p8_encrypt(src, dst, &ctx->enc_key);
 		pagefault_enable();
 		preempt_enable();
@@ -119,6 +121,7 @@ static void p8_aes_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		preempt_disable();
 		pagefault_disable();
 		enable_kernel_altivec();
+		enable_kernel_vsx();
 		aes_p8_decrypt(src, dst, &ctx->dec_key);
 		pagefault_enable();
 		preempt_enable();
diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
index 7299995..0b8fe2e 100644
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -85,6 +85,7 @@ static int p8_aes_cbc_setkey(struct crypto_tfm *tfm, const u8 *key,
 	preempt_disable();
 	pagefault_disable();
 	enable_kernel_altivec();
+	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	ret += aes_p8_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
 	pagefault_enable();
@@ -115,6 +116,7 @@ static int p8_aes_cbc_encrypt(struct blkcipher_desc *desc,
 		preempt_disable();
 		pagefault_disable();
 		enable_kernel_altivec();
+		enable_kernel_vsx();
 
 		blkcipher_walk_init(&walk, dst, src, nbytes);
 		ret = blkcipher_walk_virt(desc, &walk);
@@ -155,6 +157,7 @@ static int p8_aes_cbc_decrypt(struct blkcipher_desc *desc,
 		preempt_disable();
 		pagefault_disable();
 		enable_kernel_altivec();
+		enable_kernel_vsx();
 
 		blkcipher_walk_init(&walk, dst, src, nbytes);
 		ret = blkcipher_walk_virt(desc, &walk);
diff --git a/drivers/crypto/vmx/aes_ctr.c b/drivers/crypto/vmx/aes_ctr.c
index 7adae42..1e754ae 100644
--- a/drivers/crypto/vmx/aes_ctr.c
+++ b/drivers/crypto/vmx/aes_ctr.c
@@ -82,6 +82,7 @@ static int p8_aes_ctr_setkey(struct crypto_tfm *tfm, const u8 *key,
 
 	pagefault_disable();
 	enable_kernel_altivec();
+	enable_kernel_vsx();
 	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
 	pagefault_enable();
 
@@ -100,6 +101,7 @@ static void p8_aes_ctr_final(struct p8_aes_ctr_ctx *ctx,
 
 	pagefault_disable();
 	enable_kernel_altivec();
+	enable_kernel_vsx();
 	aes_p8_encrypt(ctrblk, keystream, &ctx->enc_key);
 	pagefault_enable();
 
@@ -131,6 +133,7 @@ static int p8_aes_ctr_crypt(struct blkcipher_desc *desc,
 		while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
 			pagefault_disable();
 			enable_kernel_altivec();
+			enable_kernel_vsx();
 			aes_p8_ctr32_encrypt_blocks(walk.src.virt.addr,
 						    walk.dst.virt.addr,
 						    (nbytes &
diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
index b5e2900..2183a2e 100644
--- a/drivers/crypto/vmx/ghash.c
+++ b/drivers/crypto/vmx/ghash.c
@@ -119,6 +119,7 @@ static int p8_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
 	preempt_disable();
 	pagefault_disable();
 	enable_kernel_altivec();
+	enable_kernel_vsx();
 	enable_kernel_fp();
 	gcm_init_p8(ctx->htable, (const u64 *) key);
 	pagefault_enable();
@@ -149,6 +150,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 			preempt_disable();
 			pagefault_disable();
 			enable_kernel_altivec();
+			enable_kernel_vsx();
 			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
@@ -163,6 +165,7 @@ static int p8_ghash_update(struct shash_desc *desc,
 			preempt_disable();
 			pagefault_disable();
 			enable_kernel_altivec();
+			enable_kernel_vsx();
 			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable, src, len);
 			pagefault_enable();
@@ -193,6 +196,7 @@ static int p8_ghash_final(struct shash_desc *desc, u8 *out)
 			preempt_disable();
 			pagefault_disable();
 			enable_kernel_altivec();
+			enable_kernel_vsx();
 			enable_kernel_fp();
 			gcm_ghash_p8(dctx->shash, ctx->htable,
 				     dctx->buffer, GHASH_DIGEST_SIZE);
-- 
2.1.0
