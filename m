Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E09A8DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 15:48:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0P4m0de000599
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 22:48:01 -0600
Date: Thu, 24 Jan 2008 22:45:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] [POWERPC] Add a cuboot wrapper for 85xx with CPM2
Message-ID: <Pine.LNX.4.64.0801242245140.22024@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bd info struct changes if we have CPM2 enabled in u-boot.

---
 arch/powerpc/boot/Makefile           |    6 +++-
 arch/powerpc/boot/cuboot-85xx-cpm2.c |   66 ++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-85xx-cpm2.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1e20aca..1a42970 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -62,7 +62,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
-		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c
+		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
+		cuboot-85xx-cpm2.c
 src-boot := $(src-wlib) $(src-plat) empty.c

 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -200,6 +201,9 @@ image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
 image-$(CONFIG_STORCENTER)		+= cuImage.824x
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
+ifeq ($(CONFIG_CPM2),y)
+image-$(CONFIG_PPC_85xx)		+= cuImage.85xx-cpm2
+endif
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
diff --git a/arch/powerpc/boot/cuboot-85xx-cpm2.c b/arch/powerpc/boot/cuboot-85xx-cpm2.c
new file mode 100644
index 0000000..723872d
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-85xx-cpm2.c
@@ -0,0 +1,66 @@
+/*
+ * Old U-boot compatibility for 85xx
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_85xx
+#define TARGET_CPM2
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void platform_fixups(void)
+{
+	void *devp;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet2", bd.bi_enet2addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 8, bd.bi_busfreq);
+
+	/* Unfortunately, the specific model number is encoded in the
+	 * soc node name in existing dts files -- once that is fixed,
+	 * this can do a simple path lookup.
+	 */
+	devp = find_node_by_devtype(NULL, "soc");
+	if (devp) {
+		void *serial = NULL;
+
+		setprop(devp, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+		while ((serial = find_node_by_devtype(serial, "serial"))) {
+			if (get_parent(serial) != devp)
+				continue;
+
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+		}
+	}
+
+	devp = find_node_by_compatible(NULL, "fsl,cpm2-brg");
+	if (devp)
+		setprop(devp, "clock-frequency", &bd.bi_brgfreq,
+		        sizeof(bd.bi_brgfreq));
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
-- 
1.5.3.7
