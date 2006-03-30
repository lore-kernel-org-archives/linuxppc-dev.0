Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0603300951n3c1d38e2mc347de10d28b818c@mail.gmail.com>
Date: Thu, 30 Mar 2006 10:51:28 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: "Sylvain Munaut" <tnt@246tnt.com>,
	Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Subject: [PATCH] Add ATA bestcomm dma support for MPC5200B.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13908_15682114.1143741088805"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_13908_15682114.1143741088805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[PATCH] Add ATA bestcomm dma support for MPC5200B.

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
 drivers/ide/ppc/mpc52xx_ide.c            |  640
+++++++++++++++++++++++++++++-
 9 files changed, 915 insertions(+), 28 deletions(-)
 create mode 100644 arch/ppc/syslib/bestcomm/ata.c
 create mode 100644 arch/ppc/syslib/bestcomm/ata.h
 create mode 100644 arch/ppc/syslib/bestcomm/sdma_ata_task.c

01a9cf3296c225320105d26201fe7e86596a2ad5
diff --git a/arch/ppc/syslib/bestcomm/Makefile
b/arch/ppc/syslib/bestcomm/Makefile
index 02cc99a..f04c5ad 100644
--- a/arch/ppc/syslib/bestcomm/Makefile
+++ b/arch/ppc/syslib/bestcomm/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PPC_BESTCOMM)     +=3D bestcomm.o
 obj-$(CONFIG_FEC_MPC52xx)    +=3D sdma_fec_rx_task.o sdma_fec_tx_task.o fe=
c.o
+obj-$(CONFIG_BLK_DEV_MPC52xx_IDE_DMA)    +=3D sdma_ata_task.o ata.o
diff --git a/arch/ppc/syslib/bestcomm/ata.c b/arch/ppc/syslib/bestcomm/ata.=
c
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
+    static int tasknum =3D -1;
+    static struct sdma_bd2 *bd2 =3D 0;
+    static u32 bd_pa;
+
+    struct sdma_ata_var *var;
+
+    if (tasknum < 0) {
+        tasknum =3D sdma_load_task(sdma_ata_task);
+        if (tasknum < 0)
+            return tasknum;
+    }
+
+    if (!bd2)
+        bd2 =3D (struct sdma_bd2 *)sdma_sram_alloc(sizeof(*bd2) * s->num_b=
d,
+                                SDMA_BD_ALIGN, &bd_pa);
+    if (!bd2)
+        return -ENOMEM;
+
+    sdma_disable_task(tasknum);
+
+    s->flags =3D SDMA_FLAGS_BD2;
+    s->tasknum =3D tasknum;
+    s->bd2 =3D bd2;
+    s->index =3D 0;
+    s->outdex =3D 0;
+    memset(bd2, 0, sizeof(*bd2) * s->num_bd);
+
+    var =3D (struct sdma_ata_var *)sdma_task_var(tasknum);
+    var->enable        =3D sdma_io_pa(&sdma.io->tcr[tasknum]);
+    var->bd_base        =3D bd_pa;
+    var->bd_last        =3D bd_pa + (s->num_bd - 1)*sizeof(struct sdma_bd2=
);
+    var->bd_start        =3D bd_pa;
+    var->buffer_size    =3D maxbufsize;
+
+    printk("here in %s calling sdma_dump ata var is %08x\n", __FUNCTION__,
var);
+    sdma_dump();
+
+#if 0
+    /* some tasks may need this set but ata apparently isn't one of them *=
/
+    sdma_set_size(tasknum, 4, 4) /* SrcSz, DstSz */
+#endif
+    sdma_set_task_pragma(tasknum, SDMA_ATA_PRAGMA);
+    sdma_set_task_auto_start(tasknum, tasknum);
+
+    /* clear pending interrupt bits */
+    out_be32(&sdma.io->IntPend, 1<<tasknum);
+
+    out_8(&sdma.io->ipr[SDMA_INITIATOR_ATA_RX], SDMA_IPR_ATA_RX);
+    out_8(&sdma.io->ipr[SDMA_INITIATOR_ATA_TX], SDMA_IPR_ATA_TX);
+
+    return tasknum;
+}
+
+
+/*
+ * Initialize ATA receive task.
+ */
+void sdma_ata_rx_init(struct sdma *s)
+{
+    struct sdma_ata_inc *inc;
+
+    inc =3D (struct sdma_ata_inc *)sdma_task_inc(s->tasknum);
+    inc->incr_bytes =3D -(s16)sizeof(u32);
+    inc->incr_src =3D 0;
+    inc->incr_dst =3D sizeof(u32);
+
+    sdma_set_initiator(s->tasknum, SDMA_INITIATOR_ATA_RX);
+}
+
+/*
+ * Initialize ATA transmit task.
+ */
+void sdma_ata_tx_init(struct sdma *s)
+{
+    struct sdma_ata_inc *inc;
+
+    inc =3D (struct sdma_ata_inc *)sdma_task_inc(s->tasknum);
+    inc->incr_bytes    =3D -(s16)sizeof(u32);
+    inc->incr_src =3D sizeof(u32);
+    inc->incr_dst =3D 0;
+
+    sdma_set_initiator(s->tasknum, SDMA_INITIATOR_ATA_TX);
+}
+
+/*
+ * Reset all the ATA task's bds
+ */
+void sdma_ata_reset(struct sdma *s)
+{
+    struct sdma_ata_var *var;
+
+    sdma_reset_buffers2(s);
+    /*
+     * Always start at the beginning (the ATA task modifies bd_start on
writes)
+     */
+    s->outdex =3D s->index =3D 0;
+    var =3D (struct sdma_ata_var *)sdma_task_var(s->tasknum);
+    var->bd_start =3D var->bd_base;
+}
+
+EXPORT_SYMBOL(sdma_ata_init);
+EXPORT_SYMBOL(sdma_ata_rx_init);
+EXPORT_SYMBOL(sdma_ata_tx_init);
+EXPORT_SYMBOL(sdma_ata_reset);
diff --git a/arch/ppc/syslib/bestcomm/ata.h b/arch/ppc/syslib/bestcomm/ata.=
h
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
+    u32 enable;        /* (u16*) address of task's control register */
+    u32 bd_base;        /* (struct sdma_bd*) beginning of ring buffer */
+    u32 bd_last;        /* (struct sdma_bd*) end of ring buffer */
+    u32 bd_start;        /* (struct sdma_bd*) current bd */
+    u32 buffer_size;    /* size of receive buffer */
+};
+
+/* ata task incs that need to be set before enabling the task */
+struct sdma_ata_inc {
+    u16 pad0;
+    s16 incr_bytes;
+    u16 pad1;
+    s16 incr_dst;
+    u16 pad2;
+    s16 incr_src;
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
diff --git a/arch/ppc/syslib/bestcomm/bestcomm.c
b/arch/ppc/syslib/bestcomm/bestcomm.c
index 76d5a9b..0f249d6 100644
--- a/arch/ppc/syslib/bestcomm/bestcomm.c
+++ b/arch/ppc/syslib/bestcomm/bestcomm.c
@@ -43,12 +43,12 @@ static spinlock_t sdma_lock =3D SPIN_LOCK_
 void sdma_dump(void)
 {
     int i;
-    printk("** SDMA registers: pa =3D %08x, va =3D %08x\n", sdma.base_reg_=
addr,
sdma.io);
+
+    printk("** SDMA registers: pa =3D %08x, va =3D %08x\n",
(u32)sdma.base_reg_addr, (u32)sdma.io);
     printk("**  taskBar =3D %08x\n", sdma.io->taskBar);
     printk("**  currentPointer =3D %08x\n", sdma.io->currentPointer);
     printk("**  endPointer =3D %08x\n", sdma.io->endPointer);
     printk("**  variablePointer =3D %08x\n", sdma.io->variablePointer);
-
     printk("**  IntVect1 =3D %08x\n", sdma.io->IntVect1);
     printk("**  IntVect2 =3D %08x\n", sdma.io->IntVect2);
     printk("**  PtdCntrl =3D %08x\n", sdma.io->PtdCntrl);
diff --git a/arch/ppc/syslib/bestcomm/bestcomm.h
b/arch/ppc/syslib/bestcomm/bestcomm.h
index 18cb58f..75ff7d2 100644
--- a/arch/ppc/syslib/bestcomm/bestcomm.h
+++ b/arch/ppc/syslib/bestcomm/bestcomm.h
@@ -237,7 +237,7 @@ static inline int sdma_desc_initiator(u3
 static inline void sdma_set_desc_initiator(u32 *desc, int initiator)
 {
     *desc =3D (*desc & ~(0x1f << SDMA_DRD_INITIATOR_SHIFT)) |
-            ((initiator << SDMA_DRD_INITIATOR_SHIFT) & 0x1f);
+            ((initiator & 0x1f) << SDMA_DRD_INITIATOR_SHIFT);
 }

 static inline void sdma_submit_buffer(struct sdma *s, void *cookie, void
*data,
@@ -284,12 +284,23 @@ static inline void *sdma_retrieve_buffer
     return cookie;
 }

+static inline void sdma_reset_buffers(struct sdma *s)
+{
+    while (!sdma_queue_empty(s)) {
+        s->bd[s->outdex].status =3D 0;
+        s->bd[s->outdex].data =3D 0;
+        sdma_retrieve_buffer(s, NULL);
+    }
+    s->index =3D s->outdex =3D 0;
+}
+
 static inline void sdma_submit_buffer2(struct sdma *s, void *cookie,
                     void *data1, void *data2, int length)
 {
 #ifdef CONFIG_BESTCOMM_DEBUG
     BUG_ON(!(s->flags & SDMA_FLAGS_BD2));
 #endif
+
     s->cookie[s->index] =3D cookie;
     s->bd2[s->index].data1 =3D data1;
     s->bd2[s->index].data2 =3D data2;
@@ -312,6 +323,17 @@ static inline void *sdma_retrieve_buffer
     return cookie;
 }

+static inline void sdma_reset_buffers2(struct sdma *s)
+{
+    while (!sdma_queue_empty(s)) {
+        s->bd2[s->outdex].status =3D 0;
+        s->bd2[s->outdex].data1 =3D 0;
+        s->bd2[s->outdex].data2 =3D 0;
+        sdma_retrieve_buffer2(s, NULL);
+    }
+    s->index =3D s->outdex =3D 0;
+}
+
 #define SDMA_TASK_MAGIC        0x4243544B    /* 'BCTK' */

 /* the size fields are given in number of 32-bit words */
@@ -351,7 +373,7 @@ static inline int sdma_desc_is_drd(u32 d
                  (0 << SDMA_PRAGMA_BIT_RST_ERROR_NO)    | \
                  (0 << SDMA_PRAGMA_BIT_PACK)        | \
                  (0 << SDMA_PRAGMA_BIT_INTEGER)        | \
-                 (1 << SDMA_PRAGMA_BIT_SPECREAD)    | \
+                 (0 << SDMA_PRAGMA_BIT_SPECREAD)    | \
                  (1 << SDMA_PRAGMA_BIT_CW)        | \
                  (1 << SDMA_PRAGMA_BIT_RL))

@@ -469,6 +491,7 @@ extern int sdma_load_task(u32 *task_imag
 extern void *sdma_sram_alloc(int size, int alignment, u32 *dma_handle);
 extern void sdma_init_bd(struct sdma *s);
 extern void sdma_init_bd2(struct sdma *s);
+extern void sdma_set_initiator(int task, int initiator);

 #define FIELD_OFFSET(s,f) ((unsigned long)(&(((struct s*)0)->f)))

diff --git a/arch/ppc/syslib/bestcomm/sdma_ata_task.c
b/arch/ppc/syslib/bestcomm/sdma_ata_task.c
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
+ *    uint32_t    magic;
+ *    uint8_t        desc_size;
+ *    uint8_t        var_size;
+ *    uint8_t        inc_size;
+ *    uint8_t        first_var;
+ *    uint8_t        reserved[8];
+ *
+ * The size fields contain the number of 32-bit words.
+*/
+
+uint32_t sdma_ata_task[] =3D {
+    /* header */
+    0x4243544b,
+    0x0e060709,
+    0x00000000,
+    0x00000000,
+
+    /* Task descriptors */
+    0x8198009b, /* LCD: idx0 =3D var3; idx0 <=3D var2; idx0 +=3D inc3 */
+    0x13e00c08, /*   DRD1A: var3 =3D var1; FN=3D0 MORE init=3D31 WS=3D0 RS=
=3D0 */
+    0xb8000264, /*   LCD: idx1 =3D *idx0, idx2 =3D var0; idx1 < var9; idx1=
 +=3D
inc4, idx2 +=3D inc4 */
+    0x10000f00, /*     DRD1A: var3 =3D idx0; FN=3D0 MORE init=3D0 WS=3D0 R=
S=3D0 */
+    0x60140002, /*     DRD2A: EU0=3D0 EU1=3D0 EU2=3D0 EU3=3D2 EXT init=3D0=
 WS=3D2 RS=3D2
*/
+    0x0c8cfc8a, /*     DRD2B1: *idx2 =3D EU3(); EU3(*idx2,var10)  */
+    0xd8988240, /*   LCDEXT: idx1 =3D idx1; idx1 > var9; idx1 +=3D inc0 */
+    0xf845e011, /*   LCDEXT: idx2 =3D *(idx0 + var00000015); ; idx2 +=3D i=
nc2
*/
+    0xb845e00a, /*   LCD: idx3 =3D *(idx0 + var00000019); ; idx3 +=3D inc1=
 */
+    0x0bfecf90, /*     DRD1A: *idx3 =3D *idx2; FN=3D0 TFD init=3D31 WS=3D3=
 RS=3D3 */
+    0x9898802d, /*   LCD: idx1 =3D idx1; idx1 once var0; idx1 +=3D inc5 */
+    0x64000005, /*     DRD2A: EU0=3D0 EU1=3D0 EU2=3D0 EU3=3D5 INT EXT init=
=3D0 WS=3D0
RS=3D0 */
+    0x0c0cf849, /*     DRD2B1: *idx0 =3D EU3(); EU3(idx1,var9)  */
+    0x000001f8, /* NOP */
+
+
+    /* VAR[9]-VAR[14] */
+    0x40000000,
+    0x7fff7fff,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+    0x00000000,
+
+    /* INC[0]-INC[6] */
+    0x40000000,
+    0xe0000000,
+    0xe0000000,
+    0xa000000c,
+    0x20000000,
+    0x00000000,
+    0x00000000,
+};
diff --git a/arch/ppc/syslib/mpc52xx_setup.c
b/arch/ppc/syslib/mpc52xx_setup.c
index 508b241..3c9cd42 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -220,7 +220,6 @@ mpc52xx_calibrate_decr(void)
     tb_to_us =3D mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }

-
 void __init
 mpc52xx_setup_cpu(void)
 {
@@ -247,8 +246,9 @@ mpc52xx_setup_cpu(void)
         out_be16(&cdm->fd_counters, 0x5555);

     /* Configure the XLB Arbiter priorities */
-    out_be32(&xlb->master_pri_enable, 0xff);
-    out_be32(&xlb->master_priority, 0x11111111);
+    /* Give PPC and BestComm the same priority on the XLB */
+    out_be32(&xlb->master_pri_enable, 0xf);
+    out_be32(&xlb->master_priority, 0x00007131);

     /* Enable ram snooping for 1GB window */
     out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
@@ -265,7 +265,6 @@ unmap_regs:
     if (xlb)  iounmap(xlb);
 }

-
 int mpc52xx_match_psc_function(int psc_idx, const char *func)
 {
     struct mpc52xx_psc_func *cf =3D mpc52xx_psc_functions;
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index e391cee..6ecaee7 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -973,6 +973,17 @@ config BLK_DEV_MPC52xx_IDE
     tristate "MPC52xx Builtin IDE support"
     depends on PPC_MPC52xx && IDE=3Dy

+config BLK_DEV_MPC52xx_IDE_MDMA
+    bool "MDMA support"
+    depends on BLK_DEV_MPC52xx_IDE
+
+config BLK_DEV_MPC52xx_IDE_UDMA
+    bool "UDMA support"
+    depends on BLK_DEV_MPC52xx_IDE
+
+config BLK_DEV_MPC52xx_IDE_DMA
+    def_bool BLK_DEV_MPC52xx_IDE_UDMA || BLK_DEV_MPC52xx_IDE_MDMA
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
-    unsigned int ipb_period;    /* in ps */
-    struct mpc52xx_ata __iomem *ata_regs;
-    struct mpc52xx_ata_timings  timings[2];
-};

 /* ATAPI-4 PIO specs (arranged for the 5200, cfr User Manual) */
 /* numbers in ns, extrapolation done by code */
@@ -58,9 +74,166 @@ static int ataspec_t2i[5]   =3D {  0,   0,
 static int ataspec_t4[5]    =3D { 30,  20,  15,  10,  10};
 static int ataspec_ta[5]    =3D { 35,  35,  35,  35,  35};

-/* Helpers to compute timing parameters */
+/* Helper to compute timing parameters */
 #define CALC_CLK_VALUE_UP(c,v) (((v) + c - 1) / c)

+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+
+/* ATAPI-4 MDMA specs (in clocks) */
+struct mdmaspec {
+    u32 t0M[3];
+    u32 td[3];
+    u32 th[3];
+    u32 tj[3];
+    u32 tkw[3];
+    u32 tm[3];
+    u32 tn[3];
+};
+
+static struct mdmaspec mdmaspec66 =3D {
+    {32,  10,  8},
+    {15,  6,   5},
+    {2,   1,   1},
+    {2,   1,   1},
+    {15,  4,   2},
+    {4,   2,   2},
+    {1,   1,   1}
+};
+
+static struct mdmaspec mdmaspec132 =3D {
+    {64,  20,  16},
+    {29,  11,  10},
+    {3,   2,   2},
+    {3,   1,   1},
+    {29,  7,   4},
+    {7,   4,   4},
+    {2,   1,   1}
+};
+
+#endif
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+/* ATAPI-4 UDMA specs (in clocks) */
+struct udmaspec {
+    u32 tcyc[6];
+    u32 t2cyc[6];
+    u32 tds[6];
+    u32 tdh[6];
+    u32 tdvs[6];
+    u32 tdvh[6];
+    u32 tfs_min[6];
+    u32 tli_max[6];
+    u32 tmli[6];
+    u32 taz[6];
+    u32 tzah[6];
+    u32 tenv_min[6];
+    u32 tsr[6];
+    u32 trfs[6];
+    u32 trp[6];
+    u32 tack[6];
+    u32 tss[6];
+};
+
+struct udmaspec udmaspec66 =3D {
+    {8, 5,  4,   3,   2,  2},
+    {16, 11,  8,   6,   4 , 2},
+    {1, 1,  1,   1,   1,  1},
+    {1, 1,  1,   1,   1,  1},
+    {5, 4,  3,   2,   1,  1},
+    {1, 1,  1,   1,   1,  1},
+    {16, 14,  12,  9,   8,  6},
+    {10, 10,  10,  7,   8,  5},
+    {2, 2,  2,   2,   2,  2},
+    {1, 1,  1,   1,   1,  1},
+    {2, 2,  2,   2,   2,  2},
+    {2, 2,  2,   2,   2,  2},
+    {3, 2,  2,   2,   2,  2},
+    {5, 5,  4,   4,   4,  4},
+    {11, 9,  7,   7,   7,  6},
+    {2, 2,  2,   2,   2,  2},
+    {4, 4,  4,   4,   4,  4}
+};
+
+struct udmaspec udmaspec132 =3D {
+    {15, 10,  6,   7,   2,  3},
+    {31, 21,  12,  12,  5,  6},
+    {2, 2,  1,   1,   0,  1},
+    {1, 1,  1,   1,   0,  1},
+    {10, 7,  5,   3,   1,  1},
+    {1, 1,  1,   1,   1,  1},
+    {30, 27,  23,  15,  16, 12},
+    {20, 20,  20,  13,  14, 10},
+    {3, 3,  3,   3,   2,  3},
+    {2, 2,  2,   2,   1,  2},
+    {3, 3,  3,   3,   2,  3},
+    {3, 3,  3,   3,   2,  3},
+    {7, 4,  3,   3,   2,  3},
+    {10, 10,  8,   8,   7,  7},
+    {22, 17,  14,  14, 13, 12},
+    {3, 3,  3,   3,   2,  3},
+    {7, 7,  7,   7,   6,  7},
+};
+
+
+#endif
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
+struct mpc52xx_ide_priv {
+    unsigned int ipb_period;    /* in ps */
+    struct mpc52xx_ata __iomem *ata_regs;
+    struct mpc52xx_ata_timings  timings[2];
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+    struct sdma *sdma;
+    struct udmaspec *udmaspec;
+    struct mdmaspec *mdmaspec;
+    int mpc52xx_ata_dma_last_write;
+#endif
+};
+
+static u8
+mpc52xx_dma2pio (u8 xfer_rate)
+{
+    switch(xfer_rate) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+        case XFER_UDMA_6:
+        case XFER_UDMA_5:
+        case XFER_UDMA_4:
+        case XFER_UDMA_3:
+        case XFER_UDMA_2:
+        case XFER_UDMA_1:
+        case XFER_UDMA_0:
+        case XFER_MW_DMA_2:
+        case XFER_PIO_4:
+            //return 3;
+            return 4;
+        case XFER_MW_DMA_1:
+        case XFER_PIO_3:
+            return 3;
+        case XFER_SW_DMA_2:
+        case XFER_PIO_2:
+            return 2;
+        case XFER_MW_DMA_0:
+        case XFER_SW_DMA_1:
+        case XFER_SW_DMA_0:
+#else
+        case XFER_PIO_4:
+            return 4;
+        case XFER_PIO_3:
+            return 3;
+        case XFER_PIO_2:
+            return 2;
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+        case XFER_PIO_1:
+        case XFER_PIO_0:
+        case XFER_PIO_SLOW:
+        default:
+            return 0;
+    }
+}

 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
*/
 /* IDE Driver & Aux functions
*/
@@ -100,6 +273,99 @@ mpc52xx_ide_compute_pio_timing(
     timing->pio2 =3D (t4 << 24) | (t1 << 16) | (ta << 8);
 }

+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+static void mpc52xx_ide_calc_udma_timings(ide_drive_t *drive, u8 speed)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+
+    int which =3D drive->select.b.unit & 0x01;
+    u32 t2cyc, tcyc, tds, tdh, tdvs, tdvh, tfs, tli, tmli, taz, tenv, tsr,
tss, trfs, trp, tack, tzah;
+
+    t2cyc =3D priv->udmaspec->t2cyc[speed];
+    tcyc =3D priv->udmaspec->tcyc[speed];
+    tds =3D priv->udmaspec->tds[speed];
+    tdh =3D priv->udmaspec->tdh[speed];
+    tdvs =3D priv->udmaspec->tdvs[speed];
+    tdvh =3D priv->udmaspec->tdvh[speed];
+    tfs =3D priv->udmaspec->tfs_min[speed];
+    tmli =3D priv->udmaspec->tmli[speed];
+    tenv =3D priv->udmaspec->tenv_min[speed];
+    tss =3D priv->udmaspec->tss[speed];
+    trp =3D priv->udmaspec->trp[speed];
+    tack =3D priv->udmaspec->tack[speed];
+    tzah =3D priv->udmaspec->tzah[speed];
+    taz =3D priv->udmaspec->taz[speed];
+    trfs =3D priv->udmaspec->trfs[speed];
+    tsr =3D priv->udmaspec->tsr[speed];
+    tli =3D priv->udmaspec->tli_max[speed];
+
+    DPRINTK ("UDMA t2cyc =3D %d\n", t2cyc);
+    DPRINTK ("UDMA tcyc  =3D %d\n", tcyc);
+    DPRINTK ("UDMA tds   =3D %d\n", tds);
+    DPRINTK ("UDMA tdh   =3D %d\n", tdh);
+    DPRINTK ("UDMA tdvs  =3D %d\n", tdvs);
+    DPRINTK ("UDMA tdvh  =3D %d\n", tdvh);
+    DPRINTK ("UDMA tfs   =3D %d\n", tfs);
+    DPRINTK ("UDMA tli   =3D %d\n", tli);
+    DPRINTK ("UDMA tmli  =3D %d\n", tmli);
+    DPRINTK ("UDMA taz   =3D %d\n", taz);
+    DPRINTK ("UDMA tenv  =3D %d\n", tenv);
+    DPRINTK ("UDMA tsr   =3D %d\n", tsr);
+    DPRINTK ("UDMA tss   =3D %d\n", tss);
+    DPRINTK ("UDMA trfs  =3D %d\n", trfs);
+    DPRINTK ("UDMA trp   =3D %d\n", trp);
+    DPRINTK ("UDMA tack  =3D %d\n", tack);
+    DPRINTK ("UDMA tzah  =3D %d\n", tzah);
+
+    priv->timings[which].udma1 =3D (t2cyc << 24) | (tcyc << 16) | (tds << =
8)
| (tdh);
+    priv->timings[which].udma2 =3D (tdvs << 24) | (tdvh << 16) | (tfs << 8=
) |
(tli);
+    priv->timings[which].udma3 =3D (tmli << 24) | (taz << 16) | (tenv << 8=
) |
(tsr);
+    priv->timings[which].udma4 =3D (tss << 24) | (trfs << 16) | (trp << 8)=
 |
(tack);
+    priv->timings[which].udma5 =3D (tzah << 24);
+
+    priv->timings[which].using_udma =3D 1;
+}
+
+#endif
+
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+
+static void mpc52xx_ide_calc_mdma_timings(ide_drive_t *drive, u8 speed)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+    int which =3D drive->select.b.unit & 0x01;
+    u32 t0M, td, tkw, tm, th, tj, tn;
+
+    t0M =3D priv->mdmaspec->t0M[speed];
+    td =3D priv->mdmaspec->td[speed];
+    tkw =3D priv->mdmaspec->tkw[speed];
+    tm =3D priv->mdmaspec->tm[speed];
+    th =3D priv->mdmaspec->th[speed];
+    tj =3D priv->mdmaspec->tj[speed];
+    tn =3D priv->mdmaspec->tn[speed];
+
+    DPRINTK ("t0M =3D %d\n", t0M);
+    DPRINTK ("td  =3D %d\n", td);
+    DPRINTK ("tkw =3D %d\n", tkw);
+    DPRINTK ("tm  =3D %d\n", tm);
+    DPRINTK ("th  =3D %d\n", th);
+    DPRINTK ("tj  =3D %d\n", tj);
+    DPRINTK ("tn  =3D %d\n", tn);
+
+    priv->timings[which].mdma1 =3D (t0M << 24) | (td << 16) | (tkw << 8) |
(tm);
+    priv->timings[which].mdma2 =3D (th << 24) | (tj << 16) | (tn << 8);
+
+    priv->timings[which].using_udma =3D 0;
+}
+
+#endif
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+

 static void
 mpc52xx_ide_tuneproc(ide_drive_t *drive, u8 pio)
@@ -117,25 +383,51 @@ mpc52xx_ide_tuneproc(ide_drive_t *drive,
     if (drive->select.all =3D=3D HWIF(drive)->INB(IDE_SELECT_REG))
         mpc52xx_ide_apply_timing(regs, &priv->timings[w]);

-        /* Should we do it here or only in speedproc ? */
-    ide_config_drive_speed(drive, pio + XFER_PIO_0);
+    /* Only call ide_config_drive_speed in speedproc */
 }

 static int
 mpc52xx_ide_speedproc(ide_drive_t *drive, u8 speed)
 {
-    /* Configure PIO Mode */
-    if (speed >=3D XFER_PIO_0 && speed <=3D XFER_PIO_4) {
-        mpc52xx_ide_tuneproc(drive, speed - XFER_PIO_0);
-        return 0;
-    }
-
-    /* DMA settings currently unsupported */
-    printk(KERN_ERR
-        "mpc52xx-ide: speedproc called with unsupported mode %d\n",
-        speed);
+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1
+    if (speed > XFER_UDMA_1)
+        speed =3D XFER_UDMA_1;
+#else
+    if (speed > XFER_UDMA_4)
+        speed =3D XFER_UDMA_4;
+#endif

-    return 1;
+    switch(speed) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+        case XFER_UDMA_4:
+        case XFER_UDMA_3:
+        case XFER_UDMA_2:
+        case XFER_UDMA_1:
+        case XFER_UDMA_0:
+            printk("%s: Setting UDMA %d timings\n", drive->name, speed -
XFER_UDMA_0);
+            mpc52xx_ide_calc_udma_timings(drive, speed - XFER_UDMA_0);
+            break;
+#endif
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+        case XFER_MW_DMA_2:
+        case XFER_MW_DMA_1:
+        case XFER_MW_DMA_0:
+            printk("%s: Setting MDMA %d timings\n", drive->name, speed -
XFER_MW_DMA_0);
+            mpc52xx_ide_calc_mdma_timings(drive, speed - XFER_MW_DMA_0);
+            break;
+#endif
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+        case XFER_PIO_4:
+        case XFER_PIO_3:
+        case XFER_PIO_2:
+        case XFER_PIO_0:
+            break;
+        default:
+            return -EINVAL;
+    }
+    mpc52xx_ide_tuneproc(drive, mpc52xx_dma2pio(speed));
+    return ide_config_drive_speed(drive, speed);
 }

 static void
@@ -151,6 +443,225 @@ mpc52xx_ide_selectproc(ide_drive_t *driv
 }


+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+static int mpc52xx_ide_dma_check(ide_drive_t *drive)
+{
+    u8 speed =3D ide_dma_speed(drive, 2);
+
+    DPRINTK("dma_check: speed=3D%x\n", speed);
+    if (speed =3D=3D 0)
+        return -1;
+    mpc52xx_ide_speedproc(drive, speed);
+
+    if (ide_dma_enable(drive))
+        drive->using_dma =3D 1;
+    else
+        drive->using_dma =3D 0;
+
+    return 0;
+}
+
+static int mpc52xx_ide_build_dmatable(ide_drive_t *drive, struct request
*rq)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+    struct mpc52xx_ata __iomem *regs =3D priv->ata_regs;
+    struct scatterlist *sg;
+    ide_hwif_t *hwif =3D HWIF(drive);
+    int i, count =3D 0;
+
+    /* Build sglist */
+    hwif->sg_nents =3D i =3D ide_build_sglist(drive, rq);
+    if (!hwif->sg_nents)
+        return 0;
+
+    if (hwif->sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE) {
+        sdma_ata_rx_init(priv->sdma);
+    } else {
+        sdma_ata_tx_init(priv->sdma);
+    }
+
+
+    sg =3D hwif->sg_table;
+    while (i && sg_dma_len(sg)) {
+        u32 cur_addr;
+        u32 cur_len;
+
+        cur_addr =3D sg_dma_address(sg);
+        cur_len =3D sg_dma_len(sg);
+
+        while (cur_len) {
+            unsigned int tc  =3D (cur_len <=3D MAX_DMA_BUFFER_SIZE) ? cur_=
len:
MAX_DMA_BUFFER_SIZE;
+
+            if (hwif->sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE) {
+                invalidate_dcache_range((u32)phys_to_virt(cur_addr),
(u32)phys_to_virt(cur_addr)+(u32)tc);
+                sdma_submit_buffer2(priv->sdma, phys_to_virt(cur_addr),
(void *)&regs->fifo_data, (void *)cur_addr, tc);
+            } else {
+                flush_dcache_range((u32)phys_to_virt(cur_addr),
(u32)phys_to_virt(cur_addr)+(u32)tc);
+                sdma_submit_buffer2(priv->sdma, phys_to_virt(cur_addr),
(void *)cur_addr, (void *)&regs->fifo_data, tc);
+            }
+
+            //DPRINTK("SDMA setup @%08x, l: %x, nextbd: %d !\n", cur_addr,
tc, next_bd);
+            cur_addr +=3D tc;
+            cur_len -=3D tc;
+            count++;
+            if(count =3D=3D MAX_DMA_BUFFERS) {
+                printk(KERN_WARNING "%s: DMA table too
small\n",drive->name);
+                goto use_pio_instead;
+            };
+        }
+        sg++;
+        i--;
+    }
+
+    return 1;
+
+use_pio_instead:
+    sdma_ata_reset(priv->sdma);
+
+    pci_unmap_sg(hwif->pci_dev,
+            hwif->sg_table,
+            hwif->sg_nents,
+            hwif->sg_dma_direction);
+
+    return 0; /* revert to PIO for this request */
+}
+
+
+/* Teardown mappings after DMA has completed.  */
+static void mpc52xx_ide_destroy_dmatable (ide_drive_t *drive)
+{
+    ide_hwif_t *hwif =3D drive->hwif;
+    struct pci_dev *dev =3D HWIF(drive)->pci_dev;
+    struct scatterlist *sg =3D hwif->sg_table;
+    int nents =3D hwif->sg_nents;
+
+    if (nents) {
+        pci_unmap_sg(dev, sg, nents, hwif->sg_dma_direction);
+        hwif->sg_nents =3D 0;
+    }
+}
+
+
+static void mpc52xx_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+    struct mpc52xx_ata __iomem *regs =3D priv->ata_regs;
+
+    mpc52xx_ide_wait_tip_bit_clear(regs);
+
+    /* issue cmd to drive */
+    ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
+}
+
+
+static int mpc52xx_ide_dma_setup(ide_drive_t *drive)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+    struct mpc52xx_ata __iomem *regs =3D priv->ata_regs;
+    ide_hwif_t *hwif =3D HWIF(drive);
+    struct request *rq =3D HWGROUP(drive)->rq;
+    int which =3D drive->select.b.unit & 0x01;
+    u8 dma_mode;
+
+    if (!mpc52xx_ide_build_dmatable(drive, rq)) {
+        ide_map_sg(drive, rq);
+        return 1;
+    };
+
+    if(hwif->sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE) { /* read */
+
+        dma_mode =3D MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ |
MPC52xx_ATA_DMAMODE_FE;
+
+        /* Setup FIFO if direction changed */
+        if (priv->mpc52xx_ata_dma_last_write) {
+            priv->mpc52xx_ata_dma_last_write =3D 0;
+            mpc52xx_ide_wait_tip_bit_clear(regs);
+            out_8(&regs->dma_mode, MPC52xx_ATA_DMAMODE_FR);
+            /* Configure it with granularity to 7 like sample code */
+            out_8(&regs->fifo_control, 7);
+            out_be16(&regs->fifo_alarm, 128);
+        }
+    }
+    else {
+
+        dma_mode =3D MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;
+
+        /* Setup FIFO if direction changed */
+        if (!priv->mpc52xx_ata_dma_last_write) {
+            priv->mpc52xx_ata_dma_last_write =3D 1;
+            mpc52xx_ide_wait_tip_bit_clear(regs);
+            /* Configure FIFO with granularity to 4 like sample code */
+            out_8(&regs->fifo_control, 4);
+            //out_be16(&regs->fifo_alarm, 256);
+            out_be16(&regs->fifo_alarm, 128);
+        }
+    };
+
+    if (priv->timings[which].using_udma)
+        dma_mode |=3D MPC52xx_ATA_DMAMODE_UDMA;
+
+    mpc52xx_ide_wait_tip_bit_clear(regs);
+    out_8(&regs->dma_mode, dma_mode);
+
+    drive->waiting_for_dma =3D 1;
+
+    return 0;
+};
+
+static void mpc52xx_ide_dma_start(ide_drive_t *drive)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+    extern void xlb_clear(void);
+
+    xlb_clear();
+    sdma_set_task_auto_start(priv->sdma->tasknum, priv->sdma->tasknum);
+    sdma_enable(priv->sdma);
+}
+
+
+static int mpc52xx_ide_dma_end(ide_drive_t *drive)
+{
+    struct mpc52xx_ide_priv *priv =3D drive->hwif->hwif_data;
+
+    drive->waiting_for_dma =3D 0;
+
+    sdma_disable(priv->sdma);
+    sdma_clear_irq(priv->sdma);
+    sdma_ata_reset(priv->sdma);
+    mpc52xx_ide_destroy_dmatable(drive);
+
+    return 0;
+}
+
+
+static int mpc52xx_ide_dma_test_irq(ide_drive_t *drive)
+{
+    return (drive->waiting_for_dma);
+}
+
+
+static int mpc52xx_ide_dma_host_off(ide_drive_t *drive)
+{
+    return 0;
+}
+
+
+static int mpc52xx_ide_dma_host_on(ide_drive_t *drive)
+{
+    return 0;
+}
+
+static int mpc52xx_ide_dma_lostirq(ide_drive_t *drive)
+{
+    printk(KERN_ERR "%s: lost interrupt\n", drive->name);
+    return 0;
+}
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
+
 static int
 mpc52xx_ide_setup(
     struct mpc52xx_ata __iomem *regs, struct mpc52xx_ide_priv *priv)
@@ -181,6 +692,21 @@ mpc52xx_ide_setup(
     tslot =3D CALC_CLK_VALUE_UP(priv->ipb_period, 1000000);
     out_be32(&regs->share_cnt, tslot << 16);

+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS
+    printk("ipb=3D%dMHz, set clock period to %d
ps\n",(int)(bd->bi_ipbfreq/1000000),
+            priv->ipb_period);
+#endif
+
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+    if(bd->bi_ipbfreq/1000000 =3D=3D 66) {
+        priv->mdmaspec =3D &mdmaspec66;
+        priv->udmaspec =3D &udmaspec66;
+    } else {
+        priv->mdmaspec =3D &mdmaspec132;
+        priv->udmaspec =3D &udmaspec132;
+    }
+#endif
+
     /* Init imings to PIO0 (safest) */
     memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));

@@ -189,9 +715,35 @@ mpc52xx_ide_setup(

     mpc52xx_ide_apply_timing(regs, &priv->timings[0]);

+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS
+    printk("GPIO config: %08x\n", in_be32((u32 *)0xf0000b00));
+    printk("ATA invalid: %08x\n", in_be32((u32 *)0xf0003a2c));
+    printk("ATA hostcnf: %08x\n", in_be32((u32 *)0xf0003a00));
+    printk("ATA pio1   : %08x\n", in_be32((u32 *)0xf0003a08));
+    printk("ATA pio2   : %08x\n", in_be32((u32 *)0xf0003a0c));
+    printk("XLB Arb cnf: %08x\n", in_be32((u32 *)0xf0001f40));
+#endif
+
     return 0;
 }

+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+static int
+mpc52xx_ata_sdma_setup(struct mpc52xx_ide_priv *priv)
+{
+    int rv =3D 0;
+
+    priv->sdma =3D sdma_alloc(MAX_DMA_BUFFERS);
+    if (!priv->sdma) {
+        return -ENOMEM;
+    }
+
+    (void) sdma_ata_init(priv->sdma, MAX_DMA_BUFFER_SIZE);
+
+    return rv;
+}
+#endif
+
 static void
 mpc52xx_ide_setup_hwif_ports(hw_regs_t *hw, struct mpc52xx_ata __iomem
*regs)
 {
@@ -218,7 +770,7 @@ mpc52xx_ide_probe(struct platform_device
 {
     /* Vars */
     ide_hwif_t *hwif;
-    struct mpc52xx_ide_priv *priv;
+    struct mpc52xx_ide_priv *priv =3D NULL;
     struct mpc52xx_gpio __iomem *gpio_regs =3D NULL;
     struct mpc52xx_ata __iomem *ata_regs =3D NULL;
     int ata_irq;
@@ -284,6 +836,7 @@ mpc52xx_ide_probe(struct platform_device
         goto error;
     }

+    memset(priv, 0, sizeof *priv);
     priv->ata_regs =3D ata_regs;

     /* Setup the ATA controller */
@@ -292,6 +845,13 @@ mpc52xx_ide_probe(struct platform_device
         printk(KERN_ERR "mpc52xx-ide: Controller setup failed !\n");
         goto error;
     }
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+    rv =3D mpc52xx_ata_sdma_setup(priv);
+    if (rv) {
+        printk(KERN_ERR "mpc52xx-ide: SDMA setup failed !\n");
+        goto error;
+    }
+#endif

     /* Setup the hwif structure */
     hwif->irq =3D ata_irq;
@@ -325,6 +885,38 @@ mpc52xx_ide_probe(struct platform_device
     hwif->drives[1].autodma =3D hwif->autodma;
     hwif->drives[1].no_io_32bit =3D 1;    /* Anyone tried ? */

+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+
+    hwif->atapi_dma =3D 1;
+    hwif->autodma =3D 1;
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA
+    hwif->mwdma_mask =3D 0x07;
+#endif
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
+    hwif->ultra_mask =3D 0x1F;
+#endif
+    hwif->ide_dma_off_quietly =3D &__ide_dma_off_quietly;
+    hwif->ide_dma_on =3D &__ide_dma_on;
+    hwif->ide_dma_check =3D &mpc52xx_ide_dma_check;
+    hwif->dma_setup =3D &mpc52xx_ide_dma_setup;
+    hwif->dma_exec_cmd =3D &mpc52xx_ide_dma_exec_cmd;
+    hwif->dma_start =3D &mpc52xx_ide_dma_start;
+    hwif->ide_dma_end =3D &mpc52xx_ide_dma_end;
+    hwif->ide_dma_test_irq =3D &mpc52xx_ide_dma_test_irq;
+    hwif->ide_dma_host_off =3D &mpc52xx_ide_dma_host_off;
+    hwif->ide_dma_host_on =3D &mpc52xx_ide_dma_host_on;
+    hwif->ide_dma_timeout =3D &__ide_dma_timeout;
+    hwif->ide_dma_lostirq =3D &mpc52xx_ide_dma_lostirq;
+
+#ifndef CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1
+    hwif->udma_four =3D 1;
+#endif
+    hwif->hwif_data =3D priv;
+
+    priv->mpc52xx_ata_dma_last_write =3D 1;
+
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
+
     hwif->hwif_data =3D priv;
     platform_set_drvdata(dev, hwif);

@@ -346,6 +938,14 @@ error:

     release_mem_region(res_mem->start, sizeof(struct mpc52xx_ata));

+    if (priv) {
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA
+        if (priv->sdma)    sdma_free(priv->sdma);
+#endif
+        kfree(priv);
+    }
+
+
     return rv;
 }

--
1.1.3

------=_Part_13908_15682114.1143741088805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[PATCH] Add ATA bestcomm dma support for MPC5200B.<br><br>This works on the=
 Lite5200B platform with some caveats.<br>The board seems to have a layout =
issue so the ata signals have<br>a noise problem.&nbsp; You need to use an =
UDMA cable even though
<br>the connector on the board does not allow most UDMA cables to<br>be plu=
gged in.&nbsp; To get around this you can remove the key pin<br>on the boar=
d connector or poke a hole in the cable connector.<br>You also want to use =
the shortest cable you can get.&nbsp; I ended up
<br>cutting the cable just past the slave connector.<br><br>Even with the a=
bove changes some drives will not work.<br>With the right cable and the rig=
ht drive you can do UDMA1.<br><br>Signed-off-by: John Rigby &lt;<a href=3D"=
mailto:jrigby@freescale.com">
jrigby@freescale.com</a>&gt;<br><br>---<br><br>&nbsp;arch/ppc/syslib/bestco=
mm/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1=
 <br>&nbsp;arch/ppc/syslib/bestcomm/ata.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 143 +++++++<br>&nbsp;arch/ppc/syslib/bes=
tcomm/ata.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 49 ++<br>&nbsp;arch/ppc/syslib/bestcomm/bestcomm.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4=20
<br>&nbsp;arch/ppc/syslib/bestcomm/bestcomm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp;&nbsp; 27 +<br>&nbsp;arch/ppc/syslib/bestcomm/sdma_ata_task.c |&nbs=
p;&nbsp; 61 +++<br>&nbsp;arch/ppc/syslib/mpc52xx_setup.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 <br>&nbsp;drivers=
/ide/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 11 +<br>
&nbsp;drivers/ide/ppc/mpc52xx_ide.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 640 +++++++++++++++++++++++++++++-<br>&n=
bsp;9 files changed, 915 insertions(+), 28 deletions(-)<br>&nbsp;create mod=
e 100644 arch/ppc/syslib/bestcomm/ata.c<br>&nbsp;create mode 100644 arch/pp=
c/syslib/bestcomm/ata.h
<br>&nbsp;create mode 100644 arch/ppc/syslib/bestcomm/sdma_ata_task.c<br><b=
r>01a9cf3296c225320105d26201fe7e86596a2ad5<br>diff --git a/arch/ppc/syslib/=
bestcomm/Makefile b/arch/ppc/syslib/bestcomm/Makefile<br>index 02cc99a..f04=
c5ad 100644
<br>--- a/arch/ppc/syslib/bestcomm/Makefile<br>+++ b/arch/ppc/syslib/bestco=
mm/Makefile<br>@@ -1,2 +1,3 @@<br>&nbsp;obj-$(CONFIG_PPC_BESTCOMM) &nbsp;&n=
bsp; &nbsp;+=3D bestcomm.o<br>&nbsp;obj-$(CONFIG_FEC_MPC52xx)&nbsp;&nbsp; &=
nbsp;+=3D sdma_fec_rx_task.o sdma_fec_tx_task.o=20
fec.o<br>+obj-$(CONFIG_BLK_DEV_MPC52xx_IDE_DMA)&nbsp;&nbsp; &nbsp;+=3D sdma=
_ata_task.o ata.o<br>diff --git a/arch/ppc/syslib/bestcomm/ata.c b/arch/ppc=
/syslib/bestcomm/ata.c<br>new file mode 100644<br>index 0000000..6feae2e<br=
>--- /dev/null
<br>+++ b/arch/ppc/syslib/bestcomm/ata.c<br>@@ -0,0 +1,143 @@<br>+/*<br>+ *=
 arch/ppc/syslib/bestcomm/ata.c<br>+ *<br>+ * Driver for MPC52xx processor =
BestComm ATA controller<br>+ *<br>+ * Copyright (C) 2006 Freescale - John R=
igby
<br>+ *<br>+ * This file is licensed under the terms of the GNU General Pub=
lic License<br>+ * version 2. This program is licensed &quot;as is&quot; wi=
thout any warranty of any<br>+ * kind, whether express or implied.<br>+ *
<br>+ * Patterned after:<br>+ *&nbsp;&nbsp;&nbsp; arch/ppc/syslib/bestcomm/=
fec.c<br>+ *<br>+ *&nbsp;&nbsp;&nbsp; Author: Dale Farnsworth &lt;<a href=
=3D"mailto:dfarnsworth@mvista.com">dfarnsworth@mvista.com</a>&gt;<br>+ *&nb=
sp;&nbsp;&nbsp; 2003-2004 (c) MontaVista, Software, Inc.
<br>+ */<br>+<br>+#include &lt;linux/config.h&gt;<br>+#include &lt;linux/ve=
rsion.h&gt;<br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux/kern=
el.h&gt;<br>+#include &lt;linux/string.h&gt;<br>+#include &lt;linux/types.h=
&gt;
<br>+#include &lt;asm/errno.h&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<br>+#include &lt;asm/io.h&gt;<br>=
+<br>+#include &lt;asm/mpc52xx.h&gt;<br>+<br>+#include &quot;bestcomm.h&quo=
t;<br>+#include &quot;ata.h&quot;<br>+<br>+/*<br>+ * Initialize the shared =
ATA rx/tx task.
<br>+ * Returns task number of ATA task.<br>+ * Returns -1 on failure<br>+ =
*/<br>+int sdma_ata_init(struct sdma *s, int maxbufsize)<br>+{<br>+&nbsp;&n=
bsp; &nbsp;static int tasknum =3D -1;<br>+&nbsp;&nbsp; &nbsp;static struct =
sdma_bd2 *bd2 =3D 0;<br>+&nbsp;&nbsp; &nbsp;static u32 bd_pa;
<br>+<br>+&nbsp;&nbsp; &nbsp;struct sdma_ata_var *var;<br>+<br>+&nbsp;&nbsp=
; &nbsp;if (tasknum &lt; 0) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;tas=
knum =3D sdma_load_task(sdma_ata_task);<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;if (tasknum &lt; 0)<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;return tasknum;<br>+&nbsp;&nbsp; &nbsp;}<br>+<br>+&nbsp;&nbsp;=
 &nbsp;if (!bd2)=20
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;bd2 =3D (struct sdma_bd2 *)sdma_=
sram_alloc(sizeof(*bd2) * s-&gt;num_bd,<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;SDMA_BD_ALIGN, &amp;bd_pa);<b=
r>+&nbsp;&nbsp; &nbsp;if (!bd2)<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;r=
eturn -ENOMEM;<br>+<br>+&nbsp;&nbsp; &nbsp;sdma_disable_task(tasknum);
<br>+<br>+&nbsp;&nbsp; &nbsp;s-&gt;flags =3D SDMA_FLAGS_BD2;<br>+&nbsp;&nbs=
p; &nbsp;s-&gt;tasknum =3D tasknum;<br>+&nbsp;&nbsp; &nbsp;s-&gt;bd2 =3D bd=
2;<br>+&nbsp;&nbsp; &nbsp;s-&gt;index =3D 0;<br>+&nbsp;&nbsp; &nbsp;s-&gt;o=
utdex =3D 0;<br>+&nbsp;&nbsp; &nbsp;memset(bd2, 0, sizeof(*bd2) * s-&gt;num=
_bd);<br>+<br>+&nbsp;&nbsp; &nbsp;var =3D (struct sdma_ata_var *)sdma_task_=
var(tasknum);
<br>+&nbsp;&nbsp; &nbsp;var-&gt;enable&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;=3D sdma_io_pa(&amp;sdma.io-&gt;tcr[tasknum]);<br>+&nbsp;&nbsp; &nbsp;var-=
&gt;bd_base&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=3D bd_pa;<br>+&nbsp;&nbsp=
; &nbsp;var-&gt;bd_last&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=3D bd_pa + (s=
-&gt;num_bd - 1)*sizeof(struct sdma_bd2);<br>+&nbsp;&nbsp; &nbsp;var-&gt;bd=
_start&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=3D bd_pa;
<br>+&nbsp;&nbsp; &nbsp;var-&gt;buffer_size&nbsp;&nbsp; &nbsp;=3D maxbufsiz=
e;<br>+<br>+&nbsp;&nbsp; &nbsp;printk(&quot;here in %s calling sdma_dump at=
a var is %08x\n&quot;, __FUNCTION__, var);<br>+&nbsp;&nbsp; &nbsp;sdma_dump=
();<br>+<br>+#if 0<br>+&nbsp;&nbsp; &nbsp;/* some tasks may need this set b=
ut ata apparently isn't one of them */
<br>+&nbsp;&nbsp; &nbsp;sdma_set_size(tasknum, 4, 4) /* SrcSz, DstSz */<br>=
+#endif<br>+&nbsp;&nbsp; &nbsp;sdma_set_task_pragma(tasknum, SDMA_ATA_PRAGM=
A);<br>+&nbsp;&nbsp; &nbsp;sdma_set_task_auto_start(tasknum, tasknum);<br>+=
<br>+&nbsp;&nbsp; &nbsp;/* clear pending interrupt bits */
<br>+&nbsp;&nbsp; &nbsp;out_be32(&amp;sdma.io-&gt;IntPend, 1&lt;&lt;tasknum=
);<br>+<br>+&nbsp;&nbsp; &nbsp;out_8(&amp;sdma.io-&gt;ipr[SDMA_INITIATOR_AT=
A_RX], SDMA_IPR_ATA_RX);<br>+&nbsp;&nbsp; &nbsp;out_8(&amp;sdma.io-&gt;ipr[=
SDMA_INITIATOR_ATA_TX], SDMA_IPR_ATA_TX);
<br>+<br>+&nbsp;&nbsp; &nbsp;return tasknum;<br>+}<br>+<br>+<br>+/*<br>+ * =
Initialize ATA receive task.<br>+ */<br>+void sdma_ata_rx_init(struct sdma =
*s)<br>+{<br>+&nbsp;&nbsp; &nbsp;struct sdma_ata_inc *inc;<br>+<br>+&nbsp;&=
nbsp; &nbsp;inc =3D (struct sdma_ata_inc *)sdma_task_inc(s-&gt;tasknum);
<br>+&nbsp;&nbsp; &nbsp;inc-&gt;incr_bytes =3D -(s16)sizeof(u32);<br>+&nbsp=
;&nbsp; &nbsp;inc-&gt;incr_src =3D 0;<br>+&nbsp;&nbsp; &nbsp;inc-&gt;incr_d=
st =3D sizeof(u32);<br>+<br>+&nbsp;&nbsp; &nbsp;sdma_set_initiator(s-&gt;ta=
sknum, SDMA_INITIATOR_ATA_RX);<br>+}<br>+<br>+/*<br>+ * Initialize ATA tran=
smit task.
<br>+ */<br>+void sdma_ata_tx_init(struct sdma *s)<br>+{<br>+&nbsp;&nbsp; &=
nbsp;struct sdma_ata_inc *inc;<br>+<br>+&nbsp;&nbsp; &nbsp;inc =3D (struct =
sdma_ata_inc *)sdma_task_inc(s-&gt;tasknum);<br>+&nbsp;&nbsp; &nbsp;inc-&gt=
;incr_bytes&nbsp;&nbsp; &nbsp;=3D -(s16)sizeof(u32);<br>+&nbsp;&nbsp; &nbsp=
;inc-&gt;incr_src =3D sizeof(u32);
<br>+&nbsp;&nbsp; &nbsp;inc-&gt;incr_dst =3D 0;<br>+<br>+&nbsp;&nbsp; &nbsp=
;sdma_set_initiator(s-&gt;tasknum, SDMA_INITIATOR_ATA_TX);<br>+}<br>+<br>+/=
*<br>+ * Reset all the ATA task's bds<br>+ */<br>+void sdma_ata_reset(struc=
t sdma *s)<br>+{<br>+&nbsp;&nbsp; &nbsp;struct sdma_ata_var *var;
<br>+<br>+&nbsp;&nbsp; &nbsp;sdma_reset_buffers2(s);<br>+&nbsp;&nbsp; &nbsp=
;/*<br>+&nbsp;&nbsp; &nbsp; * Always start at the beginning (the ATA task m=
odifies bd_start on writes)<br>+&nbsp;&nbsp; &nbsp; */<br>+&nbsp;&nbsp; &nb=
sp;s-&gt;outdex =3D s-&gt;index =3D 0;<br>+&nbsp;&nbsp; &nbsp;var =3D (stru=
ct sdma_ata_var *)sdma_task_var(s-&gt;tasknum);
<br>+&nbsp;&nbsp; &nbsp;var-&gt;bd_start =3D var-&gt;bd_base;<br>+}<br>+<br=
>+EXPORT_SYMBOL(sdma_ata_init);<br>+EXPORT_SYMBOL(sdma_ata_rx_init);<br>+EX=
PORT_SYMBOL(sdma_ata_tx_init);<br>+EXPORT_SYMBOL(sdma_ata_reset);<br>diff -=
-git a/arch/ppc/syslib/bestcomm/ata.h b/arch/ppc/syslib/bestcomm/ata.h
<br>new file mode 100644<br>index 0000000..6f2e99d<br>--- /dev/null<br>+++ =
b/arch/ppc/syslib/bestcomm/ata.h<br>@@ -0,0 +1,49 @@<br>+/*<br>+ * arch/ppc=
/syslib/bestcomm/ata.h<br>+ *<br>+ * Driver for MPC52xx processor BestComm =
ATA controller
<br>+ *<br>+ * Copyright (C) 2006 Freescale - John Rigby<br>+ *<br>+ * This=
 file is licensed under the terms of the GNU General Public License<br>+ * =
version 2. This program is licensed &quot;as is&quot; without any warranty =
of any
<br>+ * kind, whether express or implied.<br>+ *<br>+ * Patterned after:<br=
>+ *&nbsp;&nbsp;&nbsp; arch/ppc/syslib/bestcomm/fec.c<br>+ *<br>+ *&nbsp;&n=
bsp;&nbsp; Author: Dale Farnsworth &lt;<a href=3D"mailto:dfarnsworth@mvista=
.com">dfarnsworth@mvista.com
</a>&gt;<br>+ *&nbsp;&nbsp;&nbsp; 2003-2004 (c) MontaVista, Software, Inc.<=
br>+ */<br>+<br>+#ifndef __BESTCOMM_ATA_H__<br>+#define __BESTCOMM_ATA_H__<=
br>+<br>+<br>+/* ata task vars that need to be set before enabling the task=
 */<br>+struct sdma_ata_var {
<br>+&nbsp;&nbsp; &nbsp;u32 enable;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/*=
 (u16*) address of task's control register */<br>+&nbsp;&nbsp; &nbsp;u32 bd=
_base;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* (struct sdma_bd*) beginning =
of ring buffer */<br>+&nbsp;&nbsp; &nbsp;u32 bd_last;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;/* (struct sdma_bd*) end of ring buffer */
<br>+&nbsp;&nbsp; &nbsp;u32 bd_start;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
/* (struct sdma_bd*) current bd */<br>+&nbsp;&nbsp; &nbsp;u32 buffer_size;&=
nbsp;&nbsp; &nbsp;/* size of receive buffer */<br>+};<br>+<br>+/* ata task =
incs that need to be set before enabling the task */<br>+struct sdma_ata_in=
c {
<br>+&nbsp;&nbsp; &nbsp;u16 pad0;<br>+&nbsp;&nbsp; &nbsp;s16 incr_bytes;<br=
>+&nbsp;&nbsp; &nbsp;u16 pad1;<br>+&nbsp;&nbsp; &nbsp;s16 incr_dst;<br>+&nb=
sp;&nbsp; &nbsp;u16 pad2;<br>+&nbsp;&nbsp; &nbsp;s16 incr_src;<br>+};<br>+<=
br>+extern int sdma_ata_init(struct sdma *s, int maxbufsize);<br>+extern vo=
id sdma_ata_rx_init(struct sdma *s);
<br>+extern void sdma_ata_tx_init(struct sdma *s);<br>+extern void sdma_ata=
_reset(struct sdma *s);<br>+<br>+extern u32 sdma_ata_task[];<br>+<br>+#endi=
f&nbsp; /* __BESTCOMM_ATA_H__ */<br>diff --git a/arch/ppc/syslib/bestcomm/b=
estcomm.c b/arch/ppc/syslib/bestcomm/bestcomm.c
<br>index 76d5a9b..0f249d6 100644<br>--- a/arch/ppc/syslib/bestcomm/bestcom=
m.c<br>+++ b/arch/ppc/syslib/bestcomm/bestcomm.c<br>@@ -43,12 +43,12 @@ sta=
tic spinlock_t sdma_lock =3D SPIN_LOCK_<br>&nbsp;void sdma_dump(void)<br>&n=
bsp;{<br>
&nbsp;&nbsp;&nbsp; &nbsp;int i;<br>-&nbsp;&nbsp; &nbsp;printk(&quot;** SDMA=
 registers: pa =3D %08x, va =3D %08x\n&quot;, sdma.base_reg_addr, <a href=
=3D"http://sdma.io">sdma.io</a>);<br>+<br>+&nbsp;&nbsp; &nbsp;printk(&quot;=
** SDMA registers: pa =3D %08x, va =3D %08x\n&quot;, (u32)sdma.base_reg_add=
r, (u32)sdma.io);
<br>&nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;**&nbsp; taskBar =3D %08x\n&quot;=
, sdma.io-&gt;taskBar);<br>&nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;**&nbsp; c=
urrentPointer =3D %08x\n&quot;, sdma.io-&gt;currentPointer);<br>&nbsp;&nbsp=
;&nbsp; &nbsp;printk(&quot;**&nbsp; endPointer =3D %08x\n&quot;, sdma.io-&g=
t;endPointer);
<br>&nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;**&nbsp; variablePointer =3D %08x=
\n&quot;, sdma.io-&gt;variablePointer);<br>-<br>&nbsp;&nbsp;&nbsp; &nbsp;pr=
intk(&quot;**&nbsp; IntVect1 =3D %08x\n&quot;, sdma.io-&gt;IntVect1);<br>&n=
bsp;&nbsp;&nbsp; &nbsp;printk(&quot;**&nbsp; IntVect2 =3D %08x\n&quot;, sdm=
a.io-
&gt;IntVect2);<br>&nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;**&nbsp; PtdCntrl =
=3D %08x\n&quot;, sdma.io-&gt;PtdCntrl);<br>diff --git a/arch/ppc/syslib/be=
stcomm/bestcomm.h b/arch/ppc/syslib/bestcomm/bestcomm.h<br>index 18cb58f..7=
5ff7d2 100644<br>--- a/arch/ppc/syslib/bestcomm/bestcomm.h
<br>+++ b/arch/ppc/syslib/bestcomm/bestcomm.h<br>@@ -237,7 +237,7 @@ static=
 inline int sdma_desc_initiator(u3<br>&nbsp;static inline void sdma_set_des=
c_initiator(u32 *desc, int initiator)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbs=
p;*desc =3D (*desc &amp; ~(0x1f &lt;&lt; SDMA_DRD_INITIATOR_SHIFT)) |
<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;((initiator &=
lt;&lt; SDMA_DRD_INITIATOR_SHIFT) &amp; 0x1f);<br>+&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;((initiator &amp; 0x1f) &lt;&lt; SDMA_DRD_=
INITIATOR_SHIFT);<br>&nbsp;}<br>&nbsp;<br>&nbsp;static inline void sdma_sub=
mit_buffer(struct sdma *s, void *cookie, void *data,
<br>@@ -284,12 +284,23 @@ static inline void *sdma_retrieve_buffer<br>&nbsp=
;&nbsp;&nbsp; &nbsp;return cookie;<br>&nbsp;}<br>&nbsp;<br>+static inline v=
oid sdma_reset_buffers(struct sdma *s)<br>+{<br>+&nbsp;&nbsp; &nbsp;while (=
!sdma_queue_empty(s)) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd[=
s-&gt;outdex].status =3D 0;
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd[s-&gt;outdex].data =3D =
0;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;sdma_retrieve_buffer(s, NULL);=
<br>+&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp; &nbsp;s-&gt;index =3D s-&gt;outd=
ex =3D 0;<br>+}<br>+<br>&nbsp;static inline void sdma_submit_buffer2(struct=
 sdma *s, void *cookie,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;void *data1, void *data2, int length)<br>&nbs=
p;{<br>&nbsp;#ifdef CONFIG_BESTCOMM_DEBUG<br>&nbsp;&nbsp;&nbsp; &nbsp;BUG_O=
N(!(s-&gt;flags &amp; SDMA_FLAGS_BD2));<br>&nbsp;#endif<br>+<br>&nbsp;&nbsp=
;&nbsp; &nbsp;s-&gt;cookie[s-&gt;index] =3D cookie;<br>&nbsp;&nbsp;&nbsp; &=
nbsp;s-&gt;bd2[s-&gt;index].data1 =3D data1;
<br>&nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd2[s-&gt;index].data2 =3D data2;<br>@@ =
-312,6 +323,17 @@ static inline void *sdma_retrieve_buffer<br>&nbsp;&nbsp;&=
nbsp; &nbsp;return cookie;<br>&nbsp;}<br>&nbsp;<br>+static inline void sdma=
_reset_buffers2(struct sdma *s)<br>+{<br>+&nbsp;&nbsp; &nbsp;while (!sdma_q=
ueue_empty(s)) {
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd2[s-&gt;outdex].status =
=3D 0;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd2[s-&gt;outdex].da=
ta1 =3D 0;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;s-&gt;bd2[s-&gt;outdex=
].data2 =3D 0;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;sdma_retrieve_buff=
er2(s, NULL);<br>+&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp; &nbsp;s-&gt;index =
=3D s-&gt;outdex =3D 0;
<br>+}<br>+<br>&nbsp;#define SDMA_TASK_MAGIC&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;0x4243544B&nbsp;&nbsp; &nbsp;/* 'BCTK' */<br>&nbsp;<br>&nbsp;/* the =
size fields are given in number of 32-bit words */<br>@@ -351,7 +373,7 @@ s=
tatic inline int sdma_desc_is_drd(u32 d<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; (0 &lt;&lt; SDMA_PRAGMA_=
BIT_RST_ERROR_NO)&nbsp;&nbsp; &nbsp;| \
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp; (0 &lt;&lt; SDMA_PRAGMA_BIT_PACK)&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;| \<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp; (0 &lt;&lt; SDMA_PRAGMA_BIT_INTEGER)&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;| \<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp; (1 &lt;&lt; SDMA_PRAGMA_BIT_SPECREAD)&nbsp;=
&nbsp; &nbsp;| \<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp; (0 &lt;&lt; SDMA_PRAGMA_BIT_SPECREAD)&nbsp;&nbsp; &n=
bsp;| \
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp; (1 &lt;&lt; SDMA_PRAGMA_BIT_CW)&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;| \<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp; (1 &lt;&lt; SDMA_PRAGMA_BIT_RL))<br>&nbsp;<br>@@ -469,=
6 +491,7 @@ extern int sdma_load_task(u32 *task_imag<br>&nbsp;extern void *=
sdma_sram_alloc(int size, int alignment, u32 *dma_handle);
<br>&nbsp;extern void sdma_init_bd(struct sdma *s);<br>&nbsp;extern void sd=
ma_init_bd2(struct sdma *s);<br>+extern void sdma_set_initiator(int task, i=
nt initiator);<br>&nbsp;<br>&nbsp;#define FIELD_OFFSET(s,f) ((unsigned long=
)(&amp;(((struct s*)0)-&gt;f)))
<br>&nbsp;<br>diff --git a/arch/ppc/syslib/bestcomm/sdma_ata_task.c b/arch/=
ppc/syslib/bestcomm/sdma_ata_task.c<br>new file mode 100644<br>index 000000=
0..5613545<br>--- /dev/null<br>+++ b/arch/ppc/syslib/bestcomm/sdma_ata_task=
.c
<br>@@ -0,0 +1,61 @@<br>+/*<br>+ * sdma_ata_task.c<br>+ *<br>+ * Created ba=
sed on bestcom/code_dma/image_rtos1/dma_image.hex<br>+ */<br>+<br>+#include=
 &lt;linux/types.h&gt;<br>+<br>+/*<br>+ * The header consists of the follow=
ing fields:
<br>+ *&nbsp;&nbsp; &nbsp;uint32_t&nbsp;&nbsp; &nbsp;magic;<br>+ *&nbsp;&nb=
sp; &nbsp;uint8_t&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;desc_size;<br>+ *&nb=
sp;&nbsp; &nbsp;uint8_t&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;var_size;<br>+=
 *&nbsp;&nbsp; &nbsp;uint8_t&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;inc_size;=
<br>+ *&nbsp;&nbsp; &nbsp;uint8_t&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;firs=
t_var;<br>+ *&nbsp;&nbsp; &nbsp;uint8_t&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;reserved[8];<br>+ *<br>+ * The size fields contain the number of 32-bit w=
ords.
<br>+*/<br>+<br>+uint32_t sdma_ata_task[] =3D {<br>+&nbsp;&nbsp; &nbsp;/* h=
eader */<br>+&nbsp;&nbsp; &nbsp;0x4243544b,<br>+&nbsp;&nbsp; &nbsp;0x0e0607=
09,<br>+&nbsp;&nbsp; &nbsp;0x00000000,<br>+&nbsp;&nbsp; &nbsp;0x00000000,<b=
r>+<br>+&nbsp;&nbsp; &nbsp;/* Task descriptors */<br>+&nbsp;&nbsp; &nbsp;0x=
8198009b, /* LCD: idx0 =3D var3; idx0 &lt;=3D var2; idx0 +=3D inc3 */
<br>+&nbsp;&nbsp; &nbsp;0x13e00c08, /*&nbsp;&nbsp; DRD1A: var3 =3D var1; FN=
=3D0 MORE init=3D31 WS=3D0 RS=3D0 */<br>+&nbsp;&nbsp; &nbsp;0xb8000264, /*&=
nbsp;&nbsp; LCD: idx1 =3D *idx0, idx2 =3D var0; idx1 &lt; var9; idx1 +=3D i=
nc4, idx2 +=3D inc4 */<br>+&nbsp;&nbsp; &nbsp;0x10000f00, /*&nbsp;&nbsp;&nb=
sp;&nbsp; DRD1A: var3 =3D idx0; FN=3D0 MORE init=3D0 WS=3D0 RS=3D0 */
<br>+&nbsp;&nbsp; &nbsp;0x60140002, /*&nbsp;&nbsp;&nbsp;&nbsp; DRD2A: EU0=
=3D0 EU1=3D0 EU2=3D0 EU3=3D2 EXT init=3D0 WS=3D2 RS=3D2 */<br>+&nbsp;&nbsp;=
 &nbsp;0x0c8cfc8a, /*&nbsp;&nbsp;&nbsp;&nbsp; DRD2B1: *idx2 =3D EU3(); EU3(=
*idx2,var10)&nbsp; */<br>+&nbsp;&nbsp; &nbsp;0xd8988240, /*&nbsp;&nbsp; LCD=
EXT: idx1 =3D idx1; idx1 &gt; var9; idx1 +=3D inc0 */
<br>+&nbsp;&nbsp; &nbsp;0xf845e011, /*&nbsp;&nbsp; LCDEXT: idx2 =3D *(idx0 =
+ var00000015); ; idx2 +=3D inc2 */<br>+&nbsp;&nbsp; &nbsp;0xb845e00a, /*&n=
bsp;&nbsp; LCD: idx3 =3D *(idx0 + var00000019); ; idx3 +=3D inc1 */<br>+&nb=
sp;&nbsp; &nbsp;0x0bfecf90, /*&nbsp;&nbsp;&nbsp;&nbsp; DRD1A: *idx3 =3D *id=
x2; FN=3D0 TFD init=3D31 WS=3D3 RS=3D3 */
<br>+&nbsp;&nbsp; &nbsp;0x9898802d, /*&nbsp;&nbsp; LCD: idx1 =3D idx1; idx1=
 once var0; idx1 +=3D inc5 */<br>+&nbsp;&nbsp; &nbsp;0x64000005, /*&nbsp;&n=
bsp;&nbsp;&nbsp; DRD2A: EU0=3D0 EU1=3D0 EU2=3D0 EU3=3D5 INT EXT init=3D0 WS=
=3D0 RS=3D0 */<br>+&nbsp;&nbsp; &nbsp;0x0c0cf849, /*&nbsp;&nbsp;&nbsp;&nbsp=
; DRD2B1: *idx0 =3D EU3(); EU3(idx1,var9)&nbsp; */
<br>+&nbsp;&nbsp; &nbsp;0x000001f8, /* NOP */<br>+<br>+<br>+&nbsp;&nbsp; &n=
bsp;/* VAR[9]-VAR[14] */<br>+&nbsp;&nbsp; &nbsp;0x40000000,<br>+&nbsp;&nbsp=
; &nbsp;0x7fff7fff,<br>+&nbsp;&nbsp; &nbsp;0x00000000,<br>+&nbsp;&nbsp; &nb=
sp;0x00000000,<br>+&nbsp;&nbsp; &nbsp;0x00000000,<br>+&nbsp;&nbsp; &nbsp;0x=
00000000,<br>+<br>+&nbsp;&nbsp; &nbsp;/* INC[0]-INC[6] */
<br>+&nbsp;&nbsp; &nbsp;0x40000000,<br>+&nbsp;&nbsp; &nbsp;0xe0000000,<br>+=
&nbsp;&nbsp; &nbsp;0xe0000000,<br>+&nbsp;&nbsp; &nbsp;0xa000000c,<br>+&nbsp=
;&nbsp; &nbsp;0x20000000,<br>+&nbsp;&nbsp; &nbsp;0x00000000,<br>+&nbsp;&nbs=
p; &nbsp;0x00000000,<br>+};<br>diff --git a/arch/ppc/syslib/mpc52xx_setup.c=
 b/arch/ppc/syslib/mpc52xx_setup.c
<br>index 508b241..3c9cd42 100644<br>--- a/arch/ppc/syslib/mpc52xx_setup.c<=
br>+++ b/arch/ppc/syslib/mpc52xx_setup.c<br>@@ -220,7 +220,6 @@ mpc52xx_cal=
ibrate_decr(void)<br>&nbsp;&nbsp;&nbsp; &nbsp;tb_to_us =3D mulhwu_scale_fac=
tor(xlbfreq / divisor, 1000000);
<br>&nbsp;}<br>&nbsp;<br>-<br>&nbsp;void __init<br>&nbsp;mpc52xx_setup_cpu(=
void)<br>&nbsp;{<br>@@ -247,8 +246,9 @@ mpc52xx_setup_cpu(void)<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;out_be16(&amp;cdm-&gt;fd_counters, 0x55=
55);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Configure the XLB Arbiter pri=
orities */
<br>-&nbsp;&nbsp; &nbsp;out_be32(&amp;xlb-&gt;master_pri_enable, 0xff);<br>=
-&nbsp;&nbsp; &nbsp;out_be32(&amp;xlb-&gt;master_priority, 0x11111111);<br>=
+&nbsp;&nbsp; &nbsp;/* Give PPC and BestComm the same priority on the XLB *=
/<br>+&nbsp;&nbsp; &nbsp;out_be32(&amp;xlb-&gt;master_pri_enable, 0xf);
<br>+&nbsp;&nbsp; &nbsp;out_be32(&amp;xlb-&gt;master_priority, 0x00007131);=
<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Enable ram snooping for 1GB windo=
w */<br>&nbsp;&nbsp;&nbsp; &nbsp;out_be32(&amp;xlb-&gt;config, in_be32(&amp=
;xlb-&gt;config) | MPC52xx_XLB_CFG_SNOOP);<br>@@ -265,7 +265,6 @@ unmap_reg=
s:
<br>&nbsp;&nbsp;&nbsp; &nbsp;if (xlb)&nbsp; iounmap(xlb);<br>&nbsp;}<br>&nb=
sp;<br>-<br>&nbsp;int mpc52xx_match_psc_function(int psc_idx, const char *f=
unc)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;struct mpc52xx_psc_func *cf =3D=
 mpc52xx_psc_functions;<br>diff --git a/drivers/ide/Kconfig b/drivers/ide/K=
config
<br>index e391cee..6ecaee7 100644<br>--- a/drivers/ide/Kconfig<br>+++ b/dri=
vers/ide/Kconfig<br>@@ -973,6 +973,17 @@ config BLK_DEV_MPC52xx_IDE<br>&nbs=
p;&nbsp;&nbsp; &nbsp;tristate &quot;MPC52xx Builtin IDE support&quot;<br>&n=
bsp;&nbsp;&nbsp; &nbsp;depends on PPC_MPC52xx &amp;&amp; IDE=3Dy
<br>&nbsp;<br>+config BLK_DEV_MPC52xx_IDE_MDMA<br>+&nbsp;&nbsp; &nbsp;bool =
&quot;MDMA support&quot;<br>+&nbsp;&nbsp; &nbsp;depends on BLK_DEV_MPC52xx_=
IDE<br>+<br>+config BLK_DEV_MPC52xx_IDE_UDMA<br>+&nbsp;&nbsp; &nbsp;bool &q=
uot;UDMA support&quot;<br>+&nbsp;&nbsp; &nbsp;depends on BLK_DEV_MPC52xx_ID=
E
<br>+<br>+config BLK_DEV_MPC52xx_IDE_DMA<br>+&nbsp;&nbsp; &nbsp;def_bool BL=
K_DEV_MPC52xx_IDE_UDMA || BLK_DEV_MPC52xx_IDE_MDMA<br>+<br>&nbsp;# no isa -=
&gt; no vlb<br>&nbsp;config IDE_CHIPSETS<br>&nbsp;&nbsp;&nbsp; &nbsp;bool &=
quot;Other IDE chipset support&quot;<br>diff --git a/drivers/ide/ppc/mpc52x=
x_ide.c b/drivers/ide/ppc/mpc52xx_ide.c
<br>index 5970f7b..7ab1bcc 100644<br>--- a/drivers/ide/ppc/mpc52xx_ide.c<br=
>+++ b/drivers/ide/ppc/mpc52xx_ide.c<br>@@ -5,6 +5,7 @@<br>&nbsp; *<br>&nbs=
p; *<br>&nbsp; * Copyright (C) 2006 Sylvain Munaut &lt;<a href=3D"mailto:tn=
t@246tNt.com">
tnt@246tNt.com</a>&gt;<br>+ * Copyright (C) 2005,2006 Freescale - Bernard K=
uhn, John Rigby<br>&nbsp; * Copyright (C) 2003 Mipsys - Benjamin Herrenschm=
idt<br>&nbsp; *<br>&nbsp; * This file is licensed under the terms of the GN=
U General Public License
<br>@@ -24,8 +25,28 @@<br>&nbsp;#include &lt;asm/io.h&gt;<br>&nbsp;#include=
 &lt;asm/ppcboot.h&gt;<br>&nbsp;<br>+#include &lt;syslib/bestcomm/bestcomm.=
h&gt;<br>+#include &lt;syslib/bestcomm/ata.h&gt;<br>+<br>&nbsp;#include &qu=
ot;mpc52xx_ide.h&quot;
<br>&nbsp;<br>+#define CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1<br>+#defin=
e CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS 1<br>+<br>+#define MAX_DMA_BUFFERS=
 128<br>+#define MAX_DMA_BUFFER_SIZE 0x20000<br>+<br>+#undef DEBUG<br>+#def=
ine DEBUG
<br>+<br>+#undef DPRINTK<br>+#ifdef DEBUG<br>+#define DPRINTK(fmt, args...)=
 printk(fmt, ## args)<br>+#else<br>+#define DPRINTK(fmt, args...)<br>+#endi=
f<br>+<br>+typedef unsigned long ide_ioreg_t;<br>&nbsp;<br>&nbsp;<br>&nbsp;=
/* Private structures used by the driver */
<br>@@ -42,11 +63,6 @@ struct mpc52xx_ata_timings {<br>&nbsp;&nbsp;&nbsp; &=
nbsp;int using_udma;<br>&nbsp;};<br>&nbsp;<br>-struct mpc52xx_ide_priv {<br=
>-&nbsp;&nbsp; &nbsp;unsigned int ipb_period;&nbsp;&nbsp; &nbsp;/* in ps */=
<br>-&nbsp;&nbsp; &nbsp;struct mpc52xx_ata __iomem *ata_regs;<br>-&nbsp;&nb=
sp; &nbsp;struct mpc52xx_ata_timings&nbsp; timings[2];
<br>-};<br>&nbsp;<br>&nbsp;/* ATAPI-4 PIO specs (arranged for the 5200, cfr=
 User Manual) */<br>&nbsp;/* numbers in ns, extrapolation done by code */<b=
r>@@ -58,9 +74,166 @@ static int ataspec_t2i[5]&nbsp;&nbsp; =3D {&nbsp; 0,&=
nbsp;&nbsp; 0,<br>&nbsp;static int ataspec_t4[5]&nbsp;&nbsp;&nbsp; =3D { 30=
,&nbsp; 20,&nbsp; 15,&nbsp; 10,&nbsp; 10};
<br>&nbsp;static int ataspec_ta[5]&nbsp;&nbsp;&nbsp; =3D { 35,&nbsp; 35,&nb=
sp; 35,&nbsp; 35,&nbsp; 35};<br>&nbsp;<br>-/* Helpers to compute timing par=
ameters */<br>+/* Helper to compute timing parameters */<br>&nbsp;#define C=
ALC_CLK_VALUE_UP(c,v) (((v) + c - 1) / c)<br>&nbsp;<br>
+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>+<br>+#ifdef CONFIG_BLK_DEV_MPC52=
xx_IDE_MDMA<br>+<br>+/* ATAPI-4 MDMA specs (in clocks) */<br>+struct mdmasp=
ec {<br>+&nbsp;&nbsp; &nbsp;u32 t0M[3];<br>+&nbsp;&nbsp; &nbsp;u32 td[3];<b=
r>+&nbsp;&nbsp; &nbsp;u32 th[3];<br>+&nbsp;&nbsp; &nbsp;u32 tj[3];
<br>+&nbsp;&nbsp; &nbsp;u32 tkw[3];<br>+&nbsp;&nbsp; &nbsp;u32 tm[3];<br>+&=
nbsp;&nbsp; &nbsp;u32 tn[3];<br>+};<br>+<br>+static struct mdmaspec mdmaspe=
c66 =3D {<br>+&nbsp;&nbsp; &nbsp;{32,&nbsp; 10,&nbsp; 8},<br>+&nbsp;&nbsp; =
&nbsp;{15,&nbsp; 6,&nbsp;&nbsp; 5},<br>+&nbsp;&nbsp; &nbsp;{2,&nbsp;&nbsp; =
1,&nbsp;&nbsp; 1},<br>+&nbsp;&nbsp; &nbsp;{2,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1}=
,<br>+&nbsp;&nbsp; &nbsp;{15,&nbsp; 4,&nbsp;&nbsp; 2},
<br>+&nbsp;&nbsp; &nbsp;{4,&nbsp;&nbsp; 2,&nbsp;&nbsp; 2},<br>+&nbsp;&nbsp;=
 &nbsp;{1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1}<br>+};<br>+<br>+static struct mdma=
spec mdmaspec132 =3D {<br>+&nbsp;&nbsp; &nbsp;{64,&nbsp; 20,&nbsp; 16},<br>=
+&nbsp;&nbsp; &nbsp;{29,&nbsp; 11,&nbsp; 10},<br>+&nbsp;&nbsp; &nbsp;{3,&nb=
sp;&nbsp; 2,&nbsp;&nbsp; 2},<br>+&nbsp;&nbsp; &nbsp;{3,&nbsp;&nbsp; 1,&nbsp=
;&nbsp; 1},<br>+&nbsp;&nbsp; &nbsp;{29,&nbsp; 7,&nbsp;&nbsp; 4},<br>
+&nbsp;&nbsp; &nbsp;{7,&nbsp;&nbsp; 4,&nbsp;&nbsp; 4},<br>+&nbsp;&nbsp; &nb=
sp;{2,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1}<br>+};<br>+<br>+#endif<br>+<br>+#ifdef=
 CONFIG_BLK_DEV_MPC52xx_IDE_UDMA<br>+<br>+/* ATAPI-4 UDMA specs (in clocks)=
 */<br>+struct udmaspec {<br>+&nbsp;&nbsp; &nbsp;u32 tcyc[6];<br>+&nbsp;&nb=
sp; &nbsp;u32 t2cyc[6];
<br>+&nbsp;&nbsp; &nbsp;u32 tds[6];<br>+&nbsp;&nbsp; &nbsp;u32 tdh[6];<br>+=
&nbsp;&nbsp; &nbsp;u32 tdvs[6];<br>+&nbsp;&nbsp; &nbsp;u32 tdvh[6];<br>+&nb=
sp;&nbsp; &nbsp;u32 tfs_min[6];<br>+&nbsp;&nbsp; &nbsp;u32 tli_max[6];<br>+=
&nbsp;&nbsp; &nbsp;u32 tmli[6];<br>+&nbsp;&nbsp; &nbsp;u32 taz[6];<br>+&nbs=
p;&nbsp; &nbsp;u32 tzah[6];<br>+&nbsp;&nbsp; &nbsp;u32 tenv_min[6];<br>
+&nbsp;&nbsp; &nbsp;u32 tsr[6];<br>+&nbsp;&nbsp; &nbsp;u32 trfs[6];<br>+&nb=
sp;&nbsp; &nbsp;u32 trp[6];<br>+&nbsp;&nbsp; &nbsp;u32 tack[6];<br>+&nbsp;&=
nbsp; &nbsp;u32 tss[6];<br>+};<br>+<br>+struct udmaspec udmaspec66 =3D {<br=
>+&nbsp;&nbsp; &nbsp;{8, 5,&nbsp; 4,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp; 2}=
,<br>+&nbsp;&nbsp; &nbsp;{16, 11,&nbsp; 8,&nbsp;&nbsp; 6,&nbsp;&nbsp; 4 , 2=
},<br>+&nbsp;&nbsp; &nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1,&nbs=
p; 1},
<br>+&nbsp;&nbsp; &nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;=
 1},<br>+&nbsp;&nbsp; &nbsp;{5, 4,&nbsp; 3,&nbsp;&nbsp; 2,&nbsp;&nbsp; 1,&n=
bsp; 1},<br>+&nbsp;&nbsp; &nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; =
1,&nbsp; 1},<br>+&nbsp;&nbsp; &nbsp;{16, 14,&nbsp; 12,&nbsp; 9,&nbsp;&nbsp;=
 8,&nbsp; 6},<br>+&nbsp;&nbsp; &nbsp;{10, 10,&nbsp; 10,&nbsp; 7,&nbsp;&nbsp=
; 8,&nbsp; 5},<br>+&nbsp;&nbsp; &nbsp;{2, 2,&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;&=
nbsp; 2,&nbsp; 2},<br>+&nbsp;&nbsp; &nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nb=
sp;&nbsp; 1,&nbsp; 1},
<br>+&nbsp;&nbsp; &nbsp;{2, 2,&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;=
 2},<br>+&nbsp;&nbsp; &nbsp;{2, 2,&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;&nbsp; 2,&n=
bsp; 2},<br>+&nbsp;&nbsp; &nbsp;{3, 2,&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;&nbsp; =
2,&nbsp; 2},<br>+&nbsp;&nbsp; &nbsp;{5, 5,&nbsp; 4,&nbsp;&nbsp; 4,&nbsp;&nb=
sp; 4,&nbsp; 4},<br>+&nbsp;&nbsp; &nbsp;{11, 9,&nbsp; 7,&nbsp;&nbsp; 7,&nbs=
p;&nbsp; 7,&nbsp; 6},<br>+&nbsp;&nbsp; &nbsp;{2, 2,&nbsp; 2,&nbsp;&nbsp; 2,=
&nbsp;&nbsp; 2,&nbsp; 2},<br>+&nbsp;&nbsp; &nbsp;{4, 4,&nbsp; 4,&nbsp;&nbsp=
; 4,&nbsp;&nbsp; 4,&nbsp; 4}
<br>+};<br>+<br>+struct udmaspec udmaspec132 =3D {<br>+&nbsp;&nbsp; &nbsp;{=
15, 10,&nbsp; 6,&nbsp;&nbsp; 7,&nbsp;&nbsp; 2,&nbsp; 3},<br>+&nbsp;&nbsp; &=
nbsp;{31, 21,&nbsp; 12,&nbsp; 12,&nbsp; 5,&nbsp; 6},<br>+&nbsp;&nbsp; &nbsp=
;{2, 2,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 0,&nbsp; 1},<br>+&nbsp;&nbsp; &=
nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 0,&nbsp; 1},<br>+&nbsp;&nbs=
p; &nbsp;{10, 7,&nbsp; 5,&nbsp;&nbsp; 3,&nbsp;&nbsp; 1,&nbsp; 1},
<br>+&nbsp;&nbsp; &nbsp;{1, 1,&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;=
 1},<br>+&nbsp;&nbsp; &nbsp;{30, 27,&nbsp; 23,&nbsp; 15,&nbsp; 16, 12},<br>=
+&nbsp;&nbsp; &nbsp;{20, 20,&nbsp; 20,&nbsp; 13,&nbsp; 14, 10},<br>+&nbsp;&=
nbsp; &nbsp;{3, 3,&nbsp; 3,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp; 3},<br>+&nb=
sp;&nbsp; &nbsp;{2, 2,&nbsp; 2,&nbsp;&nbsp; 2,&nbsp;&nbsp; 1,&nbsp; 2},<br>=
+&nbsp;&nbsp; &nbsp;{3, 3,&nbsp; 3,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp; 3},=
<br>+&nbsp;&nbsp; &nbsp;{3, 3,&nbsp; 3,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp;=
 3},
<br>+&nbsp;&nbsp; &nbsp;{7, 4,&nbsp; 3,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp;=
 3},<br>+&nbsp;&nbsp; &nbsp;{10, 10,&nbsp; 8,&nbsp;&nbsp; 8,&nbsp;&nbsp; 7,=
&nbsp; 7},<br>+&nbsp;&nbsp; &nbsp;{22, 17,&nbsp; 14,&nbsp; 14, 13, 12},<br>=
+&nbsp;&nbsp; &nbsp;{3, 3,&nbsp; 3,&nbsp;&nbsp; 3,&nbsp;&nbsp; 2,&nbsp; 3},=
<br>+&nbsp;&nbsp; &nbsp;{7, 7,&nbsp; 7,&nbsp;&nbsp; 7,&nbsp;&nbsp; 6,&nbsp;=
 7},<br>+};<br>+<br>+<br>+#endif<br>+<br>+#endif /* CONFIG_BLK_DEV_MPC52xx_=
IDE_DMA */
<br>+<br>+struct mpc52xx_ide_priv {<br>+&nbsp;&nbsp; &nbsp;unsigned int ipb=
_period;&nbsp;&nbsp; &nbsp;/* in ps */<br>+&nbsp;&nbsp; &nbsp;struct mpc52x=
x_ata __iomem *ata_regs;<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ata_timings&=
nbsp; timings[2];<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>
+&nbsp;&nbsp; &nbsp;struct sdma *sdma;<br>+&nbsp;&nbsp; &nbsp;struct udmasp=
ec *udmaspec;<br>+&nbsp;&nbsp; &nbsp;struct mdmaspec *mdmaspec;<br>+&nbsp;&=
nbsp; &nbsp;int mpc52xx_ata_dma_last_write;<br>+#endif<br>+};<br>+<br>+stat=
ic u8<br>+mpc52xx_dma2pio (u8 xfer_rate)<br>+{<br>+&nbsp;&nbsp; &nbsp;switc=
h(xfer_rate) {
<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;case XFER_UDMA_6:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case =
XFER_UDMA_5:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_4:<br=
>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_3:<br>+&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_2:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;case XFER_UDMA_1:
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_0:<br>+&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_MW_DMA_2:<br>+&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;case XFER_PIO_4:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;//return 3;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;return 4;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XF=
ER_MW_DMA_1:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_3:<br>=
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 3;
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_SW_DMA_2:<br>+&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_2:<br>+&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 2;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;case XFER_MW_DMA_0:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;cas=
e XFER_SW_DMA_1:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_SW_DMA=
_0:<br>+#else<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_4:
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 4;<br>=
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_3:<br>+&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 3;<br>+&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;case XFER_PIO_2:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;return 2;<br>+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DM=
A */<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_1:<br>+&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_0:
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_SLOW:<br>+&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;default:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;return 0;<br>+&nbsp;&nbsp; &nbsp;}<br>+}<br>&nbsp;=
<br>&nbsp;/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */<br>&nbsp;/* IDE Driver &amp; Aux functions&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; */
<br>@@ -100,6 +273,99 @@ mpc52xx_ide_compute_pio_timing(<br>&nbsp;&nbsp;&nb=
sp; &nbsp;timing-&gt;pio2 =3D (t4 &lt;&lt; 24) | (t1 &lt;&lt; 16) | (ta &lt=
;&lt; 8);<br>&nbsp;}<br>&nbsp;<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br=
>+<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA
<br>+<br>+static void mpc52xx_ide_calc_udma_timings(ide_drive_t *drive, u8 =
speed)<br>+{<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *priv =3D drive=
-&gt;hwif-&gt;hwif_data;<br>+<br>+&nbsp;&nbsp; &nbsp;int which =3D drive-&g=
t;select.b.unit &amp; 0x01;<br>
+&nbsp;&nbsp; &nbsp;u32 t2cyc, tcyc, tds, tdh, tdvs, tdvh, tfs, tli, tmli, =
taz, tenv, tsr, tss, trfs, trp, tack, tzah;<br>+<br>+&nbsp;&nbsp; &nbsp;t2c=
yc =3D priv-&gt;udmaspec-&gt;t2cyc[speed];<br>+&nbsp;&nbsp; &nbsp;tcyc =3D =
priv-&gt;udmaspec-&gt;tcyc[speed];<br>+&nbsp;&nbsp; &nbsp;tds =3D priv-&gt;=
udmaspec-&gt;tds[speed];
<br>+&nbsp;&nbsp; &nbsp;tdh =3D priv-&gt;udmaspec-&gt;tdh[speed];<br>+&nbsp=
;&nbsp; &nbsp;tdvs =3D priv-&gt;udmaspec-&gt;tdvs[speed];<br>+&nbsp;&nbsp; =
&nbsp;tdvh =3D priv-&gt;udmaspec-&gt;tdvh[speed];<br>+&nbsp;&nbsp; &nbsp;tf=
s =3D priv-&gt;udmaspec-&gt;tfs_min[speed];<br>+&nbsp;&nbsp; &nbsp;tmli =3D=
 priv-&gt;udmaspec-&gt;tmli[speed];
<br>+&nbsp;&nbsp; &nbsp;tenv =3D priv-&gt;udmaspec-&gt;tenv_min[speed];<br>=
+&nbsp;&nbsp; &nbsp;tss =3D priv-&gt;udmaspec-&gt;tss[speed];<br>+&nbsp;&nb=
sp; &nbsp;trp =3D priv-&gt;udmaspec-&gt;trp[speed];<br>+&nbsp;&nbsp; &nbsp;=
tack =3D priv-&gt;udmaspec-&gt;tack[speed];<br>+&nbsp;&nbsp; &nbsp;tzah =3D=
 priv-&gt;udmaspec-&gt;tzah[speed];
<br>+&nbsp;&nbsp; &nbsp;taz =3D priv-&gt;udmaspec-&gt;taz[speed];<br>+&nbsp=
;&nbsp; &nbsp;trfs =3D priv-&gt;udmaspec-&gt;trfs[speed];<br>+&nbsp;&nbsp; =
&nbsp;tsr =3D priv-&gt;udmaspec-&gt;tsr[speed];<br>+&nbsp;&nbsp; &nbsp;tli =
=3D priv-&gt;udmaspec-&gt;tli_max[speed];<br>+<br>+&nbsp;&nbsp; &nbsp;DPRIN=
TK (&quot;UDMA t2cyc =3D %d\n&quot;, t2cyc);
<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tcyc&nbsp; =3D %d\n&quot;, tcyc=
);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tds&nbsp;&nbsp; =3D %d\n&quot=
;, tds);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tdh&nbsp;&nbsp; =3D %d\=
n&quot;, tdh);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tdvs&nbsp; =3D %d=
\n&quot;, tdvs);<br>
+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tdvh&nbsp; =3D %d\n&quot;, tdvh);<b=
r>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tfs&nbsp;&nbsp; =3D %d\n&quot;, t=
fs);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tli&nbsp;&nbsp; =3D %d\n&qu=
ot;, tli);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tmli&nbsp; =3D %d\n&q=
uot;, tmli);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA taz&nbsp;&nbsp; =3D=
 %d\n&quot;, taz);
<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tenv&nbsp; =3D %d\n&quot;, tenv=
);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tsr&nbsp;&nbsp; =3D %d\n&quot=
;, tsr);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tss&nbsp;&nbsp; =3D %d\=
n&quot;, tss);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA trfs&nbsp; =3D %d=
\n&quot;, trfs);<br>
+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA trp&nbsp;&nbsp; =3D %d\n&quot;, trp=
);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tack&nbsp; =3D %d\n&quot;, ta=
ck);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;UDMA tzah&nbsp; =3D %d\n&quot;, =
tzah);<br>+<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].udma1 =3D (t2cyc=
 &lt;&lt; 24) | (tcyc &lt;&lt; 16) | (tds &lt;&lt; 8) | (tdh);
<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].udma2 =3D (tdvs &lt;&lt; 24=
) | (tdvh &lt;&lt; 16) | (tfs &lt;&lt; 8) | (tli);<br>+&nbsp;&nbsp; &nbsp;p=
riv-&gt;timings[which].udma3 =3D (tmli &lt;&lt; 24) | (taz &lt;&lt; 16) | (=
tenv &lt;&lt; 8) | (tsr);<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].ud=
ma4 =3D (tss &lt;&lt; 24) | (trfs &lt;&lt; 16) | (trp &lt;&lt; 8) | (tack);
<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].udma5 =3D (tzah &lt;&lt; 24=
);<br>+<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].using_udma =3D 1;<br=
>+}<br>+<br>+#endif<br>+<br>+<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA<br=
>+<br>+static void mpc52xx_ide_calc_mdma_timings(ide_drive_t *drive, u8 spe=
ed)
<br>+{<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *priv =3D drive-&gt;h=
wif-&gt;hwif_data;<br>+&nbsp;&nbsp; &nbsp;int which =3D drive-&gt;select.b.=
unit &amp; 0x01;<br>+&nbsp;&nbsp; &nbsp;u32 t0M, td, tkw, tm, th, tj, tn;<b=
r>+<br>+&nbsp;&nbsp; &nbsp;t0M =3D priv-&gt;mdmaspec-&gt;t0M[speed];
<br>+&nbsp;&nbsp; &nbsp;td =3D priv-&gt;mdmaspec-&gt;td[speed];<br>+&nbsp;&=
nbsp; &nbsp;tkw =3D priv-&gt;mdmaspec-&gt;tkw[speed];<br>+&nbsp;&nbsp; &nbs=
p;tm =3D priv-&gt;mdmaspec-&gt;tm[speed];<br>+&nbsp;&nbsp; &nbsp;th =3D pri=
v-&gt;mdmaspec-&gt;th[speed];<br>+&nbsp;&nbsp; &nbsp;tj =3D priv-&gt;mdmasp=
ec-&gt;tj[speed];
<br>+&nbsp;&nbsp; &nbsp;tn =3D priv-&gt;mdmaspec-&gt;tn[speed];<br>+<br>+&n=
bsp;&nbsp; &nbsp;DPRINTK (&quot;t0M =3D %d\n&quot;, t0M);<br>+&nbsp;&nbsp; =
&nbsp;DPRINTK (&quot;td&nbsp; =3D %d\n&quot;, td);<br>+&nbsp;&nbsp; &nbsp;D=
PRINTK (&quot;tkw =3D %d\n&quot;, tkw);<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&qu=
ot;tm&nbsp; =3D %d\n&quot;, tm);
<br>+&nbsp;&nbsp; &nbsp;DPRINTK (&quot;th&nbsp; =3D %d\n&quot;, th);<br>+&n=
bsp;&nbsp; &nbsp;DPRINTK (&quot;tj&nbsp; =3D %d\n&quot;, tj);<br>+&nbsp;&nb=
sp; &nbsp;DPRINTK (&quot;tn&nbsp; =3D %d\n&quot;, tn);<br>+<br>+&nbsp;&nbsp=
; &nbsp;priv-&gt;timings[which].mdma1 =3D (t0M &lt;&lt; 24) | (td &lt;&lt; =
16) | (tkw &lt;&lt; 8) | (tm);
<br>+&nbsp;&nbsp; &nbsp;priv-&gt;timings[which].mdma2 =3D (th &lt;&lt; 24) =
| (tj &lt;&lt; 16) | (tn &lt;&lt; 8);<br>+<br>+&nbsp;&nbsp; &nbsp;priv-&gt;=
timings[which].using_udma =3D 0;<br>+}<br>+<br>+#endif<br>+<br>+#endif /* C=
ONFIG_BLK_DEV_MPC52xx_IDE_DMA */
<br>+<br>&nbsp;<br>&nbsp;static void<br>&nbsp;mpc52xx_ide_tuneproc(ide_driv=
e_t *drive, u8 pio)<br>@@ -117,25 +383,51 @@ mpc52xx_ide_tuneproc(ide_drive=
_t *drive,<br>&nbsp;&nbsp;&nbsp; &nbsp;if (drive-&gt;select.all =3D=3D HWIF=
(drive)-&gt;INB(IDE_SELECT_REG))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mpc52xx_ide_apply_timing(regs, =
&amp;priv-&gt;timings[w]);<br>&nbsp;<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;/* Should we do it here or only in speedproc ? */<br>-&nbsp;&nbsp; &nbs=
p;ide_config_drive_speed(drive, pio + XFER_PIO_0);<br>+&nbsp;&nbsp; &nbsp;/=
* Only call ide_config_drive_speed in speedproc */
<br>&nbsp;}<br>&nbsp;<br>&nbsp;static int<br>&nbsp;mpc52xx_ide_speedproc(id=
e_drive_t *drive, u8 speed)<br>&nbsp;{<br>-&nbsp;&nbsp; &nbsp;/* Configure =
PIO Mode */<br>-&nbsp;&nbsp; &nbsp;if (speed &gt;=3D XFER_PIO_0 &amp;&amp; =
speed &lt;=3D XFER_PIO_4) {<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mpc52=
xx_ide_tuneproc(drive, speed - XFER_PIO_0);
<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 0;<br>-&nbsp;&nbsp; &nbsp=
;}<br>-<br>-&nbsp;&nbsp; &nbsp;/* DMA settings currently unsupported */<br>=
-&nbsp;&nbsp; &nbsp;printk(KERN_ERR<br>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&quot;mpc52xx-ide: speedproc called with unsupported mode %d\n&quot;,<br=
>-&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;speed);<br>+#ifdef CONFIG_BLK_DEV_I=
DE_MPC52xx_LIMIT_TO_UDMA1
<br>+&nbsp;&nbsp; &nbsp;if (speed &gt; XFER_UDMA_1)<br>+&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;speed =3D XFER_UDMA_1;<br>+#else<br>+&nbsp;&nbsp; &nbsp;=
if (speed &gt; XFER_UDMA_4)<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;speed=
 =3D XFER_UDMA_4;<br>+#endif<br>&nbsp;<br>-&nbsp;&nbsp; &nbsp;return 1;<br>=
+&nbsp;&nbsp; &nbsp;switch(speed) {<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_D=
MA
<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_UDMA<br>+&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;case XFER_UDMA_4:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case=
 XFER_UDMA_3:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_2:<b=
r>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_1:<br>+&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;case XFER_UDMA_0:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;%s: Setting UDMA %d timings\n&qu=
ot;, drive-&gt;name, speed - XFER_UDMA_0);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mpc52xx_ide_c=
alc_udma_timings(drive, speed - XFER_UDMA_0);<br>+&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;break;<br>+#endif<br>+#ifdef CONFIG_BLK_DEV=
_MPC52xx_IDE_MDMA<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_MW_DM=
A_2:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_MW_DMA_1:<br>+&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_MW_DMA_0:
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;=
%s: Setting MDMA %d timings\n&quot;, drive-&gt;name, speed - XFER_MW_DMA_0)=
;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mpc52xx_ide_=
calc_mdma_timings(drive, speed - XFER_MW_DMA_0);<br>+&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;break;<br>+#endif<br>
+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */<br>+&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;case XFER_PIO_4:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case=
 XFER_PIO_3:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_2:<br>=
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;case XFER_PIO_0:<br>+&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;break;<br>+&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;default:<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;return -EINVAL;
<br>+&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp; &nbsp;mpc52xx_ide_tuneproc(drive=
, mpc52xx_dma2pio(speed));<br>+&nbsp;&nbsp; &nbsp;return ide_config_drive_s=
peed(drive, speed);<br>&nbsp;}<br>&nbsp;<br>&nbsp;static void<br>@@ -151,6 =
+443,225 @@ mpc52xx_ide_selectproc(ide_drive_t *driv<br>
&nbsp;}<br>&nbsp;<br>&nbsp;<br>+<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<=
br>+<br>+static int mpc52xx_ide_dma_check(ide_drive_t *drive)<br>+{<br>+&nb=
sp;&nbsp; &nbsp;u8 speed =3D ide_dma_speed(drive, 2);<br>+<br>+&nbsp;&nbsp;=
 &nbsp;DPRINTK(&quot;dma_check: speed=3D%x\n&quot;, speed);
<br>+&nbsp;&nbsp; &nbsp;if (speed =3D=3D 0)<br>+&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;return -1;<br>+&nbsp;&nbsp; &nbsp;mpc52xx_ide_speedproc(drive, s=
peed);<br>+<br>+&nbsp;&nbsp; &nbsp;if (ide_dma_enable(drive))<br>+&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;drive-&gt;using_dma =3D 1;<br>+&nbsp;&nbsp; &n=
bsp;else<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;drive-&gt;using_dma =3D =
0;<br>
+<br>+&nbsp;&nbsp; &nbsp;return 0;<br>+}<br>+<br>+static int mpc52xx_ide_bu=
ild_dmatable(ide_drive_t *drive, struct request *rq)<br>+{<br>+&nbsp;&nbsp;=
 &nbsp;struct mpc52xx_ide_priv *priv =3D drive-&gt;hwif-&gt;hwif_data;<br>+=
&nbsp;&nbsp; &nbsp;struct mpc52xx_ata __iomem *regs =3D priv-&gt;ata_regs;
<br>+&nbsp;&nbsp; &nbsp;struct scatterlist *sg;<br>+&nbsp;&nbsp; &nbsp;ide_=
hwif_t *hwif =3D HWIF(drive);<br>+&nbsp;&nbsp; &nbsp;int i, count =3D 0;<br=
>+<br>+&nbsp;&nbsp; &nbsp;/* Build sglist */<br>+&nbsp;&nbsp; &nbsp;hwif-&g=
t;sg_nents =3D i =3D ide_build_sglist(drive, rq);<br>+&nbsp;&nbsp; &nbsp;if=
 (!hwif-&gt;sg_nents)
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 0;<br>+<br>+&nbsp;&nbsp; =
&nbsp;if (hwif-&gt;sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE) {<br>+&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; sdma_ata_rx_init(priv-&gt;sdma);<br>+&nbsp;=
&nbsp; &nbsp;} else {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; sdma_ata_tx=
_init(priv-&gt;sdma);<br>+&nbsp;&nbsp; &nbsp;}<br>+<br>+<br>
+&nbsp;&nbsp; &nbsp;sg =3D hwif-&gt;sg_table;<br>+&nbsp;&nbsp; &nbsp;while =
(i &amp;&amp; sg_dma_len(sg)) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;u=
32 cur_addr;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;u32 cur_len;<br>+<br=
>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;cur_addr =3D sg_dma_address(sg);<br=
>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;cur_len =3D sg_dma_len(sg);<br>+<br=
>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;while (cur_len) {
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;unsigned int =
tc&nbsp; =3D (cur_len &lt;=3D MAX_DMA_BUFFER_SIZE) ? cur_len: MAX_DMA_BUFFE=
R_SIZE;<br>+<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;i=
f (hwif-&gt;sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE) {<br>+&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;invalidate_d=
cache_range((u32)phys_to_virt(cur_addr), (u32)phys_to_virt(cur_addr)+(u32)t=
c);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;sdma_submit_buffer2(priv-&gt;sdma, phys_to_virt(cur_addr), (void *)&a=
mp;regs-&gt;fifo_data, (void *)cur_addr, tc);<br>+&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;} else {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;flush_dcache_range((u32)phys_=
to_virt(cur_addr), (u32)phys_to_virt(cur_addr)+(u32)tc);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;sdma_submit_buffer2(priv-&gt;sdma, phys_to_virt(cur_addr), (void *)cu=
r_addr, (void *)&amp;regs-&gt;fifo_data, tc);<br>+&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>+<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;//DPRINTK(&quot;SDMA setup @%08x, l: %x, nextbd: %=
d !\n&quot;, cur_addr, tc, next_bd);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;cur_addr +=3D=
 tc;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;cur_len -=
=3D tc;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;count+=
+;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if(count =
=3D=3D MAX_DMA_BUFFERS) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;printk(KERN_WARNING &quot;%s: DMA table too =
small\n&quot;,drive-&gt;name);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;goto use_pio_instead;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;};<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;sg++;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;i--;<br>+&nbsp;&nbsp; &nbsp;}<br>+<br>+&nbsp;&nbsp; &nbsp;return 1;<br>+<b=
r>+use_pio_instead:<br>+&nbsp;&nbsp; &nbsp;sdma_ata_reset(priv-&gt;sdma);<b=
r>+<br>+&nbsp;&nbsp; &nbsp;pci_unmap_sg(hwif-&gt;pci_dev,
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;hwif-&gt;sg_t=
able,<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;hwif-&gt=
;sg_nents,<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;hwi=
f-&gt;sg_dma_direction);<br>+<br>+&nbsp;&nbsp; &nbsp;return 0; /* revert to=
 PIO for this request */<br>+}<br>+<br>+<br>+/* Teardown mappings after DMA=
 has completed.&nbsp; */
<br>+static void mpc52xx_ide_destroy_dmatable (ide_drive_t *drive)<br>+{<br=
>+&nbsp;&nbsp; &nbsp;ide_hwif_t *hwif =3D drive-&gt;hwif;<br>+&nbsp;&nbsp; =
&nbsp;struct pci_dev *dev =3D HWIF(drive)-&gt;pci_dev;<br>+&nbsp;&nbsp; &nb=
sp;struct scatterlist *sg =3D hwif-&gt;sg_table;
<br>+&nbsp;&nbsp; &nbsp;int nents =3D hwif-&gt;sg_nents;<br>+<br>+&nbsp;&nb=
sp; &nbsp;if (nents) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;pci_unmap_=
sg(dev, sg, nents, hwif-&gt;sg_dma_direction);<br>+&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;hwif-&gt;sg_nents =3D 0;<br>+&nbsp;&nbsp; &nbsp;}<br>+}<br>+<=
br>+<br>+static void mpc52xx_ide_dma_exec_cmd(ide_drive_t *drive, u8 comman=
d)
<br>+{<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *priv =3D drive-&gt;h=
wif-&gt;hwif_data;<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ata __iomem *regs =
=3D priv-&gt;ata_regs;<br>+<br>+&nbsp;&nbsp; &nbsp;mpc52xx_ide_wait_tip_bit=
_clear(regs);<br>+<br>+&nbsp;&nbsp; &nbsp;/* issue cmd to drive */
<br>+&nbsp;&nbsp; &nbsp;ide_execute_command(drive, command, &amp;ide_dma_in=
tr, 2*WAIT_CMD, NULL);<br>+}<br>+<br>+<br>+static int mpc52xx_ide_dma_setup=
(ide_drive_t *drive)<br>+{<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *=
priv =3D drive-&gt;hwif-&gt;hwif_data;
<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ata __iomem *regs =3D priv-&gt;ata_r=
egs;<br>+&nbsp;&nbsp; &nbsp;ide_hwif_t *hwif =3D HWIF(drive);<br>+&nbsp;&nb=
sp; &nbsp;struct request *rq =3D HWGROUP(drive)-&gt;rq;<br>+&nbsp;&nbsp; &n=
bsp;int which =3D drive-&gt;select.b.unit &amp; 0x01;<br>+&nbsp;&nbsp; &nbs=
p;u8 dma_mode;
<br>+<br>+&nbsp;&nbsp; &nbsp;if (!mpc52xx_ide_build_dmatable(drive, rq)) {<=
br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ide_map_sg(drive, rq);<br>+&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 1;<br>+&nbsp;&nbsp; &nbsp;};<br>+<br=
>+&nbsp;&nbsp; &nbsp;if(hwif-&gt;sg_dma_direction =3D=3D PCI_DMA_FROMDEVICE=
) { /* read */<br>+<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;dma_mode =3D =
MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ | MPC52xx_ATA_DMAMODE_FE;
<br>+<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* Setup FIFO if direction =
changed */<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (priv-&gt;mpc52xx_a=
ta_dma_last_write) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;priv-&gt;mpc52xx_ata_dma_last_write =3D 0;<br>+&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mpc52xx_ide_wait_tip_bit_clear(regs);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;out_8(&amp;re=
gs-&gt;dma_mode, MPC52xx_ATA_DMAMODE_FR);<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;/* Configure it with granularity to 7 like samp=
le code */<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;out=
_8(&amp;regs-&gt;fifo_control, 7);<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;out_be16(&amp;regs-&gt;fifo_alarm, 128);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp; &nbsp;}<br>+&=
nbsp;&nbsp; &nbsp;else {<br>+<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;dma=
_mode =3D MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;<br>+<br>+&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* Setup FIFO if direction changed */<br>=
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (!priv-&gt;mpc52xx_ata_dma_last_w=
rite) {
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;priv-&gt;mpc5=
2xx_ata_dma_last_write =3D 1;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;mpc52xx_ide_wait_tip_bit_clear(regs);<br>+&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* Configure FIFO with granularity =
to 4 like sample code */<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;out_8(&amp;regs-&gt;fifo_control, 4);
<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;//out_be16(&a=
mp;regs-&gt;fifo_alarm, 256);<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;out_be16(&amp;regs-&gt;fifo_alarm, 128);<br>+&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp; &nbsp;};<br>+<br>+&nbsp;&nbsp; &=
nbsp;if (priv-&gt;timings[which].using_udma)<br>+&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;dma_mode |=3D MPC52xx_ATA_DMAMODE_UDMA;
<br>+<br>+&nbsp;&nbsp; &nbsp;mpc52xx_ide_wait_tip_bit_clear(regs);<br>+&nbs=
p;&nbsp; &nbsp;out_8(&amp;regs-&gt;dma_mode, dma_mode);<br>+<br>+&nbsp;&nbs=
p; &nbsp;drive-&gt;waiting_for_dma =3D 1;<br>+<br>+&nbsp;&nbsp; &nbsp;retur=
n 0;<br>+};<br>+<br>+static void mpc52xx_ide_dma_start(ide_drive_t *drive)
<br>+{<br>+&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *priv =3D drive-&gt;h=
wif-&gt;hwif_data;<br>+&nbsp;&nbsp; &nbsp;extern void xlb_clear(void);<br>+=
<br>+&nbsp;&nbsp; &nbsp;xlb_clear();<br>+&nbsp;&nbsp; &nbsp;sdma_set_task_a=
uto_start(priv-&gt;sdma-&gt;tasknum, priv-&gt;sdma-&gt;tasknum);
<br>+&nbsp;&nbsp; &nbsp;sdma_enable(priv-&gt;sdma);<br>+}<br>+<br>+<br>+sta=
tic int mpc52xx_ide_dma_end(ide_drive_t *drive)<br>+{<br>+&nbsp;&nbsp; &nbs=
p;struct mpc52xx_ide_priv *priv =3D drive-&gt;hwif-&gt;hwif_data;<br>+<br>+=
&nbsp;&nbsp; &nbsp;drive-&gt;waiting_for_dma =3D 0;
<br>+<br>+&nbsp;&nbsp; &nbsp;sdma_disable(priv-&gt;sdma);<br>+&nbsp;&nbsp; =
&nbsp;sdma_clear_irq(priv-&gt;sdma);<br>+&nbsp;&nbsp; &nbsp;sdma_ata_reset(=
priv-&gt;sdma);<br>+&nbsp;&nbsp; &nbsp;mpc52xx_ide_destroy_dmatable(drive);=
<br>+<br>+&nbsp;&nbsp; &nbsp;return 0;<br>+}<br>+<br>+<br>+static int mpc52=
xx_ide_dma_test_irq(ide_drive_t *drive)
<br>+{<br>+&nbsp;&nbsp; &nbsp;return (drive-&gt;waiting_for_dma);<br>+}<br>=
+<br>+<br>+static int mpc52xx_ide_dma_host_off(ide_drive_t *drive)<br>+{<br=
>+&nbsp;&nbsp; &nbsp;return 0;<br>+}<br>+<br>+<br>+static int mpc52xx_ide_d=
ma_host_on(ide_drive_t *drive)
<br>+{<br>+&nbsp;&nbsp; &nbsp;return 0;<br>+}<br>+<br>+static int mpc52xx_i=
de_dma_lostirq(ide_drive_t *drive)<br>+{<br>+&nbsp;&nbsp; &nbsp;printk(KERN=
_ERR &quot;%s: lost interrupt\n&quot;, drive-&gt;name);<br>+&nbsp;&nbsp; &n=
bsp;return 0;<br>+}<br>+<br>+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */
<br>+<br>+<br>&nbsp;static int<br>&nbsp;mpc52xx_ide_setup(<br>&nbsp;&nbsp;&=
nbsp; &nbsp;struct mpc52xx_ata __iomem *regs, struct mpc52xx_ide_priv *priv=
)<br>@@ -181,6 +692,21 @@ mpc52xx_ide_setup(<br>&nbsp;&nbsp;&nbsp; &nbsp;ts=
lot =3D CALC_CLK_VALUE_UP(priv-&gt;ipb_period, 1000000);
<br>&nbsp;&nbsp;&nbsp; &nbsp;out_be32(&amp;regs-&gt;share_cnt, tslot &lt;&l=
t; 16);<br>&nbsp;<br>+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS<br>+&nb=
sp;&nbsp; &nbsp;printk(&quot;ipb=3D%dMHz, set clock period to %d ps\n&quot;=
,(int)(bd-&gt;bi_ipbfreq/1000000), <br>
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;priv-&gt;ipb_peri=
od);<br>+#endif<br>+<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>+&nbsp;&n=
bsp; &nbsp;if(bd-&gt;bi_ipbfreq/1000000 =3D=3D 66) {<br>+&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;priv-&gt;mdmaspec =3D &amp;mdmaspec66;<br>+&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;priv-&gt;udmaspec =3D &amp;udmaspec66;
<br>+&nbsp;&nbsp; &nbsp;} else {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
priv-&gt;mdmaspec =3D &amp;mdmaspec132;<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;priv-&gt;udmaspec =3D &amp;udmaspec132;<br>+&nbsp;&nbsp; &nbsp;}<br>=
+#endif<br>+<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Init imings to PIO0 (safest) */=
<br>&nbsp;&nbsp;&nbsp; &nbsp;memset(priv-&gt;timings, 0x00, 2*sizeof(struct=
 mpc52xx_ata_timings));
<br>&nbsp;<br>@@ -189,9 +715,35 @@ mpc52xx_ide_setup(<br>&nbsp;<br>&nbsp;&n=
bsp;&nbsp; &nbsp;mpc52xx_ide_apply_timing(regs, &amp;priv-&gt;timings[0]);<=
br>&nbsp;<br>+#ifdef CONFIG_BLK_DEV_IDE_MPC52xx_SHOWDETAILS<br>+&nbsp;&nbsp=
; &nbsp;printk(&quot;GPIO config: %08x\n&quot;, in_be32((u32 *)0xf0000b00))=
;
<br>+&nbsp;&nbsp; &nbsp;printk(&quot;ATA invalid: %08x\n&quot;, in_be32((u3=
2 *)0xf0003a2c));<br>+&nbsp;&nbsp; &nbsp;printk(&quot;ATA hostcnf: %08x\n&q=
uot;, in_be32((u32 *)0xf0003a00));<br>+&nbsp;&nbsp; &nbsp;printk(&quot;ATA =
pio1&nbsp;&nbsp; : %08x\n&quot;, in_be32((u32 *)0xf0003a08));
<br>+&nbsp;&nbsp; &nbsp;printk(&quot;ATA pio2&nbsp;&nbsp; : %08x\n&quot;, i=
n_be32((u32 *)0xf0003a0c));<br>+&nbsp;&nbsp; &nbsp;printk(&quot;XLB Arb cnf=
: %08x\n&quot;, in_be32((u32 *)0xf0001f40));<br>+#endif<br>+<br>&nbsp;&nbsp=
;&nbsp; &nbsp;return 0;<br>&nbsp;}<br>&nbsp;<br>+#ifdef CONFIG_BLK_DEV_MPC5=
2xx_IDE_DMA
<br>+static int<br>+mpc52xx_ata_sdma_setup(struct mpc52xx_ide_priv *priv)<b=
r>+{<br>+&nbsp;&nbsp; &nbsp;int rv =3D 0;<br>+<br>+&nbsp;&nbsp; &nbsp;priv-=
&gt;sdma =3D sdma_alloc(MAX_DMA_BUFFERS);<br>+&nbsp;&nbsp; &nbsp;if (!priv-=
&gt;sdma) {<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return -ENOMEM;<br>+&=
nbsp;&nbsp; &nbsp;}
<br>+<br>+&nbsp;&nbsp; &nbsp;(void) sdma_ata_init(priv-&gt;sdma, MAX_DMA_BU=
FFER_SIZE);<br>+<br>+&nbsp;&nbsp; &nbsp;return rv;<br>+}<br>+#endif<br>+<br=
>&nbsp;static void<br>&nbsp;mpc52xx_ide_setup_hwif_ports(hw_regs_t *hw, str=
uct mpc52xx_ata __iomem *regs)<br>&nbsp;{
<br>@@ -218,7 +770,7 @@ mpc52xx_ide_probe(struct platform_device<br>&nbsp;{=
<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Vars */<br>&nbsp;&nbsp;&nbsp; &nbsp;ide_hwi=
f_t *hwif;<br>-&nbsp;&nbsp; &nbsp;struct mpc52xx_ide_priv *priv;<br>+&nbsp;=
&nbsp; &nbsp;struct mpc52xx_ide_priv *priv =3D NULL;<br>&nbsp;&nbsp;&nbsp; =
&nbsp;struct mpc52xx_gpio __iomem *gpio_regs =3D NULL;
<br>&nbsp;&nbsp;&nbsp; &nbsp;struct mpc52xx_ata __iomem *ata_regs =3D NULL;=
<br>&nbsp;&nbsp;&nbsp; &nbsp;int ata_irq;<br>@@ -284,6 +836,7 @@ mpc52xx_id=
e_probe(struct platform_device<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;goto error;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp;<br>+&nbsp;&nbsp; &nb=
sp;memset(priv, 0, sizeof *priv);<br>&nbsp;&nbsp;&nbsp; &nbsp;priv-&gt;ata_=
regs =3D ata_regs;
<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Setup the ATA controller */<br>@@=
 -292,6 +845,13 @@ mpc52xx_ide_probe(struct platform_device<br>&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;printk(KERN_ERR &quot;mpc52xx-ide: Controll=
er setup failed !\n&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
goto error;<br>&nbsp;&nbsp;&nbsp; &nbsp;}
<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>+&nbsp;&nbsp; &nbsp;rv =3D mp=
c52xx_ata_sdma_setup(priv);<br>+&nbsp;&nbsp; &nbsp;if (rv) {<br>+&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;printk(KERN_ERR &quot;mpc52xx-ide: SDMA setup f=
ailed !\n&quot;);<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;goto error;<br>=
+&nbsp;&nbsp; &nbsp;}<br>+#endif
<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; &nbsp;/* Setup the hwif structure */<br>&n=
bsp;&nbsp;&nbsp; &nbsp;hwif-&gt;irq =3D ata_irq;<br>@@ -325,6 +885,38 @@ mp=
c52xx_ide_probe(struct platform_device<br>&nbsp;&nbsp;&nbsp; &nbsp;hwif-&gt=
;drives[1].autodma =3D hwif-&gt;autodma;<br>&nbsp;&nbsp;&nbsp; &nbsp;hwif-&=
gt;drives[1].no_io_32bit =3D 1;&nbsp;&nbsp; &nbsp;/* Anyone tried ? */
<br>&nbsp;<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_DMA<br>+<br>+&nbsp;&nbsp; =
&nbsp;hwif-&gt;atapi_dma =3D 1;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;autodma =3D=
 1;<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_MDMA<br>+&nbsp;&nbsp; &nbsp;hwif-=
&gt;mwdma_mask =3D 0x07;<br>+#endif<br>+#ifdef CONFIG_BLK_DEV_MPC52xx_IDE_U=
DMA
<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ultra_mask =3D 0x1F;<br>+#endif<br>+&nbsp;=
&nbsp; &nbsp;hwif-&gt;ide_dma_off_quietly =3D &amp;__ide_dma_off_quietly;<b=
r>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_on =3D &amp;__ide_dma_on;<br>+&nbsp;=
&nbsp; &nbsp;hwif-&gt;ide_dma_check =3D &amp;mpc52xx_ide_dma_check;
<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;dma_setup =3D &amp;mpc52xx_ide_dma_setup;<=
br>+&nbsp;&nbsp; &nbsp;hwif-&gt;dma_exec_cmd =3D &amp;mpc52xx_ide_dma_exec_=
cmd;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;dma_start =3D &amp;mpc52xx_ide_dma_sta=
rt;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_end =3D &amp;mpc52xx_ide_dma_en=
d;
<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_test_irq =3D &amp;mpc52xx_ide_dma_=
test_irq;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_host_off =3D &amp;mpc52xx=
_ide_dma_host_off;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_host_on =3D &amp=
;mpc52xx_ide_dma_host_on;<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_timeout =
=3D &amp;__ide_dma_timeout;
<br>+&nbsp;&nbsp; &nbsp;hwif-&gt;ide_dma_lostirq =3D &amp;mpc52xx_ide_dma_l=
ostirq;<br>+<br>+#ifndef CONFIG_BLK_DEV_IDE_MPC52xx_LIMIT_TO_UDMA1<br>+&nbs=
p;&nbsp; &nbsp;hwif-&gt;udma_four =3D 1;<br>+#endif<br>+&nbsp;&nbsp; &nbsp;=
hwif-&gt;hwif_data =3D priv;<br>+<br>+&nbsp;&nbsp; &nbsp;priv-&gt;mpc52xx_a=
ta_dma_last_write =3D 1;
<br>+<br>+#endif /* CONFIG_BLK_DEV_MPC52xx_IDE_DMA */<br>+<br>&nbsp;&nbsp;&=
nbsp; &nbsp;hwif-&gt;hwif_data =3D priv;<br>&nbsp;&nbsp;&nbsp; &nbsp;platfo=
rm_set_drvdata(dev, hwif);<br>&nbsp;<br>@@ -346,6 +938,14 @@ error:<br>&nbs=
p;<br>&nbsp;&nbsp;&nbsp; &nbsp;release_mem_region(res_mem-&gt;start, sizeof=
(struct mpc52xx_ata));
<br>&nbsp;<br>+&nbsp;&nbsp; &nbsp;if (priv) {<br>+#ifdef CONFIG_BLK_DEV_MPC=
52xx_IDE_DMA<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (priv-&gt;sdma)&n=
bsp;&nbsp; &nbsp;sdma_free(priv-&gt;sdma);<br>+#endif<br>+&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;kfree(priv);<br>+&nbsp;&nbsp; &nbsp;}<br>+&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;<br>+<br>&nbsp;&nbsp;&nbsp; &nbsp;return rv;<br>&=
nbsp;}<br>&nbsp;
<br>-- <br>1.1.3<br><br>

------=_Part_13908_15682114.1143741088805--
