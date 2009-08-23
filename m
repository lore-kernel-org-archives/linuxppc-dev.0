Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0164B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 23 Aug 2009 12:02:50 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [v2 PATCH 2/2] powerpc/405ex: support cuImage via included dtb
Date: Sun, 23 Aug 2009 10:03:44 +0800
Message-Id: <1250993024-29527-3-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1250993024-29527-1-git-send-email-tiejun.chen@windriver.com>
References: <1250993024-29527-1-git-send-email-tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support cuImage, we need to initialize the required sections and
ensure that it is built.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/boot/Makefile         |    2 +-
 arch/powerpc/boot/cuboot-kilauea.c |   49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-kilauea.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9ae7b7e..3e11611 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -75,7 +75,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c cuboot-amigaone.c
+		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
diff --git a/arch/powerpc/boot/cuboot-kilauea.c b/arch/powerpc/boot/cuboot-kilauea.c
new file mode 100644
index 0000000..b333346
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-kilauea.c
@@ -0,0 +1,49 @@
+/*
+ * Old U-boot compatibility for PPC405EX. This image is already included 
+ * a dtb.    
+ *
+ * Author: Tiejun Chen <tiejun.chen@windriver.com>
+ *
+ * Copyright (C) 2009 Wind River Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "io.h"
+#include "dcr.h"
+#include "stdio.h"
+#include "4xx.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_4xx
+#define TARGET_44x
+#include "ppcboot.h"
+
+#define KILAUEA_SYS_EXT_SERIAL_CLOCK     11059200        /* ext. 11.059MHz clk */
+
+static bd_t bd;
+
+static void kilauea_fixups(void)
+{
+	unsigned long sysclk = 33333333;
+
+	ibm405ex_fixup_clocks(sysclk, KILAUEA_SYS_EXT_SERIAL_CLOCK);
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	platform_ops.fixups = kilauea_fixups;
+	platform_ops.exit = ibm40x_dbcr_reset;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
-- 
1.5.6
