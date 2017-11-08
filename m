Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yX3PG0BFTzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 22:05:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/boot: Only build CPM code when necessary
Date: Wed,  8 Nov 2017 22:05:29 +1100
Message-Id: <1510139129-8335-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1510139129-8335-1-git-send-email-mpe@ellerman.id.au>
References: <1510139129-8335-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As far as I can tell CONFIG_CPM is the right symbol to use to
conditionally compile the cpm-serial.c code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 3 ++-
 arch/powerpc/boot/serial.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c67ad540de98..ce0bca517e46 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -108,7 +108,7 @@ src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
-		oflib.c ofconsole.c cuboot.c cpm-serial.c
+		oflib.c ofconsole.c cuboot.c
 
 src-wlib-$(CONFIG_PPC_MPC52XX) += mpc52xx-psc.c
 src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) += opal-calls.S opal.c
@@ -121,6 +121,7 @@ src-wlib-$(CONFIG_PPC_8xx) += mpc8xx.c planetcore.c fsl-soc.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
 src-wlib-$(CONFIG_EMBEDDED6xx) += mpsc.c mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
 src-wlib-$(CONFIG_XILINX_VIRTEX) += uartlite.c
+src-wlib-$(CONFIG_CPM) += cpm-serial.c
 
 src-plat-y := of.c epapr.c
 src-plat-$(CONFIG_40x) += fixed-head.S ep405.c cuboot-hotfoot.c \
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 6f2b2ecf10bd..88955095ec07 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -124,11 +124,13 @@ int serial_console_init(void)
 	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
 #endif
+#ifdef CONFIG_CPM
 	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
 		rc = cpm_console_init(devp, &serial_cd);
+#endif
 #ifdef CONFIG_PPC_MPC52XX
 	else if (dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
 		rc = mpc5200_psc_console_init(devp, &serial_cd);
-- 
2.7.4
