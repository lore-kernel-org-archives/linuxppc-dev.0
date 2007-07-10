Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:12:59 -0500 (CDT)
Subject: [PATCH/EXAMPLE 15/15] bootwrapper: example sreset marshalling
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-15.miltonm@bga.com>
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


An example using the marshalling code that can be entered by sreset.
By linking the marshalling code is at 0 and differentiating a cpu
id from a device tree, it also works for kexec.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
For reference only, not intended to be merged.

Index: work.git/arch/powerpc/boot/crt0_sample.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/crt0_sample.S	2007-07-10 16:47:25.000000000 -0500
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2006-2007 Milton Miller, IBM Corporation.
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
+	.globl _zimage_start
+_zimage_start:
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
+	b	_zimage_start_lib
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
Index: work.git/arch/powerpc/boot/sample.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/sample.c	2007-07-10 16:48:45.000000000 -0500
@@ -0,0 +1,62 @@
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
+#include "reg.h"
+#include "flatdevtree.h"
+
+extern struct boot_param_header _dtb_start[], _dtb_end[];
+struct boot_param_header *sample_dt_blob;
+
+extern unsigned int get_cpu_id(void);
+extern unsigned int cpus_found, cpus_expected;
+
+void platform_init(unsigned long boot_cpu_id)
+{
+	if (boot_cpu_id > 1024) {
+		sample_dt_blob = (void *)boot_cpu_id;
+		boot_cpu_id = get_cpu_id();
+	}
+
+	if (!sample_dt_blob)
+		if (_dtb_start != _dtb_end)
+			sample_dt_blob = _dtb_start;
+
+	if (!sample_dt_blob)
+		sample_dt_blob = 31 * 1024 * 1024 + (void *)0;
+
+	if (sample_dt_blob->magic != OF_DT_HEADER)
+		fatal("No device tree at %p\n", sample_dt_blob);
+
+	if (sample_dt_blob->version < 2)
+		conv_flattree_inplace(sample_dt_blob);
+
+	sample_dt_blob->boot_cpuid_phys = boot_cpu_id;
+
+	if (cpus_found && cpus_found < cpus_expected) {
+		HMT_LOW;
+		while (cpus_found < cpus_expected) {
+			barrier();
+		}
+		HMT_MEDIUM;
+	}
+
+	kexec_platform_init(sample_dt_blob);
+}
Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 16:41:01.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 16:47:45.000000000 -0500
@@ -48,7 +48,7 @@ src-wlib := string.S crt0.S stdio.c main
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c crt0_kexec.S \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c
+		ps3-head.S ps3-hvcall.S ps3.c crt0_sample.S sample.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -128,7 +128,7 @@ quiet_cmd_wrap	= WRAP    $@
 		$(if $6,$6,vmlinux)
 
 kexec-$(CONFIG_PPC32)			+= zImage.kexec
-kexec-$(CONFIG_PPC64)			+= zImage.kexec64
+kexec-$(CONFIG_PPC64)			+= zImage.kexec64 zImage.sample
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
Index: work.git/arch/powerpc/boot/wrapper
===================================================================
--- work.git.orig/arch/powerpc/boot/wrapper	2007-07-10 16:41:01.000000000 -0500
+++ work.git/arch/powerpc/boot/wrapper	2007-07-10 16:47:25.000000000 -0500
@@ -139,6 +139,9 @@ kexec)
 kexec64)
     platformo="-e _zimage_start_64 $object/crt0_kexec.o"
     ;;
+sample)
+    platformo="$object/crt0_sample.o $object/sample.o"
+    ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
