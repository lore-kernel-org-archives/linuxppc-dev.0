Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Dec 2007 15:30:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
Message-ID: <20071203043033.GK26919@localhost.localdomain>
References: <20071112041126.GB2047@localhost.localdomain>
	<20071112041525.2AE33DDED7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071112041525.2AE33DDED7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use embedded libfdt in the bootwrapper

This patch incorporates libfdt (from the source embedded in an earlier
patch) into the wrapper.a library used by the bootwrapper.  This
includes adding a libfdt_env.h file, which the libfdt sources need in
order to integrate into the bootwrapper environment, and a
libfdt-wrapper.c which provides glue to connect the bootwrappers
abstract device tree callbacks to the libfdt functions.

In addition, this patch changes the various wrapper and platform files
to use libfdt functions instead of the older flatdevtree.c library.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Fixed for O= builds.

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-12-03 15:23:08.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-12-03 15:24:22.000000000 +1100
@@ -33,7 +33,7 @@ ifeq ($(call cc-option-yn, -fstack-prote
 BOOTCFLAGS	+= -fno-stack-protector
 endif
 
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/dtc-src/libfdt
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
@@ -46,7 +46,9 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
 	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 
+src-libfdt := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
+		$(addprefix dtc-src/libfdt/,$(src-libfdt)) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
@@ -101,8 +103,10 @@ quiet_cmd_bootar = BOOTAR  $@
       cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
 
 $(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c FORCE
+	$(Q)mkdir -p $(dir $@)
 	$(call if_changed_dep,bootcc)
 $(patsubst %.S,%.o, $(filter %.S, $(src-boot))): %.o: %.S FORCE
+	$(Q)mkdir -p $(dir $@)
 	$(call if_changed_dep,bootas)
 
 $(obj)/wrapper.a: $(obj-wlib) FORCE
Index: working-2.6/arch/powerpc/boot/libfdt_env.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/libfdt_env.h	2007-12-03 15:23:28.000000000 +1100
@@ -0,0 +1,17 @@
+#ifndef _ARCH_POWERPC_BOOT_LIBFDT_ENV_H
+#define _ARCH_POWERPC_BOOT_LIBFDT_ENV_H
+
+#include <types.h>
+#include <string.h>
+
+typedef u32 uint32_t;
+typedef u64 uint64_t;
+
+#define fdt16_to_cpu(x)		(x)
+#define cpu_to_fdt16(x)		(x)
+#define fdt32_to_cpu(x)		(x)
+#define cpu_to_fdt32(x)		(x)
+#define fdt64_to_cpu(x)		(x)
+#define cpu_to_fdt64(x)		(x)
+
+#endif /* _ARCH_POWERPC_BOOT_LIBFDT_ENV_H */
Index: working-2.6/arch/powerpc/boot/bamboo.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/bamboo.c	2007-12-03 15:20:04.000000000 +1100
+++ working-2.6/arch/powerpc/boot/bamboo.c	2007-12-03 15:23:28.000000000 +1100
@@ -42,6 +42,6 @@ void bamboo_init(void *mac0, void *mac1)
 	platform_ops.exit = ibm44x_dbcr_reset;
 	bamboo_mac0 = mac0;
 	bamboo_mac1 = mac1;
-	ft_init(_dtb_start, 0, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 }
Index: working-2.6/arch/powerpc/boot/cuboot-52xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-52xx.c	2007-12-03 15:20:04.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-52xx.c	2007-12-03 15:23:28.000000000 +1100
@@ -53,7 +53,7 @@ void platform_init(unsigned long r3, uns
                    unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-83xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-83xx.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-83xx.c	2007-12-03 15:23:28.000000000 +1100
@@ -52,7 +52,7 @@ void platform_init(unsigned long r3, uns
                    unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-85xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-85xx.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-85xx.c	2007-12-03 15:23:28.000000000 +1100
@@ -53,7 +53,7 @@ void platform_init(unsigned long r3, uns
                    unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-8xx.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-8xx.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-8xx.c	2007-12-03 15:23:28.000000000 +1100
@@ -41,7 +41,7 @@ void platform_init(unsigned long r3, uns
                    unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-hpc2.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-hpc2.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-hpc2.c	2007-12-03 15:23:28.000000000 +1100
@@ -42,7 +42,7 @@ void platform_init(unsigned long r3, uns
 		unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-pq2.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-pq2.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-pq2.c	2007-12-03 15:23:28.000000000 +1100
@@ -255,7 +255,7 @@ void platform_init(unsigned long r3, uns
                    unsigned long r6, unsigned long r7)
 {
 	CUBOOT_INIT();
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 	platform_ops.fixups = pq2_platform_fixups;
 }
Index: working-2.6/arch/powerpc/boot/cuboot-sequoia.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/cuboot-sequoia.c	2007-12-03 15:23:28.000000000 +1100
@@ -51,6 +51,6 @@ void platform_init(unsigned long r3, uns
 	CUBOOT_INIT();
 	platform_ops.fixups = sequoia_fixups;
 	platform_ops.exit = ibm44x_dbcr_reset;
-	ft_init(_dtb_start, 0, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 }
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-12-03 15:23:28.000000000 +1100
@@ -146,6 +146,6 @@ void ebony_init(void *mac0, void *mac1)
 	platform_ops.exit = ibm44x_dbcr_reset;
 	ebony_mac0 = mac0;
 	ebony_mac1 = mac1;
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 }
Index: working-2.6/arch/powerpc/boot/ep88xc.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ep88xc.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ep88xc.c	2007-12-03 15:23:28.000000000 +1100
@@ -45,7 +45,7 @@ void platform_init(unsigned long r3, uns
 	mem_size *= 1024 * 1024;
 	simple_alloc_init(_end, mem_size - (unsigned long)_end, 32, 64);
 
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 
 	planetcore_set_stdout_path(table);
 
Index: working-2.6/arch/powerpc/boot/holly.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/holly.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/holly.c	2007-12-03 15:23:28.000000000 +1100
@@ -28,6 +28,6 @@ void platform_init(unsigned long r3, uns
 	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
 
 	simple_alloc_init(_end, heapsize, 32, 64);
-	ft_init(_dtb_start, 0, 4);
+	fdt_init(_dtb_start);
 	serial_console_init();
 }
Index: working-2.6/arch/powerpc/boot/libfdt-wrapper.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/libfdt-wrapper.c	2007-12-03 15:23:28.000000000 +1100
@@ -0,0 +1,182 @@
+/*
+ * This file does the necessary interface mapping between the bootwrapper
+ * device tree operations and the interface provided by shared source
+ * files flatdevicetree.[ch].
+ *
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include <page.h>
+#include <libfdt.h>
+#include "ops.h"
+
+#define DEBUG	0
+#define BAD_ERROR(err)	(((err) < 0) \
+			 && ((err) != -FDT_ERR_NOTFOUND) \
+			 && ((err) != -FDT_ERR_EXISTS))
+
+#define check_err(err) \
+	({ \
+		if (BAD_ERROR(err) || ((err < 0) && DEBUG)) \
+			printf("%s():%d  %s\n\r", __FUNCTION__, __LINE__, \
+			       fdt_strerror(err)); \
+		if (BAD_ERROR(err)) \
+			exit(); \
+		(err < 0) ? -1 : 0; \
+	})
+
+#define offset_devp(off)	\
+	({ \
+		int offset = (off); \
+		check_err(offset) ? NULL : (void *)(offset+1); \
+	})
+
+#define devp_offset(devp)	(((int)(devp))-1)
+
+static void *fdt;
+static void *buf; /* = NULL */
+
+#define EXPAND_GRANULARITY	1024
+
+static void expand_buf(int minexpand)
+{
+	int size = fdt_totalsize(fdt);
+	int rc;
+
+	size = _ALIGN(size + minexpand, EXPAND_GRANULARITY);
+	buf = platform_ops.realloc(buf, size);
+	if (!buf)
+		fatal("Couldn't find %d bytes to expand device tree\n\r", size);
+	rc = fdt_open_into(fdt, buf, size);
+	if (rc != 0)
+		fatal("Couldn't expand fdt into new buffer: %s\n\r",
+		      fdt_strerror(rc));
+
+	fdt = buf;
+}
+
+static void *fdt_wrapper_finddevice(const char *path)
+{
+	return offset_devp(fdt_path_offset(fdt, path));
+}
+
+static int fdt_wrapper_getprop(const void *devp, const char *name,
+			       void *buf, const int buflen)
+{
+	const void *p;
+	int len;
+
+	p = fdt_getprop(fdt, devp_offset(devp), name, &len);
+	if (!p)
+		return check_err(len);
+	memcpy(buf, p, min(len, buflen));
+	return len;
+}
+
+static int fdt_wrapper_setprop(const void *devp, const char *name,
+			       const void *buf, const int len)
+{
+	int rc;
+
+	rc = fdt_setprop(fdt, devp_offset(devp), name, buf, len);
+	if (rc == -FDT_ERR_NOSPACE) {
+		expand_buf(len + 16);
+		rc = fdt_setprop(fdt, devp_offset(devp), name, buf, len);
+	}
+
+	return check_err(rc);
+}
+
+static void *fdt_wrapper_get_parent(const void *devp)
+{
+	return offset_devp(fdt_parent_offset(fdt, devp_offset(devp)));
+}
+
+static void *fdt_wrapper_create_node(const void *devp, const char *name)
+{
+	int offset;
+
+	offset = fdt_add_subnode(fdt, devp_offset(devp), name);
+	if (offset == -FDT_ERR_NOSPACE) {
+		expand_buf(strlen(name) + 16);
+		offset = fdt_add_subnode(fdt, devp_offset(devp), name);
+	}
+
+	return offset_devp(offset);
+}
+
+static void *fdt_wrapper_find_node_by_prop_value(const void *prev,
+						 const char *name,
+						 const char *val,
+						 int len)
+{
+	return offset_devp(fdt_node_offset_by_prop_value(fdt, devp_offset(prev),
+							 name, val, len));
+}
+
+static char *fdt_wrapper_get_path(const void *devp, char *buf, int len)
+{
+	int rc;
+
+	rc = fdt_get_path(fdt, devp_offset(devp), buf, len);
+	if (check_err(rc))
+		return NULL;
+	return buf;
+}
+
+static unsigned long fdt_wrapper_finalize(void)
+{
+	int rc;
+
+	rc = fdt_pack(fdt);
+	if (rc != 0)
+		fatal("Couldn't pack flat tree: %s\n\r",
+		      fdt_strerror(rc));
+	return (unsigned long)fdt;
+}
+
+void fdt_init(void *blob)
+{
+	int err;
+
+	dt_ops.finddevice = fdt_wrapper_finddevice;
+	dt_ops.getprop = fdt_wrapper_getprop;
+	dt_ops.setprop = fdt_wrapper_setprop;
+	dt_ops.get_parent = fdt_wrapper_get_parent;
+	dt_ops.create_node = fdt_wrapper_create_node;
+	dt_ops.find_node_by_prop_value = fdt_wrapper_find_node_by_prop_value;
+	dt_ops.get_path = fdt_wrapper_get_path;
+	dt_ops.finalize = fdt_wrapper_finalize;
+
+	/* Make sure the dt blob is the right version and so forth */
+	fdt = blob;
+	err = fdt_open_into(fdt, fdt, fdt_totalsize(blob));
+	if (err == -FDT_ERR_NOSPACE) {
+		int bufsize = fdt_totalsize(fdt) + 4;
+		buf = malloc(bufsize);
+		err = fdt_open_into(fdt, buf, bufsize);
+	}
+
+	if (err != 0)
+		fatal("fdt_init(): %s\n\r", fdt_strerror(err));
+
+	if (buf)
+		fdt = buf;
+}
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-12-03 15:23:28.000000000 +1100
@@ -80,6 +80,7 @@ extern struct loader_info loader_info;
 
 void start(void);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
+void fdt_init(void *blob);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 int mpsc_console_init(void *devp, struct serial_console_data *scdp);
Index: working-2.6/arch/powerpc/boot/prpmc2800.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/prpmc2800.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/prpmc2800.c	2007-12-03 15:23:28.000000000 +1100
@@ -547,8 +547,7 @@ void platform_init(unsigned long r3, uns
 	if (!dtb)
 		exit();
 	memmove(dtb, _dtb_start, dt_size);
-	if (ft_init(dtb, dt_size, 16))
-		exit();
+	fdt_init(dtb);
 
 	bridge_base = mv64x60_get_bridge_base();
 
Index: working-2.6/arch/powerpc/boot/ps3.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ps3.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ps3.c	2007-12-03 15:23:28.000000000 +1100
@@ -131,7 +131,7 @@ void platform_init(void)
 	printf("\n-- PS3 bootwrapper --\n");
 
 	simple_alloc_init(_end, heapsize, 32, 64);
-	ft_init(_dtb_start, 0, 4);
+	fdt_init(_dtb_start);
 
 	chosen = finddevice("/chosen");
 
Index: working-2.6/arch/powerpc/boot/treeboot-walnut.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/treeboot-walnut.c	2007-12-03 15:20:05.000000000 +1100
+++ working-2.6/arch/powerpc/boot/treeboot-walnut.c	2007-12-03 15:23:28.000000000 +1100
@@ -128,6 +128,6 @@ void platform_init(void)
 	simple_alloc_init(_end, avail_ram, 32, 32);
 	platform_ops.fixups = walnut_fixups;
 	platform_ops.exit = ibm40x_dbcr_reset;
-	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	fdt_init(_dtb_start);
 	serial_console_init();
 }


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
