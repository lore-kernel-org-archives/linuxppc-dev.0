Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yX3PD07yVzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 22:05:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/boot: Only build uartlite if XILINX_VIRTEX=y
Date: Wed,  8 Nov 2017 22:05:27 +1100
Message-Id: <1510139129-8335-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The serial code in uartlite.c only matches if we find one of two
Xilinx (xlnx) nodes in the device tree, there's no need to build or
link the code on other platforms.

As far as I can tell CONFIG_XILINX_VIRTEX is the appropriate symbol to
use to conditionally compile the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 3 ++-
 arch/powerpc/boot/serial.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 651974192c4d..ad5d99def61b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -109,7 +109,7 @@ src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c cpm-serial.c \
-		uartlite.c opal.c
+		opal.c
 src-wlib-$(CONFIG_PPC_MPC52XX) += mpc52xx-psc.c
 src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) +=  opal-calls.S
 ifndef CONFIG_PPC64_BOOT_WRAPPER
@@ -120,6 +120,7 @@ src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_PPC_8xx) += mpc8xx.c planetcore.c fsl-soc.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
 src-wlib-$(CONFIG_EMBEDDED6xx) += mpsc.c mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
+src-wlib-$(CONFIG_XILINX_VIRTEX) += uartlite.c
 
 src-plat-y := of.c epapr.c
 src-plat-$(CONFIG_40x) += fixed-head.S ep405.c cuboot-hotfoot.c \
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 7b5c02b1afd0..71d062b48c1b 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -133,9 +133,11 @@ int serial_console_init(void)
 	else if (dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
 		rc = mpc5200_psc_console_init(devp, &serial_cd);
 #endif
+#ifdef CONFIG_XILINX_VIRTEX
 	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
 		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
 		rc = uartlite_console_init(devp, &serial_cd);
+#endif
 	else if (dt_is_compatible(devp, "ibm,opal-console-raw"))
 		rc = opal_console_init(devp, &serial_cd);
 
-- 
2.7.4
