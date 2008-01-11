Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id 9380FDE0F2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:05:19 +1100 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by fusion.kanatek.com with esmtp (Exim 4.66)
	(envelope-from <sean.maclennan@pikatech.com>) id 1JD6TU-0006pN-OC
	for linuxppc-dev@ozlabs.org; Thu, 10 Jan 2008 18:06:12 -0500
Message-ID: <4786B295.3000501@pikatech.com>
Date: Thu, 10 Jan 2008 19:04:37 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com> <47852D16.2070906@pikatech.com>
	<20080110024926.GD17816@localhost.localdomain>
In-Reply-To: <20080110024926.GD17816@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>
> Fold all this into cuboot-warp.c, unless you actually anticipate
> adding another wrapper for another firmware which will also use the
> functions in warp.c.
>
>   
Done.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..b3e4c35 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -469,7 +469,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| PPC_PS3
+		|| PPC_PS3 || 44x
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..cd83c4f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -62,7 +62,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
-		cuboot-katmai.c cuboot-rainier.c
+		cuboot-katmai.c cuboot-rainier.c cuboot-warp.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -206,6 +206,7 @@ image-$(CONFIG_RAINIER)			+= cuImage.rainier
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
+image-$(CONFIG_WARP)			+= cuImage.warp
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/cuboot-warp.c	2008-01-10 15:28:30.000000000 -0500
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "4xx.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void warp_fixups(void)
+{
+	unsigned long sysclk = 66000000;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+	ibm4xx_sdram_fixup_memsize();
+	dt_fixup_mac_addresses(&bd.bi_enetaddr);
+}
+
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	platform_ops.fixups = warp_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
