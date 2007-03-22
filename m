Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4574ADE092
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:49:35 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2MJnV8b028209
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:49:32 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2MJnVAc025031
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MJTZRg004525
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:29:35 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 69CE5AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:30 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MJnUKP032002
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 14:49:30 -0500
Date: Thu, 22 Mar 2007 14:49:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070322194930.GF31965@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/cuboot-83xx.c |   70 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-83xx.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 93c25f8..1c6c2e1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib) devtree.c
-cuboot-plats :=
+cuboot-plats := 83xx
 src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
@@ -163,6 +163,7 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+cuboot-plat-$(CONFIG_83xx) += 83xx
 cuboot-plat-y += unknown-platform
 
 dts = $(if $(shell echo $(CONFIG_) | grep '^/'),\
diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
new file mode 100644
index 0000000..76895a7
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -0,0 +1,70 @@
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
+static void *vmlinux_alloc(unsigned long size)
+{
+	void *p = malloc(size);
+
+	if (!p)
+		fatal("Can't allocate memory for kernel image!\n\r");
+
+	return p;
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+	void *soc;
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
+	platform_ops.vmlinux_alloc = vmlinux_alloc;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
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
