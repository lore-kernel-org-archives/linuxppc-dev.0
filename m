Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:34:11 -0500 (CDT)
Subject: [PATCH 8/8] bootwrapper: example sreset marshalling
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-08.miltonm@bga.com>
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


An example that uses the marshalling code but expects cpus to be
sreset.  This reuses the kexec code after finding the device tree
(which is magically available at 31K by whatever means loaded this
code).  With the marshalling code is at 0 in the image and
the checks in platform_init, it also works as a kexec target when
left as elf.

--- 
Status: works with sreset on the tested platform when image data
loaded at 0 and the device tree loaded at 31MB.  Works as kexec
called elf image from 64 bit kernel with kexec-supplied device-tree
and initrd.  The attached device-tree and initrd cases have not
been tested.

Index: kernel/arch/powerpc/boot/crt0_bml.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/crt0_bml.S	2007-04-09 05:12:35.000000000 -0500
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2006-2007 Milton Miller, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+	/*
+	 * This can be either a kexec started image or a sreset initiated
+	 * one.  kexec-tools purgatory is suppposed to copy from entry
+	 * point, but instead copies from image start, so put marshal_low
+	 * at address 0.
+	 */
+
+	.globl zImage_start
+zImage_start:
+#include "marshal_low.S"
+
+	.org 0x100
+	bl	get_cpu_id
+1:	mflr	0
+	lis	r4,1b@ha
+	addi	r4,r4,1b@l
+	subf	r0,r4,r0
+
+	lis	r4,elected_master@ha
+	addi	r4,r4,elected_master@l
+	add	r4,r4,r0
+2:	lwarx	r6,r0,r4
+	cmpwi	r6,0
+	bge	3f
+	stwcx.	r3,r0,r4
+	bne-	2b
+	lwz	r6,0(r4)
+
+3:	lis	r4,cpus_found@ha
+	addi	r4,r4,cpus_found@l
+	add	r4,r4,r0
+4:	lwarx	r12,r0,r4
+	addi	r12,r12,1
+	stwcx.	r12,r0,r4
+	bne-	4b
+
+	cmpw	r6,r3
+	bne	slave
+
+	mr	r4,r0
+	li	r5,0
+	b	master
+
+
+	.globl	_zimage_start_plat
+_zimage_start_plat:
+	b	_zimage_start_32_64
+
+	.weak	get_cpu_id
+get_cpu_id:
+
+get_pir:
+	mfspr	r3,1023	/* SPRN_PIR */
+	blr
+
+	.balign 8
+	.globl elected_master
+elected_master:
+	.long -1
+	.globl cpus_expected
+cpus_expected:
+	.long 8
+	.globl cpus_found
+cpus_found:
+	.long 0
Index: kernel/arch/powerpc/boot/bml.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/bml.c	2007-04-09 04:17:24.000000000 -0500
@@ -0,0 +1,42 @@
+#include "ops.h"
+#include "reg.h"
+#include "flatdevtree.h"
+
+extern struct boot_param_header _dtb_start[], _dtb_end[];
+struct boot_param_header *bml_dt_blob;
+
+extern unsigned int get_cpu_id(void);
+extern unsigned int cpus_found, cpus_expected;
+
+void platform_init(unsigned long boot_cpu_id)
+{
+	if (boot_cpu_id > 1024) {
+		bml_dt_blob = (void *)boot_cpu_id;
+		boot_cpu_id = get_cpu_id();
+	}
+
+	if (!bml_dt_blob)
+		if (_dtb_start != _dtb_end)
+			bml_dt_blob = _dtb_start;
+
+	if (!bml_dt_blob)
+		bml_dt_blob = 31 * 1024 * 1024 + (void *)0;
+
+	if (bml_dt_blob->magic != OF_DT_HEADER)
+		fatal("No device tree at %p\n", bml_dt_blob);
+
+	if (bml_dt_blob->version < 2)
+		conv_flattree_inplace(bml_dt_blob);
+
+	bml_dt_blob->boot_cpuid_phys = boot_cpu_id;
+
+	if (cpus_found && cpus_found < cpus_expected) {
+		HMT_LOW;
+		while (cpus_found < cpus_expected) {
+			barrier();
+		}
+		HMT_MEDIUM;
+	}
+
+	kexec_platform_init(bml_dt_blob);
+}
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-09 04:17:10.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-09 04:17:24.000000000 -0500
@@ -46,6 +46,7 @@ src-wlib := string.S crt0.S stdio.c main
 		gunzip_util.c $(zlib) kexec.c rtas.c
 src-plat := of.c
 src-plat += crt0_kexec.S
+src-plat += crt0_bml.S bml.c
 
 src-boot := $(src-wlib) $(src-plat) empty.c
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -124,7 +125,7 @@ quiet_cmd_wrap	= WRAP    $@
 		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
 kexec-$(CONFIG_PPC32)			+= zImage.kexec
-kexec-$(CONFIG_PPC64)			+= zImage.kexec64
+kexec-$(CONFIG_PPC64)			+= zImage.kexec64 zImage.bml
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
Index: kernel/arch/powerpc/boot/wrapper
===================================================================
--- kernel.orig/arch/powerpc/boot/wrapper	2007-04-09 04:17:10.000000000 -0500
+++ kernel/arch/powerpc/boot/wrapper	2007-04-09 04:17:24.000000000 -0500
@@ -139,6 +139,9 @@ kexec)
 kexec64)
     platformo="-e _zimage_start64 $object/crt0_kexec.o"
     ;;
+bml)
+    platformo="$object/crt0_bml.o $object/bml.o"
+    ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
