Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
In-Reply-To: <20070321063031.GB30422@localhost.localdomain>
Message-Id: <20070321063150.04BA4DDE9F@ozlabs.org>
Date: Wed, 21 Mar 2007 17:31:49 +1100 (EST)
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/boot/devtree.c |  126 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/main.c    |   21 ++-----
 arch/powerpc/boot/ops.h     |   27 ++++++++-
 4 files changed, 160 insertions(+), 16 deletions(-)

Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-03-21 16:50:55.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-03-21 16:50:55.000000000 +1100
@@ -91,11 +91,16 @@ static inline int getprop(void *devp, co
 	return (dt_ops.getprop) ? dt_ops.getprop(devp, name, buf, buflen) : -1;
 }
 
-static inline int setprop(void *devp, const char *name, void *buf, int buflen)
+static inline int setprop(void *devp, const char *name,
+			  const void *buf, int buflen)
 {
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
-
+#define setprop_val(devp, name, val) \
+	do { \
+		typeof(val) x = (val); \
+		setprop((devp), (name), &x, sizeof(x)); \
+	} while(0)
 static inline int setprop_str(void *devp, const char *name, const char *buf)
 {
 	if (dt_ops.setprop)
@@ -140,6 +145,24 @@ static inline void *find_node_by_devtype
 	return find_node_by_prop_value_str(prev, "device_type", type);
 }
 
+int dt_path_getprop(const char *path, const char *name, void *buf, int bufsize);
+void dt_path_setprop(const char *path, const char *name, void *val, int size);
+#define dt_path_setprop_val(path, name, val)	\
+	do { \
+		typeof(val) x = (val); \
+		dt_path_setprop((path),(name),&x,sizeof(x)); \
+	} while (0)
+#define dt_path_setprop_str(path, name, str) \
+	dt_path_setprop((path), (name), (str), strlen(str)+1)
+
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
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-03-21 16:50:55.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-03-21 16:50:55.000000000 +1100
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib)
+		gunzip_util.c $(zlib) devtree.c
 src-plat := of.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-21 16:50:55.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-21 16:50:55.000000000 +1100
@@ -156,9 +156,6 @@ static struct addr_range prep_initrd(str
 				     unsigned long initrd_addr,
 				     unsigned long initrd_size)
 {
-	void *devp;
-	u32 initrd_start, initrd_end;
-
 	/* If we have an image attached to us, it overrides anything
 	 * supplied by the loader. */
 	if (_initrd_end > _initrd_start) {
@@ -197,16 +194,10 @@ static struct addr_range prep_initrd(str
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
+	dt_path_setprop_val("/chosen", "linux,initrd-start",
+			    (u32)(initrd_addr));
+	dt_path_setprop_val("/chosen", "linux,initrd-end",
+			    (u32)(initrd_addr + initrd_size));
 
 	return (struct addr_range){(void *)initrd_addr, initrd_size};
 }
@@ -262,6 +253,10 @@ void start(void *sp)
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, sp);
 
+	/* Ensure that the device tree has a /chosen node */
+	if (! finddevice("/chosen"))
+		create_node(NULL, "chosen");
+
 	vmlinux = prep_kernel();
 	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
 			     loader_info.initrd_size);
Index: working-2.6/arch/powerpc/boot/devtree.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/devtree.c	2007-03-21 16:50:55.000000000 +1100
@@ -0,0 +1,126 @@
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
+int dt_path_getprop(const char *path, const char *name, void *buf, int bufsize)
+{
+	void *devp = finddevice;
+
+	if (devp)
+		return getprop(devp, name, buf, bufsize);
+	return -1;
+}
+
+void dt_path_setprop(const char *path, const char *name, void *val, int size)
+{
+	void *devp = finddevice(path);
+
+	if (! devp)
+		fatal("Couldn't find node %s to poke\n\r", path);
+
+	if (setprop(devp, name, val, size) != 0)
+		fatal("Couldn't set %s property in %s\n\r", name, path);
+}
+
+void dt_fixup_memory(u64 start, u64 size)
+{
+	void *devp;
+	int naddr, nsize, i;
+	u32 memreg[4];
+
+	if (dt_path_getprop("/", "#address-cells", &naddr, sizeof(naddr)) != 0)
+		naddr = 2;
+	if (naddr < 1 || naddr > 2)
+		fatal("Can't cope with #address-cells == %d in /\n\r", naddr);
+
+	if (dt_path_getprop("/", "#size-cells", &nsize, sizeof(nsize)) != 0)
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
+	devp = finddevice("/memory");
+	if (! devp) {
+		void *devp = create_node(NULL, "memory");
+		setprop_str(devp, "device_type", "memory");
+	}
+
+	printf("Memory <- <0x%x", memreg[0]);
+	for (i = 1; i < (naddr + nsize); i++)
+		printf(" 0x%x", memreg[i]);
+	printf("> (%ldMB)\n\r", (unsigned long)(size >> 20));
+
+	setprop(devp, "reg", memreg, (naddr + nsize)*sizeof(u32));
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
+	printf("%s: clock-frequency <- %x (%dMHz)\n\r", path, freq, MHZ(freq));
+	dt_path_setprop_val(path, "clock-frequency", freq);
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
