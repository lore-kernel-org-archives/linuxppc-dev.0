Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31DBFDE111
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 21:16:46 +1100 (EST)
Date: Thu, 13 Dec 2007 19:11:36 +0900 (JST)
Message-Id: <20071213.191136.-1300517100.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 1/2] cleanup calling mmio_nvram_init
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds conditional initialization for mmio_nvram_init().

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Here is the previous discussion:
 http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047435.html


Index: linux-powerpc-git/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/cell/setup.c
@@ -179,9 +179,7 @@ static void __init cell_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_MMIO_NVRAM
 	mmio_nvram_init();
-#endif
 }
 
 static int __init cell_probe(void)
Index: linux-powerpc-git/include/asm-powerpc/nvram.h
===================================================================
--- linux-powerpc-git.orig/include/asm-powerpc/nvram.h
+++ linux-powerpc-git/include/asm-powerpc/nvram.h
@@ -10,6 +10,8 @@
 #ifndef _ASM_POWERPC_NVRAM_H
 #define _ASM_POWERPC_NVRAM_H
 
+#include <linux/errno.h>
+
 #define NVRW_CNT 0x20
 #define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
 #define NVRAM_BLOCK_LEN 16
@@ -71,7 +73,16 @@ extern int nvram_clear_error_log(void);
 extern struct nvram_partition *nvram_find_partition(int sig, const char *name);
 
 extern int pSeries_nvram_init(void);
+
+#ifdef CONFIG_MMIO_NVRAM
 extern int mmio_nvram_init(void);
+#else
+static inline int mmio_nvram_init(void)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* __KERNEL__ */
 
 /* PowerMac specific nvram stuffs */
