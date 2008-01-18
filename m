Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2EDD3DDECD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 01:33:10 +1100 (EST)
Message-ID: <4790B8AB.4040702@scram.de>
Date: Fri, 18 Jan 2008 15:33:15 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 7/7] [POWERPC] Rename commproc to cpm1 and cpm2_common.c to
	cpm2.c
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename commproc.[ch] to cpm1.[ch] to be more consistent with cpm2. Also
rename cpm2_common.c to cpm2.c as suggested by Scott Wood. Adjust the
includes accordingly.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/ep88xc.c          |    2 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 +-
 arch/powerpc/sysdev/Makefile                 |    4 +-
 arch/powerpc/sysdev/commproc.c               |  612 ---------------------
 arch/powerpc/sysdev/cpm1.c                   |  612 +++++++++++++++++++++
 arch/powerpc/sysdev/cpm2.c                   |  469 ++++++++++++++++
 arch/powerpc/sysdev/cpm2_common.c            |  470 ----------------
 arch/powerpc/sysdev/micropatch.c             |    2 +-
 arch/ppc/8260_io/enet.c                      |    2 +-
 arch/ppc/8xx_io/commproc.c                   |    2 +-
 arch/ppc/8xx_io/enet.c                       |    6 +-
 arch/ppc/8xx_io/fec.c                        |    2 +-
 arch/ppc/8xx_io/micropatch.c                 |    2 +-
 arch/ppc/boot/simple/iic.c                   |    2 +-
 arch/ppc/boot/simple/m8xx_tty.c              |    2 +-
 arch/ppc/kernel/ppc_ksyms.c                  |    2 +-
 arch/ppc/platforms/mpc866ads_setup.c         |    2 +-
 arch/ppc/platforms/mpc885ads_setup.c         |    2 +-
 arch/ppc/syslib/mpc8xx_devices.c             |    2 +-
 arch/ppc/xmon/start_8xx.c                    |    2 +-
 drivers/net/fec.c                            |    2 +-
 drivers/net/fec.h                            |    2 +-
 drivers/net/fec_8xx/fec_8xx-netta.c          |    2 +-
 drivers/net/fec_8xx/fec_main.c               |    2 +-
 drivers/net/fec_8xx/fec_mii.c                |    2 +-
 drivers/net/fs_enet/fs_enet.h                |    2 +-
 drivers/net/fs_enet/mac-fec.c                |    2 +-
 drivers/net/fs_enet/mac-scc.c                |    2 +-
 drivers/serial/68360serial.c                 |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h      |    2 +-
 include/asm-powerpc/commproc.h               |  750 --------------------------
 include/asm-powerpc/cpm1.h                   |  750 ++++++++++++++++++++++++++
 include/asm-ppc/commproc.h                   |  688 -----------------------
 include/asm-ppc/cpm1.h                       |  688 +++++++++++++++++++++++
 35 files changed, 2549 insertions(+), 2550 deletions(-)
 delete mode 100644 arch/powerpc/sysdev/commproc.c
 create mode 100644 arch/powerpc/sysdev/cpm1.c
 create mode 100644 arch/powerpc/sysdev/cpm2.c
 delete mode 100644 arch/powerpc/sysdev/cpm2_common.c
 delete mode 100644 include/asm-powerpc/commproc.h
 create mode 100644 include/asm-powerpc/cpm1.h
 delete mode 100644 include/asm-ppc/commproc.h
 create mode 100644 include/asm-ppc/cpm1.h

diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index 9365f07..d300576 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -15,7 +15,7 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/udbg.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/mpc8xx.h>
 
 struct cpm_pin {
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 7389590..a68509d 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -23,7 +23,7 @@
 #include <asm/time.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 426b897..f39447b 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -36,7 +36,7 @@
 #include <asm/time.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9a20ef4..61f2604 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,8 +35,8 @@ endif
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM)		+= cpm_common.o
-obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
+obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
-obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
+obj-$(CONFIG_8xx)		+= mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 endif
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
deleted file mode 100644
index ef82587..0000000
--- a/arch/powerpc/sysdev/commproc.c
+++ /dev/null
@@ -1,612 +0,0 @@
-/*
- * General Purpose functions for the global management of the
- * Communication Processor Module.
- * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
- *
- * In addition to the individual control of the communication
- * channels, there are a few functions that globally affect the
- * communication processor.
- *
- * Buffer descriptors must be allocated from the dual ported memory
- * space.  The allocator for that is here.  When the communication
- * process is reset, we reclaim the memory available.  There is
- * currently no deallocator for this memory.
- * The amount of space available is platform dependent.  On the
- * MBX, the EPPC software loads additional microcode into the
- * communication processor, and uses some of the DP ram for this
- * purpose.  Current, the first 512 bytes and the last 256 bytes of
- * memory are used.  Right now I am conservative and only use the
- * memory that can never be used for microcode.  If there are
- * applications that require more DP ram, we can expand the boundaries
- * but then we have to be careful of any downloaded microcode.
- */
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/8xx_immap.h>
-#include <asm/commproc.h>
-#include <asm/io.h>
-#include <asm/tlbflush.h>
-#include <asm/rheap.h>
-#include <asm/prom.h>
-#include <asm/cpm.h>
-
-#include <asm/fs_pd.h>
-
-#define CPM_MAP_SIZE    (0x4000)
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-static void m8xx_cpm_dpinit(void);
-#endif
-cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
-immap_t __iomem *mpc8xx_immr;
-static cpic8xx_t __iomem *cpic_reg;
-
-static struct irq_host *cpm_pic_host;
-
-static void cpm_mask_irq(unsigned int irq)
-{
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
-
-	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
-}
-
-static void cpm_unmask_irq(unsigned int irq)
-{
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
-
-	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
-}
-
-static void cpm_end_irq(unsigned int irq)
-{
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
-
-	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
-}
-
-static struct irq_chip cpm_pic = {
-	.typename = " CPM PIC ",
-	.mask = cpm_mask_irq,
-	.unmask = cpm_unmask_irq,
-	.eoi = cpm_end_irq,
-};
-
-int cpm_get_irq(void)
-{
-	int cpm_vec;
-
-	/* Get the vector by setting the ACK bit and then reading
-	 * the register.
-	 */
-	out_be16(&cpic_reg->cpic_civr, 1);
-	cpm_vec = in_be16(&cpic_reg->cpic_civr);
-	cpm_vec >>= 11;
-
-	return irq_linear_revmap(cpm_pic_host, cpm_vec);
-}
-
-static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
-			  irq_hw_number_t hw)
-{
-	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
-
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
-	return 0;
-}
-
-/* The CPM can generate the error interrupt when there is a race condition
- * between generating and masking interrupts.  All we have to do is ACK it
- * and return.  This is a no-op function so we don't need any special
- * tests in the interrupt handler.
- */
-static irqreturn_t cpm_error_interrupt(int irq, void *dev)
-{
-	return IRQ_HANDLED;
-}
-
-static struct irqaction cpm_error_irqaction = {
-	.handler = cpm_error_interrupt,
-	.mask = CPU_MASK_NONE,
-	.name = "error",
-};
-
-static struct irq_host_ops cpm_pic_host_ops = {
-	.map = cpm_pic_host_map,
-};
-
-unsigned int cpm_pic_init(void)
-{
-	struct device_node *np = NULL;
-	struct resource res;
-	unsigned int sirq = NO_IRQ, hwirq, eirq;
-	int ret;
-
-	pr_debug("cpm_pic_init\n");
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pic");
-	if (np == NULL)
-		np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
-	if (np == NULL) {
-		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
-		return sirq;
-	}
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret)
-		goto end;
-
-	cpic_reg = ioremap(res.start, res.end - res.start + 1);
-	if (cpic_reg == NULL)
-		goto end;
-
-	sirq = irq_of_parse_and_map(np, 0);
-	if (sirq == NO_IRQ)
-		goto end;
-
-	/* Initialize the CPM interrupt controller. */
-	hwirq = (unsigned int)irq_map[sirq].hwirq;
-	out_be32(&cpic_reg->cpic_cicr,
-	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
-		((hwirq/2) << 13) | CICR_HP_MASK);
-
-	out_be32(&cpic_reg->cpic_cimr, 0);
-
-	cpm_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
-				      64, &cpm_pic_host_ops, 64);
-	if (cpm_pic_host == NULL) {
-		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
-		sirq = NO_IRQ;
-		goto end;
-	}
-
-	/* Install our own error handler. */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
-	if (np == NULL)
-		np = of_find_node_by_type(NULL, "cpm");
-	if (np == NULL) {
-		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
-		goto end;
-	}
-
-	eirq = irq_of_parse_and_map(np, 0);
-	if (eirq == NO_IRQ)
-		goto end;
-
-	if (setup_irq(eirq, &cpm_error_irqaction))
-		printk(KERN_ERR "Could not allocate CPM error IRQ!");
-
-	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
-
-end:
-	of_node_put(np);
-	return sirq;
-}
-
-void __init cpm_reset(void)
-{
-	sysconf8xx_t __iomem *siu_conf;
-
-	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
-	if (!mpc8xx_immr) {
-		printk(KERN_CRIT "Could not map IMMR\n");
-		return;
-	}
-
-	cpmp = &mpc8xx_immr->im_cpm;
-
-#ifndef CONFIG_PPC_EARLY_DEBUG_CPM
-	/* Perform a reset.
-	*/
-	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
-
-	/* Wait for it.
-	*/
-	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
-#endif
-
-#ifdef CONFIG_UCODE_PATCH
-	cpm_load_patch(cpmp);
-#endif
-
-	/* Set SDMA Bus Request priority 5.
-	 * On 860T, this also enables FEC priority 6.  I am not sure
-	 * this is what we realy want for some applications, but the
-	 * manual recommends it.
-	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
-	 */
-	siu_conf = immr_map(im_siu_conf);
-	out_be32(&siu_conf->sc_sdcr, 1);
-	immr_unmap(siu_conf);
-
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
-	cpm_muram_init();
-#else
-	/* Reclaim the DP memory for our use. */
-	m8xx_cpm_dpinit();
-#endif
-}
-
-static DEFINE_SPINLOCK(cmd_lock);
-
-#define MAX_CR_CMD_LOOPS        10000
-
-int cpm_command(u32 command, u8 opcode)
-{
-	int i, ret;
-	unsigned long flags;
-
-	if (command & 0xffffff0f)
-		return -EINVAL;
-
-	spin_lock_irqsave(&cmd_lock, flags);
-
-	ret = 0;
-	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
-	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
-		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
-			goto out;
-
-	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
-	ret = -EIO;
-out:
-	spin_unlock_irqrestore(&cmd_lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(cpm_command);
-
-/* Set a baud rate generator.  This needs lots of work.  There are
- * four BRGs, any of which can be wired to any channel.
- * The internal baud rate clock is the system clock divided by 16.
- * This assumes the baudrate is 16x oversampled by the uart.
- */
-#define BRG_INT_CLK		(get_brgfreq())
-#define BRG_UART_CLK		(BRG_INT_CLK/16)
-#define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)
-
-void
-cpm_setbrg(uint brg, uint rate)
-{
-	u32 __iomem *bp;
-
-	/* This is good enough to get SMCs running.....
-	*/
-	bp = &cpmp->cp_brgc1;
-	bp += brg;
-	/* The BRG has a 12-bit counter.  For really slow baud rates (or
-	 * really fast processors), we may have to further divide by 16.
-	 */
-	if (((BRG_UART_CLK / rate) - 1) < 4096)
-		out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
-	else
-		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
-		             CPM_BRG_EN | CPM_BRG_DIV16);
-}
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/*
- * dpalloc / dpfree bits.
- */
-static spinlock_t cpm_dpmem_lock;
-/*
- * 16 blocks should be enough to satisfy all requests
- * until the memory subsystem goes up...
- */
-static rh_block_t cpm_boot_dpmem_rh_block[16];
-static rh_info_t cpm_dpmem_info;
-
-#define CPM_DPMEM_ALIGNMENT	8
-static u8 __iomem *dpram_vbase;
-static phys_addr_t dpram_pbase;
-
-static void m8xx_cpm_dpinit(void)
-{
-	spin_lock_init(&cpm_dpmem_lock);
-
-	dpram_vbase = cpmp->cp_dpmem;
-	dpram_pbase = get_immrbase() + offsetof(immap_t, im_cpm.cp_dpmem);
-
-	/* Initialize the info header */
-	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
-			sizeof(cpm_boot_dpmem_rh_block) /
-			sizeof(cpm_boot_dpmem_rh_block[0]),
-			cpm_boot_dpmem_rh_block);
-
-	/*
-	 * Attach the usable dpmem area.
-	 * XXX: This is actually crap.  CPM_DATAONLY_BASE and
-	 * CPM_DATAONLY_SIZE are a subset of the available dparm.  It varies
-	 * with the processor and the microcode patches applied / activated.
-	 * But the following should be at least safe.
-	 */
-	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
-}
-
-/*
- * Allocate the requested size worth of DP memory.
- * This function returns an offset into the DPRAM area.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- */
-unsigned long cpm_dpalloc(uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return (uint)start;
-}
-EXPORT_SYMBOL(cpm_dpalloc);
-
-int cpm_dpfree(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, offset);
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(cpm_dpfree);
-
-unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_dpalloc_fixed);
-
-void cpm_dpdump(void)
-{
-	rh_dump(&cpm_dpmem_info);
-}
-EXPORT_SYMBOL(cpm_dpdump);
-
-void *cpm_dpram_addr(unsigned long offset)
-{
-	return (void *)(dpram_vbase + offset);
-}
-EXPORT_SYMBOL(cpm_dpram_addr);
-
-uint cpm_dpram_phys(u8 *addr)
-{
-	return (dpram_pbase + (uint)(addr - dpram_vbase));
-}
-EXPORT_SYMBOL(cpm_dpram_phys);
-#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
-
-struct cpm_ioport16 {
-	__be16 dir, par, odr_sor, dat, intr;
-	__be16 res[3];
-};
-
-struct cpm_ioport32 {
-	__be32 dir, par, sor;
-};
-
-static void cpm1_set_pin32(int port, int pin, int flags)
-{
-	struct cpm_ioport32 __iomem *iop;
-	pin = 1 << (31 - pin);
-
-	if (port == CPM_PORTB)
-		iop = (struct cpm_ioport32 __iomem *)
-		      &mpc8xx_immr->im_cpm.cp_pbdir;
-	else
-		iop = (struct cpm_ioport32 __iomem *)
-		      &mpc8xx_immr->im_cpm.cp_pedir;
-
-	if (flags & CPM_PIN_OUTPUT)
-		setbits32(&iop->dir, pin);
-	else
-		clrbits32(&iop->dir, pin);
-
-	if (!(flags & CPM_PIN_GPIO))
-		setbits32(&iop->par, pin);
-	else
-		clrbits32(&iop->par, pin);
-
-	if (port == CPM_PORTB) {
-		if (flags & CPM_PIN_OPENDRAIN)
-			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
-		else
-			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
-	}
-
-	if (port == CPM_PORTE) {
-		if (flags & CPM_PIN_SECONDARY)
-			setbits32(&iop->sor, pin);
-		else
-			clrbits32(&iop->sor, pin);
-
-		if (flags & CPM_PIN_OPENDRAIN)
-			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
-		else
-			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
-	}
-}
-
-static void cpm1_set_pin16(int port, int pin, int flags)
-{
-	struct cpm_ioport16 __iomem *iop =
-		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
-
-	pin = 1 << (15 - pin);
-
-	if (port != 0)
-		iop += port - 1;
-
-	if (flags & CPM_PIN_OUTPUT)
-		setbits16(&iop->dir, pin);
-	else
-		clrbits16(&iop->dir, pin);
-
-	if (!(flags & CPM_PIN_GPIO))
-		setbits16(&iop->par, pin);
-	else
-		clrbits16(&iop->par, pin);
-
-	if (port == CPM_PORTA) {
-		if (flags & CPM_PIN_OPENDRAIN)
-			setbits16(&iop->odr_sor, pin);
-		else
-			clrbits16(&iop->odr_sor, pin);
-	}
-	if (port == CPM_PORTC) {
-		if (flags & CPM_PIN_SECONDARY)
-			setbits16(&iop->odr_sor, pin);
-		else
-			clrbits16(&iop->odr_sor, pin);
-	}
-}
-
-void cpm1_set_pin(enum cpm_port port, int pin, int flags)
-{
-	if (port == CPM_PORTB || port == CPM_PORTE)
-		cpm1_set_pin32(port, pin, flags);
-	else
-		cpm1_set_pin16(port, pin, flags);
-}
-
-int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
-{
-	int shift;
-	int i, bits = 0;
-	u32 __iomem *reg;
-	u32 mask = 7;
-
-	u8 clk_map[][3] = {
-		{CPM_CLK_SCC1, CPM_BRG1, 0},
-		{CPM_CLK_SCC1, CPM_BRG2, 1},
-		{CPM_CLK_SCC1, CPM_BRG3, 2},
-		{CPM_CLK_SCC1, CPM_BRG4, 3},
-		{CPM_CLK_SCC1, CPM_CLK1, 4},
-		{CPM_CLK_SCC1, CPM_CLK2, 5},
-		{CPM_CLK_SCC1, CPM_CLK3, 6},
-		{CPM_CLK_SCC1, CPM_CLK4, 7},
-
-		{CPM_CLK_SCC2, CPM_BRG1, 0},
-		{CPM_CLK_SCC2, CPM_BRG2, 1},
-		{CPM_CLK_SCC2, CPM_BRG3, 2},
-		{CPM_CLK_SCC2, CPM_BRG4, 3},
-		{CPM_CLK_SCC2, CPM_CLK1, 4},
-		{CPM_CLK_SCC2, CPM_CLK2, 5},
-		{CPM_CLK_SCC2, CPM_CLK3, 6},
-		{CPM_CLK_SCC2, CPM_CLK4, 7},
-
-		{CPM_CLK_SCC3, CPM_BRG1, 0},
-		{CPM_CLK_SCC3, CPM_BRG2, 1},
-		{CPM_CLK_SCC3, CPM_BRG3, 2},
-		{CPM_CLK_SCC3, CPM_BRG4, 3},
-		{CPM_CLK_SCC3, CPM_CLK5, 4},
-		{CPM_CLK_SCC3, CPM_CLK6, 5},
-		{CPM_CLK_SCC3, CPM_CLK7, 6},
-		{CPM_CLK_SCC3, CPM_CLK8, 7},
-
-		{CPM_CLK_SCC4, CPM_BRG1, 0},
-		{CPM_CLK_SCC4, CPM_BRG2, 1},
-		{CPM_CLK_SCC4, CPM_BRG3, 2},
-		{CPM_CLK_SCC4, CPM_BRG4, 3},
-		{CPM_CLK_SCC4, CPM_CLK5, 4},
-		{CPM_CLK_SCC4, CPM_CLK6, 5},
-		{CPM_CLK_SCC4, CPM_CLK7, 6},
-		{CPM_CLK_SCC4, CPM_CLK8, 7},
-
-		{CPM_CLK_SMC1, CPM_BRG1, 0},
-		{CPM_CLK_SMC1, CPM_BRG2, 1},
-		{CPM_CLK_SMC1, CPM_BRG3, 2},
-		{CPM_CLK_SMC1, CPM_BRG4, 3},
-		{CPM_CLK_SMC1, CPM_CLK1, 4},
-		{CPM_CLK_SMC1, CPM_CLK2, 5},
-		{CPM_CLK_SMC1, CPM_CLK3, 6},
-		{CPM_CLK_SMC1, CPM_CLK4, 7},
-
-		{CPM_CLK_SMC2, CPM_BRG1, 0},
-		{CPM_CLK_SMC2, CPM_BRG2, 1},
-		{CPM_CLK_SMC2, CPM_BRG3, 2},
-		{CPM_CLK_SMC2, CPM_BRG4, 3},
-		{CPM_CLK_SMC2, CPM_CLK5, 4},
-		{CPM_CLK_SMC2, CPM_CLK6, 5},
-		{CPM_CLK_SMC2, CPM_CLK7, 6},
-		{CPM_CLK_SMC2, CPM_CLK8, 7},
-	};
-
-	switch (target) {
-	case CPM_CLK_SCC1:
-		reg = &mpc8xx_immr->im_cpm.cp_sicr;
-		shift = 0;
-		break;
-
-	case CPM_CLK_SCC2:
-		reg = &mpc8xx_immr->im_cpm.cp_sicr;
-		shift = 8;
-		break;
-
-	case CPM_CLK_SCC3:
-		reg = &mpc8xx_immr->im_cpm.cp_sicr;
-		shift = 16;
-		break;
-
-	case CPM_CLK_SCC4:
-		reg = &mpc8xx_immr->im_cpm.cp_sicr;
-		shift = 24;
-		break;
-
-	case CPM_CLK_SMC1:
-		reg = &mpc8xx_immr->im_cpm.cp_simode;
-		shift = 12;
-		break;
-
-	case CPM_CLK_SMC2:
-		reg = &mpc8xx_immr->im_cpm.cp_simode;
-		shift = 28;
-		break;
-
-	default:
-		printk(KERN_ERR "cpm1_clock_setup: invalid clock target\n");
-		return -EINVAL;
-	}
-
-	if (reg == &mpc8xx_immr->im_cpm.cp_sicr && mode == CPM_CLK_RX)
-		shift += 3;
-
-	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
-		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
-			bits = clk_map[i][2];
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(clk_map)) {
-		printk(KERN_ERR "cpm1_clock_setup: invalid clock combination\n");
-		return -EINVAL;
-	}
-
-	bits <<= shift;
-	mask <<= shift;
-	out_be32(reg, (in_be32(reg) & ~mask) | bits);
-
-	return 0;
-}
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
new file mode 100644
index 0000000..df8bd2b
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -0,0 +1,612 @@
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
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/8xx_immap.h>
+#include <asm/cpm1.h>
+#include <asm/io.h>
+#include <asm/tlbflush.h>
+#include <asm/rheap.h>
+#include <asm/prom.h>
+#include <asm/cpm.h>
+
+#include <asm/fs_pd.h>
+
+#define CPM_MAP_SIZE    (0x4000)
+
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
+static void m8xx_cpm_dpinit(void);
+#endif
+cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
+immap_t __iomem *mpc8xx_immr;
+static cpic8xx_t __iomem *cpic_reg;
+
+static struct irq_host *cpm_pic_host;
+
+static void cpm_mask_irq(unsigned int irq)
+{
+	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+}
+
+static void cpm_unmask_irq(unsigned int irq)
+{
+	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+}
+
+static void cpm_end_irq(unsigned int irq)
+{
+	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+
+	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
+}
+
+static struct irq_chip cpm_pic = {
+	.typename = " CPM PIC ",
+	.mask = cpm_mask_irq,
+	.unmask = cpm_unmask_irq,
+	.eoi = cpm_end_irq,
+};
+
+int cpm_get_irq(void)
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
+static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
+
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
+	return 0;
+}
+
+/* The CPM can generate the error interrupt when there is a race condition
+ * between generating and masking interrupts.  All we have to do is ACK it
+ * and return.  This is a no-op function so we don't need any special
+ * tests in the interrupt handler.
+ */
+static irqreturn_t cpm_error_interrupt(int irq, void *dev)
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
+	.map = cpm_pic_host_map,
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
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pic");
+	if (np == NULL)
+		np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
+	if (np == NULL) {
+		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
+		return sirq;
+	}
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		goto end;
+
+	cpic_reg = ioremap(res.start, res.end - res.start + 1);
+	if (cpic_reg == NULL)
+		goto end;
+
+	sirq = irq_of_parse_and_map(np, 0);
+	if (sirq == NO_IRQ)
+		goto end;
+
+	/* Initialize the CPM interrupt controller. */
+	hwirq = (unsigned int)irq_map[sirq].hwirq;
+	out_be32(&cpic_reg->cpic_cicr,
+	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
+		((hwirq/2) << 13) | CICR_HP_MASK);
+
+	out_be32(&cpic_reg->cpic_cimr, 0);
+
+	cpm_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
+				      64, &cpm_pic_host_ops, 64);
+	if (cpm_pic_host == NULL) {
+		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
+		sirq = NO_IRQ;
+		goto end;
+	}
+
+	/* Install our own error handler. */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
+	if (np == NULL)
+		np = of_find_node_by_type(NULL, "cpm");
+	if (np == NULL) {
+		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
+		goto end;
+	}
+
+	eirq = irq_of_parse_and_map(np, 0);
+	if (eirq == NO_IRQ)
+		goto end;
+
+	if (setup_irq(eirq, &cpm_error_irqaction))
+		printk(KERN_ERR "Could not allocate CPM error IRQ!");
+
+	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
+
+end:
+	of_node_put(np);
+	return sirq;
+}
+
+void __init cpm_reset(void)
+{
+	sysconf8xx_t __iomem *siu_conf;
+
+	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
+	if (!mpc8xx_immr) {
+		printk(KERN_CRIT "Could not map IMMR\n");
+		return;
+	}
+
+	cpmp = &mpc8xx_immr->im_cpm;
+
+#ifndef CONFIG_PPC_EARLY_DEBUG_CPM
+	/* Perform a reset.
+	*/
+	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
+
+	/* Wait for it.
+	*/
+	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
+#endif
+
+#ifdef CONFIG_UCODE_PATCH
+	cpm_load_patch(cpmp);
+#endif
+
+	/* Set SDMA Bus Request priority 5.
+	 * On 860T, this also enables FEC priority 6.  I am not sure
+	 * this is what we realy want for some applications, but the
+	 * manual recommends it.
+	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
+	 */
+	siu_conf = immr_map(im_siu_conf);
+	out_be32(&siu_conf->sc_sdcr, 1);
+	immr_unmap(siu_conf);
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	cpm_muram_init();
+#else
+	/* Reclaim the DP memory for our use. */
+	m8xx_cpm_dpinit();
+#endif
+}
+
+static DEFINE_SPINLOCK(cmd_lock);
+
+#define MAX_CR_CMD_LOOPS        10000
+
+int cpm_command(u32 command, u8 opcode)
+{
+	int i, ret;
+	unsigned long flags;
+
+	if (command & 0xffffff0f)
+		return -EINVAL;
+
+	spin_lock_irqsave(&cmd_lock, flags);
+
+	ret = 0;
+	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
+	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
+		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
+			goto out;
+
+	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
+	ret = -EIO;
+out:
+	spin_unlock_irqrestore(&cmd_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(cpm_command);
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
+	u32 __iomem *bp;
+
+	/* This is good enough to get SMCs running.....
+	*/
+	bp = &cpmp->cp_brgc1;
+	bp += brg;
+	/* The BRG has a 12-bit counter.  For really slow baud rates (or
+	 * really fast processors), we may have to further divide by 16.
+	 */
+	if (((BRG_UART_CLK / rate) - 1) < 4096)
+		out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
+	else
+		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
+			      CPM_BRG_EN | CPM_BRG_DIV16);
+}
+
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
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
+static u8 __iomem *dpram_vbase;
+static phys_addr_t dpram_pbase;
+
+static void m8xx_cpm_dpinit(void)
+{
+	spin_lock_init(&cpm_dpmem_lock);
+
+	dpram_vbase = cpmp->cp_dpmem;
+	dpram_pbase = get_immrbase() + offsetof(immap_t, im_cpm.cp_dpmem);
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
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+}
+
+/*
+ * Allocate the requested size worth of DP memory.
+ * This function returns an offset into the DPRAM area.
+ * Use cpm_dpram_addr() to get the virtual address of the area.
+ */
+unsigned long cpm_dpalloc(uint size, uint align)
+{
+	unsigned long start;
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
+int cpm_dpfree(unsigned long offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_free(&cpm_dpmem_info, offset);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpm_dpfree);
+
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	cpm_dpmem_info.alignment = align;
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(cpm_dpalloc_fixed);
+
+void cpm_dpdump(void)
+{
+	rh_dump(&cpm_dpmem_info);
+}
+EXPORT_SYMBOL(cpm_dpdump);
+
+void *cpm_dpram_addr(unsigned long offset)
+{
+	return (void *)(dpram_vbase + offset);
+}
+EXPORT_SYMBOL(cpm_dpram_addr);
+
+uint cpm_dpram_phys(u8 *addr)
+{
+	return (dpram_pbase + (uint)(addr - dpram_vbase));
+}
+EXPORT_SYMBOL(cpm_dpram_phys);
+#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
+
+struct cpm_ioport16 {
+	__be16 dir, par, odr_sor, dat, intr;
+	__be16 res[3];
+};
+
+struct cpm_ioport32 {
+	__be32 dir, par, sor;
+};
+
+static void cpm1_set_pin32(int port, int pin, int flags)
+{
+	struct cpm_ioport32 __iomem *iop;
+	pin = 1 << (31 - pin);
+
+	if (port == CPM_PORTB)
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pbdir;
+	else
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pedir;
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits32(&iop->dir, pin);
+	else
+		clrbits32(&iop->dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits32(&iop->par, pin);
+	else
+		clrbits32(&iop->par, pin);
+
+	if (port == CPM_PORTB) {
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
+		else
+			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
+	}
+
+	if (port == CPM_PORTE) {
+		if (flags & CPM_PIN_SECONDARY)
+			setbits32(&iop->sor, pin);
+		else
+			clrbits32(&iop->sor, pin);
+
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+		else
+			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
+	}
+}
+
+static void cpm1_set_pin16(int port, int pin, int flags)
+{
+	struct cpm_ioport16 __iomem *iop =
+		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
+
+	pin = 1 << (15 - pin);
+
+	if (port != 0)
+		iop += port - 1;
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits16(&iop->dir, pin);
+	else
+		clrbits16(&iop->dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits16(&iop->par, pin);
+	else
+		clrbits16(&iop->par, pin);
+
+	if (port == CPM_PORTA) {
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits16(&iop->odr_sor, pin);
+		else
+			clrbits16(&iop->odr_sor, pin);
+	}
+	if (port == CPM_PORTC) {
+		if (flags & CPM_PIN_SECONDARY)
+			setbits16(&iop->odr_sor, pin);
+		else
+			clrbits16(&iop->odr_sor, pin);
+	}
+}
+
+void cpm1_set_pin(enum cpm_port port, int pin, int flags)
+{
+	if (port == CPM_PORTB || port == CPM_PORTE)
+		cpm1_set_pin32(port, pin, flags);
+	else
+		cpm1_set_pin16(port, pin, flags);
+}
+
+int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
+{
+	int shift;
+	int i, bits = 0;
+	u32 __iomem *reg;
+	u32 mask = 7;
+
+	u8 clk_map[][3] = {
+		{CPM_CLK_SCC1, CPM_BRG1, 0},
+		{CPM_CLK_SCC1, CPM_BRG2, 1},
+		{CPM_CLK_SCC1, CPM_BRG3, 2},
+		{CPM_CLK_SCC1, CPM_BRG4, 3},
+		{CPM_CLK_SCC1, CPM_CLK1, 4},
+		{CPM_CLK_SCC1, CPM_CLK2, 5},
+		{CPM_CLK_SCC1, CPM_CLK3, 6},
+		{CPM_CLK_SCC1, CPM_CLK4, 7},
+
+		{CPM_CLK_SCC2, CPM_BRG1, 0},
+		{CPM_CLK_SCC2, CPM_BRG2, 1},
+		{CPM_CLK_SCC2, CPM_BRG3, 2},
+		{CPM_CLK_SCC2, CPM_BRG4, 3},
+		{CPM_CLK_SCC2, CPM_CLK1, 4},
+		{CPM_CLK_SCC2, CPM_CLK2, 5},
+		{CPM_CLK_SCC2, CPM_CLK3, 6},
+		{CPM_CLK_SCC2, CPM_CLK4, 7},
+
+		{CPM_CLK_SCC3, CPM_BRG1, 0},
+		{CPM_CLK_SCC3, CPM_BRG2, 1},
+		{CPM_CLK_SCC3, CPM_BRG3, 2},
+		{CPM_CLK_SCC3, CPM_BRG4, 3},
+		{CPM_CLK_SCC3, CPM_CLK5, 4},
+		{CPM_CLK_SCC3, CPM_CLK6, 5},
+		{CPM_CLK_SCC3, CPM_CLK7, 6},
+		{CPM_CLK_SCC3, CPM_CLK8, 7},
+
+		{CPM_CLK_SCC4, CPM_BRG1, 0},
+		{CPM_CLK_SCC4, CPM_BRG2, 1},
+		{CPM_CLK_SCC4, CPM_BRG3, 2},
+		{CPM_CLK_SCC4, CPM_BRG4, 3},
+		{CPM_CLK_SCC4, CPM_CLK5, 4},
+		{CPM_CLK_SCC4, CPM_CLK6, 5},
+		{CPM_CLK_SCC4, CPM_CLK7, 6},
+		{CPM_CLK_SCC4, CPM_CLK8, 7},
+
+		{CPM_CLK_SMC1, CPM_BRG1, 0},
+		{CPM_CLK_SMC1, CPM_BRG2, 1},
+		{CPM_CLK_SMC1, CPM_BRG3, 2},
+		{CPM_CLK_SMC1, CPM_BRG4, 3},
+		{CPM_CLK_SMC1, CPM_CLK1, 4},
+		{CPM_CLK_SMC1, CPM_CLK2, 5},
+		{CPM_CLK_SMC1, CPM_CLK3, 6},
+		{CPM_CLK_SMC1, CPM_CLK4, 7},
+
+		{CPM_CLK_SMC2, CPM_BRG1, 0},
+		{CPM_CLK_SMC2, CPM_BRG2, 1},
+		{CPM_CLK_SMC2, CPM_BRG3, 2},
+		{CPM_CLK_SMC2, CPM_BRG4, 3},
+		{CPM_CLK_SMC2, CPM_CLK5, 4},
+		{CPM_CLK_SMC2, CPM_CLK6, 5},
+		{CPM_CLK_SMC2, CPM_CLK7, 6},
+		{CPM_CLK_SMC2, CPM_CLK8, 7},
+	};
+
+	switch (target) {
+	case CPM_CLK_SCC1:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 0;
+		break;
+
+	case CPM_CLK_SCC2:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 8;
+		break;
+
+	case CPM_CLK_SCC3:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 16;
+		break;
+
+	case CPM_CLK_SCC4:
+		reg = &mpc8xx_immr->im_cpm.cp_sicr;
+		shift = 24;
+		break;
+
+	case CPM_CLK_SMC1:
+		reg = &mpc8xx_immr->im_cpm.cp_simode;
+		shift = 12;
+		break;
+
+	case CPM_CLK_SMC2:
+		reg = &mpc8xx_immr->im_cpm.cp_simode;
+		shift = 28;
+		break;
+
+	default:
+		printk(KERN_ERR "cpm1_clock_setup: invalid clock target\n");
+		return -EINVAL;
+	}
+
+	if (reg == &mpc8xx_immr->im_cpm.cp_sicr && mode == CPM_CLK_RX)
+		shift += 3;
+
+	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
+		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
+			bits = clk_map[i][2];
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(clk_map)) {
+		printk(KERN_ERR "cpm1_clock_setup: invalid clock combination\n");
+		return -EINVAL;
+	}
+
+	bits <<= shift;
+	mask <<= shift;
+	out_be32(reg, (in_be32(reg) & ~mask) | bits);
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
new file mode 100644
index 0000000..7be7112
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -0,0 +1,469 @@
+/*
+ * General Purpose functions for the global management of the
+ * 8260 Communication Processor Module.
+ * Copyright (c) 1999-2001 Dan Malek <dan@embeddedalley.com>
+ * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
+ *	2.3.99 Updates
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 	Merged to arch/powerpc from arch/ppc/syslib/cpm2_common.c
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/*
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
+#include <linux/of.h>
+
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
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
+static void cpm2_dpinit(void);
+#endif
+
+cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
+
+/* We allocate this here because it is used almost exclusively for
+ * the communication processor devices.
+ */
+cpm2_map_t __iomem *cpm2_immr;
+
+#define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
+					   of space for CPM as it is larger
+					   than on PQ2 */
+
+void __init cpm2_reset(void)
+{
+#ifdef CONFIG_PPC_85xx
+	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+#else
+	cpm2_immr = ioremap(get_immrbase(), CPM_MAP_SIZE);
+#endif
+
+	/* Reclaim the DP memory for our use.
+	 */
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	cpm_muram_init();
+#else
+	cpm2_dpinit();
+#endif
+
+	/* Tell everyone where the comm processor resides.
+	 */
+	cpmp = &cpm2_immr->im_cpm;
+}
+
+static DEFINE_SPINLOCK(cmd_lock);
+
+#define MAX_CR_CMD_LOOPS        10000
+
+int cpm_command(u32 command, u8 opcode)
+{
+	int i, ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmd_lock, flags);
+
+	ret = 0;
+	out_be32(&cpmp->cp_cpcr, command | opcode | CPM_CR_FLG);
+	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
+		if ((in_be32(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
+			goto out;
+
+	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
+	ret = -EIO;
+out:
+	spin_unlock_irqrestore(&cmd_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(cpm_command);
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
+	u32 __iomem *bp;
+
+	/* This is good enough to get SMCs running.....
+	*/
+	if (brg < 4) {
+		bp = cpm2_map_size(im_brgc1, 16);
+	} else {
+		bp = cpm2_map_size(im_brgc5, 16);
+		brg -= 4;
+	}
+	bp += brg;
+	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
+
+	cpm2_unmap(bp);
+}
+
+/* This function is used to set high speed synchronous baud rate
+ * clocks.
+ */
+void
+cpm2_fastbrg(uint brg, uint rate, int div16)
+{
+	u32 __iomem *bp;
+	u32 val;
+
+	if (brg < 4) {
+		bp = cpm2_map_size(im_brgc1, 16);
+	} else {
+		bp = cpm2_map_size(im_brgc5, 16);
+		brg -= 4;
+	}
+	bp += brg;
+	val = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
+	if (div16)
+		val |= CPM_BRG_DIV16;
+
+	out_be32(bp, val);
+	cpm2_unmap(bp);
+}
+
+int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
+{
+	int ret = 0;
+	int shift;
+	int i, bits = 0;
+	cpmux_t __iomem *im_cpmux;
+	u32 __iomem *reg;
+	u32 mask = 7;
+
+	u8 clk_map[][3] = {
+		{CPM_CLK_FCC1, CPM_BRG5, 0},
+		{CPM_CLK_FCC1, CPM_BRG6, 1},
+		{CPM_CLK_FCC1, CPM_BRG7, 2},
+		{CPM_CLK_FCC1, CPM_BRG8, 3},
+		{CPM_CLK_FCC1, CPM_CLK9, 4},
+		{CPM_CLK_FCC1, CPM_CLK10, 5},
+		{CPM_CLK_FCC1, CPM_CLK11, 6},
+		{CPM_CLK_FCC1, CPM_CLK12, 7},
+		{CPM_CLK_FCC2, CPM_BRG5, 0},
+		{CPM_CLK_FCC2, CPM_BRG6, 1},
+		{CPM_CLK_FCC2, CPM_BRG7, 2},
+		{CPM_CLK_FCC2, CPM_BRG8, 3},
+		{CPM_CLK_FCC2, CPM_CLK13, 4},
+		{CPM_CLK_FCC2, CPM_CLK14, 5},
+		{CPM_CLK_FCC2, CPM_CLK15, 6},
+		{CPM_CLK_FCC2, CPM_CLK16, 7},
+		{CPM_CLK_FCC3, CPM_BRG5, 0},
+		{CPM_CLK_FCC3, CPM_BRG6, 1},
+		{CPM_CLK_FCC3, CPM_BRG7, 2},
+		{CPM_CLK_FCC3, CPM_BRG8, 3},
+		{CPM_CLK_FCC3, CPM_CLK13, 4},
+		{CPM_CLK_FCC3, CPM_CLK14, 5},
+		{CPM_CLK_FCC3, CPM_CLK15, 6},
+		{CPM_CLK_FCC3, CPM_CLK16, 7},
+		{CPM_CLK_SCC1, CPM_BRG1, 0},
+		{CPM_CLK_SCC1, CPM_BRG2, 1},
+		{CPM_CLK_SCC1, CPM_BRG3, 2},
+		{CPM_CLK_SCC1, CPM_BRG4, 3},
+		{CPM_CLK_SCC1, CPM_CLK11, 4},
+		{CPM_CLK_SCC1, CPM_CLK12, 5},
+		{CPM_CLK_SCC1, CPM_CLK3, 6},
+		{CPM_CLK_SCC1, CPM_CLK4, 7},
+		{CPM_CLK_SCC2, CPM_BRG1, 0},
+		{CPM_CLK_SCC2, CPM_BRG2, 1},
+		{CPM_CLK_SCC2, CPM_BRG3, 2},
+		{CPM_CLK_SCC2, CPM_BRG4, 3},
+		{CPM_CLK_SCC2, CPM_CLK11, 4},
+		{CPM_CLK_SCC2, CPM_CLK12, 5},
+		{CPM_CLK_SCC2, CPM_CLK3, 6},
+		{CPM_CLK_SCC2, CPM_CLK4, 7},
+		{CPM_CLK_SCC3, CPM_BRG1, 0},
+		{CPM_CLK_SCC3, CPM_BRG2, 1},
+		{CPM_CLK_SCC3, CPM_BRG3, 2},
+		{CPM_CLK_SCC3, CPM_BRG4, 3},
+		{CPM_CLK_SCC3, CPM_CLK5, 4},
+		{CPM_CLK_SCC3, CPM_CLK6, 5},
+		{CPM_CLK_SCC3, CPM_CLK7, 6},
+		{CPM_CLK_SCC3, CPM_CLK8, 7},
+		{CPM_CLK_SCC4, CPM_BRG1, 0},
+		{CPM_CLK_SCC4, CPM_BRG2, 1},
+		{CPM_CLK_SCC4, CPM_BRG3, 2},
+		{CPM_CLK_SCC4, CPM_BRG4, 3},
+		{CPM_CLK_SCC4, CPM_CLK5, 4},
+		{CPM_CLK_SCC4, CPM_CLK6, 5},
+		{CPM_CLK_SCC4, CPM_CLK7, 6},
+		{CPM_CLK_SCC4, CPM_CLK8, 7},
+	};
+
+	im_cpmux = cpm2_map(im_cpmux);
+
+	switch (target) {
+	case CPM_CLK_SCC1:
+		reg = &im_cpmux->cmx_scr;
+		shift = 24;
+	case CPM_CLK_SCC2:
+		reg = &im_cpmux->cmx_scr;
+		shift = 16;
+		break;
+	case CPM_CLK_SCC3:
+		reg = &im_cpmux->cmx_scr;
+		shift = 8;
+		break;
+	case CPM_CLK_SCC4:
+		reg = &im_cpmux->cmx_scr;
+		shift = 0;
+		break;
+	case CPM_CLK_FCC1:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 24;
+		break;
+	case CPM_CLK_FCC2:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 16;
+		break;
+	case CPM_CLK_FCC3:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 8;
+		break;
+	default:
+		printk(KERN_ERR "cpm2_clock_setup: invalid clock target\n");
+		return -EINVAL;
+	}
+
+	if (mode == CPM_CLK_RX)
+		shift += 3;
+
+	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
+		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
+			bits = clk_map[i][2];
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(clk_map))
+	    ret = -EINVAL;
+
+	bits <<= shift;
+	mask <<= shift;
+
+	out_be32(reg, (in_be32(reg) & ~mask) | bits);
+
+	cpm2_unmap(im_cpmux);
+	return ret;
+}
+
+int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
+{
+	int ret = 0;
+	int shift;
+	int i, bits = 0;
+	cpmux_t __iomem *im_cpmux;
+	u8 __iomem *reg;
+	u8 mask = 3;
+
+	u8 clk_map[][3] = {
+		{CPM_CLK_SMC1, CPM_BRG1, 0},
+		{CPM_CLK_SMC1, CPM_BRG7, 1},
+		{CPM_CLK_SMC1, CPM_CLK7, 2},
+		{CPM_CLK_SMC1, CPM_CLK9, 3},
+		{CPM_CLK_SMC2, CPM_BRG2, 0},
+		{CPM_CLK_SMC2, CPM_BRG8, 1},
+		{CPM_CLK_SMC2, CPM_CLK4, 2},
+		{CPM_CLK_SMC2, CPM_CLK15, 3},
+	};
+
+	im_cpmux = cpm2_map(im_cpmux);
+
+	switch (target) {
+	case CPM_CLK_SMC1:
+		reg = &im_cpmux->cmx_smr;
+		mask = 3;
+		shift = 4;
+		break;
+	case CPM_CLK_SMC2:
+		reg = &im_cpmux->cmx_smr;
+		mask = 3;
+		shift = 0;
+		break;
+	default:
+		printk(KERN_ERR "cpm2_smc_clock_setup: invalid clock target\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
+		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
+			bits = clk_map[i][2];
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(clk_map))
+	    ret = -EINVAL;
+
+	bits <<= shift;
+	mask <<= shift;
+
+	out_8(reg, (in_8(reg) & ~mask) | bits);
+
+	cpm2_unmap(im_cpmux);
+	return ret;
+}
+
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
+/*
+ * dpalloc / dpfree bits.
+ */
+static spinlock_t cpm_dpmem_lock;
+/* 16 blocks should be enough to satisfy all requests
+ * until the memory subsystem goes up... */
+static rh_block_t cpm_boot_dpmem_rh_block[16];
+static rh_info_t cpm_dpmem_info;
+static u8 __iomem *im_dprambase;
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
+	im_dprambase = cpm2_immr;
+
+	/* Attach the usable dpmem area */
+	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
+	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
+	 * varies with the processor and the microcode patches activated.
+	 * But the following should be at least safe.
+	 */
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+}
+
+/* This function returns an index into the DPRAM area.
+ */
+unsigned long cpm_dpalloc(uint size, uint align)
+{
+	unsigned long start;
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
+int cpm_dpfree(unsigned long offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	ret = rh_free(&cpm_dpmem_info, offset);
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpm_dpfree);
+
+/* not sure if this is ever needed */
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_dpmem_lock, flags);
+	cpm_dpmem_info.alignment = align;
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
+	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(cpm_dpalloc_fixed);
+
+void cpm_dpdump(void)
+{
+	rh_dump(&cpm_dpmem_info);
+}
+EXPORT_SYMBOL(cpm_dpdump);
+
+void *cpm_dpram_addr(unsigned long offset)
+{
+	return (void *)(im_dprambase + offset);
+}
+EXPORT_SYMBOL(cpm_dpram_addr);
+#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
+
+struct cpm2_ioports {
+	u32 dir, par, sor, odr, dat;
+	u32 res[3];
+};
+
+void cpm2_set_pin(int port, int pin, int flags)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
+
+	pin = 1 << (31 - pin);
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits32(&iop[port].dir, pin);
+	else
+		clrbits32(&iop[port].dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits32(&iop[port].par, pin);
+	else
+		clrbits32(&iop[port].par, pin);
+
+	if (flags & CPM_PIN_SECONDARY)
+		setbits32(&iop[port].sor, pin);
+	else
+		clrbits32(&iop[port].sor, pin);
+
+	if (flags & CPM_PIN_OPENDRAIN)
+		setbits32(&iop[port].odr, pin);
+	else
+		clrbits32(&iop[port].odr, pin);
+}
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
deleted file mode 100644
index f7188e2..0000000
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ /dev/null
@@ -1,470 +0,0 @@
-/*
- * General Purpose functions for the global management of the
- * 8260 Communication Processor Module.
- * Copyright (c) 1999-2001 Dan Malek <dan@embeddedalley.com>
- * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
- *	2.3.99 Updates
- *
- * 2006 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
- * 	Merged to arch/powerpc from arch/ppc/syslib/cpm2_common.c
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/*
- *
- * In addition to the individual control of the communication
- * channels, there are a few functions that globally affect the
- * communication processor.
- *
- * Buffer descriptors must be allocated from the dual ported memory
- * space.  The allocator for that is here.  When the communication
- * process is reset, we reclaim the memory available.  There is
- * currently no deallocator for this memory.
- */
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/of.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mpc8260.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/cpm2.h>
-#include <asm/rheap.h>
-#include <asm/fs_pd.h>
-
-#include <sysdev/fsl_soc.h>
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-static void cpm2_dpinit(void);
-#endif
-
-cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
-
-/* We allocate this here because it is used almost exclusively for
- * the communication processor devices.
- */
-cpm2_map_t __iomem *cpm2_immr;
-
-#define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
-					   of space for CPM as it is larger
-					   than on PQ2 */
-
-void __init cpm2_reset(void)
-{
-#ifdef CONFIG_PPC_85xx
-	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
-#else
-	cpm2_immr = ioremap(get_immrbase(), CPM_MAP_SIZE);
-#endif
-
-	/* Reclaim the DP memory for our use.
-	 */
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
-	cpm_muram_init();
-#else
-	cpm2_dpinit();
-#endif
-
-	/* Tell everyone where the comm processor resides.
-	 */
-	cpmp = &cpm2_immr->im_cpm;
-}
-
-static DEFINE_SPINLOCK(cmd_lock);
-
-#define MAX_CR_CMD_LOOPS        10000
-
-int cpm_command(u32 command, u8 opcode)
-{
-	int i, ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cmd_lock, flags);
-
-	ret = 0;
-	out_be32(&cpmp->cp_cpcr, command | opcode | CPM_CR_FLG);
-	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
-		if ((in_be32(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
-			goto out;
-
-	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
-	ret = -EIO;
-out:
-	spin_unlock_irqrestore(&cmd_lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(cpm_command);
-
-/* Set a baud rate generator.  This needs lots of work.  There are
- * eight BRGs, which can be connected to the CPM channels or output
- * as clocks.  The BRGs are in two different block of internal
- * memory mapped space.
- * The baud rate clock is the system clock divided by something.
- * It was set up long ago during the initial boot phase and is
- * is given to us.
- * Baud rate clocks are zero-based in the driver code (as that maps
- * to port numbers).  Documentation uses 1-based numbering.
- */
-#define BRG_INT_CLK	(get_brgfreq())
-#define BRG_UART_CLK	(BRG_INT_CLK/16)
-
-/* This function is used by UARTS, or anything else that uses a 16x
- * oversampled clock.
- */
-void
-cpm_setbrg(uint brg, uint rate)
-{
-	u32 __iomem *bp;
-
-	/* This is good enough to get SMCs running.....
-	*/
-	if (brg < 4) {
-		bp = cpm2_map_size(im_brgc1, 16);
-	} else {
-		bp = cpm2_map_size(im_brgc5, 16);
-		brg -= 4;
-	}
-	bp += brg;
-	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
-
-	cpm2_unmap(bp);
-}
-
-/* This function is used to set high speed synchronous baud rate
- * clocks.
- */
-void
-cpm2_fastbrg(uint brg, uint rate, int div16)
-{
-	u32 __iomem *bp;
-	u32 val;
-
-	if (brg < 4) {
-		bp = cpm2_map_size(im_brgc1, 16);
-	}
-	else {
-		bp = cpm2_map_size(im_brgc5, 16);
-		brg -= 4;
-	}
-	bp += brg;
-	val = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
-	if (div16)
-		val |= CPM_BRG_DIV16;
-
-	out_be32(bp, val);
-	cpm2_unmap(bp);
-}
-
-int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
-{
-	int ret = 0;
-	int shift;
-	int i, bits = 0;
-	cpmux_t __iomem *im_cpmux;
-	u32 __iomem *reg;
-	u32 mask = 7;
-
-	u8 clk_map[][3] = {
-		{CPM_CLK_FCC1, CPM_BRG5, 0},
-		{CPM_CLK_FCC1, CPM_BRG6, 1},
-		{CPM_CLK_FCC1, CPM_BRG7, 2},
-		{CPM_CLK_FCC1, CPM_BRG8, 3},
-		{CPM_CLK_FCC1, CPM_CLK9, 4},
-		{CPM_CLK_FCC1, CPM_CLK10, 5},
-		{CPM_CLK_FCC1, CPM_CLK11, 6},
-		{CPM_CLK_FCC1, CPM_CLK12, 7},
-		{CPM_CLK_FCC2, CPM_BRG5, 0},
-		{CPM_CLK_FCC2, CPM_BRG6, 1},
-		{CPM_CLK_FCC2, CPM_BRG7, 2},
-		{CPM_CLK_FCC2, CPM_BRG8, 3},
-		{CPM_CLK_FCC2, CPM_CLK13, 4},
-		{CPM_CLK_FCC2, CPM_CLK14, 5},
-		{CPM_CLK_FCC2, CPM_CLK15, 6},
-		{CPM_CLK_FCC2, CPM_CLK16, 7},
-		{CPM_CLK_FCC3, CPM_BRG5, 0},
-		{CPM_CLK_FCC3, CPM_BRG6, 1},
-		{CPM_CLK_FCC3, CPM_BRG7, 2},
-		{CPM_CLK_FCC3, CPM_BRG8, 3},
-		{CPM_CLK_FCC3, CPM_CLK13, 4},
-		{CPM_CLK_FCC3, CPM_CLK14, 5},
-		{CPM_CLK_FCC3, CPM_CLK15, 6},
-		{CPM_CLK_FCC3, CPM_CLK16, 7},
-		{CPM_CLK_SCC1, CPM_BRG1, 0},
-		{CPM_CLK_SCC1, CPM_BRG2, 1},
-		{CPM_CLK_SCC1, CPM_BRG3, 2},
-		{CPM_CLK_SCC1, CPM_BRG4, 3},
-		{CPM_CLK_SCC1, CPM_CLK11, 4},
-		{CPM_CLK_SCC1, CPM_CLK12, 5},
-		{CPM_CLK_SCC1, CPM_CLK3, 6},
-		{CPM_CLK_SCC1, CPM_CLK4, 7},
-		{CPM_CLK_SCC2, CPM_BRG1, 0},
-		{CPM_CLK_SCC2, CPM_BRG2, 1},
-		{CPM_CLK_SCC2, CPM_BRG3, 2},
-		{CPM_CLK_SCC2, CPM_BRG4, 3},
-		{CPM_CLK_SCC2, CPM_CLK11, 4},
-		{CPM_CLK_SCC2, CPM_CLK12, 5},
-		{CPM_CLK_SCC2, CPM_CLK3, 6},
-		{CPM_CLK_SCC2, CPM_CLK4, 7},
-		{CPM_CLK_SCC3, CPM_BRG1, 0},
-		{CPM_CLK_SCC3, CPM_BRG2, 1},
-		{CPM_CLK_SCC3, CPM_BRG3, 2},
-		{CPM_CLK_SCC3, CPM_BRG4, 3},
-		{CPM_CLK_SCC3, CPM_CLK5, 4},
-		{CPM_CLK_SCC3, CPM_CLK6, 5},
-		{CPM_CLK_SCC3, CPM_CLK7, 6},
-		{CPM_CLK_SCC3, CPM_CLK8, 7},
-		{CPM_CLK_SCC4, CPM_BRG1, 0},
-		{CPM_CLK_SCC4, CPM_BRG2, 1},
-		{CPM_CLK_SCC4, CPM_BRG3, 2},
-		{CPM_CLK_SCC4, CPM_BRG4, 3},
-		{CPM_CLK_SCC4, CPM_CLK5, 4},
-		{CPM_CLK_SCC4, CPM_CLK6, 5},
-		{CPM_CLK_SCC4, CPM_CLK7, 6},
-		{CPM_CLK_SCC4, CPM_CLK8, 7},
-	};
-
-	im_cpmux = cpm2_map(im_cpmux);
-
-	switch (target) {
-	case CPM_CLK_SCC1:
-		reg = &im_cpmux->cmx_scr;
-		shift = 24;
-	case CPM_CLK_SCC2:
-		reg = &im_cpmux->cmx_scr;
-		shift = 16;
-		break;
-	case CPM_CLK_SCC3:
-		reg = &im_cpmux->cmx_scr;
-		shift = 8;
-		break;
-	case CPM_CLK_SCC4:
-		reg = &im_cpmux->cmx_scr;
-		shift = 0;
-		break;
-	case CPM_CLK_FCC1:
-		reg = &im_cpmux->cmx_fcr;
-		shift = 24;
-		break;
-	case CPM_CLK_FCC2:
-		reg = &im_cpmux->cmx_fcr;
-		shift = 16;
-		break;
-	case CPM_CLK_FCC3:
-		reg = &im_cpmux->cmx_fcr;
-		shift = 8;
-		break;
-	default:
-		printk(KERN_ERR "cpm2_clock_setup: invalid clock target\n");
-		return -EINVAL;
-	}
-
-	if (mode == CPM_CLK_RX)
-		shift += 3;
-
-	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
-		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
-			bits = clk_map[i][2];
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(clk_map))
-	    ret = -EINVAL;
-
-	bits <<= shift;
-	mask <<= shift;
-
-	out_be32(reg, (in_be32(reg) & ~mask) | bits);
-
-	cpm2_unmap(im_cpmux);
-	return ret;
-}
-
-int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
-{
-	int ret = 0;
-	int shift;
-	int i, bits = 0;
-	cpmux_t __iomem *im_cpmux;
-	u8 __iomem *reg;
-	u8 mask = 3;
-
-	u8 clk_map[][3] = {
-		{CPM_CLK_SMC1, CPM_BRG1, 0},
-		{CPM_CLK_SMC1, CPM_BRG7, 1},
-		{CPM_CLK_SMC1, CPM_CLK7, 2},
-		{CPM_CLK_SMC1, CPM_CLK9, 3},
-		{CPM_CLK_SMC2, CPM_BRG2, 0},
-		{CPM_CLK_SMC2, CPM_BRG8, 1},
-		{CPM_CLK_SMC2, CPM_CLK4, 2},
-		{CPM_CLK_SMC2, CPM_CLK15, 3},
-	};
-
-	im_cpmux = cpm2_map(im_cpmux);
-
-	switch (target) {
-	case CPM_CLK_SMC1:
-		reg = &im_cpmux->cmx_smr;
-		mask = 3;
-		shift = 4;
-		break;
-	case CPM_CLK_SMC2:
-		reg = &im_cpmux->cmx_smr;
-		mask = 3;
-		shift = 0;
-		break;
-	default:
-		printk(KERN_ERR "cpm2_smc_clock_setup: invalid clock target\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
-		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
-			bits = clk_map[i][2];
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(clk_map))
-	    ret = -EINVAL;
-
-	bits <<= shift;
-	mask <<= shift;
-
-	out_8(reg, (in_8(reg) & ~mask) | bits);
-
-	cpm2_unmap(im_cpmux);
-	return ret;
-}
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/*
- * dpalloc / dpfree bits.
- */
-static spinlock_t cpm_dpmem_lock;
-/* 16 blocks should be enough to satisfy all requests
- * until the memory subsystem goes up... */
-static rh_block_t cpm_boot_dpmem_rh_block[16];
-static rh_info_t cpm_dpmem_info;
-static u8 __iomem *im_dprambase;
-
-static void cpm2_dpinit(void)
-{
-	spin_lock_init(&cpm_dpmem_lock);
-
-	/* initialize the info header */
-	rh_init(&cpm_dpmem_info, 1,
-			sizeof(cpm_boot_dpmem_rh_block) /
-			sizeof(cpm_boot_dpmem_rh_block[0]),
-			cpm_boot_dpmem_rh_block);
-
-	im_dprambase = cpm2_immr;
-
-	/* Attach the usable dpmem area */
-	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
-	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
-	 * varies with the processor and the microcode patches activated.
-	 * But the following should be at least safe.
-	 */
-	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
-}
-
-/* This function returns an index into the DPRAM area.
- */
-unsigned long cpm_dpalloc(uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return (uint)start;
-}
-EXPORT_SYMBOL(cpm_dpalloc);
-
-int cpm_dpfree(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, offset);
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(cpm_dpfree);
-
-/* not sure if this is ever needed */
-unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_dpalloc_fixed);
-
-void cpm_dpdump(void)
-{
-	rh_dump(&cpm_dpmem_info);
-}
-EXPORT_SYMBOL(cpm_dpdump);
-
-void *cpm_dpram_addr(unsigned long offset)
-{
-	return (void *)(im_dprambase + offset);
-}
-EXPORT_SYMBOL(cpm_dpram_addr);
-#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
-
-struct cpm2_ioports {
-	u32 dir, par, sor, odr, dat;
-	u32 res[3];
-};
-
-void cpm2_set_pin(int port, int pin, int flags)
-{
-	struct cpm2_ioports __iomem *iop =
-		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
-
-	pin = 1 << (31 - pin);
-
-	if (flags & CPM_PIN_OUTPUT)
-		setbits32(&iop[port].dir, pin);
-	else
-		clrbits32(&iop[port].dir, pin);
-
-	if (!(flags & CPM_PIN_GPIO))
-		setbits32(&iop[port].par, pin);
-	else
-		clrbits32(&iop[port].par, pin);
-
-	if (flags & CPM_PIN_SECONDARY)
-		setbits32(&iop[port].sor, pin);
-	else
-		clrbits32(&iop[port].sor, pin);
-
-	if (flags & CPM_PIN_OPENDRAIN)
-		setbits32(&iop[port].odr, pin);
-	else
-		clrbits32(&iop[port].odr, pin);
-}
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
index 712b10a..d8d6028 100644
--- a/arch/powerpc/sysdev/micropatch.c
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -16,7 +16,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 /*
  * I2C/SPI relocation patch arrays.
diff --git a/arch/ppc/8260_io/enet.c b/arch/ppc/8260_io/enet.c
index 615b658..3ea4db2 100644
--- a/arch/ppc/8260_io/enet.c
+++ b/arch/ppc/8260_io/enet.c
@@ -10,7 +10,7 @@
  * This version of the driver is somewhat selectable for the different
  * processor/board combinations.  It works for the boards I know about
  * now, and should be easily modified to include others.  Some of the
- * configuration information is contained in <asm/commproc.h> and the
+ * configuration information is contained in <asm/cpm1.h> and the
  * remainder is here.
  *
  * Buffer descriptors are kept in the CPM dual port RAM, and the frame
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 3f93af8..9d656de 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -34,7 +34,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
index eace3bc..c6d047a 100644
--- a/arch/ppc/8xx_io/enet.c
+++ b/arch/ppc/8xx_io/enet.c
@@ -8,7 +8,7 @@
  * This version of the driver is somewhat selectable for the different
  * processor/board combinations.  It works for the boards I know about
  * now, and should be easily modified to include others.  Some of the
- * configuration information is contained in <asm/commproc.h> and the
+ * configuration information is contained in <asm/cpm1.h> and the
  * remainder is here.
  *
  * Buffer descriptors are kept in the CPM dual port RAM, and the frame
@@ -43,7 +43,7 @@
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
 #include <asm/uaccess.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/cacheflush.h>
 
 /*
@@ -80,7 +80,7 @@
  * programming documents for details unique to your board.
  *
  * For the TQM8xx(L) modules, there is no control register interface.
- * All functions are directly controlled using I/O pins.  See <asm/commproc.h>.
+ * All functions are directly controlled using I/O pins.  See <asm/cpm1.h>.
  */
 
 /* The transmitter timeout
diff --git a/arch/ppc/8xx_io/fec.c b/arch/ppc/8xx_io/fec.c
index 0288279..11b0aa6 100644
--- a/arch/ppc/8xx_io/fec.c
+++ b/arch/ppc/8xx_io/fec.c
@@ -53,7 +53,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 #ifdef	CONFIG_USE_MDIO
 /* Forward declarations of some structures to support different PHYs
diff --git a/arch/ppc/8xx_io/micropatch.c b/arch/ppc/8xx_io/micropatch.c
index cfad46b..9a5d95d 100644
--- a/arch/ppc/8xx_io/micropatch.c
+++ b/arch/ppc/8xx_io/micropatch.c
@@ -16,7 +16,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 /*
  * I2C/SPI relocation patch arrays.
diff --git a/arch/ppc/boot/simple/iic.c b/arch/ppc/boot/simple/iic.c
index e4efd83..5e91489 100644
--- a/arch/ppc/boot/simple/iic.c
+++ b/arch/ppc/boot/simple/iic.c
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <asm/uaccess.h>
 #include <asm/mpc8xx.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 
 /* IIC functions.
diff --git a/arch/ppc/boot/simple/m8xx_tty.c b/arch/ppc/boot/simple/m8xx_tty.c
index ea615d8..f28924e 100644
--- a/arch/ppc/boot/simple/m8xx_tty.c
+++ b/arch/ppc/boot/simple/m8xx_tty.c
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <asm/uaccess.h>
 #include <asm/mpc8xx.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 #ifdef CONFIG_MBX
 #define MBX_CSR1	((volatile u_char *)0xfa100000)
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 22494ec..0d53dc3 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -45,7 +45,7 @@
 #include <asm/dcr.h>
 
 #ifdef  CONFIG_8xx
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #endif
 
 extern void transfer_to_handler(void);
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index bf72204..62370f4 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -32,7 +32,7 @@
 #include <asm/time.h>
 #include <asm/ppcboot.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/ppc_sys.h>
 #include <asm/mpc8xx.h>
 
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index 87deaef..ba06cc0 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -31,7 +31,7 @@
 #include <asm/time.h>
 #include <asm/ppcboot.h>
 #include <asm/8xx_immap.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/ppc_sys.h>
 
 extern unsigned char __res[];
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
index c05ac87..80804ee 100644
--- a/arch/ppc/syslib/mpc8xx_devices.c
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -16,7 +16,7 @@
 #include <linux/device.h>
 #include <linux/serial_8250.h>
 #include <linux/mii.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/ppc_sys.h>
diff --git a/arch/ppc/xmon/start_8xx.c b/arch/ppc/xmon/start_8xx.c
index a48bd59..3097406 100644
--- a/arch/ppc/xmon/start_8xx.c
+++ b/arch/ppc/xmon/start_8xx.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 extern void xmon_printf(const char *fmt, ...);
 extern int xmon_8xx_write(char *str, int nb);
diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 0fbf1bb..0800cce 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -58,7 +58,7 @@
 #else
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
-#include "commproc.h"
+#include "cpm1.h"
 #endif
 
 #if defined(CONFIG_FEC2)
diff --git a/drivers/net/fec.h b/drivers/net/fec.h
index 1d42160..bcff463 100644
--- a/drivers/net/fec.h
+++ b/drivers/net/fec.h
@@ -111,7 +111,7 @@ typedef struct bufdesc {
 
 
 /*
- *	The following definitions courtesy of commproc.h, which where
+ *	The following definitions courtesy of cpm1.h, which where
  *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
  */
 #define BD_SC_EMPTY     ((ushort)0x8000)        /* Recieve is empty */
diff --git a/drivers/net/fec_8xx/fec_8xx-netta.c b/drivers/net/fec_8xx/fec_8xx-netta.c
index e492eb8..79deee2 100644
--- a/drivers/net/fec_8xx/fec_8xx-netta.c
+++ b/drivers/net/fec_8xx/fec_8xx-netta.c
@@ -26,7 +26,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 #include "fec_8xx.h"
 
diff --git a/drivers/net/fec_8xx/fec_main.c b/drivers/net/fec_8xx/fec_main.c
index 8d2904f..795e22e 100644
--- a/drivers/net/fec_8xx/fec_main.c
+++ b/drivers/net/fec_8xx/fec_main.c
@@ -35,7 +35,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 #include "fec_8xx.h"
 
diff --git a/drivers/net/fec_8xx/fec_mii.c b/drivers/net/fec_8xx/fec_mii.c
index e8e10a0..3b6ca29 100644
--- a/drivers/net/fec_8xx/fec_mii.c
+++ b/drivers/net/fec_8xx/fec_mii.c
@@ -34,7 +34,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 /*************************************************/
 
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index c675e29..e05389c 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -12,7 +12,7 @@
 #include <asm/fs_pd.h>
 
 #ifdef CONFIG_CPM1
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 struct fec_info {
 	fec_t __iomem *fecp;
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index c1fee48..8a311d1 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -40,7 +40,7 @@
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #endif
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 1502dbf..d3cda70 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -39,7 +39,7 @@
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #endif
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
diff --git a/drivers/serial/68360serial.c b/drivers/serial/68360serial.c
index 2aa6bfe..2969ebc 100644
--- a/drivers/serial/68360serial.c
+++ b/drivers/serial/68360serial.c
@@ -39,7 +39,7 @@
 #include <linux/delay.h>
 #include <asm/irq.h>
 #include <asm/m68360.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
  
 #ifdef CONFIG_KGDB
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index 9b5465f..ddf46d3 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -10,7 +10,7 @@
 #ifndef CPM_UART_CPM1_H
 #define CPM_UART_CPM1_H
 
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 
 /* defines for IRQs */
 #ifndef CONFIG_PPC_CPM_NEW_BINDING
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
deleted file mode 100644
index ec87b8f..0000000
--- a/include/asm-powerpc/commproc.h
+++ /dev/null
@@ -1,750 +0,0 @@
-/*
- * MPC8xx Communication Processor Module.
- * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
- *
- * This file contains structures and information for the communication
- * processor channels.  Some CPM control and status is available
- * throught the MPC8xx internal memory map.  See immap.h for details.
- * This file only contains what I need for the moment, not the total
- * CPM capabilities.  I (or someone else) will add definitions as they
- * are needed.  -- Dan
- *
- * On the MBX board, EPPC-Bug loads CPM microcode into the first 512
- * bytes of the DP RAM and relocates the I2C parameter area to the
- * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
- * or other use.
- */
-#ifndef __CPM_8XX__
-#define __CPM_8XX__
-
-#include <asm/8xx_immap.h>
-#include <asm/ptrace.h>
-#include <asm/cpm.h>
-
-/* CPM Command register.
-*/
-#define CPM_CR_RST	((ushort)0x8000)
-#define CPM_CR_OPCODE	((ushort)0x0f00)
-#define CPM_CR_CHAN	((ushort)0x00f0)
-#define CPM_CR_FLG	((ushort)0x0001)
-
-/* Some commands (there are more...later)
-*/
-#define CPM_CR_INIT_TRX		((ushort)0x0000)
-#define CPM_CR_INIT_RX		((ushort)0x0001)
-#define CPM_CR_INIT_TX		((ushort)0x0002)
-#define CPM_CR_HUNT_MODE	((ushort)0x0003)
-#define CPM_CR_STOP_TX		((ushort)0x0004)
-#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
-#define CPM_CR_RESTART_TX	((ushort)0x0006)
-#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
-#define CPM_CR_SET_GADDR	((ushort)0x0008)
-#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR
-
-/* Channel numbers.
-*/
-#define CPM_CR_CH_SCC1		((ushort)0x0000)
-#define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
-#define CPM_CR_CH_SCC2		((ushort)0x0004)
-#define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
-#define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
-#define CPM_CR_CH_SCC3		((ushort)0x0008)
-#define CPM_CR_CH_SMC1		((ushort)0x0009)	/* SMC1 / DSP1 */
-#define CPM_CR_CH_SCC4		((ushort)0x000c)
-#define CPM_CR_CH_SMC2		((ushort)0x000d)	/* SMC2 / DSP2 */
-
-#define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* The dual ported RAM is multi-functional.  Some areas can be (and are
- * being) used for microcode.  There is an area that can only be used
- * as data ram for buffer descriptors, which is all we use right now.
- * Currently the first 512 and last 256 bytes are used for microcode.
- */
-#define CPM_DATAONLY_BASE	((uint)0x0800)
-#define CPM_DATAONLY_SIZE	((uint)0x0700)
-#define CPM_DP_NOSPACE		((uint)0x7fffffff)
-#endif
-
-/* Export the base address of the communication processor registers
- * and dual port ram.
- */
-extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
-
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
-#define cpm_dpalloc cpm_muram_alloc
-#define cpm_dpfree cpm_muram_free
-#define cpm_dpram_addr cpm_muram_addr
-#define cpm_dpram_phys cpm_muram_dma
-#else
-extern unsigned long cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(unsigned long offset);
-extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
-extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(unsigned long offset);
-extern uint cpm_dpram_phys(u8* addr);
-#endif
-
-extern void cpm_setbrg(uint brg, uint rate);
-
-extern void cpm_load_patch(cpm8xx_t *cp);
-
-extern void cpm_reset(void);
-
-/* Buffer descriptors used by many of the CPM protocols.
-*/
-typedef struct cpm_buf_desc {
-	ushort	cbd_sc;		/* Status and Control */
-	ushort	cbd_datlen;	/* Data length in buffer */
-	uint	cbd_bufaddr;	/* Buffer address in host memory */
-} cbd_t;
-
-#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
-#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
-#define BD_SC_LAST	((ushort)0x0800)	/* Last buffer in frame */
-#define BD_SC_TC	((ushort)0x0400)	/* Transmit CRC */
-#define BD_SC_CM	((ushort)0x0200)	/* Continous mode */
-#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
-#define BD_SC_BR	((ushort)0x0020)	/* Break received */
-#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
-#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
-#define BD_SC_NAK	((ushort)0x0004)	/* NAK - did not respond */
-#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
-#define BD_SC_UN	((ushort)0x0002)	/* Underrun */
-#define BD_SC_CD	((ushort)0x0001)	/* ?? */
-#define BD_SC_CL	((ushort)0x0001)	/* Collision */
-
-/* Parameter RAM offsets.
-*/
-#define PROFF_SCC1	((uint)0x0000)
-#define PROFF_IIC	((uint)0x0080)
-#define PROFF_SCC2	((uint)0x0100)
-#define PROFF_SPI	((uint)0x0180)
-#define PROFF_SCC3	((uint)0x0200)
-#define PROFF_SMC1	((uint)0x0280)
-#define PROFF_SCC4	((uint)0x0300)
-#define PROFF_SMC2	((uint)0x0380)
-
-/* Define enough so I can at least use the serial port as a UART.
- * The MBX uses SMC1 as the host serial port.
- */
-typedef struct smc_uart {
-	ushort	smc_rbase;	/* Rx Buffer descriptor base address */
-	ushort	smc_tbase;	/* Tx Buffer descriptor base address */
-	u_char	smc_rfcr;	/* Rx function code */
-	u_char	smc_tfcr;	/* Tx function code */
-	ushort	smc_mrblr;	/* Max receive buffer length */
-	uint	smc_rstate;	/* Internal */
-	uint	smc_idp;	/* Internal */
-	ushort	smc_rbptr;	/* Internal */
-	ushort	smc_ibc;	/* Internal */
-	uint	smc_rxtmp;	/* Internal */
-	uint	smc_tstate;	/* Internal */
-	uint	smc_tdp;	/* Internal */
-	ushort	smc_tbptr;	/* Internal */
-	ushort	smc_tbc;	/* Internal */
-	uint	smc_txtmp;	/* Internal */
-	ushort	smc_maxidl;	/* Maximum idle characters */
-	ushort	smc_tmpidl;	/* Temporary idle counter */
-	ushort	smc_brklen;	/* Last received break length */
-	ushort	smc_brkec;	/* rcv'd break condition counter */
-	ushort	smc_brkcr;	/* xmt break count register */
-	ushort	smc_rmask;	/* Temporary bit mask */
-	char	res1[8];	/* Reserved */
-	ushort	smc_rpbase;	/* Relocation pointer */
-} smc_uart_t;
-
-/* Function code bits.
-*/
-#define SMC_EB	((u_char)0x10)	/* Set big endian byte order */
-
-/* SMC uart mode register.
-*/
-#define	SMCMR_REN	((ushort)0x0001)
-#define SMCMR_TEN	((ushort)0x0002)
-#define SMCMR_DM	((ushort)0x000c)
-#define SMCMR_SM_GCI	((ushort)0x0000)
-#define SMCMR_SM_UART	((ushort)0x0020)
-#define SMCMR_SM_TRANS	((ushort)0x0030)
-#define SMCMR_SM_MASK	((ushort)0x0030)
-#define SMCMR_PM_EVEN	((ushort)0x0100)	/* Even parity, else odd */
-#define SMCMR_REVD	SMCMR_PM_EVEN
-#define SMCMR_PEN	((ushort)0x0200)	/* Parity enable */
-#define SMCMR_BS	SMCMR_PEN
-#define SMCMR_SL	((ushort)0x0400)	/* Two stops, else one */
-#define SMCR_CLEN_MASK	((ushort)0x7800)	/* Character length */
-#define smcr_mk_clen(C)	(((C) << 11) & SMCR_CLEN_MASK)
-
-/* SMC2 as Centronics parallel printer.  It is half duplex, in that
- * it can only receive or transmit.  The parameter ram values for
- * each direction are either unique or properly overlap, so we can
- * include them in one structure.
- */
-typedef struct smc_centronics {
-	ushort	scent_rbase;
-	ushort	scent_tbase;
-	u_char	scent_cfcr;
-	u_char	scent_smask;
-	ushort	scent_mrblr;
-	uint	scent_rstate;
-	uint	scent_r_ptr;
-	ushort	scent_rbptr;
-	ushort	scent_r_cnt;
-	uint	scent_rtemp;
-	uint	scent_tstate;
-	uint	scent_t_ptr;
-	ushort	scent_tbptr;
-	ushort	scent_t_cnt;
-	uint	scent_ttemp;
-	ushort	scent_max_sl;
-	ushort	scent_sl_cnt;
-	ushort	scent_character1;
-	ushort	scent_character2;
-	ushort	scent_character3;
-	ushort	scent_character4;
-	ushort	scent_character5;
-	ushort	scent_character6;
-	ushort	scent_character7;
-	ushort	scent_character8;
-	ushort	scent_rccm;
-	ushort	scent_rccr;
-} smc_cent_t;
-
-/* Centronics Status Mask Register.
-*/
-#define SMC_CENT_F	((u_char)0x08)
-#define SMC_CENT_PE	((u_char)0x04)
-#define SMC_CENT_S	((u_char)0x02)
-
-/* SMC Event and Mask register.
-*/
-#define	SMCM_BRKE	((unsigned char)0x40)	/* When in UART Mode */
-#define	SMCM_BRK	((unsigned char)0x10)	/* When in UART Mode */
-#define	SMCM_TXE	((unsigned char)0x10)	/* When in Transparent Mode */
-#define	SMCM_BSY	((unsigned char)0x04)
-#define	SMCM_TX		((unsigned char)0x02)
-#define	SMCM_RX		((unsigned char)0x01)
-
-/* Baud rate generators.
-*/
-#define CPM_BRG_RST		((uint)0x00020000)
-#define CPM_BRG_EN		((uint)0x00010000)
-#define CPM_BRG_EXTC_INT	((uint)0x00000000)
-#define CPM_BRG_EXTC_CLK2	((uint)0x00004000)
-#define CPM_BRG_EXTC_CLK6	((uint)0x00008000)
-#define CPM_BRG_ATB		((uint)0x00002000)
-#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
-#define CPM_BRG_DIV16		((uint)0x00000001)
-
-/* SI Clock Route Register
-*/
-#define SICR_RCLK_SCC1_BRG1	((uint)0x00000000)
-#define SICR_TCLK_SCC1_BRG1	((uint)0x00000000)
-#define SICR_RCLK_SCC2_BRG2	((uint)0x00000800)
-#define SICR_TCLK_SCC2_BRG2	((uint)0x00000100)
-#define SICR_RCLK_SCC3_BRG3	((uint)0x00100000)
-#define SICR_TCLK_SCC3_BRG3	((uint)0x00020000)
-#define SICR_RCLK_SCC4_BRG4	((uint)0x18000000)
-#define SICR_TCLK_SCC4_BRG4	((uint)0x03000000)
-
-/* SCCs.
-*/
-#define SCC_GSMRH_IRP		((uint)0x00040000)
-#define SCC_GSMRH_GDE		((uint)0x00010000)
-#define SCC_GSMRH_TCRC_CCITT	((uint)0x00008000)
-#define SCC_GSMRH_TCRC_BISYNC	((uint)0x00004000)
-#define SCC_GSMRH_TCRC_HDLC	((uint)0x00000000)
-#define SCC_GSMRH_REVD		((uint)0x00002000)
-#define SCC_GSMRH_TRX		((uint)0x00001000)
-#define SCC_GSMRH_TTX		((uint)0x00000800)
-#define SCC_GSMRH_CDP		((uint)0x00000400)
-#define SCC_GSMRH_CTSP		((uint)0x00000200)
-#define SCC_GSMRH_CDS		((uint)0x00000100)
-#define SCC_GSMRH_CTSS		((uint)0x00000080)
-#define SCC_GSMRH_TFL		((uint)0x00000040)
-#define SCC_GSMRH_RFW		((uint)0x00000020)
-#define SCC_GSMRH_TXSY		((uint)0x00000010)
-#define SCC_GSMRH_SYNL16	((uint)0x0000000c)
-#define SCC_GSMRH_SYNL8		((uint)0x00000008)
-#define SCC_GSMRH_SYNL4		((uint)0x00000004)
-#define SCC_GSMRH_RTSM		((uint)0x00000002)
-#define SCC_GSMRH_RSYN		((uint)0x00000001)
-
-#define SCC_GSMRL_SIR		((uint)0x80000000)	/* SCC2 only */
-#define SCC_GSMRL_EDGE_NONE	((uint)0x60000000)
-#define SCC_GSMRL_EDGE_NEG	((uint)0x40000000)
-#define SCC_GSMRL_EDGE_POS	((uint)0x20000000)
-#define SCC_GSMRL_EDGE_BOTH	((uint)0x00000000)
-#define SCC_GSMRL_TCI		((uint)0x10000000)
-#define SCC_GSMRL_TSNC_3	((uint)0x0c000000)
-#define SCC_GSMRL_TSNC_4	((uint)0x08000000)
-#define SCC_GSMRL_TSNC_14	((uint)0x04000000)
-#define SCC_GSMRL_TSNC_INF	((uint)0x00000000)
-#define SCC_GSMRL_RINV		((uint)0x02000000)
-#define SCC_GSMRL_TINV		((uint)0x01000000)
-#define SCC_GSMRL_TPL_128	((uint)0x00c00000)
-#define SCC_GSMRL_TPL_64	((uint)0x00a00000)
-#define SCC_GSMRL_TPL_48	((uint)0x00800000)
-#define SCC_GSMRL_TPL_32	((uint)0x00600000)
-#define SCC_GSMRL_TPL_16	((uint)0x00400000)
-#define SCC_GSMRL_TPL_8		((uint)0x00200000)
-#define SCC_GSMRL_TPL_NONE	((uint)0x00000000)
-#define SCC_GSMRL_TPP_ALL1	((uint)0x00180000)
-#define SCC_GSMRL_TPP_01	((uint)0x00100000)
-#define SCC_GSMRL_TPP_10	((uint)0x00080000)
-#define SCC_GSMRL_TPP_ZEROS	((uint)0x00000000)
-#define SCC_GSMRL_TEND		((uint)0x00040000)
-#define SCC_GSMRL_TDCR_32	((uint)0x00030000)
-#define SCC_GSMRL_TDCR_16	((uint)0x00020000)
-#define SCC_GSMRL_TDCR_8	((uint)0x00010000)
-#define SCC_GSMRL_TDCR_1	((uint)0x00000000)
-#define SCC_GSMRL_RDCR_32	((uint)0x0000c000)
-#define SCC_GSMRL_RDCR_16	((uint)0x00008000)
-#define SCC_GSMRL_RDCR_8	((uint)0x00004000)
-#define SCC_GSMRL_RDCR_1	((uint)0x00000000)
-#define SCC_GSMRL_RENC_DFMAN	((uint)0x00003000)
-#define SCC_GSMRL_RENC_MANCH	((uint)0x00002000)
-#define SCC_GSMRL_RENC_FM0	((uint)0x00001000)
-#define SCC_GSMRL_RENC_NRZI	((uint)0x00000800)
-#define SCC_GSMRL_RENC_NRZ	((uint)0x00000000)
-#define SCC_GSMRL_TENC_DFMAN	((uint)0x00000600)
-#define SCC_GSMRL_TENC_MANCH	((uint)0x00000400)
-#define SCC_GSMRL_TENC_FM0	((uint)0x00000200)
-#define SCC_GSMRL_TENC_NRZI	((uint)0x00000100)
-#define SCC_GSMRL_TENC_NRZ	((uint)0x00000000)
-#define SCC_GSMRL_DIAG_LE	((uint)0x000000c0)	/* Loop and echo */
-#define SCC_GSMRL_DIAG_ECHO	((uint)0x00000080)
-#define SCC_GSMRL_DIAG_LOOP	((uint)0x00000040)
-#define SCC_GSMRL_DIAG_NORM	((uint)0x00000000)
-#define SCC_GSMRL_ENR		((uint)0x00000020)
-#define SCC_GSMRL_ENT		((uint)0x00000010)
-#define SCC_GSMRL_MODE_ENET	((uint)0x0000000c)
-#define SCC_GSMRL_MODE_QMC	((uint)0x0000000a)
-#define SCC_GSMRL_MODE_DDCMP	((uint)0x00000009)
-#define SCC_GSMRL_MODE_BISYNC	((uint)0x00000008)
-#define SCC_GSMRL_MODE_V14	((uint)0x00000007)
-#define SCC_GSMRL_MODE_AHDLC	((uint)0x00000006)
-#define SCC_GSMRL_MODE_PROFIBUS	((uint)0x00000005)
-#define SCC_GSMRL_MODE_UART	((uint)0x00000004)
-#define SCC_GSMRL_MODE_SS7	((uint)0x00000003)
-#define SCC_GSMRL_MODE_ATALK	((uint)0x00000002)
-#define SCC_GSMRL_MODE_HDLC	((uint)0x00000000)
-
-#define SCC_TODR_TOD		((ushort)0x8000)
-
-/* SCC Event and Mask register.
-*/
-#define	SCCM_TXE	((unsigned char)0x10)
-#define	SCCM_BSY	((unsigned char)0x04)
-#define	SCCM_TX		((unsigned char)0x02)
-#define	SCCM_RX		((unsigned char)0x01)
-
-typedef struct scc_param {
-	ushort	scc_rbase;	/* Rx Buffer descriptor base address */
-	ushort	scc_tbase;	/* Tx Buffer descriptor base address */
-	u_char	scc_rfcr;	/* Rx function code */
-	u_char	scc_tfcr;	/* Tx function code */
-	ushort	scc_mrblr;	/* Max receive buffer length */
-	uint	scc_rstate;	/* Internal */
-	uint	scc_idp;	/* Internal */
-	ushort	scc_rbptr;	/* Internal */
-	ushort	scc_ibc;	/* Internal */
-	uint	scc_rxtmp;	/* Internal */
-	uint	scc_tstate;	/* Internal */
-	uint	scc_tdp;	/* Internal */
-	ushort	scc_tbptr;	/* Internal */
-	ushort	scc_tbc;	/* Internal */
-	uint	scc_txtmp;	/* Internal */
-	uint	scc_rcrc;	/* Internal */
-	uint	scc_tcrc;	/* Internal */
-} sccp_t;
-
-/* Function code bits.
-*/
-#define SCC_EB	((u_char)0x10)	/* Set big endian byte order */
-
-/* CPM Ethernet through SCCx.
- */
-typedef struct scc_enet {
-	sccp_t	sen_genscc;
-	uint	sen_cpres;	/* Preset CRC */
-	uint	sen_cmask;	/* Constant mask for CRC */
-	uint	sen_crcec;	/* CRC Error counter */
-	uint	sen_alec;	/* alignment error counter */
-	uint	sen_disfc;	/* discard frame counter */
-	ushort	sen_pads;	/* Tx short frame pad character */
-	ushort	sen_retlim;	/* Retry limit threshold */
-	ushort	sen_retcnt;	/* Retry limit counter */
-	ushort	sen_maxflr;	/* maximum frame length register */
-	ushort	sen_minflr;	/* minimum frame length register */
-	ushort	sen_maxd1;	/* maximum DMA1 length */
-	ushort	sen_maxd2;	/* maximum DMA2 length */
-	ushort	sen_maxd;	/* Rx max DMA */
-	ushort	sen_dmacnt;	/* Rx DMA counter */
-	ushort	sen_maxb;	/* Max BD byte count */
-	ushort	sen_gaddr1;	/* Group address filter */
-	ushort	sen_gaddr2;
-	ushort	sen_gaddr3;
-	ushort	sen_gaddr4;
-	uint	sen_tbuf0data0;	/* Save area 0 - current frame */
-	uint	sen_tbuf0data1;	/* Save area 1 - current frame */
-	uint	sen_tbuf0rba;	/* Internal */
-	uint	sen_tbuf0crc;	/* Internal */
-	ushort	sen_tbuf0bcnt;	/* Internal */
-	ushort	sen_paddrh;	/* physical address (MSB) */
-	ushort	sen_paddrm;
-	ushort	sen_paddrl;	/* physical address (LSB) */
-	ushort	sen_pper;	/* persistence */
-	ushort	sen_rfbdptr;	/* Rx first BD pointer */
-	ushort	sen_tfbdptr;	/* Tx first BD pointer */
-	ushort	sen_tlbdptr;	/* Tx last BD pointer */
-	uint	sen_tbuf1data0;	/* Save area 0 - current frame */
-	uint	sen_tbuf1data1;	/* Save area 1 - current frame */
-	uint	sen_tbuf1rba;	/* Internal */
-	uint	sen_tbuf1crc;	/* Internal */
-	ushort	sen_tbuf1bcnt;	/* Internal */
-	ushort	sen_txlen;	/* Tx Frame length counter */
-	ushort	sen_iaddr1;	/* Individual address filter */
-	ushort	sen_iaddr2;
-	ushort	sen_iaddr3;
-	ushort	sen_iaddr4;
-	ushort	sen_boffcnt;	/* Backoff counter */
-
-	/* NOTE: Some versions of the manual have the following items
-	 * incorrectly documented.  Below is the proper order.
-	 */
-	ushort	sen_taddrh;	/* temp address (MSB) */
-	ushort	sen_taddrm;
-	ushort	sen_taddrl;	/* temp address (LSB) */
-} scc_enet_t;
-
-/* SCC Event register as used by Ethernet.
-*/
-#define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
-#define SCCE_ENET_TXE	((ushort)0x0010)	/* Transmit Error */
-#define SCCE_ENET_RXF	((ushort)0x0008)	/* Full frame received */
-#define SCCE_ENET_BSY	((ushort)0x0004)	/* All incoming buffers full */
-#define SCCE_ENET_TXB	((ushort)0x0002)	/* A buffer was transmitted */
-#define SCCE_ENET_RXB	((ushort)0x0001)	/* A buffer was received */
-
-/* SCC Mode Register (PMSR) as used by Ethernet.
-*/
-#define SCC_PSMR_HBC	((ushort)0x8000)	/* Enable heartbeat */
-#define SCC_PSMR_FC	((ushort)0x4000)	/* Force collision */
-#define SCC_PSMR_RSH	((ushort)0x2000)	/* Receive short frames */
-#define SCC_PSMR_IAM	((ushort)0x1000)	/* Check individual hash */
-#define SCC_PSMR_ENCRC	((ushort)0x0800)	/* Ethernet CRC mode */
-#define SCC_PSMR_PRO	((ushort)0x0200)	/* Promiscuous mode */
-#define SCC_PSMR_BRO	((ushort)0x0100)	/* Catch broadcast pkts */
-#define SCC_PSMR_SBT	((ushort)0x0080)	/* Special backoff timer */
-#define SCC_PSMR_LPB	((ushort)0x0040)	/* Set Loopback mode */
-#define SCC_PSMR_SIP	((ushort)0x0020)	/* Sample Input Pins */
-#define SCC_PSMR_LCW	((ushort)0x0010)	/* Late collision window */
-#define SCC_PSMR_NIB22	((ushort)0x000a)	/* Start frame search */
-#define SCC_PSMR_FDE	((ushort)0x0001)	/* Full duplex enable */
-
-/* Buffer descriptor control/status used by Ethernet receive.
-*/
-#define BD_ENET_RX_EMPTY	((ushort)0x8000)
-#define BD_ENET_RX_WRAP		((ushort)0x2000)
-#define BD_ENET_RX_INTR		((ushort)0x1000)
-#define BD_ENET_RX_LAST		((ushort)0x0800)
-#define BD_ENET_RX_FIRST	((ushort)0x0400)
-#define BD_ENET_RX_MISS		((ushort)0x0100)
-#define BD_ENET_RX_LG		((ushort)0x0020)
-#define BD_ENET_RX_NO		((ushort)0x0010)
-#define BD_ENET_RX_SH		((ushort)0x0008)
-#define BD_ENET_RX_CR		((ushort)0x0004)
-#define BD_ENET_RX_OV		((ushort)0x0002)
-#define BD_ENET_RX_CL		((ushort)0x0001)
-#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast */
-#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast */
-#define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */
-
-/* Buffer descriptor control/status used by Ethernet transmit.
-*/
-#define BD_ENET_TX_READY	((ushort)0x8000)
-#define BD_ENET_TX_PAD		((ushort)0x4000)
-#define BD_ENET_TX_WRAP		((ushort)0x2000)
-#define BD_ENET_TX_INTR		((ushort)0x1000)
-#define BD_ENET_TX_LAST		((ushort)0x0800)
-#define BD_ENET_TX_TC		((ushort)0x0400)
-#define BD_ENET_TX_DEF		((ushort)0x0200)
-#define BD_ENET_TX_HB		((ushort)0x0100)
-#define BD_ENET_TX_LC		((ushort)0x0080)
-#define BD_ENET_TX_RL		((ushort)0x0040)
-#define BD_ENET_TX_RCMASK	((ushort)0x003c)
-#define BD_ENET_TX_UN		((ushort)0x0002)
-#define BD_ENET_TX_CSL		((ushort)0x0001)
-#define BD_ENET_TX_STATS	((ushort)0x03ff)	/* All status bits */
-
-/* SCC as UART
-*/
-typedef struct scc_uart {
-	sccp_t	scc_genscc;
-	char	res1[8];	/* Reserved */
-	ushort	scc_maxidl;	/* Maximum idle chars */
-	ushort	scc_idlc;	/* temp idle counter */
-	ushort	scc_brkcr;	/* Break count register */
-	ushort	scc_parec;	/* receive parity error counter */
-	ushort	scc_frmec;	/* receive framing error counter */
-	ushort	scc_nosec;	/* receive noise counter */
-	ushort	scc_brkec;	/* receive break condition counter */
-	ushort	scc_brkln;	/* last received break length */
-	ushort	scc_uaddr1;	/* UART address character 1 */
-	ushort	scc_uaddr2;	/* UART address character 2 */
-	ushort	scc_rtemp;	/* Temp storage */
-	ushort	scc_toseq;	/* Transmit out of sequence char */
-	ushort	scc_char1;	/* control character 1 */
-	ushort	scc_char2;	/* control character 2 */
-	ushort	scc_char3;	/* control character 3 */
-	ushort	scc_char4;	/* control character 4 */
-	ushort	scc_char5;	/* control character 5 */
-	ushort	scc_char6;	/* control character 6 */
-	ushort	scc_char7;	/* control character 7 */
-	ushort	scc_char8;	/* control character 8 */
-	ushort	scc_rccm;	/* receive control character mask */
-	ushort	scc_rccr;	/* receive control character register */
-	ushort	scc_rlbc;	/* receive last break character */
-} scc_uart_t;
-
-/* SCC Event and Mask registers when it is used as a UART.
-*/
-#define UART_SCCM_GLR		((ushort)0x1000)
-#define UART_SCCM_GLT		((ushort)0x0800)
-#define UART_SCCM_AB		((ushort)0x0200)
-#define UART_SCCM_IDL		((ushort)0x0100)
-#define UART_SCCM_GRA		((ushort)0x0080)
-#define UART_SCCM_BRKE		((ushort)0x0040)
-#define UART_SCCM_BRKS		((ushort)0x0020)
-#define UART_SCCM_CCR		((ushort)0x0008)
-#define UART_SCCM_BSY		((ushort)0x0004)
-#define UART_SCCM_TX		((ushort)0x0002)
-#define UART_SCCM_RX		((ushort)0x0001)
-
-/* The SCC PMSR when used as a UART.
-*/
-#define SCU_PSMR_FLC		((ushort)0x8000)
-#define SCU_PSMR_SL		((ushort)0x4000)
-#define SCU_PSMR_CL		((ushort)0x3000)
-#define SCU_PSMR_UM		((ushort)0x0c00)
-#define SCU_PSMR_FRZ		((ushort)0x0200)
-#define SCU_PSMR_RZS		((ushort)0x0100)
-#define SCU_PSMR_SYN		((ushort)0x0080)
-#define SCU_PSMR_DRT		((ushort)0x0040)
-#define SCU_PSMR_PEN		((ushort)0x0010)
-#define SCU_PSMR_RPM		((ushort)0x000c)
-#define SCU_PSMR_REVP		((ushort)0x0008)
-#define SCU_PSMR_TPM		((ushort)0x0003)
-#define SCU_PSMR_TEVP		((ushort)0x0002)
-
-/* CPM Transparent mode SCC.
- */
-typedef struct scc_trans {
-	sccp_t	st_genscc;
-	uint	st_cpres;	/* Preset CRC */
-	uint	st_cmask;	/* Constant mask for CRC */
-} scc_trans_t;
-
-#define BD_SCC_TX_LAST		((ushort)0x0800)
-
-/* IIC parameter RAM.
-*/
-typedef struct iic {
-	ushort	iic_rbase;	/* Rx Buffer descriptor base address */
-	ushort	iic_tbase;	/* Tx Buffer descriptor base address */
-	u_char	iic_rfcr;	/* Rx function code */
-	u_char	iic_tfcr;	/* Tx function code */
-	ushort	iic_mrblr;	/* Max receive buffer length */
-	uint	iic_rstate;	/* Internal */
-	uint	iic_rdp;	/* Internal */
-	ushort	iic_rbptr;	/* Internal */
-	ushort	iic_rbc;	/* Internal */
-	uint	iic_rxtmp;	/* Internal */
-	uint	iic_tstate;	/* Internal */
-	uint	iic_tdp;	/* Internal */
-	ushort	iic_tbptr;	/* Internal */
-	ushort	iic_tbc;	/* Internal */
-	uint	iic_txtmp;	/* Internal */
-	char	res1[4];	/* Reserved */
-	ushort	iic_rpbase;	/* Relocation pointer */
-	char	res2[2];	/* Reserved */
-} iic_t;
-
-#define BD_IIC_START		((ushort)0x0400)
-
-/* SPI parameter RAM.
-*/
-typedef struct spi {
-	ushort	spi_rbase;	/* Rx Buffer descriptor base address */
-	ushort	spi_tbase;	/* Tx Buffer descriptor base address */
-	u_char	spi_rfcr;	/* Rx function code */
-	u_char	spi_tfcr;	/* Tx function code */
-	ushort	spi_mrblr;	/* Max receive buffer length */
-	uint	spi_rstate;	/* Internal */
-	uint	spi_rdp;	/* Internal */
-	ushort	spi_rbptr;	/* Internal */
-	ushort	spi_rbc;	/* Internal */
-	uint	spi_rxtmp;	/* Internal */
-	uint	spi_tstate;	/* Internal */
-	uint	spi_tdp;	/* Internal */
-	ushort	spi_tbptr;	/* Internal */
-	ushort	spi_tbc;	/* Internal */
-	uint	spi_txtmp;	/* Internal */
-	uint	spi_res;
-	ushort	spi_rpbase;	/* Relocation pointer */
-	ushort	spi_res2;
-} spi_t;
-
-/* SPI Mode register.
-*/
-#define SPMODE_LOOP	((ushort)0x4000)	/* Loopback */
-#define SPMODE_CI	((ushort)0x2000)	/* Clock Invert */
-#define SPMODE_CP	((ushort)0x1000)	/* Clock Phase */
-#define SPMODE_DIV16	((ushort)0x0800)	/* BRG/16 mode */
-#define SPMODE_REV	((ushort)0x0400)	/* Reversed Data */
-#define SPMODE_MSTR	((ushort)0x0200)	/* SPI Master */
-#define SPMODE_EN	((ushort)0x0100)	/* Enable */
-#define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
-#define SPMODE_LEN4	((ushort)0x0030)	/*  4 bits per char */
-#define SPMODE_LEN8	((ushort)0x0070)	/*  8 bits per char */
-#define SPMODE_LEN16	((ushort)0x00f0)	/* 16 bits per char */
-#define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
-
-/* SPIE fields */
-#define SPIE_MME	0x20
-#define SPIE_TXE	0x10
-#define SPIE_BSY	0x04
-#define SPIE_TXB	0x02
-#define SPIE_RXB	0x01
-
-/*
- * RISC Controller Configuration Register definitons
- */
-#define RCCR_TIME	0x8000			/* RISC Timer Enable */
-#define RCCR_TIMEP(t)	(((t) & 0x3F)<<8)	/* RISC Timer Period */
-#define RCCR_TIME_MASK	0x00FF			/* not RISC Timer related bits */
-
-/* RISC Timer Parameter RAM offset */
-#define PROFF_RTMR	((uint)0x01B0)
-
-typedef struct risc_timer_pram {
-	unsigned short	tm_base;	/* RISC Timer Table Base Address */
-	unsigned short	tm_ptr;		/* RISC Timer Table Pointer (internal) */
-	unsigned short	r_tmr;		/* RISC Timer Mode Register */
-	unsigned short	r_tmv;		/* RISC Timer Valid Register */
-	unsigned long	tm_cmd;		/* RISC Timer Command Register */
-	unsigned long	tm_cnt;		/* RISC Timer Internal Count */
-} rt_pram_t;
-
-/* Bits in RISC Timer Command Register */
-#define TM_CMD_VALID	0x80000000	/* Valid - Enables the timer */
-#define TM_CMD_RESTART	0x40000000	/* Restart - for automatic restart */
-#define TM_CMD_PWM	0x20000000	/* Run in Pulse Width Modulation Mode */
-#define TM_CMD_NUM(n)	(((n)&0xF)<<16)	/* Timer Number */
-#define TM_CMD_PERIOD(p) ((p)&0xFFFF)	/* Timer Period */
-
-/* CPM interrupts.  There are nearly 32 interrupts generated by CPM
- * channels or devices.  All of these are presented to the PPC core
- * as a single interrupt.  The CPM interrupt handler dispatches its
- * own handlers, in a similar fashion to the PPC core handler.  We
- * use the table as defined in the manuals (i.e. no special high
- * priority and SCC1 == SCCa, etc...).
- */
-#define CPMVEC_NR		32
-#define	CPMVEC_PIO_PC15		((ushort)0x1f)
-#define	CPMVEC_SCC1		((ushort)0x1e)
-#define	CPMVEC_SCC2		((ushort)0x1d)
-#define	CPMVEC_SCC3		((ushort)0x1c)
-#define	CPMVEC_SCC4		((ushort)0x1b)
-#define	CPMVEC_PIO_PC14		((ushort)0x1a)
-#define	CPMVEC_TIMER1		((ushort)0x19)
-#define	CPMVEC_PIO_PC13		((ushort)0x18)
-#define	CPMVEC_PIO_PC12		((ushort)0x17)
-#define	CPMVEC_SDMA_CB_ERR	((ushort)0x16)
-#define CPMVEC_IDMA1		((ushort)0x15)
-#define CPMVEC_IDMA2		((ushort)0x14)
-#define CPMVEC_TIMER2		((ushort)0x12)
-#define CPMVEC_RISCTIMER	((ushort)0x11)
-#define CPMVEC_I2C		((ushort)0x10)
-#define	CPMVEC_PIO_PC11		((ushort)0x0f)
-#define	CPMVEC_PIO_PC10		((ushort)0x0e)
-#define CPMVEC_TIMER3		((ushort)0x0c)
-#define	CPMVEC_PIO_PC9		((ushort)0x0b)
-#define	CPMVEC_PIO_PC8		((ushort)0x0a)
-#define	CPMVEC_PIO_PC7		((ushort)0x09)
-#define CPMVEC_TIMER4		((ushort)0x07)
-#define	CPMVEC_PIO_PC6		((ushort)0x06)
-#define	CPMVEC_SPI		((ushort)0x05)
-#define	CPMVEC_SMC1		((ushort)0x04)
-#define	CPMVEC_SMC2		((ushort)0x03)
-#define	CPMVEC_PIO_PC5		((ushort)0x02)
-#define	CPMVEC_PIO_PC4		((ushort)0x01)
-#define	CPMVEC_ERROR		((ushort)0x00)
-
-/* CPM interrupt configuration vector.
-*/
-#define	CICR_SCD_SCC4		((uint)0x00c00000)	/* SCC4 @ SCCd */
-#define	CICR_SCC_SCC3		((uint)0x00200000)	/* SCC3 @ SCCc */
-#define	CICR_SCB_SCC2		((uint)0x00040000)	/* SCC2 @ SCCb */
-#define	CICR_SCA_SCC1		((uint)0x00000000)	/* SCC1 @ SCCa */
-#define CICR_IRL_MASK		((uint)0x0000e000)	/* Core interrupt */
-#define CICR_HP_MASK		((uint)0x00001f00)	/* Hi-pri int. */
-#define CICR_IEN		((uint)0x00000080)	/* Int. enable */
-#define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
-
-#define IMAP_ADDR		(get_immrbase())
-
-#define CPM_PIN_INPUT     0
-#define CPM_PIN_OUTPUT    1
-#define CPM_PIN_PRIMARY   0
-#define CPM_PIN_SECONDARY 2
-#define CPM_PIN_GPIO      4
-#define CPM_PIN_OPENDRAIN 8
-
-enum cpm_port {
-	CPM_PORTA,
-	CPM_PORTB,
-	CPM_PORTC,
-	CPM_PORTD,
-	CPM_PORTE,
-};
-
-void cpm1_set_pin(enum cpm_port port, int pin, int flags);
-
-enum cpm_clk_dir {
-	CPM_CLK_RX,
-	CPM_CLK_TX,
-	CPM_CLK_RTX
-};
-
-enum cpm_clk_target {
-	CPM_CLK_SCC1,
-	CPM_CLK_SCC2,
-	CPM_CLK_SCC3,
-	CPM_CLK_SCC4,
-	CPM_CLK_SMC1,
-	CPM_CLK_SMC2,
-};
-
-enum cpm_clk {
-	CPM_BRG1,	/* Baud Rate Generator  1 */
-	CPM_BRG2,	/* Baud Rate Generator  2 */
-	CPM_BRG3,	/* Baud Rate Generator  3 */
-	CPM_BRG4,	/* Baud Rate Generator  4 */
-	CPM_CLK1,	/* Clock  1 */
-	CPM_CLK2,	/* Clock  2 */
-	CPM_CLK3,	/* Clock  3 */
-	CPM_CLK4,	/* Clock  4 */
-	CPM_CLK5,	/* Clock  5 */
-	CPM_CLK6,	/* Clock  6 */
-	CPM_CLK7,	/* Clock  7 */
-	CPM_CLK8,	/* Clock  8 */
-};
-
-int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode);
-
-#endif /* __CPM_8XX__ */
diff --git a/include/asm-powerpc/cpm1.h b/include/asm-powerpc/cpm1.h
new file mode 100644
index 0000000..901a00b
--- /dev/null
+++ b/include/asm-powerpc/cpm1.h
@@ -0,0 +1,750 @@
+/*
+ * MPC8xx Communication Processor Module.
+ * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+ *
+ * This file contains structures and information for the communication
+ * processor channels.  Some CPM control and status is available
+ * throught the MPC8xx internal memory map.  See immap.h for details.
+ * This file only contains what I need for the moment, not the total
+ * CPM capabilities.  I (or someone else) will add definitions as they
+ * are needed.  -- Dan
+ *
+ * On the MBX board, EPPC-Bug loads CPM microcode into the first 512
+ * bytes of the DP RAM and relocates the I2C parameter area to the
+ * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
+ * or other use.
+ */
+#ifndef __CPM1__
+#define __CPM1__
+
+#include <asm/8xx_immap.h>
+#include <asm/ptrace.h>
+#include <asm/cpm.h>
+
+/* CPM Command register.
+*/
+#define CPM_CR_RST	((ushort)0x8000)
+#define CPM_CR_OPCODE	((ushort)0x0f00)
+#define CPM_CR_CHAN	((ushort)0x00f0)
+#define CPM_CR_FLG	((ushort)0x0001)
+
+/* Some commands (there are more...later)
+*/
+#define CPM_CR_INIT_TRX		((ushort)0x0000)
+#define CPM_CR_INIT_RX		((ushort)0x0001)
+#define CPM_CR_INIT_TX		((ushort)0x0002)
+#define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_STOP_TX		((ushort)0x0004)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
+#define CPM_CR_RESTART_TX	((ushort)0x0006)
+#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
+#define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR
+
+/* Channel numbers.
+*/
+#define CPM_CR_CH_SCC1		((ushort)0x0000)
+#define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
+#define CPM_CR_CH_SCC2		((ushort)0x0004)
+#define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
+#define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
+#define CPM_CR_CH_SCC3		((ushort)0x0008)
+#define CPM_CR_CH_SMC1		((ushort)0x0009)	/* SMC1 / DSP1 */
+#define CPM_CR_CH_SCC4		((ushort)0x000c)
+#define CPM_CR_CH_SMC2		((ushort)0x000d)	/* SMC2 / DSP2 */
+
+#define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
+
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
+/* The dual ported RAM is multi-functional.  Some areas can be (and are
+ * being) used for microcode.  There is an area that can only be used
+ * as data ram for buffer descriptors, which is all we use right now.
+ * Currently the first 512 and last 256 bytes are used for microcode.
+ */
+#define CPM_DATAONLY_BASE	((uint)0x0800)
+#define CPM_DATAONLY_SIZE	((uint)0x0700)
+#define CPM_DP_NOSPACE		((uint)0x7fffffff)
+#endif
+
+/* Export the base address of the communication processor registers
+ * and dual port ram.
+ */
+extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#define cpm_dpalloc cpm_muram_alloc
+#define cpm_dpfree cpm_muram_free
+#define cpm_dpram_addr cpm_muram_addr
+#define cpm_dpram_phys cpm_muram_dma
+#else
+extern unsigned long cpm_dpalloc(uint size, uint align);
+extern int cpm_dpfree(unsigned long offset);
+extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
+extern void cpm_dpdump(void);
+extern void *cpm_dpram_addr(unsigned long offset);
+extern uint cpm_dpram_phys(u8 *addr);
+#endif
+
+extern void cpm_setbrg(uint brg, uint rate);
+
+extern void cpm_load_patch(cpm8xx_t *cp);
+
+extern void cpm_reset(void);
+
+/* Buffer descriptors used by many of the CPM protocols.
+*/
+typedef struct cpm_buf_desc {
+	ushort	cbd_sc;		/* Status and Control */
+	ushort	cbd_datlen;	/* Data length in buffer */
+	uint	cbd_bufaddr;	/* Buffer address in host memory */
+} cbd_t;
+
+#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
+#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
+#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
+#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
+#define BD_SC_LAST	((ushort)0x0800)	/* Last buffer in frame */
+#define BD_SC_TC	((ushort)0x0400)	/* Transmit CRC */
+#define BD_SC_CM	((ushort)0x0200)	/* Continous mode */
+#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
+#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
+#define BD_SC_BR	((ushort)0x0020)	/* Break received */
+#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
+#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
+#define BD_SC_NAK	((ushort)0x0004)	/* NAK - did not respond */
+#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
+#define BD_SC_UN	((ushort)0x0002)	/* Underrun */
+#define BD_SC_CD	((ushort)0x0001)	/* ?? */
+#define BD_SC_CL	((ushort)0x0001)	/* Collision */
+
+/* Parameter RAM offsets.
+*/
+#define PROFF_SCC1	((uint)0x0000)
+#define PROFF_IIC	((uint)0x0080)
+#define PROFF_SCC2	((uint)0x0100)
+#define PROFF_SPI	((uint)0x0180)
+#define PROFF_SCC3	((uint)0x0200)
+#define PROFF_SMC1	((uint)0x0280)
+#define PROFF_SCC4	((uint)0x0300)
+#define PROFF_SMC2	((uint)0x0380)
+
+/* Define enough so I can at least use the serial port as a UART.
+ * The MBX uses SMC1 as the host serial port.
+ */
+typedef struct smc_uart {
+	ushort	smc_rbase;	/* Rx Buffer descriptor base address */
+	ushort	smc_tbase;	/* Tx Buffer descriptor base address */
+	u_char	smc_rfcr;	/* Rx function code */
+	u_char	smc_tfcr;	/* Tx function code */
+	ushort	smc_mrblr;	/* Max receive buffer length */
+	uint	smc_rstate;	/* Internal */
+	uint	smc_idp;	/* Internal */
+	ushort	smc_rbptr;	/* Internal */
+	ushort	smc_ibc;	/* Internal */
+	uint	smc_rxtmp;	/* Internal */
+	uint	smc_tstate;	/* Internal */
+	uint	smc_tdp;	/* Internal */
+	ushort	smc_tbptr;	/* Internal */
+	ushort	smc_tbc;	/* Internal */
+	uint	smc_txtmp;	/* Internal */
+	ushort	smc_maxidl;	/* Maximum idle characters */
+	ushort	smc_tmpidl;	/* Temporary idle counter */
+	ushort	smc_brklen;	/* Last received break length */
+	ushort	smc_brkec;	/* rcv'd break condition counter */
+	ushort	smc_brkcr;	/* xmt break count register */
+	ushort	smc_rmask;	/* Temporary bit mask */
+	char	res1[8];	/* Reserved */
+	ushort	smc_rpbase;	/* Relocation pointer */
+} smc_uart_t;
+
+/* Function code bits.
+*/
+#define SMC_EB	((u_char)0x10)	/* Set big endian byte order */
+
+/* SMC uart mode register.
+*/
+#define	SMCMR_REN	((ushort)0x0001)
+#define SMCMR_TEN	((ushort)0x0002)
+#define SMCMR_DM	((ushort)0x000c)
+#define SMCMR_SM_GCI	((ushort)0x0000)
+#define SMCMR_SM_UART	((ushort)0x0020)
+#define SMCMR_SM_TRANS	((ushort)0x0030)
+#define SMCMR_SM_MASK	((ushort)0x0030)
+#define SMCMR_PM_EVEN	((ushort)0x0100)	/* Even parity, else odd */
+#define SMCMR_REVD	SMCMR_PM_EVEN
+#define SMCMR_PEN	((ushort)0x0200)	/* Parity enable */
+#define SMCMR_BS	SMCMR_PEN
+#define SMCMR_SL	((ushort)0x0400)	/* Two stops, else one */
+#define SMCR_CLEN_MASK	((ushort)0x7800)	/* Character length */
+#define smcr_mk_clen(C)	(((C) << 11) & SMCR_CLEN_MASK)
+
+/* SMC2 as Centronics parallel printer.  It is half duplex, in that
+ * it can only receive or transmit.  The parameter ram values for
+ * each direction are either unique or properly overlap, so we can
+ * include them in one structure.
+ */
+typedef struct smc_centronics {
+	ushort	scent_rbase;
+	ushort	scent_tbase;
+	u_char	scent_cfcr;
+	u_char	scent_smask;
+	ushort	scent_mrblr;
+	uint	scent_rstate;
+	uint	scent_r_ptr;
+	ushort	scent_rbptr;
+	ushort	scent_r_cnt;
+	uint	scent_rtemp;
+	uint	scent_tstate;
+	uint	scent_t_ptr;
+	ushort	scent_tbptr;
+	ushort	scent_t_cnt;
+	uint	scent_ttemp;
+	ushort	scent_max_sl;
+	ushort	scent_sl_cnt;
+	ushort	scent_character1;
+	ushort	scent_character2;
+	ushort	scent_character3;
+	ushort	scent_character4;
+	ushort	scent_character5;
+	ushort	scent_character6;
+	ushort	scent_character7;
+	ushort	scent_character8;
+	ushort	scent_rccm;
+	ushort	scent_rccr;
+} smc_cent_t;
+
+/* Centronics Status Mask Register.
+*/
+#define SMC_CENT_F	((u_char)0x08)
+#define SMC_CENT_PE	((u_char)0x04)
+#define SMC_CENT_S	((u_char)0x02)
+
+/* SMC Event and Mask register.
+*/
+#define	SMCM_BRKE	((unsigned char)0x40)	/* When in UART Mode */
+#define	SMCM_BRK	((unsigned char)0x10)	/* When in UART Mode */
+#define	SMCM_TXE	((unsigned char)0x10)	/* When in Transparent Mode */
+#define	SMCM_BSY	((unsigned char)0x04)
+#define	SMCM_TX		((unsigned char)0x02)
+#define	SMCM_RX		((unsigned char)0x01)
+
+/* Baud rate generators.
+*/
+#define CPM_BRG_RST		((uint)0x00020000)
+#define CPM_BRG_EN		((uint)0x00010000)
+#define CPM_BRG_EXTC_INT	((uint)0x00000000)
+#define CPM_BRG_EXTC_CLK2	((uint)0x00004000)
+#define CPM_BRG_EXTC_CLK6	((uint)0x00008000)
+#define CPM_BRG_ATB		((uint)0x00002000)
+#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
+#define CPM_BRG_DIV16		((uint)0x00000001)
+
+/* SI Clock Route Register
+*/
+#define SICR_RCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_TCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_RCLK_SCC2_BRG2	((uint)0x00000800)
+#define SICR_TCLK_SCC2_BRG2	((uint)0x00000100)
+#define SICR_RCLK_SCC3_BRG3	((uint)0x00100000)
+#define SICR_TCLK_SCC3_BRG3	((uint)0x00020000)
+#define SICR_RCLK_SCC4_BRG4	((uint)0x18000000)
+#define SICR_TCLK_SCC4_BRG4	((uint)0x03000000)
+
+/* SCCs.
+*/
+#define SCC_GSMRH_IRP		((uint)0x00040000)
+#define SCC_GSMRH_GDE		((uint)0x00010000)
+#define SCC_GSMRH_TCRC_CCITT	((uint)0x00008000)
+#define SCC_GSMRH_TCRC_BISYNC	((uint)0x00004000)
+#define SCC_GSMRH_TCRC_HDLC	((uint)0x00000000)
+#define SCC_GSMRH_REVD		((uint)0x00002000)
+#define SCC_GSMRH_TRX		((uint)0x00001000)
+#define SCC_GSMRH_TTX		((uint)0x00000800)
+#define SCC_GSMRH_CDP		((uint)0x00000400)
+#define SCC_GSMRH_CTSP		((uint)0x00000200)
+#define SCC_GSMRH_CDS		((uint)0x00000100)
+#define SCC_GSMRH_CTSS		((uint)0x00000080)
+#define SCC_GSMRH_TFL		((uint)0x00000040)
+#define SCC_GSMRH_RFW		((uint)0x00000020)
+#define SCC_GSMRH_TXSY		((uint)0x00000010)
+#define SCC_GSMRH_SYNL16	((uint)0x0000000c)
+#define SCC_GSMRH_SYNL8		((uint)0x00000008)
+#define SCC_GSMRH_SYNL4		((uint)0x00000004)
+#define SCC_GSMRH_RTSM		((uint)0x00000002)
+#define SCC_GSMRH_RSYN		((uint)0x00000001)
+
+#define SCC_GSMRL_SIR		((uint)0x80000000)	/* SCC2 only */
+#define SCC_GSMRL_EDGE_NONE	((uint)0x60000000)
+#define SCC_GSMRL_EDGE_NEG	((uint)0x40000000)
+#define SCC_GSMRL_EDGE_POS	((uint)0x20000000)
+#define SCC_GSMRL_EDGE_BOTH	((uint)0x00000000)
+#define SCC_GSMRL_TCI		((uint)0x10000000)
+#define SCC_GSMRL_TSNC_3	((uint)0x0c000000)
+#define SCC_GSMRL_TSNC_4	((uint)0x08000000)
+#define SCC_GSMRL_TSNC_14	((uint)0x04000000)
+#define SCC_GSMRL_TSNC_INF	((uint)0x00000000)
+#define SCC_GSMRL_RINV		((uint)0x02000000)
+#define SCC_GSMRL_TINV		((uint)0x01000000)
+#define SCC_GSMRL_TPL_128	((uint)0x00c00000)
+#define SCC_GSMRL_TPL_64	((uint)0x00a00000)
+#define SCC_GSMRL_TPL_48	((uint)0x00800000)
+#define SCC_GSMRL_TPL_32	((uint)0x00600000)
+#define SCC_GSMRL_TPL_16	((uint)0x00400000)
+#define SCC_GSMRL_TPL_8		((uint)0x00200000)
+#define SCC_GSMRL_TPL_NONE	((uint)0x00000000)
+#define SCC_GSMRL_TPP_ALL1	((uint)0x00180000)
+#define SCC_GSMRL_TPP_01	((uint)0x00100000)
+#define SCC_GSMRL_TPP_10	((uint)0x00080000)
+#define SCC_GSMRL_TPP_ZEROS	((uint)0x00000000)
+#define SCC_GSMRL_TEND		((uint)0x00040000)
+#define SCC_GSMRL_TDCR_32	((uint)0x00030000)
+#define SCC_GSMRL_TDCR_16	((uint)0x00020000)
+#define SCC_GSMRL_TDCR_8	((uint)0x00010000)
+#define SCC_GSMRL_TDCR_1	((uint)0x00000000)
+#define SCC_GSMRL_RDCR_32	((uint)0x0000c000)
+#define SCC_GSMRL_RDCR_16	((uint)0x00008000)
+#define SCC_GSMRL_RDCR_8	((uint)0x00004000)
+#define SCC_GSMRL_RDCR_1	((uint)0x00000000)
+#define SCC_GSMRL_RENC_DFMAN	((uint)0x00003000)
+#define SCC_GSMRL_RENC_MANCH	((uint)0x00002000)
+#define SCC_GSMRL_RENC_FM0	((uint)0x00001000)
+#define SCC_GSMRL_RENC_NRZI	((uint)0x00000800)
+#define SCC_GSMRL_RENC_NRZ	((uint)0x00000000)
+#define SCC_GSMRL_TENC_DFMAN	((uint)0x00000600)
+#define SCC_GSMRL_TENC_MANCH	((uint)0x00000400)
+#define SCC_GSMRL_TENC_FM0	((uint)0x00000200)
+#define SCC_GSMRL_TENC_NRZI	((uint)0x00000100)
+#define SCC_GSMRL_TENC_NRZ	((uint)0x00000000)
+#define SCC_GSMRL_DIAG_LE	((uint)0x000000c0)	/* Loop and echo */
+#define SCC_GSMRL_DIAG_ECHO	((uint)0x00000080)
+#define SCC_GSMRL_DIAG_LOOP	((uint)0x00000040)
+#define SCC_GSMRL_DIAG_NORM	((uint)0x00000000)
+#define SCC_GSMRL_ENR		((uint)0x00000020)
+#define SCC_GSMRL_ENT		((uint)0x00000010)
+#define SCC_GSMRL_MODE_ENET	((uint)0x0000000c)
+#define SCC_GSMRL_MODE_QMC	((uint)0x0000000a)
+#define SCC_GSMRL_MODE_DDCMP	((uint)0x00000009)
+#define SCC_GSMRL_MODE_BISYNC	((uint)0x00000008)
+#define SCC_GSMRL_MODE_V14	((uint)0x00000007)
+#define SCC_GSMRL_MODE_AHDLC	((uint)0x00000006)
+#define SCC_GSMRL_MODE_PROFIBUS	((uint)0x00000005)
+#define SCC_GSMRL_MODE_UART	((uint)0x00000004)
+#define SCC_GSMRL_MODE_SS7	((uint)0x00000003)
+#define SCC_GSMRL_MODE_ATALK	((uint)0x00000002)
+#define SCC_GSMRL_MODE_HDLC	((uint)0x00000000)
+
+#define SCC_TODR_TOD		((ushort)0x8000)
+
+/* SCC Event and Mask register.
+*/
+#define	SCCM_TXE	((unsigned char)0x10)
+#define	SCCM_BSY	((unsigned char)0x04)
+#define	SCCM_TX		((unsigned char)0x02)
+#define	SCCM_RX		((unsigned char)0x01)
+
+typedef struct scc_param {
+	ushort	scc_rbase;	/* Rx Buffer descriptor base address */
+	ushort	scc_tbase;	/* Tx Buffer descriptor base address */
+	u_char	scc_rfcr;	/* Rx function code */
+	u_char	scc_tfcr;	/* Tx function code */
+	ushort	scc_mrblr;	/* Max receive buffer length */
+	uint	scc_rstate;	/* Internal */
+	uint	scc_idp;	/* Internal */
+	ushort	scc_rbptr;	/* Internal */
+	ushort	scc_ibc;	/* Internal */
+	uint	scc_rxtmp;	/* Internal */
+	uint	scc_tstate;	/* Internal */
+	uint	scc_tdp;	/* Internal */
+	ushort	scc_tbptr;	/* Internal */
+	ushort	scc_tbc;	/* Internal */
+	uint	scc_txtmp;	/* Internal */
+	uint	scc_rcrc;	/* Internal */
+	uint	scc_tcrc;	/* Internal */
+} sccp_t;
+
+/* Function code bits.
+*/
+#define SCC_EB	((u_char)0x10)	/* Set big endian byte order */
+
+/* CPM Ethernet through SCCx.
+ */
+typedef struct scc_enet {
+	sccp_t	sen_genscc;
+	uint	sen_cpres;	/* Preset CRC */
+	uint	sen_cmask;	/* Constant mask for CRC */
+	uint	sen_crcec;	/* CRC Error counter */
+	uint	sen_alec;	/* alignment error counter */
+	uint	sen_disfc;	/* discard frame counter */
+	ushort	sen_pads;	/* Tx short frame pad character */
+	ushort	sen_retlim;	/* Retry limit threshold */
+	ushort	sen_retcnt;	/* Retry limit counter */
+	ushort	sen_maxflr;	/* maximum frame length register */
+	ushort	sen_minflr;	/* minimum frame length register */
+	ushort	sen_maxd1;	/* maximum DMA1 length */
+	ushort	sen_maxd2;	/* maximum DMA2 length */
+	ushort	sen_maxd;	/* Rx max DMA */
+	ushort	sen_dmacnt;	/* Rx DMA counter */
+	ushort	sen_maxb;	/* Max BD byte count */
+	ushort	sen_gaddr1;	/* Group address filter */
+	ushort	sen_gaddr2;
+	ushort	sen_gaddr3;
+	ushort	sen_gaddr4;
+	uint	sen_tbuf0data0;	/* Save area 0 - current frame */
+	uint	sen_tbuf0data1;	/* Save area 1 - current frame */
+	uint	sen_tbuf0rba;	/* Internal */
+	uint	sen_tbuf0crc;	/* Internal */
+	ushort	sen_tbuf0bcnt;	/* Internal */
+	ushort	sen_paddrh;	/* physical address (MSB) */
+	ushort	sen_paddrm;
+	ushort	sen_paddrl;	/* physical address (LSB) */
+	ushort	sen_pper;	/* persistence */
+	ushort	sen_rfbdptr;	/* Rx first BD pointer */
+	ushort	sen_tfbdptr;	/* Tx first BD pointer */
+	ushort	sen_tlbdptr;	/* Tx last BD pointer */
+	uint	sen_tbuf1data0;	/* Save area 0 - current frame */
+	uint	sen_tbuf1data1;	/* Save area 1 - current frame */
+	uint	sen_tbuf1rba;	/* Internal */
+	uint	sen_tbuf1crc;	/* Internal */
+	ushort	sen_tbuf1bcnt;	/* Internal */
+	ushort	sen_txlen;	/* Tx Frame length counter */
+	ushort	sen_iaddr1;	/* Individual address filter */
+	ushort	sen_iaddr2;
+	ushort	sen_iaddr3;
+	ushort	sen_iaddr4;
+	ushort	sen_boffcnt;	/* Backoff counter */
+
+	/* NOTE: Some versions of the manual have the following items
+	 * incorrectly documented.  Below is the proper order.
+	 */
+	ushort	sen_taddrh;	/* temp address (MSB) */
+	ushort	sen_taddrm;
+	ushort	sen_taddrl;	/* temp address (LSB) */
+} scc_enet_t;
+
+/* SCC Event register as used by Ethernet.
+*/
+#define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
+#define SCCE_ENET_TXE	((ushort)0x0010)	/* Transmit Error */
+#define SCCE_ENET_RXF	((ushort)0x0008)	/* Full frame received */
+#define SCCE_ENET_BSY	((ushort)0x0004)	/* All incoming buffers full */
+#define SCCE_ENET_TXB	((ushort)0x0002)	/* A buffer was transmitted */
+#define SCCE_ENET_RXB	((ushort)0x0001)	/* A buffer was received */
+
+/* SCC Mode Register (PMSR) as used by Ethernet.
+*/
+#define SCC_PSMR_HBC	((ushort)0x8000)	/* Enable heartbeat */
+#define SCC_PSMR_FC	((ushort)0x4000)	/* Force collision */
+#define SCC_PSMR_RSH	((ushort)0x2000)	/* Receive short frames */
+#define SCC_PSMR_IAM	((ushort)0x1000)	/* Check individual hash */
+#define SCC_PSMR_ENCRC	((ushort)0x0800)	/* Ethernet CRC mode */
+#define SCC_PSMR_PRO	((ushort)0x0200)	/* Promiscuous mode */
+#define SCC_PSMR_BRO	((ushort)0x0100)	/* Catch broadcast pkts */
+#define SCC_PSMR_SBT	((ushort)0x0080)	/* Special backoff timer */
+#define SCC_PSMR_LPB	((ushort)0x0040)	/* Set Loopback mode */
+#define SCC_PSMR_SIP	((ushort)0x0020)	/* Sample Input Pins */
+#define SCC_PSMR_LCW	((ushort)0x0010)	/* Late collision window */
+#define SCC_PSMR_NIB22	((ushort)0x000a)	/* Start frame search */
+#define SCC_PSMR_FDE	((ushort)0x0001)	/* Full duplex enable */
+
+/* Buffer descriptor control/status used by Ethernet receive.
+*/
+#define BD_ENET_RX_EMPTY	((ushort)0x8000)
+#define BD_ENET_RX_WRAP		((ushort)0x2000)
+#define BD_ENET_RX_INTR		((ushort)0x1000)
+#define BD_ENET_RX_LAST		((ushort)0x0800)
+#define BD_ENET_RX_FIRST	((ushort)0x0400)
+#define BD_ENET_RX_MISS		((ushort)0x0100)
+#define BD_ENET_RX_LG		((ushort)0x0020)
+#define BD_ENET_RX_NO		((ushort)0x0010)
+#define BD_ENET_RX_SH		((ushort)0x0008)
+#define BD_ENET_RX_CR		((ushort)0x0004)
+#define BD_ENET_RX_OV		((ushort)0x0002)
+#define BD_ENET_RX_CL		((ushort)0x0001)
+#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast */
+#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast */
+#define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */
+
+/* Buffer descriptor control/status used by Ethernet transmit.
+*/
+#define BD_ENET_TX_READY	((ushort)0x8000)
+#define BD_ENET_TX_PAD		((ushort)0x4000)
+#define BD_ENET_TX_WRAP		((ushort)0x2000)
+#define BD_ENET_TX_INTR		((ushort)0x1000)
+#define BD_ENET_TX_LAST		((ushort)0x0800)
+#define BD_ENET_TX_TC		((ushort)0x0400)
+#define BD_ENET_TX_DEF		((ushort)0x0200)
+#define BD_ENET_TX_HB		((ushort)0x0100)
+#define BD_ENET_TX_LC		((ushort)0x0080)
+#define BD_ENET_TX_RL		((ushort)0x0040)
+#define BD_ENET_TX_RCMASK	((ushort)0x003c)
+#define BD_ENET_TX_UN		((ushort)0x0002)
+#define BD_ENET_TX_CSL		((ushort)0x0001)
+#define BD_ENET_TX_STATS	((ushort)0x03ff)	/* All status bits */
+
+/* SCC as UART
+*/
+typedef struct scc_uart {
+	sccp_t	scc_genscc;
+	char	res1[8];	/* Reserved */
+	ushort	scc_maxidl;	/* Maximum idle chars */
+	ushort	scc_idlc;	/* temp idle counter */
+	ushort	scc_brkcr;	/* Break count register */
+	ushort	scc_parec;	/* receive parity error counter */
+	ushort	scc_frmec;	/* receive framing error counter */
+	ushort	scc_nosec;	/* receive noise counter */
+	ushort	scc_brkec;	/* receive break condition counter */
+	ushort	scc_brkln;	/* last received break length */
+	ushort	scc_uaddr1;	/* UART address character 1 */
+	ushort	scc_uaddr2;	/* UART address character 2 */
+	ushort	scc_rtemp;	/* Temp storage */
+	ushort	scc_toseq;	/* Transmit out of sequence char */
+	ushort	scc_char1;	/* control character 1 */
+	ushort	scc_char2;	/* control character 2 */
+	ushort	scc_char3;	/* control character 3 */
+	ushort	scc_char4;	/* control character 4 */
+	ushort	scc_char5;	/* control character 5 */
+	ushort	scc_char6;	/* control character 6 */
+	ushort	scc_char7;	/* control character 7 */
+	ushort	scc_char8;	/* control character 8 */
+	ushort	scc_rccm;	/* receive control character mask */
+	ushort	scc_rccr;	/* receive control character register */
+	ushort	scc_rlbc;	/* receive last break character */
+} scc_uart_t;
+
+/* SCC Event and Mask registers when it is used as a UART.
+*/
+#define UART_SCCM_GLR		((ushort)0x1000)
+#define UART_SCCM_GLT		((ushort)0x0800)
+#define UART_SCCM_AB		((ushort)0x0200)
+#define UART_SCCM_IDL		((ushort)0x0100)
+#define UART_SCCM_GRA		((ushort)0x0080)
+#define UART_SCCM_BRKE		((ushort)0x0040)
+#define UART_SCCM_BRKS		((ushort)0x0020)
+#define UART_SCCM_CCR		((ushort)0x0008)
+#define UART_SCCM_BSY		((ushort)0x0004)
+#define UART_SCCM_TX		((ushort)0x0002)
+#define UART_SCCM_RX		((ushort)0x0001)
+
+/* The SCC PMSR when used as a UART.
+*/
+#define SCU_PSMR_FLC		((ushort)0x8000)
+#define SCU_PSMR_SL		((ushort)0x4000)
+#define SCU_PSMR_CL		((ushort)0x3000)
+#define SCU_PSMR_UM		((ushort)0x0c00)
+#define SCU_PSMR_FRZ		((ushort)0x0200)
+#define SCU_PSMR_RZS		((ushort)0x0100)
+#define SCU_PSMR_SYN		((ushort)0x0080)
+#define SCU_PSMR_DRT		((ushort)0x0040)
+#define SCU_PSMR_PEN		((ushort)0x0010)
+#define SCU_PSMR_RPM		((ushort)0x000c)
+#define SCU_PSMR_REVP		((ushort)0x0008)
+#define SCU_PSMR_TPM		((ushort)0x0003)
+#define SCU_PSMR_TEVP		((ushort)0x0002)
+
+/* CPM Transparent mode SCC.
+ */
+typedef struct scc_trans {
+	sccp_t	st_genscc;
+	uint	st_cpres;	/* Preset CRC */
+	uint	st_cmask;	/* Constant mask for CRC */
+} scc_trans_t;
+
+#define BD_SCC_TX_LAST		((ushort)0x0800)
+
+/* IIC parameter RAM.
+*/
+typedef struct iic {
+	ushort	iic_rbase;	/* Rx Buffer descriptor base address */
+	ushort	iic_tbase;	/* Tx Buffer descriptor base address */
+	u_char	iic_rfcr;	/* Rx function code */
+	u_char	iic_tfcr;	/* Tx function code */
+	ushort	iic_mrblr;	/* Max receive buffer length */
+	uint	iic_rstate;	/* Internal */
+	uint	iic_rdp;	/* Internal */
+	ushort	iic_rbptr;	/* Internal */
+	ushort	iic_rbc;	/* Internal */
+	uint	iic_rxtmp;	/* Internal */
+	uint	iic_tstate;	/* Internal */
+	uint	iic_tdp;	/* Internal */
+	ushort	iic_tbptr;	/* Internal */
+	ushort	iic_tbc;	/* Internal */
+	uint	iic_txtmp;	/* Internal */
+	char	res1[4];	/* Reserved */
+	ushort	iic_rpbase;	/* Relocation pointer */
+	char	res2[2];	/* Reserved */
+} iic_t;
+
+#define BD_IIC_START		((ushort)0x0400)
+
+/* SPI parameter RAM.
+*/
+typedef struct spi {
+	ushort	spi_rbase;	/* Rx Buffer descriptor base address */
+	ushort	spi_tbase;	/* Tx Buffer descriptor base address */
+	u_char	spi_rfcr;	/* Rx function code */
+	u_char	spi_tfcr;	/* Tx function code */
+	ushort	spi_mrblr;	/* Max receive buffer length */
+	uint	spi_rstate;	/* Internal */
+	uint	spi_rdp;	/* Internal */
+	ushort	spi_rbptr;	/* Internal */
+	ushort	spi_rbc;	/* Internal */
+	uint	spi_rxtmp;	/* Internal */
+	uint	spi_tstate;	/* Internal */
+	uint	spi_tdp;	/* Internal */
+	ushort	spi_tbptr;	/* Internal */
+	ushort	spi_tbc;	/* Internal */
+	uint	spi_txtmp;	/* Internal */
+	uint	spi_res;
+	ushort	spi_rpbase;	/* Relocation pointer */
+	ushort	spi_res2;
+} spi_t;
+
+/* SPI Mode register.
+*/
+#define SPMODE_LOOP	((ushort)0x4000)	/* Loopback */
+#define SPMODE_CI	((ushort)0x2000)	/* Clock Invert */
+#define SPMODE_CP	((ushort)0x1000)	/* Clock Phase */
+#define SPMODE_DIV16	((ushort)0x0800)	/* BRG/16 mode */
+#define SPMODE_REV	((ushort)0x0400)	/* Reversed Data */
+#define SPMODE_MSTR	((ushort)0x0200)	/* SPI Master */
+#define SPMODE_EN	((ushort)0x0100)	/* Enable */
+#define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
+#define SPMODE_LEN4	((ushort)0x0030)	/*  4 bits per char */
+#define SPMODE_LEN8	((ushort)0x0070)	/*  8 bits per char */
+#define SPMODE_LEN16	((ushort)0x00f0)	/* 16 bits per char */
+#define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
+
+/* SPIE fields */
+#define SPIE_MME	0x20
+#define SPIE_TXE	0x10
+#define SPIE_BSY	0x04
+#define SPIE_TXB	0x02
+#define SPIE_RXB	0x01
+
+/*
+ * RISC Controller Configuration Register definitons
+ */
+#define RCCR_TIME	0x8000			/* RISC Timer Enable */
+#define RCCR_TIMEP(t)	(((t) & 0x3F)<<8)	/* RISC Timer Period */
+#define RCCR_TIME_MASK	0x00FF			/* not RISC Timer related bits */
+
+/* RISC Timer Parameter RAM offset */
+#define PROFF_RTMR	((uint)0x01B0)
+
+typedef struct risc_timer_pram {
+	unsigned short	tm_base;	/* RISC Timer Table Base Address */
+	unsigned short	tm_ptr;		/* RISC Timer Table Pointer (internal) */
+	unsigned short	r_tmr;		/* RISC Timer Mode Register */
+	unsigned short	r_tmv;		/* RISC Timer Valid Register */
+	unsigned long	tm_cmd;		/* RISC Timer Command Register */
+	unsigned long	tm_cnt;		/* RISC Timer Internal Count */
+} rt_pram_t;
+
+/* Bits in RISC Timer Command Register */
+#define TM_CMD_VALID	0x80000000	/* Valid - Enables the timer */
+#define TM_CMD_RESTART	0x40000000	/* Restart - for automatic restart */
+#define TM_CMD_PWM	0x20000000	/* Run in Pulse Width Modulation Mode */
+#define TM_CMD_NUM(n)	(((n)&0xF)<<16)	/* Timer Number */
+#define TM_CMD_PERIOD(p) ((p)&0xFFFF)	/* Timer Period */
+
+/* CPM interrupts.  There are nearly 32 interrupts generated by CPM
+ * channels or devices.  All of these are presented to the PPC core
+ * as a single interrupt.  The CPM interrupt handler dispatches its
+ * own handlers, in a similar fashion to the PPC core handler.  We
+ * use the table as defined in the manuals (i.e. no special high
+ * priority and SCC1 == SCCa, etc...).
+ */
+#define CPMVEC_NR		32
+#define	CPMVEC_PIO_PC15		((ushort)0x1f)
+#define	CPMVEC_SCC1		((ushort)0x1e)
+#define	CPMVEC_SCC2		((ushort)0x1d)
+#define	CPMVEC_SCC3		((ushort)0x1c)
+#define	CPMVEC_SCC4		((ushort)0x1b)
+#define	CPMVEC_PIO_PC14		((ushort)0x1a)
+#define	CPMVEC_TIMER1		((ushort)0x19)
+#define	CPMVEC_PIO_PC13		((ushort)0x18)
+#define	CPMVEC_PIO_PC12		((ushort)0x17)
+#define	CPMVEC_SDMA_CB_ERR	((ushort)0x16)
+#define CPMVEC_IDMA1		((ushort)0x15)
+#define CPMVEC_IDMA2		((ushort)0x14)
+#define CPMVEC_TIMER2		((ushort)0x12)
+#define CPMVEC_RISCTIMER	((ushort)0x11)
+#define CPMVEC_I2C		((ushort)0x10)
+#define	CPMVEC_PIO_PC11		((ushort)0x0f)
+#define	CPMVEC_PIO_PC10		((ushort)0x0e)
+#define CPMVEC_TIMER3		((ushort)0x0c)
+#define	CPMVEC_PIO_PC9		((ushort)0x0b)
+#define	CPMVEC_PIO_PC8		((ushort)0x0a)
+#define	CPMVEC_PIO_PC7		((ushort)0x09)
+#define CPMVEC_TIMER4		((ushort)0x07)
+#define	CPMVEC_PIO_PC6		((ushort)0x06)
+#define	CPMVEC_SPI		((ushort)0x05)
+#define	CPMVEC_SMC1		((ushort)0x04)
+#define	CPMVEC_SMC2		((ushort)0x03)
+#define	CPMVEC_PIO_PC5		((ushort)0x02)
+#define	CPMVEC_PIO_PC4		((ushort)0x01)
+#define	CPMVEC_ERROR		((ushort)0x00)
+
+/* CPM interrupt configuration vector.
+*/
+#define	CICR_SCD_SCC4		((uint)0x00c00000)	/* SCC4 @ SCCd */
+#define	CICR_SCC_SCC3		((uint)0x00200000)	/* SCC3 @ SCCc */
+#define	CICR_SCB_SCC2		((uint)0x00040000)	/* SCC2 @ SCCb */
+#define	CICR_SCA_SCC1		((uint)0x00000000)	/* SCC1 @ SCCa */
+#define CICR_IRL_MASK		((uint)0x0000e000)	/* Core interrupt */
+#define CICR_HP_MASK		((uint)0x00001f00)	/* Hi-pri int. */
+#define CICR_IEN		((uint)0x00000080)	/* Int. enable */
+#define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
+
+#define IMAP_ADDR		(get_immrbase())
+
+#define CPM_PIN_INPUT     0
+#define CPM_PIN_OUTPUT    1
+#define CPM_PIN_PRIMARY   0
+#define CPM_PIN_SECONDARY 2
+#define CPM_PIN_GPIO      4
+#define CPM_PIN_OPENDRAIN 8
+
+enum cpm_port {
+	CPM_PORTA,
+	CPM_PORTB,
+	CPM_PORTC,
+	CPM_PORTD,
+	CPM_PORTE,
+};
+
+void cpm1_set_pin(enum cpm_port port, int pin, int flags);
+
+enum cpm_clk_dir {
+	CPM_CLK_RX,
+	CPM_CLK_TX,
+	CPM_CLK_RTX
+};
+
+enum cpm_clk_target {
+	CPM_CLK_SCC1,
+	CPM_CLK_SCC2,
+	CPM_CLK_SCC3,
+	CPM_CLK_SCC4,
+	CPM_CLK_SMC1,
+	CPM_CLK_SMC2,
+};
+
+enum cpm_clk {
+	CPM_BRG1,	/* Baud Rate Generator  1 */
+	CPM_BRG2,	/* Baud Rate Generator  2 */
+	CPM_BRG3,	/* Baud Rate Generator  3 */
+	CPM_BRG4,	/* Baud Rate Generator  4 */
+	CPM_CLK1,	/* Clock  1 */
+	CPM_CLK2,	/* Clock  2 */
+	CPM_CLK3,	/* Clock  3 */
+	CPM_CLK4,	/* Clock  4 */
+	CPM_CLK5,	/* Clock  5 */
+	CPM_CLK6,	/* Clock  6 */
+	CPM_CLK7,	/* Clock  7 */
+	CPM_CLK8,	/* Clock  8 */
+};
+
+int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode);
+
+#endif /* __CPM1__ */
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
deleted file mode 100644
index 5418d6d..0000000
--- a/include/asm-ppc/commproc.h
+++ /dev/null
@@ -1,688 +0,0 @@
-/*
- * MPC8xx Communication Processor Module.
- * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
- *
- * This file contains structures and information for the communication
- * processor channels.  Some CPM control and status is available
- * throught the MPC8xx internal memory map.  See immap.h for details.
- * This file only contains what I need for the moment, not the total
- * CPM capabilities.  I (or someone else) will add definitions as they
- * are needed.  -- Dan
- *
- * On the MBX board, EPPC-Bug loads CPM microcode into the first 512
- * bytes of the DP RAM and relocates the I2C parameter area to the
- * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
- * or other use.
- */
-#ifndef __CPM_8XX__
-#define __CPM_8XX__
-
-#include <asm/8xx_immap.h>
-#include <asm/ptrace.h>
-
-/* CPM Command register.
-*/
-#define CPM_CR_RST	((ushort)0x8000)
-#define CPM_CR_OPCODE	((ushort)0x0f00)
-#define CPM_CR_CHAN	((ushort)0x00f0)
-#define CPM_CR_FLG	((ushort)0x0001)
-
-/* Some commands (there are more...later)
-*/
-#define CPM_CR_INIT_TRX		((ushort)0x0000)
-#define CPM_CR_INIT_RX		((ushort)0x0001)
-#define CPM_CR_INIT_TX		((ushort)0x0002)
-#define CPM_CR_HUNT_MODE	((ushort)0x0003)
-#define CPM_CR_STOP_TX		((ushort)0x0004)
-#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
-#define CPM_CR_RESTART_TX	((ushort)0x0006)
-#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
-#define CPM_CR_SET_GADDR	((ushort)0x0008)
-#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR
-
-/* Channel numbers.
-*/
-#define CPM_CR_CH_SCC1		((ushort)0x0000)
-#define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
-#define CPM_CR_CH_SCC2		((ushort)0x0004)
-#define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
-#define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
-#define CPM_CR_CH_SCC3		((ushort)0x0008)
-#define CPM_CR_CH_SMC1		((ushort)0x0009)	/* SMC1 / DSP1 */
-#define CPM_CR_CH_SCC4		((ushort)0x000c)
-#define CPM_CR_CH_SMC2		((ushort)0x000d)	/* SMC2 / DSP2 */
-
-#define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
-
-/* The dual ported RAM is multi-functional.  Some areas can be (and are
- * being) used for microcode.  There is an area that can only be used
- * as data ram for buffer descriptors, which is all we use right now.
- * Currently the first 512 and last 256 bytes are used for microcode.
- */
-#define CPM_DATAONLY_BASE	((uint)0x0800)
-#define CPM_DATAONLY_SIZE	((uint)0x0700)
-#define CPM_DP_NOSPACE		((uint)0x7fffffff)
-
-/* Export the base address of the communication processor registers
- * and dual port ram.
- */
-extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
-extern unsigned long cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(unsigned long offset);
-extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
-extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(unsigned long offset);
-extern uint cpm_dpram_phys(u8* addr);
-extern void cpm_setbrg(uint brg, uint rate);
-
-extern void cpm_load_patch(volatile immap_t *immr);
-
-/* Buffer descriptors used by many of the CPM protocols.
-*/
-typedef struct cpm_buf_desc {
-	ushort	cbd_sc;		/* Status and Control */
-	ushort	cbd_datlen;	/* Data length in buffer */
-	uint	cbd_bufaddr;	/* Buffer address in host memory */
-} cbd_t;
-
-#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
-#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
-#define BD_SC_LAST	((ushort)0x0800)	/* Last buffer in frame */
-#define BD_SC_TC	((ushort)0x0400)	/* Transmit CRC */
-#define BD_SC_CM	((ushort)0x0200)	/* Continous mode */
-#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
-#define BD_SC_BR	((ushort)0x0020)	/* Break received */
-#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
-#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
-#define BD_SC_NAK	((ushort)0x0004)	/* NAK - did not respond */
-#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
-#define BD_SC_UN	((ushort)0x0002)	/* Underrun */
-#define BD_SC_CD	((ushort)0x0001)	/* ?? */
-#define BD_SC_CL	((ushort)0x0001)	/* Collision */
-
-/* Parameter RAM offsets.
-*/
-#define PROFF_SCC1	((uint)0x0000)
-#define PROFF_IIC	((uint)0x0080)
-#define PROFF_SCC2	((uint)0x0100)
-#define PROFF_SPI	((uint)0x0180)
-#define PROFF_SCC3	((uint)0x0200)
-#define PROFF_SMC1	((uint)0x0280)
-#define PROFF_SCC4	((uint)0x0300)
-#define PROFF_SMC2	((uint)0x0380)
-
-/* Define enough so I can at least use the serial port as a UART.
- * The MBX uses SMC1 as the host serial port.
- */
-typedef struct smc_uart {
-	ushort	smc_rbase;	/* Rx Buffer descriptor base address */
-	ushort	smc_tbase;	/* Tx Buffer descriptor base address */
-	u_char	smc_rfcr;	/* Rx function code */
-	u_char	smc_tfcr;	/* Tx function code */
-	ushort	smc_mrblr;	/* Max receive buffer length */
-	uint	smc_rstate;	/* Internal */
-	uint	smc_idp;	/* Internal */
-	ushort	smc_rbptr;	/* Internal */
-	ushort	smc_ibc;	/* Internal */
-	uint	smc_rxtmp;	/* Internal */
-	uint	smc_tstate;	/* Internal */
-	uint	smc_tdp;	/* Internal */
-	ushort	smc_tbptr;	/* Internal */
-	ushort	smc_tbc;	/* Internal */
-	uint	smc_txtmp;	/* Internal */
-	ushort	smc_maxidl;	/* Maximum idle characters */
-	ushort	smc_tmpidl;	/* Temporary idle counter */
-	ushort	smc_brklen;	/* Last received break length */
-	ushort	smc_brkec;	/* rcv'd break condition counter */
-	ushort	smc_brkcr;	/* xmt break count register */
-	ushort	smc_rmask;	/* Temporary bit mask */
-	char	res1[8];	/* Reserved */
-	ushort	smc_rpbase;	/* Relocation pointer */
-} smc_uart_t;
-
-/* Function code bits.
-*/
-#define SMC_EB	((u_char)0x10)	/* Set big endian byte order */
-
-/* SMC uart mode register.
-*/
-#define	SMCMR_REN	((ushort)0x0001)
-#define SMCMR_TEN	((ushort)0x0002)
-#define SMCMR_DM	((ushort)0x000c)
-#define SMCMR_SM_GCI	((ushort)0x0000)
-#define SMCMR_SM_UART	((ushort)0x0020)
-#define SMCMR_SM_TRANS	((ushort)0x0030)
-#define SMCMR_SM_MASK	((ushort)0x0030)
-#define SMCMR_PM_EVEN	((ushort)0x0100)	/* Even parity, else odd */
-#define SMCMR_REVD	SMCMR_PM_EVEN
-#define SMCMR_PEN	((ushort)0x0200)	/* Parity enable */
-#define SMCMR_BS	SMCMR_PEN
-#define SMCMR_SL	((ushort)0x0400)	/* Two stops, else one */
-#define SMCR_CLEN_MASK	((ushort)0x7800)	/* Character length */
-#define smcr_mk_clen(C)	(((C) << 11) & SMCR_CLEN_MASK)
-
-/* SMC2 as Centronics parallel printer.  It is half duplex, in that
- * it can only receive or transmit.  The parameter ram values for
- * each direction are either unique or properly overlap, so we can
- * include them in one structure.
- */
-typedef struct smc_centronics {
-	ushort	scent_rbase;
-	ushort	scent_tbase;
-	u_char	scent_cfcr;
-	u_char	scent_smask;
-	ushort	scent_mrblr;
-	uint	scent_rstate;
-	uint	scent_r_ptr;
-	ushort	scent_rbptr;
-	ushort	scent_r_cnt;
-	uint	scent_rtemp;
-	uint	scent_tstate;
-	uint	scent_t_ptr;
-	ushort	scent_tbptr;
-	ushort	scent_t_cnt;
-	uint	scent_ttemp;
-	ushort	scent_max_sl;
-	ushort	scent_sl_cnt;
-	ushort	scent_character1;
-	ushort	scent_character2;
-	ushort	scent_character3;
-	ushort	scent_character4;
-	ushort	scent_character5;
-	ushort	scent_character6;
-	ushort	scent_character7;
-	ushort	scent_character8;
-	ushort	scent_rccm;
-	ushort	scent_rccr;
-} smc_cent_t;
-
-/* Centronics Status Mask Register.
-*/
-#define SMC_CENT_F	((u_char)0x08)
-#define SMC_CENT_PE	((u_char)0x04)
-#define SMC_CENT_S	((u_char)0x02)
-
-/* SMC Event and Mask register.
-*/
-#define	SMCM_BRKE	((unsigned char)0x40)	/* When in UART Mode */
-#define	SMCM_BRK	((unsigned char)0x10)	/* When in UART Mode */
-#define	SMCM_TXE	((unsigned char)0x10)	/* When in Transparent Mode */
-#define	SMCM_BSY	((unsigned char)0x04)
-#define	SMCM_TX		((unsigned char)0x02)
-#define	SMCM_RX		((unsigned char)0x01)
-
-/* Baud rate generators.
-*/
-#define CPM_BRG_RST		((uint)0x00020000)
-#define CPM_BRG_EN		((uint)0x00010000)
-#define CPM_BRG_EXTC_INT	((uint)0x00000000)
-#define CPM_BRG_EXTC_CLK2	((uint)0x00004000)
-#define CPM_BRG_EXTC_CLK6	((uint)0x00008000)
-#define CPM_BRG_ATB		((uint)0x00002000)
-#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
-#define CPM_BRG_DIV16		((uint)0x00000001)
-
-/* SI Clock Route Register
-*/
-#define SICR_RCLK_SCC1_BRG1	((uint)0x00000000)
-#define SICR_TCLK_SCC1_BRG1	((uint)0x00000000)
-#define SICR_RCLK_SCC2_BRG2	((uint)0x00000800)
-#define SICR_TCLK_SCC2_BRG2	((uint)0x00000100)
-#define SICR_RCLK_SCC3_BRG3	((uint)0x00100000)
-#define SICR_TCLK_SCC3_BRG3	((uint)0x00020000)
-#define SICR_RCLK_SCC4_BRG4	((uint)0x18000000)
-#define SICR_TCLK_SCC4_BRG4	((uint)0x03000000)
-
-/* SCCs.
-*/
-#define SCC_GSMRH_IRP		((uint)0x00040000)
-#define SCC_GSMRH_GDE		((uint)0x00010000)
-#define SCC_GSMRH_TCRC_CCITT	((uint)0x00008000)
-#define SCC_GSMRH_TCRC_BISYNC	((uint)0x00004000)
-#define SCC_GSMRH_TCRC_HDLC	((uint)0x00000000)
-#define SCC_GSMRH_REVD		((uint)0x00002000)
-#define SCC_GSMRH_TRX		((uint)0x00001000)
-#define SCC_GSMRH_TTX		((uint)0x00000800)
-#define SCC_GSMRH_CDP		((uint)0x00000400)
-#define SCC_GSMRH_CTSP		((uint)0x00000200)
-#define SCC_GSMRH_CDS		((uint)0x00000100)
-#define SCC_GSMRH_CTSS		((uint)0x00000080)
-#define SCC_GSMRH_TFL		((uint)0x00000040)
-#define SCC_GSMRH_RFW		((uint)0x00000020)
-#define SCC_GSMRH_TXSY		((uint)0x00000010)
-#define SCC_GSMRH_SYNL16	((uint)0x0000000c)
-#define SCC_GSMRH_SYNL8		((uint)0x00000008)
-#define SCC_GSMRH_SYNL4		((uint)0x00000004)
-#define SCC_GSMRH_RTSM		((uint)0x00000002)
-#define SCC_GSMRH_RSYN		((uint)0x00000001)
-
-#define SCC_GSMRL_SIR		((uint)0x80000000)	/* SCC2 only */
-#define SCC_GSMRL_EDGE_NONE	((uint)0x60000000)
-#define SCC_GSMRL_EDGE_NEG	((uint)0x40000000)
-#define SCC_GSMRL_EDGE_POS	((uint)0x20000000)
-#define SCC_GSMRL_EDGE_BOTH	((uint)0x00000000)
-#define SCC_GSMRL_TCI		((uint)0x10000000)
-#define SCC_GSMRL_TSNC_3	((uint)0x0c000000)
-#define SCC_GSMRL_TSNC_4	((uint)0x08000000)
-#define SCC_GSMRL_TSNC_14	((uint)0x04000000)
-#define SCC_GSMRL_TSNC_INF	((uint)0x00000000)
-#define SCC_GSMRL_RINV		((uint)0x02000000)
-#define SCC_GSMRL_TINV		((uint)0x01000000)
-#define SCC_GSMRL_TPL_128	((uint)0x00c00000)
-#define SCC_GSMRL_TPL_64	((uint)0x00a00000)
-#define SCC_GSMRL_TPL_48	((uint)0x00800000)
-#define SCC_GSMRL_TPL_32	((uint)0x00600000)
-#define SCC_GSMRL_TPL_16	((uint)0x00400000)
-#define SCC_GSMRL_TPL_8		((uint)0x00200000)
-#define SCC_GSMRL_TPL_NONE	((uint)0x00000000)
-#define SCC_GSMRL_TPP_ALL1	((uint)0x00180000)
-#define SCC_GSMRL_TPP_01	((uint)0x00100000)
-#define SCC_GSMRL_TPP_10	((uint)0x00080000)
-#define SCC_GSMRL_TPP_ZEROS	((uint)0x00000000)
-#define SCC_GSMRL_TEND		((uint)0x00040000)
-#define SCC_GSMRL_TDCR_32	((uint)0x00030000)
-#define SCC_GSMRL_TDCR_16	((uint)0x00020000)
-#define SCC_GSMRL_TDCR_8	((uint)0x00010000)
-#define SCC_GSMRL_TDCR_1	((uint)0x00000000)
-#define SCC_GSMRL_RDCR_32	((uint)0x0000c000)
-#define SCC_GSMRL_RDCR_16	((uint)0x00008000)
-#define SCC_GSMRL_RDCR_8	((uint)0x00004000)
-#define SCC_GSMRL_RDCR_1	((uint)0x00000000)
-#define SCC_GSMRL_RENC_DFMAN	((uint)0x00003000)
-#define SCC_GSMRL_RENC_MANCH	((uint)0x00002000)
-#define SCC_GSMRL_RENC_FM0	((uint)0x00001000)
-#define SCC_GSMRL_RENC_NRZI	((uint)0x00000800)
-#define SCC_GSMRL_RENC_NRZ	((uint)0x00000000)
-#define SCC_GSMRL_TENC_DFMAN	((uint)0x00000600)
-#define SCC_GSMRL_TENC_MANCH	((uint)0x00000400)
-#define SCC_GSMRL_TENC_FM0	((uint)0x00000200)
-#define SCC_GSMRL_TENC_NRZI	((uint)0x00000100)
-#define SCC_GSMRL_TENC_NRZ	((uint)0x00000000)
-#define SCC_GSMRL_DIAG_LE	((uint)0x000000c0)	/* Loop and echo */
-#define SCC_GSMRL_DIAG_ECHO	((uint)0x00000080)
-#define SCC_GSMRL_DIAG_LOOP	((uint)0x00000040)
-#define SCC_GSMRL_DIAG_NORM	((uint)0x00000000)
-#define SCC_GSMRL_ENR		((uint)0x00000020)
-#define SCC_GSMRL_ENT		((uint)0x00000010)
-#define SCC_GSMRL_MODE_ENET	((uint)0x0000000c)
-#define SCC_GSMRL_MODE_QMC	((uint)0x0000000a)
-#define SCC_GSMRL_MODE_DDCMP	((uint)0x00000009)
-#define SCC_GSMRL_MODE_BISYNC	((uint)0x00000008)
-#define SCC_GSMRL_MODE_V14	((uint)0x00000007)
-#define SCC_GSMRL_MODE_AHDLC	((uint)0x00000006)
-#define SCC_GSMRL_MODE_PROFIBUS	((uint)0x00000005)
-#define SCC_GSMRL_MODE_UART	((uint)0x00000004)
-#define SCC_GSMRL_MODE_SS7	((uint)0x00000003)
-#define SCC_GSMRL_MODE_ATALK	((uint)0x00000002)
-#define SCC_GSMRL_MODE_HDLC	((uint)0x00000000)
-
-#define SCC_TODR_TOD		((ushort)0x8000)
-
-/* SCC Event and Mask register.
-*/
-#define	SCCM_TXE	((unsigned char)0x10)
-#define	SCCM_BSY	((unsigned char)0x04)
-#define	SCCM_TX		((unsigned char)0x02)
-#define	SCCM_RX		((unsigned char)0x01)
-
-typedef struct scc_param {
-	ushort	scc_rbase;	/* Rx Buffer descriptor base address */
-	ushort	scc_tbase;	/* Tx Buffer descriptor base address */
-	u_char	scc_rfcr;	/* Rx function code */
-	u_char	scc_tfcr;	/* Tx function code */
-	ushort	scc_mrblr;	/* Max receive buffer length */
-	uint	scc_rstate;	/* Internal */
-	uint	scc_idp;	/* Internal */
-	ushort	scc_rbptr;	/* Internal */
-	ushort	scc_ibc;	/* Internal */
-	uint	scc_rxtmp;	/* Internal */
-	uint	scc_tstate;	/* Internal */
-	uint	scc_tdp;	/* Internal */
-	ushort	scc_tbptr;	/* Internal */
-	ushort	scc_tbc;	/* Internal */
-	uint	scc_txtmp;	/* Internal */
-	uint	scc_rcrc;	/* Internal */
-	uint	scc_tcrc;	/* Internal */
-} sccp_t;
-
-/* Function code bits.
-*/
-#define SCC_EB	((u_char)0x10)	/* Set big endian byte order */
-
-/* CPM Ethernet through SCCx.
- */
-typedef struct scc_enet {
-	sccp_t	sen_genscc;
-	uint	sen_cpres;	/* Preset CRC */
-	uint	sen_cmask;	/* Constant mask for CRC */
-	uint	sen_crcec;	/* CRC Error counter */
-	uint	sen_alec;	/* alignment error counter */
-	uint	sen_disfc;	/* discard frame counter */
-	ushort	sen_pads;	/* Tx short frame pad character */
-	ushort	sen_retlim;	/* Retry limit threshold */
-	ushort	sen_retcnt;	/* Retry limit counter */
-	ushort	sen_maxflr;	/* maximum frame length register */
-	ushort	sen_minflr;	/* minimum frame length register */
-	ushort	sen_maxd1;	/* maximum DMA1 length */
-	ushort	sen_maxd2;	/* maximum DMA2 length */
-	ushort	sen_maxd;	/* Rx max DMA */
-	ushort	sen_dmacnt;	/* Rx DMA counter */
-	ushort	sen_maxb;	/* Max BD byte count */
-	ushort	sen_gaddr1;	/* Group address filter */
-	ushort	sen_gaddr2;
-	ushort	sen_gaddr3;
-	ushort	sen_gaddr4;
-	uint	sen_tbuf0data0;	/* Save area 0 - current frame */
-	uint	sen_tbuf0data1;	/* Save area 1 - current frame */
-	uint	sen_tbuf0rba;	/* Internal */
-	uint	sen_tbuf0crc;	/* Internal */
-	ushort	sen_tbuf0bcnt;	/* Internal */
-	ushort	sen_paddrh;	/* physical address (MSB) */
-	ushort	sen_paddrm;
-	ushort	sen_paddrl;	/* physical address (LSB) */
-	ushort	sen_pper;	/* persistence */
-	ushort	sen_rfbdptr;	/* Rx first BD pointer */
-	ushort	sen_tfbdptr;	/* Tx first BD pointer */
-	ushort	sen_tlbdptr;	/* Tx last BD pointer */
-	uint	sen_tbuf1data0;	/* Save area 0 - current frame */
-	uint	sen_tbuf1data1;	/* Save area 1 - current frame */
-	uint	sen_tbuf1rba;	/* Internal */
-	uint	sen_tbuf1crc;	/* Internal */
-	ushort	sen_tbuf1bcnt;	/* Internal */
-	ushort	sen_txlen;	/* Tx Frame length counter */
-	ushort	sen_iaddr1;	/* Individual address filter */
-	ushort	sen_iaddr2;
-	ushort	sen_iaddr3;
-	ushort	sen_iaddr4;
-	ushort	sen_boffcnt;	/* Backoff counter */
-
-	/* NOTE: Some versions of the manual have the following items
-	 * incorrectly documented.  Below is the proper order.
-	 */
-	ushort	sen_taddrh;	/* temp address (MSB) */
-	ushort	sen_taddrm;
-	ushort	sen_taddrl;	/* temp address (LSB) */
-} scc_enet_t;
-
-/* SCC Event register as used by Ethernet.
-*/
-#define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
-#define SCCE_ENET_TXE	((ushort)0x0010)	/* Transmit Error */
-#define SCCE_ENET_RXF	((ushort)0x0008)	/* Full frame received */
-#define SCCE_ENET_BSY	((ushort)0x0004)	/* All incoming buffers full */
-#define SCCE_ENET_TXB	((ushort)0x0002)	/* A buffer was transmitted */
-#define SCCE_ENET_RXB	((ushort)0x0001)	/* A buffer was received */
-
-/* SCC Mode Register (PMSR) as used by Ethernet.
-*/
-#define SCC_PSMR_HBC	((ushort)0x8000)	/* Enable heartbeat */
-#define SCC_PSMR_FC	((ushort)0x4000)	/* Force collision */
-#define SCC_PSMR_RSH	((ushort)0x2000)	/* Receive short frames */
-#define SCC_PSMR_IAM	((ushort)0x1000)	/* Check individual hash */
-#define SCC_PSMR_ENCRC	((ushort)0x0800)	/* Ethernet CRC mode */
-#define SCC_PSMR_PRO	((ushort)0x0200)	/* Promiscuous mode */
-#define SCC_PSMR_BRO	((ushort)0x0100)	/* Catch broadcast pkts */
-#define SCC_PSMR_SBT	((ushort)0x0080)	/* Special backoff timer */
-#define SCC_PSMR_LPB	((ushort)0x0040)	/* Set Loopback mode */
-#define SCC_PSMR_SIP	((ushort)0x0020)	/* Sample Input Pins */
-#define SCC_PSMR_LCW	((ushort)0x0010)	/* Late collision window */
-#define SCC_PSMR_NIB22	((ushort)0x000a)	/* Start frame search */
-#define SCC_PSMR_FDE	((ushort)0x0001)	/* Full duplex enable */
-
-/* Buffer descriptor control/status used by Ethernet receive.
-*/
-#define BD_ENET_RX_EMPTY	((ushort)0x8000)
-#define BD_ENET_RX_WRAP		((ushort)0x2000)
-#define BD_ENET_RX_INTR		((ushort)0x1000)
-#define BD_ENET_RX_LAST		((ushort)0x0800)
-#define BD_ENET_RX_FIRST	((ushort)0x0400)
-#define BD_ENET_RX_MISS		((ushort)0x0100)
-#define BD_ENET_RX_LG		((ushort)0x0020)
-#define BD_ENET_RX_NO		((ushort)0x0010)
-#define BD_ENET_RX_SH		((ushort)0x0008)
-#define BD_ENET_RX_CR		((ushort)0x0004)
-#define BD_ENET_RX_OV		((ushort)0x0002)
-#define BD_ENET_RX_CL		((ushort)0x0001)
-#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast */
-#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast */
-#define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */
-
-/* Buffer descriptor control/status used by Ethernet transmit.
-*/
-#define BD_ENET_TX_READY	((ushort)0x8000)
-#define BD_ENET_TX_PAD		((ushort)0x4000)
-#define BD_ENET_TX_WRAP		((ushort)0x2000)
-#define BD_ENET_TX_INTR		((ushort)0x1000)
-#define BD_ENET_TX_LAST		((ushort)0x0800)
-#define BD_ENET_TX_TC		((ushort)0x0400)
-#define BD_ENET_TX_DEF		((ushort)0x0200)
-#define BD_ENET_TX_HB		((ushort)0x0100)
-#define BD_ENET_TX_LC		((ushort)0x0080)
-#define BD_ENET_TX_RL		((ushort)0x0040)
-#define BD_ENET_TX_RCMASK	((ushort)0x003c)
-#define BD_ENET_TX_UN		((ushort)0x0002)
-#define BD_ENET_TX_CSL		((ushort)0x0001)
-#define BD_ENET_TX_STATS	((ushort)0x03ff)	/* All status bits */
-
-/* SCC as UART
-*/
-typedef struct scc_uart {
-	sccp_t	scc_genscc;
-	char	res1[8];	/* Reserved */
-	ushort	scc_maxidl;	/* Maximum idle chars */
-	ushort	scc_idlc;	/* temp idle counter */
-	ushort	scc_brkcr;	/* Break count register */
-	ushort	scc_parec;	/* receive parity error counter */
-	ushort	scc_frmec;	/* receive framing error counter */
-	ushort	scc_nosec;	/* receive noise counter */
-	ushort	scc_brkec;	/* receive break condition counter */
-	ushort	scc_brkln;	/* last received break length */
-	ushort	scc_uaddr1;	/* UART address character 1 */
-	ushort	scc_uaddr2;	/* UART address character 2 */
-	ushort	scc_rtemp;	/* Temp storage */
-	ushort	scc_toseq;	/* Transmit out of sequence char */
-	ushort	scc_char1;	/* control character 1 */
-	ushort	scc_char2;	/* control character 2 */
-	ushort	scc_char3;	/* control character 3 */
-	ushort	scc_char4;	/* control character 4 */
-	ushort	scc_char5;	/* control character 5 */
-	ushort	scc_char6;	/* control character 6 */
-	ushort	scc_char7;	/* control character 7 */
-	ushort	scc_char8;	/* control character 8 */
-	ushort	scc_rccm;	/* receive control character mask */
-	ushort	scc_rccr;	/* receive control character register */
-	ushort	scc_rlbc;	/* receive last break character */
-} scc_uart_t;
-
-/* SCC Event and Mask registers when it is used as a UART.
-*/
-#define UART_SCCM_GLR		((ushort)0x1000)
-#define UART_SCCM_GLT		((ushort)0x0800)
-#define UART_SCCM_AB		((ushort)0x0200)
-#define UART_SCCM_IDL		((ushort)0x0100)
-#define UART_SCCM_GRA		((ushort)0x0080)
-#define UART_SCCM_BRKE		((ushort)0x0040)
-#define UART_SCCM_BRKS		((ushort)0x0020)
-#define UART_SCCM_CCR		((ushort)0x0008)
-#define UART_SCCM_BSY		((ushort)0x0004)
-#define UART_SCCM_TX		((ushort)0x0002)
-#define UART_SCCM_RX		((ushort)0x0001)
-
-/* The SCC PMSR when used as a UART.
-*/
-#define SCU_PSMR_FLC		((ushort)0x8000)
-#define SCU_PSMR_SL		((ushort)0x4000)
-#define SCU_PSMR_CL		((ushort)0x3000)
-#define SCU_PSMR_UM		((ushort)0x0c00)
-#define SCU_PSMR_FRZ		((ushort)0x0200)
-#define SCU_PSMR_RZS		((ushort)0x0100)
-#define SCU_PSMR_SYN		((ushort)0x0080)
-#define SCU_PSMR_DRT		((ushort)0x0040)
-#define SCU_PSMR_PEN		((ushort)0x0010)
-#define SCU_PSMR_RPM		((ushort)0x000c)
-#define SCU_PSMR_REVP		((ushort)0x0008)
-#define SCU_PSMR_TPM		((ushort)0x0003)
-#define SCU_PSMR_TEVP		((ushort)0x0002)
-
-/* CPM Transparent mode SCC.
- */
-typedef struct scc_trans {
-	sccp_t	st_genscc;
-	uint	st_cpres;	/* Preset CRC */
-	uint	st_cmask;	/* Constant mask for CRC */
-} scc_trans_t;
-
-#define BD_SCC_TX_LAST		((ushort)0x0800)
-
-/* IIC parameter RAM.
-*/
-typedef struct iic {
-	ushort	iic_rbase;	/* Rx Buffer descriptor base address */
-	ushort	iic_tbase;	/* Tx Buffer descriptor base address */
-	u_char	iic_rfcr;	/* Rx function code */
-	u_char	iic_tfcr;	/* Tx function code */
-	ushort	iic_mrblr;	/* Max receive buffer length */
-	uint	iic_rstate;	/* Internal */
-	uint	iic_rdp;	/* Internal */
-	ushort	iic_rbptr;	/* Internal */
-	ushort	iic_rbc;	/* Internal */
-	uint	iic_rxtmp;	/* Internal */
-	uint	iic_tstate;	/* Internal */
-	uint	iic_tdp;	/* Internal */
-	ushort	iic_tbptr;	/* Internal */
-	ushort	iic_tbc;	/* Internal */
-	uint	iic_txtmp;	/* Internal */
-	char	res1[4];	/* Reserved */
-	ushort	iic_rpbase;	/* Relocation pointer */
-	char	res2[2];	/* Reserved */
-} iic_t;
-
-#define BD_IIC_START		((ushort)0x0400)
-
-/* SPI parameter RAM.
-*/
-typedef struct spi {
-	ushort	spi_rbase;	/* Rx Buffer descriptor base address */
-	ushort	spi_tbase;	/* Tx Buffer descriptor base address */
-	u_char	spi_rfcr;	/* Rx function code */
-	u_char	spi_tfcr;	/* Tx function code */
-	ushort	spi_mrblr;	/* Max receive buffer length */
-	uint	spi_rstate;	/* Internal */
-	uint	spi_rdp;	/* Internal */
-	ushort	spi_rbptr;	/* Internal */
-	ushort	spi_rbc;	/* Internal */
-	uint	spi_rxtmp;	/* Internal */
-	uint	spi_tstate;	/* Internal */
-	uint	spi_tdp;	/* Internal */
-	ushort	spi_tbptr;	/* Internal */
-	ushort	spi_tbc;	/* Internal */
-	uint	spi_txtmp;	/* Internal */
-	uint	spi_res;
-	ushort	spi_rpbase;	/* Relocation pointer */
-	ushort	spi_res2;
-} spi_t;
-
-/* SPI Mode register.
-*/
-#define SPMODE_LOOP	((ushort)0x4000)	/* Loopback */
-#define SPMODE_CI	((ushort)0x2000)	/* Clock Invert */
-#define SPMODE_CP	((ushort)0x1000)	/* Clock Phase */
-#define SPMODE_DIV16	((ushort)0x0800)	/* BRG/16 mode */
-#define SPMODE_REV	((ushort)0x0400)	/* Reversed Data */
-#define SPMODE_MSTR	((ushort)0x0200)	/* SPI Master */
-#define SPMODE_EN	((ushort)0x0100)	/* Enable */
-#define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
-#define SPMODE_LEN4	((ushort)0x0030)	/*  4 bits per char */
-#define SPMODE_LEN8	((ushort)0x0070)	/*  8 bits per char */
-#define SPMODE_LEN16	((ushort)0x00f0)	/* 16 bits per char */
-#define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
-
-/* SPIE fields */
-#define SPIE_MME	0x20
-#define SPIE_TXE	0x10
-#define SPIE_BSY	0x04
-#define SPIE_TXB	0x02
-#define SPIE_RXB	0x01
-
-/*
- * RISC Controller Configuration Register definitons
- */
-#define RCCR_TIME	0x8000			/* RISC Timer Enable */
-#define RCCR_TIMEP(t)	(((t) & 0x3F)<<8)	/* RISC Timer Period */
-#define RCCR_TIME_MASK	0x00FF			/* not RISC Timer related bits */
-
-/* RISC Timer Parameter RAM offset */
-#define PROFF_RTMR	((uint)0x01B0)
-
-typedef struct risc_timer_pram {
-	unsigned short	tm_base;	/* RISC Timer Table Base Address */
-	unsigned short	tm_ptr;		/* RISC Timer Table Pointer (internal) */
-	unsigned short	r_tmr;		/* RISC Timer Mode Register */
-	unsigned short	r_tmv;		/* RISC Timer Valid Register */
-	unsigned long	tm_cmd;		/* RISC Timer Command Register */
-	unsigned long	tm_cnt;		/* RISC Timer Internal Count */
-} rt_pram_t;
-
-/* Bits in RISC Timer Command Register */
-#define TM_CMD_VALID	0x80000000	/* Valid - Enables the timer */
-#define TM_CMD_RESTART	0x40000000	/* Restart - for automatic restart */
-#define TM_CMD_PWM	0x20000000	/* Run in Pulse Width Modulation Mode */
-#define TM_CMD_NUM(n)	(((n)&0xF)<<16)	/* Timer Number */
-#define TM_CMD_PERIOD(p) ((p)&0xFFFF)	/* Timer Period */
-
-/* CPM interrupts.  There are nearly 32 interrupts generated by CPM
- * channels or devices.  All of these are presented to the PPC core
- * as a single interrupt.  The CPM interrupt handler dispatches its
- * own handlers, in a similar fashion to the PPC core handler.  We
- * use the table as defined in the manuals (i.e. no special high
- * priority and SCC1 == SCCa, etc...).
- */
-#define CPMVEC_NR		32
-#define	CPMVEC_PIO_PC15		((ushort)0x1f)
-#define	CPMVEC_SCC1		((ushort)0x1e)
-#define	CPMVEC_SCC2		((ushort)0x1d)
-#define	CPMVEC_SCC3		((ushort)0x1c)
-#define	CPMVEC_SCC4		((ushort)0x1b)
-#define	CPMVEC_PIO_PC14		((ushort)0x1a)
-#define	CPMVEC_TIMER1		((ushort)0x19)
-#define	CPMVEC_PIO_PC13		((ushort)0x18)
-#define	CPMVEC_PIO_PC12		((ushort)0x17)
-#define	CPMVEC_SDMA_CB_ERR	((ushort)0x16)
-#define CPMVEC_IDMA1		((ushort)0x15)
-#define CPMVEC_IDMA2		((ushort)0x14)
-#define CPMVEC_TIMER2		((ushort)0x12)
-#define CPMVEC_RISCTIMER	((ushort)0x11)
-#define CPMVEC_I2C		((ushort)0x10)
-#define	CPMVEC_PIO_PC11		((ushort)0x0f)
-#define	CPMVEC_PIO_PC10		((ushort)0x0e)
-#define CPMVEC_TIMER3		((ushort)0x0c)
-#define	CPMVEC_PIO_PC9		((ushort)0x0b)
-#define	CPMVEC_PIO_PC8		((ushort)0x0a)
-#define	CPMVEC_PIO_PC7		((ushort)0x09)
-#define CPMVEC_TIMER4		((ushort)0x07)
-#define	CPMVEC_PIO_PC6		((ushort)0x06)
-#define	CPMVEC_SPI		((ushort)0x05)
-#define	CPMVEC_SMC1		((ushort)0x04)
-#define	CPMVEC_SMC2		((ushort)0x03)
-#define	CPMVEC_PIO_PC5		((ushort)0x02)
-#define	CPMVEC_PIO_PC4		((ushort)0x01)
-#define	CPMVEC_ERROR		((ushort)0x00)
-
-/* CPM interrupt configuration vector.
-*/
-#define	CICR_SCD_SCC4		((uint)0x00c00000)	/* SCC4 @ SCCd */
-#define	CICR_SCC_SCC3		((uint)0x00200000)	/* SCC3 @ SCCc */
-#define	CICR_SCB_SCC2		((uint)0x00040000)	/* SCC2 @ SCCb */
-#define	CICR_SCA_SCC1		((uint)0x00000000)	/* SCC1 @ SCCa */
-#define CICR_IRL_MASK		((uint)0x0000e000)	/* Core interrupt */
-#define CICR_HP_MASK		((uint)0x00001f00)	/* Hi-pri int. */
-#define CICR_IEN		((uint)0x00000080)	/* Int. enable */
-#define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
-
-extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
-extern void cpm_free_handler(int vec);
-
-#endif /* __CPM_8XX__ */
diff --git a/include/asm-ppc/cpm1.h b/include/asm-ppc/cpm1.h
new file mode 100644
index 0000000..03035ac
--- /dev/null
+++ b/include/asm-ppc/cpm1.h
@@ -0,0 +1,688 @@
+/*
+ * MPC8xx Communication Processor Module.
+ * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+ *
+ * This file contains structures and information for the communication
+ * processor channels.  Some CPM control and status is available
+ * throught the MPC8xx internal memory map.  See immap.h for details.
+ * This file only contains what I need for the moment, not the total
+ * CPM capabilities.  I (or someone else) will add definitions as they
+ * are needed.  -- Dan
+ *
+ * On the MBX board, EPPC-Bug loads CPM microcode into the first 512
+ * bytes of the DP RAM and relocates the I2C parameter area to the
+ * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
+ * or other use.
+ */
+#ifndef __CPM1__
+#define __CPM1__
+
+#include <asm/8xx_immap.h>
+#include <asm/ptrace.h>
+
+/* CPM Command register.
+*/
+#define CPM_CR_RST	((ushort)0x8000)
+#define CPM_CR_OPCODE	((ushort)0x0f00)
+#define CPM_CR_CHAN	((ushort)0x00f0)
+#define CPM_CR_FLG	((ushort)0x0001)
+
+/* Some commands (there are more...later)
+*/
+#define CPM_CR_INIT_TRX		((ushort)0x0000)
+#define CPM_CR_INIT_RX		((ushort)0x0001)
+#define CPM_CR_INIT_TX		((ushort)0x0002)
+#define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_STOP_TX		((ushort)0x0004)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
+#define CPM_CR_RESTART_TX	((ushort)0x0006)
+#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
+#define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR
+
+/* Channel numbers.
+*/
+#define CPM_CR_CH_SCC1		((ushort)0x0000)
+#define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
+#define CPM_CR_CH_SCC2		((ushort)0x0004)
+#define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
+#define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
+#define CPM_CR_CH_SCC3		((ushort)0x0008)
+#define CPM_CR_CH_SMC1		((ushort)0x0009)	/* SMC1 / DSP1 */
+#define CPM_CR_CH_SCC4		((ushort)0x000c)
+#define CPM_CR_CH_SMC2		((ushort)0x000d)	/* SMC2 / DSP2 */
+
+#define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
+
+/* The dual ported RAM is multi-functional.  Some areas can be (and are
+ * being) used for microcode.  There is an area that can only be used
+ * as data ram for buffer descriptors, which is all we use right now.
+ * Currently the first 512 and last 256 bytes are used for microcode.
+ */
+#define CPM_DATAONLY_BASE	((uint)0x0800)
+#define CPM_DATAONLY_SIZE	((uint)0x0700)
+#define CPM_DP_NOSPACE		((uint)0x7fffffff)
+
+/* Export the base address of the communication processor registers
+ * and dual port ram.
+ */
+extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
+extern unsigned long cpm_dpalloc(uint size, uint align);
+extern int cpm_dpfree(unsigned long offset);
+extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
+extern void cpm_dpdump(void);
+extern void *cpm_dpram_addr(unsigned long offset);
+extern uint cpm_dpram_phys(u8 *addr);
+extern void cpm_setbrg(uint brg, uint rate);
+
+extern void cpm_load_patch(volatile immap_t *immr);
+
+/* Buffer descriptors used by many of the CPM protocols.
+*/
+typedef struct cpm_buf_desc {
+	ushort	cbd_sc;		/* Status and Control */
+	ushort	cbd_datlen;	/* Data length in buffer */
+	uint	cbd_bufaddr;	/* Buffer address in host memory */
+} cbd_t;
+
+#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
+#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
+#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
+#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
+#define BD_SC_LAST	((ushort)0x0800)	/* Last buffer in frame */
+#define BD_SC_TC	((ushort)0x0400)	/* Transmit CRC */
+#define BD_SC_CM	((ushort)0x0200)	/* Continous mode */
+#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
+#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
+#define BD_SC_BR	((ushort)0x0020)	/* Break received */
+#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
+#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
+#define BD_SC_NAK	((ushort)0x0004)	/* NAK - did not respond */
+#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
+#define BD_SC_UN	((ushort)0x0002)	/* Underrun */
+#define BD_SC_CD	((ushort)0x0001)	/* ?? */
+#define BD_SC_CL	((ushort)0x0001)	/* Collision */
+
+/* Parameter RAM offsets.
+*/
+#define PROFF_SCC1	((uint)0x0000)
+#define PROFF_IIC	((uint)0x0080)
+#define PROFF_SCC2	((uint)0x0100)
+#define PROFF_SPI	((uint)0x0180)
+#define PROFF_SCC3	((uint)0x0200)
+#define PROFF_SMC1	((uint)0x0280)
+#define PROFF_SCC4	((uint)0x0300)
+#define PROFF_SMC2	((uint)0x0380)
+
+/* Define enough so I can at least use the serial port as a UART.
+ * The MBX uses SMC1 as the host serial port.
+ */
+typedef struct smc_uart {
+	ushort	smc_rbase;	/* Rx Buffer descriptor base address */
+	ushort	smc_tbase;	/* Tx Buffer descriptor base address */
+	u_char	smc_rfcr;	/* Rx function code */
+	u_char	smc_tfcr;	/* Tx function code */
+	ushort	smc_mrblr;	/* Max receive buffer length */
+	uint	smc_rstate;	/* Internal */
+	uint	smc_idp;	/* Internal */
+	ushort	smc_rbptr;	/* Internal */
+	ushort	smc_ibc;	/* Internal */
+	uint	smc_rxtmp;	/* Internal */
+	uint	smc_tstate;	/* Internal */
+	uint	smc_tdp;	/* Internal */
+	ushort	smc_tbptr;	/* Internal */
+	ushort	smc_tbc;	/* Internal */
+	uint	smc_txtmp;	/* Internal */
+	ushort	smc_maxidl;	/* Maximum idle characters */
+	ushort	smc_tmpidl;	/* Temporary idle counter */
+	ushort	smc_brklen;	/* Last received break length */
+	ushort	smc_brkec;	/* rcv'd break condition counter */
+	ushort	smc_brkcr;	/* xmt break count register */
+	ushort	smc_rmask;	/* Temporary bit mask */
+	char	res1[8];	/* Reserved */
+	ushort	smc_rpbase;	/* Relocation pointer */
+} smc_uart_t;
+
+/* Function code bits.
+*/
+#define SMC_EB	((u_char)0x10)	/* Set big endian byte order */
+
+/* SMC uart mode register.
+*/
+#define	SMCMR_REN	((ushort)0x0001)
+#define SMCMR_TEN	((ushort)0x0002)
+#define SMCMR_DM	((ushort)0x000c)
+#define SMCMR_SM_GCI	((ushort)0x0000)
+#define SMCMR_SM_UART	((ushort)0x0020)
+#define SMCMR_SM_TRANS	((ushort)0x0030)
+#define SMCMR_SM_MASK	((ushort)0x0030)
+#define SMCMR_PM_EVEN	((ushort)0x0100)	/* Even parity, else odd */
+#define SMCMR_REVD	SMCMR_PM_EVEN
+#define SMCMR_PEN	((ushort)0x0200)	/* Parity enable */
+#define SMCMR_BS	SMCMR_PEN
+#define SMCMR_SL	((ushort)0x0400)	/* Two stops, else one */
+#define SMCR_CLEN_MASK	((ushort)0x7800)	/* Character length */
+#define smcr_mk_clen(C)	(((C) << 11) & SMCR_CLEN_MASK)
+
+/* SMC2 as Centronics parallel printer.  It is half duplex, in that
+ * it can only receive or transmit.  The parameter ram values for
+ * each direction are either unique or properly overlap, so we can
+ * include them in one structure.
+ */
+typedef struct smc_centronics {
+	ushort	scent_rbase;
+	ushort	scent_tbase;
+	u_char	scent_cfcr;
+	u_char	scent_smask;
+	ushort	scent_mrblr;
+	uint	scent_rstate;
+	uint	scent_r_ptr;
+	ushort	scent_rbptr;
+	ushort	scent_r_cnt;
+	uint	scent_rtemp;
+	uint	scent_tstate;
+	uint	scent_t_ptr;
+	ushort	scent_tbptr;
+	ushort	scent_t_cnt;
+	uint	scent_ttemp;
+	ushort	scent_max_sl;
+	ushort	scent_sl_cnt;
+	ushort	scent_character1;
+	ushort	scent_character2;
+	ushort	scent_character3;
+	ushort	scent_character4;
+	ushort	scent_character5;
+	ushort	scent_character6;
+	ushort	scent_character7;
+	ushort	scent_character8;
+	ushort	scent_rccm;
+	ushort	scent_rccr;
+} smc_cent_t;
+
+/* Centronics Status Mask Register.
+*/
+#define SMC_CENT_F	((u_char)0x08)
+#define SMC_CENT_PE	((u_char)0x04)
+#define SMC_CENT_S	((u_char)0x02)
+
+/* SMC Event and Mask register.
+*/
+#define	SMCM_BRKE	((unsigned char)0x40)	/* When in UART Mode */
+#define	SMCM_BRK	((unsigned char)0x10)	/* When in UART Mode */
+#define	SMCM_TXE	((unsigned char)0x10)	/* When in Transparent Mode */
+#define	SMCM_BSY	((unsigned char)0x04)
+#define	SMCM_TX		((unsigned char)0x02)
+#define	SMCM_RX		((unsigned char)0x01)
+
+/* Baud rate generators.
+*/
+#define CPM_BRG_RST		((uint)0x00020000)
+#define CPM_BRG_EN		((uint)0x00010000)
+#define CPM_BRG_EXTC_INT	((uint)0x00000000)
+#define CPM_BRG_EXTC_CLK2	((uint)0x00004000)
+#define CPM_BRG_EXTC_CLK6	((uint)0x00008000)
+#define CPM_BRG_ATB		((uint)0x00002000)
+#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
+#define CPM_BRG_DIV16		((uint)0x00000001)
+
+/* SI Clock Route Register
+*/
+#define SICR_RCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_TCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_RCLK_SCC2_BRG2	((uint)0x00000800)
+#define SICR_TCLK_SCC2_BRG2	((uint)0x00000100)
+#define SICR_RCLK_SCC3_BRG3	((uint)0x00100000)
+#define SICR_TCLK_SCC3_BRG3	((uint)0x00020000)
+#define SICR_RCLK_SCC4_BRG4	((uint)0x18000000)
+#define SICR_TCLK_SCC4_BRG4	((uint)0x03000000)
+
+/* SCCs.
+*/
+#define SCC_GSMRH_IRP		((uint)0x00040000)
+#define SCC_GSMRH_GDE		((uint)0x00010000)
+#define SCC_GSMRH_TCRC_CCITT	((uint)0x00008000)
+#define SCC_GSMRH_TCRC_BISYNC	((uint)0x00004000)
+#define SCC_GSMRH_TCRC_HDLC	((uint)0x00000000)
+#define SCC_GSMRH_REVD		((uint)0x00002000)
+#define SCC_GSMRH_TRX		((uint)0x00001000)
+#define SCC_GSMRH_TTX		((uint)0x00000800)
+#define SCC_GSMRH_CDP		((uint)0x00000400)
+#define SCC_GSMRH_CTSP		((uint)0x00000200)
+#define SCC_GSMRH_CDS		((uint)0x00000100)
+#define SCC_GSMRH_CTSS		((uint)0x00000080)
+#define SCC_GSMRH_TFL		((uint)0x00000040)
+#define SCC_GSMRH_RFW		((uint)0x00000020)
+#define SCC_GSMRH_TXSY		((uint)0x00000010)
+#define SCC_GSMRH_SYNL16	((uint)0x0000000c)
+#define SCC_GSMRH_SYNL8		((uint)0x00000008)
+#define SCC_GSMRH_SYNL4		((uint)0x00000004)
+#define SCC_GSMRH_RTSM		((uint)0x00000002)
+#define SCC_GSMRH_RSYN		((uint)0x00000001)
+
+#define SCC_GSMRL_SIR		((uint)0x80000000)	/* SCC2 only */
+#define SCC_GSMRL_EDGE_NONE	((uint)0x60000000)
+#define SCC_GSMRL_EDGE_NEG	((uint)0x40000000)
+#define SCC_GSMRL_EDGE_POS	((uint)0x20000000)
+#define SCC_GSMRL_EDGE_BOTH	((uint)0x00000000)
+#define SCC_GSMRL_TCI		((uint)0x10000000)
+#define SCC_GSMRL_TSNC_3	((uint)0x0c000000)
+#define SCC_GSMRL_TSNC_4	((uint)0x08000000)
+#define SCC_GSMRL_TSNC_14	((uint)0x04000000)
+#define SCC_GSMRL_TSNC_INF	((uint)0x00000000)
+#define SCC_GSMRL_RINV		((uint)0x02000000)
+#define SCC_GSMRL_TINV		((uint)0x01000000)
+#define SCC_GSMRL_TPL_128	((uint)0x00c00000)
+#define SCC_GSMRL_TPL_64	((uint)0x00a00000)
+#define SCC_GSMRL_TPL_48	((uint)0x00800000)
+#define SCC_GSMRL_TPL_32	((uint)0x00600000)
+#define SCC_GSMRL_TPL_16	((uint)0x00400000)
+#define SCC_GSMRL_TPL_8		((uint)0x00200000)
+#define SCC_GSMRL_TPL_NONE	((uint)0x00000000)
+#define SCC_GSMRL_TPP_ALL1	((uint)0x00180000)
+#define SCC_GSMRL_TPP_01	((uint)0x00100000)
+#define SCC_GSMRL_TPP_10	((uint)0x00080000)
+#define SCC_GSMRL_TPP_ZEROS	((uint)0x00000000)
+#define SCC_GSMRL_TEND		((uint)0x00040000)
+#define SCC_GSMRL_TDCR_32	((uint)0x00030000)
+#define SCC_GSMRL_TDCR_16	((uint)0x00020000)
+#define SCC_GSMRL_TDCR_8	((uint)0x00010000)
+#define SCC_GSMRL_TDCR_1	((uint)0x00000000)
+#define SCC_GSMRL_RDCR_32	((uint)0x0000c000)
+#define SCC_GSMRL_RDCR_16	((uint)0x00008000)
+#define SCC_GSMRL_RDCR_8	((uint)0x00004000)
+#define SCC_GSMRL_RDCR_1	((uint)0x00000000)
+#define SCC_GSMRL_RENC_DFMAN	((uint)0x00003000)
+#define SCC_GSMRL_RENC_MANCH	((uint)0x00002000)
+#define SCC_GSMRL_RENC_FM0	((uint)0x00001000)
+#define SCC_GSMRL_RENC_NRZI	((uint)0x00000800)
+#define SCC_GSMRL_RENC_NRZ	((uint)0x00000000)
+#define SCC_GSMRL_TENC_DFMAN	((uint)0x00000600)
+#define SCC_GSMRL_TENC_MANCH	((uint)0x00000400)
+#define SCC_GSMRL_TENC_FM0	((uint)0x00000200)
+#define SCC_GSMRL_TENC_NRZI	((uint)0x00000100)
+#define SCC_GSMRL_TENC_NRZ	((uint)0x00000000)
+#define SCC_GSMRL_DIAG_LE	((uint)0x000000c0)	/* Loop and echo */
+#define SCC_GSMRL_DIAG_ECHO	((uint)0x00000080)
+#define SCC_GSMRL_DIAG_LOOP	((uint)0x00000040)
+#define SCC_GSMRL_DIAG_NORM	((uint)0x00000000)
+#define SCC_GSMRL_ENR		((uint)0x00000020)
+#define SCC_GSMRL_ENT		((uint)0x00000010)
+#define SCC_GSMRL_MODE_ENET	((uint)0x0000000c)
+#define SCC_GSMRL_MODE_QMC	((uint)0x0000000a)
+#define SCC_GSMRL_MODE_DDCMP	((uint)0x00000009)
+#define SCC_GSMRL_MODE_BISYNC	((uint)0x00000008)
+#define SCC_GSMRL_MODE_V14	((uint)0x00000007)
+#define SCC_GSMRL_MODE_AHDLC	((uint)0x00000006)
+#define SCC_GSMRL_MODE_PROFIBUS	((uint)0x00000005)
+#define SCC_GSMRL_MODE_UART	((uint)0x00000004)
+#define SCC_GSMRL_MODE_SS7	((uint)0x00000003)
+#define SCC_GSMRL_MODE_ATALK	((uint)0x00000002)
+#define SCC_GSMRL_MODE_HDLC	((uint)0x00000000)
+
+#define SCC_TODR_TOD		((ushort)0x8000)
+
+/* SCC Event and Mask register.
+*/
+#define	SCCM_TXE	((unsigned char)0x10)
+#define	SCCM_BSY	((unsigned char)0x04)
+#define	SCCM_TX		((unsigned char)0x02)
+#define	SCCM_RX		((unsigned char)0x01)
+
+typedef struct scc_param {
+	ushort	scc_rbase;	/* Rx Buffer descriptor base address */
+	ushort	scc_tbase;	/* Tx Buffer descriptor base address */
+	u_char	scc_rfcr;	/* Rx function code */
+	u_char	scc_tfcr;	/* Tx function code */
+	ushort	scc_mrblr;	/* Max receive buffer length */
+	uint	scc_rstate;	/* Internal */
+	uint	scc_idp;	/* Internal */
+	ushort	scc_rbptr;	/* Internal */
+	ushort	scc_ibc;	/* Internal */
+	uint	scc_rxtmp;	/* Internal */
+	uint	scc_tstate;	/* Internal */
+	uint	scc_tdp;	/* Internal */
+	ushort	scc_tbptr;	/* Internal */
+	ushort	scc_tbc;	/* Internal */
+	uint	scc_txtmp;	/* Internal */
+	uint	scc_rcrc;	/* Internal */
+	uint	scc_tcrc;	/* Internal */
+} sccp_t;
+
+/* Function code bits.
+*/
+#define SCC_EB	((u_char)0x10)	/* Set big endian byte order */
+
+/* CPM Ethernet through SCCx.
+ */
+typedef struct scc_enet {
+	sccp_t	sen_genscc;
+	uint	sen_cpres;	/* Preset CRC */
+	uint	sen_cmask;	/* Constant mask for CRC */
+	uint	sen_crcec;	/* CRC Error counter */
+	uint	sen_alec;	/* alignment error counter */
+	uint	sen_disfc;	/* discard frame counter */
+	ushort	sen_pads;	/* Tx short frame pad character */
+	ushort	sen_retlim;	/* Retry limit threshold */
+	ushort	sen_retcnt;	/* Retry limit counter */
+	ushort	sen_maxflr;	/* maximum frame length register */
+	ushort	sen_minflr;	/* minimum frame length register */
+	ushort	sen_maxd1;	/* maximum DMA1 length */
+	ushort	sen_maxd2;	/* maximum DMA2 length */
+	ushort	sen_maxd;	/* Rx max DMA */
+	ushort	sen_dmacnt;	/* Rx DMA counter */
+	ushort	sen_maxb;	/* Max BD byte count */
+	ushort	sen_gaddr1;	/* Group address filter */
+	ushort	sen_gaddr2;
+	ushort	sen_gaddr3;
+	ushort	sen_gaddr4;
+	uint	sen_tbuf0data0;	/* Save area 0 - current frame */
+	uint	sen_tbuf0data1;	/* Save area 1 - current frame */
+	uint	sen_tbuf0rba;	/* Internal */
+	uint	sen_tbuf0crc;	/* Internal */
+	ushort	sen_tbuf0bcnt;	/* Internal */
+	ushort	sen_paddrh;	/* physical address (MSB) */
+	ushort	sen_paddrm;
+	ushort	sen_paddrl;	/* physical address (LSB) */
+	ushort	sen_pper;	/* persistence */
+	ushort	sen_rfbdptr;	/* Rx first BD pointer */
+	ushort	sen_tfbdptr;	/* Tx first BD pointer */
+	ushort	sen_tlbdptr;	/* Tx last BD pointer */
+	uint	sen_tbuf1data0;	/* Save area 0 - current frame */
+	uint	sen_tbuf1data1;	/* Save area 1 - current frame */
+	uint	sen_tbuf1rba;	/* Internal */
+	uint	sen_tbuf1crc;	/* Internal */
+	ushort	sen_tbuf1bcnt;	/* Internal */
+	ushort	sen_txlen;	/* Tx Frame length counter */
+	ushort	sen_iaddr1;	/* Individual address filter */
+	ushort	sen_iaddr2;
+	ushort	sen_iaddr3;
+	ushort	sen_iaddr4;
+	ushort	sen_boffcnt;	/* Backoff counter */
+
+	/* NOTE: Some versions of the manual have the following items
+	 * incorrectly documented.  Below is the proper order.
+	 */
+	ushort	sen_taddrh;	/* temp address (MSB) */
+	ushort	sen_taddrm;
+	ushort	sen_taddrl;	/* temp address (LSB) */
+} scc_enet_t;
+
+/* SCC Event register as used by Ethernet.
+*/
+#define SCCE_ENET_GRA	((ushort)0x0080)	/* Graceful stop complete */
+#define SCCE_ENET_TXE	((ushort)0x0010)	/* Transmit Error */
+#define SCCE_ENET_RXF	((ushort)0x0008)	/* Full frame received */
+#define SCCE_ENET_BSY	((ushort)0x0004)	/* All incoming buffers full */
+#define SCCE_ENET_TXB	((ushort)0x0002)	/* A buffer was transmitted */
+#define SCCE_ENET_RXB	((ushort)0x0001)	/* A buffer was received */
+
+/* SCC Mode Register (PMSR) as used by Ethernet.
+*/
+#define SCC_PSMR_HBC	((ushort)0x8000)	/* Enable heartbeat */
+#define SCC_PSMR_FC	((ushort)0x4000)	/* Force collision */
+#define SCC_PSMR_RSH	((ushort)0x2000)	/* Receive short frames */
+#define SCC_PSMR_IAM	((ushort)0x1000)	/* Check individual hash */
+#define SCC_PSMR_ENCRC	((ushort)0x0800)	/* Ethernet CRC mode */
+#define SCC_PSMR_PRO	((ushort)0x0200)	/* Promiscuous mode */
+#define SCC_PSMR_BRO	((ushort)0x0100)	/* Catch broadcast pkts */
+#define SCC_PSMR_SBT	((ushort)0x0080)	/* Special backoff timer */
+#define SCC_PSMR_LPB	((ushort)0x0040)	/* Set Loopback mode */
+#define SCC_PSMR_SIP	((ushort)0x0020)	/* Sample Input Pins */
+#define SCC_PSMR_LCW	((ushort)0x0010)	/* Late collision window */
+#define SCC_PSMR_NIB22	((ushort)0x000a)	/* Start frame search */
+#define SCC_PSMR_FDE	((ushort)0x0001)	/* Full duplex enable */
+
+/* Buffer descriptor control/status used by Ethernet receive.
+*/
+#define BD_ENET_RX_EMPTY	((ushort)0x8000)
+#define BD_ENET_RX_WRAP		((ushort)0x2000)
+#define BD_ENET_RX_INTR		((ushort)0x1000)
+#define BD_ENET_RX_LAST		((ushort)0x0800)
+#define BD_ENET_RX_FIRST	((ushort)0x0400)
+#define BD_ENET_RX_MISS		((ushort)0x0100)
+#define BD_ENET_RX_LG		((ushort)0x0020)
+#define BD_ENET_RX_NO		((ushort)0x0010)
+#define BD_ENET_RX_SH		((ushort)0x0008)
+#define BD_ENET_RX_CR		((ushort)0x0004)
+#define BD_ENET_RX_OV		((ushort)0x0002)
+#define BD_ENET_RX_CL		((ushort)0x0001)
+#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast */
+#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast */
+#define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */
+
+/* Buffer descriptor control/status used by Ethernet transmit.
+*/
+#define BD_ENET_TX_READY	((ushort)0x8000)
+#define BD_ENET_TX_PAD		((ushort)0x4000)
+#define BD_ENET_TX_WRAP		((ushort)0x2000)
+#define BD_ENET_TX_INTR		((ushort)0x1000)
+#define BD_ENET_TX_LAST		((ushort)0x0800)
+#define BD_ENET_TX_TC		((ushort)0x0400)
+#define BD_ENET_TX_DEF		((ushort)0x0200)
+#define BD_ENET_TX_HB		((ushort)0x0100)
+#define BD_ENET_TX_LC		((ushort)0x0080)
+#define BD_ENET_TX_RL		((ushort)0x0040)
+#define BD_ENET_TX_RCMASK	((ushort)0x003c)
+#define BD_ENET_TX_UN		((ushort)0x0002)
+#define BD_ENET_TX_CSL		((ushort)0x0001)
+#define BD_ENET_TX_STATS	((ushort)0x03ff)	/* All status bits */
+
+/* SCC as UART
+*/
+typedef struct scc_uart {
+	sccp_t	scc_genscc;
+	char	res1[8];	/* Reserved */
+	ushort	scc_maxidl;	/* Maximum idle chars */
+	ushort	scc_idlc;	/* temp idle counter */
+	ushort	scc_brkcr;	/* Break count register */
+	ushort	scc_parec;	/* receive parity error counter */
+	ushort	scc_frmec;	/* receive framing error counter */
+	ushort	scc_nosec;	/* receive noise counter */
+	ushort	scc_brkec;	/* receive break condition counter */
+	ushort	scc_brkln;	/* last received break length */
+	ushort	scc_uaddr1;	/* UART address character 1 */
+	ushort	scc_uaddr2;	/* UART address character 2 */
+	ushort	scc_rtemp;	/* Temp storage */
+	ushort	scc_toseq;	/* Transmit out of sequence char */
+	ushort	scc_char1;	/* control character 1 */
+	ushort	scc_char2;	/* control character 2 */
+	ushort	scc_char3;	/* control character 3 */
+	ushort	scc_char4;	/* control character 4 */
+	ushort	scc_char5;	/* control character 5 */
+	ushort	scc_char6;	/* control character 6 */
+	ushort	scc_char7;	/* control character 7 */
+	ushort	scc_char8;	/* control character 8 */
+	ushort	scc_rccm;	/* receive control character mask */
+	ushort	scc_rccr;	/* receive control character register */
+	ushort	scc_rlbc;	/* receive last break character */
+} scc_uart_t;
+
+/* SCC Event and Mask registers when it is used as a UART.
+*/
+#define UART_SCCM_GLR		((ushort)0x1000)
+#define UART_SCCM_GLT		((ushort)0x0800)
+#define UART_SCCM_AB		((ushort)0x0200)
+#define UART_SCCM_IDL		((ushort)0x0100)
+#define UART_SCCM_GRA		((ushort)0x0080)
+#define UART_SCCM_BRKE		((ushort)0x0040)
+#define UART_SCCM_BRKS		((ushort)0x0020)
+#define UART_SCCM_CCR		((ushort)0x0008)
+#define UART_SCCM_BSY		((ushort)0x0004)
+#define UART_SCCM_TX		((ushort)0x0002)
+#define UART_SCCM_RX		((ushort)0x0001)
+
+/* The SCC PMSR when used as a UART.
+*/
+#define SCU_PSMR_FLC		((ushort)0x8000)
+#define SCU_PSMR_SL		((ushort)0x4000)
+#define SCU_PSMR_CL		((ushort)0x3000)
+#define SCU_PSMR_UM		((ushort)0x0c00)
+#define SCU_PSMR_FRZ		((ushort)0x0200)
+#define SCU_PSMR_RZS		((ushort)0x0100)
+#define SCU_PSMR_SYN		((ushort)0x0080)
+#define SCU_PSMR_DRT		((ushort)0x0040)
+#define SCU_PSMR_PEN		((ushort)0x0010)
+#define SCU_PSMR_RPM		((ushort)0x000c)
+#define SCU_PSMR_REVP		((ushort)0x0008)
+#define SCU_PSMR_TPM		((ushort)0x0003)
+#define SCU_PSMR_TEVP		((ushort)0x0002)
+
+/* CPM Transparent mode SCC.
+ */
+typedef struct scc_trans {
+	sccp_t	st_genscc;
+	uint	st_cpres;	/* Preset CRC */
+	uint	st_cmask;	/* Constant mask for CRC */
+} scc_trans_t;
+
+#define BD_SCC_TX_LAST		((ushort)0x0800)
+
+/* IIC parameter RAM.
+*/
+typedef struct iic {
+	ushort	iic_rbase;	/* Rx Buffer descriptor base address */
+	ushort	iic_tbase;	/* Tx Buffer descriptor base address */
+	u_char	iic_rfcr;	/* Rx function code */
+	u_char	iic_tfcr;	/* Tx function code */
+	ushort	iic_mrblr;	/* Max receive buffer length */
+	uint	iic_rstate;	/* Internal */
+	uint	iic_rdp;	/* Internal */
+	ushort	iic_rbptr;	/* Internal */
+	ushort	iic_rbc;	/* Internal */
+	uint	iic_rxtmp;	/* Internal */
+	uint	iic_tstate;	/* Internal */
+	uint	iic_tdp;	/* Internal */
+	ushort	iic_tbptr;	/* Internal */
+	ushort	iic_tbc;	/* Internal */
+	uint	iic_txtmp;	/* Internal */
+	char	res1[4];	/* Reserved */
+	ushort	iic_rpbase;	/* Relocation pointer */
+	char	res2[2];	/* Reserved */
+} iic_t;
+
+#define BD_IIC_START		((ushort)0x0400)
+
+/* SPI parameter RAM.
+*/
+typedef struct spi {
+	ushort	spi_rbase;	/* Rx Buffer descriptor base address */
+	ushort	spi_tbase;	/* Tx Buffer descriptor base address */
+	u_char	spi_rfcr;	/* Rx function code */
+	u_char	spi_tfcr;	/* Tx function code */
+	ushort	spi_mrblr;	/* Max receive buffer length */
+	uint	spi_rstate;	/* Internal */
+	uint	spi_rdp;	/* Internal */
+	ushort	spi_rbptr;	/* Internal */
+	ushort	spi_rbc;	/* Internal */
+	uint	spi_rxtmp;	/* Internal */
+	uint	spi_tstate;	/* Internal */
+	uint	spi_tdp;	/* Internal */
+	ushort	spi_tbptr;	/* Internal */
+	ushort	spi_tbc;	/* Internal */
+	uint	spi_txtmp;	/* Internal */
+	uint	spi_res;
+	ushort	spi_rpbase;	/* Relocation pointer */
+	ushort	spi_res2;
+} spi_t;
+
+/* SPI Mode register.
+*/
+#define SPMODE_LOOP	((ushort)0x4000)	/* Loopback */
+#define SPMODE_CI	((ushort)0x2000)	/* Clock Invert */
+#define SPMODE_CP	((ushort)0x1000)	/* Clock Phase */
+#define SPMODE_DIV16	((ushort)0x0800)	/* BRG/16 mode */
+#define SPMODE_REV	((ushort)0x0400)	/* Reversed Data */
+#define SPMODE_MSTR	((ushort)0x0200)	/* SPI Master */
+#define SPMODE_EN	((ushort)0x0100)	/* Enable */
+#define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
+#define SPMODE_LEN4	((ushort)0x0030)	/*  4 bits per char */
+#define SPMODE_LEN8	((ushort)0x0070)	/*  8 bits per char */
+#define SPMODE_LEN16	((ushort)0x00f0)	/* 16 bits per char */
+#define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
+
+/* SPIE fields */
+#define SPIE_MME	0x20
+#define SPIE_TXE	0x10
+#define SPIE_BSY	0x04
+#define SPIE_TXB	0x02
+#define SPIE_RXB	0x01
+
+/*
+ * RISC Controller Configuration Register definitons
+ */
+#define RCCR_TIME	0x8000			/* RISC Timer Enable */
+#define RCCR_TIMEP(t)	(((t) & 0x3F)<<8)	/* RISC Timer Period */
+#define RCCR_TIME_MASK	0x00FF			/* not RISC Timer related bits */
+
+/* RISC Timer Parameter RAM offset */
+#define PROFF_RTMR	((uint)0x01B0)
+
+typedef struct risc_timer_pram {
+	unsigned short	tm_base;	/* RISC Timer Table Base Address */
+	unsigned short	tm_ptr;		/* RISC Timer Table Pointer (internal) */
+	unsigned short	r_tmr;		/* RISC Timer Mode Register */
+	unsigned short	r_tmv;		/* RISC Timer Valid Register */
+	unsigned long	tm_cmd;		/* RISC Timer Command Register */
+	unsigned long	tm_cnt;		/* RISC Timer Internal Count */
+} rt_pram_t;
+
+/* Bits in RISC Timer Command Register */
+#define TM_CMD_VALID	0x80000000	/* Valid - Enables the timer */
+#define TM_CMD_RESTART	0x40000000	/* Restart - for automatic restart */
+#define TM_CMD_PWM	0x20000000	/* Run in Pulse Width Modulation Mode */
+#define TM_CMD_NUM(n)	(((n)&0xF)<<16)	/* Timer Number */
+#define TM_CMD_PERIOD(p) ((p)&0xFFFF)	/* Timer Period */
+
+/* CPM interrupts.  There are nearly 32 interrupts generated by CPM
+ * channels or devices.  All of these are presented to the PPC core
+ * as a single interrupt.  The CPM interrupt handler dispatches its
+ * own handlers, in a similar fashion to the PPC core handler.  We
+ * use the table as defined in the manuals (i.e. no special high
+ * priority and SCC1 == SCCa, etc...).
+ */
+#define CPMVEC_NR		32
+#define	CPMVEC_PIO_PC15		((ushort)0x1f)
+#define	CPMVEC_SCC1		((ushort)0x1e)
+#define	CPMVEC_SCC2		((ushort)0x1d)
+#define	CPMVEC_SCC3		((ushort)0x1c)
+#define	CPMVEC_SCC4		((ushort)0x1b)
+#define	CPMVEC_PIO_PC14		((ushort)0x1a)
+#define	CPMVEC_TIMER1		((ushort)0x19)
+#define	CPMVEC_PIO_PC13		((ushort)0x18)
+#define	CPMVEC_PIO_PC12		((ushort)0x17)
+#define	CPMVEC_SDMA_CB_ERR	((ushort)0x16)
+#define CPMVEC_IDMA1		((ushort)0x15)
+#define CPMVEC_IDMA2		((ushort)0x14)
+#define CPMVEC_TIMER2		((ushort)0x12)
+#define CPMVEC_RISCTIMER	((ushort)0x11)
+#define CPMVEC_I2C		((ushort)0x10)
+#define	CPMVEC_PIO_PC11		((ushort)0x0f)
+#define	CPMVEC_PIO_PC10		((ushort)0x0e)
+#define CPMVEC_TIMER3		((ushort)0x0c)
+#define	CPMVEC_PIO_PC9		((ushort)0x0b)
+#define	CPMVEC_PIO_PC8		((ushort)0x0a)
+#define	CPMVEC_PIO_PC7		((ushort)0x09)
+#define CPMVEC_TIMER4		((ushort)0x07)
+#define	CPMVEC_PIO_PC6		((ushort)0x06)
+#define	CPMVEC_SPI		((ushort)0x05)
+#define	CPMVEC_SMC1		((ushort)0x04)
+#define	CPMVEC_SMC2		((ushort)0x03)
+#define	CPMVEC_PIO_PC5		((ushort)0x02)
+#define	CPMVEC_PIO_PC4		((ushort)0x01)
+#define	CPMVEC_ERROR		((ushort)0x00)
+
+/* CPM interrupt configuration vector.
+*/
+#define	CICR_SCD_SCC4		((uint)0x00c00000)	/* SCC4 @ SCCd */
+#define	CICR_SCC_SCC3		((uint)0x00200000)	/* SCC3 @ SCCc */
+#define	CICR_SCB_SCC2		((uint)0x00040000)	/* SCC2 @ SCCb */
+#define	CICR_SCA_SCC1		((uint)0x00000000)	/* SCC1 @ SCCa */
+#define CICR_IRL_MASK		((uint)0x0000e000)	/* Core interrupt */
+#define CICR_HP_MASK		((uint)0x00001f00)	/* Hi-pri int. */
+#define CICR_IEN		((uint)0x00000080)	/* Int. enable */
+#define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
+
+extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
+extern void cpm_free_handler(int vec);
+
+#endif /* __CPM1__ */
-- 
1.5.3.8
