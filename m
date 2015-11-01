Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id EAD0B1A065A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 21:49:01 +1100 (AEDT)
Message-Id: <20151101104205.771338878@telegraphics.com.au>
Date: Sun, 01 Nov 2015 21:42:16 +1100
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v7 14/26] powerpc: Implement arch_nvram_ops.get_size() and
 remove old nvram_* exports
References: <20151101104202.301856132@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement arch_nvram_ops for PPC32 and make use of it in the generic_nvram
misc device module so that the nvram_* function exports can be removed.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/powerpc/include/asm/nvram.h |    3 ---
 arch/powerpc/kernel/setup_32.c   |   10 +++++++---
 drivers/char/generic_nvram.c     |   24 ++++++++++++------------
 3 files changed, 19 insertions(+), 18 deletions(-)

Index: linux/arch/powerpc/include/asm/nvram.h
===================================================================
--- linux.orig/arch/powerpc/include/asm/nvram.h	2015-11-01 21:41:38.000000000 +1100
+++ linux/arch/powerpc/include/asm/nvram.h	2015-11-01 21:41:41.000000000 +1100
@@ -98,7 +98,4 @@ extern int nvram_write_os_partition(stru
 				    unsigned int err_type,
 				    unsigned int error_log_cnt);
 
-/* Determine NVRAM size */
-extern ssize_t nvram_get_size(void);
-
 #endif /* _ASM_POWERPC_NVRAM_H */
Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:38.000000000 +1100
+++ linux/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:41.000000000 +1100
@@ -192,13 +192,12 @@ void nvram_write_byte(unsigned char val,
 }
 EXPORT_SYMBOL(nvram_write_byte);
 
-ssize_t nvram_get_size(void)
+static ssize_t ppc_nvram_get_size(void)
 {
 	if (ppc_md.nvram_size)
 		return ppc_md.nvram_size();
-	return -1;
+	return -ENODEV;
 }
-EXPORT_SYMBOL(nvram_get_size);
 
 void nvram_sync(void)
 {
@@ -207,6 +206,11 @@ void nvram_sync(void)
 }
 EXPORT_SYMBOL(nvram_sync);
 
+const struct nvram_ops arch_nvram_ops = {
+	.get_size       = ppc_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
 #endif /* CONFIG_NVRAM */
 
 int __init ppc_init(void)
Index: linux/drivers/char/generic_nvram.c
===================================================================
--- linux.orig/drivers/char/generic_nvram.c	2015-11-01 21:41:38.000000000 +1100
+++ linux/drivers/char/generic_nvram.c	2015-11-01 21:41:41.000000000 +1100
@@ -27,8 +27,6 @@
 #include <asm/machdep.h>
 #endif
 
-#define NVRAM_SIZE	8192
-
 static DEFINE_MUTEX(nvram_mutex);
 static ssize_t nvram_len;
 
@@ -149,20 +147,22 @@ static struct miscdevice nvram_dev = {
 
 int __init nvram_init(void)
 {
-	int ret = 0;
+	int ret;
 
-	printk(KERN_INFO "Generic non-volatile memory driver v%s\n",
-		NVRAM_VERSION);
-	ret = misc_register(&nvram_dev);
-	if (ret != 0)
-		goto out;
+	if (arch_nvram_ops.get_size == NULL)
+		return -ENODEV;
 
-	nvram_len = nvram_get_size();
+	nvram_len = arch_nvram_ops.get_size();
 	if (nvram_len < 0)
-		nvram_len = NVRAM_SIZE;
+		return nvram_len;
 
-out:
-	return ret;
+	ret = misc_register(&nvram_dev);
+	if (ret)
+		return ret;
+
+	pr_info("Generic non-volatile memory driver v%s\n", NVRAM_VERSION);
+
+	return 0;
 }
 
 void __exit nvram_cleanup(void)
