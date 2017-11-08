Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yX3PF118WzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 22:05:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/boot: Only build OPAL code when necessary
Date: Wed,  8 Nov 2017 22:05:28 +1100
Message-Id: <1510139129-8335-2-git-send-email-mpe@ellerman.id.au>
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

Only build the OPAL console code in when necessary. This looks like it
should use CONFIG_PPC_POWERNV, but because the opal-call.S code is
64-bit only, we must only build it when we're building the boot
wrapper 64-bit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 6 +++---
 arch/powerpc/boot/serial.c | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ad5d99def61b..c67ad540de98 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -108,10 +108,10 @@ src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
-		oflib.c ofconsole.c cuboot.c cpm-serial.c \
-		opal.c
+		oflib.c ofconsole.c cuboot.c cpm-serial.c
+
 src-wlib-$(CONFIG_PPC_MPC52XX) += mpc52xx-psc.c
-src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) +=  opal-calls.S
+src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) += opal-calls.S opal.c
 ifndef CONFIG_PPC64_BOOT_WRAPPER
 src-wlib-y += crtsavres.S
 endif
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 71d062b48c1b..6f2b2ecf10bd 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -138,8 +138,10 @@ int serial_console_init(void)
 		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
 		rc = uartlite_console_init(devp, &serial_cd);
 #endif
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
 	else if (dt_is_compatible(devp, "ibm,opal-console-raw"))
 		rc = opal_console_init(devp, &serial_cd);
+#endif
 
 	/* Add other serial console driver calls here */
 
-- 
2.7.4
