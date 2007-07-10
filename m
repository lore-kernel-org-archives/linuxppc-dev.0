Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:10:20 -0500 (CDT)
Subject: [PATCH 7/15] bootwrapper: Add kexec callable zImage wrapper
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-07.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This code creates a 32 bit zImage wrapper for a 32 or 64 bit PowerPC
Linux kernel.   This allows you to kexec a zImage with its compressed
vmlinux instead of the uncompressed vmlinux elf.  The elf is also
packaged as a 64 bit elf for use by kexec-tools for 64 bit kernels.

Limitations:

The memory node off the root with a name starting with "memory" must
contain enough free memory (not in the reserved ranges) in the first
reg range to uncompress the the kernel with padding.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I split a few more routines out from this file.

I removed the call serial_console_init because some of the serial
console require a loader supplied virtural address mapping which
will not exist when called from kexec.

Successfully boots from and to a 64 bit kernel when loaded at 0 and
when loaded after the kernel _end on machines with with initrds,
rtas, and various other data reserved.

The next patch needed to load using kexec-tools without an externally
generated flat device tree.

Index: work.git/arch/powerpc/boot/kexec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/kexec.c	2007-07-10 16:37:30.000000000 -0500
@@ -0,0 +1,181 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright IBM Corporation 2007
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "flatdevtree.h"
+#include "page.h"
+#include "types.h"
+
+extern char _start[];
+extern char _end[];
+
+BSS_STACK(16*1024);
+
+static void find_console_from_tree(void)
+{
+	int rc = -1;
+
+	if (rc) {
+		/* no console, oh well */
+	}
+}
+
+/* fixme: use find_device_by_type "memory" and xlate_reg */
+static void find_rmo_end(void)
+{
+	unsigned int na, ns, reg[4], *rp;
+	void *devp;
+	int rc;
+
+	devp = finddevice("/");
+	if (!devp)
+		fatal("Ack, device-tree root");
+	rc = getprop(devp, "#address-cells", &na, sizeof(na));
+	if (rc != sizeof(na))
+		fatal("Ack, no #address-cells in root");
+	rc = getprop(devp, "#size-cells", &ns, sizeof(ns));
+	if (rc != sizeof(ns))
+		fatal("Ack, no #size-cells in root");
+	if (!na || !ns || na + ns > ARRAY_SIZE(reg))
+		fatal("#addr-cells or #size-cells unusable");
+	do {
+		devp = finddevice("/memory@0");
+		if (!devp)
+			devp = finddevice("/memory");
+		if (!devp)
+			devp = finddevice("/memory@00000000");
+		if (!devp)
+			devp = finddevice("/memory@0000000000000000");
+		if (!devp)
+			fatal("Ack, can't find  memory");
+		rc = getprop(devp, "reg", reg, sizeof(reg));
+		if (rc < (na + ns) * sizeof(int))
+			fatal("Ack, no valid reg property in memory");
+
+		rp = &reg[0];
+		while (na--) {
+			if (*rp)
+				fatal("didn't find memory at 0");
+			rp++;
+		}
+		while (--ns) {
+			if (*rp) {
+				/* first range >= 4G , use 2G */
+				rmo_end = (void *)0x80000000;
+				return;
+			}
+			rp++;
+		}
+	} while (0);
+
+	rmo_end = (void *)*rp;
+}
+
+/**
+ * setup_initial_heap - setup a small heap in the bss
+ * Using a preallocated heap, setup for scanning the device tree.
+ * Intended for the initial read while the tree will remain read-only so
+ * a minimal malloc and search limit can be used.  This way we don't have
+ * lots of data or bss to clear.
+ */
+static void setup_initial_heap(void)
+{
+	static char initial_heap[8*1024];
+	void *heap_end;
+
+	heap_end = simple_alloc_init(initial_heap,
+			sizeof(initial_heap) * 7 / 8,
+			sizeof(long), 64);
+
+	if (heap_end - sizeof(initial_heap) > (void *)&initial_heap[0])
+		fatal("Initial heap too big\n\r");
+}
+
+static void early_scan_flat_tree(struct boot_param_header *dt_blob)
+{
+	int rc;
+
+	rc = ft_init(dt_blob, dt_blob->totalsize, 50);
+	if (rc)
+		fatal("couldn't initialize device-tree\n\r");
+
+	find_rmo_end();
+	dt_find_initrd();
+}
+
+static void init_flat_tree(struct boot_param_header *dt_blob)
+{
+	int rc;
+
+	rc = ft_init(dt_blob, dt_blob->totalsize, /* max_finddevice */ 1024);
+	if (rc)
+		fatal("Unable to initialize device_tree library!\n\r");
+}
+
+static void *saved_vmlinux_addr;
+
+static void *kexec_vmlinux_alloc(unsigned long size)
+{
+	void *addr;
+
+	addr = ranges_vmlinux_alloc(size);
+
+	saved_vmlinux_addr = addr;
+	return addr;
+}
+
+static void kexec_fixups(void)
+{
+	wait_slaves_moved();
+}
+
+static unsigned long (*finalize_chain)(void);
+
+static unsigned long kexec_finalize(void)
+{
+	send_slaves_to_kernel(saved_vmlinux_addr);
+
+	return finalize_chain();
+}
+
+void kexec_platform_init(struct boot_param_header *dt_blob)
+{
+	slaves_are_low();
+	move_slaves_up();
+
+	setup_initial_heap();
+	early_scan_flat_tree(dt_blob);
+
+	/* drivers can malloc and read the tree, but not realloc later
+	 * or modify the tree now.
+	 */
+	if (!console_ops.write)
+		find_console_from_tree();
+
+	add_known_ranges(dt_blob);
+	ranges_init_malloc();
+	init_flat_tree(dt_blob);
+
+	platform_ops.vmlinux_alloc = kexec_vmlinux_alloc;
+	platform_ops.fixups = kexec_fixups;
+	finalize_chain = dt_ops.finalize;
+	dt_ops.finalize = kexec_finalize;
+}
Index: work.git/arch/powerpc/boot/crt0_kexec.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/crt0_kexec.S	2007-07-10 16:37:30.000000000 -0500
@@ -0,0 +1,45 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+	/*
+	 * The kernel calls out to the first image with
+	 * r3 = boot cpu, r4 = entrypoint, r5 = 0
+	 *
+	 * kexec-tools purgatory calls this as it would a linux kernel:
+	 * r3 = boot block, r4 = entrypoint, r5 = 0
+	 *
+	 * The boot block boot_cpu field has been filled in.
+	 *
+	 * kexec-tools and its purgatory are suppposed to copy SMP_SLAVE_SIZE
+	 * bytes from the from entry point, but aparently instead it copies
+	 * from the image start.
+	 */
+	.globl _zimage_start
+_zimage_start:
+
+#include "marshal_low.S"
+
+	.globl	_zimage_start_plat
+_zimage_start_plat:
+	b	_zimage_start_lib
+
+	.globl	platform_init
+platform_init:
+	b	kexec_platform_init
Index: work.git/arch/powerpc/boot/wrapper
===================================================================
--- work.git.orig/arch/powerpc/boot/wrapper	2007-07-10 16:30:15.000000000 -0500
+++ work.git/arch/powerpc/boot/wrapper	2007-07-10 16:37:30.000000000 -0500
@@ -133,6 +133,12 @@ coff)
     platformo=$object/of.o
     lds=$object/zImage.coff.lds
     ;;
+kexec)
+    platformo=$object/crt0_kexec.o
+    ;;
+kexec64)
+    platformo="-e _zimage_start_64 $object/crt0_kexec.o"
+    ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
@@ -190,6 +196,9 @@ uboot)
     fi
     exit 0
     ;;
+kexec64)
+    ${CROSS}objcopy -O elf64-powerpc $ofile
+    ;;
 esac
 
 addsec() {
Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 16:34:28.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 16:37:30.000000000 -0500
@@ -42,11 +42,11 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		marshal.c memranges.c \
+		marshal.c memranges.c kexec.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
-src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
+src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c crt0_kexec.S \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c
 src-boot := $(src-wlib) $(src-plat) empty.c
@@ -126,6 +126,9 @@ quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
+kexec-$(CONFIG_PPC32)			+= zImage.kexec
+kexec-$(CONFIG_PPC64)			+= zImage.kexec64
+
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
@@ -138,6 +141,7 @@ image-$(CONFIG_PPC_HOLLY)		+= zImage.hol
 image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_KEXEC)			+= $(kexec-y)
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
@@ -151,7 +155,7 @@ ifeq ($(CONFIG_PPC32),y)
 image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
-initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
+initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-) $(kexec-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
 		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))
 initrd-y := $(filter-out $(image-y), $(initrd-y))
@@ -219,8 +223,8 @@ install: $(CONFIGURE) $(addprefix $(obj)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.* \
-	otheros.bld
+clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* \
+	treeImage.* $(kexec-)
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
Index: work.git/arch/powerpc/boot/ops.h
===================================================================
--- work.git.orig/arch/powerpc/boot/ops.h	2007-07-10 16:34:28.000000000 -0500
+++ work.git/arch/powerpc/boot/ops.h	2007-07-10 16:37:30.000000000 -0500
@@ -90,6 +90,7 @@ void *simple_alloc_init(char *base, unsi
 void flush_cache(void *, unsigned long);
 int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
+void kexec_platform_init(struct boot_param_header *dt_blob);
 
 /* marshal slave cpus around to kernel */
 void move_slaves_up(void);
