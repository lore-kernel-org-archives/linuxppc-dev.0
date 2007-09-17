Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BDC8DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:13 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 04/28] Add early debug console for CPM serial ports.
Message-ID: <20070917165733.GD6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This code assumes that the ports have been previously set up, with
buffers in DPRAM.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig.debug         |   21 ++++++++++++++++
 arch/powerpc/kernel/head_32.S      |   16 ++++++++++++
 arch/powerpc/kernel/udbg.c         |    2 +
 arch/powerpc/platforms/8xx/Kconfig |    1 +
 arch/powerpc/platforms/Kconfig     |    4 +++
 arch/powerpc/sysdev/Makefile       |    1 +
 arch/powerpc/sysdev/cpm_common.c   |   46 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/udbg.h         |    1 +
 8 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/cpm_common.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c38bc22..f4e5d22 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -221,6 +221,15 @@ config PPC_EARLY_DEBUG_44x
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.
 
+config PPC_EARLY_DEBUG_CPM
+	bool "Early serial debugging for Freescale CPM-based serial ports"
+	depends on SERIAL_CPM
+	select PIN_TLB if PPC_8xx
+	help
+	  Select this to enable early debugging for Freescale chips
+	  using a CPM-based serial port.  This assumes that the bootwrapper
+	  has run, and set up the CPM in a particular way.
+
 endchoice
 
 config PPC_EARLY_DEBUG_44x_PHYSLOW
@@ -233,4 +242,16 @@ config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	depends PPC_EARLY_DEBUG_44x
 	default "0x1"
 
+config PPC_EARLY_DEBUG_CPM_ADDR
+	hex "CPM UART early debug transmit descriptor address"
+	depends on PPC_EARLY_DEBUG_CPM
+	default "0xfa202808" if PPC_EP88XC
+	default "0xf0000808" if CPM2
+	default "0xff002808" if CPM1
+	help
+	  This specifies the address of the transmit descriptor
+	  used for early debug output.  Because it is needed before
+	  platform probing is done, all platforms selected must
+	  share the same address.
+
 endmenu
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 12febfe..6bee0a0 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -149,6 +149,9 @@ __after_mmu_off:
 #if defined(CONFIG_BOOTX_TEXT)
 	bl	setup_disp_bat
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+	bl	setup_cpm_bat
+#endif
 
 /*
  * Call setup_cpu for CPU 0 and initialize 6xx Idle
@@ -1245,6 +1248,19 @@ setup_disp_bat:
 	blr
 #endif /* CONFIG_BOOTX_TEXT */
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+setup_cpm_bat:
+	lis	r8, 0xf000
+	ori	r8, r8,	0x002a
+	mtspr	SPRN_DBAT1L, r8
+
+	lis	r11, 0xf000
+	ori	r11, r11, (BL_1M << 2) | 2
+	mtspr	SPRN_DBAT1U, r11
+
+	blr
+#endif
+
 #ifdef CONFIG_8260
 /* Jump into the system reset for the rom.
  * We first disable the MMU, and then jump to the ROM reset address.
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 0f9b4ea..d723070 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -54,6 +54,8 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_44x)
 	/* PPC44x debug */
 	udbg_init_44x_as1();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
+	udbg_init_cpm();
 #endif
 }
 
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 39bb8c5..8ecd01a 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -3,6 +3,7 @@ config FADS
 
 config CPM1
 	bool
+	select CPM
 
 choice
 	prompt "8xx Machine Type"
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 7ad7b9c..06eda35 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -277,6 +277,7 @@ config QUICC_ENGINE
 config CPM2
 	bool
 	default n
+	select CPM
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
@@ -313,4 +314,7 @@ config FSL_ULI1575
 	  Freescale reference boards. The boards all use the ULI in pretty
 	  much the same way.
 
+config CPM
+	bool
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 08ce31e..cdf044f 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -34,6 +34,7 @@ endif
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
new file mode 100644
index 0000000..9daa6ac
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -0,0 +1,46 @@
+/*
+ * Common CPM code
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <asm/udbg.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <mm/mmu_decl.h>
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+static u32 __iomem *cpm_udbg_txdesc =
+	(u32 __iomem __force *)CONFIG_PPC_EARLY_DEBUG_CPM_ADDR;
+
+static void udbg_putc_cpm(char c)
+{
+	u8 __iomem *txbuf = (u8 __iomem __force *)in_be32(&cpm_udbg_txdesc[1]);
+
+	if (c == '\n')
+		udbg_putc('\r');
+
+	while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
+		;
+
+	out_8(txbuf, c);
+	out_be32(&cpm_udbg_txdesc[0], 0xa0000001);
+}
+
+void __init udbg_init_cpm(void)
+{
+	if (cpm_udbg_txdesc) {
+#ifdef CONFIG_CPM2
+		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
+#endif
+		udbg_putc = udbg_putc_cpm;
+	}
+}
+#endif
diff --git a/include/asm-powerpc/udbg.h b/include/asm-powerpc/udbg.h
index ce9d82f..a9e0b0e 100644
--- a/include/asm-powerpc/udbg.h
+++ b/include/asm-powerpc/udbg.h
@@ -48,6 +48,7 @@ extern void __init udbg_init_rtas_console(void);
 extern void __init udbg_init_debug_beat(void);
 extern void __init udbg_init_btext(void);
 extern void __init udbg_init_44x_as1(void);
+extern void __init udbg_init_cpm(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
-- 
1.5.3.1
