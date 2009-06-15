Return-Path: <spulijala@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E71C2B7134
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 03:33:45 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5939ADDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 03:33:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: [PATCH 3/3] AMCC Crypto4xx Device Driver v7
Date: Mon, 15 Jun 2009 10:28:03 -0700
Message-ID: <DB599F406D04E34389140B7D99C71B1B07D83E99@SDCEXCHANGE01.ad.amcc.com>
From: "Shasi Pulijala" <spulijala@amcc.com>
To: <herbert@gondor.apana.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Shasi Pulijala <spulijala@amcc.com>

This patch further adds immediate hash functions to md5/sha1/sha2 algs.
These immediate hash functions are used in hmac key generation in PPC =
Crypto4xx driver.

Signed-off-by: Shasi Pulijala <spulijala@amcc.com>
Acked-by: Loc Ho <lho@amcc.com>
---
 crypto/md5.c            |   15 +++++++++++++++
 crypto/sha1_generic.c   |   15 +++++++++++++++
 crypto/sha256_generic.c |   15 +++++++++++++++
 crypto/sha512_generic.c |   19 +++++++++++++++++++
 include/crypto/sha.h    |    7 +++++++
 5 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/crypto/md5.c b/crypto/md5.c
index 83eb529..0c74b84 100644
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -220,6 +220,21 @@ static int md5_final(struct shash_desc *desc, u8 =
*out)
 	return 0;
 }
=20
+void md5_get_immediate_hash(struct crypto_tfm *tfm, u8 *data)
+{
+	struct shash_desc *desc =3D crypto_tfm_ctx(tfm);
+	struct md5_ctx *mctx =3D shash_desc_ctx(desc);
+	int i;
+
+	for (i =3D 0; i < MD5_HASH_WORDS; i++) {
+		*data++ =3D mctx->hash[i] & 0xFF;
+		*data++ =3D (mctx->hash[i] >> 8) & 0xFF;
+		*data++ =3D (mctx->hash[i] >> 16) & 0xFF;
+		*data++ =3D (mctx->hash[i] >> 24) & 0xFF;
+	}
+}
+EXPORT_SYMBOL_GPL(md5_get_immediate_hash);
+
 static struct shash_alg alg =3D {
 	.digestsize	=3D	MD5_DIGEST_SIZE,
 	.init		=3D	md5_init,
diff --git a/crypto/sha1_generic.c b/crypto/sha1_generic.c
index 9efef20..e77b591 100644
--- a/crypto/sha1_generic.c
+++ b/crypto/sha1_generic.c
@@ -111,6 +111,21 @@ static int sha1_final(struct shash_desc *desc, u8 =
*out)
 	return 0;
 }
=20
+void sha1_get_immediate_hash(struct crypto_tfm *tfm, u8 *data)
+{
+	struct shash_desc *desc =3D crypto_tfm_ctx(tfm);
+	struct sha1_ctx *sctx =3D shash_desc_ctx(desc);
+	int i;
+
+	for (i =3D 0; i < 5; i++) {
+		*data++ =3D sctx->state[i] & 0xFF;
+		*data++ =3D (sctx->state[i] >> 8) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 16) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 24) & 0xFF;
+	}
+}
+EXPORT_SYMBOL_GPL(sha1_get_immediate_hash);
+
 static struct shash_alg alg =3D {
 	.digestsize	=3D	SHA1_DIGEST_SIZE,
 	.init		=3D	sha1_init,
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index 6349d83..0f5a66b 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -331,6 +331,21 @@ static int sha224_final(struct shash_desc *desc, u8 =
*hash)
 	return 0;
 }
=20
+void sha256_get_immediate_hash(struct crypto_tfm *tfm, u8 *data)
+{
+	struct shash_desc *desc =3D crypto_tfm_ctx(tfm);
+	struct sha256_ctx *sctx =3D shash_desc_ctx(desc);
+	int i;
+
+	for (i =3D 0; i < 8; i++) {
+		*data++ =3D sctx->state[i] & 0xFF;
+		*data++ =3D (sctx->state[i] >> 8) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 16) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 24) & 0xFF;
+	}
+}
+EXPORT_SYMBOL_GPL(sha256_get_immediate_hash);
+
 static struct shash_alg sha256 =3D {
 	.digestsize	=3D	SHA256_DIGEST_SIZE,
 	.init		=3D	sha256_init,
diff --git a/crypto/sha512_generic.c b/crypto/sha512_generic.c
index 3bea38d..c329903 100644
--- a/crypto/sha512_generic.c
+++ b/crypto/sha512_generic.c
@@ -257,6 +257,25 @@ static int sha384_final(struct shash_desc *desc, u8 =
*hash)
 	return 0;
 }
=20
+void sha512_get_immediate_hash(struct crypto_tfm *tfm, u8 *data)
+{
+	struct shash_desc *desc =3D crypto_tfm_ctx(tfm);
+	struct sha512_ctx *sctx =3D shash_desc_ctx(desc);
+	int i;
+
+	for (i =3D 0; i < 8; i++) {
+		*data++ =3D (sctx->state[i] >> 32) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 40) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 48) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 56) & 0xFF;
+		*data++ =3D sctx->state[i] & 0xFF;
+		*data++ =3D (sctx->state[i] >> 8) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 16) & 0xFF;
+		*data++ =3D (sctx->state[i] >> 24) & 0xFF;
+	}
+}
+EXPORT_SYMBOL_GPL(sha512_get_immediate_hash);
+
 static struct shash_alg sha512 =3D {
 	.digestsize	=3D	SHA512_DIGEST_SIZE,
 	.init		=3D	sha512_init,
diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index c0ccc2b..8894c2f 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -62,4 +62,11 @@
 #define SHA512_H6	0x1f83d9abfb41bd6bULL
 #define SHA512_H7	0x5be0cd19137e2179ULL
=20
+/* From crypto/sha1_generic.c */
+void sha1_get_immediate_hash(struct crypto_tfm *tfm, u8 *data);
+/* From crypto/sha256_generic.c */
+void sha256_get_immediate_hash(struct crypto_tfm *tfm, u8 *data);
+/* From crypto/sha512_generic.c */
+void sha512_get_immediate_hash(struct crypto_tfm *tfm, u8 *data);
+
 #endif
--=20
1.5.5
