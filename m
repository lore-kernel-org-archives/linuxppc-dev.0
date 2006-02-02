Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B38BE68A7B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 06:58:41 +1100 (EST)
Date: Thu, 2 Feb 2006 13:50:44 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Cleanup MPC83xx platform support
Message-ID: <Pine.LNX.4.44.0602021349480.13198-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved some code around so its usable by more systems than just
the MPC834x SYS.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 3a37a9fa1aa28844651449eda0c31485ad202b01
tree 30998d96fa22fbab7517be304fc004ba02377181
parent 7ddda6a6630d95f800fbf848b00bd1d685c9bba4
author Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 13:16:20 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 13:16:20 -0600

 arch/powerpc/platforms/83xx/Makefile      |    4 ++
 arch/powerpc/platforms/83xx/misc.c        |   55 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc834x_sys.c |   58 -----------------------------
 arch/powerpc/platforms/83xx/mpc83xx.h     |    3 ++
 arch/powerpc/platforms/83xx/pci.c         |   13 +++++--
 5 files changed, 71 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 9d8b28e..5c72367 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -1,4 +1,6 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
-obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o pci.o
+obj-y				:= misc.o
+obj-$(CONFIG_PCI)		+= pci.o
+obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
new file mode 100644
index 0000000..0eb3d99
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -0,0 +1,55 @@
+/*
+ * misc setup functions for MPC83xx
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+#include <asm/hw_irq.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc83xx.h"
+
+void mpc83xx_restart(char *cmd)
+{
+#define RST_OFFSET	0x00000900
+#define RST_PROT_REG	0x00000018
+#define RST_CTRL_REG	0x0000001c
+	__be32 __iomem *reg;
+
+	/* map reset register space */
+	reg = ioremap(get_immrbase() + 0x900, 0xff);
+
+	local_irq_disable();
+
+	/* enable software reset "RSTE" */
+	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
+
+	/* set software hard reset */
+	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
+	for (;;) ;
+}
+
+long __init mpc83xx_time_init(void)
+{
+#define SPCR_OFFSET	0x00000110
+#define SPCR_TBEN	0x00400000
+	__be32 __iomem *spcr = ioremap(get_immrbase() + SPCR_OFFSET, 4);
+	__be32 tmp;
+
+	tmp = in_be32(spcr);
+	out_be32(spcr, tmp | SPCR_TBEN);
+
+	iounmap(spcr);
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 2098dd0..7d5a278 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -24,22 +24,15 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/module.h>
-#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
 #include <asm/bootinfo.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpc83xx.h>
 #include <asm/irq.h>
-#include <mm/mmu_decl.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
@@ -52,8 +45,6 @@ unsigned long isa_mem_base = 0;
 #endif
 
 #ifdef CONFIG_PCI
-extern int mpc83xx_pci2_busno;
-
 static int
 mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
@@ -78,17 +69,6 @@ mpc83xx_map_irq(struct pci_dev *dev, uns
 	const long min_idsel = 0x11, max_idsel = 0x20, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 }
-
-static int
-mpc83xx_exclude_device(u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (mpc83xx_pci2_busno)
-		if (bus == (mpc83xx_pci2_busno) && PCI_SLOT(devfn) == 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-	return PCIBIOS_SUCCESSFUL;
-}
 #endif /* CONFIG_PCI */
 
 /* ************************************************************************
@@ -180,42 +160,6 @@ mpc834x_rtc_hookup(void)
 late_initcall(mpc834x_rtc_hookup);
 #endif
 
-static void
-mpc83xx_restart(char *cmd)
-{
-#define RST_OFFSET	0x00000900
-#define RST_PROT_REG	0x00000018
-#define RST_CTRL_REG	0x0000001c
-	__be32 __iomem *reg;
-
-	// map reset register space
-	reg = ioremap(get_immrbase() + 0x900, 0xff);
-
-	local_irq_disable();
-
-	/* enable software reset "RSTE" */
-	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
-
-	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
-	for(;;);
-}
-
-static long __init
-mpc83xx_time_init(void)
-{
-#define SPCR_OFFSET	0x00000110
-#define SPCR_TBEN	0x00400000
-	__be32 __iomem *spcr = ioremap(get_immrbase() + SPCR_OFFSET, 4);
-	__be32 tmp;
-
-	tmp = in_be32(spcr);
-	out_be32(spcr, tmp|SPCR_TBEN);
-
-	iounmap(spcr);
-
-	return 0;
-}
 void __init
 platform_init(void)
 {
@@ -239,5 +183,3 @@ platform_init(void)
 
 	return;
 }
-
-
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index ce9e66a..228d5c4 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -10,5 +10,8 @@
  */
 
 extern int add_bridge(struct device_node *dev);
+extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
+extern void mpc83xx_restart(char *cmd);
+extern long mpc83xx_time_init(void);
 
 #endif /* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 469cdac..70e28fc 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -36,7 +36,16 @@
 
 int mpc83xx_pci2_busno;
 
-#ifdef CONFIG_PCI
+int mpc83xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (mpc83xx_pci2_busno)
+		if (bus == (mpc83xx_pci2_busno) && PCI_SLOT(devfn) == 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	return PCIBIOS_SUCCESSFUL;
+}
+
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
@@ -95,5 +104,3 @@ int __init add_bridge(struct device_node
 
 	return 0;
 }
-
-#endif
