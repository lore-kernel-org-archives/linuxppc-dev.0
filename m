Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 78A47DDEEF
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:42:26 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPV00B34X2OZA50@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:24 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPV00F64X2L0J30@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 13 Oct 2007 22:42:24 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPV00A6SX2KE5X1@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 13 Oct 2007 22:42:20 -0600 (MDT)
Date: Sat, 13 Oct 2007 22:42:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 7/7] bestcomm: GenBD task support
In-reply-to: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	tnt@246tnt.com, domen.puncer@telargo.com
Message-id: <20071014044220.23438.1333.stgit@trillian.cg.shawcable.net>
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

This is the microcode for the GenBD task and the associated
support code. This is a generic task that copy data to/from
a hardware FIFO. This is currently locked to 32bits wide
access but could be extended as needed.

The microcode itself comes directly from the offical
API (v2.2)

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/Kconfig               |    7 +
 arch/powerpc/sysdev/bestcomm/Makefile              |    2 
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c |   63 +++++
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c |   69 +++++
 arch/powerpc/sysdev/bestcomm/gen_bd.c              |  260 ++++++++++++++++++++
 arch/powerpc/sysdev/bestcomm/gen_bd.h              |   48 ++++
 6 files changed, 449 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/bestcomm/Kconfig b/arch/powerpc/sysdev/bestcomm/Kconfig
index 831763b..57cc565 100644
--- a/arch/powerpc/sysdev/bestcomm/Kconfig
+++ b/arch/powerpc/sysdev/bestcomm/Kconfig
@@ -30,3 +30,10 @@ config PPC_BESTCOMM_FEC
 	help
 	  This option enables the support for the FEC tasks.
 
+config PPC_BESTCOMM_GEN_BD
+	tristate "Bestcomm GenBD tasks support"
+	depends on PPC_BESTCOMM
+	default n
+	help
+	  This option enables the support for the GenBD tasks.
+
diff --git a/arch/powerpc/sysdev/bestcomm/Makefile b/arch/powerpc/sysdev/bestcomm/Makefile
index 43046cf..095981a 100644
--- a/arch/powerpc/sysdev/bestcomm/Makefile
+++ b/arch/powerpc/sysdev/bestcomm/Makefile
@@ -5,8 +5,10 @@
 bestcomm-core-objs	:= bestcomm.o sram.o
 bestcomm-ata-objs	:= ata.o bcom_ata_task.o
 bestcomm-fec-objs	:= fec.o bcom_fec_rx_task.o bcom_fec_tx_task.o
+bestcomm-gen-bd-objs	:= gen_bd.o bcom_gen_bd_rx_task.o bcom_gen_bd_tx_task.o
 
 obj-y					+= bestcomm-core.o
 obj-$(CONFIG_PPC_BESTCOMM_ATA)		+= bestcomm-ata.o
 obj-$(CONFIG_PPC_BESTCOMM_FEC)		+= bestcomm-fec.o
+obj-$(CONFIG_PPC_BESTCOMM_GEN_BD)	+= bestcomm-gen-bd.o
  
diff --git a/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c b/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c
new file mode 100644
index 0000000..efee022
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c
@@ -0,0 +1,63 @@
+/*
+ * Bestcomm GenBD RX task microcode
+ *
+ * Copyright (C) 2006 AppSpec Computer Technologies Corp.
+ *                    Jeff Gibbons <jeff.gibbons@appspec.com>
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Based on BestCommAPI-2.2/code_dma/image_rtos1/dma_image.hex
+ * on Tue Mar 4 10:14:12 2006 GMT
+ *
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
+u32 bcom_gen_bd_rx_task[] = {
+	/* header */
+	0x4243544b,
+	0x0d020409,
+	0x00000000,
+	0x00000000,
+
+	/* Task descriptors */
+	0x808220da, /* LCD: idx0 = var1, idx1 = var4; idx1 <= var3; idx0 += inc3, idx1 += inc2 */
+	0x13e01010, /*   DRD1A: var4 = var2; FN=0 MORE init=31 WS=0 RS=0 */
+	0xb880025b, /*   LCD: idx2 = *idx1, idx3 = var0; idx2 < var9; idx2 += inc3, idx3 += inc3 */
+	0x10001308, /*     DRD1A: var4 = idx1; FN=0 MORE init=0 WS=0 RS=0 */
+	0x60140002, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=2 EXT init=0 WS=2 RS=2 */
+	0x0cccfcca, /*     DRD2B1: *idx3 = EU3(); EU3(*idx3,var10)  */
+	0xd9190240, /*   LCDEXT: idx2 = idx2; idx2 > var9; idx2 += inc0 */
+	0xb8c5e009, /*   LCD: idx3 = *(idx1 + var00000015); ; idx3 += inc1 */
+	0x07fecf80, /*     DRD1A: *idx3 = *idx0; FN=0 INT init=31 WS=3 RS=3 */
+	0x99190024, /*   LCD: idx2 = idx2; idx2 once var0; idx2 += inc4 */
+	0x60000005, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=5 EXT init=0 WS=0 RS=0 */
+	0x0c4cf889, /*     DRD2B1: *idx1 = EU3(); EU3(idx2,var9)  */
+	0x000001f8, /*   NOP */
+
+	/* VAR[9]-VAR[10] */
+	0x40000000,
+	0x7fff7fff,
+
+	/* INC[0]-INC[3] */
+	0x40000000,
+	0xe0000000,
+	0xa0000008,
+	0x20000000,
+};
+
diff --git a/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c b/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c
new file mode 100644
index 0000000..c605aa4
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c
@@ -0,0 +1,69 @@
+/*
+ * Bestcomm GenBD TX task microcode
+ *
+ * Copyright (C) 2006 AppSpec Computer Technologies Corp.
+ *                    Jeff Gibbons <jeff.gibbons@appspec.com>
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Based on BestCommAPI-2.2/code_dma/image_rtos1/dma_image.hex
+ * on Tue Mar 4 10:14:12 2006 GMT
+ *
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
+u32 bcom_gen_bd_tx_task[] = {
+	/* header */
+	0x4243544b,
+	0x0f040609,
+	0x00000000,
+	0x00000000,
+
+	/* Task descriptors */
+	0x800220e3, /* LCD: idx0 = var0, idx1 = var4; idx1 <= var3; idx0 += inc4, idx1 += inc3 */
+	0x13e01010, /*   DRD1A: var4 = var2; FN=0 MORE init=31 WS=0 RS=0 */
+	0xb8808264, /*   LCD: idx2 = *idx1, idx3 = var1; idx2 < var9; idx2 += inc4, idx3 += inc4 */
+	0x10001308, /*     DRD1A: var4 = idx1; FN=0 MORE init=0 WS=0 RS=0 */
+	0x60140002, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=2 EXT init=0 WS=2 RS=2 */
+	0x0cccfcca, /*     DRD2B1: *idx3 = EU3(); EU3(*idx3,var10)  */
+	0xd9190300, /*   LCDEXT: idx2 = idx2; idx2 > var12; idx2 += inc0 */
+	0xb8c5e009, /*   LCD: idx3 = *(idx1 + var00000015); ; idx3 += inc1 */
+	0x03fec398, /*     DRD1A: *idx0 = *idx3; FN=0 init=31 WS=3 RS=3 */
+	0x9919826a, /*   LCD: idx2 = idx2, idx3 = idx3; idx2 > var9; idx2 += inc5, idx3 += inc2 */
+	0x0feac398, /*     DRD1A: *idx0 = *idx3; FN=0 TFD INT init=31 WS=1 RS=1 */
+	0x99190036, /*   LCD: idx2 = idx2; idx2 once var0; idx2 += inc6 */
+	0x60000005, /*     DRD2A: EU0=0 EU1=0 EU2=0 EU3=5 EXT init=0 WS=0 RS=0 */
+	0x0c4cf889, /*     DRD2B1: *idx1 = EU3(); EU3(idx2,var9)  */
+	0x000001f8, /*   NOP */
+
+	/* VAR[9]-VAR[12] */
+	0x40000000,
+	0x7fff7fff,
+	0x00000000,
+	0x40000004,
+
+	/* INC[0]-INC[5] */
+	0x40000000,
+	0xe0000000,
+	0xe0000000,
+	0xa0000008,
+	0x20000000,
+	0x4000ffff,
+};
+
diff --git a/arch/powerpc/sysdev/bestcomm/gen_bd.c b/arch/powerpc/sysdev/bestcomm/gen_bd.c
new file mode 100644
index 0000000..8d33eaf
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/gen_bd.c
@@ -0,0 +1,260 @@
+/*
+ * Driver for MPC52xx processor BestComm General Buffer Descriptor
+ *
+ * Copyright (C) 2007 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2006 AppSpec Computer Technologies Corp.
+ *                    Jeff Gibbons <jeff.gibbons@appspec.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/errno.h>
+#include <asm/io.h>
+
+#include <asm/mpc52xx.h>
+
+#include "bestcomm.h"
+#include "bestcomm_priv.h"
+#include "gen_bd.h"
+
+
+/* ======================================================================== */
+/* Task image/var/inc                                                       */
+/* ======================================================================== */
+
+/* gen_bd tasks images */
+extern u32 bcom_gen_bd_rx_task[];
+extern u32 bcom_gen_bd_tx_task[];
+
+/* rx task vars that need to be set before enabling the task */
+struct bcom_gen_bd_rx_var {
+	u32 enable;		/* (u16*) address of task's control register */
+	u32 fifo;		/* (u32*) address of gen_bd's fifo */
+	u32 bd_base;		/* (struct bcom_bd*) beginning of ring buffer */
+	u32 bd_last;		/* (struct bcom_bd*) end of ring buffer */
+	u32 bd_start;		/* (struct bcom_bd*) current bd */
+	u32 buffer_size;	/* size of receive buffer */
+};
+
+/* rx task incs that need to be set before enabling the task */
+struct bcom_gen_bd_rx_inc {
+	u16 pad0;
+	s16 incr_bytes;
+	u16 pad1;
+	s16 incr_dst;
+};
+
+/* tx task vars that need to be set before enabling the task */
+struct bcom_gen_bd_tx_var {
+	u32 fifo;		/* (u32*) address of gen_bd's fifo */
+	u32 enable;		/* (u16*) address of task's control register */
+	u32 bd_base;		/* (struct bcom_bd*) beginning of ring buffer */
+	u32 bd_last;		/* (struct bcom_bd*) end of ring buffer */
+	u32 bd_start;		/* (struct bcom_bd*) current bd */
+	u32 buffer_size;	/* set by uCode for each packet */
+};
+
+/* tx task incs that need to be set before enabling the task */
+struct bcom_gen_bd_tx_inc {
+	u16 pad0;
+	s16 incr_bytes;
+	u16 pad1;
+	s16 incr_src;
+	u16 pad2;
+	s16 incr_src_ma;
+};
+
+/* private structure */
+struct bcom_gen_bd_priv {
+	phys_addr_t	fifo;
+	int		initiator;
+	int		ipr;
+	int		maxbufsize;
+};
+
+
+/* ======================================================================== */
+/* Task support code                                                        */
+/* ======================================================================== */
+
+struct bcom_task *
+bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
+			int initiator, int ipr, int maxbufsize)
+{
+	struct bcom_task *tsk;
+	struct bcom_gen_bd_priv *priv;
+
+	tsk = bcom_task_alloc(queue_len, sizeof(struct bcom_gen_bd),
+			sizeof(struct bcom_gen_bd_priv));
+	if (!tsk)
+		return NULL;
+
+	tsk->flags = BCOM_FLAGS_NONE;
+
+	priv = tsk->priv;
+	priv->fifo	= fifo;
+	priv->initiator	= initiator;
+	priv->ipr	= ipr;
+	priv->maxbufsize = maxbufsize;
+
+	if (bcom_gen_bd_rx_reset(tsk)) {
+		bcom_task_free(tsk);
+		return NULL;
+	}
+
+	return tsk;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_init);
+
+int
+bcom_gen_bd_rx_reset(struct bcom_task *tsk)
+{
+	struct bcom_gen_bd_priv *priv = tsk->priv;
+	struct bcom_gen_bd_rx_var *var;
+	struct bcom_gen_bd_rx_inc *inc;
+
+	/* Shutdown the task */
+	bcom_disable_task(tsk->tasknum);
+
+	/* Reset the microcode */
+	var = (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->tasknum);
+	inc = (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->tasknum);
+
+	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
+		return -1;
+
+	var->enable	= bcom_eng->regs_base +
+				offsetof(struct mpc52xx_sdma, tcr[tsk->tasknum]);
+	var->fifo	= (u32) priv->fifo;
+	var->bd_base	= tsk->bd_pa;
+	var->bd_last	= tsk->bd_pa + ((tsk->num_bd-1) * tsk->bd_size);
+	var->bd_start	= tsk->bd_pa;
+	var->buffer_size = priv->maxbufsize;
+
+	inc->incr_bytes	= -(s16)sizeof(u32);
+	inc->incr_dst	= sizeof(u32);
+
+	/* Reset the BDs */
+	tsk->index = 0;
+	tsk->outdex = 0;
+
+	memset(tsk->bd, 0x00, tsk->num_bd * tsk->bd_size);
+
+	/* Configure some stuff */
+	bcom_set_task_pragma(tsk->tasknum, BCOM_GEN_RX_BD_PRAGMA);
+	bcom_set_task_auto_start(tsk->tasknum, tsk->tasknum);
+
+	out_8(&bcom_eng->regs->ipr[priv->initiator], priv->ipr);
+	bcom_set_initiator(tsk->tasknum, priv->initiator);
+
+	out_be32(&bcom_eng->regs->IntPend, 1<<tsk->tasknum);	/* Clear ints */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_reset);
+
+void
+bcom_gen_bd_rx_release(struct bcom_task *tsk)
+{
+	/* Nothing special for the GenBD tasks */
+	bcom_task_free(tsk);
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_release);
+
+
+extern struct bcom_task *
+bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
+			int initiator, int ipr)
+{
+	struct bcom_task *tsk;
+	struct bcom_gen_bd_priv *priv;
+
+	tsk = bcom_task_alloc(queue_len, sizeof(struct bcom_gen_bd),
+			sizeof(struct bcom_gen_bd_priv));
+	if (!tsk)
+		return NULL;
+
+	tsk->flags = BCOM_FLAGS_NONE;
+
+	priv = tsk->priv;
+	priv->fifo	= fifo;
+	priv->initiator	= initiator;
+	priv->ipr	= ipr;
+
+	if (bcom_gen_bd_tx_reset(tsk)) {
+		bcom_task_free(tsk);
+		return NULL;
+	}
+
+	return tsk;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_init);
+
+int
+bcom_gen_bd_tx_reset(struct bcom_task *tsk)
+{
+	struct bcom_gen_bd_priv *priv = tsk->priv;
+	struct bcom_gen_bd_tx_var *var;
+	struct bcom_gen_bd_tx_inc *inc;
+
+	/* Shutdown the task */
+	bcom_disable_task(tsk->tasknum);
+
+	/* Reset the microcode */
+	var = (struct bcom_gen_bd_tx_var *) bcom_task_var(tsk->tasknum);
+	inc = (struct bcom_gen_bd_tx_inc *) bcom_task_inc(tsk->tasknum);
+
+	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_tx_task))
+		return -1;
+
+	var->enable	= bcom_eng->regs_base +
+				offsetof(struct mpc52xx_sdma, tcr[tsk->tasknum]);
+	var->fifo	= (u32) priv->fifo;
+	var->bd_base	= tsk->bd_pa;
+	var->bd_last	= tsk->bd_pa + ((tsk->num_bd-1) * tsk->bd_size);
+	var->bd_start	= tsk->bd_pa;
+
+	inc->incr_bytes	= -(s16)sizeof(u32);
+	inc->incr_src	= sizeof(u32);
+	inc->incr_src_ma = sizeof(u8);
+
+	/* Reset the BDs */
+	tsk->index = 0;
+	tsk->outdex = 0;
+
+	memset(tsk->bd, 0x00, tsk->num_bd * tsk->bd_size);
+
+	/* Configure some stuff */
+	bcom_set_task_pragma(tsk->tasknum, BCOM_GEN_TX_BD_PRAGMA);
+	bcom_set_task_auto_start(tsk->tasknum, tsk->tasknum);
+
+	out_8(&bcom_eng->regs->ipr[priv->initiator], priv->ipr);
+	bcom_set_initiator(tsk->tasknum, priv->initiator);
+
+	out_be32(&bcom_eng->regs->IntPend, 1<<tsk->tasknum);	/* Clear ints */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_reset);
+
+void
+bcom_gen_bd_tx_release(struct bcom_task *tsk)
+{
+	/* Nothing special for the GenBD tasks */
+	bcom_task_free(tsk);
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
+
+
+MODULE_DESCRIPTION("BestComm General Buffer Descriptor tasks driver");
+MODULE_AUTHOR("Jeff Gibbons <jeff.gibbons@appspec.com>");
+MODULE_LICENSE("GPL v2");
+
diff --git a/arch/powerpc/sysdev/bestcomm/gen_bd.h b/arch/powerpc/sysdev/bestcomm/gen_bd.h
new file mode 100644
index 0000000..5b6fa80
--- /dev/null
+++ b/arch/powerpc/sysdev/bestcomm/gen_bd.h
@@ -0,0 +1,48 @@
+/*
+ * Header for Bestcomm General Buffer Descriptor tasks driver
+ *
+ *
+ * Copyright (C) 2007 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2006 AppSpec Computer Technologies Corp.
+ *                    Jeff Gibbons <jeff.gibbons@appspec.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ *
+ */
+
+#ifndef __BESTCOMM_GEN_BD_H__
+#define __BESTCOMM_GEN_BD_H__
+
+struct bcom_gen_bd {
+	u32	status;
+	u32	buf_pa;
+};
+
+
+extern struct bcom_task *
+bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
+			int initiator, int ipr, int maxbufsize);
+
+extern int
+bcom_gen_bd_rx_reset(struct bcom_task *tsk);
+
+extern void
+bcom_gen_bd_rx_release(struct bcom_task *tsk);
+
+
+extern struct bcom_task *
+bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
+			int initiator, int ipr);
+
+extern int
+bcom_gen_bd_tx_reset(struct bcom_task *tsk);
+
+extern void
+bcom_gen_bd_tx_release(struct bcom_task *tsk);
+
+
+#endif  /* __BESTCOMM_GEN_BD_H__ */
+
