Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EFFBDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:26:02 +1000 (EST)
Date: Mon, 16 Apr 2007 18:25:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/4] bootwrapper: cuboot for 83xx
Message-ID: <20070416232555.GC26693@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416232451.GA26667@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds cuboot support for MPC83xx platforms.

A device tree used with this must have linux,stdout-path in /chosen and
linux,network-index in any network device nodes that need mac addresses
assigned.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile      |    3 +-
 arch/powerpc/boot/cuboot-83xx.c |   68 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-83xx.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d602b7c..3e172ff 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c
-src-plat := of.c
+src-plat := of.c cuboot-83xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -162,6 +162,7 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+cuboot-plat-$(CONFIG_83xx) += 83xx
 cuboot-plat-y += unknown-platform
 
 dts = $(if $(shell echo $(CONFIG_) | grep '^/'),\
diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
new file mode 100644
index 0000000..8f11d1e
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -0,0 +1,68 @@
+/*
+ * Old U-boot compatibility for 83xx
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
+
+#define TARGET_83xx
+#include "ppcboot.h"
+
+static bd_t bd;
+extern char _end[];
+extern char _dtb_start[], _dtb_end[];
+
+static void platform_fixups(void)
+{
+	void *soc;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+
+	/* Unfortunately, the specific model number is encoded in the
+	 * soc node name in existing dts files -- once that is fixed,
+	 * this can do a simple path lookup.
+	 */
+	soc = find_node_by_devtype(NULL, "soc");
+	if (soc) {
+		void *serial = NULL;
+
+		setprop(soc, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+		while ((serial = find_node_by_devtype(serial, "serial"))) {
+			if (get_parent(serial) != soc)
+				continue;
+
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+		}
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+
+	memcpy(&bd, (bd_t *)r3, sizeof(bd));
+	loader_info.initrd_addr = r4;
+	loader_info.initrd_size = r4 ? r5 : 0;
+	loader_info.cmdline = (char *)r6;
+	loader_info.cmdline_len = r7 - r6;
+
+	simple_alloc_init(_end, avail_ram, 32, 64);
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
-- 
1.5.0.3
