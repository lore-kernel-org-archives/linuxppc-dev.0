Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73AB4B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 17:18:41 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Mon, 26 Mar 2012 14:06:51 +0800
Message-ID: <1332742011-2317-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <shuo.liu@freescale.com>

A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
goes down. when the link goes down, Non-posted transactions issued
via the ATMU requiring completion result in an instruction stall.
At the same time a machine-check exception is generated to the core
to allow further processing by the handler. We implements the handler
which skips the instruction caused the stall.

Signed-off-by: Zhao Chenhui <b35336@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
Changes for v2:
 * Update the copyright infomation.
 * Add check to make sure the hose is for PCIe.

 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
 arch/powerpc/kernel/traps.c               |    3 ++
 arch/powerpc/sysdev/fsl_pci.c             |   41 ++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_pci.h             |    6 ++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8053db0..213cb5e 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -64,7 +64,7 @@ _GLOBAL(__setup_cpu_e500v2)
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500_ivors
-#ifdef CONFIG_FSL_RIO
+#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
 	/* Ensure that RFXE is set */
 	mfspr	r3,SPRN_HID1
 	oris	r3,r3,HID1_RFXE@h
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a750409..3a26b19 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -58,6 +58,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/rio.h>
 #include <asm/fadump.h>
+#include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -554,6 +555,8 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RBERR) {
 		if (fsl_rio_mcheck_exception(regs))
 			return 1;
+		if (fsl_pci_mcheck_exception(regs))
+			return 1;
 	}
 
 	printk("Machine check in kernel mode.\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..2878f11 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007-2011 Freescale Semiconductor, Inc.
+ * Copyright 2007-2012 Freescale Semiconductor, Inc.
  * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
@@ -30,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 #include <asm/machdep.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -807,3 +808,41 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 	return 0;
 }
+
+static int is_in_pci_mem_space(phys_addr_t addr)
+{
+	struct pci_controller *hose;
+	struct resource *res;
+	int i;
+
+	list_for_each_entry(hose, &hose_list, list_node) {
+		if (!early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP))
+			continue;
+
+		for (i = 0; i < 3; i++) {
+			res = &hose->mem_resources[i];
+			if ((res->flags & IORESOURCE_MEM) &&
+				addr >= res->start && addr <= res->end)
+				return 1;
+		}
+	}
+	return 0;
+}
+
+int fsl_pci_mcheck_exception(struct pt_regs *regs)
+{
+	phys_addr_t addr = 0;
+
+#ifdef CONFIG_PHYS_64BIT
+	addr = mfspr(SPRN_MCARU);
+	addr <<= 32;
+#endif
+	addr += mfspr(SPRN_MCAR);
+
+	if (is_in_pci_mem_space(addr)) {
+		regs->nip += 4;
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..96b07ce 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -93,5 +93,11 @@ extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
+#ifdef CONFIG_FSL_PCI
+extern int fsl_pci_mcheck_exception(struct pt_regs *);
+#else
+static inline int fsl_pci_mcheck_exception(struct pt_regs *regs) {return 0; }
+#endif
+
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.5.1
