Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 0C064DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 17:56:49 +1100 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JVL00K6GNA2ZQF0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 01 Feb 2008 23:56:26 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JVL00A1ENA0SN70@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 01 Feb 2008 23:56:27 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JVL00L4KN9ZU230@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 01 Feb 2008 23:56:24 -0700 (MST)
Date: Fri, 01 Feb 2008 23:55:42 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC][POWERPC] bootwrapper: Add a firmware-independent simpleboot
	target.
To: linuxppc-dev@ozlabs.org, jwboyer@gmail.com, scottwood@freescale.com,
	stephen.neuendorffer@xilinx.com
Message-id: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This target produces a flat binary rather than an ELF file,
fixes the entry point at the beginning of the image, and takes
a complete device tree with no fixups needed.

Based on 'raw' target written by Scott Wood.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile         |    9 +++-
 arch/powerpc/boot/io.h             |    7 +++
 arch/powerpc/boot/simpleboot.c     |   88 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/virtex405-head.S |   30 ++++++++++++
 arch/powerpc/boot/wrapper          |    4 ++
 5 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 836234b..c4156ea 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -40,6 +40,7 @@ $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=440
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
+$(obj)/virtex405-head.o: BOOTCFLAGS += -mcpu=405
 
 
 zlib       := inffast.c inflate.c inftrees.c
@@ -64,7 +65,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
-		cuboot-warp.c cuboot-85xx-cpm2.c
+		cuboot-warp.c cuboot-85xx-cpm2.c simpleboot.c virtex405-head.S
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -306,6 +307,12 @@ $(obj)/uImage: vmlinux $(wrapperbits)
 $(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dtstree)/$*.dts)
 
+$(obj)/simpleImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
+	$(call if_changed,wrap,simpleboot-$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
+
+$(obj)/simpleImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
+	$(call if_changed,wrap,simpleboot-$*,$(dtstree)/$*.dts)
+
 $(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
 
diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index ccaedae..ec57ec9 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -99,4 +99,11 @@ static inline void barrier(void)
 	asm volatile("" : : : "memory");
 }
 
+static inline void disable_irq(void)
+{
+	int dummy;
+	asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
+	             "=r" (dummy) : : "memory");
+}
+
 #endif /* _IO_H */
diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
new file mode 100644
index 0000000..8c2440d
--- /dev/null
+++ b/arch/powerpc/boot/simpleboot.c
@@ -0,0 +1,88 @@
+/*
+ * The simple platform -- for booting when firmware doesn't supply a device
+ *                        tree or any platform configuration information.
+ *                        All data is extracted from an embedded device tree
+ *                        blob.
+ *
+ * Authors: Scott Wood <scottwood@freescale.com>
+ *          Grant Likely <grant.likely@secretlab.ca>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2008 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "types.h"
+#include "io.h"
+#include "stdio.h"
+#include "libfdt/libfdt.h"
+
+BSS_STACK(16*1024);
+static char initial_heap[8*1024];
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	const u32 *na, *ns, *reg, *timebase;
+	u64 memsize64;
+	int node, size, i;
+
+	/* Allocate initial heap for probing the tree */
+	simple_alloc_init(initial_heap, sizeof(initial_heap), 32, 64);
+
+	/* Make sure FDT blob is sane */
+	if (fdt_check_header(_dtb_start) != 0)
+		fatal("Invalid device tree blob\n");
+
+	/* Find the #address-cells and #size-cells properties */
+	node = fdt_path_offset(_dtb_start, "/");
+	if (node < 0)
+		fatal("Cannot find root node\n");
+	na = fdt_getprop(_dtb_start, node, "#address-cells", &size);
+	if (!na || (size != 4))
+		fatal("Cannot find #address-cells property");
+	ns = fdt_getprop(_dtb_start, node, "#size-cells", &size);
+	if (!ns || (size != 4))
+		fatal("Cannot find #size-cells property");
+
+	/* Find the memory range */
+	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
+					     "memory", sizeof("memory"));
+	if (node < 0)
+		fatal("Cannot find memory node\n");
+	reg = fdt_getprop(_dtb_start, node, "reg", &size);
+	if (size < (*na+*ns) * sizeof(u32))
+		fatal("cannot get memory range\n");
+
+	/* Only interested in memory based at 0 */
+	for (i = 0; i < *na; i++)
+		if (*reg++ != 0)
+			fatal("Memory range is not based at address 0\n");
+
+	/* get the memsize and trucate it to under 4G on 32 bit machines */
+	memsize64 = 0;
+	for (i = 0; i < *ns; i++)
+		memsize64 = (memsize64 << 32) | *reg++;
+	if (sizeof(void *) == 4 && memsize64 >= 0x100000000ULL)
+		memsize64 = 0xffffffff;
+
+	/* finally, setup the timebase */
+	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
+					     "cpu", sizeof("cpu"));
+	if (!node)
+		fatal("Cannot find cpu node\n");
+	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
+	if (timebase && (size == 4))
+		timebase_period_ns = 1000000000 / *timebase;
+
+	/* Now we have the real memory size; reinitialize the heap */
+	simple_alloc_init(_end, memsize64 - (unsigned long)_end, 32, 64);
+
+	/* prepare the device tree and find the console */
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/virtex405-head.S b/arch/powerpc/boot/virtex405-head.S
new file mode 100644
index 0000000..3edb13f
--- /dev/null
+++ b/arch/powerpc/boot/virtex405-head.S
@@ -0,0 +1,30 @@
+#include "ppc_asm.h"
+
+	.text
+	.global _zimage_start
+_zimage_start:
+
+	/* PPC errata 213: needed by Virtex-4 FX */
+	mfccr0  0
+	oris    0,0,0x50000000@h
+	mtccr0  0
+
+	/*
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
+	 */
+	mfdccr	r9
+	cmplwi	r9,0
+	bne	2f
+	lis	r9,0
+	li	r8,256
+	mtctr	r8
+1:	dccci	r0,r9
+	addi	r9,r9,0x20
+	bdnz	1b
+2:	b	_zimage_start_lib
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c317815..1f41ff4 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -195,6 +195,10 @@ ep88xc|ep405|redboot*|ep8248e)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
+simpleboot-virtex405-*)
+    platformo="$object/virtex405-head.o $object/simpleboot.o"
+    binary=y
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
