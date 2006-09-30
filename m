Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 688FB67D4E
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:34:05 +1000 (EST)
Date: Sat, 30 Sep 2006 18:33:33 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/15] qe_lib: Add common files
Message-Id: <20060930183333.0ec7fe0f.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

qe_lib: Add common files

Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/Kconfig                   |   12 +
 arch/powerpc/sysdev/Makefile           |    1 
 arch/powerpc/sysdev/qe_lib/Kconfig     |   29 ++
 arch/powerpc/sysdev/qe_lib/Makefile    |    8 +
 arch/powerpc/sysdev/qe_lib/qe_common.c |  362 ++++++++++++++++++++++++
 include/asm-powerpc/qe.h               |  492 ++++++++++++++++++++++++++++++++
 6 files changed, 904 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de1ef2f..0402209 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -355,6 +355,16 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
+config QUICC_ENGINE
+	bool
+	depends on PPC_MPC836x
+	default y
+	help
+	  The QE(QUICC Engine) is a new generation of coprocessor on
+	  Freescale embedded CPUs(like CPM  in older chips).  Selecting
+	  this option means that you wish to build a kernel for a machine
+	  with QE coprocessor on it.
+
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
@@ -1059,6 +1069,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
 
 # XXX source "arch/ppc/8260_io/Kconfig"
 
+source "arch/powerpc/sysdev/qe_lib/Kconfig"
+
 source "arch/powerpc/platforms/iseries/Kconfig"
 
 source "lib/Kconfig"
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f15f4d7..91f052d 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
+obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
new file mode 100644
index 0000000..28487e4
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -0,0 +1,29 @@
+#
+# QE Communication options
+#
+
+menu "QE Options"
+	depends on QUICC_ENGINE
+
+config UCC_SLOW
+	bool "UCC Slow Protocols Support"
+	default n
+	select UCC
+	help
+	  This option provides qe_lib support to UCC slow
+	  protocols: UART, BISYNC, QMC
+
+config UCC_FAST
+	bool "UCC Fast Protocols Support"
+	default n
+	select UCC
+	help
+	  This option provides qe_lib support to UCC fast
+	  protocols: HDLC, Ethernet, ATM, transparent
+
+config UCC
+	bool
+	default y if UCC_FAST || UCC_SLOW
+
+endmenu
+
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
new file mode 100644
index 0000000..9a54a81
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux ppc-specific parts of QE
+#
+obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe.o qe_ic.o qe_io.o
+
+obj-$(CONFIG_UCC)	+= ucc.o
+obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
+obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o ucc_slow.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
new file mode 100644
index 0000000..0cde73c
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ * Based on cpm2_common.c from Dan Malek (dmalek@jlc.net)
+ *
+ * Description:
+ * General Purpose functions for the global management of the
+ * QUICC Engine (QE).
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+#include <asm/prom.h>
+#include <asm/rheap.h>
+
+/* QE snum state
+*/
+typedef enum qe_snum_state {
+	QE_SNUM_STATE_USED,	/* used */
+	QE_SNUM_STATE_FREE	/* free */
+} qe_snum_state_e;
+
+/* QE snum
+*/
+typedef struct qe_snum {
+	u8 num;			/* snum  */
+	qe_snum_state_e state;	/* state */
+} qe_snum_t;
+
+/* We allocate this here because it is used almost exclusively for
+ * the communication processor devices.
+ */
+EXPORT_SYMBOL(qe_immr);
+qe_map_t *qe_immr = NULL;
+static qe_snum_t snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs  */
+
+static void qe_snums_init(void);
+static void qe_muram_init(void);
+static int qe_sdma_init(void);
+
+static DEFINE_SPINLOCK(qe_lock);
+
+void qe_reset(void)
+{
+	if (qe_immr == NULL)
+		qe_immr = (qe_map_t *) ioremap(get_qe_base(), QE_IMMAP_SIZE);
+
+	qe_snums_init();
+
+	qe_issue_cmd(QE_RESET, QE_CR_SUBBLOCK_INVALID,
+		     (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+
+	/* Reclaim the MURAM memory for our use. */
+	qe_muram_init();
+
+	if (qe_sdma_init())
+		panic("sdma init failed!");
+}
+
+EXPORT_SYMBOL(qe_issue_cmd);
+int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input)
+{
+	unsigned long flags;
+	u32 cecr;
+	u8 mcn_shift = 0, dev_shift = 0;
+
+	spin_lock_irqsave(&qe_lock, flags);
+	if (cmd == QE_RESET) {
+		out_be32(&qe_immr->cp.cecr, (u32) (cmd | QE_CR_FLG));
+	} else {
+		if (cmd == QE_ASSIGN_PAGE) {
+			/* Here device is the SNUM, not sub-block */
+			dev_shift = QE_CR_SNUM_SHIFT;
+		} else if (cmd == QE_ASSIGN_RISC) {
+			/* Here device is the SNUM, and mcnProtocol is
+			 * e_QeCmdRiscAssignment value */
+			dev_shift = QE_CR_SNUM_SHIFT;
+			mcn_shift = QE_CR_MCN_RISC_ASSIGN_SHIFT;
+		} else {
+			if (device == QE_CR_SUBBLOCK_USB)
+				mcn_shift = QE_CR_MCN_USB_SHIFT;
+			else
+				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
+		}
+
+		out_be32(&qe_immr->cp.cecdr,
+			 immrbar_virt_to_phys((void *)cmd_input));
+		out_be32(&qe_immr->cp.cecr,
+			 (cmd | QE_CR_FLG | ((u32) device << dev_shift) | (u32)
+			  mcn_protocol << mcn_shift));
+	}
+
+	/* wait for the QE_CR_FLG to clear */
+	do {
+		cecr = in_be32(&qe_immr->cp.cecr);
+	} while (cecr & QE_CR_FLG);
+	spin_unlock_irqrestore(&qe_lock, flags);
+
+	return 0;
+}
+
+/* Set a baud rate generator. This needs lots of work. There are
+ * 16 BRGs, which can be connected to the QE channels or output
+ * as clocks. The BRGs are in two different block of internal
+ * memory mapped space.
+ * The baud rate clock is the system clock divided by something.
+ * It was set up long ago during the initial boot phase and is
+ * is given to us.
+ * Baud rate clocks are zero-based in the driver code (as that maps
+ * to port numbers). Documentation uses 1-based numbering.
+ */
+static unsigned int brg_clk = 0;
+
+unsigned int get_brg_clk(void)
+{
+	struct device_node *qe;
+	if (brg_clk)
+		return brg_clk;
+
+	qe = of_find_node_by_type(NULL, "qe");
+	if (qe) {
+		unsigned int size;
+		u32 *prop = (u32 *) get_property(qe, "brg-frequency", &size);
+		brg_clk = *prop;
+		of_node_put(qe);
+	};
+	return brg_clk;
+}
+
+/* This function is used by UARTS, or anything else that uses a 16x
+ * oversampled clock.
+ */
+void qe_setbrg(uint brg, uint rate)
+{
+	volatile uint *bp;
+	u32 divisor;
+	int div16 = 0;
+
+	bp = (uint *) & qe_immr->brg.brgc1;
+	bp += brg;
+
+	divisor = (get_brg_clk() / rate);
+	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
+		div16 = 1;
+		divisor /= 16;
+	}
+
+	*bp = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) | QE_BRGC_ENABLE;
+	if (div16)
+		*bp |= QE_BRGC_DIV16;
+}
+
+static void qe_snums_init(void)
+{
+	int i;
+
+	/* Initialize the SNUMs array. */
+	for (i = 0; i < QE_NUM_OF_SNUM; i++)
+		snums[i].state = QE_SNUM_STATE_FREE;
+
+	/* Initialize SNUMs (thread serial numbers) according to QE
+	 * spec chapter 4, SNUM table */
+	i = 0;
+	snums[i++].num = 0x04;
+	snums[i++].num = 0x05;
+	snums[i++].num = 0x0C;
+	snums[i++].num = 0x0D;
+	snums[i++].num = 0x14;
+	snums[i++].num = 0x15;
+	snums[i++].num = 0x1C;
+	snums[i++].num = 0x1D;
+	snums[i++].num = 0x24;
+	snums[i++].num = 0x25;
+	snums[i++].num = 0x2C;
+	snums[i++].num = 0x2D;
+	snums[i++].num = 0x34;
+	snums[i++].num = 0x35;
+	snums[i++].num = 0x88;
+	snums[i++].num = 0x89;
+	snums[i++].num = 0x98;
+	snums[i++].num = 0x99;
+	snums[i++].num = 0xA8;
+	snums[i++].num = 0xA9;
+	snums[i++].num = 0xB8;
+	snums[i++].num = 0xB9;
+	snums[i++].num = 0xC8;
+	snums[i++].num = 0xC9;
+	snums[i++].num = 0xD8;
+	snums[i++].num = 0xD9;
+	snums[i++].num = 0xE8;
+	snums[i++].num = 0xE9;
+}
+
+int qe_get_snum(void)
+{
+	unsigned long flags;
+	int snum = -EBUSY;
+	int i;
+
+	spin_lock_irqsave(&qe_lock, flags);
+	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+		if (snums[i].state == QE_SNUM_STATE_FREE) {
+			snums[i].state = QE_SNUM_STATE_USED;
+			snum = snums[i].num;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&qe_lock, flags);
+
+	return snum;
+}
+
+EXPORT_SYMBOL(qe_get_snum);
+
+void qe_put_snum(u8 snum)
+{
+	int i;
+
+	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+		if (snums[i].num == snum) {
+			snums[i].state = QE_SNUM_STATE_FREE;
+			break;
+		}
+	}
+}
+
+EXPORT_SYMBOL(qe_put_snum);
+
+static int qe_sdma_init(void)
+{
+	sdma_t *sdma = &qe_immr->sdma;
+	uint sdma_buf_offset;
+
+	if (!sdma)
+		return -ENODEV;
+
+	/* allocate 2 internal temporary buffers (512 bytes size each) for
+	 * the SDMA */
+	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
+	if (IS_MURAM_ERR(sdma_buf_offset))
+		return -ENOMEM;
+
+	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
+					QE_SDMR_CEN_SHIFT)));
+
+	return 0;
+}
+
+/*
+ * muram_alloc / muram_free bits.
+ */
+static DEFINE_SPINLOCK(qe_muram_lock);
+
+/* 16 blocks should be enough to satisfy all requests
+ * until the memory subsystem goes up... */
+static rh_block_t qe_boot_muram_rh_block[16];
+static rh_info_t qe_muram_info;
+
+static void qe_muram_init(void)
+{
+	struct device_node *np;
+	u32 address;
+	u64 size;
+	unsigned int flags;
+
+	/* initialize the info header */
+	rh_init(&qe_muram_info, 1,
+		sizeof(qe_boot_muram_rh_block) /
+		sizeof(qe_boot_muram_rh_block[0]), qe_boot_muram_rh_block);
+
+	/* Attach the usable muram area */
+	/* XXX: This is a subset of the available muram. It
+	 * varies with the processor and the microcode patches activated.
+	 */
+	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
+		address = *of_get_address(np, 0, &size, &flags);
+		of_node_put(np);
+		rh_attach_region(&qe_muram_info,
+			(void *)address, (int)size);
+	}
+}
+
+/* This function returns an index into the MURAM area.
+ */
+uint qe_muram_alloc(uint size, uint align)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (uint) start;
+}
+
+EXPORT_SYMBOL(qe_muram_alloc);
+
+int qe_muram_free(uint offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	ret = rh_free(&qe_muram_info, (void *)offset);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(qe_muram_free);
+
+/* not sure if this is ever needed */
+uint qe_muram_alloc_fixed(uint offset, uint size)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start =
+	    rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (uint) start;
+}
+
+EXPORT_SYMBOL(qe_muram_alloc_fixed);
+
+void qe_muram_dump(void)
+{
+	rh_dump(&qe_muram_info);
+}
+
+EXPORT_SYMBOL(qe_muram_dump);
+
+void *qe_muram_addr(uint offset)
+{
+	return (void *)&qe_immr->muram[offset];
+}
+
+EXPORT_SYMBOL(qe_muram_addr);
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
new file mode 100644
index 0000000..94623ee
--- /dev/null
+++ b/include/asm-powerpc/qe.h
@@ -0,0 +1,492 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QUICC Engine (QE) external definitions and structure.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef CONFIG_QUICC_ENGINE
+#ifdef __KERNEL__
+#ifndef __QE_H__
+#define __QE_H__
+
+#include <asm/immap_qe.h>
+
+static inline long IS_MURAM_ERR(const uint offset)
+{
+	return (uint) offset > (uint) - 1000L;
+}
+
+#define QE_NUM_OF_SNUM  28
+#define QE_NUM_OF_BRGS  16
+#define QE_NUM_OF_PORTS 1024
+
+/* Memory partitions
+*/
+#define MEM_PART_SYSTEM     0
+#define MEM_PART_SECONDARY  1
+#define MEM_PART_MURAM      2
+
+/* Export QE common operations */
+extern void qe_reset(void);
+extern int par_io_init(struct device_node *np);
+extern int par_io_of_config(struct device_node *np);
+
+/* QE internal APIs */
+int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input);
+void qe_setbrg(uint brg, uint rate);
+int qe_get_snum(void);
+void qe_put_snum(u8 snum);
+uint qe_muram_alloc(uint size, uint align);
+int qe_muram_free(uint offset);
+uint qe_muram_alloc_fixed(uint offset, uint size);
+void qe_muram_dump(void);
+void *qe_muram_addr(uint offset);
+/* Buffer descriptors.
+*/
+typedef struct qe_bd {
+	u16 status;
+	u16 length;
+	u32 buf;
+} __attribute__ ((packed)) qe_bd_t;
+
+#define QE_SIZEOF_BD       sizeof(qe_bd_t)
+
+#define BD_STATUS_MASK                      0xffff0000
+#define BD_LENGTH_MASK                      0x0000ffff
+
+#define BD_BUFFER_ARG(bd)                   ((qe_bd_t *)bd)->buf
+#define BD_BUFFER_CLEAR(bd)                 out_be32(&(BD_BUFFER_ARG(bd)), 0);
+#define BD_BUFFER(bd)                       in_be32(&(BD_BUFFER_ARG(bd)))
+#define BD_STATUS_AND_LENGTH_SET(bd, val)   out_be32((u32*)bd, val)
+#define BD_STATUS_AND_LENGTH(bd)            in_be32((u32*)bd)
+#define BD_BUFFER_SET(bd, buffer)           out_be32(&(BD_BUFFER_ARG(bd)), \
+	(u32)(buffer))
+/* Macro for retrieving the following BD.
+   example:
+   next = BD_GET_NEXT( currBd, bdStatus, bdBase, SIZEOF_MY_BD, T_W ) */
+#define BD_GET_NEXT( curr_bd, bd_status, bd_base, bd_len, last_bd ) \
+        ( (!((bd_status) & (last_bd))) ? ((curr_bd)+(bd_len)) : (bd_base) )
+
+/* Alignments
+*/
+#define QE_INTR_TABLE_ALIGN                16	/* ??? */
+#define QE_ALIGNMENT_OF_BD                 8
+#define QE_ALIGNMENT_OF_PRAM               64
+
+/* RISC allocation
+*/
+typedef enum qe_risc_allocation {
+	QE_RISC_ALLOCATION_RISC1 = 1,	/* RISC 1 */
+	QE_RISC_ALLOCATION_RISC2 = 2,	/* RISC 2 */
+	QE_RISC_ALLOCATION_RISC1_AND_RISC2 = 3	/* Dynamically choose RISC 1 or
+						   RISC 2 */
+} qe_risc_allocation_e;
+
+/* QE extended filtering Table Lookup Key Size
+*/
+typedef enum qe_fltr_tbl_lookup_key_size {
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= 0x3f,		/* LookupKey parsed by the Generate LookupKey
+				   CMD is truncated to 8  bytes */
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= 0x5f,		/* LookupKey parsed by the Generate LookupKey
+				   CMD is truncated to 16 bytes */
+} qe_fltr_tbl_lookup_key_size_e;
+
+/* QE FLTR extended filtering Largest External Table Lookup Key Size
+*/
+typedef enum qe_fltr_largest_external_tbl_lookup_key_size_ {
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
+		= 0x0,/* not used */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,	/* 8  bytes */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES	/* 16 bytes */
+} qe_fltr_largest_external_tbl_lookup_key_size_e;
+
+/* structure representing QE parameter RAM
+*/
+typedef struct qe_timer_tables {
+	u16 tm_base;		/* QE timer table base adr */
+	u16 tm_ptr;		/* QE timer table pointer  */
+	u16 r_tmr;		/* QE timer mode register  */
+	u16 r_tmv;		/* QE timer valid register */
+	u32 tm_cmd;		/* QE timer cmd register   */
+	u32 tm_cnt;		/* QE timer internal cnt   */
+} __attribute__ ((packed)) qe_timer_tables_t;
+
+#define QE_FLTR_TAD_SIZE                8
+
+/* QE extended filtering Termination Action Descriptor (TAD)
+*/
+typedef struct qe_fltr_tad {
+	u8 serialized[QE_FLTR_TAD_SIZE];
+} __attribute__ ((packed)) qe_fltr_tad_t;
+
+/* Communication Direction.
+*/
+typedef enum comm_dir {
+	COMM_DIR_NONE = 0,
+	COMM_DIR_RX = 1,
+	COMM_DIR_TX = 2,
+	COMM_DIR_RX_AND_TX = 3
+} comm_dir_e;
+
+/* Clocks and GRG's
+*/
+typedef enum qe_clock {
+	QE_CLK_NONE = 0
+	    , QE_BRG1		/* Baud Rate Generator  1 */
+	    , QE_BRG2		/* Baud Rate Generator  2 */
+	    , QE_BRG3		/* Baud Rate Generator  3 */
+	    , QE_BRG4		/* Baud Rate Generator  4 */
+	    , QE_BRG5		/* Baud Rate Generator  5 */
+	    , QE_BRG6		/* Baud Rate Generator  6 */
+	    , QE_BRG7		/* Baud Rate Generator  7 */
+	    , QE_BRG8		/* Baud Rate Generator  8 */
+	    , QE_BRG9		/* Baud Rate Generator  9 */
+	    , QE_BRG10		/* Baud Rate Generator 10 */
+	    , QE_BRG11		/* Baud Rate Generator 11 */
+	    , QE_BRG12		/* Baud Rate Generator 12 */
+	    , QE_BRG13		/* Baud Rate Generator 13 */
+	    , QE_BRG14		/* Baud Rate Generator 14 */
+	    , QE_BRG15		/* Baud Rate Generator 15 */
+	    , QE_BRG16		/* Baud Rate Generator 16 */
+	    , QE_CLK1		/* Clock  1               */
+	    , QE_CLK2		/* Clock  2               */
+	    , QE_CLK3		/* Clock  3               */
+	    , QE_CLK4		/* Clock  4               */
+	    , QE_CLK5		/* Clock  5               */
+	    , QE_CLK6		/* Clock  6               */
+	    , QE_CLK7		/* Clock  7               */
+	    , QE_CLK8		/* Clock  8               */
+	    , QE_CLK9		/* Clock  9               */
+	    , QE_CLK10		/* Clock 10               */
+	    , QE_CLK11		/* Clock 11               */
+	    , QE_CLK12		/* Clock 12               */
+	    , QE_CLK13		/* Clock 13               */
+	    , QE_CLK14		/* Clock 14               */
+	    , QE_CLK15		/* Clock 15               */
+	    , QE_CLK16		/* Clock 16               */
+	    , QE_CLK17		/* Clock 17               */
+	    , QE_CLK18		/* Clock 18               */
+	    , QE_CLK19		/* Clock 19               */
+	    , QE_CLK20		/* Clock 20               */
+	    , QE_CLK21		/* Clock 21               */
+	    , QE_CLK22		/* Clock 22               */
+	    , QE_CLK23		/* Clock 23               */
+	    , QE_CLK24		/* Clock 24               */
+	    , QE_CLK_DUMMY
+} qe_clock_e;
+
+/* QE CMXUCR Registers.
+ * There are two UCCs represented in each of the four CMXUCR registers.
+ * These values are for the UCC in the LSBs
+ */
+#define QE_CMXUCR_MII_ENET_MNG              0x00007000
+#define QE_CMXUCR_MII_ENET_MNG_SHIFT        12
+#define QE_CMXUCR_GRANT                     0x00008000
+#define QE_CMXUCR_TSA                       0x00004000
+#define QE_CMXUCR_BKPT                      0x00000100
+#define QE_CMXUCR_TX_CLK_SRC_MASK           0x0000000F
+
+/* QE CMXGCR Registers.
+*/
+#define QE_CMXGCR_MII_ENET_MNG              0x00007000
+#define QE_CMXGCR_MII_ENET_MNG_SHIFT        12
+#define QE_CMXGCR_USBCS                     0x0000000f
+
+/* QE CECR Commands.
+*/
+#define QE_CR_FLG                   0x00010000
+#define QE_RESET                    0x80000000
+#define QE_INIT_TX_RX               0x00000000
+#define QE_INIT_RX                  0x00000001
+#define QE_INIT_TX                  0x00000002
+#define QE_ENTER_HUNT_MODE          0x00000003
+#define QE_STOP_TX                  0x00000004
+#define QE_GRACEFUL_STOP_TX         0x00000005
+#define QE_RESTART_TX               0x00000006
+#define QE_CLOSE_RX_BD              0x00000007
+#define QE_SWITCH_COMMAND           0x00000007
+#define QE_SET_GROUP_ADDRESS        0x00000008
+#define QE_START_IDMA               0x00000009
+#define QE_MCC_STOP_RX              0x00000009
+#define QE_ATM_TRANSMIT             0x0000000a
+#define QE_HPAC_CLEAR_ALL           0x0000000b
+#define QE_GRACEFUL_STOP_RX         0x0000001a
+#define QE_RESTART_RX               0x0000001b
+#define QE_HPAC_SET_PRIORITY        0x0000010b
+#define QE_HPAC_STOP_TX             0x0000020b
+#define QE_HPAC_STOP_RX             0x0000030b
+#define QE_HPAC_GRACEFUL_STOP_TX    0x0000040b
+#define QE_HPAC_GRACEFUL_STOP_RX    0x0000050b
+#define QE_HPAC_START_TX            0x0000060b
+#define QE_HPAC_START_RX            0x0000070b
+#define QE_USB_STOP_TX              0x0000000a
+#define QE_USB_RESTART_TX           0x0000000b
+#define QE_QMC_STOP_TX              0x0000000c
+#define QE_QMC_STOP_RX              0x0000000d
+#define QE_SS7_SU_FIL_RESET         0x0000000e
+/* jonathbr added from here down for 83xx */
+#define QE_RESET_BCS                0x0000000a
+#define QE_MCC_INIT_TX_RX_16        0x00000003
+#define QE_MCC_STOP_TX              0x00000004
+#define QE_MCC_INIT_TX_1            0x00000005
+#define QE_MCC_INIT_RX_1            0x00000006
+#define QE_MCC_RESET                0x00000007
+#define QE_SET_TIMER                0x00000008
+#define QE_RANDOM_NUMBER            0x0000000c
+#define QE_ATM_MULTI_THREAD_INIT    0x00000011
+#define QE_ASSIGN_PAGE              0x00000012
+#define QE_ADD_REMOVE_HASH_ENTRY    0x00000013
+#define QE_START_FLOW_CONTROL       0x00000014
+#define QE_STOP_FLOW_CONTROL        0x00000015
+#define QE_ASSIGN_PAGE_TO_DEVICE    0x00000016
+
+#define QE_ASSIGN_RISC		    0x00000010
+#define QE_CR_MCN_NORMAL_SHIFT      6
+#define QE_CR_MCN_USB_SHIFT         4
+#define QE_CR_MCN_RISC_ASSIGN_SHIFT 8
+#define QE_CR_SNUM_SHIFT            17
+
+/* QE CECR Sub Block - sub block of QE command.
+*/
+#define QE_CR_SUBBLOCK_INVALID      0x00000000
+#define QE_CR_SUBBLOCK_USB          0x03200000
+#define QE_CR_SUBBLOCK_UCCFAST1     0x02000000
+#define QE_CR_SUBBLOCK_UCCFAST2     0x02200000
+#define QE_CR_SUBBLOCK_UCCFAST3     0x02400000
+#define QE_CR_SUBBLOCK_UCCFAST4     0x02600000
+#define QE_CR_SUBBLOCK_UCCFAST5     0x02800000
+#define QE_CR_SUBBLOCK_UCCFAST6     0x02a00000
+#define QE_CR_SUBBLOCK_UCCFAST7     0x02c00000
+#define QE_CR_SUBBLOCK_UCCFAST8     0x02e00000
+#define QE_CR_SUBBLOCK_UCCSLOW1     0x00000000
+#define QE_CR_SUBBLOCK_UCCSLOW2     0x00200000
+#define QE_CR_SUBBLOCK_UCCSLOW3     0x00400000
+#define QE_CR_SUBBLOCK_UCCSLOW4     0x00600000
+#define QE_CR_SUBBLOCK_UCCSLOW5     0x00800000
+#define QE_CR_SUBBLOCK_UCCSLOW6     0x00a00000
+#define QE_CR_SUBBLOCK_UCCSLOW7     0x00c00000
+#define QE_CR_SUBBLOCK_UCCSLOW8     0x00e00000
+#define QE_CR_SUBBLOCK_MCC1         0x03800000
+#define QE_CR_SUBBLOCK_MCC2         0x03a00000
+#define QE_CR_SUBBLOCK_MCC3         0x03000000
+#define QE_CR_SUBBLOCK_IDMA1        0x02800000
+#define QE_CR_SUBBLOCK_IDMA2        0x02a00000
+#define QE_CR_SUBBLOCK_IDMA3        0x02c00000
+#define QE_CR_SUBBLOCK_IDMA4        0x02e00000
+#define QE_CR_SUBBLOCK_HPAC         0x01e00000
+#define QE_CR_SUBBLOCK_SPI1         0x01400000
+#define QE_CR_SUBBLOCK_SPI2         0x01600000
+#define QE_CR_SUBBLOCK_RAND         0x01c00000
+#define QE_CR_SUBBLOCK_TIMER        0x01e00000
+#define QE_CR_SUBBLOCK_GENERAL      0x03c00000
+
+/* QE CECR Protocol - For non-MCC, specifies mode for QE CECR command.
+*/
+#define QE_CR_PROTOCOL_UNSPECIFIED       0x00	/* For all other protocols */
+#define QE_CR_PROTOCOL_HDLC_TRANSPARENT  0x00
+#define QE_CR_PROTOCOL_ATM_POS           0x0A
+#define QE_CR_PROTOCOL_ETHERNET          0x0C
+#define QE_CR_PROTOCOL_L2_SWITCH         0x0D
+
+/* BMR byte order
+*/
+#define QE_BMR_BYTE_ORDER_BO_PPC  0x08	/* powerpc little endian */
+#define QE_BMR_BYTE_ORDER_BO_MOT  0x10	/* motorola big endian   */
+#define QE_BMR_BYTE_ORDER_BO_MAX  0x18
+
+/* BRG configuration register
+*/
+#define QE_BRGC_ENABLE          0x00010000
+#define QE_BRGC_DIVISOR_SHIFT   1
+#define QE_BRGC_DIVISOR_MAX     0xFFF
+#define QE_BRGC_DIV16           1
+/* QE Timers registers */
+#define QE_GTCFR1_PCAS      0x80
+#define QE_GTCFR1_STP2      0x20
+#define QE_GTCFR1_RST2      0x10
+#define QE_GTCFR1_GM2       0x08
+#define QE_GTCFR1_GM1       0x04
+#define QE_GTCFR1_STP1      0x02
+#define QE_GTCFR1_RST1      0x01
+
+/* SDMA registers */
+#define QE_SDSR_BER1            0x02000000
+#define QE_SDSR_BER2            0x01000000
+
+#define QE_SDMR_GLB_1_MSK       0x80000000
+#define QE_SDMR_ADR_SEL         0x20000000
+#define QE_SDMR_BER1_MSK        0x02000000
+#define QE_SDMR_BER2_MSK        0x01000000
+#define QE_SDMR_EB1_MSK         0x00800000
+#define QE_SDMR_ER1_MSK         0x00080000
+#define QE_SDMR_ER2_MSK         0x00040000
+#define QE_SDMR_CEN_MASK        0x0000E000
+#define QE_SDMR_SBER_1          0x00000200
+#define QE_SDMR_SBER_2          0x00000200
+#define QE_SDMR_EB1_PR_MASK     0x000000C0
+#define QE_SDMR_ER1_PR          0x00000008
+
+#define QE_SDMR_CEN_SHIFT       13
+#define QE_SDMR_EB1_PR_SHIFT    6
+
+#define QE_SDTM_MSNUM_SHIFT     24
+
+#define QE_SDEBCR_BA_MASK       0x01FFFFFF
+
+/* UPC
+*/
+#define UPGCR_PROTOCOL      0x80000000	/* protocol ul2 or pl2 */
+#define UPGCR_TMS           0x40000000	/* Transmit master/slave mode */
+#define UPGCR_RMS           0x20000000	/* Receive master/slave mode */
+#define UPGCR_ADDR          0x10000000	/* Master MPHY Addr multiplexing */
+#define UPGCR_DIAG          0x01000000	/* Diagnostic mode */
+
+/* UCC
+*/
+#define UCC_GUEMR_MODE_MASK_RX  0x02
+#define UCC_GUEMR_MODE_MASK_TX  0x01
+#define UCC_GUEMR_MODE_FAST_RX  0x02
+#define UCC_GUEMR_MODE_FAST_TX  0x01
+#define UCC_GUEMR_MODE_SLOW_RX  0x00
+#define UCC_GUEMR_MODE_SLOW_TX  0x00
+#define UCC_GUEMR_SET_RESERVED3 0x10	/* Bit 3 in the guemr is reserved but
+					   must be set 1 */
+
+/* structure representing UCC SLOW parameter RAM
+*/
+typedef struct ucc_slow_pram {
+	u16 rbase;		/* RX BD base address       */
+	u16 tbase;		/* TX BD base address       */
+	u8 rfcr;		/* Rx function code         */
+	u8 tfcr;		/* Tx function code         */
+	u16 mrblr;		/* Rx buffer length         */
+	u32 rstate;		/* Rx internal state        */
+	u32 rptr;		/* Rx internal data pointer */
+	u16 rbptr;		/* rb BD Pointer            */
+	u16 rcount;		/* Rx internal byte count   */
+	u32 rtemp;		/* Rx temp                  */
+	u32 tstate;		/* Tx internal state        */
+	u32 tptr;		/* Tx internal data pointer */
+	u16 tbptr;		/* Tx BD pointer            */
+	u16 tcount;		/* Tx byte count            */
+	u32 ttemp;		/* Tx temp                  */
+	u32 rcrc;		/* temp receive CRC         */
+	u32 tcrc;		/* temp transmit CRC        */
+} __attribute__ ((packed)) ucc_slow_pram_t;
+
+/* General UCC SLOW Mode Register (GUMRH & GUMRL)
+*/
+#define UCC_SLOW_GUMR_H_CRC16         0x00004000
+#define UCC_SLOW_GUMR_H_CRC16CCITT    0x00000000
+#define UCC_SLOW_GUMR_H_CRC32CCITT    0x00008000
+#define UCC_SLOW_GUMR_H_REVD          0x00002000
+#define UCC_SLOW_GUMR_H_TRX           0x00001000
+#define UCC_SLOW_GUMR_H_TTX           0x00000800
+#define UCC_SLOW_GUMR_H_CDP           0x00000400
+#define UCC_SLOW_GUMR_H_CTSP          0x00000200
+#define UCC_SLOW_GUMR_H_CDS           0x00000100
+#define UCC_SLOW_GUMR_H_CTSS          0x00000080
+#define UCC_SLOW_GUMR_H_TFL           0x00000040
+#define UCC_SLOW_GUMR_H_RFW           0x00000020
+#define UCC_SLOW_GUMR_H_TXSY          0x00000010
+#define UCC_SLOW_GUMR_H_4SYNC         0x00000004
+#define UCC_SLOW_GUMR_H_8SYNC         0x00000008
+#define UCC_SLOW_GUMR_H_16SYNC        0x0000000c
+#define UCC_SLOW_GUMR_H_RTSM          0x00000002
+#define UCC_SLOW_GUMR_H_RSYN          0x00000001
+
+#define UCC_SLOW_GUMR_L_TCI           0x10000000
+#define UCC_SLOW_GUMR_L_RINV          0x02000000
+#define UCC_SLOW_GUMR_L_TINV          0x01000000
+#define UCC_SLOW_GUMR_L_TEND          0x00020000
+#define UCC_SLOW_GUMR_L_ENR           0x00000020
+#define UCC_SLOW_GUMR_L_ENT           0x00000010
+
+/* General UCC FAST Mode Register
+*/
+#define UCC_FAST_GUMR_TCI             0x20000000
+#define UCC_FAST_GUMR_TRX             0x10000000
+#define UCC_FAST_GUMR_TTX             0x08000000
+#define UCC_FAST_GUMR_CDP             0x04000000
+#define UCC_FAST_GUMR_CTSP            0x02000000
+#define UCC_FAST_GUMR_CDS             0x01000000
+#define UCC_FAST_GUMR_CTSS            0x00800000
+#define UCC_FAST_GUMR_TXSY            0x00020000
+#define UCC_FAST_GUMR_RSYN            0x00010000
+#define UCC_FAST_GUMR_RTSM            0x00002000
+#define UCC_FAST_GUMR_REVD            0x00000400
+#define UCC_FAST_GUMR_ENR             0x00000020
+#define UCC_FAST_GUMR_ENT             0x00000010
+
+/* Slow UCC Event Register (UCCE)
+*/
+#define UCC_SLOW_UCCE_GLR       0x1000
+#define UCC_SLOW_UCCE_GLT       0x0800
+#define UCC_SLOW_UCCE_DCC       0x0400
+#define UCC_SLOW_UCCE_FLG       0x0200
+#define UCC_SLOW_UCCE_AB        0x0200
+#define UCC_SLOW_UCCE_IDLE      0x0100
+#define UCC_SLOW_UCCE_GRA       0x0080
+#define UCC_SLOW_UCCE_TXE       0x0010
+#define UCC_SLOW_UCCE_RXF       0x0008
+#define UCC_SLOW_UCCE_CCR       0x0008
+#define UCC_SLOW_UCCE_RCH       0x0008
+#define UCC_SLOW_UCCE_BSY       0x0004
+#define UCC_SLOW_UCCE_TXB       0x0002
+#define UCC_SLOW_UCCE_TX        0x0002
+#define UCC_SLOW_UCCE_RX        0x0001
+#define UCC_SLOW_UCCE_GOV       0x0001
+#define UCC_SLOW_UCCE_GUN       0x0002
+#define UCC_SLOW_UCCE_GINT      0x0004
+#define UCC_SLOW_UCCE_IQOV      0x0008
+
+#define UCC_SLOW_UCCE_HDLC_SET  (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_RXF| \
+		UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_ENET_SET  (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_RXF)
+#define UCC_SLOW_UCCE_TRANS_SET (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_TX |UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_UART_SET  (UCC_SLOW_UCCE_BSY|UCC_SLOW_UCCE_GRA| \
+		UCC_SLOW_UCCE_TXB|UCC_SLOW_UCCE_TX |UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_GLT|UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_QMC_SET   (UCC_SLOW_UCCE_IQOV|UCC_SLOW_UCCE_GINT| \
+		UCC_SLOW_UCCE_GUN|UCC_SLOW_UCCE_GOV)
+
+#define UCC_SLOW_UCCE_OTHER     (UCC_SLOW_UCCE_TXE|UCC_SLOW_UCCE_BSY| \
+		UCC_SLOW_UCCE_GRA|UCC_SLOW_UCCE_DCC|UCC_SLOW_UCCE_GLT| \
+		UCC_SLOW_UCCE_GLR)
+
+#define UCC_SLOW_INTR_TX        UCC_SLOW_UCCE_TXB
+#define UCC_SLOW_INTR_RX        (UCC_SLOW_UCCE_RXF | UCC_SLOW_UCCE_RX)
+#define UCC_SLOW_INTR           (UCC_SLOW_INTR_TX  | UCC_SLOW_INTR_RX)
+
+/* Transmit On Demand (UTORD)
+*/
+#define UCC_SLOW_TOD            0x8000
+#define UCC_FAST_TOD            0x8000
+
+/* Function code masks.
+*/
+#define FC_GBL                             0x20
+#define FC_DTB_LCL                         0x02
+#define UCC_FAST_FUNCTION_CODE_GBL         0x20
+#define UCC_FAST_FUNCTION_CODE_DTB_LCL     0x02
+#define UCC_FAST_FUNCTION_CODE_BDB_LCL     0x01
+
+#endif				/* __QE_H__ */
+#endif				/* __KERNEL__ */
+#endif				/* CONFIG_QUICC_ENGINE */
-- 
1.4.2.1
