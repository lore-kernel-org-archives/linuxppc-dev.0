Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B245967C02
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4HAOBox004092
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:24:11 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4HAGaNr016711
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:16:37 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D61C@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 2/10] Powerpc: Add Tundra Semiconductor tsi108
	macro define
Date: Wed, 17 May 2006 18:13:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Tundra Semiconductor tsi108 host bridge common and irq macro define

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

---

 include/asm-powerpc/tsi108.h     |  106 +++++++++++++++++++++++++++++++
 include/asm-powerpc/tsi108_irq.h |  131 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-powerpc/tsi108.h
 create mode 100644 include/asm-powerpc/tsi108_irq.h

d7b3cf7ba073991ce7c2fac268d21f8bd43d6962
diff --git a/include/asm-powerpc/tsi108.h b/include/asm-powerpc/tsi108.h
new file mode 100644
index 0000000..ed9ec36
--- /dev/null
+++ b/include/asm-powerpc/tsi108.h
@@ -0,0 +1,106 @@
+/*
+ * include/asm-ppc/tsi108.h
+ *
+ * common routine and memory layout for Tundra TSI108(Grendel) host bridge
+ * memory controller.
+ *
+ * Author: Jacob Pan (jacob.pan@freescale.com)
+ *	   Alex Bounine (alexandreb@tundra.com)
+ * 2004 (c) Freescale Semiconductor Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __PPC_KERNEL_TSI108_H
+#define __PPC_KERNEL_TSI108_H
+
+#include <asm/pci-bridge.h>
+
+/* Size of entire register space */
+#define TSI108_REG_SIZE		(0x10000)
+
+/* Sizes of register spaces for individual blocks */
+#define TSI108_HLP_SIZE		0x1000
+#define TSI108_PCI_SIZE		0x1000
+#define TSI108_CLK_SIZE		0x1000
+#define TSI108_PB_SIZE		0x1000
+#define TSI108_SD_SIZE		0x1000
+#define TSI108_DMA_SIZE		0x1000
+#define TSI108_ETH_SIZE		0x1000
+#define TSI108_I2C_SIZE		0x400
+#define TSI108_MPIC_SIZE	0x400
+#define TSI108_UART0_SIZE	0x200
+#define TSI108_GPIO_SIZE	0x200
+#define TSI108_UART1_SIZE	0x200
+
+/* Offsets within Tsi108(A) CSR space for individual blocks */
+#define TSI108_HLP_OFFSET	0x0000
+#define TSI108_PCI_OFFSET	0x1000
+#define TSI108_CLK_OFFSET	0x2000
+#define TSI108_PB_OFFSET	0x3000
+#define TSI108_SD_OFFSET	0x4000
+#define TSI108_DMA_OFFSET	0x5000
+#define TSI108_ETH_OFFSET	0x6000
+#define TSI108_I2C_OFFSET	0x7000
+#define TSI108_MPIC_OFFSET	0x7400
+#define TSI108_UART0_OFFSET	0x7800
+#define TSI108_GPIO_OFFSET	0x7A00
+#define TSI108_UART1_OFFSET	0x7C00
+
+/* Tsi108 registers used by common code components */
+#define TSI108_PCI_CSR		(0x004)
+#define TSI108_PCI_IRP_CFG_CTL	(0x180)
+#define TSI108_PCI_IRP_STAT	(0x184)
+#define TSI108_PCI_IRP_ENABLE	(0x188)
+#define TSI108_PCI_IRP_INTAD	(0x18C)
+
+#define TSI108_PCI_IRP_STAT_P_INT	(0x00400000)
+
+#define TSI108_CG_PWRUP_STATUS	(0x234)
+
+#define TSI108_PB_ISR		(0x00C)
+#define TSI108_PB_ERRCS		(0x404)
+#define TSI108_PB_AERR		(0x408)
+
+#define TSI108_PB_ERRCS_ES		(1 << 1)
+#define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
+
+#define TBL_END 0
+
+/* Global variables */
+
+extern u32 tsi108_pci_cfg_base;
+/* Exported functions */
+
+extern int tsi108_bridge_init(struct pci_controller *hose, uint phys_csr_base);
+extern unsigned long tsi108_get_mem_size(void);
+extern unsigned long tsi108_get_cpu_clk(void);
+extern unsigned long tsi108_get_sdc_clk(void);
+extern int tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfn,
+				      int offset, int len, u32 val);
+extern int tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 * val);
+extern void tsi108_clear_pci_error(u32 pci_cfg_base);
+
+extern phys_addr_t get_csrbase(void);
+
+typedef struct {
+	u32 regs;		/* hw registers base address */
+	u32 phyregs;		/* phy registers base address */
+	u16 phy;		/* phy address */
+	u16 irq_num;		/* irq number */
+} hw_info;
+
+extern u32 get_vir_csrbase(void);
+
+extern inline u32 tsi108_read_reg(u32 reg_offset)
+{
+	return in_be32((volatile u32 *)(get_vir_csrbase() + reg_offset));
+}
+
+extern inline void tsi108_write_reg(u32 reg_offset, u32 val)
+{
+	out_be32((volatile u32 *)(get_vir_csrbase() + reg_offset), val);
+}
+
+#endif				/* __PPC_KERNEL_TSI108_H */
diff --git a/include/asm-powerpc/tsi108_irq.h b/include/asm-powerpc/tsi108_irq.h
new file mode 100644
index 0000000..2f7e8d8
--- /dev/null
+++ b/include/asm-powerpc/tsi108_irq.h
@@ -0,0 +1,131 @@
+/*
+ * (C) Copyright 2005 Tundra Semiconductor Corp.
+ * Alex Bounine, <alexandreb@tundra.com).
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+/*
+ * asm-ppc/tsi108_irq.h - definitions for interrupt controller
+ * initialization and external interrupt demultiplexing on TSI108EMU/SVB boards.
+ */
+
+#ifndef _ASM_PPC_TSI108_IRQ_H
+#define _ASM_PPC_TSI108_IRQ_H
+
+/*
+ * Tsi108 interrupts
+ */
+#ifndef TSI108_IRQ_BASE
+#define TSI108_IRQ_BASE		0
+#endif
+
+#define TSI108_IRQ(x)		(TSI108_IRQ_BASE + (x))
+
+#define TSI108_MAX_VECTORS	(36 + 4)	/* 36 sources + PCI INT demux */
+#define MAX_TASK_PRIO	0xF
+
+#define TSI108_IRQ_SPURIOUS	(TSI108_MAX_VECTORS)
+
+#define DEFAULT_PRIO_LVL	10	/* initial priority level */
+
+/* Interrupt vectors assignment to external and internal 
+ * sources of requests. */
+
+/* EXTERNAL INTERRUPT SOURCES */
+
+#define IRQ_TSI108_EXT_INT0	TSI108_IRQ(0)	/* External Source at INT[0] */
+#define IRQ_TSI108_EXT_INT1	TSI108_IRQ(1)	/* External Source at INT[1] */
+#define IRQ_TSI108_EXT_INT2	TSI108_IRQ(2)	/* External Source at INT[2] */
+#define IRQ_TSI108_EXT_INT3	TSI108_IRQ(3)	/* External Source at INT[3] */
+
+/* INTERNAL INTERRUPT SOURCES */
+
+#define IRQ_TSI108_RESERVED0	TSI108_IRQ(4)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED1	TSI108_IRQ(5)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED2	TSI108_IRQ(6)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED3	TSI108_IRQ(7)	/* Reserved IRQ */
+#define IRQ_TSI108_DMA0		TSI108_IRQ(8)	/* DMA0 */
+#define IRQ_TSI108_DMA1		TSI108_IRQ(9)	/* DMA1 */
+#define IRQ_TSI108_DMA2		TSI108_IRQ(10)	/* DMA2 */
+#define IRQ_TSI108_DMA3		TSI108_IRQ(11)	/* DMA3 */
+#define IRQ_TSI108_UART0	TSI108_IRQ(12)	/* UART0 */
+#define IRQ_TSI108_UART1	TSI108_IRQ(13)	/* UART1 */
+#define IRQ_TSI108_I2C		TSI108_IRQ(14)	/* I2C */
+#define IRQ_TSI108_GPIO		TSI108_IRQ(15)	/* GPIO */
+#define IRQ_TSI108_GIGE0	TSI108_IRQ(16)	/* GIGE0 */
+#define IRQ_TSI108_GIGE1	TSI108_IRQ(17)	/* GIGE1 */
+#define IRQ_TSI108_RESERVED4	TSI108_IRQ(18)	/* Reserved IRQ */
+#define IRQ_TSI108_HLP		TSI108_IRQ(19)	/* HLP */
+#define IRQ_TSI108_SDRAM	TSI108_IRQ(20)	/* SDC */
+#define IRQ_TSI108_PROC_IF	TSI108_IRQ(21)	/* Processor IF */
+#define IRQ_TSI108_RESERVED5	TSI108_IRQ(22)	/* Reserved IRQ */
+#define IRQ_TSI108_PCI		TSI108_IRQ(23)	/* PCI/X block */
+
+#define IRQ_TSI108_MBOX0	TSI108_IRQ(24)	/* Mailbox 0 register */
+#define IRQ_TSI108_MBOX1	TSI108_IRQ(25)	/* Mailbox 1 register */
+#define IRQ_TSI108_MBOX2	TSI108_IRQ(26)	/* Mailbox 2 register */
+#define IRQ_TSI108_MBOX3	TSI108_IRQ(27)	/* Mailbox 3 register */
+
+#define IRQ_TSI108_DBELL0	TSI108_IRQ(28)	/* Doorbell 0 */
+#define IRQ_TSI108_DBELL1	TSI108_IRQ(29)	/* Doorbell 1 */
+#define IRQ_TSI108_DBELL2	TSI108_IRQ(30)	/* Doorbell 2 */
+#define IRQ_TSI108_DBELL3	TSI108_IRQ(31)	/* Doorbell 3 */
+
+#define IRQ_TSI108_TIMER0	TSI108_IRQ(32)	/* Global Timer 0 */
+#define IRQ_TSI108_TIMER1	TSI108_IRQ(33)	/* Global Timer 1 */
+#define IRQ_TSI108_TIMER2	TSI108_IRQ(34)	/* Global Timer 2 */
+#define IRQ_TSI108_TIMER3	TSI108_IRQ(35)	/* Global Timer 3 */
+
+/*
+ * PCI bus INTA# - INTD# lines demultiplexor
+ */
+#define IRQ_PCI_INTAD_BASE	TSI108_IRQ(36)
+#define IRQ_PCI_INTA		(IRQ_PCI_INTAD_BASE + 0)
+#define IRQ_PCI_INTB		(IRQ_PCI_INTAD_BASE + 1)
+#define IRQ_PCI_INTC		(IRQ_PCI_INTAD_BASE + 2)
+#define IRQ_PCI_INTD		(IRQ_PCI_INTAD_BASE + 3)
+#define NUM_PCI_IRQS		(4)
+
+/* number of entries in vector dispatch table */
+#define IRQ_TSI108_TAB_SIZE	(TSI108_MAX_VECTORS + 1)
+
+/* Mapping of MPIC outputs to processors' interrupt pins */
+
+#define IDIR_INT_OUT0		0x1
+#define IDIR_INT_OUT1		0x2
+#define IDIR_INT_OUT2		0x4
+#define IDIR_INT_OUT3		0x8
+
+/*---------------------------------------------------------------
+ * IRQ line configuration parameters */
+
+/* Interrupt delivery modes */
+typedef enum {
+	TSI108_IRQ_DIRECTED,
+	TSI108_IRQ_DISTRIBUTED,
+} TSI108_IRQ_MODE;
+
+/*--------------------------------------------------------------- */
+/* Error codes */
+
+#define MPIC_OK		0
+#define MPIC_ERROR	1
+
+#endif				/*  _ASM_PPC_TSI108_IRQ_H */
-- 
1.3.0
