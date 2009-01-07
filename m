Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9B406DE612
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:03:36 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 15:03:34 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090107135457.234150@gmx.net>
Message-ID: <20090107140334.299940@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net>
Subject: [PATCH 3/5] powerpc: Bootwrapper and serial console support for
	AmigaOne
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the bootwrapper for the cuImage target and a compatible property
check for "pnpPNP,501" to the generic serial console support code.
The default link address for the cuImage target is set to 0x800000. This
allows to boot the kernel with AmigaOS4's second level bootloader, which
always loads a uImage at 0x500000.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/boot/Makefile          |    5 ++++-
 arch/powerpc/boot/cuboot-amigaone.c |   35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/serial.c          |    3 ++-
 arch/powerpc/boot/wrapper           |    3 +++
 4 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-amigaone.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f328299..d5ec22a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -70,7 +70,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c
+		cuboot-acadia.c cuboot-amigaone.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -274,6 +274,9 @@ image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
 
+# Board port in arch/powerpc/platform/amigaone/Kconfig
+image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
+
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
 ifeq ($(CONFIG_PPC32),y)
diff --git a/arch/powerpc/boot/cuboot-amigaone.c b/arch/powerpc/boot/cuboot-amigaone.c
new file mode 100644
index 0000000..d502967
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-amigaone.c
@@ -0,0 +1,35 @@
+/*
+ * Old U-boot compatibility for AmigaOne
+ *
+ * Author: Gerhard Pircher (gerhard_pircher@gmx.net)
+ *
+ *   Based on cuboot-83xx.c
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void platform_fixups(void)
+{
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 8b3607c..f2156f0 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -117,7 +117,8 @@ int serial_console_init(void)
 	if (devp == NULL)
 		goto err_out;
 
-	if (dt_is_compatible(devp, "ns16550"))
+	if (dt_is_compatible(devp, "ns16550") ||
+	    dt_is_compatible(devp, "pnpPNP,501"))
 		rc = ns16550_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 965c237..6170bbf 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -186,6 +186,9 @@ cuboot*)
     *-mpc85*|*-tqm85*|*-sbc85*)
         platformo=$object/cuboot-85xx.o
         ;;
+    *-amigaone)
+        link_address='0x800000'
+        ;;
     esac
     ;;
 ps3)
-- 
1.5.6.5


-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
