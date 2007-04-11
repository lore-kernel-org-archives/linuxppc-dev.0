Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 818A1DDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 03:17:59 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3BHHtA2101902
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 17:17:55 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3BHHtTY2490610
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:55 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3BHHtXD007916
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:55 +0100
Received: from [9.152.237.70] (dyn-9-152-237-70.boeblingen.de.ibm.com
	[9.152.237.70])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l3BHHttO007909
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:55 +0100
Message-Id: <20070411165702.256910000@linux.vnet.ibm.com>>
References: <20070411164910.657151000@linux.vnet.ibm.com>>
Date: Wed, 11 Apr 2007 18:49:11 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 1/3] cryptoapi: AES with AltiVec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

That's the best I could do. I get 

Average: 4728 msec, approx. 33840 kb/sec || 33 mb/sec
on encryption

Average: 5364 msec, approx. 29828 kb/sec || 29 mb/sec
on decryption

the generic module is faster:

Average: 3853 msec, approx. 41526 kb/sec || 40 mb/sec
on encryption 

Average: 3736 msec, approx. 42826 kb/sec || 41 mb/sec
on decryption

AltiVec measurement was done with "kernel altivec patch" see next patch. Without
it is slower:

Average: 7079 msec, approx. 22602 kb/sec || 22 mb/sec
on encryption

Average: 10083 msec, approx. 15868 kb/sec || 15 mb/sec
on decryption

It would be nice if someone could play around with different machines. This has
been on a ps3.

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Index: ps3-linux/crypto/aes-alti.c
===================================================================
--- /dev/null
+++ ps3-linux/crypto/aes-alti.c
@@ -0,0 +1,136 @@
+/*
+ * based on crypto/aes.c
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <asm/byteorder.h>
+#include <asm/system.h>
+
+#include "aes-altivec.h"
+
+#define AES_MIN_KEY_SIZE	16
+#define AES_MAX_KEY_SIZE	32
+
+#define AES_BLOCK_SIZE		16
+
+/* max rounds is 14. Every round needs 1 vector as key (=4 ints or 16 bytes)
+ * The first slot is the given key
+ */
+
+#define MAX_AES_ROUNDS 15
+#define MAX_AES_KEYSIZE_INT (MAX_AES_ROUNDS *4)
+#define MAX_AES_KEYSIZE_BYTE (MAX_AES_KEYSIZE_INT *4)
+
+struct aes_ctx {
+#ifdef KERN_EMU
+	unsigned char pad0;
+	unsigned char pad1;
+	unsigned char pad2;
+	unsigned char pad3;
+#endif
+	unsigned char key_enc_ch[MAX_AES_KEYSIZE_BYTE];// __attribute__ ((aligned (16)));
+	unsigned char key_dec_ch[MAX_AES_KEYSIZE_BYTE];// __attribute__ ((aligned (16)));
+	unsigned int key_length;
+};
+
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len)
+{
+	struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	u32 *flags = &tfm->crt_flags;
+	u32 i;
+
+	switch (key_len) {
+	case 16:
+		break;
+
+	case 24:
+		break;
+
+	case 32:
+		break;
+
+	default:
+		 *flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		 return -EINVAL;
+	}
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	printk("ctx @ %p\n", ctx);
+	ctx->key_length = key_len;
+	i = expand_key(in_key, key_len/4 , ctx->key_enc_ch, ctx->key_dec_ch);
+
+	preempt_enable();
+	return i;
+}
+
+static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	aes_encrypt_altivec(in, out, ctx->key_enc_ch, ctx->key_length);
+
+	preempt_enable();
+}
+
+static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	aes_decrypt_altivec(in, out, ctx->key_dec_ch, ctx->key_length);
+
+	preempt_enable();
+}
+
+
+static struct crypto_alg aes_alg = {
+	.cra_name			=	"aes",
+	.cra_driver_name	=	"aes-altivec",
+	.cra_priority		=	123,
+	.cra_flags			=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	AES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct aes_ctx),
+	.cra_alignmask		=	15,
+	.cra_module			=	THIS_MODULE,
+	.cra_list			=	LIST_HEAD_INIT(aes_alg.cra_list),
+	.cra_u				=	{
+		.cipher = {
+			.cia_min_keysize	=	AES_MIN_KEY_SIZE,
+			.cia_max_keysize	=	AES_MAX_KEY_SIZE,
+			.cia_setkey	   		= 	aes_set_key,
+			.cia_encrypt	 	=	aes_encrypt,
+			.cia_decrypt	  	=	aes_decrypt
+		}
+	}
+};
+
+static int __init aes_init(void)
+{
+	if (!(cpu_has_feature(CPU_FTR_ALTIVEC))) {
+		printk("aes-alti: No altivec unit available\n");
+		return -ENODEV;
+	}
+
+	return crypto_register_alg(&aes_alg);
+}
+
+static void __exit aes_fini(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
+
+module_init(aes_init);
+module_exit(aes_fini);
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
+MODULE_LICENSE("GPL");
Index: ps3-linux/crypto/aes-altivec.c
===================================================================
--- /dev/null
+++ ps3-linux/crypto/aes-altivec.c
@@ -0,0 +1,706 @@
+/*
+ * AES implementation with AltiVec support.
+ * v.02
+ *
+ * Author:
+ * 			Sebastian Siewior (bigeasy _at_ breakpoint.cc)
+ * 			Arnd Bergmann (arnd _at_ arndb.de)
+ *
+ * License: GPL v2
+ *
+ * Code based on ideas from "Effincient Galois Field Arithmetic on SIMD Architectures" by
+ * Raghav Bhaskar, Prapdeep K. Dubey, Vijay Kumar, Atri Rudra and Animesh Sharma.
+ *
+ * This implementation makes use of AltiVec and asumes therefore big endian (on the other
+ * hand only Intel makes it (still) wrong (well it made porting to 64bit probably a lot of
+ * easier)).
+ * Tables for MixColumn() and InvMixColumn() are adjusted in order to omit ShiftRow in all but
+ * last round.
+ */
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <altivec.h>
+#include <linux/autoconf.h>
+#include "aes-altivec.h"
+
+static const vector unsigned char imm_7Fh = {
+	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
+	0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f
+};
+
+/*
+ * This values are either defined in AES standard or can be
+ * computed.
+ */
+static const unsigned int Rcon[] = {
+	0x00000000, 0x01000000, 0x02000000, 0x04000000, 0x08000000,
+	0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x1b000000,
+	0x36000000
+};
+
+static const vector unsigned char sbox_enc[16] = {
+	{ 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
+	  0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76 },
+	{ 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+	  0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0 },
+	{ 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
+	  0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15 },
+	{ 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
+	  0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75 },
+	{ 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+	  0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84 },
+	{ 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
+	  0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf },
+	{ 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
+	  0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8 },
+	{ 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+	  0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2 },
+	{ 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
+	  0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73 },
+	{ 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
+	  0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb },
+	{ 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+	  0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79 },
+	{ 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
+	  0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08 },
+	{ 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
+	  0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a },
+	{ 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+	  0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e },
+	{ 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
+	  0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf },
+	{ 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
+	  0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 }
+};
+
+static const vector unsigned char shift_round = {
+	0x00, 0x05, 0x0a, 0x0f,
+	0x04, 0x09, 0x0e, 0x03,
+	0x08, 0x0d, 0x02, 0x07,
+	0x0c, 0x01, 0x06, 0x0b
+};
+
+static const vector unsigned char pre_xor_s0 = {
+	0x10, 0x00, 0x00, 0x10,
+	0x14, 0x04, 0x04, 0x14,
+	0x18, 0x08, 0x08, 0x18,
+	0x1c, 0x0c, 0x0c, 0x1c
+};
+
+static const vector unsigned char pre_xor_s1 = {
+	0x15, 0x15, 0x05, 0x00,
+	0x19, 0x19, 0x09, 0x04,
+	0x1d, 0x1d, 0x0d, 0x08,
+	0x11, 0x11, 0x01, 0x0c
+};
+
+static const vector unsigned char pre_xor_s2 = {
+	0x05, 0x1a, 0x1a, 0x05,
+	0x09, 0x1e, 0x1e, 0x09,
+	0x0d, 0x12, 0x12, 0x0d,
+	0x01, 0x16, 0x16, 0x01
+};
+
+static const vector unsigned char pre_xor_s3 = {
+	0x0a, 0x0a, 0x1f, 0x0a,
+	0x0e, 0x0e, 0x13, 0x0e,
+	0x02, 0x02, 0x17, 0x02,
+	0x06, 0x06, 0x1b, 0x06
+};
+
+static const vector unsigned char pre_xor_s4 = {
+	0x0f, 0x0f, 0x0f, 0x1f,
+	0x03, 0x03, 0x03, 0x13,
+	0x07, 0x07, 0x07, 0x17,
+	0x0b, 0x0b, 0x0b, 0x1b
+};
+
+static const vector unsigned char sbox_dec[16] = {
+	{ 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38,
+	  0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb },
+	{ 0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87,
+	  0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb },
+	{ 0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d,
+	  0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e },
+	{ 0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2,
+	  0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25 },
+	{ 0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16,
+	  0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92 },
+	{ 0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda,
+	  0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84 },
+	{ 0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a,
+	  0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06 },
+	{ 0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02,
+	  0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b },
+	{ 0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea,
+	  0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73 },
+	{ 0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85,
+	  0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e },
+	{ 0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89,
+	  0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b },
+	{ 0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20,
+	  0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4 },
+	{ 0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31,
+	  0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f },
+	{ 0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d,
+	  0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef },
+	{ 0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0,
+	  0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61 },
+	{ 0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26,
+	  0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d }
+};
+
+static const vector unsigned char inv_shift_round = {
+	0x00, 0x0d, 0x0a, 0x07,
+	0x04, 0x01, 0x0e, 0x0B,
+	0x08, 0x05, 0x02, 0x0f,
+	0x0c, 0x09, 0x06, 0x03
+};
+
+static const vector unsigned char inv_select_0e_shifted = {
+	0x00, 0x0d, 0x0a, 0x07,
+	0x04, 0x01, 0x0e, 0x0B,
+	0x08, 0x05, 0x02, 0x0f,
+	0x0c, 0x09, 0x06, 0x03
+};
+
+static const vector unsigned char inv_select_0b_shifted = {
+	0x0d, 0x0a, 0x07, 0x00,
+	0x01, 0x0e, 0x0b, 0x04,
+	0x05, 0x02, 0x0f, 0x08,
+	0x09, 0x06, 0x03, 0x0c
+};
+
+static const vector unsigned char inv_select_0d_shifted = {
+	0x0a, 0x07, 0x00, 0x0d,
+	0x0e, 0x0b, 0x04, 0x01,
+	0x02, 0x0f, 0x08, 0x05,
+	0x06, 0x03, 0x0c, 0x09
+};
+
+static const vector unsigned char inv_select_09_shifted = {
+	0x07, 0x00, 0x0d, 0x0a,
+	0x0b, 0x04, 0x01, 0x0e,
+	0x0f, 0x08, 0x05, 0x02,
+	0x03, 0x0c, 0x09, 0x06
+};
+
+static const vector unsigned char inv_select_0e_norm = {
+	0x00, 0x01, 0x02, 0x03,
+	0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b,
+	0x0c, 0x0d, 0x0e, 0x0f
+};
+
+static const vector unsigned char inv_select_0b_norm = {
+	0x01, 0x02, 0x03, 0x00,
+	0x05, 0x06, 0x07, 0x04,
+	0x09, 0x0a, 0x0b, 0x08,
+	0x0d, 0x0e, 0x0f, 0x0c
+};
+
+static const vector unsigned char inv_select_0d_norm = {
+	0x02, 0x03, 0x00, 0x01,
+	0x06, 0x07, 0x04, 0x05,
+	0x0a, 0x0b, 0x08, 0x09,
+	0x0e, 0x0f, 0x0c, 0x0d
+};
+
+static const vector unsigned char inv_select_09_norm = {
+	0x03, 0x00, 0x01, 0x02,
+	0x07, 0x04, 0x05, 0x06,
+	0x0b, 0x08, 0x09, 0x0a,
+	0x0f, 0x0c, 0x0d, 0x0e
+};
+
+#ifdef CONFIG_CRYPTO_AES_ALTIVEC_TABLE
+/* small GF lookup table */
+static const vector unsigned char gf_mul_8_high = {
+	0x00, 0x80, 0x1b, 0x9b, 0x36, 0xb6, 0x2d, 0xad,
+	0x6c, 0xec, 0x77, 0xf7, 0x5a, 0xda, 0x41, 0xc1
+};
+static const vector unsigned char gf_mul_a_high = {
+	0x00, 0xa0, 0x5b, 0xfb, 0xb6, 0x16, 0xed, 0x4d,
+	0x77, 0xd7, 0x2c, 0x8c, 0xc1, 0x61, 0x9a, 0x3a
+};
+static const vector unsigned char gf_mul_c_high = {
+	0x00, 0xc0, 0x9b, 0x5b, 0x2d, 0xed, 0xb6, 0x76,
+	0x5a, 0x9a, 0xc1, 0x01, 0x77, 0xb7, 0xec, 0x2c
+};
+static const vector unsigned char gf_mul_e_high = {
+	0x00, 0xe0, 0xdb, 0x3b, 0xad, 0x4d, 0x76, 0x96,
+	0x41, 0xa1, 0x9a, 0x7a, 0xec, 0x0c, 0x37, 0xd7
+};
+static const vector unsigned char gf_mul_8_low = {
+	0x00, 0x08, 0x10, 0x18, 0x20, 0x28, 0x30, 0x38,
+	0x40, 0x48, 0x50, 0x58, 0x60, 0x68, 0x70, 0x78
+};
+static const vector unsigned char gf_mul_a_low = {
+	0x00, 0x0a, 0x14, 0x1e, 0x28, 0x22, 0x3c, 0x36,
+	0x50, 0x5a, 0x44, 0x4e, 0x78, 0x72, 0x6c, 0x66
+};
+static const vector unsigned char gf_mul_c_low = {
+	0x00, 0x0c, 0x18, 0x14, 0x30, 0x3c, 0x28, 0x24,
+	0x60, 0x6c, 0x78, 0x74, 0x50, 0x5c, 0x48, 0x44
+};
+static const vector unsigned char gf_mul_e_low = {
+	0x00, 0x0e, 0x1c, 0x12, 0x38, 0x36, 0x24, 0x2a,
+	0x70, 0x7e, 0x6c, 0x62, 0x48, 0x46, 0x54, 0x5a
+};
+#endif
+/* encryption code */
+
+static vector unsigned char ByteSub(vector unsigned char state)
+{
+	/* line of the s-box */
+	vector unsigned char line_01, line_23, line_45, line_67,
+		   line_89, line_AB, line_CD, line_EF;
+	/* selector */
+	vector unsigned char sel1, sel2, sel7;
+	/* correct lines */
+	vector unsigned char cor_0123, cor_4567, cor_89AB, cor_CDEF,
+		cor_0to7, cor_8toF;
+	vector unsigned char ret_state;
+	vector unsigned char state_shift2, state_shift1;
+
+	line_01 = vec_perm(sbox_enc[0], sbox_enc[1], state);
+	line_23 = vec_perm(sbox_enc[2], sbox_enc[3], state);
+	line_45 = vec_perm(sbox_enc[4], sbox_enc[5], state);
+	line_67 = vec_perm(sbox_enc[6], sbox_enc[7], state);
+	line_89 = vec_perm(sbox_enc[8], sbox_enc[9], state);
+	line_AB = vec_perm(sbox_enc[10], sbox_enc[11], state);
+	line_CD = vec_perm(sbox_enc[12], sbox_enc[13], state);
+	line_EF = vec_perm(sbox_enc[14], sbox_enc[15], state);
+
+	state_shift2 = vec_vslb(state, vec_splat_u8(2));
+	sel2 = (typeof (sel2)) vec_vcmpgtub(state_shift2, imm_7Fh);
+	cor_0123 = vec_sel(line_01, line_23, sel2);
+	cor_4567 = vec_sel(line_45, line_67, sel2);
+	cor_89AB = vec_sel(line_89, line_AB, sel2);
+	cor_CDEF = vec_sel(line_CD, line_EF, sel2);
+
+	state_shift1 = vec_vslb(state, vec_splat_u8(1));
+	sel1 = (typeof (sel1))vec_vcmpgtub(state_shift1, imm_7Fh);
+	cor_0to7 = vec_sel(cor_0123, cor_4567, sel1);
+	cor_8toF = vec_sel(cor_89AB, cor_CDEF, sel1);
+
+	sel7 = (typeof (sel7))vec_vcmpgtub(state, imm_7Fh);
+	ret_state = vec_sel(cor_0to7, cor_8toF, sel7);
+
+	return ret_state;
+}
+
+static vector unsigned char ShiftRow(vector unsigned char state)
+{
+
+	return vec_perm(state, state, shift_round);
+}
+
+static vector unsigned char MixColumn(vector unsigned char state)
+{
+	vector unsigned char imm_00h, imm_01h;
+	vector unsigned char need_add;
+	vector unsigned char shifted_vec, modul;
+	vector unsigned char toadd, xtimed;
+	vector unsigned char op1, op2, op3, op4, op5;
+	vector unsigned char xor_12, xor_34, xor_1234, ret;
+
+	imm_00h = vec_splat_u8(0x00);
+	imm_01h = vec_splat_u8(0x01);
+
+	modul = vec_splat( vec_lvsr(0, (unsigned char *) 0), 0x0b); // 0x1b
+
+	need_add = (vector unsigned char)vec_vcmpgtub(state, imm_7Fh);
+	shifted_vec = vec_vslb(state, imm_01h);
+
+	toadd = vec_sel(imm_00h, modul, need_add);
+
+	xtimed = vec_xor(toadd, shifted_vec);
+
+	op1 = vec_perm(state, xtimed, pre_xor_s0);
+	op2 = vec_perm(state, xtimed, pre_xor_s1);
+	op3 = vec_perm(state, xtimed, pre_xor_s2);
+	op4 = vec_perm(state, xtimed, pre_xor_s3);
+	op5 = vec_perm(state, xtimed, pre_xor_s4);
+
+	xor_12 = vec_xor(op1, op2);
+	xor_34 = vec_xor(op3, op4);
+	xor_1234 = vec_xor(xor_12, xor_34);
+	ret = vec_xor(xor_1234, op5);
+
+	return ret;
+}
+
+static vector unsigned char AddRoundKey(vector unsigned char state,
+		vector unsigned char key)
+{
+	return vec_xor(state,key);
+}
+
+static vector unsigned char normalRound(vector unsigned char state, vector unsigned char key)
+{
+	vector unsigned char pstate;
+
+	pstate = ByteSub(state);
+	pstate = MixColumn(pstate);
+	pstate = AddRoundKey(pstate, key);
+	return pstate;
+}
+
+static vector unsigned char finalRound(vector unsigned char state, vector unsigned char key)
+{
+	vector unsigned char pstate;
+
+	pstate = ByteSub(state);
+	pstate = ShiftRow(pstate);
+	pstate = AddRoundKey(pstate, key);
+	return pstate;
+}
+
+int aes_encrypt_altivec(const unsigned char *in, unsigned char *out,
+		const unsigned char *kp, unsigned int key_len)
+{
+	unsigned char i;
+	vector unsigned char pstate;
+	const vector unsigned char *key;
+	unsigned char tmpbuf[16]  __attribute__ ((aligned (16)));
+
+	memcpy(tmpbuf, in, sizeof(tmpbuf));
+	pstate = vec_ld(0, tmpbuf);
+	key = (const vector unsigned char*) kp;
+
+	pstate = vec_xor(pstate, *key++);
+
+	switch (key_len) {
+		case 32: /* 14 rounds */
+			pstate = normalRound(pstate, *key++);
+			pstate = normalRound(pstate, *key++);
+
+		case 24: /* 12 rounds */
+			pstate = normalRound(pstate, *key++);
+			pstate = normalRound(pstate, *key++);
+
+		case 16: /* 10 rounds */
+			for (i=0; i<9; i++)
+				pstate = normalRound(pstate, *key++);
+
+			break;
+
+		default:
+			/* unsupported */
+			BUG();
+	}
+
+	pstate = finalRound(pstate, *key);
+
+	vec_st(pstate, 0, tmpbuf);
+	memcpy(out, tmpbuf, 16);
+
+	return 0;
+}
+
+/* decryption code, alternative version */
+
+static vector unsigned char InvByteSub(vector unsigned char state)
+{
+	/* line of the s-box */
+	vector unsigned char line_01, line_23, line_45, line_67,
+		   line_89, line_AB, line_CD, line_EF;
+	/* selector */
+	vector unsigned char sel1, sel2, sel7;
+	/* correct lines */
+	vector unsigned char cor_0123, cor_4567, cor_89AB, cor_CDEF,
+		cor_0to7, cor_8toF;
+	vector unsigned char ret_state;
+	vector unsigned char state_shift2, state_shift1;
+
+	line_01 = vec_perm(sbox_dec[0], sbox_dec[1], state);
+	line_23 = vec_perm(sbox_dec[2], sbox_dec[3], state);
+	line_45 = vec_perm(sbox_dec[4], sbox_dec[5], state);
+	line_67 = vec_perm(sbox_dec[6], sbox_dec[7], state);
+	line_89 = vec_perm(sbox_dec[8], sbox_dec[9], state);
+	line_AB = vec_perm(sbox_dec[10], sbox_dec[11], state);
+	line_CD = vec_perm(sbox_dec[12], sbox_dec[13], state);
+	line_EF = vec_perm(sbox_dec[14], sbox_dec[15], state);
+
+	state_shift2 = vec_vslb(state, vec_splat_u8(2));
+	sel2 = (typeof (sel2)) vec_vcmpgtub(state_shift2, imm_7Fh);
+	cor_0123 = vec_sel(line_01, line_23, sel2);
+	cor_4567 = vec_sel(line_45, line_67, sel2);
+	cor_89AB = vec_sel(line_89, line_AB, sel2);
+	cor_CDEF = vec_sel(line_CD, line_EF, sel2);
+
+	state_shift1 = vec_vslb(state, vec_splat_u8(1));
+	sel1 = (typeof (sel1))vec_vcmpgtub(state_shift1, imm_7Fh);
+	cor_0to7 = vec_sel(cor_0123, cor_4567, sel1);
+	cor_8toF = vec_sel(cor_89AB, cor_CDEF, sel1);
+
+	sel7 = (typeof (sel7))vec_vcmpgtub(state, imm_7Fh);
+	ret_state = vec_sel(cor_0to7, cor_8toF, sel7);
+
+	return ret_state;
+}
+
+static vector unsigned char InvShiftRow(vector unsigned char state)
+{
+
+	return vec_perm(state, state, inv_shift_round);
+}
+
+static vector unsigned char InvMixColumn(vector unsigned char state,
+		vector unsigned char inv_select_0e, vector unsigned char inv_select_0b,
+		vector unsigned char inv_select_0d, vector unsigned char inv_select_09 )
+{
+	vector unsigned char op0, op1, op2, op3, op4, op5;
+	vector unsigned char mul_0e, mul_09, mul_0d, mul_0b;
+	vector unsigned char ret;
+
+#ifdef CONFIG_CRYPTO_AES_ALTIVEC_TABLE
+
+	vector unsigned char state_high, state_low;
+	vector unsigned char imm_04h, imm_0fh;
+	vector unsigned char mul_08, mul_0c, mul_0a;
+	vector unsigned char mul_08_hi, mul_08_lo, mul_0a_hi, mul_0a_lo, mul_0c_hi,
+		   mul_0c_lo, mul_0e_hi, mul_0e_lo;
+
+	/* 19 operations, 1x 8 memory loads */
+	imm_04h = vec_splat_u8(0x04);
+	imm_0fh = vec_splat_u8(0x0f);
+
+	state_high = vec_sr(state, imm_04h);
+	state_low  = vec_and(state, imm_0fh);
+
+	mul_08_hi = vec_perm(gf_mul_8_high, gf_mul_8_high, state_high);
+	mul_0a_hi = vec_perm(gf_mul_a_high, gf_mul_a_high, state_high);
+	mul_0c_hi = vec_perm(gf_mul_c_high, gf_mul_c_high, state_high);
+	mul_0e_hi = vec_perm(gf_mul_e_high, gf_mul_e_high, state_high);
+
+	mul_08_lo = vec_perm(gf_mul_8_low, gf_mul_8_low, state_low);
+	mul_0a_lo = vec_perm(gf_mul_a_low, gf_mul_a_low, state_low);
+	mul_0c_lo = vec_perm(gf_mul_c_low, gf_mul_c_low, state_low);
+	mul_0e_lo = vec_perm(gf_mul_e_low, gf_mul_e_low, state_low);
+
+	mul_08 = vec_xor(mul_08_hi, mul_08_lo);
+	mul_0a = vec_xor(mul_0a_hi, mul_0a_lo);
+	mul_0c = vec_xor(mul_0c_hi, mul_0c_lo);
+	mul_0e = vec_xor(mul_0e_hi, mul_0e_lo);
+
+	mul_09 = vec_xor(mul_08, state);
+	mul_0b = vec_xor(mul_0a, state);
+	mul_0d = vec_xor(mul_0c, state);
+
+#else
+
+	vector unsigned char imm_00h, imm_01h;
+	vector unsigned char need_add;
+	vector unsigned char shifted_vec, modul;
+	vector unsigned char toadd;
+	vector unsigned char mul_2, mul_4, mul_8;
+	vector unsigned char mul_2_4;
+
+	/* 21 operations, 3x 1 memory loads */
+	/* compute 0e, 0b, 0d, 09 in GF */
+	imm_00h = vec_splat_u8(0x00);
+	imm_01h = vec_splat_u8(0x01);
+
+	modul = vec_splat( vec_lvsr(0, (unsigned char *) 0), 0x0b); // 0x1b
+
+	need_add = (vector unsigned char)vec_vcmpgtub(state, imm_7Fh);
+	shifted_vec = vec_vslb(state, imm_01h);
+	toadd = vec_sel(imm_00h, modul, need_add);
+	mul_2 = vec_xor(toadd, shifted_vec);
+
+	need_add = (vector unsigned char)vec_vcmpgtub(mul_2, imm_7Fh);
+	shifted_vec = vec_vslb(mul_2, imm_01h);
+	toadd = vec_sel(imm_00h, modul, need_add);
+	mul_4 = vec_xor(toadd, shifted_vec);
+
+	need_add = (vector unsigned char)vec_vcmpgtub(mul_4, imm_7Fh);
+	shifted_vec = vec_vslb(mul_4, imm_01h);
+	toadd = vec_sel(imm_00h, modul, need_add);
+	mul_8 = vec_xor(toadd, shifted_vec);
+
+	mul_2_4 = vec_xor(mul_2, mul_4);
+	/* 09 = 8 * 1 */
+	mul_09 = vec_xor(mul_8, state);
+
+	/* 0e = 2 * 4 * 8 */
+	mul_0e = vec_xor(mul_2_4, mul_8);
+
+	/* 0b = 2 * 8 * 1 */
+	mul_0b = vec_xor(mul_2, mul_09);
+
+	/* 0d = 4 * 8 * 1 */
+	mul_0d = vec_xor(mul_4, mul_09);
+#endif
+
+	/* prepare vectors for add */
+
+	op0 = vec_perm(mul_0e, mul_0e, inv_select_0e);
+	op1 = vec_perm(mul_0b, mul_0b, inv_select_0b);
+	op2 = vec_perm(mul_0d, mul_0d, inv_select_0d);
+	op3 = vec_perm(mul_09, mul_09, inv_select_09);
+
+	op4 = vec_xor(op0, op1);
+	op5 = vec_xor(op2, op3);
+	ret = vec_xor(op4, op5);
+	return ret;
+}
+
+static vector unsigned char InvNormalRound(vector unsigned char state,
+		vector unsigned char key)
+{
+	vector unsigned char pstate;
+
+	pstate = InvByteSub(state);
+	pstate = InvMixColumn(pstate, inv_select_0e_shifted, inv_select_0b_shifted,
+			inv_select_0d_shifted, inv_select_09_shifted);
+	pstate = AddRoundKey(pstate, key);
+	return pstate;
+}
+
+static vector unsigned char InvfinalRound(vector unsigned char state,
+		vector unsigned char key)
+{
+	vector unsigned char pstate;
+
+	pstate = InvByteSub(state);
+	pstate = InvShiftRow(pstate);
+	pstate = AddRoundKey(pstate, key);
+	return pstate;
+}
+
+int aes_decrypt_altivec(const unsigned char *in, unsigned char *out,
+		const unsigned char *kp, unsigned char key_len)
+{
+	unsigned char i;
+	vector unsigned char pstate;
+	const vector unsigned char *key;
+	unsigned char tmpbuf[16]  __attribute__ ((aligned (16)));
+
+	memcpy(tmpbuf, in, sizeof(tmpbuf));
+	pstate = vec_ld(0, tmpbuf);
+
+	key = (const vector unsigned char*) kp;
+
+	pstate = vec_xor(pstate, *key++);
+
+	switch (key_len) {
+		case 32: /* 14 rounds */
+			pstate = InvNormalRound(pstate, *key++);
+			pstate = InvNormalRound(pstate, *key++);
+
+		case 24: /* 12 rounds */
+			pstate = InvNormalRound(pstate, *key++);
+			pstate = InvNormalRound(pstate, *key++);
+
+		case 16: /* 10 rounds */
+			for (i=0; i<9; i++)
+				pstate = InvNormalRound(pstate, *key++);
+
+			break;
+
+		default:
+			BUG();
+	}
+
+	pstate = InvfinalRound(pstate, *key);
+
+	vec_st(pstate, 0, tmpbuf);
+	memcpy(out, tmpbuf, 16);
+	return 0;
+}
+
+/* expand key */
+
+static unsigned int SubWord(unsigned int in)
+{
+	unsigned char buff[16] __attribute__ ((aligned (16)));
+	vector unsigned char vec_buf;
+
+	buff[0] =  in >> 24;
+	buff[1] = (in >> 16) & 0xff;
+	buff[2] = (in >>  8) & 0xff;
+	buff[3] = in & 0xff;
+
+	vec_buf = vec_ld(0, buff);
+	vec_buf = ByteSub(vec_buf);
+	vec_st(vec_buf, 0, buff);
+	return buff[0] << 24 | buff[1] << 16 | buff[2] << 8 | buff[3];
+}
+
+static unsigned int  RotWord(unsigned int word)
+{
+	return (word << 8 | word >> 24);
+}
+
+int expand_key(const unsigned char *key, unsigned int keylen,
+		unsigned char exp_enc_key[15 *4*4], unsigned char exp_dec_key[15*4*4])
+{
+	unsigned int tmp, i, rounds;
+	unsigned int expanded_key[15 *4] __attribute__ ((aligned (16)));
+	vector unsigned char expanded_dec_key[15];
+	vector unsigned char mixed_key;
+	vector unsigned char *cur_key;
+
+	switch (keylen) {
+		case 4:
+			rounds = 10;
+			break;
+
+		case 6:
+			rounds = 12;
+			break;
+
+		case 8:
+			rounds = 14;
+			break;
+
+		default:
+			/* wrong key size */
+			return -EINVAL;
+	}
+
+	memcpy(expanded_key, key, keylen*4);
+
+	i = keylen;
+
+	/* setup enc key */
+
+	for (; i< 4 * (rounds+1); i++) {
+		tmp = expanded_key[i-1];
+
+		if (!(i % keylen)) {
+			tmp = RotWord(tmp);
+			tmp = SubWord(tmp);
+			tmp ^= Rcon[i / keylen ];
+		} else if (keylen > 6 &&  (i % keylen == 4))
+				tmp = SubWord(tmp);
+
+		expanded_key[i] = expanded_key[i-keylen] ^ tmp;
+	}
+
+	memcpy(exp_enc_key, expanded_key, 15*4*4);
+
+	/* setup dec key: the key is turned arround and prepared for the
+	 * "alternative decryption" mode
+	 */
+
+	cur_key = (vector unsigned char*) expanded_key;
+
+	memcpy(&expanded_dec_key[rounds],      &expanded_key[0], 4*4);
+	memcpy(&expanded_dec_key[0], &expanded_key[(rounds) *4], 4*4);
+
+	cur_key++;
+	for (i = (rounds-1); i> 0; i--) {
+
+		mixed_key = InvMixColumn(*cur_key++, inv_select_0e_norm, inv_select_0b_norm,
+				inv_select_0d_norm, inv_select_09_norm);
+		expanded_dec_key[i] = mixed_key;
+	}
+
+	memcpy(exp_dec_key, expanded_dec_key, 15*4*4);
+	return 0;
+}
Index: ps3-linux/crypto/aes-altivec.h
===================================================================
--- /dev/null
+++ ps3-linux/crypto/aes-altivec.h
@@ -0,0 +1,12 @@
+#ifndef  __AES_ALTIVEC_H__
+#define  __AES_ALTIVEC_H__
+
+extern int expand_key(const unsigned char *key, unsigned int keylen,
+		unsigned char exp_enc_key[15 *4*4], unsigned char expanded_dec_key[15*4*4]);
+
+extern int aes_encrypt_altivec(const unsigned char *in, unsigned char *out,
+		const unsigned char *kp, unsigned int key_len);
+
+extern int aes_decrypt_altivec(const unsigned char *in, unsigned char *out,
+		         const unsigned char *kp, unsigned char key_len);
+#endif
Index: ps3-linux/crypto/Kconfig
===================================================================
--- ps3-linux.orig/crypto/Kconfig
+++ ps3-linux/crypto/Kconfig
@@ -325,6 +325,21 @@ config CRYPTO_AES_X86_64
 
 	  See <http://csrc.nist.gov/encryption/aes/> for more information.
 
+config CRYPTO_AES_ALTIVEC
+	tristate "AES with AltiVec support"
+	select CRYPTO_ALGAPI
+	depends on ALTIVEC
+	help
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
+	  algorithm. This implementation has AltiVec support.
+
+config CRYPTO_AES_ALTIVEC_TABLE
+	bool "Use table lookup for decryption"
+	depends on CRYPTO_AES_ALTIVEC
+	help
+	  Use precomputed tables for decryption instead of computing
+	  "by hand" in GF. This solution is slower.
+
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
 	select CRYPTO_ALGAPI
Index: ps3-linux/crypto/Makefile
===================================================================
--- ps3-linux.orig/crypto/Makefile
+++ ps3-linux/crypto/Makefile
@@ -48,3 +48,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
+
+CFLAGS_aes-altivec.o += -O3  -maltivec -mcpu=cell
+aes_altivec-objs := aes-alti.o aes-altivec.o
+obj-$(CONFIG_CRYPTO_AES_ALTIVEC) += aes_altivec.o

--
