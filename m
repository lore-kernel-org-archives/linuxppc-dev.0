Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-40-144.msk.skylink.ru
	[83.217.40.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E9D9681EA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:00:12 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 4/5] [POWERPC] 8xx: powerpc port of core CPM, CPM PIC, etc.
Date: Tue, 14 Nov 2006 04:28:25 +0300
Message-Id: <20061114012825.17455.1242.stgit@localhost.localdomain>
In-Reply-To: <20061114012504.17455.13833.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
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


This covers common CPM access functions, CPM interrupt controller code,
micropatch and a few compatibility things to kee the same driver base
working with arch/ppc.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/sysdev/Makefile     |    3 
 arch/powerpc/sysdev/commproc.c   |  426 ++++++++++++++++++++++
 arch/powerpc/sysdev/micropatch.c |  743 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/mpc8xx_pic.c |  209 +++++++++++
 arch/powerpc/sysdev/mpc8xx_pic.h |   12 +
 include/asm-powerpc/fs_pd.h      |   44 ++
 include/asm-powerpc/mpc8xx.h     |   38 ++
 7 files changed, 1465 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 8ba11ab..ab6b06e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -22,3 +22,6 @@ # Temporary hack until we have migrated 
 ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 endif
+
+obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
+obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
new file mode 100644
index 0000000..6fc0c9e
--- /dev/null
+++ b/arch/powerpc/sysdev/commproc.c
@@ -0,0 +1,426 @@
+/*
+ * General Purpose functions for the global management of the
+ * Communication Processor Module.
+ * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
+ *
+ * In addition to the individual control of the communication
+ * channels, there are a few functions that globally affect the
+ * communication processor.
+ *
+ * Buffer descriptors must be allocated from the dual ported memory
+ * space.  The allocator for that is here.  When the communication
+ * process is reset, we reclaim the memory available.  There is
+ * currently no deallocator for this memory.
+ * The amount of space available is platform dependent.  On the
+ * MBX, the EPPC software loads additional microcode into the
+ * communication processor, and uses some of the DP ram for this
+ * purpose.  Current, the first 512 bytes and the last 256 bytes of
+ * memory are used.  Right now I am conservative and only use the
+ * memory that can never be used for microcode.  If there are
+ * applications that require more DP ram, we can expand the boundaries
+ * but then we have to be careful of any downloaded microcode.
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <asm/mpc8xx.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/io.h>
+#include <asm/tlbflush.h>
+#include <asm/rheap.h>
+#include <asm/prom.h>
+
+#include <asm/fs_pd.h>
+
+#define CPM_MAP_SIZE    (0x4000)
+
+static void m8xx_cpm_dpinit(void);
+static	uint	host_buffer;	/* One page of host buffer */
+static	uint	host_end;	/* end + 1 */
+cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
+cpic8xx_t	*cpic_reg;
+
+static struct device_node *cpm_pic_node;
+static struct irq_host *cpm_pic_host;
+
+static void cpm_mask_irq(unsigned int irq)
+{
+        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+}
+
+static void cpm_unmask_irq(unsigned int irq)
+{
+        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+}
+
+static void cpm_mask_and_ack(unsigned int irq)
+{
+	/* We do not need to do anything here. */
+}
+
+static void cpm_end_irq(unsigned int irq)
+{
+        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
+}
+
+static struct irq_chip cpm_pic = {
+	.typename = " CPM PIC ",
+	.enable = cpm_unmask_irq,
+	.disable = cpm_mask_irq,
+	.unmask = cpm_unmask_irq,
+	.mask_ack = cpm_mask_and_ack,
+	.end = cpm_end_irq,
+};
+
+int cpm_get_irq()
+{
+	int cpm_vec;
+
+	/* Get the vector by setting the ACK bit and then reading
+	 * the register.
+	 */
+	out_be16(&cpic_reg->cpic_civr, 1);
+	cpm_vec = in_be16(&cpic_reg->cpic_civr);
+	cpm_vec >>= 11;
+
+	return irq_linear_revmap(cpm_pic_host, cpm_vec);
+}
+
+static int cpm_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	return cpm_pic_node == NULL || cpm_pic_node == node;
+}
+
+static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
+
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &cpm_pic, handle_level_irq);
+	return 0;
+}
+
+static void cpm_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* Make sure irq is masked in hardware */
+	cpm_mask_irq(virq);
+
+	/* remove chip and handler */
+	set_irq_chip_and_handler(virq, NULL, NULL);
+}
+
+static int cpm_pic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+	static unsigned char map_cpm_senses[4] = {
+		IRQ_TYPE_LEVEL_LOW,
+		IRQ_TYPE_LEVEL_HIGH,
+		IRQ_TYPE_EDGE_FALLING,
+		IRQ_TYPE_EDGE_RISING,
+	};
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1 && intspec[1] < 4)
+		*out_flags = map_cpm_senses[intspec[1]];
+	else
+		*out_flags = IRQ_TYPE_NONE;
+
+	return 0;
+}
+
+/* The CPM can generate the error interrupt when there is a race condition
+ * between generating and masking interrupts.  All we have to do is ACK it
+ * and return.  This is a no-op function so we don't need any special
+ * tests in the interrupt handler.
+ */
+static	irqreturn_t cpm_error_interrupt(int irq, void *dev)
+{
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cpm_error_irqaction = {
+	.handler = cpm_error_interrupt,
+	.mask = CPU_MASK_NONE,
+	.name = "error",
+};
+
+static struct irq_host_ops cpm_pic_host_ops = {
+	.match = cpm_pic_host_match,
+	.map = cpm_pic_host_map,
+	.unmap = cpm_host_unmap,
+	.xlate = cpm_pic_host_xlate,
+};
+
+unsigned int cpm_pic_init(void)
+{
+	struct device_node *np = NULL;
+	struct resource res;
+	unsigned int sirq = NO_IRQ, hwirq, eirq;
+	int ret;
+
+	pr_debug("cpm_pic_init\n");
+
+	np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
+	if (np == NULL) {
+		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
+                return sirq;
+	}
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return sirq;
+
+	cpic_reg = (void *)ioremap(res.start, res.end - res.start + 1);
+	if (cpic_reg == NULL)
+		return sirq;
+
+	sirq = irq_of_parse_and_map(np, 0);
+
+	/* Initialize the CPM interrupt controller. */
+	hwirq = (unsigned int)irq_map[sirq].hwirq;
+	out_be32(&cpic_reg->cpic_cicr,
+	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
+		((hwirq/2) << 13) | CICR_HP_MASK);
+
+	out_be32(&cpic_reg->cpic_cimr, 0);
+
+	/* create a legacy host */
+	if (np)
+		cpm_pic_node = of_node_get(np);
+
+	cpm_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm_pic_host_ops, 64);
+	if (cpm_pic_host == NULL) {
+		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
+		sirq = NO_IRQ;
+                return sirq;
+	}
+
+	/* Install our own error handler. */
+	np = of_find_node_by_type(NULL, "cpm");
+	eirq= irq_of_parse_and_map(np, 0);
+	if (setup_irq(eirq, &cpm_error_irqaction))
+		printk(KERN_ERR "Could not allocate CPM error IRQ!");
+
+	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
+
+	return sirq;
+}
+
+void cpm_reset(void)
+{
+	cpm8xx_t	*commproc;
+	sysconf8xx_t    *siu_conf;
+
+	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+
+#ifdef CONFIG_UCODE_PATCH
+	/* Perform a reset.
+	*/
+	out_be16(&commproc->cp_cpcr,  CPM_CR_RST | CPM_CR_FLG);
+
+	/* Wait for it.
+	*/
+	while (in_be16(&commproc->cp_cpcr) & CPM_CR_FLG);
+
+	cpm_load_patch(commproc);
+#endif
+
+	/* Set SDMA Bus Request priority 5.
+	 * On 860T, this also enables FEC priority 6.  I am not sure
+	 * this is what we realy want for some applications, but the
+	 * manual recommends it.
+	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
+	 */
+	siu_conf = (sysconf8xx_t*)immr_map(im_siu_conf);
+	out_be32(&siu_conf->sc_sdcr, 1);
+	immr_unmap(siu_conf);
+
+	/* Reclaim the DP memory for our use. */
+	m8xx_cpm_dpinit();
+
+	/* Tell everyone where the comm processor resides.
+	*/
+	cpmp = commproc;
+}
+
+/* We used to do this earlier, but have to postpone as long as possible
+ * to ensure the kernel VM is now running.
+ */
+static void
+alloc_host_memory(void)
+{
+	dma_addr_t	physaddr;
+
+	/* Set the host page for allocation.
+	*/
+	host_buffer = (uint)dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
+			GFP_KERNEL);
+	host_end = host_buffer + PAGE_SIZE;
+}
+
+/* We also own one page of host buffer space for the allocation of
+ * UART "fifos" and the like.
+ */
+uint
+m8xx_cpm_hostalloc(uint size)
+{
+	uint	retloc;
+
+	if (host_buffer == 0)
+		alloc_host_memory();
+
+	if ((host_buffer + size) >= host_end)
+		return(0);
+
+	retloc = host_buffer;
+	host_buffer += size;
+
+	return(retloc);
+}
+
+/* Set a baud rate generator.  This needs lots of work.  There are
+ * four BRGs, any of which can be wired to any channel.
+ * The internal baud rate clock is the system clock divided by 16.
+ * This assumes the baudrate is 16x oversampled by the uart.
+ */
+#define BRG_INT_CLK		(get_brgfreq())
+#define BRG_UART_CLK		(BRG_INT_CLK/16)
+#define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)
+
+void
+cpm_setbrg(uint brg, uint rate)
+{
+	volatile uint	*bp;
+
+	/* This is good enough to get SMCs running.....
+	*/
+	bp = (uint *)&cpmp->cp_brgc1;
+	bp += brg;
+	/* The BRG has a 12-bit counter.  For really slow baud rates (or
+	 * really fast processors), we may have to further divide by 16.
+	 */
+	if (((BRG_UART_CLK / rate) - 1) < 4096)
+		*bp = (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN;
+	else
+		*bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
+						CPM_BRG_EN | CPM_BRG_DIV16;
+}
+
+/*
+ * dpalloc / dpfree bits.
+ */
+static spinlock_t cpm_dpmem_lock;
+/*
+ * 16 blocks should be enough to satisfy all requests
+ * until the memory subsystem goes up...
+ */
+static rh_block_t cpm_boot_dpmem_rh_block[16];
+static rh_info_t cpm_dpmem_info;
+
+#define CPM_DPMEM_ALIGNMENT	8
+static u8* dpram_vbase;
+static uint dpram_pbase;
+
+void m8xx_cpm_dpinit(void)
+{
+	spin_lock_init(&cpm_dpmem_lock);
+
+	dpram_vbase = immr_map_size(im_cpm.cp_dpmem, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
+	dpram_pbase = (uint)&((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
+
+	/* Initialize the info header */
+	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
+			sizeof(cpm_boot_dpmem_rh_block) /
+			sizeof(cpm_boot_dpmem_rh_block[0]),
+			cpm_boot_dpmem_rh_block);
+
+	/*
+	 * Attach the usable dpmem area.
+	 * XXX: This is actually crap.  CPM_DATAONLY_BASE and
+	 * CPM_DATAONLY_SIZE are a subset of the available dparm.  It varies
+	 * with the processor and the microcode patches applied / activated.
+	 * But the following should be at least safe.
+	 */
+	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+}
+
+/*
+ * Allocate the requested size worth of DP memory.
+ * This function returns an offset into the DPRAM area.
+ * Use cpm_dpram_addr() to get the virtual address of the area.
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
+	return (void *)(dpram_vbase + offset);
+}
+EXPORT_SYMBOL(cpm_dpram_addr);
+
+uint cpm_dpram_phys(u8* addr)
+{
+	return (dpram_pbase + (uint)(addr - dpram_vbase));
+}
+EXPORT_SYMBOL(cpm_dpram_addr);
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
new file mode 100644
index 0000000..712b10a
--- /dev/null
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -0,0 +1,743 @@
+
+/* Microcode patches for the CPM as supplied by Motorola.
+ * This is the one for IIC/SPI.  There is a newer one that
+ * also relocates SMC2, but this would require additional changes
+ * to uart.c, so I am holding off on that for a moment.
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/mpc8xx.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+
+/*
+ * I2C/SPI relocation patch arrays.
+ */
+
+#ifdef CONFIG_I2C_SPI_UCODE_PATCH
+
+uint patch_2000[] = {
+	0x7FFFEFD9,
+	0x3FFD0000,
+	0x7FFB49F7,
+	0x7FF90000,
+	0x5FEFADF7,
+	0x5F89ADF7,
+	0x5FEFAFF7,
+	0x5F89AFF7,
+	0x3A9CFBC8,
+	0xE7C0EDF0,
+	0x77C1E1BB,
+	0xF4DC7F1D,
+	0xABAD932F,
+	0x4E08FDCF,
+	0x6E0FAFF8,
+	0x7CCF76CF,
+	0xFD1FF9CF,
+	0xABF88DC6,
+	0xAB5679F7,
+	0xB0937383,
+	0xDFCE79F7,
+	0xB091E6BB,
+	0xE5BBE74F,
+	0xB3FA6F0F,
+	0x6FFB76CE,
+	0xEE0DF9CF,
+	0x2BFBEFEF,
+	0xCFEEF9CF,
+	0x76CEAD24,
+	0x90B2DF9A,
+	0x7FDDD0BF,
+	0x4BF847FD,
+	0x7CCF76CE,
+	0xCFEF7E1F,
+	0x7F1D7DFD,
+	0xF0B6EF71,
+	0x7FC177C1,
+	0xFBC86079,
+	0xE722FBC8,
+	0x5FFFDFFF,
+	0x5FB2FFFB,
+	0xFBC8F3C8,
+	0x94A67F01,
+	0x7F1D5F39,
+	0xAFE85F5E,
+	0xFFDFDF96,
+	0xCB9FAF7D,
+	0x5FC1AFED,
+	0x8C1C5FC1,
+	0xAFDD5FC3,
+	0xDF9A7EFD,
+	0xB0B25FB2,
+	0xFFFEABAD,
+	0x5FB2FFFE,
+	0x5FCE600B,
+	0xE6BB600B,
+	0x5FCEDFC6,
+	0x27FBEFDF,
+	0x5FC8CFDE,
+	0x3A9CE7C0,
+	0xEDF0F3C8,
+	0x7F0154CD,
+	0x7F1D2D3D,
+	0x363A7570,
+	0x7E0AF1CE,
+	0x37EF2E68,
+	0x7FEE10EC,
+	0xADF8EFDE,
+	0xCFEAE52F,
+	0x7D0FE12B,
+	0xF1CE5F65,
+	0x7E0A4DF8,
+	0xCFEA5F72,
+	0x7D0BEFEE,
+	0xCFEA5F74,
+	0xE522EFDE,
+	0x5F74CFDA,
+	0x0B627385,
+	0xDF627E0A,
+	0x30D8145B,
+	0xBFFFF3C8,
+	0x5FFFDFFF,
+	0xA7F85F5E,
+	0xBFFE7F7D,
+	0x10D31450,
+	0x5F36BFFF,
+	0xAF785F5E,
+	0xBFFDA7F8,
+	0x5F36BFFE,
+	0x77FD30C0,
+	0x4E08FDCF,
+	0xE5FF6E0F,
+	0xAFF87E1F,
+	0x7E0FFD1F,
+	0xF1CF5F1B,
+	0xABF80D5E,
+	0x5F5EFFEF,
+	0x79F730A2,
+	0xAFDD5F34,
+	0x47F85F34,
+	0xAFED7FDD,
+	0x50B24978,
+	0x47FD7F1D,
+	0x7DFD70AD,
+	0xEF717EC1,
+	0x6BA47F01,
+	0x2D267EFD,
+	0x30DE5F5E,
+	0xFFFD5F5E,
+	0xFFEF5F5E,
+	0xFFDF0CA0,
+	0xAFED0A9E,
+	0xAFDD0C3A,
+	0x5F3AAFBD,
+	0x7FBDB082,
+	0x5F8247F8
+};
+
+uint patch_2f00[] = {
+	0x3E303430,
+	0x34343737,
+	0xABF7BF9B,
+	0x994B4FBD,
+	0xBD599493,
+	0x349FFF37,
+	0xFB9B177D,
+	0xD9936956,
+	0xBBFDD697,
+	0xBDD2FD11,
+	0x31DB9BB3,
+	0x63139637,
+	0x93733693,
+	0x193137F7,
+	0x331737AF,
+	0x7BB9B999,
+	0xBB197957,
+	0x7FDFD3D5,
+	0x73B773F7,
+	0x37933B99,
+	0x1D115316,
+	0x99315315,
+	0x31694BF4,
+	0xFBDBD359,
+	0x31497353,
+	0x76956D69,
+	0x7B9D9693,
+	0x13131979,
+	0x79376935
+};
+#endif
+
+/*
+ * I2C/SPI/SMC1 relocation patch arrays.
+ */
+
+#ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
+
+uint patch_2000[] = {
+	0x3fff0000,
+	0x3ffd0000,
+	0x3ffb0000,
+	0x3ff90000,
+	0x5f13eff8,
+	0x5eb5eff8,
+	0x5f88adf7,
+	0x5fefadf7,
+	0x3a9cfbc8,
+	0x77cae1bb,
+	0xf4de7fad,
+	0xabae9330,
+	0x4e08fdcf,
+	0x6e0faff8,
+	0x7ccf76cf,
+	0xfdaff9cf,
+	0xabf88dc8,
+	0xab5879f7,
+	0xb0925d8d,
+	0xdfd079f7,
+	0xb090e6bb,
+	0xe5bbe74f,
+	0x9e046f0f,
+	0x6ffb76ce,
+	0xee0cf9cf,
+	0x2bfbefef,
+	0xcfeef9cf,
+	0x76cead23,
+	0x90b3df99,
+	0x7fddd0c1,
+	0x4bf847fd,
+	0x7ccf76ce,
+	0xcfef77ca,
+	0x7eaf7fad,
+	0x7dfdf0b7,
+	0xef7a7fca,
+	0x77cafbc8,
+	0x6079e722,
+	0xfbc85fff,
+	0xdfff5fb3,
+	0xfffbfbc8,
+	0xf3c894a5,
+	0xe7c9edf9,
+	0x7f9a7fad,
+	0x5f36afe8,
+	0x5f5bffdf,
+	0xdf95cb9e,
+	0xaf7d5fc3,
+	0xafed8c1b,
+	0x5fc3afdd,
+	0x5fc5df99,
+	0x7efdb0b3,
+	0x5fb3fffe,
+	0xabae5fb3,
+	0xfffe5fd0,
+	0x600be6bb,
+	0x600b5fd0,
+	0xdfc827fb,
+	0xefdf5fca,
+	0xcfde3a9c,
+	0xe7c9edf9,
+	0xf3c87f9e,
+	0x54ca7fed,
+	0x2d3a3637,
+	0x756f7e9a,
+	0xf1ce37ef,
+	0x2e677fee,
+	0x10ebadf8,
+	0xefdecfea,
+	0xe52f7d9f,
+	0xe12bf1ce,
+	0x5f647e9a,
+	0x4df8cfea,
+	0x5f717d9b,
+	0xefeecfea,
+	0x5f73e522,
+	0xefde5f73,
+	0xcfda0b61,
+	0x5d8fdf61,
+	0xe7c9edf9,
+	0x7e9a30d5,
+	0x1458bfff,
+	0xf3c85fff,
+	0xdfffa7f8,
+	0x5f5bbffe,
+	0x7f7d10d0,
+	0x144d5f33,
+	0xbfffaf78,
+	0x5f5bbffd,
+	0xa7f85f33,
+	0xbffe77fd,
+	0x30bd4e08,
+	0xfdcfe5ff,
+	0x6e0faff8,
+	0x7eef7e9f,
+	0xfdeff1cf,
+	0x5f17abf8,
+	0x0d5b5f5b,
+	0xffef79f7,
+	0x309eafdd,
+	0x5f3147f8,
+	0x5f31afed,
+	0x7fdd50af,
+	0x497847fd,
+	0x7f9e7fed,
+	0x7dfd70a9,
+	0xef7e7ece,
+	0x6ba07f9e,
+	0x2d227efd,
+	0x30db5f5b,
+	0xfffd5f5b,
+	0xffef5f5b,
+	0xffdf0c9c,
+	0xafed0a9a,
+	0xafdd0c37,
+	0x5f37afbd,
+	0x7fbdb081,
+	0x5f8147f8,
+	0x3a11e710,
+	0xedf0ccdd,
+	0xf3186d0a,
+	0x7f0e5f06,
+	0x7fedbb38,
+	0x3afe7468,
+	0x7fedf4fc,
+	0x8ffbb951,
+	0xb85f77fd,
+	0xb0df5ddd,
+	0xdefe7fed,
+	0x90e1e74d,
+	0x6f0dcbf7,
+	0xe7decfed,
+	0xcb74cfed,
+	0xcfeddf6d,
+	0x91714f74,
+	0x5dd2deef,
+	0x9e04e7df,
+	0xefbb6ffb,
+	0xe7ef7f0e,
+	0x9e097fed,
+	0xebdbeffa,
+	0xeb54affb,
+	0x7fea90d7,
+	0x7e0cf0c3,
+	0xbffff318,
+	0x5fffdfff,
+	0xac59efea,
+	0x7fce1ee5,
+	0xe2ff5ee1,
+	0xaffbe2ff,
+	0x5ee3affb,
+	0xf9cc7d0f,
+	0xaef8770f,
+	0x7d0fb0c6,
+	0xeffbbfff,
+	0xcfef5ede,
+	0x7d0fbfff,
+	0x5ede4cf8,
+	0x7fddd0bf,
+	0x49f847fd,
+	0x7efdf0bb,
+	0x7fedfffd,
+	0x7dfdf0b7,
+	0xef7e7e1e,
+	0x5ede7f0e,
+	0x3a11e710,
+	0xedf0ccab,
+	0xfb18ad2e,
+	0x1ea9bbb8,
+	0x74283b7e,
+	0x73c2e4bb,
+	0x2ada4fb8,
+	0xdc21e4bb,
+	0xb2a1ffbf,
+	0x5e2c43f8,
+	0xfc87e1bb,
+	0xe74ffd91,
+	0x6f0f4fe8,
+	0xc7ba32e2,
+	0xf396efeb,
+	0x600b4f78,
+	0xe5bb760b,
+	0x53acaef8,
+	0x4ef88b0e,
+	0xcfef9e09,
+	0xabf8751f,
+	0xefef5bac,
+	0x741f4fe8,
+	0x751e760d,
+	0x7fdbf081,
+	0x741cafce,
+	0xefcc7fce,
+	0x751e70ac,
+	0x741ce7bb,
+	0x3372cfed,
+	0xafdbefeb,
+	0xe5bb760b,
+	0x53f2aef8,
+	0xafe8e7eb,
+	0x4bf8771e,
+	0x7e247fed,
+	0x4fcbe2cc,
+	0x7fbc30a9,
+	0x7b0f7a0f,
+	0x34d577fd,
+	0x308b5db7,
+	0xde553e5f,
+	0xaf78741f,
+	0x741f30f0,
+	0xcfef5e2c,
+	0x741f3eac,
+	0xafb8771e,
+	0x5e677fed,
+	0x0bd3e2cc,
+	0x741ccfec,
+	0xe5ca53cd,
+	0x6fcb4f74,
+	0x5dadde4b,
+	0x2ab63d38,
+	0x4bb3de30,
+	0x751f741c,
+	0x6c42effa,
+	0xefea7fce,
+	0x6ffc30be,
+	0xefec3fca,
+	0x30b3de2e,
+	0xadf85d9e,
+	0xaf7daefd,
+	0x5d9ede2e,
+	0x5d9eafdd,
+	0x761f10ac,
+	0x1da07efd,
+	0x30adfffe,
+	0x4908fb18,
+	0x5fffdfff,
+	0xafbb709b,
+	0x4ef85e67,
+	0xadf814ad,
+	0x7a0f70ad,
+	0xcfef50ad,
+	0x7a0fde30,
+	0x5da0afed,
+	0x3c12780f,
+	0xefef780f,
+	0xefef790f,
+	0xa7f85e0f,
+	0xffef790f,
+	0xefef790f,
+	0x14adde2e,
+	0x5d9eadfd,
+	0x5e2dfffb,
+	0xe79addfd,
+	0xeff96079,
+	0x607ae79a,
+	0xddfceff9,
+	0x60795dff,
+	0x607acfef,
+	0xefefefdf,
+	0xefbfef7f,
+	0xeeffedff,
+	0xebffe7ff,
+	0xafefafdf,
+	0xafbfaf7f,
+	0xaeffadff,
+	0xabffa7ff,
+	0x6fef6fdf,
+	0x6fbf6f7f,
+	0x6eff6dff,
+	0x6bff67ff,
+	0x2fef2fdf,
+	0x2fbf2f7f,
+	0x2eff2dff,
+	0x2bff27ff,
+	0x4e08fd1f,
+	0xe5ff6e0f,
+	0xaff87eef,
+	0x7e0ffdef,
+	0xf11f6079,
+	0xabf8f542,
+	0x7e0af11c,
+	0x37cfae3a,
+	0x7fec90be,
+	0xadf8efdc,
+	0xcfeae52f,
+	0x7d0fe12b,
+	0xf11c6079,
+	0x7e0a4df8,
+	0xcfea5dc4,
+	0x7d0befec,
+	0xcfea5dc6,
+	0xe522efdc,
+	0x5dc6cfda,
+	0x4e08fd1f,
+	0x6e0faff8,
+	0x7c1f761f,
+	0xfdeff91f,
+	0x6079abf8,
+	0x761cee24,
+	0xf91f2bfb,
+	0xefefcfec,
+	0xf91f6079,
+	0x761c27fb,
+	0xefdf5da7,
+	0xcfdc7fdd,
+	0xd09c4bf8,
+	0x47fd7c1f,
+	0x761ccfcf,
+	0x7eef7fed,
+	0x7dfdf093,
+	0xef7e7f1e,
+	0x771efb18,
+	0x6079e722,
+	0xe6bbe5bb,
+	0xae0ae5bb,
+	0x600bae85,
+	0xe2bbe2bb,
+	0xe2bbe2bb,
+	0xaf02e2bb,
+	0xe2bb2ff9,
+	0x6079e2bb
+};
+
+uint patch_2f00[] = {
+	0x30303030,
+	0x3e3e3434,
+	0xabbf9b99,
+	0x4b4fbdbd,
+	0x59949334,
+	0x9fff37fb,
+	0x9b177dd9,
+	0x936956bb,
+	0xfbdd697b,
+	0xdd2fd113,
+	0x1db9f7bb,
+	0x36313963,
+	0x79373369,
+	0x3193137f,
+	0x7331737a,
+	0xf7bb9b99,
+	0x9bb19795,
+	0x77fdfd3d,
+	0x573b773f,
+	0x737933f7,
+	0xb991d115,
+	0x31699315,
+	0x31531694,
+	0xbf4fbdbd,
+	0x35931497,
+	0x35376956,
+	0xbd697b9d,
+	0x96931313,
+	0x19797937,
+	0x6935af78,
+	0xb9b3baa3,
+	0xb8788683,
+	0x368f78f7,
+	0x87778733,
+	0x3ffffb3b,
+	0x8e8f78b8,
+	0x1d118e13,
+	0xf3ff3f8b,
+	0x6bd8e173,
+	0xd1366856,
+	0x68d1687b,
+	0x3daf78b8,
+	0x3a3a3f87,
+	0x8f81378f,
+	0xf876f887,
+	0x77fd8778,
+	0x737de8d6,
+	0xbbf8bfff,
+	0xd8df87f7,
+	0xfd876f7b,
+	0x8bfff8bd,
+	0x8683387d,
+	0xb873d87b,
+	0x3b8fd7f8,
+	0xf7338883,
+	0xbb8ee1f8,
+	0xef837377,
+	0x3337b836,
+	0x817d11f8,
+	0x7378b878,
+	0xd3368b7d,
+	0xed731b7d,
+	0x833731f3,
+	0xf22f3f23
+};
+
+uint patch_2e00[] = {
+	0x27eeeeee,
+	0xeeeeeeee,
+	0xeeeeeeee,
+	0xeeeeeeee,
+	0xee4bf4fb,
+	0xdbd259bb,
+	0x1979577f,
+	0xdfd2d573,
+	0xb773f737,
+	0x4b4fbdbd,
+	0x25b9b177,
+	0xd2d17376,
+	0x956bbfdd,
+	0x697bdd2f,
+	0xff9f79ff,
+	0xff9ff22f
+};
+#endif
+
+/*
+ *  USB SOF patch arrays.
+ */
+
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
+
+uint patch_2000[] = {
+	0x7fff0000,
+	0x7ffd0000,
+	0x7ffb0000,
+	0x49f7ba5b,
+	0xba383ffb,
+	0xf9b8b46d,
+	0xe5ab4e07,
+	0xaf77bffe,
+	0x3f7bbf79,
+	0xba5bba38,
+	0xe7676076,
+	0x60750000
+};
+
+uint patch_2f00[] = {
+	0x3030304c,
+	0xcab9e441,
+	0xa1aaf220
+};
+#endif
+
+void
+cpm_load_patch(cpm8xx_t	*cp)
+{
+	volatile uint		*dp;		/* Dual-ported RAM. */
+	volatile cpm8xx_t	*commproc;
+	volatile iic_t		*iip;
+	volatile spi_t		*spp;
+	volatile smc_uart_t	*smp;
+	int	i;
+
+	commproc = cp;
+
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
+	commproc->cp_rccr = 0;
+
+	dp = (uint *)(commproc->cp_dpmem);
+	for (i=0; i<(sizeof(patch_2000)/4); i++)
+		*dp++ = patch_2000[i];
+
+	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
+	for (i=0; i<(sizeof(patch_2f00)/4); i++)
+		*dp++ = patch_2f00[i];
+
+	commproc->cp_rccr = 0x0009;
+
+	printk("USB SOF microcode patch installed\n");
+#endif /* CONFIG_USB_SOF_UCODE_PATCH */
+
+#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
+    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
+
+	commproc->cp_rccr = 0;
+
+	dp = (uint *)(commproc->cp_dpmem);
+	for (i=0; i<(sizeof(patch_2000)/4); i++)
+		*dp++ = patch_2000[i];
+
+	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
+	for (i=0; i<(sizeof(patch_2f00)/4); i++)
+		*dp++ = patch_2f00[i];
+
+	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
+# define RPBASE 0x0500
+	iip->iic_rpbase = RPBASE;
+
+	/* Put SPI above the IIC, also 32-byte aligned.
+	*/
+	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
+	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
+	spp->spi_rpbase = i;
+
+# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
+	commproc->cp_cpmcr1 = 0x802a;
+	commproc->cp_cpmcr2 = 0x8028;
+	commproc->cp_cpmcr3 = 0x802e;
+	commproc->cp_cpmcr4 = 0x802c;
+	commproc->cp_rccr = 1;
+
+	printk("I2C/SPI microcode patch installed.\n");
+# endif /* CONFIG_I2C_SPI_UCODE_PATCH */
+
+# if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
+
+	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
+	for (i=0; i<(sizeof(patch_2e00)/4); i++)
+		*dp++ = patch_2e00[i];
+
+	commproc->cp_cpmcr1 = 0x8080;
+	commproc->cp_cpmcr2 = 0x808a;
+	commproc->cp_cpmcr3 = 0x8028;
+	commproc->cp_cpmcr4 = 0x802a;
+	commproc->cp_rccr = 3;
+
+	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+	smp->smc_rpbase = 0x1FC0;
+
+	printk("I2C/SPI/SMC1 microcode patch installed.\n");
+# endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
+
+#endif /* some variation of the I2C/SPI patch was selected */
+}
+
+/*
+ *  Take this entire routine out, since no one calls it and its
+ * logic is suspect.
+ */
+
+#if 0
+void
+verify_patch(volatile immap_t *immr)
+{
+	volatile uint		*dp;
+	volatile cpm8xx_t	*commproc;
+	int i;
+
+	commproc = (cpm8xx_t *)&immr->im_cpm;
+
+	printk("cp_rccr %x\n", commproc->cp_rccr);
+	commproc->cp_rccr = 0;
+
+	dp = (uint *)(commproc->cp_dpmem);
+	for (i=0; i<(sizeof(patch_2000)/4); i++)
+		if (*dp++ != patch_2000[i]) {
+			printk("patch_2000 bad at %d\n", i);
+			dp--;
+			printk("found 0x%X, wanted 0x%X\n", *dp, patch_2000[i]);
+			break;
+		}
+
+	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
+	for (i=0; i<(sizeof(patch_2f00)/4); i++)
+		if (*dp++ != patch_2f00[i]) {
+			printk("patch_2f00 bad at %d\n", i);
+			dp--;
+			printk("found 0x%X, wanted 0x%X\n", *dp, patch_2f00[i]);
+			break;
+		}
+
+	commproc->cp_rccr = 0x0009;
+}
+#endif
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
new file mode 100644
index 0000000..d15f0c1
--- /dev/null
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -0,0 +1,209 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
+#include <asm/prom.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/8xx_immap.h>
+#include <asm/mpc8xx.h>
+
+#include "mpc8xx_pic.h"
+
+
+#define PIC_VEC_SPURRIOUS      15
+
+extern int cpm_get_irq(struct pt_regs *regs);
+
+static struct device_node *mpc8xx_pic_node;
+static struct irq_host *mpc8xx_pic_host;
+#define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
+static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+static sysconf8xx_t	*siu_reg;
+
+int cpm_get_irq(struct pt_regs *regs);
+
+static void mpc8xx_unmask_irq(unsigned int virq)
+{
+	int	bit, word;
+	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+
+	bit = irq_nr & 0x1f;
+	word = irq_nr >> 5;
+
+	ppc_cached_irq_mask[word] |= (1 << (31-bit));
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+}
+
+static void mpc8xx_mask_irq(unsigned int virq)
+{
+	int	bit, word;
+	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+
+	bit = irq_nr & 0x1f;
+	word = irq_nr >> 5;
+
+	ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+}
+
+static void mpc8xx_mask_and_ack(unsigned int virq)
+{
+	int	bit, word;
+	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+
+	bit = irq_nr & 0x1f;
+	word = irq_nr >> 5;
+
+	ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+	out_be32(&siu_reg->sc_sipend, 1 << (31-bit));
+}
+
+static void mpc8xx_end_irq(unsigned int virq)
+{
+	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+
+	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
+			&& irq_desc[irq_nr].action) {
+		int bit, word;
+
+		bit = irq_nr & 0x1f;
+		word = irq_nr >> 5;
+
+		ppc_cached_irq_mask[word] |= (1 << (31-bit));
+		out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+	}
+}
+
+static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
+{
+       struct irq_desc *desc = get_irq_desc(virq);
+
+
+        desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+        desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+        if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+                desc->status |= IRQ_LEVEL;
+
+        if (flow_type & IRQ_TYPE_EDGE_FALLING) {
+		irq_hw_number_t hw = (unsigned int)irq_map[virq].hwirq;
+		unsigned int siel = in_be32(&siu_reg->sc_siel);
+                if ((hw & 1) == 0)
+                        siel |= (0x80000000 >> hw);
+                else
+                        siel &= ~(0x80000000 >> (hw & ~1));
+		out_be32(&siu_reg->sc_siel, siel);
+	}
+        return 0;
+}
+
+static struct irq_chip mpc8xx_pic = {
+	.typename = " MPC8XX SIU ",
+	.enable = mpc8xx_unmask_irq,
+	.disable = mpc8xx_mask_irq,
+	.unmask = mpc8xx_unmask_irq,
+	.mask_ack = mpc8xx_mask_and_ack,
+	.end = mpc8xx_end_irq,
+	.set_type = mpc8xx_set_irq_type,
+};
+
+unsigned int mpc8xx_get_irq(void)
+{
+	int irq;
+
+	/* For MPC8xx, read the SIVEC register and shift the bits down
+	 * to get the irq number.
+	 */
+	irq = in_be32(&siu_reg->sc_sivec) >> 26;
+
+	/*
+	 * When we read the sivec without an interrupt to process, we will
+	 * get back SIU_LEVEL7.  In this case, return -1
+	 */
+//        if (irq == CPM_INTERRUPT)
+//        	irq = CPM_IRQ_OFFSET + cpm_get_irq(regs);
+//	else
+		if (irq == PIC_VEC_SPURRIOUS)
+			irq = NO_IRQ;
+        return irq_linear_revmap(mpc8xx_pic_host, irq);
+
+//	return irq;
+}
+
+static int mpc8xx_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	return mpc8xx_pic_node == NULL || mpc8xx_pic_node == node;
+}
+
+static int mpc8xx_pic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	pr_debug("mpc8xx_pic_host_map(%d, 0x%lx)\n", virq, hw);
+
+	set_irq_chip_and_handler(virq, &mpc8xx_pic, handle_level_irq);
+	return 0;
+}
+
+static void mpc8xx_pic_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* Make sure irq is masked in hardware */
+	mpc8xx_mask_irq(virq);
+
+	/* remove chip and handler */
+	set_irq_chip_and_handler(virq, NULL, NULL);
+}
+
+static int mpc8xx_pic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+	static unsigned char map_pic_senses[4] = {
+		IRQ_TYPE_LEVEL_LOW,
+		IRQ_TYPE_LEVEL_HIGH,
+		IRQ_TYPE_EDGE_FALLING,
+		IRQ_TYPE_EDGE_RISING,
+	};
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1 && intspec[1] < 4)
+		*out_flags = map_pic_senses[intspec[1]];
+	else
+		*out_flags = IRQ_TYPE_NONE;
+
+	return 0;
+}
+
+static struct irq_host_ops mpc8xx_pic_host_ops = {
+	.match = mpc8xx_pic_host_match,
+	.map = mpc8xx_pic_host_map,
+	.unmap = mpc8xx_pic_host_unmap,
+	.xlate = mpc8xx_pic_host_xlate,
+};
+
+void mpc8xx_pic_init(struct device_node *np)
+{
+	struct resource res;
+	int ret;
+
+	/* create a legacy host */
+	if (np)
+		mpc8xx_pic_node = of_node_get(np);
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return;
+
+	siu_reg = (void *)ioremap(res.start, res.end - res.start + 1);
+	if (siu_reg == NULL)
+		return;
+
+	mpc8xx_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &mpc8xx_pic_host_ops, 64);
+	if (mpc8xx_pic_host == NULL) {
+		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
+	}
+}
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.h b/arch/powerpc/sysdev/mpc8xx_pic.h
new file mode 100644
index 0000000..c94d3f5
--- /dev/null
+++ b/arch/powerpc/sysdev/mpc8xx_pic.h
@@ -0,0 +1,12 @@
+#ifndef _PPC_KERNEL_MPC8xx_H
+#define _PPC_KERNEL_MPC8xx_H
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+extern struct hw_interrupt_type mpc8xx_pic;
+
+void mpc8xx_pic_init(struct device_node *node);
+unsigned int mpc8xx_get_irq(void);
+
+#endif /* _PPC_KERNEL_PPC8xx_H */
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 3d0e819..4c3af35 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -11,19 +11,11 @@
 
 #ifndef FS_PD_H
 #define FS_PD_H
-#include <asm/cpm2.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/time.h>
 
-static inline int uart_baudrate(void)
-{
-        return get_baudrate();
-}
-
-static inline int uart_clock(void)
-{
-        return ppc_proc_freq;
-}
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
 
 #define cpm2_map(member)						\
 ({									\
@@ -41,5 +33,37 @@ ({									\
 })
 
 #define cpm2_unmap(addr)	iounmap(addr)
+#endif
+
+#ifdef CONFIG_8xx
+#include <asm/8xx_immap.h>
+
+#define immr_map(member)						\
+({									\
+	u32 offset = offsetof(immap_t, member);				\
+	void *addr = ioremap (IMAP_ADDR + offset,			\
+			      sizeof( ((immap_t*)0)->member));		\
+	addr;								\
+})
+
+#define immr_map_size(member, size)					\
+({									\
+	u32 offset = offsetof(immap_t, member);				\
+	void *addr = ioremap (IMAP_ADDR + offset, size);		\
+	addr;								\
+})
+
+#define immr_unmap(addr)		iounmap(addr)
+#endif
+
+static inline int uart_baudrate(void)
+{
+        return get_baudrate();
+}
+
+static inline int uart_clock(void)
+{
+        return ppc_proc_freq;
+}
 
 #endif
diff --git a/include/asm-powerpc/mpc8xx.h b/include/asm-powerpc/mpc8xx.h
new file mode 100644
index 0000000..58eb15d
--- /dev/null
+++ b/include/asm-powerpc/mpc8xx.h
@@ -0,0 +1,38 @@
+/* This is the single file included by all MPC8xx build options.
+ * Since there are many different boards and no standard configuration,
+ * we have a unique include file for each.  Rather than change every
+ * file that has to include MPC8xx configuration, they all include
+ * this one and the configuration switching is done here.
+ */
+#ifdef __KERNEL__
+#ifndef __CONFIG_8xx_DEFS
+#define __CONFIG_8xx_DEFS
+
+
+#ifdef CONFIG_8xx
+
+#ifdef CONFIG_FADS
+#include <platforms/fads.h>
+#endif
+
+#if defined(CONFIG_MPC885ADS)
+#include <platforms/8xx/mpc885ads.h>
+#endif
+
+/* Currently, all 8xx boards that support a processor to PCI/ISA bridge
+ * use the same memory map.
+ */
+#if !defined(_IO_BASE)  /* defined in board specific header */
+#define _IO_BASE        0
+#endif
+#define _ISA_MEM_BASE   0
+#define PCI_DRAM_OFFSET 0
+
+#ifndef __ASSEMBLY__
+//struct pt_regs;
+//#define PPC_PIN_SIZE	(24 * 1024 * 1024)	/* 24Mbytes of data pinned */
+#endif /* !__ASSEMBLY__ */
+
+#endif /* CONFIG_8xx */
+#endif /* __CONFIG_8xx_DEFS */
+#endif /* __KERNEL__ */
