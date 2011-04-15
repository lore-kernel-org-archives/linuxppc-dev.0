Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e47ee8e57f6cd0d842f49e30df84ccec49ddf7fc.1302841853.git.michael@ellerman.id.au>
In-Reply-To: <34e3e03a96888bc8c20013aa65712123ccf94649.1302676893.git.michael@ellerman.id.au>
Subject: [PATCH 2/2] powerpc: Add an ePAPR compliant boot wrapper
Date: Fri, 15 Apr 2011 14:29:16 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <dwg@au1.ibm.com>

This is a first cut at making bootwrapper code which will
produce a zImage compliant with the requirements set down
by ePAPR.

This is a very simple bootwrapper, taking the device tree
blob supplied by the ePAPR boot program and passing it on
to the kernel. It builds on the earlier patch to build a
relocatable ET_DYN zImage to meet the other ePAPR image
requirements.

For good measure we have some paranoid checks which will
generate warnings if some of the ePAPR entry condition
guarantees are not met.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig       |    6 ++++
 arch/powerpc/boot/Makefile |    4 ++-
 arch/powerpc/boot/epapr.c  |   66 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper  |    4 ++
 4 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b6ff882..2629c21 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -193,6 +193,12 @@ config SYS_SUPPORTS_APM_EMULATION
 	default y if PMAC_APM_EMU
 	bool
 
+config EPAPR_BOOT
+	bool
+	help
+	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
+	default n
+
 config DEFAULT_UIMAGE
 	bool
 	help
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8917816..0e2a152 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -69,7 +69,8 @@ src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
 		fsl-soc.c mpc8xx.c pq2.c ugecon.c
 src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
-		cuboot-ebony.c cuboot-hotfoot.c treeboot-ebony.c prpmc2800.c \
+		cuboot-ebony.c cuboot-hotfoot.c epapr.c treeboot-ebony.c \
+		prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
@@ -182,6 +183,7 @@ image-$(CONFIG_PPC_HOLLY)		+= dtbImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+= dtbImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_EPAPR_BOOT)		+= zImage.epapr
 
 #
 # Targets which embed a device tree blob
diff --git a/arch/powerpc/boot/epapr.c b/arch/powerpc/boot/epapr.c
new file mode 100644
index 0000000..06c1961
--- /dev/null
+++ b/arch/powerpc/boot/epapr.c
@@ -0,0 +1,66 @@
+/*
+ * Bootwrapper for ePAPR compliant firmwares
+ *
+ * Copyright 2010 David Gibson <david@gibson.dropbear.id.au>, IBM Corporation.
+ *
+ * Based on earlier bootwrappers by:
+ * (c) Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp,\
+ *   and
+ * Scott Wood <scottwood@freescale.com>
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "io.h"
+#include <libfdt.h>
+
+BSS_STACK(4096);
+
+#define EPAPR_SMAGIC	0x65504150
+#define EPAPR_EMAGIC	0x45504150
+
+static unsigned epapr_magic;
+static unsigned long ima_size;
+static unsigned long fdt_addr;
+
+static void platform_fixups(void)
+{
+	if ((epapr_magic != EPAPR_EMAGIC)
+	    && (epapr_magic != EPAPR_SMAGIC))
+		fatal("r6 contained 0x%08x instead of ePAPR magic number\n",
+		      epapr_magic);
+
+	if (ima_size < (unsigned long)_end)
+		printf("WARNING: Image loaded outside IMA!"
+		       " (_end=%p, ima_size=0x%lx)\n", _end, ima_size);
+	if (ima_size < fdt_addr)
+		printf("WARNING: Device tree address is outside IMA!"
+		       "(fdt_addr=0x%lx, ima_size=0x%lx)\n", fdt_addr,
+		       ima_size);
+	if (ima_size < fdt_addr + fdt_totalsize((void *)fdt_addr))
+		printf("WARNING: Device tree extends outside IMA!"
+		       " (fdt_addr=0x%lx, size=0x%x, ima_size=0x%lx\n",
+		       fdt_addr, fdt_totalsize((void *)fdt_addr), ima_size);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	epapr_magic = r6;
+	ima_size = r7;
+	fdt_addr = r3;
+
+	/* FIXME: we should process reserve entries */
+
+	simple_alloc_init(_end, ima_size - (unsigned long)_end, 32, 64);
+
+	fdt_init((void *)fdt_addr);
+
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index fef5278..dfa29cb 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -247,6 +247,10 @@ gamecube|wii)
 treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
+epapr)
+    link_address='0x20000000'
+    pie=-pie
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.7.1
