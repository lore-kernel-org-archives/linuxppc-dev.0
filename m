Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 42DE6DDE2C
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:42:18 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPV00B2DX2CZA50@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:12 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPV00MX3X2B7M60@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 13 Oct 2007 22:42:13 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPV00E6EX2ADVV0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:10 -0600 (MDT)
Date: Sat, 13 Oct 2007 22:42:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 5/7] bestcomm: ATA task support
In-reply-to: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com, domen.puncer@telargo.com
Message-id: <20071014044210.23438.18146.stgit@trillian.cg.shawcable.net>
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

This is the microcode for the ATA task and the associated
support code.

The microcode itself comes directly from the offical
API (v2.2)

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/Kconfig         |    7 +
 arch/powerpc/sysdev/bestcomm/Makefile        |    2 
 arch/powerpc/sysdev/bestcomm/ata.c           |  154 ++++++++++++++++++++++++++
 arch/powerpc/sysdev/bestcomm/ata.h           |   37 ++++++
 arch/powerpc/sysdev/bestcomm/bcom_ata_task.c |   67 +++++++++++
 5 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/bestcomm/Kconfig b/arch/powerpc/sysdev/bestcomm/Kconfig
index 3366e24..9d087ce 100644
--- a/arch/powerpc/sysdev/bestcomm/Kconfig
+++ b/arch/powerpc/sysdev/bestcomm/Kconfig
@@ -16,3 +16,10 @@ config PPC_BESTCOMM
 	  If you want to use drivers that require DMA operations,
 	  answer Y or M. Otherwise say N.
 
+config PPC_BESTCOMM_ATA
+	tristate "Bestcomm ATA task support"
+	depends on PPC_BESTCOMM
+	default n
+	help
+	  This option enables the support for the ATA task.
+
diff --git a/arch/powerpc/sysdev/bestcomm/Makefile b/arch/powerpc/sysdev/bestcomm/Makefile
index 8e33217..242d822 100644
--- a/arch/powerpc/sysdev/bestcomm/Makefile
+++ b/arch/powerpc/sysdev/bestcomm/Makefile
@@ -3,6 +3,8 @@
 #
 
 bestcomm-core-objs	:= bestcomm.o sram.o
+bestcomm-ata-objs	:= ata.o bcom_ata_task.o
 
 obj-y					+= bestcomm-core.o
+obj-$(CONFIG_PPC_BESTCOMM_ATA)		+= bestcomm-ata.o
  
diff --git a/arch/powerpc/sysdev/bestcomm/ata.c b/arch/powerpc/sysdev/bestcomm/ata.c
new file mode 100644
index 0000000..1f5258f
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/ata.c
@@ -0,0 +1,154 @@
+/*
+ * Bestcomm ATA task driver
+ *
+ *
+ * Patterned after bestcomm/fec.c by Dale Farnsworth <dfarnsworth@mvista.com>
+ *                                   2003-2004 (c) MontaVista, Software, Inc.
+ *
+ * Copyright (C) 2006-2007 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2006      Freescale - John Rigby
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <asm/io.h>
+
+#include "bestcomm.h"
+#include "bestcomm_priv.h"
+#include "ata.h"
+
+
+/* ======================================================================== */
+/* Task image/var/inc                                                       */
+/* ======================================================================== */
+
+/* ata task image */
+extern u32 bcom_ata_task[];
+
+/* ata task vars that need to be set before enabling the task */
+struct bcom_ata_var {
+	u32 enable;		/* (u16*) address of task's control register */
+	u32 bd_base;		/* (struct bcom_bd*) beginning of ring buffer */
+	u32 bd_last;		/* (struct bcom_bd*) end of ring buffer */
+	u32 bd_start;		/* (struct bcom_bd*) current bd */
+	u32 buffer_size;	/* size of receive buffer */
+};
+
+/* ata task incs that need to be set before enabling the task */
+struct bcom_ata_inc {
+	u16 pad0;
+	s16 incr_bytes;
+	u16 pad1;
+	s16 incr_dst;
+	u16 pad2;
+	s16 incr_src;
+};
+
+
+/* ======================================================================== */
+/* Task support code                                                        */
+/* ======================================================================== */
+
+struct bcom_task *
+bcom_ata_init(int queue_len, int maxbufsize)
+{
+	struct bcom_task *tsk;
+	struct bcom_ata_var *var;
+	struct bcom_ata_inc *inc;
+
+	tsk = bcom_task_alloc(queue_len, sizeof(struct bcom_ata_bd), 0);
+	if (!tsk)
+		return NULL;
+
+	tsk->flags = BCOM_FLAGS_NONE;
+
+	bcom_ata_reset_bd(tsk);
+
+	var = (struct bcom_ata_var *) bcom_task_var(tsk->tasknum);
+	inc = (struct bcom_ata_inc *) bcom_task_inc(tsk->tasknum);
+
+	if (bcom_load_image(tsk->tasknum, bcom_ata_task)) {
+		bcom_task_free(tsk);
+		return NULL;
+	}
+
+	var->enable	= bcom_eng->regs_base +
+				offsetof(struct mpc52xx_sdma, tcr[tsk->tasknum]);
+	var->bd_base	= tsk->bd_pa;
+	var->bd_last	= tsk->bd_pa + ((tsk->num_bd-1) * tsk->bd_size);
+	var->bd_start	= tsk->bd_pa;
+	var->buffer_size = maxbufsize;
+
+	/* Configure some stuff */
+	bcom_set_task_pragma(tsk->tasknum, BCOM_ATA_PRAGMA);
+	bcom_set_task_auto_start(tsk->tasknum, tsk->tasknum);
+
+	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ATA_RX], BCOM_IPR_ATA_RX);
+	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ATA_TX], BCOM_IPR_ATA_TX);
+
+	out_be32(&bcom_eng->regs->IntPend, 1<<tsk->tasknum); /* Clear ints */
+
+	return tsk;
+}
+EXPORT_SYMBOL_GPL(bcom_ata_init);
+
+void bcom_ata_rx_prepare(struct bcom_task *tsk)
+{
+	struct bcom_ata_inc *inc;
+
+	inc = (struct bcom_ata_inc *) bcom_task_inc(tsk->tasknum);
+
+	inc->incr_bytes	= -(s16)sizeof(u32);
+	inc->incr_src	= 0;
+	inc->incr_dst	= sizeof(u32);
+
+	bcom_set_initiator(tsk->tasknum, BCOM_INITIATOR_ATA_RX);
+}
+EXPORT_SYMBOL_GPL(bcom_ata_rx_prepare);
+
+void bcom_ata_tx_prepare(struct bcom_task *tsk)
+{
+	struct bcom_ata_inc *inc;
+
+	inc = (struct bcom_ata_inc *) bcom_task_inc(tsk->tasknum);
+
+	inc->incr_bytes	= -(s16)sizeof(u32);
+	inc->incr_src	= sizeof(u32);
+	inc->incr_dst	= 0;
+
+	bcom_set_initiator(tsk->tasknum, BCOM_INITIATOR_ATA_TX);
+}
+EXPORT_SYMBOL_GPL(bcom_ata_tx_prepare);
+
+void bcom_ata_reset_bd(struct bcom_task *tsk)
+{
+	struct bcom_ata_var *var;
+
+	/* Reset all BD */
+	memset(tsk->bd, 0x00, tsk->num_bd * tsk->bd_size);
+
+	tsk->index = 0;
+	tsk->outdex = 0;
+
+	var = (struct bcom_ata_var *) bcom_task_var(tsk->tasknum);
+	var->bd_start = var->bd_base;
+}
+EXPORT_SYMBOL_GPL(bcom_ata_reset_bd);
+
+void bcom_ata_release(struct bcom_task *tsk)
+{
+	/* Nothing special for the ATA tasks */
+	bcom_task_free(tsk);
+}
+EXPORT_SYMBOL_GPL(bcom_ata_release);
+
+
+MODULE_DESCRIPTION("BestComm ATA task driver");
+MODULE_AUTHOR("John Rigby");
+MODULE_LICENSE("GPL v2");
+
diff --git a/arch/powerpc/sysdev/bestcomm/ata.h b/arch/powerpc/sysdev/bestcomm/ata.h
new file mode 100644
index 0000000..1098276
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/ata.h
@@ -0,0 +1,37 @@
+/*
+ * Header for Bestcomm ATA task driver
+ *
+ *
+ * Copyright (C) 2006 Freescale - John Rigby
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __BESTCOMM_ATA_H__
+#define __BESTCOMM_ATA_H__
+
+
+struct bcom_ata_bd {
+	u32	status;
+	u32	dst_pa;
+	u32	src_pa;
+};
+
+extern struct bcom_task *
+bcom_ata_init(int queue_len, int maxbufsize);
+
+extern void
+bcom_ata_rx_prepare(struct bcom_task *tsk);
+
+extern void
+bcom_ata_tx_prepare(struct bcom_task *tsk);
+
+extern void
+bcom_ata_reset_bd(struct bcom_task *tsk);
+
+
+#endif /* __BESTCOMM_ATA_H__ */
+
diff --git a/arch/powerpc/sysdev/bestcomm/bcom_ata_task.c b/arch/powerpc/sysdev/bestcomm/bcom_ata_task.c
new file mode 100644
index 0000000..cc6049a
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bcom_ata_task.c
@@ -0,0 +1,67 @@
+/*
+ * Bestcomm ATA task microcode
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Created based on bestcom/code_dma/image_rtos1/dma_image.hex
+ */
+
+#include <asm/types.h>
+
+/*
+ * The header consists of the following fields:
+ *	u32	magic;
+ *	u8	desc_size;
+ *	u8	var_size;
+ *	u8	inc_size;
+ *	u8	first_var;
+ *	u8	reserved[8];
+ *
+ * The size fields contain the number of 32-bit words.
+ */
+
+u32 bcom_ata_task[] = {
+	/* header */
+	0x4243544b,
+	0x0e060709,
+	0x00000000,
+	0x00000000,
+
+	/* Task descriptors */
+	0x8198009b, /* LCD: idx0 = var3; idx0 <= var2; idx0 += inc3 */
+	0x13e00c08, /*   DRD1A: var3 = var1; FN=0 MORE init=31 WS=0 RS=0 */
+	0xb8000264, /*   LCD: idx1 = *idx0, idx2 = var0; idx1 < var9; idx1 += inc4, idx2 += inc4 */
+	0x10000f00, /*     DRD1A: var3 = idx0; FN=0 MORE init=0 WS=0 RS=0 */
+	0x60140002, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=2 EXT init=0 WS=2 RS=2 */
+	0x0c8cfc8a, /*     DRD2B1: *idx2 = EU3(); EU3(*idx2,var10)  */
+	0xd8988240, /*   LCDEXT: idx1 = idx1; idx1 > var9; idx1 += inc0 */
+	0xf845e011, /*   LCDEXT: idx2 = *(idx0 + var00000015); ; idx2 += inc2 */
+	0xb845e00a, /*   LCD: idx3 = *(idx0 + var00000019); ; idx3 += inc1 */
+	0x0bfecf90, /*     DRD1A: *idx3 = *idx2; FN=0 TFD init=31 WS=3 RS=3 */
+	0x9898802d, /*   LCD: idx1 = idx1; idx1 once var0; idx1 += inc5 */
+	0x64000005, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=5 INT EXT init=0 WS=0 RS=0 */
+	0x0c0cf849, /*     DRD2B1: *idx0 = EU3(); EU3(idx1,var9)  */
+	0x000001f8, /* NOP */
+
+	/* VAR[9]-VAR[14] */
+	0x40000000,
+	0x7fff7fff,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+
+	/* INC[0]-INC[6] */
+	0x40000000,
+	0xe0000000,
+	0xe0000000,
+	0xa000000c,
+	0x20000000,
+	0x00000000,
+	0x00000000,
+};
+
