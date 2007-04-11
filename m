Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:33:34 -0500 (CDT)
Subject: [PATCH 5/8] bootwrapper: Add kexec callable zImage wrapper
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-05.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
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
Linux kernel.   This allows you to kexec a zImage (instead of a kernel).
This can reduce the memory needed to reboot, or to provide a common
image for boot and reboot.

It also provides rules to pretend the binary is a 64-bit elf, with
the same calling convention as the 64-bit kernel.

In theory this code should be useable in any envrionment that supplies
a flat device tree to describe the usable memory of the machine.

Limitations:

The memory node off the root with a name starting with "memory" must
contain enough free memory (not in the reserved ranges) in the first
reg range to uncompress the the kenrel with padding.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Status: Successfully boots from and to a 64 bit kernel when loaded
at 0 and after the kernel _end,  when initrds and various other data
reserved are loaded discontigiously above the size of the kernel.   

The memory search should be converted to use the address translation
framework and find_node_by_type, although we have a limited malloc
space during the search.  That points out the need for a read-only
scan of the tree.

The next patch is needed to call from kexec-tools without supplying
an externally generated flat device tree.

kexec.c is added as a library in the belief that it can be used by
multiple platforms.

I didn't test any serial drivers in this environment.  kexec will
clear out the mmu, so relying on initialized translations will fail.


Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/kexec.c	2007-04-10 21:35:03.000000000 -0500
@@ -0,0 +1,255 @@
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
+ * Copyright (C) IBM Corporation 2007
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
+	int rc;
+
+	rc = serial_console_init();
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
+				continue;
+			rp++;
+		}
+		while (--ns) {
+			if (*rp)
+				continue;
+			rp++;
+		}
+	} while (0);
+
+	rmo_end = (void *)*rp;
+}
+
+static void find_dt_initrd(void)
+{
+	int rc;
+	unsigned long long initrd_start, initrd_end;
+	void *devp;
+
+	devp = finddevice("/chosen");
+	if (! devp) {
+		return;
+	}
+
+	/* The properties had to be 8 bytes until 2.6.22  */
+	rc = getprop(devp, "linux,initrd-start", &initrd_start,
+		sizeof(initrd_start));
+	if (rc < 0)
+		return;
+	if (rc == sizeof(unsigned long)) {
+		unsigned long tmp;
+		memcpy(&tmp, &initrd_start, rc);
+		initrd_start = tmp;
+	} else if (rc != sizeof(initrd_start)) {
+		printf("unexpected length of linux,initrd_start in /chosen!\n\r");
+		return;
+	}
+
+	rc = getprop(devp, "linux,initrd-end", &initrd_end, sizeof(initrd_end));
+	if (rc < 0) {
+		printf("chosen has linux,initrd_start but no linux,initrd_end!\n\r");
+		return;
+	}
+	if (rc == sizeof(unsigned long)) {
+		unsigned long tmp;
+		memcpy(&tmp, &initrd_end, rc);
+		initrd_end = tmp;
+	} else if (rc != sizeof(initrd_end)) {
+		printf("unexpected length of linux,initrd_end in /chosen!\n\r");
+		return;
+	}
+
+	if (!initrd_start)
+		return;
+
+	/* if the initrd is above 4G, its untouchable in 32 bit mode */
+	if (initrd_end <= UINT_MAX && initrd_start < initrd_end) {
+		loader_info.initrd_addr = initrd_start;
+		loader_info.initrd_size  = initrd_end - initrd_start;
+	}
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
+	find_dt_initrd();
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
+static void *kexec_vmlinux_alloc(unsigned long vmsize)
+{
+	unsigned long size = vmsize;
+	void *addr;
+
+	/*
+	 * If we are running where the kernel will decompress itself,
+	 * tack some more space onto the allocations and move the slaves
+	 * there.  This avoids the kernel decompressing before the slaves
+	 * catch on that they should move down to 0x60.
+	 */
+	if (size > (unsigned long)_start)
+		size += SMP_SLAVE_SIZE;
+
+	addr = ranges_vmlinux_alloc(size);
+
+	if (size > vmsize) {
+		if (addr < (void *)_start) {
+			/*
+			 * The kernel will memmove its self down.  The extra
+			 * space is at the end, make sure it is alligned.
+			 * We don't care if the kernel overwrites the first
+			 * instruction, that is the master entry point.
+			 */
+			vmsize &= ~3UL;
+			move_slaves_here(addr + vmsize);
+		} else {
+			/* nice aligned space at the beginning */
+			move_slaves_here(addr);
+			addr += SMP_SLAVE_SIZE;
+		}
+	}
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
Index: kernel/arch/powerpc/boot/crt0_kexec.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/crt0_kexec.S	2007-04-10 21:35:03.000000000 -0500
@@ -0,0 +1,46 @@
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
+ * Copyright (C) 2007 IBM Corporation.
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
+	.globl	platform_init
+platform_init:
+	b	kexec_platform_init
+
+
+	.globl	_zimage_start_plat
+_zimage_start_plat:
+	b	_zimage_start_32_64
Index: kernel/arch/powerpc/boot/wrapper
===================================================================
--- kernel.orig/arch/powerpc/boot/wrapper	2007-04-10 21:28:30.000000000 -0500
+++ kernel/arch/powerpc/boot/wrapper	2007-04-10 21:35:03.000000000 -0500
@@ -133,6 +133,12 @@ pmaccoff)
     platformo=$object/of.o
     lds=$object/zImage.coff.lds
     ;;
+kexec)
+    platformo=$object/crt0_kexec.o
+    ;;
+kexec64)
+    platformo="-e _zimage_start64 $object/crt0_kexec.o"
+    ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
@@ -216,4 +222,7 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
+kexec64)
+    ${CROSS}objcopy -O elf64-powerpc $ofile
+    ;;
 esac
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-10 21:34:43.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-10 21:35:03.000000000 -0500
@@ -43,10 +43,11 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		marshal.c memranges.c misc64.S \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib)
+		gunzip_util.c $(zlib) kexec.c
 src-plat := of.c
-src-boot := $(src-wlib) $(src-plat) empty.c
+src-plat += crt0_kexec.S
 
+src-boot := $(src-wlib) $(src-plat) empty.c
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
@@ -122,6 +123,9 @@ quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
+kexec-$(CONFIG_PPC32)			+= zImage.kexec
+kexec-$(CONFIG_PPC64)			+= zImage.kexec64
+
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
@@ -131,6 +135,7 @@ image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_KEXEC)			+= $(kexec-y)
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
@@ -138,7 +143,7 @@ ifeq ($(CONFIG_PPC32),y)
 image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
-initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
+initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-) $(kexec-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
 initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
@@ -172,7 +177,7 @@ install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd
+clean-files += $(image-) $(initrd-) $(kexec-) zImage zImage.initrd
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-04-10 21:34:18.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-04-10 21:35:03.000000000 -0500
@@ -83,6 +83,7 @@ int ns16550_console_init(void *devp, str
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 void flush_cache(void *, unsigned long);
+void kexec_platform_init(struct boot_param_header *dt_blob);
 
 /* marshal slave cpus around to kernel */
 void move_slaves_up(void);
