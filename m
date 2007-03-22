Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
In-Reply-To: <20070322054812.GA16993@localhost.localdomain>
Message-Id: <20070322060221.655BEDDF2F@ozlabs.org>
Date: Thu, 22 Mar 2007 17:02:21 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a library of useful device tree manipulation functions
to the zImage library, for use by platform code.  These functions are
based on the hooks already in dt_ops, so they're not dependent on a
particular device tree implementation.  This patch also slightly
streamlines the code in main.c using these new functions.

This is a consolidation of my work in this area with Scott Wood's
patches to a very similar end.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/Makefile  |    2 
 arch/powerpc/boot/devtree.c |  111 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/main.c    |   27 ++++------
 arch/powerpc/boot/ops.h     |   13 +++++
 4 files changed, 136 insertions(+), 17 deletions(-)

Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-22 13:47:16.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-22 13:57:23.000000000 +1100
@@ -96,6 +96,11 @@ static inline int setprop(void *devp, co
 {
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
+#define setprop_val(devp, name, val) \
+	do { \
+		typeof(val) x = (val); \
+		setprop((devp), (name), &x, sizeof(x)); \
+	} while (0)
 
 static inline int setprop_str(void *devp, const char *name, const char *buf)
 {
@@ -141,6 +146,14 @@ static inline void *find_node_by_devtype
 	return find_node_by_prop_value_str(prev, "device_type", type);
 }
 
+void dt_fixup_memory(u64 start, u64 size);
+void dt_fixup_cpu_clocks(u32 cpufreq, u32 tbfreq, u32 busfreq);
+void dt_fixup_clock(const char *path, u32 freq);
+void __dt_fixup_mac_addresses(u32 startindex, ...);
+#define dt_fixup_mac_addresses(...) \
+	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
+
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-03-22 13:47:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-03-22 13:57:21.000000000 +1100
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib)
+		gunzip_util.c $(zlib) devtree.c
 src-plat := of.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-22 13:47:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-22 13:57:23.000000000 +1100
@@ -152,13 +152,10 @@ static struct addr_range prep_kernel(voi
 	return (struct addr_range){addr, ei.memsize};
 }
 
-static struct addr_range prep_initrd(struct addr_range vmlinux,
+static struct addr_range prep_initrd(struct addr_range vmlinux, void *chosen,
 				     unsigned long initrd_addr,
 				     unsigned long initrd_size)
 {
-	void *devp;
-	u32 initrd_start, initrd_end;
-
 	/* If we have an image attached to us, it overrides anything
 	 * supplied by the loader. */
 	if (_initrd_end > _initrd_start) {
@@ -197,16 +194,8 @@ static struct addr_range prep_initrd(str
 	printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd_addr));
 
 	/* Tell the kernel initrd address via device tree */
-	devp = finddevice("/chosen");
-	if (! devp)
-		fatal("Device tree has no chosen node!\n\r");
-
-	initrd_start = (u32)initrd_addr;
-	initrd_end = (u32)initrd_addr + initrd_size;
-
-	setprop(devp, "linux,initrd-start", &initrd_start,
-		sizeof(initrd_start));
-	setprop(devp, "linux,initrd-end", &initrd_end, sizeof(initrd_end));
+	setprop_val(chosen, "linux,initrd-start", (u32)(initrd_addr));
+	setprop_val(chosen, "linux,initrd-end", (u32)(initrd_addr+initrd_size));
 
 	return (struct addr_range){(void *)initrd_addr, initrd_size};
 }
@@ -253,6 +242,7 @@ void start(void *sp)
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
 	unsigned long ft_addr = 0;
+	void *chosen;
 
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
@@ -262,9 +252,14 @@ void start(void *sp)
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, sp);
 
+	/* Ensure that the device tree has a /chosen node */
+	chosen = finddevice("/chosen");
+	if (! chosen)
+		chosen = create_node(NULL, "chosen");
+
 	vmlinux = prep_kernel();
-	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
-			     loader_info.initrd_size);
+	initrd = prep_initrd(vmlinux, chosen,
+			     loader_info.initrd_addr, loader_info.initrd_size);
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
Index: working-2.6/arch/powerpc/boot/devtree.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/devtree.c	2007-03-22 13:58:15.000000000 +1100
@@ -0,0 +1,111 @@
+/*
+ * devtree.c - convenience functions for device tree manipulation
+ * Copyright 2007 David Gibson, IBM Corporation.
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * Authors: David Gibson <david@gibson.dropbear.id.au>
+ *	    Scott Wood <scottwood@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+
+void dt_fixup_memory(u64 start, u64 size)
+{
+	void *root, *memory;
+	int naddr, nsize, i;
+	u32 memreg[4];
+
+	root = finddevice("/");
+	if (getprop(root, "#address-cells", &naddr, sizeof(naddr)) < 0)
+		naddr = 2;
+	if (naddr < 1 || naddr > 2)
+		fatal("Can't cope with #address-cells == %d in /\n\r", naddr);
+
+	if (getprop(root, "#size-cells", &nsize, sizeof(nsize)) < 0)
+		nsize = 1;
+	if (nsize < 1 || nsize > 2)
+		fatal("Can't cope with #size-cells == %d in /\n\r", nsize);
+
+	i = 0;
+	if (naddr == 2)
+		memreg[i++] = start >> 32;
+	memreg[i++] = start & 0xffffffff;
+	if (nsize == 2)
+		memreg[i++] = size >> 32;
+	memreg[i++] = size & 0xffffffff;
+
+	memory = finddevice("/memory");
+	if (! memory) {
+		memory = create_node(NULL, "memory");
+		setprop_str(memory, "device_type", "memory");
+	}
+
+	printf("Memory <- <0x%x", memreg[0]);
+	for (i = 1; i < (naddr + nsize); i++)
+		printf(" 0x%x", memreg[i]);
+	printf("> (%ldMB)\n\r", (unsigned long)(size >> 20));
+
+	setprop(memory, "reg", memreg, (naddr + nsize)*sizeof(u32));
+}
+
+#define MHZ(x)	((x + 500000) / 1000000)
+
+void dt_fixup_cpu_clocks(u32 cpu, u32 tb, u32 bus)
+{
+	void *devp = NULL;
+
+	printf("CPU clock-frequency <- 0x%x (%dMHz)\n\r", cpu, MHZ(cpu));
+	printf("CPU timebase-frequency <- 0x%x (%dMHz)\n\r", tb, MHZ(tb));
+	if (bus > 0)
+		printf("CPU bus-frequency <- 0x%x (%dMHz)\n\r", bus, MHZ(bus));
+
+	while ((devp = find_node_by_devtype(devp, "cpu"))) {
+		setprop_val(devp, "clock-frequency", cpu);
+		setprop_val(devp, "timebase-frequency", tb);
+		if (bus > 0)
+			setprop_val(devp, "bus-frequency", bus);
+	}
+}
+
+void dt_fixup_clock(const char *path, u32 freq)
+{
+	void *devp = finddevice(path);
+
+	if (devp) {
+		printf("%s: clock-frequency <- %x (%dMHz)\n\r", path, freq, MHZ(freq));
+		setprop_val(devp, "clock-frequency", freq);
+	}
+}
+
+void __dt_fixup_mac_addresses(u32 startindex, ...)
+{
+	va_list ap;
+	u32 index = startindex;
+	void *devp;
+	const u8 *addr;
+
+	va_start(ap, startindex);
+	while ((addr = va_arg(ap, const u8 *))) {
+		devp = find_node_by_prop_value(NULL, "linux,network-index",
+					       (void*)&index, sizeof(index));
+
+		printf("ENET%d: local-mac-address <-"
+		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
+		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+
+		if (devp)
+			setprop(devp, "local-mac-address", addr, 6);
+
+		index++;
+	}
+	va_end(ap);
+}
