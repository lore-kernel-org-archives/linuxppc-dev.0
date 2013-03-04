Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9A1C2C0409
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 20:12:26 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Mon, 4 Mar 2013 16:40:25 +0800
Message-ID: <1362386425-20149-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
goes down. when the link goes down, Non-posted transactions issued
via the ATMU requiring completion result in an instruction stall.
At the same time a machine-check exception is generated to the core
to allow further processing by the handler. We implements the handler
which skips the instruction caused the stall.

This patch depends on patch:
powerpc/85xx: Add platform_device declaration to fsl_pci.h

Signed-off-by: Zhao Chenhui <b35336@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
V4 changed:
* Rebased the patch on kernel v3.8.0-rc5

The link for V3:
http://patchwork.ozlabs.org/patch/171120/

 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
 arch/powerpc/kernel/traps.c               |    3 ++
 arch/powerpc/sysdev/fsl_pci.c             |   41 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |    6 ++++
 4 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index dcd8819..f1bde90 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -66,7 +66,7 @@ _GLOBAL(__setup_cpu_e500v2)
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500_ivors
-#ifdef CONFIG_FSL_RIO
+#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
 	/* Ensure that RFXE is set */
 	mfspr	r3,SPRN_HID1
 	oris	r3,r3,HID1_RFXE@h
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a008cf5..dd275a4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -59,6 +59,7 @@
 #include <asm/fadump.h>
 #include <asm/switch_to.h>
 #include <asm/debug.h>
+#include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -556,6 +557,8 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RBERR) {
 		if (fsl_rio_mcheck_exception(regs))
 			return 1;
+		if (fsl_pci_mcheck_exception(regs))
+			return 1;
 	}
 
 	printk("Machine check in kernel mode.\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 682084d..39a10b6 100644
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
@@ -826,6 +827,46 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 	return 0;
 }
 
+#ifdef CONFIG_E500
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
+#endif
+
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,mpc8540-pci", },
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index df66721..ee90a95 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -115,5 +115,11 @@ static inline int mpc85xx_pci_err_probe(struct platform_device *op)
 }
 #endif
 
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
