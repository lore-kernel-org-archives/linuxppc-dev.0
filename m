Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0603301334pd7d6029g137246a7ecd58c30@mail.gmail.com>
Date: Thu, 30 Mar 2006 14:34:04 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>,
	"Sylvain Munaut" <tnt@246tnt.com>
Subject: Resubmit munged patch -- [PATCH] Add ATA bestcomm dma support for
	MPC5200.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18969_7631797.1143754444420"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_18969_7631797.1143754444420
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dale noticed that the previous patch had been munged my my mailer.=20
Sorry about that.

------=_Part_18969_7631797.1143754444420
Content-Type: text/plain;
	name=0001-Add-ATA-bestcomm-dma-support-for-MPC5200.txt;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elfltl5r
Content-Disposition: attachment; filename="0001-Add-ATA-bestcomm-dma-support-for-MPC5200.txt"

Subject: [PATCH] Add ATA bestcomm dma support for MPC5200.

This works on the Lite5200B platform with some caveats.
The board seems to have a layout issue so the ata signals have
a noise problem.  You need to use an UDMA cable even though
the connector on the board does not allow most UDMA cables to
be plugged in.  To get around this you can remove the key pin
on the board connector or poke a hole in the cable connector.
You also want to use the shortest cable you can get.  I ended up
cutting the cable just past the slave connector.

Even with the above changes some drives will not work.
With the right cable and the right drive you can do UDMA1.

I have not tested this on the old Lite5200 but it is my
understanding that the older silicon has issues that
make UDMA not work.  MDMA should work though.

Signed-off-by: John Rigby <jrigby@freescale.com>

---

 arch/ppc/syslib/bestcomm/Makefile        |    1 
 arch/ppc/syslib/bestcomm/ata.c           |  143 +++++++
 arch/ppc/syslib/bestcomm/ata.h           |   49 ++
 arch/ppc/syslib/bestcomm/bestcomm.c      |    4 
 arch/ppc/syslib/bestcomm/bestcomm.h      |   27 +
 arch/ppc/syslib/bestcomm/sdma_ata_task.c |   61 +++
 arch/ppc/syslib/mpc52xx_setup.c          |    7 
 drivers/ide/Kconfig                      |   11 +
 drivers/ide/ppc/mpc52xx_ide.c            |  640 +++++++++++++++++++++++++++++-
 9 files changed, 915 insertions(+), 28 deletions(-)
 create mode 100644 arch/ppc/syslib/bestcomm/ata.c
 create mode 100644 arch/ppc/syslib/bestcomm/ata.h
 create mode 100644 arch/ppc/syslib/bestcomm/sdma_ata_task.c

01a9cf3296c225320105d26201fe7e86596a2ad5
diff --git a/arch/ppc/syslib/bestcomm/Makefile b/arch/ppc/syslib/bestcomm/Makefile
index 02cc99a..f04c5ad 100644
--- a/arch/ppc/syslib/bestcomm/Makefile
+++ b/arch/ppc/syslib/bestcomm/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PPC_BESTCOMM) 	+= bestcomm.o
 obj-$(CONFIG_FEC_MPC52xx)	+= sdma_fec_rx_task.o sdma_fec_tx_task.o fec.o
+obj-$(CONFIG_BLK_DEV_MPC52xx_IDE_DMA)	+= sdma_ata_task.o ata.o
diff --git a/arch/ppc/syslib/bestcomm/ata.c b/arch/ppc/syslib/bestcomm/ata.c
new file mode 100644
index 0000000..6feae2e
--- /dev/null
+++ b/arch/ppc/syslib/bestcomm/ata.c
@@ -0,0 +1,143 @@
+/*
+ * arch/ppc/syslib/bestcomm/ata.c
+ *
+ * Driver for MPC52xx processor BestComm ATA controller
+ *
+ * Copyright (C) 2006 Freescale - John Rigby
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Patterned after:
+ *    arch/ppc/syslib/bestcomm/fec.c
+ *
+ *    Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ *    2003-2004 (c) MontaVista, Software, Inc.
+ */
+
+#include <linux/config.h>
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
+#include "ata.h"
+
+/*
+ * Initialize the shared ATA rx/tx task.
+ * Returns task number of ATA task.
+ * Returns -1 on failure
+ */
+int sdma_ata_init(struct sdma *s, int maxbufsize)
+{
+	static int tasknum = -1;
+	static struct sdma_bd2 *bd2 = 0;
+	static u32 bd_pa;
+
+	struct sdma_ata_var *var;
+
+	if (tasknum < 0) {
+		tasknum = sdma_load_task(sdma_ata_task);
+		if (tasknum < 0)
+			return tasknum;
+	}
+
+	if (!bd2) 
+		bd2 = (struct sdma_bd2 *)sdma_sram_alloc(sizeof(*bd2) * s->num_bd,
+								SDMA_BD_ALIGN, &bd_pa);
+	if (!bd2)
+		return -ENOMEM;
+
+	sdma_disable_task(tasknum);
+
+	s->flags = SDMA_FLAGS_BD2;
+	s->tasknum = tasknum;
+	s->bd2 = bd2;
+	s->index = 0;
+	s->outdex = 0;
+	memset(bd2, 0, sizeof(*bd2) * s->num_bd);
+
+	var = (struct sdma_ata_var *)sdma_task_var(tasknum);
+	var->enable		= sdma_io_pa(&sdma.io->tcr[tasknum]);
+	var->bd_base		= bd_pa;
+	var->bd_last		= bd_pa + (s->num_bd - 1)*sizeof(struct sdma_bd2);
+	var->bd_start		= bd_pa;
+	var->buffer_size	= maxbufsize;
+
+	printk("here in %s calling sdma_dump ata var is %08x\n", __FUNCTION__, var);
+	sdma_dump();
+
+#if 0
+	/* some tasks may need this set but ata apparently isn't one of them */
+	sdma_set_size(tasknum, 4, 4) /* SrcSz, DstSz */
+#endif
+	sdma_set_task_pragma(tasknum, SDMA_ATA_PRAGMA);
+	sdma_set_task_auto_start(tasknum, tasknum);
+
+	/* clear pending interrupt bits */
+	out_be32(&sdma.io->IntPend, 1<<tasknum);
+
+	out_8(&sdma.io->ipr[SDMA_INITIATOR_ATA_RX], SDMA_IPR_ATA_RX);
+	out_8(&sdma.io->ipr[SDMA_INITIATOR_ATA_TX], SDMA_IPR_ATA_TX);
+
+	return tasknum;
+}
+
+
+/*
+ * Initialize ATA receive task.
+ */
+void sdma_ata_rx_init(struct sdma *s)
+{
+	struct sdma_ata_inc *inc;
+
+	inc = (struct sdma_ata_inc *)sdma_task_inc(s->tasknum);
+	inc->incr_bytes = -(s16)sizeof(u32);
+	inc->incr_src = 0;
+	inc->incr_dst = sizeof(u32);
+
+	sdma_set_initiator(s->tasknum, SDMA_INITIATOR_ATA_RX);
+}
+
+/*
+ * Initialize ATA transmit task.
+ */
+void sdma_ata_tx_init(struct sdma *s)
+{
+	struct sdma_ata_inc *inc;
+
+	inc = (struct sdma_ata_inc *)sdma_task_inc(s->tasknum);
+	inc->incr_bytes	= -(s16)sizeof(u32);
+	inc->incr_src = sizeof(u32);
+	inc->incr_dst = 0;
+
+	sdma_set_initiator(s->tasknum, SDMA_INITIATOR_ATA_TX);
+}
+
+/*
+ * Reset all the ATA task's bds
+ */
+void sdma_ata_reset(struct sdma *s)
+{
+	struct sdma_ata_var *var;
+
+	sdma_reset_buffers2(s);
+	/*
+	 * Always start at the beginning (the ATA task modifies bd_start on writes)
+	 */
+	s->outdex = s->index = 0;
+	var = (struct sdma_ata_var *)sdma_task_var(s->tasknum);
+	var->bd_start = var->bd_base;
+}
+
+EXPORT_SYMBOL(sdma_ata_init);
+EXPORT_SYMBOL(sdma_ata_rx_init);
+EXPORT_SYMBOL(sdma_ata_tx_init);
+EXPORT_SYMBOL(sdma_ata_reset);
diff --git a/arch/ppc/syslib/bestcomm/ata.h b/arch/ppc/syslib/bestcomm/ata.h
new file mode 100644
index 0000000..6f2e99d
--- /dev/null
+++ b/arch/ppc/syslib/bestcomm/ata.h
@@ -0,0 +1,49 @@
+/*
+ * arch/ppc/syslib/bestcomm/ata.h
+ *
+ * Driver for MPC52xx processor BestComm ATA controller
+ *
+ * Copyright (C) 2006 Freescale - John Rigby
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Patterned after:
+ *    arch/ppc/syslib/bestcomm/fec.c
+ *
+ *    Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ *    2003-2004 (c) MontaVista, Software, Inc.
+ */
+
+#ifndef __BESTCOMM_ATA_H__
+#define __BESTCOMM_ATA_H__
+
+
+/* ata task vars that need to be set before enabling the task */
+struct sdma_ata_var {
+	u32 enable;		/* (u16*) address of task's control register */
+	u32 bd_base;		/* (struct sdma_bd*) beginning of ring buffer */
+	u32 bd_last;		/* (struct sdma_bd*) end of ring buffer */
+	u32 bd_start;		/* (struct sdma_bd*) current bd */
+	u32 buffer_size;	/* size of receive buffer */
+};
+
+/* ata task incs that need to be set before enabling the task */
+struct sdma_ata_inc {
+	u16 pad0;
+	s16 incr_bytes;
+	u16 pad1;
+	s16 incr_dst;
+	u16 pad2;
+	s16 incr_src;
+};
+
+extern int sdma_ata_init(struct sdma *s, int maxbufsize);
+extern void sdma_ata_rx_init(struct sdma *s);
+extern void sdma_ata_tx_init(struct sdma *s);
+extern void sdma_ata_reset(struct sdma *s);
+
+extern u32 sdma_ata_task[];
+
+#endif  /* __BESTCOMM_ATA_H__ */
diff --git a/arch/ppc/syslib/bestcomm/bestcomm.c b/arch/ppc/syslib/bestcomm/bestcomm.c
index 76d5a9b..0f249d6 100644
--- a/arch/ppc/syslib/bestcomm/bestcomm.c
+++ b/arch/ppc/syslib/bestcomm/bestcomm.c
@@ -43,12 +43,12 @@ static spinlock_t sdma_lock = SPIN_LOCK_
 void sdma_dump(void)
 {
 	int i;
-	printk("** SDMA registers: pa = %08x, va = %08x\n", sdma.base_reg_addr, sdma.io);
+
+	printk("** SDMA registers: pa = %08x, va = %08x\n", (u32)sdma.base_reg_addr, (u32)sdma.io);
 	printk("**  taskBar = %08x\n", sdma.io->taskBar);
 	printk("**  currentPointer = %08x\n", sdma.io->currentPointer);
 	printk("**  endPointer = %08x\n", sdma.io->endPointer);
 	printk("**  variablePointer = %08x\n", sdma.io->variablePointer);
-
 	printk("**  IntVect1 = %08x\n", sdma.io->IntVect1);
 	printk("**  IntVect2 = %08x\n", sdma.io->IntVect2);
 	printk("**  PtdCntrl = %08x\n", sdma.io->PtdCntrl);
diff --git a/arch/ppc/syslib/bestcomm/bestcomm.h b/arch/ppc/syslib/bestcomm/bestcomm.h
index 18cb58f..75ff7d2 100644
--- a/arch/ppc/syslib/bestcomm/bestcomm.h
+++ b/arch/ppc/syslib/bestcomm/bestcomm.h
@@ -237,7 +237,7 @@ static inline int sdma_desc_initiator(u3
 static inline void sdma_set_desc_initiator(u32 *desc, int initiator)
 {
 	*desc = (*desc & ~(0x1f << SDMA_DRD_INITIATOR_SHIFT)) |
-			((initiator << SDMA_DRD_INITIATOR_SHIFT) & 0x1f);
+			((initiator & 0x1f) << SDMA_DRD_INITIATOR_SHIFT);
 }
 
 static inline void sdma_submit_buffer(struct sdma *s, void *cookie, void *data,
@@ -284,12 +284,23 @@ static inline void *sdma_retrieve_buffer
 	return cookie;
 }
 
+static inline void sdma_reset_buffers(struct sdma *s)
+{
+	while (!sdma_queue_empty(s)) {
+		s->bd[s->outdex].status = 0;
+		s->bd[s->outdex].data = 0;
+		sdma_retrieve_buffer(s, NULL);
+	}
+	s->index = s->outdex = 0;
+}
+
 static inline void sdma_submit_buffer2(struct sdma *s, void *cookie,
 					void *data1, void *data2, int length)
 {
 #ifdef CONFIG_BESTCOMM_DEBUG
 	BUG_ON(!(s->flags & SDMA_FLAGS_BD2));
 #endif
+
 	s->cookie[s->index] = cookie;
 	s->bd2[s->index].data1 = data1;
 	s->bd2[s->index].data2 = data2;
@@ -312,6 +323,17 @@ static inline void *sdma_retrieve_buffer
 	return cookie;
 }
 
+static inline void sdma_reset_buffers2(struct sdma *s)
+{
+	while (!sdma_queue_empty(s)) {
+		s->bd2[s->outdex].status = 0;
+		s->bd2[s->outdex].data1 = 0;
+		s->bd2[s->outdex].data2 = 0;
+		sdma_retrieve_buffer2(s, NULL);
+	}
+	s->index = s->outdex = 0;
+}
+
 #define SDMA_TASK_MAGIC		0x4243544B	/* 'BCTK' */
 
 /* the size fields are given in number of 32-bit words */
@@ -351,7 +373,7 @@ static inline int sdma_desc_is_drd(u32 d
 				 (0 << SDMA_PRAGMA_BIT_RST_ERROR_NO)	| \
 				 (0 << SDMA_PRAGMA_BIT_PACK)		| \
 				 (0 << SDMA_PRAGMA_BIT_INTEGER)		| \
-				 (1 << SDMA_PRAGMA_BIT_SPECREAD)	| \
+				 (0 << SDMA_PRAGMA_BIT_SPECREAD)	| \
 				 (1 << SDMA_PRAGMA_BIT_CW)		| \
 				 (1 << SDMA_PRAGMA_BIT_RL))
 
@@ -469,6 +491,7 @@ extern int sdma_load_task(u32 *task_imag
 extern void *sdma_sram_alloc(int size, int alignment, u32 *dma_handle);
 extern void sdma_init_bd(struct sdma *s);
 extern void sdma_init_bd2(struct sdma *s);
+extern void sdma_set_initiator(int task, int initiator);
 
 #define FIELD_OFFSET(s,f) ((unsigned long)(&(((struct s*)0)->f)))
 
diff --git a/arch/ppc/syslib/bestcomm/sdma_ata_task.c b/arch/ppc/syslib/bestcomm/sdma_ata_task.c
new file mode 100644
index 0000000..5613545
--- /dev/null
+++ b/arch/ppc/syslib/bestcomm/sdma_ata_task.c
@@ -0,0 +1,61 @@
+/*
+ * sdma_ata_task.c
+ *
+ * Created based on bestcom/code_dma/image_rtos1/dma_image.hex
+ */
+
+#include <linux/types.h>
+
+/*
+ * The header consists of the following fields:
+ *	uint32_t	magic;
+ *	uint8_t		desc_size;
+ *	uint8_t		var_size;
+ *	uint8_t		inc_size;
+ *	uint8_t		first_var;
+ *	uint8_t		reserved[8];
+ *
+ * The size fields contain the number of 32-bit words.
+*/
+
+uint32_t sdma_ata_task[] = {
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
diff --git a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
index 508b241..3c9cd42 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -220,7 +220,6 @@ mpc52xx_calibrate_decr(void)
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
 
-
 void __init
 mpc52xx_setup_cpu(void)
 {
@@ -247,8 +246,9 @@ mpc52xx_setup_cpu(void)
 		out_be16(&cdm->fd_counters, 0x5555);
 
 	/* Configure the XLB Arbiter priorities */
-	out_be32(&xlb->master_pri_enable, 0xff);
-	out_be32(&xlb->master_priority, 0x11111111);
+	/* Give PPC and BestComm the same priority on the XLB */
+	out_be32(&xlb->master_pri_enable, 0xf);
+	out_be32(&xlb->master_priority, 0x00007131);
 
 	/* Enable ram snooping for 1GB window */
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
@@ -265,7 +265,6 @@ unmap_regs:
 	if (xlb)  iounmap(xlb);
 }
 
-
 int mpc52xx_match_psc_function(int psc_idx, const char *func)
 {
 	struct mpc52xx_psc_func *cf = mpc52xx_psc_functions;
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index e391cee..6ecaee7 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -973,6 +973,17 @@ config BLK_DEV_MPC52xx_IDE
 	tristate "MPC52xx Builtin IDE support"
 	depends on PPC_MPC52xx && IDE=y
 
+config BLK_DEV_MPC52xx_IDE_MDMA
+	bool "MDMA support"
+	depends on BLK_DEV_MPC52xx_IDE
+
+config BLK_DEV_MPC52xx_IDE_UDMA
+	bool "UDMA support"
+	depends on BLK_DEV_MPC52xx_IDE
+
+config BLK_DEV_MPC52xx_IDE_DMA
+	def_bool BLK_DEV_MPC52xx_IDE_UDMA || BLK_DEV_MPC52xx_IDE_MDMA
+
 # no isa -> no vlb
 config IDE_CHIPSETS
 	bool "Other IDE chipset support"
diff --git a/drivers/ide/ppc/mpc52xx_ide.c b/drivers/ide/ppc/mpc52xx_ide.c
index 5970f7b..7ab1bcc 100644
--- a/drivers/ide/ppc/mpc52xx_ide.c
+++ b/drivers/ide/ppc/mpc52xx_ide.c
@@ -5,6 +5,7 @@
  *
  *
  * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2005,2006 Freescale - Bernard Kuhn, John Rigby
  * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -24,8 +25,28 @@
 #include <asm/io.h>
 #include <asm/ppcboot.h>
 
+#include <syslib/bestcomm/bestcomm.h>
+#include <syslib/bestcomm/ata.h>
+
 #include "mpc52xx_ide.h"
 
+#define CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1
+#define CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS 1
+
+#define MAX_DMA_BUFFERS 128
+#define MAX_DMA_BUFFER_SIZE 0x20000
+
+#undef DEBUG
+#define DEBUG
+
+#undef DPRINTK
+#ifdef DEBUG
+#define DPRINTK(fmt, args...) printk(fmt, ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+typedef unsigned long ide_ioreg_t;
 
 
 /* Private structures used by the driver */
@@ -42,11 +63,6 @@ struct mpc52xx_ata_timings {
 	int using_udma;
 };
 
-struct mpc52xx_ide_priv {
-	unsigned int ipb_period;	/* in ps */
-	struct mpc52xx_ata __iomem *ata_regs;
-	struct mpc52xx_ata_timings  timings[2];
-};
 
 /* ATAPI-4 PIO specs (arranged for the 5200, cfr User Manual) */
 /* numbers in ns, extrapolation done by code */
@@ -58,9 +74,166 @@ static int ataspec_t2i[5]   = {  0,   0,
 static int ataspec_t4[5]    = { 30,  20,  15,  10,  10};
 static int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
 
-/* Helpers to compute timing parameters */
+/* Helper to compute timing parameters */
 #define CALC_CLK_VALUE_UP(c,v) (((v) + c - 1) / c)
 
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+
+/* ATAPI-4 MDMA specs (in clocks) */
+struct mdmaspec {
+	u32 t0M[3];
+	u32 td[3];
+	u32 th[3];
+	u32 tj[3];
+	u32 tkw[3];
+	u32 tm[3];
+	u32 tn[3];
+};
+
+static struct mdmaspec mdmaspec66 = {
+	{32,  10,  8},
+	{15,  6,   5},
+	{2,   1,   1},
+	{2,   1,   1},
+	{15,  4,   2},
+	{4,   2,   2},
+	{1,   1,   1}
+};
+
+static struct mdmaspec mdmaspec132 = {
+	{64,  20,  16},
+	{29,  11,  10},
+	{3,   2,   2},
+	{3,   1,   1},
+	{29,  7,   4},
+	{7,   4,   4},
+	{2,   1,   1}
+};
+
+#endif
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+/* ATAPI-4 UDMA specs (in clocks) */
+struct udmaspec {
+	u32 tcyc[6];
+	u32 t2cyc[6];
+	u32 tds[6];
+	u32 tdh[6];
+	u32 tdvs[6];
+	u32 tdvh[6];
+	u32 tfs_min[6];
+	u32 tli_max[6];
+	u32 tmli[6];
+	u32 taz[6];
+	u32 tzah[6];
+	u32 tenv_min[6];
+	u32 tsr[6];
+	u32 trfs[6];
+	u32 trp[6];
+	u32 tack[6];
+	u32 tss[6];
+};
+
+struct udmaspec udmaspec66 = {
+	{8, 5,  4,   3,   2,  2},
+	{16, 11,  8,   6,   4 , 2},
+	{1, 1,  1,   1,   1,  1},
+	{1, 1,  1,   1,   1,  1},
+	{5, 4,  3,   2,   1,  1},
+	{1, 1,  1,   1,   1,  1},
+	{16, 14,  12,  9,   8,  6},
+	{10, 10,  10,  7,   8,  5},
+	{2, 2,  2,   2,   2,  2},
+	{1, 1,  1,   1,   1,  1},
+	{2, 2,  2,   2,   2,  2},
+	{2, 2,  2,   2,   2,  2},
+	{3, 2,  2,   2,   2,  2},
+	{5, 5,  4,   4,   4,  4},
+	{11, 9,  7,   7,   7,  6},
+	{2, 2,  2,   2,   2,  2},
+	{4, 4,  4,   4,   4,  4}
+};
+
+struct udmaspec udmaspec132 = {
+	{15, 10,  6,   7,   2,  3},
+	{31, 21,  12,  12,  5,  6},
+	{2, 2,  1,   1,   0,  1},
+	{1, 1,  1,   1,   0,  1},
+	{10, 7,  5,   3,   1,  1},
+	{1, 1,  1,   1,   1,  1},
+	{30, 27,  23,  15,  16, 12},
+	{20, 20,  20,  13,  14, 10},
+	{3, 3,  3,   3,   2,  3},
+	{2, 2,  2,   2,   1,  2},
+	{3, 3,  3,   3,   2,  3},
+	{3, 3,  3,   3,   2,  3},
+	{7, 4,  3,   3,   2,  3},
+	{10, 10,  8,   8,   7,  7},
+	{22, 17,  14,  14, 13, 12},
+	{3, 3,  3,   3,   2,  3},
+	{7, 7,  7,   7,   6,  7},
+};
+
+
+#endif
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
+struct mpc52xx_ide_priv {
+	unsigned int ipb_period;	/* in ps */
+	struct mpc52xx_ata __iomem *ata_regs;
+	struct mpc52xx_ata_timings  timings[2];
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+	struct sdma *sdma;
+	struct udmaspec *udmaspec;
+	struct mdmaspec *mdmaspec;
+	int mpc52xx_ata_dma_last_write;
+#endif
+};
+
+static u8
+mpc52xx_dma2pio (u8 xfer_rate)
+{
+	switch(xfer_rate) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+		case XFER_MW_DMA_2:
+		case XFER_PIO_4:
+			//return 3;
+			return 4;
+		case XFER_MW_DMA_1:
+		case XFER_PIO_3:
+			return 3;
+		case XFER_SW_DMA_2:
+		case XFER_PIO_2:
+			return 2;
+		case XFER_MW_DMA_0:
+		case XFER_SW_DMA_1:
+		case XFER_SW_DMA_0:
+#else
+		case XFER_PIO_4:
+			return 4;
+		case XFER_PIO_3:
+			return 3;
+		case XFER_PIO_2:
+			return 2;
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+		case XFER_PIO_SLOW:
+		default:
+			return 0;
+	}
+}
 
 /* ======================================================================== */
 /* IDE Driver & Aux functions                                               */
@@ -100,6 +273,99 @@ mpc52xx_ide_compute_pio_timing(
 	timing->pio2 = (t4 << 24) | (t1 << 16) | (ta << 8);
 }
 
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+static void mpc52xx_ide_calc_udma_timings(ide_drive_t *drive, u8 speed)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+
+	int which = drive->select.b.unit & 0x01;
+	u32 t2cyc, tcyc, tds, tdh, tdvs, tdvh, tfs, tli, tmli, taz, tenv, tsr, tss, trfs, trp, tack, tzah;
+
+	t2cyc = priv->udmaspec->t2cyc[speed];
+	tcyc = priv->udmaspec->tcyc[speed];
+	tds = priv->udmaspec->tds[speed];
+	tdh = priv->udmaspec->tdh[speed];
+	tdvs = priv->udmaspec->tdvs[speed];
+	tdvh = priv->udmaspec->tdvh[speed];
+	tfs = priv->udmaspec->tfs_min[speed];
+	tmli = priv->udmaspec->tmli[speed];
+	tenv = priv->udmaspec->tenv_min[speed];
+	tss = priv->udmaspec->tss[speed];
+	trp = priv->udmaspec->trp[speed];
+	tack = priv->udmaspec->tack[speed];
+	tzah = priv->udmaspec->tzah[speed];
+	taz = priv->udmaspec->taz[speed];
+	trfs = priv->udmaspec->trfs[speed];
+	tsr = priv->udmaspec->tsr[speed];
+	tli = priv->udmaspec->tli_max[speed];
+
+	DPRINTK ("UDMA t2cyc = %d\n", t2cyc);
+	DPRINTK ("UDMA tcyc  = %d\n", tcyc);
+	DPRINTK ("UDMA tds   = %d\n", tds);
+	DPRINTK ("UDMA tdh   = %d\n", tdh);
+	DPRINTK ("UDMA tdvs  = %d\n", tdvs);
+	DPRINTK ("UDMA tdvh  = %d\n", tdvh);
+	DPRINTK ("UDMA tfs   = %d\n", tfs);
+	DPRINTK ("UDMA tli   = %d\n", tli);
+	DPRINTK ("UDMA tmli  = %d\n", tmli);
+	DPRINTK ("UDMA taz   = %d\n", taz);
+	DPRINTK ("UDMA tenv  = %d\n", tenv);
+	DPRINTK ("UDMA tsr   = %d\n", tsr);
+	DPRINTK ("UDMA tss   = %d\n", tss);
+	DPRINTK ("UDMA trfs  = %d\n", trfs);
+	DPRINTK ("UDMA trp   = %d\n", trp);
+	DPRINTK ("UDMA tack  = %d\n", tack);
+	DPRINTK ("UDMA tzah  = %d\n", tzah);
+
+	priv->timings[which].udma1 = (t2cyc << 24) | (tcyc << 16) | (tds << 8) | (tdh);
+	priv->timings[which].udma2 = (tdvs << 24) | (tdvh << 16) | (tfs << 8) | (tli);
+	priv->timings[which].udma3 = (tmli << 24) | (taz << 16) | (tenv << 8) | (tsr);
+	priv->timings[which].udma4 = (tss << 24) | (trfs << 16) | (trp << 8) | (tack);
+	priv->timings[which].udma5 = (tzah << 24);
+
+	priv->timings[which].using_udma = 1;
+}
+
+#endif
+
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+static void mpc52xx_ide_calc_mdma_timings(ide_drive_t *drive, u8 speed)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	int which = drive->select.b.unit & 0x01;
+	u32 t0M, td, tkw, tm, th, tj, tn;
+
+	t0M = priv->mdmaspec->t0M[speed];
+	td = priv->mdmaspec->td[speed];
+	tkw = priv->mdmaspec->tkw[speed];
+	tm = priv->mdmaspec->tm[speed];
+	th = priv->mdmaspec->th[speed];
+	tj = priv->mdmaspec->tj[speed];
+	tn = priv->mdmaspec->tn[speed];
+
+	DPRINTK ("t0M = %d\n", t0M);
+	DPRINTK ("td  = %d\n", td);
+	DPRINTK ("tkw = %d\n", tkw);
+	DPRINTK ("tm  = %d\n", tm);
+	DPRINTK ("th  = %d\n", th);
+	DPRINTK ("tj  = %d\n", tj);
+	DPRINTK ("tn  = %d\n", tn);
+
+	priv->timings[which].mdma1 = (t0M << 24) | (td << 16) | (tkw << 8) | (tm);
+	priv->timings[which].mdma2 = (th << 24) | (tj << 16) | (tn << 8);
+
+	priv->timings[which].using_udma = 0;
+}
+
+#endif
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
 
 static void
 mpc52xx_ide_tuneproc(ide_drive_t *drive, u8 pio)
@@ -117,25 +383,51 @@ mpc52xx_ide_tuneproc(ide_drive_t *drive,
 	if (drive->select.all == HWIF(drive)->INB(IDE_SELECT_REG))
 		mpc52xx_ide_apply_timing(regs, &priv->timings[w]);
 
-		/* Should we do it here or only in speedproc ? */
-	ide_config_drive_speed(drive, pio + XFER_PIO_0);
+	/* Only call ide_config_drive_speed in speedproc */
 }
 
 static int
 mpc52xx_ide_speedproc(ide_drive_t *drive, u8 speed)
 {
-	/* Configure PIO Mode */
-	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		mpc52xx_ide_tuneproc(drive, speed - XFER_PIO_0);
-		return 0;
-	}
-
-	/* DMA settings currently unsupported */
-	printk(KERN_ERR
-		"mpc52xx-ide: speedproc called with unsupported mode %d\n",
-		speed);
+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1
+	if (speed > XFER_UDMA_1)
+		speed = XFER_UDMA_1;
+#else
+	if (speed > XFER_UDMA_4)
+		speed = XFER_UDMA_4;
+#endif
 
-	return 1;
+	switch(speed) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+			printk("%s: Setting UDMA %d timings\n", drive->name, speed - XFER_UDMA_0);
+			mpc52xx_ide_calc_udma_timings(drive, speed - XFER_UDMA_0);
+			break;
+#endif
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:
+		case XFER_MW_DMA_0:
+			printk("%s: Setting MDMA %d timings\n", drive->name, speed - XFER_MW_DMA_0);
+			mpc52xx_ide_calc_mdma_timings(drive, speed - XFER_MW_DMA_0);
+			break;
+#endif
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_0:
+			break;
+		default:
+			return -EINVAL;
+	}
+	mpc52xx_ide_tuneproc(drive, mpc52xx_dma2pio(speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 static void
@@ -151,6 +443,225 @@ mpc52xx_ide_selectproc(ide_drive_t *driv
 }
 
 
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+static int mpc52xx_ide_dma_check(ide_drive_t *drive)
+{
+	u8 speed = ide_dma_speed(drive, 2);
+
+	DPRINTK("dma_check: speed=%x\n", speed);
+	if (speed == 0)
+		return -1;
+	mpc52xx_ide_speedproc(drive, speed);
+
+	if (ide_dma_enable(drive))
+		drive->using_dma = 1;
+	else
+		drive->using_dma = 0;
+
+	return 0;
+}
+
+static int mpc52xx_ide_build_dmatable(ide_drive_t *drive, struct request *rq)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+	struct scatterlist *sg;
+	ide_hwif_t *hwif = HWIF(drive);
+	int i, count = 0;
+
+	/* Build sglist */
+	hwif->sg_nents = i = ide_build_sglist(drive, rq);
+	if (!hwif->sg_nents)
+		return 0;
+
+	if (hwif->sg_dma_direction == PCI_DMA_FROMDEVICE) {
+	    sdma_ata_rx_init(priv->sdma);
+	} else {
+	    sdma_ata_tx_init(priv->sdma);
+	}
+
+
+	sg = hwif->sg_table;
+	while (i && sg_dma_len(sg)) {
+		u32 cur_addr;
+		u32 cur_len;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		while (cur_len) {
+			unsigned int tc  = (cur_len <= MAX_DMA_BUFFER_SIZE) ? cur_len: MAX_DMA_BUFFER_SIZE;
+
+			if (hwif->sg_dma_direction == PCI_DMA_FROMDEVICE) {
+				invalidate_dcache_range((u32)phys_to_virt(cur_addr), (u32)phys_to_virt(cur_addr)+(u32)tc);
+				sdma_submit_buffer2(priv->sdma, phys_to_virt(cur_addr), (void *)&regs->fifo_data, (void *)cur_addr, tc);
+			} else {
+				flush_dcache_range((u32)phys_to_virt(cur_addr), (u32)phys_to_virt(cur_addr)+(u32)tc);
+				sdma_submit_buffer2(priv->sdma, phys_to_virt(cur_addr), (void *)cur_addr, (void *)&regs->fifo_data, tc);
+			}
+
+			//DPRINTK("SDMA setup @%08x, l: %x, nextbd: %d !\n", cur_addr, tc, next_bd);
+			cur_addr += tc;
+			cur_len -= tc;
+			count++;
+			if(count == MAX_DMA_BUFFERS) {
+				printk(KERN_WARNING "%s: DMA table too small\n",drive->name);
+				goto use_pio_instead;
+			};
+		}
+		sg++;
+		i--;
+	}
+
+	return 1;
+
+use_pio_instead:
+	sdma_ata_reset(priv->sdma);
+
+	pci_unmap_sg(hwif->pci_dev,
+			hwif->sg_table,
+			hwif->sg_nents,
+			hwif->sg_dma_direction);
+
+	return 0; /* revert to PIO for this request */
+}
+
+
+/* Teardown mappings after DMA has completed.  */
+static void mpc52xx_ide_destroy_dmatable (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	struct scatterlist *sg = hwif->sg_table;
+	int nents = hwif->sg_nents;
+
+	if (nents) {
+		pci_unmap_sg(dev, sg, nents, hwif->sg_dma_direction);
+		hwif->sg_nents = 0;
+	}
+}
+
+
+static void mpc52xx_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+
+	mpc52xx_ide_wait_tip_bit_clear(regs);
+
+	/* issue cmd to drive */
+	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
+}
+
+
+static int mpc52xx_ide_dma_setup(ide_drive_t *drive)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+	ide_hwif_t *hwif = HWIF(drive);
+	struct request *rq = HWGROUP(drive)->rq;
+	int which = drive->select.b.unit & 0x01;
+	u8 dma_mode;
+
+	if (!mpc52xx_ide_build_dmatable(drive, rq)) {
+		ide_map_sg(drive, rq);
+		return 1;
+	};
+
+	if(hwif->sg_dma_direction == PCI_DMA_FROMDEVICE) { /* read */
+
+		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ | MPC52xx_ATA_DMAMODE_FE;
+
+		/* Setup FIFO if direction changed */
+		if (priv->mpc52xx_ata_dma_last_write) {
+			priv->mpc52xx_ata_dma_last_write = 0;
+			mpc52xx_ide_wait_tip_bit_clear(regs);
+			out_8(&regs->dma_mode, MPC52xx_ATA_DMAMODE_FR);
+			/* Configure it with granularity to 7 like sample code */
+			out_8(&regs->fifo_control, 7);
+			out_be16(&regs->fifo_alarm, 128);
+		}
+	}
+	else {
+
+		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;
+
+		/* Setup FIFO if direction changed */
+		if (!priv->mpc52xx_ata_dma_last_write) {
+			priv->mpc52xx_ata_dma_last_write = 1;
+			mpc52xx_ide_wait_tip_bit_clear(regs);
+			/* Configure FIFO with granularity to 4 like sample code */
+			out_8(&regs->fifo_control, 4);
+			//out_be16(&regs->fifo_alarm, 256);
+			out_be16(&regs->fifo_alarm, 128);
+		}
+	};
+
+	if (priv->timings[which].using_udma)
+		dma_mode |= MPC52xx_ATA_DMAMODE_UDMA;
+
+	mpc52xx_ide_wait_tip_bit_clear(regs);
+	out_8(&regs->dma_mode, dma_mode);
+
+	drive->waiting_for_dma = 1;
+
+	return 0;
+};
+
+static void mpc52xx_ide_dma_start(ide_drive_t *drive)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	extern void xlb_clear(void);
+
+	xlb_clear();
+	sdma_set_task_auto_start(priv->sdma->tasknum, priv->sdma->tasknum);
+	sdma_enable(priv->sdma);
+}
+
+
+static int mpc52xx_ide_dma_end(ide_drive_t *drive)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+
+	drive->waiting_for_dma = 0;
+
+	sdma_disable(priv->sdma);
+	sdma_clear_irq(priv->sdma);
+	sdma_ata_reset(priv->sdma);
+	mpc52xx_ide_destroy_dmatable(drive);
+
+	return 0;
+}
+
+
+static int mpc52xx_ide_dma_test_irq(ide_drive_t *drive)
+{
+	return (drive->waiting_for_dma);
+}
+
+
+static int mpc52xx_ide_dma_host_off(ide_drive_t *drive)
+{
+	return 0;
+}
+
+
+static int mpc52xx_ide_dma_host_on(ide_drive_t *drive)
+{
+	return 0;
+}
+
+static int mpc52xx_ide_dma_lostirq(ide_drive_t *drive)
+{
+	printk(KERN_ERR "%s: lost interrupt\n", drive->name);
+	return 0;
+}
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
+
 static int
 mpc52xx_ide_setup(
 	struct mpc52xx_ata __iomem *regs, struct mpc52xx_ide_priv *priv)
@@ -181,6 +692,21 @@ mpc52xx_ide_setup(
 	tslot = CALC_CLK_VALUE_UP(priv->ipb_period, 1000000);
 	out_be32(&regs->share_cnt, tslot << 16);
 
+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS
+	printk("ipb=%dMHz, set clock period to %d ps\n",(int)(bd->bi_ipbfreq/1000000), 
+			priv->ipb_period);
+#endif
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+	if(bd->bi_ipbfreq/1000000 == 66) {
+		priv->mdmaspec = &mdmaspec66;
+		priv->udmaspec = &udmaspec66;
+	} else {
+		priv->mdmaspec = &mdmaspec132;
+		priv->udmaspec = &udmaspec132;
+	}
+#endif
+
 	/* Init imings to PIO0 (safest) */
 	memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));
 
@@ -189,9 +715,35 @@ mpc52xx_ide_setup(
 
 	mpc52xx_ide_apply_timing(regs, &priv->timings[0]);
 
+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS
+	printk("GPIO config: %08x\n", in_be32((u32 *)0xf0000b00));
+	printk("ATA invalid: %08x\n", in_be32((u32 *)0xf0003a2c));
+	printk("ATA hostcnf: %08x\n", in_be32((u32 *)0xf0003a00));
+	printk("ATA pio1   : %08x\n", in_be32((u32 *)0xf0003a08));
+	printk("ATA pio2   : %08x\n", in_be32((u32 *)0xf0003a0c));
+	printk("XLB Arb cnf: %08x\n", in_be32((u32 *)0xf0001f40));
+#endif
+
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+static int
+mpc52xx_ata_sdma_setup(struct mpc52xx_ide_priv *priv)
+{
+	int rv = 0;
+
+	priv->sdma = sdma_alloc(MAX_DMA_BUFFERS);
+	if (!priv->sdma) {
+		return -ENOMEM;
+	}
+
+	(void) sdma_ata_init(priv->sdma, MAX_DMA_BUFFER_SIZE);
+
+	return rv;
+}
+#endif
+
 static void
 mpc52xx_ide_setup_hwif_ports(hw_regs_t *hw, struct mpc52xx_ata __iomem *regs)
 {
@@ -218,7 +770,7 @@ mpc52xx_ide_probe(struct platform_device
 {
 	/* Vars */
 	ide_hwif_t *hwif;
-	struct mpc52xx_ide_priv *priv;
+	struct mpc52xx_ide_priv *priv = NULL;
 	struct mpc52xx_gpio __iomem *gpio_regs = NULL;
 	struct mpc52xx_ata __iomem *ata_regs = NULL;
 	int ata_irq;
@@ -284,6 +836,7 @@ mpc52xx_ide_probe(struct platform_device
 		goto error;
 	}
 
+	memset(priv, 0, sizeof *priv);
 	priv->ata_regs = ata_regs;
 
 	/* Setup the ATA controller */
@@ -292,6 +845,13 @@ mpc52xx_ide_probe(struct platform_device
 		printk(KERN_ERR "mpc52xx-ide: Controller setup failed !\n");
 		goto error;
 	}
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+	rv = mpc52xx_ata_sdma_setup(priv);
+	if (rv) {
+		printk(KERN_ERR "mpc52xx-ide: SDMA setup failed !\n");
+		goto error;
+	}
+#endif
 
 	/* Setup the hwif structure */
 	hwif->irq = ata_irq;
@@ -325,6 +885,38 @@ mpc52xx_ide_probe(struct platform_device
 	hwif->drives[1].autodma = hwif->autodma;
 	hwif->drives[1].no_io_32bit = 1;	/* Anyone tried ? */
 
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+	hwif->atapi_dma = 1;
+	hwif->autodma = 1;
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+	hwif->mwdma_mask = 0x07;
+#endif
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+	hwif->ultra_mask = 0x1F;
+#endif
+	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
+	hwif->ide_dma_on = &__ide_dma_on;
+	hwif->ide_dma_check = &mpc52xx_ide_dma_check;
+	hwif->dma_setup = &mpc52xx_ide_dma_setup;
+	hwif->dma_exec_cmd = &mpc52xx_ide_dma_exec_cmd;
+	hwif->dma_start = &mpc52xx_ide_dma_start;
+	hwif->ide_dma_end = &mpc52xx_ide_dma_end;
+	hwif->ide_dma_test_irq = &mpc52xx_ide_dma_test_irq;
+	hwif->ide_dma_host_off = &mpc52xx_ide_dma_host_off;
+	hwif->ide_dma_host_on = &mpc52xx_ide_dma_host_on;
+	hwif->ide_dma_timeout = &__ide_dma_timeout;
+	hwif->ide_dma_lostirq = &mpc52xx_ide_dma_lostirq;
+
+#ifndef CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1
+	hwif->udma_four = 1;
+#endif
+	hwif->hwif_data = priv;
+
+	priv->mpc52xx_ata_dma_last_write = 1;
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
 	hwif->hwif_data = priv;
 	platform_set_drvdata(dev, hwif);
 
@@ -346,6 +938,14 @@ error:
 
 	release_mem_region(res_mem->start, sizeof(struct mpc52xx_ata));
 
+	if (priv) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+		if (priv->sdma)	sdma_free(priv->sdma);
+#endif
+		kfree(priv);
+	}
+		
+
 	return rv;
 }
 
-- 
1.1.3

------=_Part_18969_7631797.1143754444420--
