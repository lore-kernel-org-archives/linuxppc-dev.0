Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add a powerpc implementation of SHA-1
Date: Fri, 14 Sep 2012 19:00:49 +1000
Message-Id: <1347613249-28726-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a crypto driver which provides a powerpc accelerated
implementation of SHA-1, accelerated in that it is written in asm.

Original patch by Paul, minor fixups for upstream by moi.

Lightly tested on 64-bit with the test program here:

 http://michael.ellerman.id.au/files/junkcode/sha1test.c

Seems to work, and is "not slower" than the generic version.

Needs testing on 32-bit.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Makefile                  |    1 +
 arch/powerpc/crypto/Makefile           |    9 ++
 arch/powerpc/crypto/sha1-powerpc-asm.S |  179 ++++++++++++++++++++++++++++++++
 arch/powerpc/crypto/sha1.c             |  157 ++++++++++++++++++++++++++++
 crypto/Kconfig                         |    7 ++
 5 files changed, 353 insertions(+)
 create mode 100644 arch/powerpc/crypto/Makefile
 create mode 100644 arch/powerpc/crypto/sha1-powerpc-asm.S
 create mode 100644 arch/powerpc/crypto/sha1.c

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 159e94f..277880d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -143,6 +143,7 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/sysdev/ \
 				   arch/powerpc/platforms/ \
 				   arch/powerpc/math-emu/ \
+				   arch/powerpc/crypto/ \
 				   arch/powerpc/net/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
new file mode 100644
index 0000000..2926fb9
--- /dev/null
+++ b/arch/powerpc/crypto/Makefile
@@ -0,0 +1,9 @@
+#
+# powerpc/crypto/Makefile
+#
+# Arch-specific CryptoAPI modules.
+#
+
+obj-$(CONFIG_CRYPTO_SHA1_PPC) += sha1-powerpc.o
+
+sha1-powerpc-y := sha1-powerpc-asm.o sha1.o
diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
new file mode 100644
index 0000000..a5f8264
--- /dev/null
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -0,0 +1,179 @@
+/*
+ * SHA-1 implementation for PowerPC.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * We roll the registers for T, A, B, C, D, E around on each
+ * iteration; T on iteration t is A on iteration t+1, and so on.
+ * We use registers 7 - 12 for this.
+ */
+#define RT(t)	((((t)+5)%6)+7)
+#define RA(t)	((((t)+4)%6)+7)
+#define RB(t)	((((t)+3)%6)+7)
+#define RC(t)	((((t)+2)%6)+7)
+#define RD(t)	((((t)+1)%6)+7)
+#define RE(t)	((((t)+0)%6)+7)
+
+/* We use registers 16 - 31 for the W values */
+#define W(t)	(((t)%16)+16)
+
+#define LOADW(t)				\
+	lwz	W(t),(t)*4(r4)
+
+#define STEPD0_LOAD(t)				\
+	andc	r0,RD(t),RB(t);		\
+	and	r6,RB(t),RC(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	or	r6,r6,r0;			\
+	add	r0,RE(t),r15;			\
+	add	RT(t),RT(t),r6;		\
+	add	r14,r0,W(t);			\
+	lwz	W((t)+4),((t)+4)*4(r4);	\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RT(t),RT(t),r14
+
+#define STEPD0_UPDATE(t)			\
+	and	r6,RB(t),RC(t);		\
+	andc	r0,RD(t),RB(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	or	r6,r6,r0;			\
+	add	r0,RE(t),r15;			\
+	xor	r5,W((t)+4-3),W((t)+4-8);		\
+	add	RT(t),RT(t),r6;		\
+	xor	W((t)+4),W((t)+4-16),W((t)+4-14);	\
+	add	r0,r0,W(t);			\
+	xor	W((t)+4),W((t)+4),r5;			\
+	add	RT(t),RT(t),r0;		\
+	rotlwi	W((t)+4),W((t)+4),1
+
+#define STEPD1(t)				\
+	xor	r6,RB(t),RC(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	xor	r6,r6,RD(t);			\
+	add	r0,RE(t),r15;			\
+	add	RT(t),RT(t),r6;		\
+	add	r0,r0,W(t);			\
+	add	RT(t),RT(t),r0
+
+#define STEPD1_UPDATE(t)				\
+	xor	r6,RB(t),RC(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	xor	r6,r6,RD(t);			\
+	add	r0,RE(t),r15;			\
+	xor	r5,W((t)+4-3),W((t)+4-8);		\
+	add	RT(t),RT(t),r6;		\
+	xor	W((t)+4),W((t)+4-16),W((t)+4-14);	\
+	add	r0,r0,W(t);			\
+	xor	W((t)+4),W((t)+4),r5;			\
+	add	RT(t),RT(t),r0;		\
+	rotlwi	W((t)+4),W((t)+4),1
+
+#define STEPD2_UPDATE(t)			\
+	and	r6,RB(t),RC(t);		\
+	and	r0,RB(t),RD(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	or	r6,r6,r0;			\
+	rotlwi	RB(t),RB(t),30;			\
+	and	r0,RC(t),RD(t);		\
+	xor	r5,W((t)+4-3),W((t)+4-8);	\
+	or	r6,r6,r0;			\
+	xor	W((t)+4),W((t)+4-16),W((t)+4-14);	\
+	add	r0,RE(t),r15;			\
+	add	RT(t),RT(t),r6;		\
+	add	r0,r0,W(t);			\
+	xor	W((t)+4),W((t)+4),r5;		\
+	add	RT(t),RT(t),r0;		\
+	rotlwi	W((t)+4),W((t)+4),1
+
+#define STEP0LD4(t)				\
+	STEPD0_LOAD(t);				\
+	STEPD0_LOAD((t)+1);			\
+	STEPD0_LOAD((t)+2);			\
+	STEPD0_LOAD((t)+3)
+
+#define STEPUP4(t, fn)				\
+	STEP##fn##_UPDATE(t);			\
+	STEP##fn##_UPDATE((t)+1);		\
+	STEP##fn##_UPDATE((t)+2);		\
+	STEP##fn##_UPDATE((t)+3)
+
+#define STEPUP20(t, fn)				\
+	STEPUP4(t, fn);				\
+	STEPUP4((t)+4, fn);			\
+	STEPUP4((t)+8, fn);			\
+	STEPUP4((t)+12, fn);			\
+	STEPUP4((t)+16, fn)
+
+_GLOBAL(powerpc_sha_transform)
+	PPC_STLU r1,-STACKFRAMESIZE(r1)
+	SAVE_8GPRS(14, r1)
+	SAVE_10GPRS(22, r1)
+
+	/* Load up A - E */
+	lwz	RA(0),0(r3)	/* A */
+	lwz	RB(0),4(r3)	/* B */
+	lwz	RC(0),8(r3)	/* C */
+	lwz	RD(0),12(r3)	/* D */
+	lwz	RE(0),16(r3)	/* E */
+
+	LOADW(0)
+	LOADW(1)
+	LOADW(2)
+	LOADW(3)
+
+	lis	r15,0x5a82	/* K0-19 */
+	ori	r15,r15,0x7999
+	STEP0LD4(0)
+	STEP0LD4(4)
+	STEP0LD4(8)
+	STEPUP4(12, D0)
+	STEPUP4(16, D0)
+
+	lis	r15,0x6ed9	/* K20-39 */
+	ori	r15,r15,0xeba1
+	STEPUP20(20, D1)
+
+	lis	r15,0x8f1b	/* K40-59 */
+	ori	r15,r15,0xbcdc
+	STEPUP20(40, D2)
+
+	lis	r15,0xca62	/* K60-79 */
+	ori	r15,r15,0xc1d6
+	STEPUP4(60, D1)
+	STEPUP4(64, D1)
+	STEPUP4(68, D1)
+	STEPUP4(72, D1)
+	lwz	r20,16(r3)
+	STEPD1(76)
+	lwz	r19,12(r3)
+	STEPD1(77)
+	lwz	r18,8(r3)
+	STEPD1(78)
+	lwz	r17,4(r3)
+	STEPD1(79)
+
+	lwz	r16,0(r3)
+	add	r20,RE(80),r20
+	add	RD(0),RD(80),r19
+	add	RC(0),RC(80),r18
+	add	RB(0),RB(80),r17
+	add	RA(0),RA(80),r16
+	mr	RE(0),r20
+	stw	RA(0),0(r3)
+	stw	RB(0),4(r3)
+	stw	RC(0),8(r3)
+	stw	RD(0),12(r3)
+	stw	RE(0),16(r3)
+
+	REST_8GPRS(14, r1)
+	REST_10GPRS(22, r1)
+	addi	r1,r1,STACKFRAMESIZE
+	blr
diff --git a/arch/powerpc/crypto/sha1.c b/arch/powerpc/crypto/sha1.c
new file mode 100644
index 0000000..f9e8b94
--- /dev/null
+++ b/arch/powerpc/crypto/sha1.c
@@ -0,0 +1,157 @@
+/*
+ * Cryptographic API.
+ *
+ * powerpc implementation of the SHA1 Secure Hash Algorithm.
+ *
+ * Derived from cryptoapi implementation, adapted for in-place
+ * scatterlist interface.
+ *
+ * Derived from "crypto/sha1.c"
+ * Copyright (c) Alan Smithee.
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#include <crypto/internal/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/cryptohash.h>
+#include <linux/types.h>
+#include <crypto/sha.h>
+#include <asm/byteorder.h>
+
+extern void powerpc_sha_transform(u32 *state, const u8 *src, u32 *temp);
+
+static int sha1_init(struct shash_desc *desc)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha1_state){
+		.state = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
+	};
+
+	return 0;
+}
+
+static int sha1_update(struct shash_desc *desc, const u8 *data,
+			unsigned int len)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+
+	partial = sctx->count & 0x3f;
+	sctx->count += len;
+	done = 0;
+	src = data;
+
+	if ((partial + len) > 63) {
+		u32 temp[SHA_WORKSPACE_WORDS];
+
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buffer + partial, data, done + 64);
+			src = sctx->buffer;
+		}
+
+		do {
+			powerpc_sha_transform(sctx->state, src, temp);
+			done += 64;
+			src = data + done;
+		} while (done + 63 < len);
+
+		memset(temp, 0, sizeof(temp));
+		partial = 0;
+	}
+	memcpy(sctx->buffer + partial, src, len - done);
+
+	return 0;
+}
+
+
+/* Add padding and return the message digest. */
+static int sha1_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	__be32 *dst = (__be32 *)out;
+	u32 i, index, padlen;
+	__be64 bits;
+	static const u8 padding[64] = { 0x80, };
+
+	bits = cpu_to_be64(sctx->count << 3);
+
+	/* Pad out to 56 mod 64 */
+	index = sctx->count & 0x3f;
+	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
+	sha1_update(desc, padding, padlen);
+
+	/* Append length */
+	sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Store state in digest */
+	for (i = 0; i < 5; i++)
+		dst[i] = cpu_to_be32(sctx->state[i]);
+
+	/* Wipe context */
+	memset(sctx, 0, sizeof *sctx);
+
+	return 0;
+}
+
+static int sha1_export(struct shash_desc *desc, void *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(out, sctx, sizeof(*sctx));
+	return 0;
+}
+
+static int sha1_import(struct shash_desc *desc, const void *in)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(sctx, in, sizeof(*sctx));
+	return 0;
+}
+
+static struct shash_alg alg = {
+	.digestsize	=	SHA1_DIGEST_SIZE,
+	.init		=	sha1_init,
+	.update		=	sha1_update,
+	.final		=	sha1_final,
+	.export		=	sha1_export,
+	.import		=	sha1_import,
+	.descsize	=	sizeof(struct sha1_state),
+	.statesize	=	sizeof(struct sha1_state),
+	.base		=	{
+		.cra_name	=	"sha1",
+		.cra_driver_name=	"sha1-powerpc",
+		.cra_flags	=	CRYPTO_ALG_TYPE_SHASH,
+		.cra_blocksize	=	SHA1_BLOCK_SIZE,
+		.cra_module	=	THIS_MODULE,
+	}
+};
+
+static int __init sha1_powerpc_mod_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit sha1_powerpc_mod_fini(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_init(sha1_powerpc_mod_init);
+module_exit(sha1_powerpc_mod_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm");
+
+MODULE_ALIAS("sha1-powerpc");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index a323805..777f150 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -433,6 +433,13 @@ config CRYPTO_SHA1_SSSE3
 	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
 	  Extensions (AVX), when available.
 
+config CRYPTO_SHA1_PPC
+	tristate "SHA1 digest algorithm (powerpc)"
+	depends on PPC
+	help
+	  This is the powerpc hardware accelerated implementation of the
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
-- 
1.7.9.5
