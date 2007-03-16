Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 502E9DE84A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:19 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHTFp1004503
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:29:16 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHTFV3010027
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:15 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9YBb001470
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:34 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id A445DAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:14 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHTEY8029865
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:29:14 -0500
Date: Fri, 16 Mar 2007 12:29:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/17] bootwrapper: cuboot for 83xx
Message-ID: <20070316172914.GQ29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/cuboot-83xx.c |   75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-83xx.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a51fe08..0a01e70 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c devtree.c $(zlib)
-cuboot-plats :=
+cuboot-plats := 83xx
 src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
@@ -166,6 +166,7 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
+cuboot-plat-$(CONFIG_83xx) += 83xx
 cuboot-plat-y += unknown-platform
 
 $(obj)/cuImage: vmlinux $(wrapperbits)
diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
new file mode 100644
index 0000000..b68d438
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -0,0 +1,75 @@
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
+static void *heap_end;
+extern char _end[];
+extern char _dtb_start[], _dtb_end[];
+
+static void *vmlinux_alloc(unsigned long size)
+{
+	unsigned long start = (unsigned long)heap_end;
+	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
+	start = (start + 3) & ~3;
+
+	if (start + size > end_of_ram) {
+		printf("Can't allocate memory for kernel image!\n\r");
+		printf("%lu bytes requested, %lu bytes available\n\r",
+		       size, end_of_ram - start);
+		exit();
+	}
+
+	return (void *)start;
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	u8 *mac_addrs[2] = { bd.bi_enetaddr, bd.bi_enet1addr };
+	void *soc;
+
+	memcpy(&bd, (bd_t *)r3, sizeof(bd));
+	loader_info.initrd_addr = r4;
+	loader_info.initrd_size = r4 ? r5 : 0;
+
+	heap_end = simple_alloc_init(_end, 512 * 1024, 32, 64);
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.vmlinux_alloc = vmlinux_alloc;
+
+	dt_set_memory(bd.bi_memstart, bd.bi_memsize, 1);
+	set_cmdline((const char *)r6);
+	dt_set_mac_addresses(mac_addrs, 2);
+	dt_set_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq, bd.bi_busfreq / 4);
+
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
-- 
1.5.0.3
