Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 93434DDF3A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 08:11:42 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Xilinx: Fix boot with 16550 for 405 and 440
Date: Wed, 2 Jul 2008 15:11:28 -0700
Message-ID: <20080702221136.08EDB84004F@mail134-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following changes add processing to initialize the
Xilinx 16550 UART in the boot strap loader since a
boot loader is not used many times with the FPGA.

The wrapper was also modified to add the 440 build.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/boot/Makefile     |    2 +-
 arch/powerpc/boot/simpleboot.c |    6 ++
 arch/powerpc/boot/virtex.c     |  100 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper      |    6 ++-
 4 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/virtex.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f8ffb56..1b641cf 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -66,7 +66,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S
+		virtex405-head.S virtex.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
index 86cd285..c58a0da 100644
--- a/arch/powerpc/boot/simpleboot.c
+++ b/arch/powerpc/boot/simpleboot.c
@@ -23,6 +23,8 @@
 
 BSS_STACK(4*1024);
 
+extern int platform_specific_init(void) __attribute__((weak));
+
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		   unsigned long r6, unsigned long r7)
 {
@@ -80,5 +82,9 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 
 	/* prepare the device tree and find the console */
 	fdt_init(_dtb_start);
+
+	if (platform_specific_init)
+		platform_specific_init();
+
 	serial_console_init();
 }
diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
new file mode 100644
index 0000000..f622805
--- /dev/null
+++ b/arch/powerpc/boot/virtex.c
@@ -0,0 +1,100 @@
+/*
+ * The platform specific code for virtex devices since a boot loader is not
+ * always used.
+ *
+ * (C) Copyright 2008 Xilinx, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "io.h"
+#include "stdio.h"
+
+#define UART_DLL		0	/* Out: Divisor Latch Low */
+#define UART_DLM		1	/* Out: Divisor Latch High */
+#define UART_FCR		2	/* Out: FIFO Control Register */
+#define UART_FCR_CLEAR_RCVR 	0x02 	/* Clear the RCVR FIFO */
+#define UART_FCR_CLEAR_XMIT	0x04 	/* Clear the XMIT FIFO */
+#define UART_LCR		3	/* Out: Line Control Register */
+#define UART_MCR		4	/* Out: Modem Control Register */
+#define UART_MCR_RTS		0x02 	/* RTS complement */
+#define UART_MCR_DTR		0x01 	/* DTR complement */
+#define UART_LCR_DLAB		0x80 	/* Divisor latch access bit */
+#define UART_LCR_WLEN8		0x03 	/* Wordlength: 8 bits */
+
+static int virtex_ns16550_console_init(void *devp)
+{
+	unsigned char *reg_base;
+	u32 reg_shift, reg_offset, clk, spd;
+	u16 divisor;
+	int n;
+
+	if (dt_get_virtual_reg(devp, (void **)&reg_base, 1) < 1)
+		return -1;
+
+	n = getprop(devp, "reg-offset", &reg_offset, sizeof(reg_offset));
+	if (n == sizeof(reg_offset))
+		reg_base += reg_offset;
+
+	n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
+	if (n != sizeof(reg_shift))
+		reg_shift = 0;
+
+	n = getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
+	if (n != sizeof(spd))
+		spd = 9600;
+
+	/* should there be a default clock rate?*/
+	n = getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
+	if (n != sizeof(clk))
+		return -1;
+
+	divisor = clk / (16 * spd);
+
+	/* Access baud rate */
+	out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_DLAB);
+
+	/* Baud rate based on input clock */
+	out_8(reg_base + (UART_DLL << reg_shift), divisor & 0xFF);
+	out_8(reg_base + (UART_DLM << reg_shift), divisor >> 8);
+
+	/* 8 data, 1 stop, no parity */
+	out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_WLEN8);
+
+	/* RTS/DTR */
+	out_8(reg_base + (UART_MCR << reg_shift), UART_MCR_RTS | UART_MCR_DTR);
+
+	/* Clear transmitter and receiver */
+	out_8(reg_base + (UART_FCR << reg_shift),
+				UART_FCR_CLEAR_XMIT | UART_FCR_CLEAR_RCVR);
+	return 0;
+}
+
+/* For virtex, the kernel may be loaded without using a bootloader and if so
+   some UARTs need more setup than is provided in the normal console init
+*/
+int platform_specific_init(void)
+{
+	void *devp;
+	char devtype[MAX_PROP_LEN];
+	char path[MAX_PATH_LEN];
+
+	devp = finddevice("/chosen");
+	if (devp == NULL)
+		return -1;
+
+	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0) {
+		devp = finddevice(path);
+		if (devp == NULL)
+			return -1;
+
+		if ((getprop(devp, "device_type", devtype, sizeof(devtype)) > 0)
+				&& !strcmp(devtype, "serial")
+				&& (dt_is_compatible(devp, "ns16550")))
+				virtex_ns16550_console_init(devp);
+	}
+	return 0;
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d6c96d9..bd7ae29 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -200,7 +200,11 @@ adder875-redboot)
     binary=y
     ;;
 simpleboot-virtex405-*)
-    platformo="$object/virtex405-head.o $object/simpleboot.o"
+    platformo="$object/virtex405-head.o $object/simpleboot.o $object/virtex.o"
+    binary=y
+    ;;
+simpleboot-virtex440-*)
+    platformo="$object/simpleboot.o $object/virtex.o"
     binary=y
     ;;
 esac
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
