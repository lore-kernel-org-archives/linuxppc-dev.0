Return-Path: <sfr@canb.auug.org.au>
From: sfr@canb.auug.org.au
To: paulus@samba.org
Subject: [PATCH 10/15] powerpc: move asm/mpc83xx.h
Date: Wed, 05 Apr 2006 15:10:44 +1000
Message-Id: <11442138673826-git-send-email-sfr@canb.auug.org.au>
In-Reply-To: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Since the ARCH=powerpc build depends on this file, move it to
include/asm-powerpc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 include/asm-powerpc/mpc83xx.h |  115 +++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/mpc83xx.h     |  116 -----------------------------------------
 2 files changed, 115 insertions(+), 116 deletions(-)
 create mode 100644 include/asm-powerpc/mpc83xx.h
 delete mode 100644 include/asm-ppc/mpc83xx.h

ce28e1e8654ad07cc23573a31f8cea992d41f9cc
diff --git a/include/asm-powerpc/mpc83xx.h b/include/asm-powerpc/mpc83xx.h
new file mode 100644
index 0000000..da4b0fa
--- /dev/null
+++ b/include/asm-powerpc/mpc83xx.h
@@ -0,0 +1,115 @@
+#ifndef _ASM_POWERPC_MPC83XX_H
+#define _ASM_POWERPC_MPC83XX_H
+/*
+ * include/asm-ppc/mpc83xx.h
+ *
+ * MPC83xx definitions
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+
+#include <asm/mmu.h>
+
+#ifdef CONFIG_83xx
+
+#ifdef CONFIG_MPC834x_SYS
+#include <platforms/83xx/mpc834x_sys.h>
+#endif
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+/*
+ * The "residual" board information structure the boot loader passes
+ * into the kernel.
+ */
+extern unsigned char __res[];
+
+/* Internal IRQs on MPC83xx OpenPIC */
+/* Not all of these exist on all MPC83xx implementations */
+
+#ifndef MPC83xx_IPIC_IRQ_OFFSET
+#define MPC83xx_IPIC_IRQ_OFFSET	0
+#endif
+
+#define NR_IPIC_INTS 128
+
+#define MPC83xx_IRQ_UART1	( 9 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_UART2	(10 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SEC2	(11 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_IIC1	(14 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_IIC2	(15 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SPI		(16 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT1	(17 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT2	(18 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT3	(19 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT4	(20 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT5	(21 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT6	(22 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT7	(23 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_TX	(32 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_RX	(33 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_ERROR	(34 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_TX	(35 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_RX	(36 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_ERROR	(37 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_USB2_DR	(38 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_USB2_MPH	(39 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT0	(48 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_RTC_SEC	(64 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PIT		(65 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PCI1	(66 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PCI2	(67 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_RTC_ALR	(68 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_MU		(69 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SBA		(70 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_DMA		(71 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM4	(72 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM8	(73 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GPIO1	(74 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GPIO2	(75 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_DDR		(76 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_LBC		(77 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM2	(78 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM6	(79 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PMC		(80 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM3	(84 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM7	(85 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM1	(90 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM5	(91 + MPC83xx_IPIC_IRQ_OFFSET)
+
+#define MPC83xx_CCSRBAR_SIZE	(1024*1024)
+
+/* Let modules/drivers get at immrbar (physical) */
+extern phys_addr_t immrbar;
+
+enum ppc_sys_devices {
+	MPC83xx_TSEC1,
+	MPC83xx_TSEC2,
+	MPC83xx_IIC1,
+	MPC83xx_IIC2,
+	MPC83xx_DUART,
+	MPC83xx_SEC2,
+	MPC83xx_USB2_DR,
+	MPC83xx_USB2_MPH,
+	MPC83xx_MDIO,
+	NUM_PPC_SYS_DEVS,
+};
+
+#endif /* CONFIG_83xx */
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_MPC83XX_H */
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
deleted file mode 100644
index 3c23fc4..0000000
--- a/include/asm-ppc/mpc83xx.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * include/asm-ppc/mpc83xx.h
- *
- * MPC83xx definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
- *
- * Copyright 2005 Freescale Semiconductor, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_MPC83xx_H__
-#define __ASM_MPC83xx_H__
-
-#include <linux/config.h>
-#include <asm/mmu.h>
-
-#ifdef CONFIG_83xx
-
-#ifdef CONFIG_MPC834x_SYS
-#include <platforms/83xx/mpc834x_sys.h>
-#endif
-
-#define _IO_BASE        isa_io_base
-#define _ISA_MEM_BASE   isa_mem_base
-#ifdef CONFIG_PCI
-#define PCI_DRAM_OFFSET pci_dram_offset
-#else
-#define PCI_DRAM_OFFSET 0
-#endif
-
-/*
- * The "residual" board information structure the boot loader passes
- * into the kernel.
- */
-extern unsigned char __res[];
-
-/* Internal IRQs on MPC83xx OpenPIC */
-/* Not all of these exist on all MPC83xx implementations */
-
-#ifndef MPC83xx_IPIC_IRQ_OFFSET
-#define MPC83xx_IPIC_IRQ_OFFSET	0
-#endif
-
-#define NR_IPIC_INTS 128
-
-#define MPC83xx_IRQ_UART1	( 9 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_UART2	(10 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_SEC2	(11 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_IIC1	(14 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_IIC2	(15 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_SPI		(16 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT1	(17 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT2	(18 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT3	(19 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT4	(20 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT5	(21 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT6	(22 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT7	(23 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC1_TX	(32 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC1_RX	(33 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC1_ERROR	(34 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC2_TX	(35 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC2_RX	(36 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_TSEC2_ERROR	(37 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_USB2_DR	(38 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_USB2_MPH	(39 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_EXT0	(48 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_RTC_SEC	(64 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_PIT		(65 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_PCI1	(66 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_PCI2	(67 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_RTC_ALR	(68 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_MU		(69 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_SBA		(70 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_DMA		(71 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM4	(72 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM8	(73 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GPIO1	(74 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GPIO2	(75 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_DDR		(76 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_LBC		(77 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM2	(78 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM6	(79 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_PMC		(80 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM3	(84 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM7	(85 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM1	(90 + MPC83xx_IPIC_IRQ_OFFSET)
-#define MPC83xx_IRQ_GTM5	(91 + MPC83xx_IPIC_IRQ_OFFSET)
-
-#define MPC83xx_CCSRBAR_SIZE	(1024*1024)
-
-/* Let modules/drivers get at immrbar (physical) */
-extern phys_addr_t immrbar;
-
-enum ppc_sys_devices {
-	MPC83xx_TSEC1,
-	MPC83xx_TSEC2,
-	MPC83xx_IIC1,
-	MPC83xx_IIC2,
-	MPC83xx_DUART,
-	MPC83xx_SEC2,
-	MPC83xx_USB2_DR,
-	MPC83xx_USB2_MPH,
-	MPC83xx_MDIO,
-	NUM_PPC_SYS_DEVS,
-};
-
-#endif /* CONFIG_83xx */
-#endif /* __ASM_MPC83xx_H__ */
-#endif /* __KERNEL__ */
-- 
1.2.4
