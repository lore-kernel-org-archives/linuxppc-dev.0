Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDB2867C9A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:20:43 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/6] POWERPC: move the generic cpm2 stuff to the powerpc
Date: Sat, 12 Aug 2006 04:10:14 +0400
Message-Id: <20060812001013.6186.41337.stgit@localhost.localdomain>
In-Reply-To: <20060812000655.6186.42738.stgit@localhost.localdomain>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This moves the cpm2 common code and PIC stuff to the powerpc. Most of the files
were just copied from ppc/, with minor tuning to make it compile, and, subsequently, work.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/lib/Makefile         |    5 +
 arch/powerpc/sysdev/Makefile      |    7 +
 arch/powerpc/sysdev/cpm2_common.c |  204 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/cpm2_pic.c    |  256 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/cpm2_pic.h    |    8 +
 include/asm-ppc/cpm2.h            |    6 +
 6 files changed, 484 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 336dd19..460cea0 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -20,3 +20,8 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
 obj-$(CONFIG_DEBUG_KERNEL) += sstep.o
 endif
+
+# Temporary hack until we have migrated to asm-powerpc
+ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_CPM2)	+= rheap.o
+endif
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cebfae2..0f44f06 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -16,4 +16,9 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
- endif
+endif
+
+# Temporary hack until we have migrated to asm-powerpc
+ifeq ($(ARCH),powerpc)
+obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
+endif
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
new file mode 100644
index 0000000..1161970
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -0,0 +1,204 @@
+/*
+ * General Purpose functions for the global management of the
+ * 8260 Communication Processor Module.
+ * Copyright (c) 1999 Dan Malek (dmalek@jlc.net)
+ * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
+ *	2.3.99 Updates
+ * 
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 	Merged to arch/powerpc from arch/ppc/syslib/cpm2_common.c 
+ *
+ * In addition to the individual control of the communication
+ * channels, there are a few functions that globally affect the
+ * communication processor.
+ *
+ * Buffer descriptors must be allocated from the dual ported memory
+ * space.  The allocator for that is here.  When the communication
+ * process is reset, we reclaim the memory available.  There is
+ * currently no deallocator for this memory.
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mpc8260.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/cpm2.h>
+#include <asm/rheap.h>
+#include <asm/fs_pd.h>
+
+#include <sysdev/fsl_soc.h>
+
+static void cpm2_dpinit(void);
+cpm_cpm2_t	*cpmp;		/* Pointer to comm processor space */
+
+/* We allocate this here because it is used almost exclusively for
+ * the communication processor devices.
+ */
+cpm2_map_t *cpm2_immr;
+
+#define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
+					   of space for CPM as it is larger
+					   than on PQ2 */
+
+void
+cpm2_reset(void)
+{
+	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+
+	/* Reclaim the DP memory for our use.
+	 */
+	cpm2_dpinit();
+
+	/* Tell everyone where the comm processor resides.
+	 */
+	cpmp = &cpm2_immr->im_cpm;
+}
+
+/* Set a baud rate generator.  This needs lots of work.  There are
+ * eight BRGs, which can be connected to the CPM channels or output
+ * as clocks.  The BRGs are in two different block of internal
+ * memory mapped space.
+ * The baud rate clock is the system clock divided by something.
+ * It was set up long ago during the initial boot phase and is
+ * is given to us.
+ * Baud rate clocks are zero-based in the driver code (as that maps
+ * to port numbers).  Documentation uses 1-based numbering.
+ */
+#define BRG_INT_CLK	(get_brgfreq())
+#define BRG_UART_CLK	(BRG_INT_CLK/16)
+
+/* This function is used by UARTS, or anything else that uses a 16x
+ * oversampled clock.
+ */
+void
+cpm_setbrg(uint brg, uint rate)
+{
+	volatile uint	*bp;
+
+	/* This is good enough to get SMCs running.....
+	*/
+	if (brg < 4) {
+		bp = (uint *)&cpm2_immr->im_brgc1;
+	}
+	else {
+		bp = (uint *)&cpm2_immr->im_brgc5;
+		brg -= 4;
+	}
+	bp += brg;
+	*bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
+}
+
+/* This function is used to set high speed synchronous baud rate
+ * clocks.
+ */
+void
+cpm2_fastbrg(uint brg, uint rate, int div16)
+{
+	volatile uint	*bp;
+
+	if (brg < 4) {
+		bp = (uint *)&cpm2_immr->im_brgc1;
+	}
+	else {
+		bp = (uint *)&cpm2_immr->im_brgc5;
+		brg -= 4;
+	}
+	bp += brg;
+	*bp = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
+	if (div16)
+		*bp |= CPM_BRG_DIV16;
+}
+
+/*
+ * dpalloc / dpfree bits.
+ */
+static spinlock_t cpm_dpmem_lock;
+/* 16 blocks should be enough to satisfy all requests
+ * until the memory subsystem goes up... */
+static rh_block_t cpm_boot_dpmem_rh_block[16];
+static rh_info_t cpm_dpmem_info;
+
+static void cpm2_dpinit(void)
+{
+	spin_lock_init(&cpm_dpmem_lock);
+
+	/* initialize the info header */
+	rh_init(&cpm_dpmem_info, 1,
+			sizeof(cpm_boot_dpmem_rh_block) /
+			sizeof(cpm_boot_dpmem_rh_block[0]),
+			cpm_boot_dpmem_rh_block);
+
+	/* Attach the usable dpmem area */
+	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
+	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
+	 * varies with the processor and the microcode patches activated.
+	 * But the following should be at least safe.
+	 */
+	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
+			CPM_DATAONLY_SIZE);
+}
+
+/* This function returns an index into the DPRAM area.
+ */
+uint cpm_dpalloc(uint size, uint align)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	cpm_dpmem_info.alignment = align;
+	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return (uint)start;
+}
+EXPORT_SYMBOL(cpm_dpalloc);
+
+int cpm_dpfree(uint offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpm_dpfree);
+
+/* not sure if this is ever needed */
+uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	cpm_dpmem_info.alignment = align;
+	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return (uint)start;
+}
+EXPORT_SYMBOL(cpm_dpalloc_fixed);
+
+void cpm_dpdump(void)
+{
+	rh_dump(&cpm_dpmem_info);
+}
+EXPORT_SYMBOL(cpm_dpdump);
+
+void *cpm_dpram_addr(uint offset)
+{
+	return (void *)&cpm2_immr->im_dprambase[offset];
+}
+EXPORT_SYMBOL(cpm_dpram_addr);
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
new file mode 100644
index 0000000..ec9df31
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -0,0 +1,256 @@
+/*
+ * Platform information definitions.
+ * 
+ * Copied from arch/ppc/syslib/cpm2_pic.c with minor subsequent updates
+ * to make in work in arch/powerpc/. Original (c) belongs to Dan Malek AFAIK. 
+ * 
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+         
+/* The CPM2 internal interrupt controller.  It is usually
+ * the only interrupt controller.
+ * There are two 32-bit registers (high/low) for up to 64
+ * possible interrupts.
+ *
+ * Now, the fun starts.....Interrupt Numbers DO NOT MAP
+ * in a simple arithmetic fashion to mask or pending registers.
+ * That is, interrupt 4 does not map to bit position 4.
+ * We create two tables, indexed by vector number, to indicate
+ * which register to use and which bit in the register to use.
+ */
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/irq.h>
+
+#include <asm/immap_cpm2.h>
+#include <asm/mpc8260.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#include "cpm2_pic.h"
+
+static struct device_node *cpm2_pic_node;
+static struct irq_host *cpm2_pic_host;
+#define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
+static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+
+static	u_char	irq_to_siureg[] = {
+	1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1,
+	0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0,
+	1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1,
+	0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0
+};
+
+/* bit numbers do not match the docs, these are precomputed so the bit for
+ * a given irq is (1 << irq_to_siubit[irq]) */
+static	u_char	irq_to_siubit[] = {
+	 0, 15, 14, 13, 12, 11, 10,  9,
+	 8,  7,  6,  5,  4,  3,  2,  1,
+	 2,  1,  0, 14, 13, 12, 11, 10,
+	 9,  8,  7,  6,  5,  4,  3,  0,
+	31, 30, 29, 28, 27, 26, 25, 24,
+	23, 22, 21, 20, 19, 18, 17, 16,
+	16, 17, 18, 19, 20, 21, 22, 23,
+	24, 25, 26, 27, 28, 29, 30, 31,
+};
+
+static void cpm2_mask_irq(unsigned int irq_nr)
+{
+	int	bit, word;
+	volatile uint	*simr;
+
+	irq_nr -= CPM_IRQ_OFFSET;
+
+	bit = irq_to_siubit[irq_nr];
+	word = irq_to_siureg[irq_nr];
+
+	simr = &(cpm2_immr->im_intctl.ic_simrh);
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
+	simr[word] = ppc_cached_irq_mask[word];
+}
+
+static void cpm2_unmask_irq(unsigned int irq_nr)
+{
+	int	bit, word;
+	volatile uint	*simr;
+
+	irq_nr -= CPM_IRQ_OFFSET;
+
+	bit = irq_to_siubit[irq_nr];
+	word = irq_to_siureg[irq_nr];
+
+	simr = &(cpm2_immr->im_intctl.ic_simrh);
+	ppc_cached_irq_mask[word] |= 1 << bit;
+	simr[word] = ppc_cached_irq_mask[word];
+}
+
+static void cpm2_mask_and_ack(unsigned int irq_nr)
+{
+	int	bit, word;
+	volatile uint	*simr, *sipnr;
+
+	irq_nr -= CPM_IRQ_OFFSET;
+
+	bit = irq_to_siubit[irq_nr];
+	word = irq_to_siureg[irq_nr];
+
+	simr = &(cpm2_immr->im_intctl.ic_simrh);
+	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
+	simr[word] = ppc_cached_irq_mask[word];
+	sipnr[word] = 1 << bit;
+}
+
+static void cpm2_end_irq(unsigned int irq_nr)
+{
+	int	bit, word;
+	volatile uint	*simr;
+
+	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
+			&& irq_desc[irq_nr].action) {
+
+		irq_nr -= CPM_IRQ_OFFSET;
+		bit = irq_to_siubit[irq_nr];
+		word = irq_to_siureg[irq_nr];
+
+		simr = &(cpm2_immr->im_intctl.ic_simrh);
+		ppc_cached_irq_mask[word] |= 1 << bit;
+		simr[word] = ppc_cached_irq_mask[word];
+		/*
+		 * Work around large numbers of spurious IRQs on PowerPC 82xx
+		 * systems.
+		 */
+		mb();
+	}
+}
+
+static struct irq_chip cpm2_pic = {
+	.typename = " CPM2 SIU ",
+	.enable = cpm2_unmask_irq,
+	.disable = cpm2_mask_irq,
+	.unmask = cpm2_unmask_irq,
+	.mask_ack = cpm2_mask_and_ack,
+	.end = cpm2_end_irq,
+};
+
+int cpm2_get_irq(struct pt_regs *regs)
+{
+	int irq;
+        unsigned long bits;
+
+        /* For CPM2, read the SIVEC register and shift the bits down
+         * to get the irq number.         */
+        bits = cpm2_immr->im_intctl.ic_sivec;
+        irq = bits >> 26;
+
+	if (irq == 0)
+		return(-1);
+	return irq+CPM_IRQ_OFFSET;
+}
+
+static int cpm2_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	return cpm2_pic_node == NULL || cpm2_pic_node == node;
+}
+
+static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	pr_debug("cpm2_pic_host_map(%d, 0x%lx)\n", virq, hw);
+
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &cpm2_pic, handle_level_irq);
+	return 0;
+}
+
+static void cpm2_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* Make sure irq is masked in hardware */
+	cpm2_mask_irq(virq);
+
+	/* remove chip and handler */
+	set_irq_chip_and_handler(virq, NULL, NULL);
+}
+
+static int cpm2_pic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+	static unsigned char map_cpm2_senses[4] = {
+		IRQ_TYPE_LEVEL_LOW,
+		IRQ_TYPE_LEVEL_HIGH,
+		IRQ_TYPE_EDGE_FALLING,
+		IRQ_TYPE_EDGE_RISING,
+	};
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1 && intspec[1] < 4)
+		*out_flags = map_cpm2_senses[intspec[1]];
+	else
+		*out_flags = IRQ_TYPE_NONE;
+
+	return 0;
+}
+
+
+static struct irq_host_ops cpm2_pic_host_ops = {
+	.match = cpm2_pic_host_match,
+	.map = cpm2_pic_host_map,
+	.unmap = cpm2_host_unmap,
+	.xlate = cpm2_pic_host_xlate,
+};
+
+
+void cpm2_pic_init(struct device_node *node)
+{
+	int i;
+
+	/* Clear the CPM IRQ controller, in case it has any bits set
+	 * from the bootloader
+	 */
+
+	/* Mask out everything */
+
+	cpm2_immr->im_intctl.ic_simrh = 0x00000000;
+	cpm2_immr->im_intctl.ic_simrl = 0x00000000;
+
+	wmb();
+
+	/* Ack everything */
+	cpm2_immr->im_intctl.ic_sipnrh = 0xffffffff;
+	cpm2_immr->im_intctl.ic_sipnrl = 0xffffffff;
+	wmb();
+
+	/* Dummy read of the vector */
+	i = cpm2_immr->im_intctl.ic_sivec;
+	rmb();
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	cpm2_immr->im_intctl.ic_sicr = 0;
+	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
+	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
+
+	/* create a legacy host */
+	if (node)
+		cpm2_pic_node = of_node_get(node);
+
+	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
+	if (cpm2_pic_host == NULL) {
+		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
+		return;
+	}
+}
diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
new file mode 100644
index 0000000..436cca7
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -0,0 +1,8 @@
+#ifndef _PPC_KERNEL_CPM2_H
+#define _PPC_KERNEL_CPM2_H
+
+extern int cpm2_get_irq(struct pt_regs *regs);
+
+extern void cpm2_pic_init(struct device_node*);
+
+#endif /* _PPC_KERNEL_CPM2_H */
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index f6a7ff0..876974e 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -42,6 +42,8 @@ #define CPM_CR_IDMA3_SBLOCK	(0x16)
 #define CPM_CR_IDMA4_SBLOCK	(0x17)
 #define CPM_CR_MCC1_SBLOCK	(0x1c)
 
+#define CPM_CR_FCC_SBLOCK(x)	(x + 0x10)
+
 #define CPM_CR_SCC1_PAGE	(0x00)
 #define CPM_CR_SCC2_PAGE	(0x01)
 #define CPM_CR_SCC3_PAGE	(0x02)
@@ -62,6 +64,8 @@ #define CPM_CR_IDMA4_PAGE	(0x0a)
 #define CPM_CR_MCC1_PAGE	(0x07)
 #define CPM_CR_MCC2_PAGE	(0x08)
 
+#define CPM_CR_FCC_PAGE(x)	(x + 0x04)
+
 /* Some opcodes (there are more...later)
 */
 #define CPM_CR_INIT_TRX		((ushort)0x0000)
@@ -1186,7 +1190,7 @@ #define PC3_DIRC1	(PC3_TXDAT)
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
