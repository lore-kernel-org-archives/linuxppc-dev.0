Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29B8CDDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 22:24:06 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3HCO1ZN320462
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 12:24:01 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3HCO1WG2551966
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:24:01 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3HCO1R9025754
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:24:01 +0100
Received: from [9.152.237.70] (dyn-9-152-237-70.boeblingen.de.ibm.com
	[9.152.237.70])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l3HCO1Yo025751
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:24:01 +0100
Message-Id: <20070417120925.673710000@linux.vnet.ibm.com>>
References: <20070417115206.709701000@linux.vnet.ibm.com>>
Date: Tue, 17 Apr 2007 13:52:09 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 3/3] cryptoapi: speed test
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This has been used for performance testing of my aes altivec code.

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Index: linux/crypto/limi-speed.c
===================================================================
--- /dev/null
+++ linux/crypto/limi-speed.c
@@ -0,0 +1,140 @@
+/*
+ * Code derived von crypt/tcrypt.h
+ *
+ * Small speed test with time resolution in msec.
+ * Author: Sebastian Siewior (bigeasy _at_ breakpoint.cc)
+ * License: GPL v2
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/scatterlist.h>
+#include <linux/crypto.h>
+#include <linux/jiffies.h>
+#include <linux/types.h>
+
+static char *in;
+
+static unsigned int buff_size = 16 * 1024;
+module_param(buff_size, uint, 0444);
+MODULE_PARM_DESC(buff_size, "Buffer allocated by kmalloc()");
+
+static unsigned int keylen = 16;
+module_param(keylen, uint, 0444);
+MODULE_PARM_DESC(keylen, "Length of the key (16,24 or 32 bits");
+
+static unsigned int mode = 0;
+module_param(mode, uint, 0444);
+MODULE_PARM_DESC(mode, "0 -> encryption else decryption");
+
+static unsigned int big_loops = 10;
+module_param(big_loops, uint, 0444);
+MODULE_PARM_DESC(big_loops, "Number of mensurations.");
+
+static unsigned int small_loops = 10000;
+module_param(small_loops, uint, 0444);
+MODULE_PARM_DESC(small_loops, "loops within one mesurement.");
+
+static unsigned int alg = 1;
+module_param(alg, uint, 0444);
+MODULE_PARM_DESC(alg, "0 -> ecb(aes), else -> cbc(aes)");
+
+static int __init init(void)
+{
+	struct scatterlist sg[1];
+	struct crypto_blkcipher *tfm;
+	struct blkcipher_desc desc;
+	unsigned int i;
+	unsigned int ret;
+	unsigned int iv_len;
+	unsigned long start, end;
+	unsigned long total = 0;
+	unsigned long size_kb;
+    unsigned char key[32] = { 1, 2, 3, 4, 5, 6 };
+	const unsigned char *algname;
+
+	algname = alg ? "cbc(aes)" : "ecb(aes)";
+	printk("Limi-speed: %s buff_size: %u, keylen: %d, mode: %s\n", algname, buff_size, keylen,
+			mode ? "decryption" : "encryption");
+	printk("loops: %d, iterations: %d, ", big_loops, small_loops);
+	size_kb = small_loops * buff_size / 1024;
+	printk("=> %lu kb or %lu mb a loop\n", size_kb, size_kb/1024);
+
+	if (keylen != 16 && keylen != 24 && keylen != 32) {
+		printk("Invalid keysize\n");
+		return -EINVAL;
+	}
+
+	in = kmalloc(buff_size, GFP_KERNEL);
+	if (in == NULL) {
+		printk("Failed to allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	memset(in, 0x24, buff_size);
+
+	sg_set_buf(sg, in, buff_size);
+
+	tfm = crypto_alloc_blkcipher(algname, 0, CRYPTO_ALG_ASYNC);
+
+	if (IS_ERR(tfm)) {
+		printk("failed to load transform for %s: %ld\n", algname, PTR_ERR(tfm));
+		goto leave;
+	}
+
+	crypto_blkcipher_setkey(tfm, key, keylen);
+
+	iv_len = crypto_blkcipher_ivsize(tfm);
+	if (iv_len)
+		crypto_blkcipher_set_iv(tfm, in, iv_len);
+
+	desc.tfm = tfm;
+	desc.flags = 0;
+
+	for (i=0 ; i<big_loops; i++) {
+		int j;
+		start = jiffies;
+		ret = 0;
+
+		for (j=0; j < small_loops && !ret; j++) {
+
+			if (!mode)
+				ret = crypto_blkcipher_encrypt(&desc, sg, sg, buff_size);
+			else
+				ret = crypto_blkcipher_decrypt(&desc, sg, sg, buff_size);
+		}
+
+		if (ret) {
+			printk("encryption failed: %d after (i,j) (%u,%u) iterations\n", ret, i, j);
+			goto leave_loop;
+		}
+		end = jiffies;
+		if ( !time_after(start, end)) {
+			printk("Run: %u msec\n", jiffies_to_msecs(end - start));
+			total += jiffies_to_msecs(end - start);
+		} else {
+			printk("Run: %u msec\n", jiffies_to_msecs(start - end));
+			total += jiffies_to_msecs(start - end);
+		}
+	}
+
+	total /= big_loops;
+	size_kb *= 1000;
+	size_kb /= total;
+	printk("Average: %lu msec, approx. %lu kb/sec || %lu mb/sec  \n", total,
+			size_kb, size_kb/1024);
+
+leave_loop:
+	crypto_free_blkcipher(tfm);
+
+leave:
+	kfree(in);
+	return -ENODEV;
+}
+
+static void __exit fini(void) { }
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
Index: linux/crypto/Kconfig
===================================================================
--- linux.orig/crypto/Kconfig
+++ linux/crypto/Kconfig
@@ -462,6 +462,12 @@ config CRYPTO_TEST
 	help
 	  Quick & dirty crypto test module.
 
+config CRYPTO_LIMI_SPEED
+	tristate "Crypto algorithm speed test with msec resolution"
+	help
+	  insmod/modprobe the module, and watch dmesg for results.
+	  Test is for aes only, see modinfo for options
+
 source "drivers/crypto/Kconfig"
 
 endif	# if CRYPTO
Index: linux/crypto/Makefile
===================================================================
--- linux.orig/crypto/Makefile
+++ linux/crypto/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
 CFLAGS_aes-altivec.o += -O3  -maltivec
 aes_altivec-objs := aes-alti.o aes-altivec.o
 obj-$(CONFIG_CRYPTO_AES_ALTIVEC) += aes_altivec.o
+obj-$(CONFIG_CRYPTO_LIMI_SPEED) += limi-speed.o

--
