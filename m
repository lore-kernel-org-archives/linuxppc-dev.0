Return-Path: <galak@gate.crashing.org>
Date: Mon, 14 Nov 2005 12:54:33 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511141254020.1850-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] powerpc: moved ipic code to arch/powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved 83xx and QUICC Engine interrupt handling code into arch/powerpc
as a precursor of getting 83xx sub-arch building in arch/powerpc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 37ae6e53ffc338b28dc5409f0a6be4d8374cca21
tree 4aa155c3faff04f1c287c7e19fbe38182aa266e1
parent e982b09df1f635eb047e5be9633c89045ba021c2
author Kumar Gala <galak@kernel.crashing.org> Mon, 14 Nov 2005 12:54:33 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 14 Nov 2005 12:54:33 -0600

 arch/powerpc/sysdev/Makefile |    1 
 arch/powerpc/sysdev/ipic.c   |  646 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ipic.h   |   49 +++
 arch/ppc/syslib/Makefile     |    2 
 arch/ppc/syslib/ipic.c       |  646 ------------------------------------------
 arch/ppc/syslib/ipic.h       |   49 ---
 include/asm-powerpc/ipic.h   |   85 ++++++
 include/asm-ppc/ipic.h       |   85 ------
 8 files changed, 782 insertions(+), 781 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 6b7efcf..b3e3636 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_U3_DART)		+= u3_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
+obj-$(CONFIG_83xx)		+= ipic.o
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
new file mode 100644
index 0000000..8f01e0f
--- /dev/null
+++ b/arch/powerpc/sysdev/ipic.c
@@ -0,0 +1,646 @@
+/*
+ * include/asm-ppc/ipic.c
+ *
+ * IPIC routines implementations.
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sysdev.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/ipic.h>
+#include <asm/mpc83xx.h>
+
+#include "ipic.h"
+
+static struct ipic p_ipic;
+static struct ipic * primary_ipic;
+
+static struct ipic_info ipic_info[] = {
+	[9] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 24,
+		.prio_mask = 0,
+	},
+	[10] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 25,
+		.prio_mask = 1,
+	},
+	[11] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 26,
+		.prio_mask = 2,
+	},
+	[14] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 29,
+		.prio_mask = 5,
+	},
+	[15] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 30,
+		.prio_mask = 6,
+	},
+	[16] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 31,
+		.prio_mask = 7,
+	},
+	[17] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 1,
+		.prio_mask = 5,
+	},
+	[18] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 2,
+		.prio_mask = 6,
+	},
+	[19] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 3,
+		.prio_mask = 7,
+	},
+	[20] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 4,
+		.prio_mask = 4,
+	},
+	[21] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 5,
+		.prio_mask = 5,
+	},
+	[22] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 6,
+		.prio_mask = 6,
+	},
+	[23] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 7,
+		.prio_mask = 7,
+	},
+	[32] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 0,
+		.prio_mask = 0,
+	},
+	[33] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 1,
+		.prio_mask = 1,
+	},
+	[34] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 2,
+		.prio_mask = 2,
+	},
+	[35] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 3,
+		.prio_mask = 3,
+	},
+	[36] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 4,
+		.prio_mask = 4,
+	},
+	[37] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 5,
+		.prio_mask = 5,
+	},
+	[38] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 6,
+		.prio_mask = 6,
+	},
+	[39] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 7,
+		.prio_mask = 7,
+	},
+	[48] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 0,
+		.prio_mask = 4,
+	},
+	[64] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 0,
+		.prio_mask = 0,
+	},
+	[65] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 1,
+		.prio_mask = 1,
+	},
+	[66] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 2,
+		.prio_mask = 2,
+	},
+	[67] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 3,
+		.prio_mask = 3,
+	},
+	[68] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 4,
+		.prio_mask = 0,
+	},
+	[69] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 5,
+		.prio_mask = 1,
+	},
+	[70] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 6,
+		.prio_mask = 2,
+	},
+	[71] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 7,
+		.prio_mask = 3,
+	},
+	[72] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 8,
+	},
+	[73] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 9,
+	},
+	[74] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 10,
+	},
+	[75] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 11,
+	},
+	[76] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 12,
+	},
+	[77] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 13,
+	},
+	[78] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 14,
+	},
+	[79] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 15,
+	},
+	[80] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 16,
+	},
+	[84] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 20,
+	},
+	[85] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 21,
+	},
+	[90] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 26,
+	},
+	[91] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 27,
+	},
+};
+
+static inline u32 ipic_read(volatile u32 __iomem *base, unsigned int reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static inline void ipic_write(volatile u32 __iomem *base, unsigned int reg, u32 value)
+{
+	out_be32(base + (reg >> 2), value);
+}
+
+static inline struct ipic * ipic_from_irq(unsigned int irq)
+{
+	return primary_ipic;
+}
+
+static void ipic_enable_irq(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].mask);
+	temp |= (1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].mask, temp);
+}
+
+static void ipic_disable_irq(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].mask);
+	temp &= ~(1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].mask, temp);
+}
+
+static void ipic_disable_irq_and_ack(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	ipic_disable_irq(irq);
+
+	temp = ipic_read(ipic->regs, ipic_info[src].pend);
+	temp |= (1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+}
+
+static void ipic_end_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		ipic_enable_irq(irq);
+}
+
+struct hw_interrupt_type ipic = {
+	.typename = " IPIC  ",
+	.enable = ipic_enable_irq,
+	.disable = ipic_disable_irq,
+	.ack = ipic_disable_irq_and_ack,
+	.end = ipic_end_irq,
+};
+
+void __init ipic_init(phys_addr_t phys_addr,
+		unsigned int flags,
+		unsigned int irq_offset,
+		unsigned char *senses,
+		unsigned int senses_count)
+{
+	u32 i, temp = 0;
+
+	primary_ipic = &p_ipic;
+	primary_ipic->regs = ioremap(phys_addr, MPC83xx_IPIC_SIZE);
+
+	primary_ipic->irq_offset = irq_offset;
+
+	ipic_write(primary_ipic->regs, IPIC_SICNR, 0x0);
+
+	/* default priority scheme is grouped. If spread mode is required
+	 * configure SICFR accordingly */
+	if (flags & IPIC_SPREADMODE_GRP_A)
+		temp |= SICFR_IPSA;
+	if (flags & IPIC_SPREADMODE_GRP_D)
+		temp |= SICFR_IPSD;
+	if (flags & IPIC_SPREADMODE_MIX_A)
+		temp |= SICFR_MPSA;
+	if (flags & IPIC_SPREADMODE_MIX_B)
+		temp |= SICFR_MPSB;
+
+	ipic_write(primary_ipic->regs, IPIC_SICNR, temp);
+
+	/* handle MCP route */
+	temp = 0;
+	if (flags & IPIC_DISABLE_MCP_OUT)
+		temp = SERCR_MCPR;
+	ipic_write(primary_ipic->regs, IPIC_SERCR, temp);
+
+	/* handle routing of IRQ0 to MCP */
+	temp = ipic_read(primary_ipic->regs, IPIC_SEMSR);
+
+	if (flags & IPIC_IRQ0_MCP)
+		temp |= SEMSR_SIRQ0;
+	else
+		temp &= ~SEMSR_SIRQ0;
+
+	ipic_write(primary_ipic->regs, IPIC_SEMSR, temp);
+
+	for (i = 0 ; i < NR_IPIC_INTS ; i++) {
+		irq_desc[i+irq_offset].handler = &ipic;
+		irq_desc[i+irq_offset].status = IRQ_LEVEL;
+	}
+
+	temp = 0;
+	for (i = 0 ; i < senses_count ; i++) {
+		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
+			temp |= 1 << (15 - i);
+			if (i != 0)
+				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
+			else
+				irq_desc[irq_offset + MPC83xx_IRQ_EXT0].status = 0;
+		}
+	}
+	ipic_write(primary_ipic->regs, IPIC_SECNR, temp);
+
+	printk ("IPIC (%d IRQ sources, %d External IRQs) at %p\n", NR_IPIC_INTS,
+			senses_count, primary_ipic->regs);
+}
+
+int ipic_set_priority(unsigned int irq, unsigned int priority)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	if (priority > 7)
+		return -EINVAL;
+	if (src > 127)
+		return -EINVAL;
+	if (ipic_info[src].prio == 0)
+		return -EINVAL;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].prio);
+
+	if (priority < 4) {
+		temp &= ~(0x7 << (20 + (3 - priority) * 3));
+		temp |= ipic_info[src].prio_mask << (20 + (3 - priority) * 3);
+	} else {
+		temp &= ~(0x7 << (4 + (7 - priority) * 3));
+		temp |= ipic_info[src].prio_mask << (4 + (7 - priority) * 3);
+	}
+
+	ipic_write(ipic->regs, ipic_info[src].prio, temp);
+
+	return 0;
+}
+
+void ipic_set_highest_priority(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SICFR);
+
+	/* clear and set HPI */
+	temp &= 0x7f000000;
+	temp |= (src & 0x7f) << 24;
+
+	ipic_write(ipic->regs, IPIC_SICFR, temp);
+}
+
+void ipic_set_default_priority(void)
+{
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
+	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
+	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
+
+	ipic_set_priority(MPC83xx_IRQ_UART1, 0);
+	ipic_set_priority(MPC83xx_IRQ_UART2, 1);
+	ipic_set_priority(MPC83xx_IRQ_SEC2, 2);
+	ipic_set_priority(MPC83xx_IRQ_IIC1, 5);
+	ipic_set_priority(MPC83xx_IRQ_IIC2, 6);
+	ipic_set_priority(MPC83xx_IRQ_SPI, 7);
+	ipic_set_priority(MPC83xx_IRQ_RTC_SEC, 0);
+	ipic_set_priority(MPC83xx_IRQ_PIT, 1);
+	ipic_set_priority(MPC83xx_IRQ_PCI1, 2);
+	ipic_set_priority(MPC83xx_IRQ_PCI2, 3);
+	ipic_set_priority(MPC83xx_IRQ_EXT0, 4);
+	ipic_set_priority(MPC83xx_IRQ_EXT1, 5);
+	ipic_set_priority(MPC83xx_IRQ_EXT2, 6);
+	ipic_set_priority(MPC83xx_IRQ_EXT3, 7);
+	ipic_set_priority(MPC83xx_IRQ_RTC_ALR, 0);
+	ipic_set_priority(MPC83xx_IRQ_MU, 1);
+	ipic_set_priority(MPC83xx_IRQ_SBA, 2);
+	ipic_set_priority(MPC83xx_IRQ_DMA, 3);
+	ipic_set_priority(MPC83xx_IRQ_EXT4, 4);
+	ipic_set_priority(MPC83xx_IRQ_EXT5, 5);
+	ipic_set_priority(MPC83xx_IRQ_EXT6, 6);
+	ipic_set_priority(MPC83xx_IRQ_EXT7, 7);
+}
+
+void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
+{
+	struct ipic *ipic = primary_ipic;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SERMR);
+	temp |= (1 << (31 - mcp_irq));
+	ipic_write(ipic->regs, IPIC_SERMR, temp);
+}
+
+void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
+{
+	struct ipic *ipic = primary_ipic;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SERMR);
+	temp &= (1 << (31 - mcp_irq));
+	ipic_write(ipic->regs, IPIC_SERMR, temp);
+}
+
+u32 ipic_get_mcp_status(void)
+{
+	return ipic_read(primary_ipic->regs, IPIC_SERMR);
+}
+
+void ipic_clear_mcp_status(u32 mask)
+{
+	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
+}
+
+/* Return an interrupt vector or -1 if no interrupt is pending. */
+int ipic_get_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & 0x7f;
+
+	if (irq == 0)    /* 0 --> no irq is pending */
+		irq = -1;
+
+	return irq;
+}
+
+static struct sysdev_class ipic_sysclass = {
+	set_kset_name("ipic"),
+};
+
+static struct sys_device device_ipic = {
+	.id		= 0,
+	.cls		= &ipic_sysclass,
+};
+
+static int __init init_ipic_sysfs(void)
+{
+	int rc;
+
+	if (!primary_ipic->regs)
+		return -ENODEV;
+	printk(KERN_DEBUG "Registering ipic with sysfs...\n");
+
+	rc = sysdev_class_register(&ipic_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering ipic sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_ipic);
+	if (rc) {
+		printk(KERN_ERR "Failed registering ipic sys device\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_ipic_sysfs);
diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
new file mode 100644
index 0000000..a7ce7da
--- /dev/null
+++ b/arch/powerpc/sysdev/ipic.h
@@ -0,0 +1,49 @@
+/*
+ * arch/ppc/kernel/ipic.h
+ *
+ * IPIC private definitions and structure.
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
+#ifndef __IPIC_H__
+#define __IPIC_H__
+
+#include <asm/ipic.h>
+
+#define MPC83xx_IPIC_SIZE	(0x00100)
+
+/* System Global Interrupt Configuration Register */
+#define	SICFR_IPSA	0x00010000
+#define	SICFR_IPSD	0x00080000
+#define	SICFR_MPSA	0x00200000
+#define	SICFR_MPSB	0x00400000
+
+/* System External Interrupt Mask Register */
+#define	SEMSR_SIRQ0	0x00008000
+
+/* System Error Control Register */
+#define SERCR_MCPR	0x00000001
+
+struct ipic {
+	volatile u32 __iomem	*regs;
+	unsigned int		irq_offset;
+};
+
+struct ipic_info {
+	u8	pend;		/* pending register offset from base */
+	u8	mask;		/* mask register offset from base */
+	u8	prio;		/* priority register offset from base */
+	u8	force;		/* force register offset from base */
+	u8	bit;		/* register bit position (as per doc)
+				   bit mask = 1 << (31 - bit) */
+	u8	prio_mask;	/* priority mask value */
+};
+
+#endif /* __IPIC_H__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 5b7f2b8..84ef030 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -96,7 +96,7 @@ ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o
 endif
 obj-$(CONFIG_RAPIDIO)		+= ppc85xx_rio.o
-obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_setup.o ppc_sys.o \
+obj-$(CONFIG_83xx)		+= ppc83xx_setup.o ppc_sys.o \
 					mpc83xx_sys.o mpc83xx_devices.o
 ifeq ($(CONFIG_83xx),y)
 obj-$(CONFIG_PCI)		+= pci_auto.o
diff --git a/arch/ppc/syslib/ipic.c b/arch/ppc/syslib/ipic.c
deleted file mode 100644
index 8f01e0f..0000000
--- a/arch/ppc/syslib/ipic.c
+++ /dev/null
@@ -1,646 +0,0 @@
-/*
- * include/asm-ppc/ipic.c
- *
- * IPIC routines implementations.
- *
- * Copyright 2005 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/slab.h>
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/sysdev.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/ipic.h>
-#include <asm/mpc83xx.h>
-
-#include "ipic.h"
-
-static struct ipic p_ipic;
-static struct ipic * primary_ipic;
-
-static struct ipic_info ipic_info[] = {
-	[9] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 24,
-		.prio_mask = 0,
-	},
-	[10] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 25,
-		.prio_mask = 1,
-	},
-	[11] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 26,
-		.prio_mask = 2,
-	},
-	[14] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 29,
-		.prio_mask = 5,
-	},
-	[15] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 30,
-		.prio_mask = 6,
-	},
-	[16] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_D,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 31,
-		.prio_mask = 7,
-	},
-	[17] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SEFCR,
-		.bit	= 1,
-		.prio_mask = 5,
-	},
-	[18] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SEFCR,
-		.bit	= 2,
-		.prio_mask = 6,
-	},
-	[19] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SEFCR,
-		.bit	= 3,
-		.prio_mask = 7,
-	},
-	[20] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SEFCR,
-		.bit	= 4,
-		.prio_mask = 4,
-	},
-	[21] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SEFCR,
-		.bit	= 5,
-		.prio_mask = 5,
-	},
-	[22] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SEFCR,
-		.bit	= 6,
-		.prio_mask = 6,
-	},
-	[23] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SEFCR,
-		.bit	= 7,
-		.prio_mask = 7,
-	},
-	[32] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 0,
-		.prio_mask = 0,
-	},
-	[33] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 1,
-		.prio_mask = 1,
-	},
-	[34] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 2,
-		.prio_mask = 2,
-	},
-	[35] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 3,
-		.prio_mask = 3,
-	},
-	[36] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 4,
-		.prio_mask = 4,
-	},
-	[37] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 5,
-		.prio_mask = 5,
-	},
-	[38] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 6,
-		.prio_mask = 6,
-	},
-	[39] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_H,
-		.prio	= IPIC_SIPRR_A,
-		.force	= IPIC_SIFCR_H,
-		.bit	= 7,
-		.prio_mask = 7,
-	},
-	[48] = {
-		.pend	= IPIC_SEPNR,
-		.mask	= IPIC_SEMSR,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SEFCR,
-		.bit	= 0,
-		.prio_mask = 4,
-	},
-	[64] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 0,
-		.prio_mask = 0,
-	},
-	[65] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 1,
-		.prio_mask = 1,
-	},
-	[66] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 2,
-		.prio_mask = 2,
-	},
-	[67] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_A,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 3,
-		.prio_mask = 3,
-	},
-	[68] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 4,
-		.prio_mask = 0,
-	},
-	[69] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 5,
-		.prio_mask = 1,
-	},
-	[70] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 6,
-		.prio_mask = 2,
-	},
-	[71] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= IPIC_SMPRR_B,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 7,
-		.prio_mask = 3,
-	},
-	[72] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 8,
-	},
-	[73] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 9,
-	},
-	[74] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 10,
-	},
-	[75] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 11,
-	},
-	[76] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 12,
-	},
-	[77] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 13,
-	},
-	[78] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 14,
-	},
-	[79] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 15,
-	},
-	[80] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 16,
-	},
-	[84] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 20,
-	},
-	[85] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 21,
-	},
-	[90] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 26,
-	},
-	[91] = {
-		.pend	= IPIC_SIPNR_H,
-		.mask	= IPIC_SIMSR_L,
-		.prio	= 0,
-		.force	= IPIC_SIFCR_L,
-		.bit	= 27,
-	},
-};
-
-static inline u32 ipic_read(volatile u32 __iomem *base, unsigned int reg)
-{
-	return in_be32(base + (reg >> 2));
-}
-
-static inline void ipic_write(volatile u32 __iomem *base, unsigned int reg, u32 value)
-{
-	out_be32(base + (reg >> 2), value);
-}
-
-static inline struct ipic * ipic_from_irq(unsigned int irq)
-{
-	return primary_ipic;
-}
-
-static void ipic_enable_irq(unsigned int irq)
-{
-	struct ipic *ipic = ipic_from_irq(irq);
-	unsigned int src = irq - ipic->irq_offset;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, ipic_info[src].mask);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].mask, temp);
-}
-
-static void ipic_disable_irq(unsigned int irq)
-{
-	struct ipic *ipic = ipic_from_irq(irq);
-	unsigned int src = irq - ipic->irq_offset;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, ipic_info[src].mask);
-	temp &= ~(1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].mask, temp);
-}
-
-static void ipic_disable_irq_and_ack(unsigned int irq)
-{
-	struct ipic *ipic = ipic_from_irq(irq);
-	unsigned int src = irq - ipic->irq_offset;
-	u32 temp;
-
-	ipic_disable_irq(irq);
-
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
-}
-
-static void ipic_end_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		ipic_enable_irq(irq);
-}
-
-struct hw_interrupt_type ipic = {
-	.typename = " IPIC  ",
-	.enable = ipic_enable_irq,
-	.disable = ipic_disable_irq,
-	.ack = ipic_disable_irq_and_ack,
-	.end = ipic_end_irq,
-};
-
-void __init ipic_init(phys_addr_t phys_addr,
-		unsigned int flags,
-		unsigned int irq_offset,
-		unsigned char *senses,
-		unsigned int senses_count)
-{
-	u32 i, temp = 0;
-
-	primary_ipic = &p_ipic;
-	primary_ipic->regs = ioremap(phys_addr, MPC83xx_IPIC_SIZE);
-
-	primary_ipic->irq_offset = irq_offset;
-
-	ipic_write(primary_ipic->regs, IPIC_SICNR, 0x0);
-
-	/* default priority scheme is grouped. If spread mode is required
-	 * configure SICFR accordingly */
-	if (flags & IPIC_SPREADMODE_GRP_A)
-		temp |= SICFR_IPSA;
-	if (flags & IPIC_SPREADMODE_GRP_D)
-		temp |= SICFR_IPSD;
-	if (flags & IPIC_SPREADMODE_MIX_A)
-		temp |= SICFR_MPSA;
-	if (flags & IPIC_SPREADMODE_MIX_B)
-		temp |= SICFR_MPSB;
-
-	ipic_write(primary_ipic->regs, IPIC_SICNR, temp);
-
-	/* handle MCP route */
-	temp = 0;
-	if (flags & IPIC_DISABLE_MCP_OUT)
-		temp = SERCR_MCPR;
-	ipic_write(primary_ipic->regs, IPIC_SERCR, temp);
-
-	/* handle routing of IRQ0 to MCP */
-	temp = ipic_read(primary_ipic->regs, IPIC_SEMSR);
-
-	if (flags & IPIC_IRQ0_MCP)
-		temp |= SEMSR_SIRQ0;
-	else
-		temp &= ~SEMSR_SIRQ0;
-
-	ipic_write(primary_ipic->regs, IPIC_SEMSR, temp);
-
-	for (i = 0 ; i < NR_IPIC_INTS ; i++) {
-		irq_desc[i+irq_offset].handler = &ipic;
-		irq_desc[i+irq_offset].status = IRQ_LEVEL;
-	}
-
-	temp = 0;
-	for (i = 0 ; i < senses_count ; i++) {
-		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
-			temp |= 1 << (15 - i);
-			if (i != 0)
-				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
-			else
-				irq_desc[irq_offset + MPC83xx_IRQ_EXT0].status = 0;
-		}
-	}
-	ipic_write(primary_ipic->regs, IPIC_SECNR, temp);
-
-	printk ("IPIC (%d IRQ sources, %d External IRQs) at %p\n", NR_IPIC_INTS,
-			senses_count, primary_ipic->regs);
-}
-
-int ipic_set_priority(unsigned int irq, unsigned int priority)
-{
-	struct ipic *ipic = ipic_from_irq(irq);
-	unsigned int src = irq - ipic->irq_offset;
-	u32 temp;
-
-	if (priority > 7)
-		return -EINVAL;
-	if (src > 127)
-		return -EINVAL;
-	if (ipic_info[src].prio == 0)
-		return -EINVAL;
-
-	temp = ipic_read(ipic->regs, ipic_info[src].prio);
-
-	if (priority < 4) {
-		temp &= ~(0x7 << (20 + (3 - priority) * 3));
-		temp |= ipic_info[src].prio_mask << (20 + (3 - priority) * 3);
-	} else {
-		temp &= ~(0x7 << (4 + (7 - priority) * 3));
-		temp |= ipic_info[src].prio_mask << (4 + (7 - priority) * 3);
-	}
-
-	ipic_write(ipic->regs, ipic_info[src].prio, temp);
-
-	return 0;
-}
-
-void ipic_set_highest_priority(unsigned int irq)
-{
-	struct ipic *ipic = ipic_from_irq(irq);
-	unsigned int src = irq - ipic->irq_offset;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SICFR);
-
-	/* clear and set HPI */
-	temp &= 0x7f000000;
-	temp |= (src & 0x7f) << 24;
-
-	ipic_write(ipic->regs, IPIC_SICFR, temp);
-}
-
-void ipic_set_default_priority(void)
-{
-	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
-	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
-	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
-	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
-	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
-	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
-	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
-	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
-
-	ipic_set_priority(MPC83xx_IRQ_UART1, 0);
-	ipic_set_priority(MPC83xx_IRQ_UART2, 1);
-	ipic_set_priority(MPC83xx_IRQ_SEC2, 2);
-	ipic_set_priority(MPC83xx_IRQ_IIC1, 5);
-	ipic_set_priority(MPC83xx_IRQ_IIC2, 6);
-	ipic_set_priority(MPC83xx_IRQ_SPI, 7);
-	ipic_set_priority(MPC83xx_IRQ_RTC_SEC, 0);
-	ipic_set_priority(MPC83xx_IRQ_PIT, 1);
-	ipic_set_priority(MPC83xx_IRQ_PCI1, 2);
-	ipic_set_priority(MPC83xx_IRQ_PCI2, 3);
-	ipic_set_priority(MPC83xx_IRQ_EXT0, 4);
-	ipic_set_priority(MPC83xx_IRQ_EXT1, 5);
-	ipic_set_priority(MPC83xx_IRQ_EXT2, 6);
-	ipic_set_priority(MPC83xx_IRQ_EXT3, 7);
-	ipic_set_priority(MPC83xx_IRQ_RTC_ALR, 0);
-	ipic_set_priority(MPC83xx_IRQ_MU, 1);
-	ipic_set_priority(MPC83xx_IRQ_SBA, 2);
-	ipic_set_priority(MPC83xx_IRQ_DMA, 3);
-	ipic_set_priority(MPC83xx_IRQ_EXT4, 4);
-	ipic_set_priority(MPC83xx_IRQ_EXT5, 5);
-	ipic_set_priority(MPC83xx_IRQ_EXT6, 6);
-	ipic_set_priority(MPC83xx_IRQ_EXT7, 7);
-}
-
-void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
-{
-	struct ipic *ipic = primary_ipic;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SERMR);
-	temp |= (1 << (31 - mcp_irq));
-	ipic_write(ipic->regs, IPIC_SERMR, temp);
-}
-
-void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
-{
-	struct ipic *ipic = primary_ipic;
-	u32 temp;
-
-	temp = ipic_read(ipic->regs, IPIC_SERMR);
-	temp &= (1 << (31 - mcp_irq));
-	ipic_write(ipic->regs, IPIC_SERMR, temp);
-}
-
-u32 ipic_get_mcp_status(void)
-{
-	return ipic_read(primary_ipic->regs, IPIC_SERMR);
-}
-
-void ipic_clear_mcp_status(u32 mask)
-{
-	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
-}
-
-/* Return an interrupt vector or -1 if no interrupt is pending. */
-int ipic_get_irq(struct pt_regs *regs)
-{
-	int irq;
-
-	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & 0x7f;
-
-	if (irq == 0)    /* 0 --> no irq is pending */
-		irq = -1;
-
-	return irq;
-}
-
-static struct sysdev_class ipic_sysclass = {
-	set_kset_name("ipic"),
-};
-
-static struct sys_device device_ipic = {
-	.id		= 0,
-	.cls		= &ipic_sysclass,
-};
-
-static int __init init_ipic_sysfs(void)
-{
-	int rc;
-
-	if (!primary_ipic->regs)
-		return -ENODEV;
-	printk(KERN_DEBUG "Registering ipic with sysfs...\n");
-
-	rc = sysdev_class_register(&ipic_sysclass);
-	if (rc) {
-		printk(KERN_ERR "Failed registering ipic sys class\n");
-		return -ENODEV;
-	}
-	rc = sysdev_register(&device_ipic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering ipic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-subsys_initcall(init_ipic_sysfs);
diff --git a/arch/ppc/syslib/ipic.h b/arch/ppc/syslib/ipic.h
deleted file mode 100644
index a7ce7da..0000000
--- a/arch/ppc/syslib/ipic.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * arch/ppc/kernel/ipic.h
- *
- * IPIC private definitions and structure.
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
-#ifndef __IPIC_H__
-#define __IPIC_H__
-
-#include <asm/ipic.h>
-
-#define MPC83xx_IPIC_SIZE	(0x00100)
-
-/* System Global Interrupt Configuration Register */
-#define	SICFR_IPSA	0x00010000
-#define	SICFR_IPSD	0x00080000
-#define	SICFR_MPSA	0x00200000
-#define	SICFR_MPSB	0x00400000
-
-/* System External Interrupt Mask Register */
-#define	SEMSR_SIRQ0	0x00008000
-
-/* System Error Control Register */
-#define SERCR_MCPR	0x00000001
-
-struct ipic {
-	volatile u32 __iomem	*regs;
-	unsigned int		irq_offset;
-};
-
-struct ipic_info {
-	u8	pend;		/* pending register offset from base */
-	u8	mask;		/* mask register offset from base */
-	u8	prio;		/* priority register offset from base */
-	u8	force;		/* force register offset from base */
-	u8	bit;		/* register bit position (as per doc)
-				   bit mask = 1 << (31 - bit) */
-	u8	prio_mask;	/* priority mask value */
-};
-
-#endif /* __IPIC_H__ */
diff --git a/include/asm-powerpc/ipic.h b/include/asm-powerpc/ipic.h
new file mode 100644
index 0000000..0fe396a
--- /dev/null
+++ b/include/asm-powerpc/ipic.h
@@ -0,0 +1,85 @@
+/*
+ * include/asm-ppc/ipic.h
+ *
+ * IPIC external definitions and structure.
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
+#ifdef __KERNEL__
+#ifndef __ASM_IPIC_H__
+#define __ASM_IPIC_H__
+
+#include <linux/irq.h>
+
+/* Flags when we init the IPIC */
+#define IPIC_SPREADMODE_GRP_A	0x00000001
+#define IPIC_SPREADMODE_GRP_D	0x00000002
+#define IPIC_SPREADMODE_MIX_A	0x00000004
+#define IPIC_SPREADMODE_MIX_B	0x00000008
+#define IPIC_DISABLE_MCP_OUT	0x00000010
+#define IPIC_IRQ0_MCP		0x00000020
+
+/* IPIC registers offsets */
+#define IPIC_SICFR	0x00	/* System Global Interrupt Configuration Register */
+#define IPIC_SIVCR	0x04	/* System Global Interrupt Vector Register */
+#define IPIC_SIPNR_H	0x08	/* System Internal Interrupt Pending Register (HIGH) */
+#define IPIC_SIPNR_L	0x0C	/* System Internal Interrupt Pending Register (LOW) */
+#define IPIC_SIPRR_A	0x10	/* System Internal Interrupt group A Priority Register */
+#define IPIC_SIPRR_B	0x14	/* System Internal Interrupt group B Priority Register */
+#define IPIC_SIPRR_C	0x18	/* System Internal Interrupt group C Priority Register */
+#define IPIC_SIPRR_D	0x1C	/* System Internal Interrupt group D Priority Register */
+#define IPIC_SIMSR_H	0x20	/* System Internal Interrupt Mask Register (HIGH) */
+#define IPIC_SIMSR_L	0x24	/* System Internal Interrupt Mask Register (LOW) */
+#define IPIC_SICNR	0x28	/* System Internal Interrupt Control Register */
+#define IPIC_SEPNR	0x2C	/* System External Interrupt Pending Register */
+#define IPIC_SMPRR_A	0x30	/* System Mixed Interrupt group A Priority Register */
+#define IPIC_SMPRR_B	0x34	/* System Mixed Interrupt group B Priority Register */
+#define IPIC_SEMSR	0x38	/* System External Interrupt Mask Register */
+#define IPIC_SECNR	0x3C	/* System External Interrupt Control Register */
+#define IPIC_SERSR	0x40	/* System Error Status Register */
+#define IPIC_SERMR	0x44	/* System Error Mask Register */
+#define IPIC_SERCR	0x48	/* System Error Control Register */
+#define IPIC_SIFCR_H	0x50	/* System Internal Interrupt Force Register (HIGH) */
+#define IPIC_SIFCR_L	0x54	/* System Internal Interrupt Force Register (LOW) */
+#define IPIC_SEFCR	0x58	/* System External Interrupt Force Register */
+#define IPIC_SERFR	0x5C	/* System Error Force Register */
+#define IPIC_SCVCR	0x60	/* System Critical Interrupt Vector Register */
+#define IPIC_SMVCR	0x64	/* System Management Interrupt Vector Register */
+
+enum ipic_prio_grp {
+	IPIC_INT_GRP_A = IPIC_SIPRR_A,
+	IPIC_INT_GRP_D = IPIC_SIPRR_D,
+	IPIC_MIX_GRP_A = IPIC_SMPRR_A,
+	IPIC_MIX_GRP_B = IPIC_SMPRR_B,
+};
+
+enum ipic_mcp_irq {
+	IPIC_MCP_IRQ0 = 0,
+	IPIC_MCP_WDT  = 1,
+	IPIC_MCP_SBA  = 2,
+	IPIC_MCP_PCI1 = 5,
+	IPIC_MCP_PCI2 = 6,
+	IPIC_MCP_MU   = 7,
+};
+
+extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
+		unsigned int irq_offset,
+		unsigned char *senses, unsigned int senses_count);
+extern int ipic_set_priority(unsigned int irq, unsigned int priority);
+extern void ipic_set_highest_priority(unsigned int irq);
+extern void ipic_set_default_priority(void);
+extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
+extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
+extern u32 ipic_get_mcp_status(void);
+extern void ipic_clear_mcp_status(u32 mask);
+extern int ipic_get_irq(struct pt_regs *regs);
+
+#endif /* __ASM_IPIC_H__ */
+#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/ipic.h b/include/asm-ppc/ipic.h
deleted file mode 100644
index 0fe396a..0000000
--- a/include/asm-ppc/ipic.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * include/asm-ppc/ipic.h
- *
- * IPIC external definitions and structure.
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
-#ifdef __KERNEL__
-#ifndef __ASM_IPIC_H__
-#define __ASM_IPIC_H__
-
-#include <linux/irq.h>
-
-/* Flags when we init the IPIC */
-#define IPIC_SPREADMODE_GRP_A	0x00000001
-#define IPIC_SPREADMODE_GRP_D	0x00000002
-#define IPIC_SPREADMODE_MIX_A	0x00000004
-#define IPIC_SPREADMODE_MIX_B	0x00000008
-#define IPIC_DISABLE_MCP_OUT	0x00000010
-#define IPIC_IRQ0_MCP		0x00000020
-
-/* IPIC registers offsets */
-#define IPIC_SICFR	0x00	/* System Global Interrupt Configuration Register */
-#define IPIC_SIVCR	0x04	/* System Global Interrupt Vector Register */
-#define IPIC_SIPNR_H	0x08	/* System Internal Interrupt Pending Register (HIGH) */
-#define IPIC_SIPNR_L	0x0C	/* System Internal Interrupt Pending Register (LOW) */
-#define IPIC_SIPRR_A	0x10	/* System Internal Interrupt group A Priority Register */
-#define IPIC_SIPRR_B	0x14	/* System Internal Interrupt group B Priority Register */
-#define IPIC_SIPRR_C	0x18	/* System Internal Interrupt group C Priority Register */
-#define IPIC_SIPRR_D	0x1C	/* System Internal Interrupt group D Priority Register */
-#define IPIC_SIMSR_H	0x20	/* System Internal Interrupt Mask Register (HIGH) */
-#define IPIC_SIMSR_L	0x24	/* System Internal Interrupt Mask Register (LOW) */
-#define IPIC_SICNR	0x28	/* System Internal Interrupt Control Register */
-#define IPIC_SEPNR	0x2C	/* System External Interrupt Pending Register */
-#define IPIC_SMPRR_A	0x30	/* System Mixed Interrupt group A Priority Register */
-#define IPIC_SMPRR_B	0x34	/* System Mixed Interrupt group B Priority Register */
-#define IPIC_SEMSR	0x38	/* System External Interrupt Mask Register */
-#define IPIC_SECNR	0x3C	/* System External Interrupt Control Register */
-#define IPIC_SERSR	0x40	/* System Error Status Register */
-#define IPIC_SERMR	0x44	/* System Error Mask Register */
-#define IPIC_SERCR	0x48	/* System Error Control Register */
-#define IPIC_SIFCR_H	0x50	/* System Internal Interrupt Force Register (HIGH) */
-#define IPIC_SIFCR_L	0x54	/* System Internal Interrupt Force Register (LOW) */
-#define IPIC_SEFCR	0x58	/* System External Interrupt Force Register */
-#define IPIC_SERFR	0x5C	/* System Error Force Register */
-#define IPIC_SCVCR	0x60	/* System Critical Interrupt Vector Register */
-#define IPIC_SMVCR	0x64	/* System Management Interrupt Vector Register */
-
-enum ipic_prio_grp {
-	IPIC_INT_GRP_A = IPIC_SIPRR_A,
-	IPIC_INT_GRP_D = IPIC_SIPRR_D,
-	IPIC_MIX_GRP_A = IPIC_SMPRR_A,
-	IPIC_MIX_GRP_B = IPIC_SMPRR_B,
-};
-
-enum ipic_mcp_irq {
-	IPIC_MCP_IRQ0 = 0,
-	IPIC_MCP_WDT  = 1,
-	IPIC_MCP_SBA  = 2,
-	IPIC_MCP_PCI1 = 5,
-	IPIC_MCP_PCI2 = 6,
-	IPIC_MCP_MU   = 7,
-};
-
-extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
-		unsigned int irq_offset,
-		unsigned char *senses, unsigned int senses_count);
-extern int ipic_set_priority(unsigned int irq, unsigned int priority);
-extern void ipic_set_highest_priority(unsigned int irq);
-extern void ipic_set_default_priority(void);
-extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
-extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
-extern u32 ipic_get_mcp_status(void);
-extern void ipic_clear_mcp_status(u32 mask);
-extern int ipic_get_irq(struct pt_regs *regs);
-
-#endif /* __ASM_IPIC_H__ */
-#endif /* __KERNEL__ */
