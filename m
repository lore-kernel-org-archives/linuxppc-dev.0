Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B03A21A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 11:34:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: <linuxppc-dev@ozlabs.org>, linux-crypto@vger.kernel.org,
 Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH stable 2/2] crypto: vmx - Adding enable_kernel_vsx() to access
 VSX instructions
Date: Wed, 16 Sep 2015 11:34:08 +1000
Message-Id: <1442367251-9319-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1442367251-9319-1-git-send-email-mpe@ellerman.id.au>
References: <1442367251-9319-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>

commit 2d6f0600b2cd755959527230ef5a6fba97bb762a upstream.

vmx-crypto driver make use of some VSX instructions which are
only available if VSX is enabled. Running in cases where VSX
are not enabled vmx-crypto fails in a VSX exception.

In order to fix this enable_kernel_vsx() was added to turn on
VSX instructions for vmx-crypto.

Signed-off-by: Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Fixes: 8676590a1593 ("crypto: vmx - Adding AES routines for VMX module")
Cc: stable@vger.kernel.org # 4.2
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/crypto/vmx/aes.c     | 3 +++
 drivers/crypto/vmx/aes_cbc.c | 3 +++
 drivers/crypto/vmx/aes_ctr.c | 3 +++
 drivers/crypto/vmx/ghash.c   | 4 ++++
 4 files changed, 13 insertions(+)

This fixes a kernel crash at boot.

diff --git a/drivers/crypto/vmx/aes.c b/drivers/crypto/vmx/aes.c
index e79e567e43aa..263af709e536 100644
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
index 7299995c78ec..0b8fe2ec5315 100644
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
index 7adae42a7b79..1e754ae4e850 100644
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
index b5e29002b666..2183a2e77641 100644
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
2.1.4
