Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id CF1DDDDE38
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:42:18 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPV00BZOX2DZB40@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:13 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPV00MXDX267J60@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 13 Oct 2007 22:42:14 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPV00AFLX25E312@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:05 -0600 (MDT)
Date: Sat, 13 Oct 2007 22:42:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale MPC5200
In-reply-to: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com, domen.puncer@telargo.com
Message-id: <20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sylvain Munaut <tnt@246tNt.com>

This patch adds support for the core of the BestComm API
for the Freescale MPC5200(b). The BestComm engine is a
microcode-controlled / tasks-based DMA used by several
of the onchip devices.

Setting up the tasks / memory allocation and all common
low level functions are handled by this patch.
The specifics details of each tasks and their microcode
are split-out in separate patches.

This is not the official API, but a much cleaner one.
(hopefully)

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/Kconfig               |    2 
 arch/powerpc/sysdev/Makefile                 |    1 
 arch/powerpc/sysdev/bestcomm/Kconfig         |   18 +
 arch/powerpc/sysdev/bestcomm/Makefile        |    8 
 arch/powerpc/sysdev/bestcomm/bestcomm.c      |  528 ++++++++++++++++++++++++++
 arch/powerpc/sysdev/bestcomm/bestcomm.h      |  190 +++++++++
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |  334 ++++++++++++++++
 arch/powerpc/sysdev/bestcomm/sram.c          |  177 +++++++++
 arch/powerpc/sysdev/bestcomm/sram.h          |   54 +++
 9 files changed, 1312 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 3724cb4..bdced1e 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -315,4 +315,6 @@ config FSL_ULI1575
 config CPM
 	bool
 
+source "arch/powerpc/sysdev/bestcomm/Kconfig"
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 1a6f564..99a77d7 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_PPC_BESTCOMM)	+= bestcomm/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
 				   mv64x60_udbg.o
diff --git a/arch/powerpc/sysdev/bestcomm/Kconfig b/arch/powerpc/sysdev/bestcomm/Kconfig
new file mode 100644
index 0000000..3366e24
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/Kconfig
@@ -0,0 +1,18 @@
+#
+# Kconfig options for Bestcomm
+#
+
+config PPC_BESTCOMM
+	tristate "Bestcomm DMA engine support"
+	depends on PPC_MPC52xx
+	default n
+	select PPC_LIB_RHEAP
+	help
+	  BestComm is the name of the communication coprocessor found
+	  on the Freescale MPC5200 family of processor. It's usage is
+	  optionnal for some drivers (like ATA), but required for
+	  others (like FEC).
+
+	  If you want to use drivers that require DMA operations,
+	  answer Y or M. Otherwise say N.
+
diff --git a/arch/powerpc/sysdev/bestcomm/Makefile b/arch/powerpc/sysdev/bestcomm/Makefile
new file mode 100644
index 0000000..8e33217
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for BestComm & co
+#
+
+bestcomm-core-objs	:= bestcomm.o sram.o
+
+obj-y					+= bestcomm-core.o
+ 
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
new file mode 100644
index 0000000..48492a8
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -0,0 +1,528 @@
+/*
+ * Driver for MPC52xx processor BestComm peripheral controller
+ *
+ *
+ * Copyright (C) 2006-2007 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2005      Varma Electronics Oy,
+ *                         ( by Andrey Volkov <avolkov@varma-el.com> )
+ * Copyright (C) 2003-2004 MontaVista, Software, Inc.
+ *                         ( by Dale Farnsworth <dfarnsworth@mvista.com> )
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mpc52xx.h>
+
+#include "sram.h"
+#include "bestcomm_priv.h"
+#include "bestcomm.h"
+
+#define DRIVER_NAME "bestcomm-core"
+
+
+struct bcom_engine *bcom_eng = NULL;
+EXPORT_SYMBOL_GPL(bcom_eng);	/* needed for inline functions */
+
+
+/* ======================================================================== */
+/* Public and private API                                                   */
+/* ======================================================================== */
+
+/* Private API */
+
+struct bcom_task *
+bcom_task_alloc(int bd_count, int bd_size, int priv_size)
+{
+	int i, tasknum = -1;
+	struct bcom_task *tsk;
+
+	/* Get and reserve a task num */
+	spin_lock(&bcom_eng->lock);
+
+	for (i=0; i<BCOM_MAX_TASKS; i++)
+		if (!bcom_eng->tdt[i].stop) {	/* we use stop as a marker */
+			bcom_eng->tdt[i].stop = 0xfffffffful; /* dummy addr */
+			tasknum = i;
+			break;
+		}
+
+	spin_unlock(&bcom_eng->lock);
+
+	if (tasknum < 0)
+		return NULL;
+
+	/* Allocate our structure */
+	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
+	if (!tsk)
+		goto error;
+
+	tsk->tasknum = tasknum;
+	if (priv_size)
+		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
+
+	/* Get IRQ of that task */
+	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
+	if (tsk->irq == NO_IRQ)
+		goto error;
+
+	/* Init the BDs, if needed */
+	if (bd_count) {
+		tsk->cookie = kmalloc(sizeof(void*) * bd_count, GFP_KERNEL);
+		if (!tsk->cookie)
+			goto error;
+
+		tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
+		if (!tsk->bd)
+			goto error;
+		memset(tsk->bd, 0x00, bd_count * bd_size);
+
+		tsk->num_bd = bd_count;
+		tsk->bd_size = bd_size;
+	}
+
+	return tsk;
+
+error:
+	if (tsk) {
+		if (tsk->irq != NO_IRQ)
+			irq_dispose_mapping(tsk->irq);
+		bcom_sram_free(tsk->bd);
+		kfree(tsk->cookie);
+		kfree(tsk);
+	}
+
+	bcom_eng->tdt[tasknum].stop = 0;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(bcom_task_alloc);
+
+void
+bcom_task_free(struct bcom_task *tsk)
+{
+	/* Stop the task */
+	bcom_disable_task(tsk->tasknum);
+
+	/* Clear TDT */
+	bcom_eng->tdt[tsk->tasknum].start = 0;
+	bcom_eng->tdt[tsk->tasknum].stop  = 0;
+
+	/* Free everything */
+	irq_dispose_mapping(tsk->irq);
+	bcom_sram_free(tsk->bd);
+	kfree(tsk->cookie);
+	kfree(tsk);
+}
+EXPORT_SYMBOL_GPL(bcom_task_free);
+
+int
+bcom_load_image(int task, u32 *task_image)
+{
+	struct bcom_task_header *hdr = (struct bcom_task_header *)task_image;
+	struct bcom_tdt *tdt;
+	u32 *desc, *var, *inc;
+	u32 *desc_src, *var_src, *inc_src;
+
+	/* Safety checks */
+	if (hdr->magic != BCOM_TASK_MAGIC) {
+		printk(KERN_ERR DRIVER_NAME
+			": Trying to load invalid microcode\n");
+		return -EINVAL;
+	}
+
+	if ((task < 0) || (task >= BCOM_MAX_TASKS)) {
+		printk(KERN_ERR DRIVER_NAME
+			": Trying to load invalid task %d\n", task);
+		return -EINVAL;
+	}
+
+	/* Initial load or reload */
+	tdt = &bcom_eng->tdt[task];
+
+	if (tdt->start) {
+		desc = bcom_task_desc(task);
+		if (hdr->desc_size != bcom_task_num_descs(task)) {
+			printk(KERN_ERR DRIVER_NAME
+				": Trying to reload wrong task image "
+				"(%d size %d/%d)!\n",
+				task,
+				hdr->desc_size,
+				bcom_task_num_descs(task));
+			return -EINVAL;
+		}
+	} else {
+		phys_addr_t start_pa;
+
+		desc = bcom_sram_alloc(hdr->desc_size * sizeof(u32), 4, &start_pa);
+		if (!desc)
+			return -ENOMEM;
+
+		tdt->start = start_pa;
+		tdt->stop = start_pa + ((hdr->desc_size-1) * sizeof(u32));
+	}
+
+	var = bcom_task_var(task);
+	inc = bcom_task_inc(task);
+
+	/* Clear & copy */
+	memset(var, 0x00, BCOM_VAR_SIZE);
+	memset(inc, 0x00, BCOM_INC_SIZE);
+
+	desc_src = (u32 *)(hdr + 1);
+	var_src = desc_src + hdr->desc_size;
+	inc_src = var_src + hdr->var_size;
+
+	memcpy(desc, desc_src, hdr->desc_size * sizeof(u32));
+	memcpy(var + hdr->first_var, var_src, hdr->var_size * sizeof(u32));
+	memcpy(inc, inc_src, hdr->inc_size * sizeof(u32));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcom_load_image);
+
+void
+bcom_set_initiator(int task, int initiator)
+{
+	int i;
+	int num_descs;
+	u32 *desc;
+	int next_drd_has_initiator;
+
+	bcom_set_tcr_initiator(task, initiator);
+
+	/* Just setting tcr is apparently not enough due to some problem */
+	/* with it. So we just go thru all the microcode and replace in  */
+	/* the DRD directly */
+
+	desc = bcom_task_desc(task);
+	next_drd_has_initiator = 1;
+	num_descs = bcom_task_num_descs(task);
+
+	for (i=0; i<num_descs; i++, desc++) {
+		if (!bcom_desc_is_drd(*desc))
+			continue;
+		if (next_drd_has_initiator)
+			if (bcom_desc_initiator(*desc) != BCOM_INITIATOR_ALWAYS)
+				bcom_set_desc_initiator(desc, initiator);
+		next_drd_has_initiator = !bcom_drd_is_extended(*desc);
+	}
+}
+EXPORT_SYMBOL_GPL(bcom_set_initiator);
+
+
+/* Public API */
+
+void
+bcom_enable(struct bcom_task *tsk)
+{
+	bcom_enable_task(tsk->tasknum);
+}
+EXPORT_SYMBOL_GPL(bcom_enable);
+
+void
+bcom_disable(struct bcom_task *tsk)
+{
+	bcom_disable_task(tsk->tasknum);
+}
+EXPORT_SYMBOL_GPL(bcom_disable);
+
+
+/* ======================================================================== */
+/* Engine init/cleanup                                                      */
+/* ======================================================================== */
+
+/* Function Descriptor table */
+/* this will need to be updated if Freescale changes their task code FDT */
+static u32 fdt_ops[] = {
+	0xa0045670,	/* FDT[48] - load_acc()	  */
+	0x80045670,	/* FDT[49] - unload_acc() */
+	0x21800000,	/* FDT[50] - and()        */
+	0x21e00000,	/* FDT[51] - or()         */
+	0x21500000,	/* FDT[52] - xor()        */
+	0x21400000,	/* FDT[53] - andn()       */
+	0x21500000,	/* FDT[54] - not()        */
+	0x20400000,	/* FDT[55] - add()        */
+	0x20500000,	/* FDT[56] - sub()        */
+	0x20800000,	/* FDT[57] - lsh()        */
+	0x20a00000,	/* FDT[58] - rsh()        */
+	0xc0170000,	/* FDT[59] - crc8()       */
+	0xc0145670,	/* FDT[60] - crc16()      */
+	0xc0345670,	/* FDT[61] - crc32()      */
+	0xa0076540,	/* FDT[62] - endian32()   */
+	0xa0000760,	/* FDT[63] - endian16()   */
+};
+
+
+static int __devinit
+bcom_engine_init(void)
+{
+	int task;
+	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
+	unsigned int tdt_size, ctx_size, var_size, fdt_size;
+
+	/* Allocate & clear SRAM zones for FDT, TDTs, contexts and vars/incs */
+	tdt_size = BCOM_MAX_TASKS * sizeof(struct bcom_tdt);
+	ctx_size = BCOM_MAX_TASKS * BCOM_CTX_SIZE;
+	var_size = BCOM_MAX_TASKS * (BCOM_VAR_SIZE + BCOM_INC_SIZE);
+	fdt_size = BCOM_FDT_SIZE;
+
+	bcom_eng->tdt = bcom_sram_alloc(tdt_size, sizeof(u32), &tdt_pa);
+	bcom_eng->ctx = bcom_sram_alloc(ctx_size, BCOM_CTX_ALIGN, &ctx_pa);
+	bcom_eng->var = bcom_sram_alloc(var_size, BCOM_VAR_ALIGN, &var_pa);
+	bcom_eng->fdt = bcom_sram_alloc(fdt_size, BCOM_FDT_ALIGN, &fdt_pa);
+
+	if (!bcom_eng->tdt || !bcom_eng->ctx || !bcom_eng->var || !bcom_eng->fdt) {
+		printk(KERN_ERR "DMA: SRAM alloc failed in engine init !\n");
+
+		bcom_sram_free(bcom_eng->tdt);
+		bcom_sram_free(bcom_eng->ctx);
+		bcom_sram_free(bcom_eng->var);
+		bcom_sram_free(bcom_eng->fdt);
+
+		return -ENOMEM;
+	}
+
+	memset(bcom_eng->tdt, 0x00, tdt_size);
+	memset(bcom_eng->ctx, 0x00, ctx_size);
+	memset(bcom_eng->var, 0x00, var_size);
+	memset(bcom_eng->fdt, 0x00, fdt_size);
+
+	/* Copy the FDT for the EU#3 */
+	memcpy(&bcom_eng->fdt[48], fdt_ops, sizeof(fdt_ops));
+
+	/* Initialize Task base structure */
+	for (task=0; task<BCOM_MAX_TASKS; task++)
+	{
+		out_be16(&bcom_eng->regs->tcr[task], 0);
+		out_8(&bcom_eng->regs->ipr[task], 0);
+
+		bcom_eng->tdt[task].context	= ctx_pa;
+		bcom_eng->tdt[task].var	= var_pa;
+		bcom_eng->tdt[task].fdt	= fdt_pa;
+
+		var_pa += BCOM_VAR_SIZE + BCOM_INC_SIZE;
+		ctx_pa += BCOM_CTX_SIZE;
+	}
+
+	out_be32(&bcom_eng->regs->taskBar, tdt_pa);
+
+	/* Init 'always' initiator */
+	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
+
+	/* Disable COMM Bus Prefetch, apparently it's not reliable yet */
+	/* FIXME: This should be done on 5200 and not 5200B ... */
+	out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);
+
+	/* Init lock */
+	spin_lock_init(&bcom_eng->lock);
+
+	return 0;
+}
+
+static void
+bcom_engine_cleanup(void)
+{
+	int task;
+
+	/* Stop all tasks */
+	for (task=0; task<BCOM_MAX_TASKS; task++)
+	{
+		out_be16(&bcom_eng->regs->tcr[task], 0);
+		out_8(&bcom_eng->regs->ipr[task], 0);
+	}
+
+	out_be32(&bcom_eng->regs->taskBar, 0ul);
+
+	/* Release the SRAM zones */
+	bcom_sram_free(bcom_eng->tdt);
+	bcom_sram_free(bcom_eng->ctx);
+	bcom_sram_free(bcom_eng->var);
+	bcom_sram_free(bcom_eng->fdt);
+}
+
+
+/* ======================================================================== */
+/* OF platform driver                                                       */
+/* ======================================================================== */
+
+static int __devinit
+mpc52xx_bcom_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct device_node *ofn_sram;
+	struct resource res_bcom;
+
+	int rv;
+
+	/* Inform user we're ok so far */
+	printk(KERN_INFO "DMA: MPC52xx BestComm driver\n");
+
+	/* Get the bestcomm node */
+	of_node_get(op->node);
+
+	/* Prepare SRAM */
+	ofn_sram = of_find_compatible_node(NULL, "sram", "mpc5200-sram");
+	if (!ofn_sram) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"No SRAM found in device tree\n");
+		rv = -ENODEV;
+		goto error_ofput;
+	}
+	rv = bcom_sram_init(ofn_sram, DRIVER_NAME);
+	of_node_put(ofn_sram);
+
+	if (rv) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"Error in SRAM init\n");
+		goto error_ofput;
+	}
+
+	/* Get a clean struct */
+	bcom_eng = kzalloc(sizeof(struct bcom_engine), GFP_KERNEL);
+	if (!bcom_eng) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"Can't allocate state structure\n");
+		rv = -ENOMEM;
+		goto error_sramclean;
+	}
+
+	/* Save the node */
+	bcom_eng->ofnode = op->node;
+
+	/* Get, reserve & map io */
+	if (of_address_to_resource(op->node, 0, &res_bcom)) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"Can't get resource\n");
+		rv = -EINVAL;
+		goto error_sramclean;
+	}
+
+	if (!request_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma),
+				DRIVER_NAME)) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"Can't request registers region\n");
+		rv = -EBUSY;
+		goto error_sramclean;
+	}
+
+	bcom_eng->regs_base = res_bcom.start;
+	bcom_eng->regs = ioremap(res_bcom.start, sizeof(struct mpc52xx_sdma));
+	if (!bcom_eng->regs) {
+		printk(KERN_ERR DRIVER_NAME ": "
+			"Can't map registers\n");
+		rv = -ENOMEM;
+		goto error_release;
+	}
+
+	/* Now, do the real init */
+	rv = bcom_engine_init();
+	if (rv)
+		goto error_unmap;
+
+	/* Done ! */
+	printk(KERN_INFO "DMA: MPC52xx BestComm engine @%08lx ok !\n",
+		bcom_eng->regs_base);
+
+	return 0;
+
+	/* Error path */
+error_unmap:
+	iounmap(bcom_eng->regs);
+error_release:
+	release_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma));
+error_sramclean:
+	kfree(bcom_eng);
+	bcom_sram_cleanup();
+error_ofput:
+	of_node_put(op->node);
+
+	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
+
+	return rv;
+}
+
+
+static int
+mpc52xx_bcom_remove(struct of_device *op)
+{
+	/* Clean up the engine */
+	bcom_engine_cleanup();
+
+	/* Cleanup SRAM */
+	bcom_sram_cleanup();
+
+	/* Release regs */
+	iounmap(bcom_eng->regs);
+	release_mem_region(bcom_eng->regs_base, sizeof(struct mpc52xx_sdma));
+
+	/* Release the node */
+	of_node_put(bcom_eng->ofnode);
+
+	/* Release memory */
+	kfree(bcom_eng);
+	bcom_eng = NULL;
+
+	return 0;
+}
+
+static struct of_device_id mpc52xx_bcom_of_match[] = {
+	{
+		.type		= "dma-controller",
+		.compatible	= "mpc5200-bestcomm",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mpc52xx_bcom_of_match);
+
+
+static struct of_platform_driver mpc52xx_bcom_of_platform_driver = {
+	.owner		= THIS_MODULE,
+	.name		= DRIVER_NAME,
+	.match_table	= mpc52xx_bcom_of_match,
+	.probe		= mpc52xx_bcom_probe,
+	.remove		= mpc52xx_bcom_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+
+/* ======================================================================== */
+/* Module                                                                   */
+/* ======================================================================== */
+
+static int __init
+mpc52xx_bcom_init(void)
+{
+	return of_register_platform_driver(&mpc52xx_bcom_of_platform_driver);
+}
+
+static void __exit
+mpc52xx_bcom_exit(void)
+{
+	of_unregister_platform_driver(&mpc52xx_bcom_of_platform_driver);
+}
+
+/* If we're not a module, we must make sure everything is setup before  */
+/* anyone tries to use us ... that's why we use subsys_initcall instead */
+/* of module_init. */
+subsys_initcall(mpc52xx_bcom_init);
+module_exit(mpc52xx_bcom_exit);
+
+MODULE_DESCRIPTION("Freescale MPC52xx BestComm DMA");
+MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
+MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
+MODULE_AUTHOR("Dale Farnsworth <dfarnsworth@mvista.com>");
+MODULE_LICENSE("GPL v2");
+
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.h b/arch/powerpc/sysdev/bestcomm/bestcomm.h
new file mode 100644
index 0000000..e802cb4
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.h
@@ -0,0 +1,190 @@
+/*
+ * Public header for the MPC52xx processor BestComm driver
+ *
+ *
+ * Copyright (C) 2006      Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2005      Varma Electronics Oy,
+ *                         ( by Andrey Volkov <avolkov@varma-el.com> )
+ * Copyright (C) 2003-2004 MontaVista, Software, Inc.
+ *                         ( by Dale Farnsworth <dfarnsworth@mvista.com> )
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __BESTCOMM_H__
+#define __BESTCOMM_H__
+
+struct bcom_bd; /* defined later on ... */
+
+
+/* ======================================================================== */
+/* Generic task managment                                                   */
+/* ======================================================================== */
+
+/**
+ * struct bcom_task - Structure describing a loaded BestComm task
+ *
+ * This structure is never built by the driver it self. It's built and
+ * filled the intermediate layer of the BestComm API, the task dependent
+ * support code.
+ *
+ * Most likely you don't need to poke around inside this structure. The
+ * fields are exposed in the header just for the sake of inline functions
+ */
+struct bcom_task {
+	unsigned int	tasknum;
+	unsigned int	flags;
+	int		irq;
+
+	struct bcom_bd	*bd;
+	phys_addr_t	bd_pa;
+	void		**cookie;
+	unsigned short	index;
+	unsigned short	outdex;
+	unsigned int	num_bd;
+	unsigned int	bd_size;
+
+	void*		priv;
+};
+
+#define BCOM_FLAGS_NONE         0x00000000ul
+#define BCOM_FLAGS_ENABLE_TASK  (1ul <<  0)
+
+/**
+ * bcom_enable - Enable a BestComm task
+ * @tsk: The BestComm task structure
+ *
+ * This function makes sure the given task is enabled and can be run
+ * by the BestComm engine as needed
+ */
+extern void bcom_enable(struct bcom_task *tsk);
+
+/**
+ * bcom_disable - Disable a BestComm task
+ * @tsk: The BestComm task structure
+ *
+ * This function disable a given task, making sure it's not executed
+ * by the BestComm engine.
+ */
+extern void bcom_disable(struct bcom_task *tsk);
+
+
+/**
+ * bcom_get_task_irq - Returns the irq number of a BestComm task
+ * @tsk: The BestComm task structure
+ */
+static inline int
+bcom_get_task_irq(struct bcom_task *tsk) {
+	return tsk->irq;
+}
+
+/* ======================================================================== */
+/* BD based tasks helpers                                                   */
+/* ======================================================================== */
+
+/**
+ * struct bcom_bd - Structure describing a generic BestComm buffer descriptor
+ * @status: The current status of this buffer. Exact meaning depends on the
+ *          task type
+ * @data: An array of u32 whose meaning depends on the task type.
+ */
+struct bcom_bd {
+	u32	status;
+	u32	data[1];	/* variable, but at least 1 */
+};
+
+#define BCOM_BD_READY	0x40000000ul
+
+/** _bcom_next_index - Get next input index.
+ * @tsk: pointer to task structure
+ *
+ * Support function; Device drivers should not call this
+ */
+static inline int
+_bcom_next_index(struct bcom_task *tsk)
+{
+	return ((tsk->index + 1) == tsk->num_bd) ? 0 : tsk->index + 1;
+}
+
+/** _bcom_next_outdex - Get next output index.
+ * @tsk: pointer to task structure
+ *
+ * Support function; Device drivers should not call this
+ */
+static inline int
+_bcom_next_outdex(struct bcom_task *tsk)
+{
+	return ((tsk->outdex + 1) == tsk->num_bd) ? 0 : tsk->outdex + 1;
+}
+
+/**
+ * bcom_queue_empty - Checks if a BestComm task BD queue is empty
+ * @tsk: The BestComm task structure
+ */
+static inline int
+bcom_queue_empty(struct bcom_task *tsk)
+{
+	return tsk->index == tsk->outdex;
+}
+
+/**
+ * bcom_queue_full - Checks if a BestComm task BD queue is full
+ * @tsk: The BestComm task structure
+ */
+static inline int
+bcom_queue_full(struct bcom_task *tsk)
+{
+	return tsk->outdex == _bcom_next_index(tsk);
+}
+
+/**
+ * bcom_buffer_done - Checks if a BestComm 
+ * @tsk: The BestComm task structure
+ */
+static inline int
+bcom_buffer_done(struct bcom_task *tsk)
+{
+	if (bcom_queue_empty(tsk))
+		return 0;
+	return !(tsk->bd[tsk->outdex].status & BCOM_BD_READY);
+}
+
+/**
+ * bcom_prepare_next_buffer - clear status of next available buffer.
+ * @tsk: The BestComm task structure
+ *
+ * Returns pointer to next buffer descriptor
+ */
+static inline struct bcom_bd *
+bcom_prepare_next_buffer(struct bcom_task *tsk)
+{
+	tsk->bd[tsk->index].status = 0;	/* cleanup last status */
+	return &tsk->bd[tsk->index];
+}
+
+static inline void
+bcom_submit_next_buffer(struct bcom_task *tsk, void *cookie)
+{
+	tsk->cookie[tsk->index] = cookie;
+	mb();	/* ensure the bd is really up-to-date */
+	tsk->bd[tsk->index].status |= BCOM_BD_READY;
+	tsk->index = _bcom_next_index(tsk);
+	if (tsk->flags & BCOM_FLAGS_ENABLE_TASK)
+		bcom_enable(tsk);
+}
+
+static inline void *
+bcom_retrieve_buffer(struct bcom_task *tsk, u32 *p_status, struct bcom_bd **p_bd)
+{
+	void *cookie = tsk->cookie[tsk->outdex];
+	if (p_status)
+		*p_status = tsk->bd[tsk->outdex].status;
+	if (p_bd)
+		*p_bd = &tsk->bd[tsk->outdex];
+	tsk->outdex = _bcom_next_outdex(tsk);
+	return cookie;
+}
+
+#endif /* __BESTCOMM_H__ */
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
new file mode 100644
index 0000000..866a291
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
@@ -0,0 +1,334 @@
+/*
+ * Private header for the MPC52xx processor BestComm driver
+ *
+ * By private, we mean that driver should not use it directly. It's meant
+ * to be used by the BestComm engine driver itself and by the intermediate
+ * layer between the core and the drivers.
+ *
+ * Copyright (C) 2006      Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2005      Varma Electronics Oy,
+ *                         ( by Andrey Volkov <avolkov@varma-el.com> )
+ * Copyright (C) 2003-2004 MontaVista, Software, Inc.
+ *                         ( by Dale Farnsworth <dfarnsworth@mvista.com> )
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __BESTCOMM_PRIV_H__
+#define __BESTCOMM_PRIV_H__
+
+#include <linux/spinlock.h>
+#include <linux/of.h>
+#include <asm/io.h>
+#include <asm/mpc52xx.h>
+
+#include "sram.h"
+
+
+/* ======================================================================== */
+/* Engine related stuff                                                     */
+/* ======================================================================== */
+
+/* Zones sizes and needed alignments */
+#define BCOM_MAX_TASKS		16
+#define BCOM_MAX_VAR		24
+#define BCOM_MAX_INC		8
+#define BCOM_MAX_FDT		64
+#define BCOM_MAX_CTX		20
+#define BCOM_CTX_SIZE		(BCOM_MAX_CTX * sizeof(u32))
+#define BCOM_CTX_ALIGN		0x100
+#define BCOM_VAR_SIZE		(BCOM_MAX_VAR * sizeof(u32))
+#define BCOM_INC_SIZE		(BCOM_MAX_INC * sizeof(u32))
+#define BCOM_VAR_ALIGN		0x80
+#define BCOM_FDT_SIZE		(BCOM_MAX_FDT * sizeof(u32))
+#define BCOM_FDT_ALIGN		0x100
+
+/**
+ * struct bcom_tdt - Task Descriptor Table Entry
+ *
+ */
+struct bcom_tdt {
+	u32 start;
+	u32 stop;
+	u32 var;
+	u32 fdt;
+	u32 exec_status;	/* used internally by BestComm engine */
+	u32 mvtp;		/* used internally by BestComm engine */
+	u32 context;
+	u32 litbase;
+};
+
+/**
+ * struct bcom_engine
+ *
+ * This holds all info needed globaly to handle the engine
+ */
+struct bcom_engine {
+	struct device_node		*ofnode;
+	struct mpc52xx_sdma __iomem     *regs;
+	phys_addr_t                      regs_base;
+
+	struct bcom_tdt			*tdt;
+	u32				*ctx;
+	u32				*var;
+	u32				*fdt;
+
+	spinlock_t			lock;
+};
+
+extern struct bcom_engine *bcom_eng;
+
+
+/* ======================================================================== */
+/* Tasks related stuff                                                      */
+/* ======================================================================== */
+
+/* Tasks image header */
+#define BCOM_TASK_MAGIC		0x4243544B	/* 'BCTK' */
+
+struct bcom_task_header {
+	u32	magic;
+	u8	desc_size;	/* the size fields     */
+	u8	var_size;	/* are given in number */
+	u8	inc_size;	/* of 32-bits words    */
+	u8	first_var;
+	u8	reserved[8];
+};
+
+/* Descriptors stucture & co */
+#define BCOM_DESC_NOP		0x000001f8
+#define BCOM_LCD_MASK		0x80000000
+#define BCOM_DRD_EXTENDED	0x40000000
+#define BCOM_DRD_INITIATOR_SHIFT	21
+
+/* Tasks pragma */
+#define BCOM_PRAGMA_BIT_RSV		7	/* reserved pragma bit */
+#define BCOM_PRAGMA_BIT_PRECISE_INC	6	/* increment 0=when possible, */
+						/*           1=iter end */
+#define BCOM_PRAGMA_BIT_RST_ERROR_NO	5	/* don't reset errors on */
+						/* task enable */
+#define BCOM_PRAGMA_BIT_PACK		4	/* pack data enable */
+#define BCOM_PRAGMA_BIT_INTEGER		3	/* data alignment */
+						/* 0=frac(msb), 1=int(lsb) */
+#define BCOM_PRAGMA_BIT_SPECREAD	2	/* XLB speculative read */
+#define BCOM_PRAGMA_BIT_CW		1	/* write line buffer enable */
+#define BCOM_PRAGMA_BIT_RL		0	/* read line buffer enable */
+
+	/* Looks like XLB speculative read generates XLB errors when a buffer
+	 * is at the end of the physical memory. i.e. when accessing the
+	 * lasts words, the engine tries to prefetch the next but there is no
+	 * next ...
+	 */
+#define BCOM_STD_PRAGMA		((0 << BCOM_PRAGMA_BIT_RSV)		| \
+				 (0 << BCOM_PRAGMA_BIT_PRECISE_INC)	| \
+				 (0 << BCOM_PRAGMA_BIT_RST_ERROR_NO)	| \
+				 (0 << BCOM_PRAGMA_BIT_PACK)		| \
+				 (0 << BCOM_PRAGMA_BIT_INTEGER)		| \
+				 (0 << BCOM_PRAGMA_BIT_SPECREAD)	| \
+				 (1 << BCOM_PRAGMA_BIT_CW)		| \
+				 (1 << BCOM_PRAGMA_BIT_RL))
+
+#define BCOM_PCI_PRAGMA		((0 << BCOM_PRAGMA_BIT_RSV)		| \
+				 (0 << BCOM_PRAGMA_BIT_PRECISE_INC)	| \
+				 (0 << BCOM_PRAGMA_BIT_RST_ERROR_NO)	| \
+				 (0 << BCOM_PRAGMA_BIT_PACK)		| \
+				 (1 << BCOM_PRAGMA_BIT_INTEGER)		| \
+				 (0 << BCOM_PRAGMA_BIT_SPECREAD)	| \
+				 (1 << BCOM_PRAGMA_BIT_CW)		| \
+				 (1 << BCOM_PRAGMA_BIT_RL))
+
+#define BCOM_ATA_PRAGMA		BCOM_STD_PRAGMA
+#define BCOM_CRC16_DP_0_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_CRC16_DP_1_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_FEC_RX_BD_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_FEC_TX_BD_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_0_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_1_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_2_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_3_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_BD_0_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_DP_BD_1_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_RX_BD_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_TX_BD_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_GEN_LPC_PRAGMA	BCOM_STD_PRAGMA
+#define BCOM_PCI_RX_PRAGMA	BCOM_PCI_PRAGMA
+#define BCOM_PCI_TX_PRAGMA	BCOM_PCI_PRAGMA
+
+/* Initiators number */
+#define BCOM_INITIATOR_ALWAYS	 0
+#define BCOM_INITIATOR_SCTMR_0	 1
+#define BCOM_INITIATOR_SCTMR_1	 2
+#define BCOM_INITIATOR_FEC_RX	 3
+#define BCOM_INITIATOR_FEC_TX	 4
+#define BCOM_INITIATOR_ATA_RX	 5
+#define BCOM_INITIATOR_ATA_TX	 6
+#define BCOM_INITIATOR_SCPCI_RX	 7
+#define BCOM_INITIATOR_SCPCI_TX	 8
+#define BCOM_INITIATOR_PSC3_RX	 9
+#define BCOM_INITIATOR_PSC3_TX	10
+#define BCOM_INITIATOR_PSC2_RX	11
+#define BCOM_INITIATOR_PSC2_TX	12
+#define BCOM_INITIATOR_PSC1_RX	13
+#define BCOM_INITIATOR_PSC1_TX	14
+#define BCOM_INITIATOR_SCTMR_2	15
+#define BCOM_INITIATOR_SCLPC	16
+#define BCOM_INITIATOR_PSC5_RX	17
+#define BCOM_INITIATOR_PSC5_TX	18
+#define BCOM_INITIATOR_PSC4_RX	19
+#define BCOM_INITIATOR_PSC4_TX	20
+#define BCOM_INITIATOR_I2C2_RX	21
+#define BCOM_INITIATOR_I2C2_TX	22
+#define BCOM_INITIATOR_I2C1_RX	23
+#define BCOM_INITIATOR_I2C1_TX	24
+#define BCOM_INITIATOR_PSC6_RX	25
+#define BCOM_INITIATOR_PSC6_TX	26
+#define BCOM_INITIATOR_IRDA_RX	25
+#define BCOM_INITIATOR_IRDA_TX	26
+#define BCOM_INITIATOR_SCTMR_3	27
+#define BCOM_INITIATOR_SCTMR_4	28
+#define BCOM_INITIATOR_SCTMR_5	29
+#define BCOM_INITIATOR_SCTMR_6	30
+#define BCOM_INITIATOR_SCTMR_7	31
+
+/* Initiators priorities */
+#define BCOM_IPR_ALWAYS		7
+#define BCOM_IPR_SCTMR_0	2
+#define BCOM_IPR_SCTMR_1	2
+#define BCOM_IPR_FEC_RX		6
+#define BCOM_IPR_FEC_TX		5
+#define BCOM_IPR_ATA_RX		4
+#define BCOM_IPR_ATA_TX		3
+#define BCOM_IPR_SCPCI_RX	2
+#define BCOM_IPR_SCPCI_TX	2
+#define BCOM_IPR_PSC3_RX	2
+#define BCOM_IPR_PSC3_TX	2
+#define BCOM_IPR_PSC2_RX	2
+#define BCOM_IPR_PSC2_TX	2
+#define BCOM_IPR_PSC1_RX	2
+#define BCOM_IPR_PSC1_TX	2
+#define BCOM_IPR_SCTMR_2	2
+#define BCOM_IPR_SCLPC		2
+#define BCOM_IPR_PSC5_RX	2
+#define BCOM_IPR_PSC5_TX	2
+#define BCOM_IPR_PSC4_RX	2
+#define BCOM_IPR_PSC4_TX	2
+#define BCOM_IPR_I2C2_RX	2
+#define BCOM_IPR_I2C2_TX	2
+#define BCOM_IPR_I2C1_RX	2
+#define BCOM_IPR_I2C1_TX	2
+#define BCOM_IPR_PSC6_RX	2
+#define BCOM_IPR_PSC6_TX	2
+#define BCOM_IPR_IRDA_RX	2
+#define BCOM_IPR_IRDA_TX	2
+#define BCOM_IPR_SCTMR_3	2
+#define BCOM_IPR_SCTMR_4	2
+#define BCOM_IPR_SCTMR_5	2
+#define BCOM_IPR_SCTMR_6	2
+#define BCOM_IPR_SCTMR_7	2
+
+
+/* ======================================================================== */
+/* API                                                                      */
+/* ======================================================================== */
+
+extern struct bcom_task *bcom_task_alloc(int bd_count, int bd_size, int priv_size);
+extern void bcom_task_free(struct bcom_task *tsk);
+extern int bcom_load_image(int task, u32 *task_image);
+extern void bcom_set_initiator(int task, int initiator);
+
+
+#define TASK_ENABLE             0x8000
+
+static inline void
+bcom_enable_task(int task)
+{
+        u16 reg;
+        reg = in_be16(&bcom_eng->regs->tcr[task]);
+        out_be16(&bcom_eng->regs->tcr[task],  reg | TASK_ENABLE);
+}
+
+static inline void
+bcom_disable_task(int task)
+{
+        u16 reg = in_be16(&bcom_eng->regs->tcr[task]);
+        out_be16(&bcom_eng->regs->tcr[task], reg & ~TASK_ENABLE);
+}
+
+
+static inline u32 *
+bcom_task_desc(int task)
+{
+	return bcom_sram_pa2va(bcom_eng->tdt[task].start);
+}
+
+static inline int
+bcom_task_num_descs(int task)
+{
+	return (bcom_eng->tdt[task].stop - bcom_eng->tdt[task].start)/sizeof(u32) + 1;
+}
+
+static inline u32 *
+bcom_task_var(int task)
+{
+	return bcom_sram_pa2va(bcom_eng->tdt[task].var);
+}
+
+static inline u32 *
+bcom_task_inc(int task)
+{
+	return &bcom_task_var(task)[BCOM_MAX_VAR];
+}
+
+
+static inline int
+bcom_drd_is_extended(u32 desc)
+{
+	return (desc) & BCOM_DRD_EXTENDED;
+}
+
+static inline int
+bcom_desc_is_drd(u32 desc)
+{
+	return !(desc & BCOM_LCD_MASK) && desc != BCOM_DESC_NOP;
+}
+
+static inline int
+bcom_desc_initiator(u32 desc)
+{
+	return (desc >> BCOM_DRD_INITIATOR_SHIFT) & 0x1f;
+}
+
+static inline void
+bcom_set_desc_initiator(u32 *desc, int initiator)
+{
+	*desc = (*desc & ~(0x1f << BCOM_DRD_INITIATOR_SHIFT)) |
+			((initiator & 0x1f) << BCOM_DRD_INITIATOR_SHIFT);
+}
+
+
+static inline void
+bcom_set_task_pragma(int task, int pragma)
+{
+	u32 *fdt = &bcom_eng->tdt[task].fdt;
+	*fdt = (*fdt & ~0xff) | pragma;
+}
+
+static inline void
+bcom_set_task_auto_start(int task, int next_task)
+{
+	u16 __iomem *tcr = &bcom_eng->regs->tcr[task];
+	out_be16(tcr, (in_be16(tcr) & ~0xff) | 0x00c0 | next_task);
+}
+
+static inline void
+bcom_set_tcr_initiator(int task, int initiator)
+{
+	u16 __iomem *tcr = &bcom_eng->regs->tcr[task];
+	out_be16(tcr, (in_be16(tcr) & ~0x1f00) | ((initiator & 0x1f) << 8));
+}
+
+
+#endif /* __BESTCOMM_PRIV_H__ */
+
diff --git a/arch/powerpc/sysdev/bestcomm/sram.c b/arch/powerpc/sysdev/bestcomm/sram.c
new file mode 100644
index 0000000..b3f2ed1
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/sram.c
@@ -0,0 +1,177 @@
+/*
+ * Simple memory allocator for on-board SRAM
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+
+#include <asm/io.h>
+#include <asm/mmu.h>
+
+#include "sram.h"
+
+
+/* Struct keeping our 'state' */
+struct bcom_sram *bcom_sram = NULL;
+EXPORT_SYMBOL_GPL(bcom_sram);	/* needed for inline functions */
+
+
+/* ======================================================================== */
+/* Public API                                                               */
+/* ======================================================================== */
+/* DO NOT USE in interrupts, if needed in irq handler, we should use the
+   _irqsave version of the spin_locks */
+
+int bcom_sram_init(struct device_node *sram_node, char *owner)
+{
+	int rv;
+	const u32 *regaddr_p;
+	u64 regaddr64, size64;
+	unsigned int psize;
+
+	/* Create our state struct */
+	if (bcom_sram) {
+		printk(KERN_ERR "%s: bcom_sram_init: "
+			"Already initialiwed !\n", owner);
+		return -EBUSY;
+	}
+
+	bcom_sram = kmalloc(sizeof(struct bcom_sram), GFP_KERNEL);
+	if (!bcom_sram) {
+		printk(KERN_ERR "%s: bcom_sram_init: "
+			"Couldn't allocate internal state !\n", owner);
+		return -ENOMEM;
+	}
+
+	/* Get address and size of the sram */
+	regaddr_p = of_get_address(sram_node, 0, &size64, NULL);
+	if (!regaddr_p) {
+		printk(KERN_ERR "%s: bcom_sram_init: "
+			"Invalid device node !\n", owner);
+		rv = -EINVAL;
+		goto error_free;
+	}
+
+	regaddr64 = of_translate_address(sram_node, regaddr_p);
+
+	bcom_sram->base_phys = (phys_addr_t) regaddr64;
+	bcom_sram->size = (unsigned int) size64;
+
+	/* Request region */
+	if (!request_mem_region(bcom_sram->base_phys, bcom_sram->size, owner)) {
+		printk(KERN_ERR "%s: bcom_sram_init: "
+			"Couln't request region !\n", owner);
+		rv = -EBUSY;
+		goto error_free;
+	}
+
+	/* Map SRAM */
+		/* sram is not really __iomem */
+	bcom_sram->base_virt = (void*) ioremap(bcom_sram->base_phys, bcom_sram->size);
+
+	if (!bcom_sram->base_virt) {
+		printk(KERN_ERR "%s: bcom_sram_init: "
+			"Map error SRAM zone 0x%08lx (0x%0x)!\n",
+			owner, bcom_sram->base_phys, bcom_sram->size );
+		rv = -ENOMEM;
+		goto error_release;
+	}
+
+	/* Create an rheap (defaults to 32 bits word alignment) */
+	bcom_sram->rh = rh_create(4);
+
+	/* Attach the free zones */
+#if 0
+	/* Currently disabled ... for future use only */
+	reg_addr_p = of_get_property(sram_node, "available", &psize);
+#else
+	regaddr_p = NULL;
+	psize = 0;
+#endif
+
+	if (!regaddr_p || !psize) {
+		/* Attach the whole zone */
+		rh_attach_region(bcom_sram->rh, 0, bcom_sram->size);
+	} else {
+		/* Attach each zone independently */
+		while (psize >= 2 * sizeof(u32)) {
+			phys_addr_t zbase = of_translate_address(sram_node, regaddr_p);
+			rh_attach_region(bcom_sram->rh, zbase - bcom_sram->base_phys, regaddr_p[1]);
+			regaddr_p += 2;
+			psize -= 2 * sizeof(u32);
+		}
+	}
+
+	/* Init our spinlock */
+	spin_lock_init(&bcom_sram->lock);
+
+	return 0;
+
+error_release:
+	release_mem_region(bcom_sram->base_phys, bcom_sram->size);
+error_free:
+	kfree(bcom_sram);
+	bcom_sram = NULL;
+
+	return rv;
+}
+EXPORT_SYMBOL_GPL(bcom_sram_init);
+
+void bcom_sram_cleanup(void)
+{
+	/* Free resources */
+	if (bcom_sram) {
+		rh_destroy(bcom_sram->rh);
+		iounmap((void __iomem *)bcom_sram->base_virt);
+		release_mem_region(bcom_sram->base_phys, bcom_sram->size);
+		kfree(bcom_sram);
+		bcom_sram = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(bcom_sram_cleanup);
+
+void* bcom_sram_alloc(int size, int align, phys_addr_t *phys)
+{
+	unsigned long offset;
+
+	spin_lock(&bcom_sram->lock);
+	offset = rh_alloc_align(bcom_sram->rh, size, align, NULL);
+	spin_unlock(&bcom_sram->lock);
+
+	if (IS_ERR_VALUE(offset))
+		return NULL;
+
+	*phys = bcom_sram->base_phys + offset;
+	return bcom_sram->base_virt + offset;
+}
+EXPORT_SYMBOL_GPL(bcom_sram_alloc);
+
+void bcom_sram_free(void *ptr)
+{
+	unsigned long offset;
+
+	if (!ptr)
+		return;
+
+	offset = ptr - bcom_sram->base_virt;
+
+	spin_lock(&bcom_sram->lock);
+	rh_free(bcom_sram->rh, offset);
+	spin_unlock(&bcom_sram->lock);
+}
+EXPORT_SYMBOL_GPL(bcom_sram_free);
+
diff --git a/arch/powerpc/sysdev/bestcomm/sram.h b/arch/powerpc/sysdev/bestcomm/sram.h
new file mode 100644
index 0000000..b6d6689
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/sram.h
@@ -0,0 +1,54 @@
+/*
+ * Handling of a sram zone for bestcomm
+ *
+ *
+ * Copyright (C) 2007 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __BESTCOMM_SRAM_H__
+#define __BESTCOMM_SRAM_H__
+
+#include <asm/rheap.h>
+#include <asm/mmu.h>
+#include <linux/spinlock.h>
+
+
+/* Structure used internally */
+	/* The internals are here for the inline functions
+	 * sake, certainly not for the user to mess with !
+	 */
+struct bcom_sram {
+	phys_addr_t		 base_phys;
+	void 			*base_virt;
+	unsigned int		 size;
+	rh_info_t		*rh;
+	spinlock_t		 lock;
+};
+
+extern struct bcom_sram *bcom_sram;
+
+
+/* Public API */
+extern int  bcom_sram_init(struct device_node *sram_node, char *owner);
+extern void bcom_sram_cleanup(void);
+
+extern void* bcom_sram_alloc(int size, int align, phys_addr_t *phys);
+extern void  bcom_sram_free(void *ptr);
+
+static inline phys_addr_t bcom_sram_va2pa(void *va) {
+	return bcom_sram->base_phys +
+		(unsigned long)(va - bcom_sram->base_virt);
+}
+
+static inline void *bcom_sram_pa2va(phys_addr_t pa) {
+	return bcom_sram->base_virt +
+		(unsigned long)(pa - bcom_sram->base_phys);
+}
+
+
+#endif  /* __BESTCOMM_SRAM_H__ */
+
