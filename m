Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D15D9DED08
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:31 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1ZQ3N019024
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:26 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZPTp001440
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:25 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AiIF007893
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:44 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 69741AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:24 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZOip015334
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:24 -0500
Date: Tue, 17 Jul 2007 20:35:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 20/61] Add early debug console for CPM serial ports.
Message-ID: <20070718013524.GR15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig.debug       |    9 +++++++
 arch/powerpc/kernel/head_32.S    |   16 +++++++++++++
 arch/powerpc/kernel/udbg.c       |    2 +
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/cpm_common.c |   44 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/cpm_common.h |    9 +++++++
 include/asm-powerpc/udbg.h       |    1 +
 7 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/cpm_common.c
 create mode 100644 arch/powerpc/sysdev/cpm_common.h

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 346cd3b..b124e6b 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -211,6 +211,15 @@ config PPC_EARLY_DEBUG_44x
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
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7d73a13..e950a75 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -152,6 +152,9 @@ __after_mmu_off:
 #if defined(CONFIG_BOOTX_TEXT)
 	bl	setup_disp_bat
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+	bl	setup_cpm_bat
+#endif
 
 /*
  * Call setup_cpu for CPU 0 and initialize 6xx Idle
@@ -1248,6 +1251,19 @@ setup_disp_bat:
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
index cbca1df..422856c 100644
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
 
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f65078c..7529cf2 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -32,6 +32,7 @@ endif
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_CPM1)$(CONFIG_CPM2) += cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
new file mode 100644
index 0000000..92ed644
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -0,0 +1,44 @@
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
+#include "cpm_common.h"
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+void udbg_putc_cpm(char c)
+{
+	u8 __iomem *txbuf = (u8 __iomem *)in_be32(&cpm_udbg_txdesc[1]);
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
diff --git a/arch/powerpc/sysdev/cpm_common.h b/arch/powerpc/sysdev/cpm_common.h
new file mode 100644
index 0000000..2b26c6f
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm_common.h
@@ -0,0 +1,9 @@
+#ifndef _POWERPC_SYSDEV_CPM_COMMON_H
+#define _POWERPC_SYSDEV_CPM_COMMON_H
+
+#include <linux/types.h>
+
+/* Board code must define this address if the early console is used. */
+extern u32 __iomem *cpm_udbg_txdesc;
+
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
1.5.0.3
