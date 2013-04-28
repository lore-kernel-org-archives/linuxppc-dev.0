Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21C462C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2013 16:01:23 +1000 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>, <segher@kernel.crashing.org>
Subject: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Sun, 28 Apr 2013 13:20:08 +0800
Message-ID: <1367126408-12997-2-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1367126408-12997-1-git-send-email-hongtao.jia@freescale.com>
References: <1367126408-12997-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com
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
Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
V8:
* Add A variant load instruction emulation.

V7:
* Correct PCIe checking method (Using indirect_type member of pci_controller
  stucture).

V6:
* Move OP and XOP defines to a new header file: asm/ppc-disassemble.h
* Add X UX BRX variant of load instruction emulation
* Remove A variant of load instruction emulation

V5:
* Fill rd with all-Fs if the skipped instruction is load and emulate the
  instruction.
* Let KVM/QEMU deal with the exception if the machine check comes from KVM.

 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   2 +-
 arch/powerpc/kernel/traps.c               |   3 +
 arch/powerpc/sysdev/fsl_pci.c             | 158 ++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |   6 ++
 4 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 0b9af01..bfb18c7 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -75,7 +75,7 @@ _GLOBAL(__setup_cpu_e500v2)
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500_ivors
-#ifdef CONFIG_FSL_RIO
+#if defined(CONFIG_FSL_RIO) || defined(CONFIG_FSL_PCI)
 	/* Ensure that RFXE is set */
 	mfspr	r3,SPRN_HID1
 	oris	r3,r3,HID1_RFXE@h
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 37cc40e..d15cfb5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -60,6 +60,7 @@
 #include <asm/switch_to.h>
 #include <asm/tm.h>
 #include <asm/debug.h>
+#include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -565,6 +566,8 @@ int machine_check_e500(struct pt_regs *regs)
 	if (reason & MCSR_BUS_RBERR) {
 		if (fsl_rio_mcheck_exception(regs))
 			return 1;
+		if (fsl_pci_mcheck_exception(regs))
+			return 1;
 	}
 
 	printk("Machine check in kernel mode.\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 40ffe29..5fa851a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -26,11 +26,15 @@
 #include <linux/memblock.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 #include <asm/machdep.h>
+#include <asm/disassemble.h>
+#include <asm/ppc-opcode.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
@@ -876,6 +880,160 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 	return 0;
 }
 
+#ifdef CONFIG_E500
+static int mcheck_handle_load(struct pt_regs *regs, u32 inst)
+{
+	unsigned int rd, ra, rb, d;
+
+	rd = get_rt(inst);
+	ra = get_ra(inst);
+	rb = get_rb(inst);
+	d = get_d(inst);
+
+	switch (get_op(inst)) {
+	case 31:
+		switch (get_xop(inst)) {
+		case OP_31_XOP_LWZX:
+		case OP_31_XOP_LWBRX:
+			regs->gpr[rd] = 0xffffffff;
+			break;
+
+		case OP_31_XOP_LWZUX:
+			regs->gpr[rd] = 0xffffffff;
+			regs->gpr[ra] += regs->gpr[rb];
+			break;
+
+		case OP_31_XOP_LBZX:
+			regs->gpr[rd] = 0xff;
+			break;
+
+		case OP_31_XOP_LBZUX:
+			regs->gpr[rd] = 0xff;
+			regs->gpr[ra] += regs->gpr[rb];
+			break;
+
+		case OP_31_XOP_LHZX:
+		case OP_31_XOP_LHBRX:
+			regs->gpr[rd] = 0xffff;
+			break;
+
+		case OP_31_XOP_LHZUX:
+			regs->gpr[rd] = 0xffff;
+			regs->gpr[ra] += regs->gpr[rb];
+			break;
+
+		case OP_31_XOP_LHAX:
+			regs->gpr[rd] = ~0UL;
+			break;
+
+		case OP_31_XOP_LHAUX:
+			regs->gpr[rd] = ~0UL;
+			regs->gpr[ra] += regs->gpr[rb];
+			break;
+
+		default:
+			return 0;
+		}
+		break;
+
+	case OP_LWZ:
+		regs->gpr[rd] = 0xffffffff;
+		break;
+
+	case OP_LWZU:
+		regs->gpr[rd] = 0xffffffff;
+		regs->gpr[ra] += (s16)d;
+		break;
+
+	case OP_LBZ:
+		regs->gpr[rd] = 0xff;
+		break;
+
+	case OP_LBZU:
+		regs->gpr[rd] = 0xff;
+		regs->gpr[ra] += (s16)d;
+		break;
+
+	case OP_LHZ:
+		regs->gpr[rd] = 0xffff;
+		break;
+
+	case OP_LHZU:
+		regs->gpr[rd] = 0xffff;
+		regs->gpr[ra] += (s16)d;
+		break;
+
+	case OP_LHA:
+		regs->gpr[rd] = ~0UL;
+		break;
+
+	case OP_LHAU:
+		regs->gpr[rd] = ~0UL;
+		regs->gpr[ra] += (s16)d;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+static int is_in_pci_mem_space(phys_addr_t addr)
+{
+	struct pci_controller *hose;
+	struct resource *res;
+	int i;
+
+	list_for_each_entry(hose, &hose_list, list_node) {
+		if (!(hose->indirect_type & PPC_INDIRECT_TYPE_EXT_REG))
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
+	u32 inst;
+	int ret;
+	phys_addr_t addr = 0;
+
+	/* Let KVM/QEMU deal with the exception */
+	if (regs->msr & MSR_GS)
+		return 0;
+
+#ifdef CONFIG_PHYS_64BIT
+	addr = mfspr(SPRN_MCARU);
+	addr <<= 32;
+#endif
+	addr += mfspr(SPRN_MCAR);
+
+	if (is_in_pci_mem_space(addr)) {
+		if (user_mode(regs)) {
+			pagefault_disable();
+			ret = get_user(regs->nip, &inst);
+			pagefault_enable();
+		} else {
+			ret = probe_kernel_address(regs->nip, inst);
+		}
+
+		if (mcheck_handle_load(regs, inst)) {
+			regs->nip += 4;
+			return 1;
+		}
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
index 72b5625..defc422 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -126,5 +126,11 @@ static inline int mpc85xx_pci_err_probe(struct platform_device *op)
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
1.8.0
