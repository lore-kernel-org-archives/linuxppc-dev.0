Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3CA4B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 19:12:32 +1100 (EST)
Received: from mail168-tx2 (localhost [127.0.0.1])	by
 mail168-tx2-R.bigfish.com (Postfix) with ESMTP id 0530B420514	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 08:12:28 +0000 (UTC)
Received: from TX2EHSMHS015.bigfish.com (unknown [10.9.14.239])	by
 mail168-tx2.bigfish.com (Postfix) with ESMTP id 4F6E44400E1	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 08:12:26 +0000 (UTC)
From: <shuo.liu@freesacle.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe erratum
 on mpc85xx
Date: Fri, 10 Feb 2012 16:09:47 +0800
Message-ID: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Chenhui <b35336@freescale.com>, Liu Shuo <b35362@freescale.com>,
 r61911@freescale.com, Liu Shuo <shuo.liu@freescale.com>,
 scottwood@freescale.com
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
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
 arch/powerpc/kernel/traps.c               |    3 ++
 arch/powerpc/sysdev/fsl_pci.c             |   36 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |    6 +++++
 4 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 2c03ac2..beef028 100644
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
index 343c46b..1d6bcc0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -57,6 +57,7 @@
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
 #include <asm/rio.h>
+#include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -525,6 +526,8 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RBERR) {
 		if (fsl_rio_mcheck_exception(regs))
 			return 1;
+		if (fsl_pci_mcheck_exception(regs))
+			return 1;
 	}
 
 	printk("Machine check in kernel mode.\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6bc3bfd..8ea23f0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -30,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 #include <asm/machdep.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -727,3 +728,38 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
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
1.7.1
