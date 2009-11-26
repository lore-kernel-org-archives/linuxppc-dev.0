Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 460401007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 11:45:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] ppc440spe-adma: adds updated ppc440spe adma driver
Date: Wed, 25 Nov 2009 16:34:31 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C08642A43@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1259186722-15012-1-git-send-email-agust@denx.de>
References: <1259186722-15012-1-git-send-email-agust@denx.de>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Anatolij Gustschin" <agust@denx.de>,
	<linux-raid@vger.kernel.org>
Cc: Yuri Tikhonov <yur@emcraft.com>, linuxppc-dev@ozlabs.org,
	dan.j.williams@intel.com, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Why are we having separate directory for 440spe. Can this be generalized
arch/dma/ppc4xx/ppc4xx_dma.c ?

-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] On =
Behalf
Of Anatolij Gustschin
Sent: Wednesday, November 25, 2009 2:05 PM
To: linux-raid@vger.kernel.org
Cc: wd@denx.de; dzu@denx.de; Yuri Tikhonov; linuxppc-dev@ozlabs.org;
dan.j.williams@intel.com; Anatolij Gustschin
Subject: [PATCH v2] ppc440spe-adma: adds updated ppc440spe adma driver

This patch adds new version of the PPC440SPe ADMA driver.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---

Changes since v1:
 - removed DCRN_SDR_CONFIG_* defines
 - use ioread32/iowrite32 instead of in_le32/out_le32
 - moved headers and driver file to ppc440spe directory
 - use dcr_write/dcr_read instead of mtdcr/mfdcr
 - update copyright notes
 - remove remaining typedefs
 - use accessors to read/write mmio registers instead of
   volatile struct pointers
 - removed "select ASYNC_TX_DMA" and "default y"
 - wrap calls to debug functions, use pr_debug
 - fix errors reported by sparse
 - check for 'len' > PAGE_SIZE cases where required
 - use dma_set_maxpq() when setting 'max_pq'

Before applying this patch the following patch to katmai.dts
should be applied first: http://patchwork.ozlabs.org/patch/36768/

 .../powerpc/dts-bindings/4xx/ppc440spe-adma.txt    |   93 +
 arch/powerpc/boot/dts/katmai.dts                   |   52 +-
 arch/powerpc/include/asm/async_tx.h                |   47 +
 arch/powerpc/include/asm/dcr-regs.h                |   23 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/ppc440spe/Makefile                     |    1 +
 drivers/dma/ppc440spe/ppc440spe-adma.c             | 5015
++++++++++++++++++++
 drivers/dma/ppc440spe/ppc440spe_adma.h             |  195 +
 drivers/dma/ppc440spe/ppc440spe_dma.h              |  223 +
 drivers/dma/ppc440spe/ppc440spe_xor.h              |  110 +
 11 files changed, 5770 insertions(+), 1 deletions(-)
 create mode 100644
Documentation/powerpc/dts-bindings/4xx/ppc440spe-adma.txt
 create mode 100644 arch/powerpc/include/asm/async_tx.h
 create mode 100644 drivers/dma/ppc440spe/Makefile
 create mode 100644 drivers/dma/ppc440spe/ppc440spe-adma.c
 create mode 100644 drivers/dma/ppc440spe/ppc440spe_adma.h
 create mode 100644 drivers/dma/ppc440spe/ppc440spe_dma.h
 create mode 100644 drivers/dma/ppc440spe/ppc440spe_xor.h

diff --git a/Documentation/powerpc/dts-bindings/4xx/ppc440spe-adma.txt
b/Documentation/powerpc/dts-bindings/4xx/ppc440spe-adma.txt
new file mode 100644
index 0000000..515ebcf
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/ppc440spe-adma.txt
@@ -0,0 +1,93 @@
+PPC440SPe DMA/XOR (DMA Controller and XOR Accelerator)
+
+Device nodes needed for operation of the ppc440spe-adma driver
+are specified hereby. These are I2O/DMA, DMA and XOR nodes
+for DMA engines and Memory Queue Module node. The latter is used
+by ADMA driver for configuration of RAID-6 H/W capabilities of
+the PPC440SPe. In addition to the nodes and properties described
+below, the ranges property of PLB node must specify ranges for
+DMA devices.
+
+ i) The I2O node
+
+ Required properties:
+
+ - compatible		: "ibm,i2o-440spe";
+ - reg			: <registers mapping>
+ - dcr-reg		: <DCR registers range>
+
+ Example:
+
+	I2O: i2o@400100000 {
+		compatible =3D "ibm,i2o-440spe";
+		reg =3D <0x00000004 0x00100000 0x100>;
+		dcr-reg =3D <0x060 0x020>;
+	};
+
+
+ ii) The DMA node
+
+ Required properties:
+
+ - compatible		: "ibm,dma-440spe";
+ - cell-index		: 1 cell, hardware index of the DMA engine
+			  (typically 0x0 and 0x1 for DMA0 and DMA1)
+ - reg			: <registers mapping>
+ - dcr-reg		: <DCR registers range>
+ - interrupts		: <interrupt mapping for DMA0/1 interrupts
sources:
+			   2 sources: DMAx CS FIFO Needs Service IRQ (on
UIC0)
+			   and DMA Error IRQ (on UIC1). The latter is
common
+			   for both DMA engines>.
+ - interrupt-parent	: needed for interrupt mapping
+
+ Example:
+
+	DMA0: dma0@400100100 {
+		compatible =3D "ibm,dma-440spe";
+		cell-index =3D <0>;
+		reg =3D <0x00000004 0x00100100 0x100>;
+		dcr-reg =3D <0x060 0x020>;
+		interrupt-parent =3D <&DMA0>;
+		interrupts =3D <0 1>;
+		#interrupt-cells =3D <1>;
+		#address-cells =3D <0>;
+		#size-cells =3D <0>;
+		interrupt-map =3D <
+			0 &UIC0 0x14 4
+			1 &UIC1 0x16 4>;
+	};
+
+
+ iii) XOR Accelerator node
+
+ Required properties:
+
+ - compatible		: "amcc,xor-accelerator";
+ - reg			: <registers mapping>
+ - interrupts		: <interrupt mapping for XOR interrupt source>
+ - interrupt-parent	: for interrupt mapping
+
+ Example:
+
+	xor-accel@400200000 {
+		compatible =3D "amcc,xor-accelerator";
+		reg =3D <0x00000004 0x00200000 0x400>;
+		interrupt-parent =3D <&UIC1>;
+		interrupts =3D <0x1f 4>;
+	};
+
+
+ iv) Memory Queue Module node
+
+ Required properties:
+
+ - compatible		: "ibm,mq-440spe";
+ - dcr-reg		: <DCR registers range>
+
+ Example:
+
+	MQ0: mq {
+		compatible =3D "ibm,mq-440spe";
+		dcr-reg =3D <0x040 0x020>;
+	};
+
diff --git a/arch/powerpc/boot/dts/katmai.dts
b/arch/powerpc/boot/dts/katmai.dts
index b8cd97c..033a134 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -108,12 +108,19 @@
 		dcr-reg =3D <0x00c 0x002>;
 	};
=20
+	MQ0: mq {
+		compatible =3D "ibm,mq-440spe";
+		dcr-reg =3D <0x040 0x020>;
+	};
+
 	plb {
 		compatible =3D "ibm,plb-440spe", "ibm,plb-440gp",
"ibm,plb4";
 		#address-cells =3D <2>;
 		#size-cells =3D <1>;
 		/*        addr-child     addr-parent    size */
-		ranges =3D <0x4 0xe0000000 0x4 0xe0000000 0x20000000
+		ranges =3D <0x4 0x00100000 0x4 0x00100000 0x00001000
+			  0x4 0x00200000 0x4 0x00200000 0x00000400
+			  0x4 0xe0000000 0x4 0xe0000000 0x20000000
 			  0xc 0x00000000 0xc 0x00000000 0x20000000
 			  0xd 0x00000000 0xd 0x00000000 0x80000000
 			  0xd 0x80000000 0xd 0x80000000 0x80000000
@@ -400,6 +407,49 @@
 				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /*
swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /*
swizzled int D */>;
 		};
+
+		I2O: i2o@400100000 {
+			compatible =3D "ibm,i2o-440spe";
+			reg =3D <0x00000004 0x00100000 0x100>;
+			dcr-reg =3D <0x060 0x020>;
+		};
+
+		DMA0: dma0@400100100 {
+			compatible =3D "ibm,dma-440spe";
+			cell-index =3D <0>;
+			reg =3D <0x00000004 0x00100100 0x100>;
+			dcr-reg =3D <0x060 0x020>;
+			interrupt-parent =3D <&DMA0>;
+			interrupts =3D <0 1>;
+			#interrupt-cells =3D <1>;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			interrupt-map =3D <
+				0 &UIC0 0x14 4
+				1 &UIC1 0x16 4>;
+		};
+
+		DMA1: dma1@400100200 {
+			compatible =3D "ibm,dma-440spe";
+			cell-index =3D <1>;
+			reg =3D <0x00000004 0x00100200 0x100>;
+			dcr-reg =3D <0x060 0x020>;
+			interrupt-parent =3D <&DMA1>;
+			interrupts =3D <0 1>;
+			#interrupt-cells =3D <1>;
+			#address-cells =3D <0>;
+			#size-cells =3D <0>;
+			interrupt-map =3D <
+				0 &UIC0 0x16 4
+				1 &UIC1 0x16 4>;
+		};
+
+		xor-accel@400200000 {
+			compatible =3D "amcc,xor-accelerator";
+			reg =3D <0x00000004 0x00200000 0x400>;
+			interrupt-parent =3D <&UIC1>;
+			interrupts =3D <0x1f 4>;
+		};
 	};
=20
 	chosen {
diff --git a/arch/powerpc/include/asm/async_tx.h
b/arch/powerpc/include/asm/async_tx.h
new file mode 100644
index 0000000..8b2dc55
--- /dev/null
+++ b/arch/powerpc/include/asm/async_tx.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2008-2009 DENX Software Engineering.
+ *
+ * Author: Yuri Tikhonov <yur@emcraft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the Free
+ * Software Foundation; either version 2 of the License, or (at your
option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution
in the
+ * file called COPYING.
+ */
+#ifndef _ASM_POWERPC_ASYNC_TX_H_
+#define _ASM_POWERPC_ASYNC_TX_H_
+
+#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
+extern struct dma_chan *
+ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
+	struct page **dst_lst, int dst_cnt, struct page **src_lst,
+	int src_cnt, size_t src_sz);
+
+#define async_tx_find_channel(dep, cap, dst_lst, dst_cnt, src_lst, \
+			      src_cnt, src_sz) \
+	ppc440spe_async_tx_find_best_channel(cap, dst_lst, dst_cnt,
src_lst, \
+					     src_cnt, src_sz)
+#else
+
+#define async_tx_find_channel(dep, type, dst, dst_count, src,
src_count, len) \
+	__async_tx_find_channel(dep, type)
+
+struct dma_chan *
+__async_tx_find_channel(struct async_submit_ctl *submit,
+			enum dma_transaction_type tx_type);
+
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/dcr-regs.h
b/arch/powerpc/include/asm/dcr-regs.h
index 828e3aa..380274d 100644
--- a/arch/powerpc/include/asm/dcr-regs.h
+++ b/arch/powerpc/include/asm/dcr-regs.h
@@ -157,4 +157,27 @@
 #define  L2C_SNP_SSR_32G	0x0000f000
 #define  L2C_SNP_ESR		0x00000800
=20
+/*
+ * DCR register offsets for 440SP/440SPe I2O/DMA controller.
+ * The base address is configured in the device tree.
+ */
+#define DCRN_I2O0_IBAL		0x006
+#define DCRN_I2O0_IBAH		0x007
+#define I2O_REG_ENABLE		0x00000001	/* Enable I2O/DMA access
*/
+
+/* 440SP/440SPe Software Reset DCR */
+#define DCRN_SDR0_SRST		0x0200
+#define DCRN_SDR0_SRST_I2ODMA	(0x80000000 >> 15)	/* Reset I2O/DMA
*/
+
+/* 440SP/440SPe Memory Queue DCR offsets */
+#define DCRN_MQ0_XORBA		0x04
+#define DCRN_MQ0_CF2H		0x06
+#define DCRN_MQ0_CFBHL		0x0f
+#define DCRN_MQ0_BAUH		0x10
+
+/* HB/LL Paths Configuration Register */
+#define MQ0_CFBHL_TPLM		28
+#define MQ0_CFBHL_HBCL		23
+#define MQ0_CFBHL_POLY		15
+
 #endif /* __DCR_REGS_H__ */
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b401dad..af43aca 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -111,6 +111,17 @@ config SH_DMAE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
=20
+config AMCC_PPC440SPE_ADMA
+	tristate "AMCC PPC440SPe ADMA support"
+	depends on 440SPe || 440SP
+	select DMA_ENGINE
+	select ARCH_HAS_ASYNC_TX_FIND_CHANNEL
+	help
+	  Enable support for the AMCC PPC440SPe RAID engines.
+
+config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
+	bool
+
 config DMA_ENGINE
 	bool
=20
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index eca71ba..cdb5be8 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_AT_HDMAC) +=3D at_hdmac.o
 obj-$(CONFIG_MX3_IPU) +=3D ipu/
 obj-$(CONFIG_TXX9_DMAC) +=3D txx9dmac.o
 obj-$(CONFIG_SH_DMAE) +=3D shdma.o
+obj-$(CONFIG_AMCC_PPC440SPE_ADMA) +=3D ppc440spe/
diff --git a/drivers/dma/ppc440spe/Makefile
b/drivers/dma/ppc440spe/Makefile
new file mode 100644
index 0000000..77691b7
--- /dev/null
+++ b/drivers/dma/ppc440spe/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_AMCC_PPC440SPE_ADMA) +=3D ppc440spe-adma.o
diff --git a/drivers/dma/ppc440spe/ppc440spe-adma.c
b/drivers/dma/ppc440spe/ppc440spe-adma.c
new file mode 100644
index 0000000..b37c896
--- /dev/null
+++ b/drivers/dma/ppc440spe/ppc440spe-adma.c
@@ -0,0 +1,5015 @@
+/*
+ * Copyright (C) 2006-2009 DENX Software Engineering.
+ *
+ * Author: Yuri Tikhonov <yur@emcraft.com>
+ *
+ * Further porting to arch/powerpc by
+ * 	Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the Free
+ * Software Foundation; either version 2 of the License, or (at your
option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution
in the
+ * file called COPYING.
+ */
+
+/*
+ * This driver supports the asynchrounous DMA copy and RAID engines
available
+ * on the AMCC PPC440SPe Processors.
+ * Based on the Intel Xscale(R) family of I/O Processors (IOP 32x, 33x,
134x)
+ * ADMA driver written by D.Williams.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/async_tx.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/uaccess.h>
+#include <linux/proc_fs.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/dcr.h>
+#include <asm/dcr-regs.h>
+#include "ppc440spe_adma.h"
+
+enum ppc_adma_init_code {
+	PPC_ADMA_INIT_OK =3D 0,
+	PPC_ADMA_INIT_MEMRES,
+	PPC_ADMA_INIT_MEMREG,
+	PPC_ADMA_INIT_ALLOC,
+	PPC_ADMA_INIT_COHERENT,
+	PPC_ADMA_INIT_CHANNEL,
+	PPC_ADMA_INIT_IRQ1,
+	PPC_ADMA_INIT_IRQ2,
+	PPC_ADMA_INIT_REGISTER
+};
+
+static char *ppc_adma_errors[] =3D {
+	[PPC_ADMA_INIT_OK] =3D "ok",
+	[PPC_ADMA_INIT_MEMRES] =3D "failed to get memory resource",
+	[PPC_ADMA_INIT_MEMREG] =3D "failed to request memory region",
+	[PPC_ADMA_INIT_ALLOC] =3D "failed to allocate memory for adev "
+				"structure",
+	[PPC_ADMA_INIT_COHERENT] =3D "failed to allocate coherent memory
for "
+				   "hardware descriptors",
+	[PPC_ADMA_INIT_CHANNEL] =3D "failed to allocate memory for
channel",
+	[PPC_ADMA_INIT_IRQ1] =3D "failed to request first irq",
+	[PPC_ADMA_INIT_IRQ2] =3D "failed to request second irq",
+	[PPC_ADMA_INIT_REGISTER] =3D "failed to register dma async
device",
+};
+
+static enum ppc_adma_init_code
+ppc440spe_adma_devices[PPC440SPE_ADMA_ENGINES_NUM];
+
+struct ppc_dma_chan_ref {
+	struct dma_chan *chan;
+	struct list_head node;
+};
+
+/* The list of channels exported by ppc440spe ADMA */
+struct list_head
+ppc440spe_adma_chan_list =3D LIST_HEAD_INIT(ppc440spe_adma_chan_list);
+
+/* This flag is set when want to refetch the xor chain in the interrupt
+ * handler
+ */
+static u32 do_xor_refetch;
+
+/* Pointer to DMA0, DMA1 CP/CS FIFO */
+static void *ppc440spe_dma_fifo_buf;
+
+/* Pointers to last submitted to DMA0, DMA1 CDBs */
+static struct ppc440spe_adma_desc_slot *chan_last_sub[3];
+static struct ppc440spe_adma_desc_slot *chan_first_cdb[3];
+
+/* Pointer to last linked and submitted xor CB */
+static struct ppc440spe_adma_desc_slot *xor_last_linked;
+static struct ppc440spe_adma_desc_slot *xor_last_submit;
+
+/* This array is used in data-check operations for storing a pattern */
+static char ppc440spe_qword[16];
+
+static atomic_t ppc440spe_adma_err_irq_ref;
+static dcr_host_t ppc440spe_mq_dcr_host;
+static unsigned int ppc440spe_mq_dcr_len;
+
+/* Since RXOR operations use the common register (MQ0_CF2H) for
setting-up
+ * the block size in transactions, then we do not allow to activate
more than
+ * only one RXOR transactions simultaneously. So use this var to store
+ * the information about is RXOR currently active (PPC440SPE_RXOR_RUN
bit is
+ * set) or not (PPC440SPE_RXOR_RUN is clear).
+ */
+static unsigned long ppc440spe_rxor_state;
+
+/* These are used in enable & check routines
+ */
+static u32 ppc440spe_r6_enabled;
+static struct ppc440spe_adma_chan *ppc440spe_r6_tchan;
+static struct completion ppc440spe_r6_test_comp;
+
+static int ppc440spe_adma_dma2rxor_prep_src(
+		struct ppc440spe_adma_desc_slot *desc,
+		struct ppc440spe_rxor *cursor, int index,
+		int src_cnt, u32 addr);
+static void ppc440spe_adma_dma2rxor_set_src(
+		struct ppc440spe_adma_desc_slot *desc,
+		int index, dma_addr_t addr);
+static void ppc440spe_adma_dma2rxor_set_mult(
+		struct ppc440spe_adma_desc_slot *desc,
+		int index, u8 mult);
+
+#ifdef ADMA_LL_DEBUG
+#define ADMA_LL_DBG(x) ({ if (1) x; 0; })
+#else
+#define ADMA_LL_DBG(x) ({ if (0) x; 0; })
+#endif
+
+static void print_cb(struct ppc440spe_adma_chan *chan, void *block)
+{
+	struct dma_cdb *cdb;
+	struct xor_cb *cb;
+	int i;
+
+	switch (chan->device->id) {
+	case 0:
+	case 1:
+		cdb =3D block;
+
+		pr_debug("CDB at %p [%d]:\n"
+			"\t attr 0x%02x opc 0x%02x cnt 0x%08x\n"
+			"\t sg1u 0x%08x sg1l 0x%08x\n"
+			"\t sg2u 0x%08x sg2l 0x%08x\n"
+			"\t sg3u 0x%08x sg3l 0x%08x\n",
+			cdb, chan->device->id,
+			cdb->attr, cdb->opc, le32_to_cpu(cdb->cnt),
+			le32_to_cpu(cdb->sg1u), le32_to_cpu(cdb->sg1l),
+			le32_to_cpu(cdb->sg2u), le32_to_cpu(cdb->sg2l),
+			le32_to_cpu(cdb->sg3u), le32_to_cpu(cdb->sg3l)
+		);
+		break;
+	case 2:
+		cb =3D block;
+
+		pr_debug("CB at %p [%d]:\n"
+			"\t cbc 0x%08x cbbc 0x%08x cbs 0x%08x\n"
+			"\t cbtah 0x%08x cbtal 0x%08x\n"
+			"\t cblah 0x%08x cblal 0x%08x\n",
+			cb, chan->device->id,
+			cb->cbc, cb->cbbc, cb->cbs,
+			cb->cbtah, cb->cbtal,
+			cb->cblah, cb->cblal);
+		for (i =3D 0; i < 16; i++) {
+			if (i && !cb->ops[i].h && !cb->ops[i].l)
+				continue;
+			pr_debug("\t ops[%2d]: h 0x%08x l 0x%08x\n",
+				i, cb->ops[i].h, cb->ops[i].l);
+		}
+		break;
+	}
+}
+
+static void print_cb_list(struct ppc440spe_adma_chan *chan,
+			  struct ppc440spe_adma_desc_slot *iter)
+{
+	for (; iter; iter =3D iter->hw_next)
+		print_cb(chan, iter->hw_desc);
+}
+
+static void prep_dma_xor_dbg(int id, dma_addr_t dst, dma_addr_t *src,
+			     unsigned int src_cnt)
+{
+	int i;
+
+	pr_debug("\n%s(%d):\nsrc: ", __func__, id);
+	for (i =3D 0; i < src_cnt; i++)
+		pr_debug("\t0x%016llx ", src[i]);
+	pr_debug("dst:\n\t0x%016llx\n", dst);
+}
+
+static void prep_dma_pq_dbg(int id, dma_addr_t *dst, dma_addr_t *src,
+			    unsigned int src_cnt)
+{
+	int i;
+
+	pr_debug("\n%s(%d):\nsrc: ", __func__, id);
+	for (i =3D 0; i < src_cnt; i++)
+		pr_debug("\t0x%016llx ", src[i]);
+	pr_debug("dst: ");
+	for (i =3D 0; i < 2; i++)
+		pr_debug("\t0x%016llx ", dst[i]);
+}
+
+static void prep_dma_pqzero_sum_dbg(int id, dma_addr_t *src,
+				    unsigned int src_cnt,
+				    const unsigned char *scf)
+{
+	int i;
+
+	pr_debug("\n%s(%d):\nsrc(coef): ", __func__, id);
+	if (scf) {
+		for (i =3D 0; i < src_cnt; i++)
+			pr_debug("\t0x%016llx(0x%02x) ", src[i],
scf[i]);
+	} else {
+		for (i =3D 0; i < src_cnt; i++)
+			pr_debug("\t0x%016llx(no) ", src[i]);
+	}
+
+	pr_debug("dst: ");
+	for (i =3D 0; i < 2; i++)
+		pr_debug("\t0x%016llx ", src[src_cnt + i]);
+}
+
+/**********************************************************************
********
+ * Command (Descriptor) Blocks low-level routines
+
************************************************************************
******/
+/**
+ * ppc440spe_desc_init_interrupt - initialize the descriptor for
INTERRUPT
+ * pseudo operation
+ */
+static void ppc440spe_desc_init_interrupt(struct
ppc440spe_adma_desc_slot *desc,
+					  struct ppc440spe_adma_chan
*chan)
+{
+	struct xor_cb *p;
+
+	switch (chan->device->id) {
+	case PPC440SPE_XOR_ID:
+		p =3D desc->hw_desc;
+		memset(desc->hw_desc, 0, sizeof(struct xor_cb));
+		/* NOP with Command Block Complete Enable */
+		p->cbc =3D XOR_CBCR_CBCE_BIT;
+		break;
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		memset(desc->hw_desc, 0, sizeof(struct dma_cdb));
+		/* NOP with interrupt */
+		set_bit(PPC440SPE_DESC_INT, &desc->flags);
+		break;
+	default:
+		printk(KERN_ERR "Unsupported id %d in %s\n",
chan->device->id,
+				__func__);
+		break;
+	}
+}
+
+/**
+ * ppc440spe_desc_init_null_xor - initialize the descriptor for NULL
XOR
+ * pseudo operation
+ */
+static void ppc440spe_desc_init_null_xor(struct
ppc440spe_adma_desc_slot *desc)
+{
+	memset(desc->hw_desc, 0, sizeof(struct xor_cb));
+	desc->hw_next =3D NULL;
+	desc->src_cnt =3D 0;
+	desc->dst_cnt =3D 1;
+}
+
+/**
+ * ppc440spe_desc_init_xor - initialize the descriptor for XOR
operation
+ */
+static void ppc440spe_desc_init_xor(struct ppc440spe_adma_desc_slot
*desc,
+					 int src_cnt, unsigned long
flags)
+{
+	struct xor_cb *hw_desc =3D desc->hw_desc;
+
+	memset(desc->hw_desc, 0, sizeof(struct xor_cb));
+	desc->hw_next =3D NULL;
+	desc->src_cnt =3D src_cnt;
+	desc->dst_cnt =3D 1;
+
+	hw_desc->cbc =3D XOR_CBCR_TGT_BIT | src_cnt;
+	if (flags & DMA_PREP_INTERRUPT)
+		/* Enable interrupt on completion */
+		hw_desc->cbc |=3D XOR_CBCR_CBCE_BIT;
+}
+
+/**
+ * ppc440spe_desc_init_dma2pq - initialize the descriptor for PQ
+ * operation in DMA2 controller
+ */
+static void ppc440spe_desc_init_dma2pq(struct ppc440spe_adma_desc_slot
*desc,
+		int dst_cnt, int src_cnt, unsigned long flags)
+{
+	struct xor_cb *hw_desc =3D desc->hw_desc;
+
+	memset(desc->hw_desc, 0, sizeof(struct xor_cb));
+	desc->hw_next =3D NULL;
+	desc->src_cnt =3D src_cnt;
+	desc->dst_cnt =3D dst_cnt;
+	memset(desc->reverse_flags, 0, sizeof(desc->reverse_flags));
+	desc->descs_per_op =3D 0;
+
+	hw_desc->cbc =3D XOR_CBCR_TGT_BIT;
+	if (flags & DMA_PREP_INTERRUPT)
+		/* Enable interrupt on completion */
+		hw_desc->cbc |=3D XOR_CBCR_CBCE_BIT;
+}
+
+#define DMA_CTRL_FLAGS_LAST	DMA_PREP_FENCE
+#define DMA_PREP_ZERO_P		(DMA_CTRL_FLAGS_LAST << 1)
+#define DMA_PREP_ZERO_Q		(DMA_PREP_ZERO_P << 1)
+
+/**
+ * ppc440spe_desc_init_dma01pq - initialize the descriptors for PQ
operation
+ * with DMA0/1
+ */
+static void ppc440spe_desc_init_dma01pq(struct ppc440spe_adma_desc_slot
*desc,
+				int dst_cnt, int src_cnt, unsigned long
flags,
+				unsigned long op)
+{
+	struct dma_cdb *hw_desc;
+	struct ppc440spe_adma_desc_slot *iter;
+	u8 dopc;
+
+	/* Common initialization of a PQ descriptors chain */
+	set_bits(op, &desc->flags);
+	desc->src_cnt =3D src_cnt;
+	desc->dst_cnt =3D dst_cnt;
+
+	/* WXOR MULTICAST if both P and Q are being computed
+	 * MV_SG1_SG2 if Q only
+	 */
+	dopc =3D (desc->dst_cnt =3D=3D DMA_DEST_MAX_NUM) ?
+		DMA_CDB_OPC_MULTICAST : DMA_CDB_OPC_MV_SG1_SG2;
+
+	list_for_each_entry(iter, &desc->group_list, chain_node) {
+		hw_desc =3D iter->hw_desc;
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+
+		if (likely(!list_is_last(&iter->chain_node,
+				&desc->group_list))) {
+			/* set 'next' pointer */
+			iter->hw_next =3D
list_entry(iter->chain_node.next,
+				struct ppc440spe_adma_desc_slot,
chain_node);
+			clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+		} else {
+			/* this is the last descriptor.
+			 * this slot will be pasted from ADMA level
+			 * each time it wants to configure parameters
+			 * of the transaction (src, dst, ...)
+			 */
+			iter->hw_next =3D NULL;
+			if (flags & DMA_PREP_INTERRUPT)
+				set_bit(PPC440SPE_DESC_INT,
&iter->flags);
+			else
+				clear_bit(PPC440SPE_DESC_INT,
&iter->flags);
+		}
+	}
+
+	/* Set OPS depending on WXOR/RXOR type of operation */
+	if (!test_bit(PPC440SPE_DESC_RXOR, &desc->flags)) {
+		/* This is a WXOR only chain:
+		 * - first descriptors are for zeroing destinations
+		 *   if PPC440SPE_ZERO_P/Q set;
+		 * - descriptors remained are for GF-XOR operations.
+		 */
+		iter =3D list_first_entry(&desc->group_list,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+
+		if (test_bit(PPC440SPE_ZERO_P, &desc->flags)) {
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+			iter =3D list_first_entry(&iter->chain_node,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		}
+
+		if (test_bit(PPC440SPE_ZERO_Q, &desc->flags)) {
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+			iter =3D list_first_entry(&iter->chain_node,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		}
+
+		list_for_each_entry_from(iter, &desc->group_list,
chain_node) {
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D dopc;
+		}
+	} else {
+		/* This is either RXOR-only or mixed RXOR/WXOR */
+
+		/* The first 1 or 2 slots in chain are always RXOR,
+		 * if need to calculate P & Q, then there are two
+		 * RXOR slots; if only P or only Q, then there is one
+		 */
+		iter =3D list_first_entry(&desc->group_list,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+
+		if (desc->dst_cnt =3D=3D DMA_DEST_MAX_NUM) {
+			iter =3D list_first_entry(&iter->chain_node,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+		}
+
+		/* The remaining descs (if any) are WXORs */
+		if (test_bit(PPC440SPE_DESC_WXOR, &desc->flags)) {
+			iter =3D list_first_entry(&iter->chain_node,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			list_for_each_entry_from(iter,
&desc->group_list,
+						chain_node) {
+				hw_desc =3D iter->hw_desc;
+				hw_desc->opc =3D dopc;
+			}
+		}
+	}
+}
+
+/**
+ * ppc440spe_desc_init_dma01pqzero_sum - initialize the descriptor
+ * for PQ_ZERO_SUM operation
+ */
+static void ppc440spe_desc_init_dma01pqzero_sum(
+				struct ppc440spe_adma_desc_slot *desc,
+				int dst_cnt, int src_cnt)
+{
+	struct dma_cdb *hw_desc;
+	struct ppc440spe_adma_desc_slot *iter;
+	int i =3D 0;
+	u8 dopc =3D (dst_cnt =3D=3D 2) ? DMA_CDB_OPC_MULTICAST :
+				   DMA_CDB_OPC_MV_SG1_SG2;
+	/*
+	 * Initialize starting from 2nd or 3rd descriptor dependent
+	 * on dst_cnt. First one or two slots are for cloning P
+	 * and/or Q to chan->pdest and/or chan->qdest as we have
+	 * to preserve original P/Q.
+	 */
+	iter =3D list_first_entry(&desc->group_list,
+				struct ppc440spe_adma_desc_slot,
chain_node);
+	iter =3D list_entry(iter->chain_node.next,
+			  struct ppc440spe_adma_desc_slot, chain_node);
+
+	if (dst_cnt > 1) {
+		iter =3D list_entry(iter->chain_node.next,
+				  struct ppc440spe_adma_desc_slot,
chain_node);
+	}
+	/* initialize each source descriptor in chain */
+	list_for_each_entry_from(iter, &desc->group_list, chain_node) {
+		hw_desc =3D iter->hw_desc;
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		iter->src_cnt =3D 0;
+		iter->dst_cnt =3D 0;
+
+		/* This is a ZERO_SUM operation:
+		 * - <src_cnt> descriptors starting from 2nd or 3rd
+		 *   descriptor are for GF-XOR operations;
+		 * - remaining <dst_cnt> descriptors are for checking
the result
+		 */
+		if (i++ < src_cnt)
+			/* MV_SG1_SG2 if only Q is being verified
+			 * MULTICAST if both P and Q are being verified
+			 */
+			hw_desc->opc =3D dopc;
+		else
+			/* DMA_CDB_OPC_DCHECK128 operation */
+			hw_desc->opc =3D DMA_CDB_OPC_DCHECK128;
+
+		if (likely(!list_is_last(&iter->chain_node,
+					 &desc->group_list))) {
+			/* set 'next' pointer */
+			iter->hw_next =3D
list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+		} else {
+			/* this is the last descriptor.
+			 * this slot will be pasted from ADMA level
+			 * each time it wants to configure parameters
+			 * of the transaction (src, dst, ...)
+			 */
+			iter->hw_next =3D NULL;
+			/* always enable interrupt generation since we
get
+			 * the status of pqzero from the handler
+			 */
+			set_bit(PPC440SPE_DESC_INT, &iter->flags);
+		}
+	}
+	desc->src_cnt =3D src_cnt;
+	desc->dst_cnt =3D dst_cnt;
+}
+
+/**
+ * ppc440spe_desc_init_memcpy - initialize the descriptor for MEMCPY
operation
+ */
+static void ppc440spe_desc_init_memcpy(struct ppc440spe_adma_desc_slot
*desc,
+					unsigned long flags)
+{
+	struct dma_cdb *hw_desc =3D desc->hw_desc;
+
+	memset(desc->hw_desc, 0, sizeof(struct dma_cdb));
+	desc->hw_next =3D NULL;
+	desc->src_cnt =3D 1;
+	desc->dst_cnt =3D 1;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		set_bit(PPC440SPE_DESC_INT, &desc->flags);
+	else
+		clear_bit(PPC440SPE_DESC_INT, &desc->flags);
+
+	hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+}
+
+/**
+ * ppc440spe_desc_init_memset - initialize the descriptor for MEMSET
operation
+ */
+static void ppc440spe_desc_init_memset(struct ppc440spe_adma_desc_slot
*desc,
+					int value, unsigned long flags)
+{
+	struct dma_cdb *hw_desc =3D desc->hw_desc;
+
+	memset(desc->hw_desc, 0, sizeof(struct dma_cdb));
+	desc->hw_next =3D NULL;
+	desc->src_cnt =3D 1;
+	desc->dst_cnt =3D 1;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		set_bit(PPC440SPE_DESC_INT, &desc->flags);
+	else
+		clear_bit(PPC440SPE_DESC_INT, &desc->flags);
+
+	hw_desc->sg1u =3D hw_desc->sg1l =3D cpu_to_le32((u32)value);
+	hw_desc->sg3u =3D hw_desc->sg3l =3D cpu_to_le32((u32)value);
+	hw_desc->opc =3D DMA_CDB_OPC_DFILL128;
+}
+
+/**
+ * ppc440spe_desc_set_src_addr - set source address into the descriptor
+ */
+static void ppc440spe_desc_set_src_addr(struct ppc440spe_adma_desc_slot
*desc,
+					struct ppc440spe_adma_chan
*chan,
+					int src_idx, dma_addr_t addrh,
+					dma_addr_t addrl)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+	phys_addr_t addr64, tmplow, tmphi;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		if (!addrh) {
+			addr64 =3D addrl;
+			tmphi =3D (addr64 >> 32);
+			tmplow =3D (addr64 & 0xFFFFFFFF);
+		} else {
+			tmphi =3D addrh;
+			tmplow =3D addrl;
+		}
+		dma_hw_desc =3D desc->hw_desc;
+		dma_hw_desc->sg1l =3D cpu_to_le32((u32)tmplow);
+		dma_hw_desc->sg1u |=3D cpu_to_le32((u32)tmphi);
+		break;
+	case PPC440SPE_XOR_ID:
+		xor_hw_desc =3D desc->hw_desc;
+		xor_hw_desc->ops[src_idx].l =3D addrl;
+		xor_hw_desc->ops[src_idx].h |=3D addrh;
+		break;
+	}
+}
+
+/**
+ * ppc440spe_desc_set_src_mult - set source address mult into the
descriptor
+ */
+static void ppc440spe_desc_set_src_mult(struct ppc440spe_adma_desc_slot
*desc,
+			struct ppc440spe_adma_chan *chan, u32
mult_index,
+			int sg_index, unsigned char mult_value)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+	u32 *psgu;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+
+		switch (sg_index) {
+		/* for RXOR operations set multiplier
+		 * into source cued address
+		 */
+		case DMA_CDB_SG_SRC:
+			psgu =3D &dma_hw_desc->sg1u;
+			break;
+		/* for WXOR operations set multiplier
+		 * into destination cued address(es)
+		 */
+		case DMA_CDB_SG_DST1:
+			psgu =3D &dma_hw_desc->sg2u;
+			break;
+		case DMA_CDB_SG_DST2:
+			psgu =3D &dma_hw_desc->sg3u;
+			break;
+		default:
+			BUG();
+		}
+
+		*psgu |=3D cpu_to_le32(mult_value << mult_index);
+		break;
+	case PPC440SPE_XOR_ID:
+		xor_hw_desc =3D desc->hw_desc;
+		break;
+	default:
+		BUG();
+	}
+}
+
+/**
+ * ppc440spe_desc_set_dest_addr - set destination address into the
descriptor
+ */
+static void ppc440spe_desc_set_dest_addr(struct
ppc440spe_adma_desc_slot *desc,
+				struct ppc440spe_adma_chan *chan,
+				dma_addr_t addrh, dma_addr_t addrl,
+				u32 dst_idx)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+	phys_addr_t addr64, tmphi, tmplow;
+	u32 *psgu, *psgl;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		if (!addrh) {
+			addr64 =3D addrl;
+			tmphi =3D (addr64 >> 32);
+			tmplow =3D (addr64 & 0xFFFFFFFF);
+		} else {
+			tmphi =3D addrh;
+			tmplow =3D addrl;
+		}
+		dma_hw_desc =3D desc->hw_desc;
+
+		psgu =3D dst_idx ? &dma_hw_desc->sg3u :
&dma_hw_desc->sg2u;
+		psgl =3D dst_idx ? &dma_hw_desc->sg3l :
&dma_hw_desc->sg2l;
+
+		*psgl =3D cpu_to_le32((u32)tmplow);
+		*psgu |=3D cpu_to_le32((u32)tmphi);
+		break;
+	case PPC440SPE_XOR_ID:
+		xor_hw_desc =3D desc->hw_desc;
+		xor_hw_desc->cbtal =3D addrl;
+		xor_hw_desc->cbtah |=3D addrh;
+		break;
+	}
+}
+
+/**
+ * ppc440spe_desc_set_byte_count - set number of data bytes involved
+ * into the operation
+ */
+static void ppc440spe_desc_set_byte_count(struct
ppc440spe_adma_desc_slot *desc,
+				struct ppc440spe_adma_chan *chan,
+				u32 byte_count)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+		dma_hw_desc->cnt =3D cpu_to_le32(byte_count);
+		break;
+	case PPC440SPE_XOR_ID:
+		xor_hw_desc =3D desc->hw_desc;
+		xor_hw_desc->cbbc =3D byte_count;
+		break;
+	}
+}
+
+/**
+ * ppc440spe_desc_set_rxor_block_size - set RXOR block size
+ */
+static inline void ppc440spe_desc_set_rxor_block_size(u32 byte_count)
+{
+	/* assume that byte_count is aligned on the 512-boundary;
+	 * thus write it directly to the register (bits 23:31 are
+	 * reserved there).
+	 */
+	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_CF2H, byte_count);
+}
+
+/**
+ * ppc440spe_desc_set_dcheck - set CHECK pattern
+ */
+static void ppc440spe_desc_set_dcheck(struct ppc440spe_adma_desc_slot
*desc,
+				struct ppc440spe_adma_chan *chan, u8
*qword)
+{
+	struct dma_cdb *dma_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+		iowrite32(qword[0], &dma_hw_desc->sg3l);
+		iowrite32(qword[4], &dma_hw_desc->sg3u);
+		iowrite32(qword[8], &dma_hw_desc->sg2l);
+		iowrite32(qword[12], &dma_hw_desc->sg2u);
+		break;
+	default:
+		BUG();
+	}
+}
+
+/**
+ * ppc440spe_xor_set_link - set link address in xor CB
+ */
+static void ppc440spe_xor_set_link(struct ppc440spe_adma_desc_slot
*prev_desc,
+				struct ppc440spe_adma_desc_slot
*next_desc)
+{
+	struct xor_cb *xor_hw_desc =3D prev_desc->hw_desc;
+
+	if (unlikely(!next_desc || !(next_desc->phys))) {
+		printk(KERN_ERR "%s: next_desc=3D0x%p;
next_desc->phys=3D0x%llx\n",
+			__func__, next_desc,
+			next_desc ? next_desc->phys : 0);
+		BUG();
+	}
+
+	xor_hw_desc->cbs =3D 0;
+	xor_hw_desc->cblal =3D next_desc->phys;
+	xor_hw_desc->cblah =3D 0;
+	xor_hw_desc->cbc |=3D XOR_CBCR_LNK_BIT;
+}
+
+/**
+ * ppc440spe_desc_set_link - set the address of descriptor following
this
+ * descriptor in chain
+ */
+static void ppc440spe_desc_set_link(struct ppc440spe_adma_chan *chan,
+				struct ppc440spe_adma_desc_slot
*prev_desc,
+				struct ppc440spe_adma_desc_slot
*next_desc)
+{
+	unsigned long flags;
+	struct ppc440spe_adma_desc_slot *tail =3D next_desc;
+
+	if (unlikely(!prev_desc || !next_desc ||
+		(prev_desc->hw_next && prev_desc->hw_next !=3D
next_desc))) {
+		/* If previous next is overwritten something is wrong.
+		 * though we may refetch from append to initiate list
+		 * processing; in this case - it's ok.
+		 */
+		printk(KERN_ERR "%s: prev_desc=3D0x%p; next_desc=3D0x%p; "
+			"prev->hw_next=3D0x%p\n", __func__, prev_desc,
+			next_desc, prev_desc ? prev_desc->hw_next : 0);
+		BUG();
+	}
+
+	local_irq_save(flags);
+
+	/* do s/w chaining both for DMA and XOR descriptors */
+	prev_desc->hw_next =3D next_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		break;
+	case PPC440SPE_XOR_ID:
+		/* bind descriptor to the chain */
+		while (tail->hw_next)
+			tail =3D tail->hw_next;
+		xor_last_linked =3D tail;
+
+		if (prev_desc =3D=3D xor_last_submit)
+			/* do not link to the last submitted CB */
+			break;
+		ppc440spe_xor_set_link(prev_desc, next_desc);
+		break;
+	}
+
+	local_irq_restore(flags);
+}
+
+/**
+ * ppc440spe_desc_get_src_addr - extract the source address from the
descriptor
+ */
+static u32 ppc440spe_desc_get_src_addr(struct ppc440spe_adma_desc_slot
*desc,
+				struct ppc440spe_adma_chan *chan, int
src_idx)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+		/* May have 0, 1, 2, or 3 sources */
+		switch (dma_hw_desc->opc) {
+		case DMA_CDB_OPC_NO_OP:
+		case DMA_CDB_OPC_DFILL128:
+			return 0;
+		case DMA_CDB_OPC_DCHECK128:
+			if (unlikely(src_idx)) {
+				printk(KERN_ERR "%s: try to get %d
source for"
+				    " DCHECK128\n", __func__, src_idx);
+				BUG();
+			}
+			return le32_to_cpu(dma_hw_desc->sg1l);
+		case DMA_CDB_OPC_MULTICAST:
+		case DMA_CDB_OPC_MV_SG1_SG2:
+			if (unlikely(src_idx > 2)) {
+				printk(KERN_ERR "%s: try to get %d
source from"
+				    " DMA descr\n", __func__, src_idx);
+				BUG();
+			}
+			if (src_idx) {
+				if (le32_to_cpu(dma_hw_desc->sg1u) &
+				    DMA_CUED_XOR_WIN_MSK) {
+					u8 region;
+
+					if (src_idx =3D=3D 1)
+						return le32_to_cpu(
+						    dma_hw_desc->sg1l) +
+							desc->unmap_len;
+
+					region =3D (le32_to_cpu(
+					    dma_hw_desc->sg1u)) >>
+						DMA_CUED_REGION_OFF;
+
+					region &=3D DMA_CUED_REGION_MSK;
+					switch (region) {
+					case DMA_RXOR123:
+						return le32_to_cpu(
+						    dma_hw_desc->sg1l) +
+							(desc->unmap_len
<< 1);
+					case DMA_RXOR124:
+						return le32_to_cpu(
+						    dma_hw_desc->sg1l) +
+							(desc->unmap_len
* 3);
+					case DMA_RXOR125:
+						return le32_to_cpu(
+						    dma_hw_desc->sg1l) +
+							(desc->unmap_len
<< 2);
+					default:
+						printk(KERN_ERR
+						    "%s: try to"
+						    " get src3 for
region %02x"
+
"PPC440SPE_DESC_RXOR12?\n",
+						    __func__, region);
+						BUG();
+					}
+				} else {
+					printk(KERN_ERR
+						"%s: try to get %d"
+						" source for non-cued
descr\n",
+						__func__, src_idx);
+					BUG();
+				}
+			}
+			return le32_to_cpu(dma_hw_desc->sg1l);
+		default:
+			printk(KERN_ERR "%s: unknown OPC 0x%02x\n",
+				__func__, dma_hw_desc->opc);
+			BUG();
+		}
+		return le32_to_cpu(dma_hw_desc->sg1l);
+	case PPC440SPE_XOR_ID:
+		/* May have up to 16 sources */
+		xor_hw_desc =3D desc->hw_desc;
+		return xor_hw_desc->ops[src_idx].l;
+	}
+	return 0;
+}
+
+/**
+ * ppc440spe_desc_get_dest_addr - extract the destination address from
the
+ * descriptor
+ */
+static u32 ppc440spe_desc_get_dest_addr(struct ppc440spe_adma_desc_slot
*desc,
+				struct ppc440spe_adma_chan *chan, int
idx)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+
+		if (likely(!idx))
+			return le32_to_cpu(dma_hw_desc->sg2l);
+		return le32_to_cpu(dma_hw_desc->sg3l);
+	case PPC440SPE_XOR_ID:
+		xor_hw_desc =3D desc->hw_desc;
+		return xor_hw_desc->cbtal;
+	}
+	return 0;
+}
+
+/**
+ * ppc440spe_desc_get_src_num - extract the number of source addresses
from
+ * the descriptor
+ */
+static u32 ppc440spe_desc_get_src_num(struct ppc440spe_adma_desc_slot
*desc,
+				struct ppc440spe_adma_chan *chan)
+{
+	struct dma_cdb *dma_hw_desc;
+	struct xor_cb *xor_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_hw_desc =3D desc->hw_desc;
+
+		switch (dma_hw_desc->opc) {
+		case DMA_CDB_OPC_NO_OP:
+		case DMA_CDB_OPC_DFILL128:
+			return 0;
+		case DMA_CDB_OPC_DCHECK128:
+			return 1;
+		case DMA_CDB_OPC_MV_SG1_SG2:
+		case DMA_CDB_OPC_MULTICAST:
+			/*
+			 * Only for RXOR operations we have more than
+			 * one source
+			 */
+			if (le32_to_cpu(dma_hw_desc->sg1u) &
+			    DMA_CUED_XOR_WIN_MSK) {
+				/* RXOR op, there are 2 or 3 sources */
+				if (((le32_to_cpu(dma_hw_desc->sg1u) >>
+				    DMA_CUED_REGION_OFF) &
+				      DMA_CUED_REGION_MSK) =3D=3D
DMA_RXOR12) {
+					/* RXOR 1-2 */
+					return 2;
+				} else {
+					/* RXOR 1-2-3/1-2-4/1-2-5 */
+					return 3;
+				}
+			}
+			return 1;
+		default:
+			printk(KERN_ERR "%s: unknown OPC 0x%02x\n",
+				__func__, dma_hw_desc->opc);
+			BUG();
+		}
+	case PPC440SPE_XOR_ID:
+		/* up to 16 sources */
+		xor_hw_desc =3D desc->hw_desc;
+		return xor_hw_desc->cbc & XOR_CDCR_OAC_MSK;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+/**
+ * ppc440spe_desc_get_dst_num - get the number of destination addresses
in
+ * this descriptor
+ */
+static u32 ppc440spe_desc_get_dst_num(struct ppc440spe_adma_desc_slot
*desc,
+				struct ppc440spe_adma_chan *chan)
+{
+	struct dma_cdb *dma_hw_desc;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* May be 1 or 2 destinations */
+		dma_hw_desc =3D desc->hw_desc;
+		switch (dma_hw_desc->opc) {
+		case DMA_CDB_OPC_NO_OP:
+		case DMA_CDB_OPC_DCHECK128:
+			return 0;
+		case DMA_CDB_OPC_MV_SG1_SG2:
+		case DMA_CDB_OPC_DFILL128:
+			return 1;
+		case DMA_CDB_OPC_MULTICAST:
+			if (desc->dst_cnt =3D=3D 2)
+				return 2;
+			else
+				return 1;
+		default:
+			printk(KERN_ERR "%s: unknown OPC 0x%02x\n",
+				__func__, dma_hw_desc->opc);
+			BUG();
+		}
+	case PPC440SPE_XOR_ID:
+		/* Always only 1 destination */
+		return 1;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+/**
+ * ppc440spe_desc_get_link - get the address of the descriptor that
+ * follows this one
+ */
+static inline u32 ppc440spe_desc_get_link(struct
ppc440spe_adma_desc_slot *desc,
+					struct ppc440spe_adma_chan
*chan)
+{
+	if (!desc->hw_next)
+		return 0;
+
+	return desc->hw_next->phys;
+}
+
+/**
+ * ppc440spe_desc_is_aligned - check alignment
+ */
+static inline int ppc440spe_desc_is_aligned(
+	struct ppc440spe_adma_desc_slot *desc, int num_slots)
+{
+	return (desc->idx & (num_slots - 1)) ? 0 : 1;
+}
+
+/**
+ * ppc440spe_chan_xor_slot_count - get the number of slots necessary
for
+ * XOR operation
+ */
+static int ppc440spe_chan_xor_slot_count(size_t len, int src_cnt,
+			int *slots_per_op)
+{
+	int slot_cnt;
+
+	/* each XOR descriptor provides up to 16 source operands */
+	slot_cnt =3D *slots_per_op =3D (src_cnt + XOR_MAX_OPS -
1)/XOR_MAX_OPS;
+
+	if (likely(len <=3D PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT))
+		return slot_cnt;
+
+	printk(KERN_ERR "%s: len %d > max %d !!\n",
+		__func__, len, PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT);
+	BUG();
+	return slot_cnt;
+}
+
+/**
+ * ppc440spe_dma2_pq_slot_count - get the number of slots necessary for
+ * DMA2 PQ operation
+ */
+static int ppc440spe_dma2_pq_slot_count(dma_addr_t *srcs,
+		int src_cnt, size_t len)
+{
+	signed long long order =3D 0;
+	int state =3D 0;
+	int addr_count =3D 0;
+	int i;
+	for (i =3D 1; i < src_cnt; i++) {
+		dma_addr_t cur_addr =3D srcs[i];
+		dma_addr_t old_addr =3D srcs[i-1];
+		switch (state) {
+		case 0:
+			if (cur_addr =3D=3D old_addr + len) {
+				/* direct RXOR */
+				order =3D 1;
+				state =3D 1;
+				if (i =3D=3D src_cnt-1)
+					addr_count++;
+			} else if (old_addr =3D=3D cur_addr + len) {
+				/* reverse RXOR */
+				order =3D -1;
+				state =3D 1;
+				if (i =3D=3D src_cnt-1)
+					addr_count++;
+			} else {
+				state =3D 3;
+			}
+			break;
+		case 1:
+			if (i =3D=3D src_cnt-2 || (order =3D=3D -1
+				&& cur_addr !=3D old_addr - len)) {
+				order =3D 0;
+				state =3D 0;
+				addr_count++;
+			} else if (cur_addr =3D=3D old_addr + len*order) {
+				state =3D 2;
+				if (i =3D=3D src_cnt-1)
+					addr_count++;
+			} else if (cur_addr =3D=3D old_addr + 2*len) {
+				state =3D 2;
+				if (i =3D=3D src_cnt-1)
+					addr_count++;
+			} else if (cur_addr =3D=3D old_addr + 3*len) {
+				state =3D 2;
+				if (i =3D=3D src_cnt-1)
+					addr_count++;
+			} else {
+				order =3D 0;
+				state =3D 0;
+				addr_count++;
+			}
+			break;
+		case 2:
+			order =3D 0;
+			state =3D 0;
+			addr_count++;
+				break;
+		}
+		if (state =3D=3D 3)
+			break;
+	}
+	if (src_cnt <=3D 1 || (state !=3D 1 && state !=3D 2)) {
+		pr_err("%s: src_cnt=3D%d, state=3D%d, addr_count=3D%d,
order=3D%lld\n",
+			__func__, src_cnt, state, addr_count, order);
+		for (i =3D 0; i < src_cnt; i++)
+			pr_err("\t[%d] 0x%llx \n", i, srcs[i]);
+		BUG();
+	}
+
+	return (addr_count + XOR_MAX_OPS - 1) / XOR_MAX_OPS;
+}
+
+
+/**********************************************************************
********
+ * ADMA channel low-level routines
+
************************************************************************
******/
+
+static u32
+ppc440spe_chan_get_current_descriptor(struct ppc440spe_adma_chan
*chan);
+static void ppc440spe_chan_append(struct ppc440spe_adma_chan *chan);
+
+/**
+ * ppc440spe_adma_device_clear_eot_status - interrupt ack to XOR or DMA
engine
+ */
+static void ppc440spe_adma_device_clear_eot_status(
+					struct ppc440spe_adma_chan
*chan)
+{
+	struct dma_regs *dma_reg;
+	struct xor_regs *xor_reg;
+	u8 *p =3D chan->device->dma_desc_pool_virt;
+	struct dma_cdb *cdb;
+	u32 rv, i;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* read FIFO to ack */
+		dma_reg =3D chan->device->dma_reg;
+		while ((rv =3D ioread32(&dma_reg->csfpl))) {
+			i =3D rv & DMA_CDB_ADDR_MSK;
+			cdb =3D (struct dma_cdb *)&p[i -
+			    (u32)chan->device->dma_desc_pool];
+
+			/* Clear opcode to ack. This is necessary for
+			 * ZeroSum operations only
+			 */
+			cdb->opc =3D 0;
+
+			if (test_bit(PPC440SPE_RXOR_RUN,
+			    &ppc440spe_rxor_state)) {
+				/* probably this is a completed RXOR op,
+				 * get pointer to CDB using the fact
that
+				 * physical and virtual addresses of CDB
+				 * in pools have the same offsets
+				 */
+				if (le32_to_cpu(cdb->sg1u) &
+				    DMA_CUED_XOR_BASE) {
+					/* this is a RXOR */
+					clear_bit(PPC440SPE_RXOR_RUN,
+
&ppc440spe_rxor_state);
+				}
+			}
+
+			if (rv & DMA_CDB_STATUS_MSK) {
+				/* ZeroSum check failed
+				 */
+				struct ppc440spe_adma_desc_slot *iter;
+				dma_addr_t phys =3D rv & ~DMA_CDB_MSK;
+
+				/*
+				 * Update the status of corresponding
+				 * descriptor.
+				 */
+				list_for_each_entry(iter, &chan->chain,
+				    chain_node) {
+					if (iter->phys =3D=3D phys)
+						break;
+				}
+				/*
+				 * if cannot find the corresponding
+				 * slot it's a bug
+				 */
+				BUG_ON(&iter->chain_node =3D=3D
&chan->chain);
+
+				if (iter->xor_check_result) {
+					if
(test_bit(PPC440SPE_DESC_PCHECK,
+						     &iter->flags)) {
+						*iter->xor_check_result
|=3D
+
SUM_CHECK_P_RESULT;
+					} else
+					if
(test_bit(PPC440SPE_DESC_QCHECK,
+						     &iter->flags)) {
+						*iter->xor_check_result
|=3D
+
SUM_CHECK_Q_RESULT;
+					} else
+						BUG();
+				}
+			}
+		}
+
+		rv =3D ioread32(&dma_reg->dsts);
+		if (rv) {
+			pr_err("DMA%d err status: 0x%x\n",
+			       chan->device->id, rv);
+			/* write back to clear */
+			iowrite32(rv, &dma_reg->dsts);
+		}
+		break;
+	case PPC440SPE_XOR_ID:
+		/* reset status bits to ack */
+		xor_reg =3D chan->device->xor_reg;
+		rv =3D ioread32be(&xor_reg->sr);
+		iowrite32be(rv, &xor_reg->sr);
+
+		if (rv &
(XOR_IE_ICBIE_BIT|XOR_IE_ICIE_BIT|XOR_IE_RPTIE_BIT)) {
+			if (rv & XOR_IE_RPTIE_BIT) {
+				/* Read PLB Timeout Error.
+				 * Try to resubmit the CB
+				 */
+				u32 val =3D ioread32be(&xor_reg->ccbalr);
+
+				iowrite32be(val, &xor_reg->cblalr);
+
+				val =3D ioread32be(&xor_reg->crsr);
+				iowrite32be(val | XOR_CRSR_XAE_BIT,
+					    &xor_reg->crsr);
+			} else
+				pr_err("XOR ERR 0x%x status\n", rv);
+			break;
+		}
+
+		/*  if the XORcore is idle, but there are unprocessed
CBs
+		 * then refetch the s/w chain here
+		 */
+		if (!(ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT) &&
+		    do_xor_refetch)
+			ppc440spe_chan_append(chan);
+		break;
+	}
+}
+
+/**
+ * ppc440spe_chan_is_busy - get the channel status
+ */
+static int ppc440spe_chan_is_busy(struct ppc440spe_adma_chan *chan)
+{
+	struct dma_regs *dma_reg;
+	struct xor_regs *xor_reg;
+	int busy =3D 0;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_reg =3D chan->device->dma_reg;
+		/*  if command FIFO's head and tail pointers are equal
and
+		 * status tail is the same as command, then channel is
free
+		 */
+		if (ioread16(&dma_reg->cpfhp) !=3D
ioread16(&dma_reg->cpftp) ||
+		    ioread16(&dma_reg->cpftp) !=3D
ioread16(&dma_reg->csftp))
+			busy =3D 1;
+		break;
+	case PPC440SPE_XOR_ID:
+		/* use the special status bit for the XORcore
+		 */
+		xor_reg =3D chan->device->xor_reg;
+		busy =3D (ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT) ? 1 :
0;
+		break;
+	}
+
+	return busy;
+}
+
+/**
+ * ppc440spe_chan_set_first_xor_descriptor -  init XORcore chain
+ */
+static void ppc440spe_chan_set_first_xor_descriptor(
+				struct ppc440spe_adma_chan *chan,
+				struct ppc440spe_adma_desc_slot
*next_desc)
+{
+	struct xor_regs *xor_reg =3D chan->device->xor_reg;
+
+	if (ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT)
+		printk(KERN_INFO "%s: Warn: XORcore is running "
+			"when try to set the first CDB!\n",
+			__func__);
+
+	xor_last_submit =3D xor_last_linked =3D next_desc;
+
+	iowrite32be(XOR_CRSR_64BA_BIT, &xor_reg->crsr);
+
+	iowrite32be(next_desc->phys, &xor_reg->cblalr);
+	iowrite32be(0, &xor_reg->cblahr);
+	iowrite32be(ioread32be(&xor_reg->cbcr) | XOR_CBCR_LNK_BIT,
+		    &xor_reg->cbcr);
+
+	chan->hw_chain_inited =3D 1;
+}
+
+/**
+ * ppc440spe_dma_put_desc - put DMA0,1 descriptor to FIFO.
+ * called with irqs disabled
+ */
+static void ppc440spe_dma_put_desc(struct ppc440spe_adma_chan *chan,
+		struct ppc440spe_adma_desc_slot *desc)
+{
+	u32 pcdb;
+	struct dma_regs *dma_reg =3D chan->device->dma_reg;
+
+	pcdb =3D desc->phys;
+	if (!test_bit(PPC440SPE_DESC_INT, &desc->flags))
+		pcdb |=3D DMA_CDB_NO_INT;
+
+	chan_last_sub[chan->device->id] =3D desc;
+
+	ADMA_LL_DBG(print_cb(chan, desc->hw_desc));
+
+	iowrite32(pcdb, &dma_reg->cpfpl);
+}
+
+/**
+ * ppc440spe_chan_append - update the h/w chain in the channel
+ */
+static void ppc440spe_chan_append(struct ppc440spe_adma_chan *chan)
+{
+	struct xor_regs *xor_reg;
+	struct ppc440spe_adma_desc_slot *iter;
+	struct xor_cb *xcb;
+	u32 cur_desc;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		cur_desc =3D ppc440spe_chan_get_current_descriptor(chan);
+
+		if (likely(cur_desc)) {
+			iter =3D chan_last_sub[chan->device->id];
+			BUG_ON(!iter);
+		} else {
+			/* first peer */
+			iter =3D chan_first_cdb[chan->device->id];
+			BUG_ON(!iter);
+			ppc440spe_dma_put_desc(chan, iter);
+			chan->hw_chain_inited =3D 1;
+		}
+
+		/* is there something new to append */
+		if (!iter->hw_next)
+			break;
+
+		/* flush descriptors from the s/w queue to fifo */
+		list_for_each_entry_continue(iter, &chan->chain,
chain_node) {
+			ppc440spe_dma_put_desc(chan, iter);
+			if (!iter->hw_next)
+				break;
+		}
+		break;
+	case PPC440SPE_XOR_ID:
+		/* update h/w links and refetch */
+		if (!xor_last_submit->hw_next)
+			break;
+
+		xor_reg =3D chan->device->xor_reg;
+		/* the last linked CDB has to generate an interrupt
+		 * that we'd be able to append the next lists to h/w
+		 * regardless of the XOR engine state at the moment of
+		 * appending of these next lists
+		 */
+		xcb =3D xor_last_linked->hw_desc;
+		xcb->cbc |=3D XOR_CBCR_CBCE_BIT;
+
+		if (!(ioread32be(&xor_reg->sr) & XOR_SR_XCP_BIT)) {
+			/* XORcore is idle. Refetch now */
+			do_xor_refetch =3D 0;
+			ppc440spe_xor_set_link(xor_last_submit,
+				xor_last_submit->hw_next);
+
+			ADMA_LL_DBG(print_cb_list(chan,
+				xor_last_submit->hw_next));
+
+			xor_last_submit =3D xor_last_linked;
+			iowrite32be(ioread32be(&xor_reg->crsr) |
+				    XOR_CRSR_RCBE_BIT |
XOR_CRSR_64BA_BIT,
+				    &xor_reg->crsr);
+		} else {
+			/* XORcore is running. Refetch later in the
handler */
+			do_xor_refetch =3D 1;
+		}
+
+		break;
+	}
+
+	local_irq_restore(flags);
+}
+
+/**
+ * ppc440spe_chan_get_current_descriptor - get the currently executed
descriptor
+ */
+static u32
+ppc440spe_chan_get_current_descriptor(struct ppc440spe_adma_chan *chan)
+{
+	struct dma_regs *dma_reg;
+	struct xor_regs *xor_reg;
+
+	if (unlikely(!chan->hw_chain_inited))
+		/* h/w descriptor chain is not initialized yet */
+		return 0;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_reg =3D chan->device->dma_reg;
+		return ioread32(&dma_reg->acpl) & (~DMA_CDB_MSK);
+	case PPC440SPE_XOR_ID:
+		xor_reg =3D chan->device->xor_reg;
+		return ioread32be(&xor_reg->ccbalr);
+	}
+	return 0;
+}
+
+/**
+ * ppc440spe_chan_run - enable the channel
+ */
+static void ppc440spe_chan_run(struct ppc440spe_adma_chan *chan)
+{
+	struct xor_regs *xor_reg;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* DMAs are always enabled, do nothing */
+		break;
+	case PPC440SPE_XOR_ID:
+		/* drain write buffer */
+		xor_reg =3D chan->device->xor_reg;
+
+		/* fetch descriptor pointed to in <link> */
+		iowrite32be(XOR_CRSR_64BA_BIT | XOR_CRSR_XAE_BIT,
+			    &xor_reg->crsr);
+		break;
+	}
+}
+
+/**********************************************************************
********
+ * ADMA device level
+
************************************************************************
******/
+
+static void ppc440spe_chan_start_null_xor(struct ppc440spe_adma_chan
*chan);
+static int ppc440spe_adma_alloc_chan_resources(struct dma_chan *chan);
+
+static dma_cookie_t
+ppc440spe_adma_tx_submit(struct dma_async_tx_descriptor *tx);
+
+static void ppc440spe_adma_set_dest(struct ppc440spe_adma_desc_slot
*tx,
+				    dma_addr_t addr, int index);
+static void
+ppc440spe_adma_memcpy_xor_set_src(struct ppc440spe_adma_desc_slot *tx,
+				  dma_addr_t addr, int index);
+
+static void
+ppc440spe_adma_pq_set_dest(struct ppc440spe_adma_desc_slot *tx,
+			   dma_addr_t *paddr, unsigned long flags);
+static void
+ppc440spe_adma_pq_set_src(struct ppc440spe_adma_desc_slot *tx,
+			  dma_addr_t addr, int index);
+static void
+ppc440spe_adma_pq_set_src_mult(struct ppc440spe_adma_desc_slot *tx,
+			       unsigned char mult, int index, int
dst_pos);
+static void
+ppc440spe_adma_pqzero_sum_set_dest(struct ppc440spe_adma_desc_slot *tx,
+				   dma_addr_t paddr, dma_addr_t qaddr);
+
+static struct page *ppc440spe_rxor_srcs[32];
+
+/**
+ * ppc440spe_can_rxor - check if the operands may be processed with
RXOR
+ */
+static int ppc440spe_can_rxor(struct page **srcs, int src_cnt, size_t
len)
+{
+	int i, order =3D 0, state =3D 0;
+	int idx =3D 0;
+
+	if (unlikely(!(src_cnt > 1)))
+		return 0;
+
+	BUG_ON(src_cnt > ARRAY_SIZE(ppc440spe_rxor_srcs));
+
+	/* Skip holes in the source list before checking */
+	for (i =3D 0; i < src_cnt; i++) {
+		if (!srcs[i])
+			continue;
+		ppc440spe_rxor_srcs[idx++] =3D srcs[i];
+	}
+	src_cnt =3D idx;
+
+	for (i =3D 1; i < src_cnt; i++) {
+		char *cur_addr =3D page_address(ppc440spe_rxor_srcs[i]);
+		char *old_addr =3D page_address(ppc440spe_rxor_srcs[i -
1]);
+
+		switch (state) {
+		case 0:
+			if (cur_addr =3D=3D old_addr + len) {
+				/* direct RXOR */
+				order =3D 1;
+				state =3D 1;
+			} else if (old_addr =3D=3D cur_addr + len) {
+				/* reverse RXOR */
+				order =3D -1;
+				state =3D 1;
+			} else
+				goto out;
+			break;
+		case 1:
+			if ((i =3D=3D src_cnt - 2) ||
+			    (order =3D=3D -1 && cur_addr !=3D old_addr - len))
{
+				order =3D 0;
+				state =3D 0;
+			} else if ((cur_addr =3D=3D old_addr + len * order)
||
+				   (cur_addr =3D=3D old_addr + 2 * len) ||
+				   (cur_addr =3D=3D old_addr + 3 * len)) {
+				state =3D 2;
+			} else {
+				order =3D 0;
+				state =3D 0;
+			}
+			break;
+		case 2:
+			order =3D 0;
+			state =3D 0;
+			break;
+		}
+	}
+
+out:
+	if (state =3D=3D 1 || state =3D=3D 2)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * ppc440spe_adma_device_estimate - estimate the efficiency of
processing
+ *	the operation given on this channel. It's assumed that 'chan' is
+ *	capable to process 'cap' type of operation.
+ * @chan: channel to use
+ * @cap: type of transaction
+ * @dst_lst: array of destination pointers
+ * @dst_cnt: number of destination operands
+ * @src_lst: array of source pointers
+ * @src_cnt: number of source operands
+ * @src_sz: size of each source operand
+ */
+static int ppc440spe_adma_estimate(struct dma_chan *chan,
+	enum dma_transaction_type cap, struct page **dst_lst, int
dst_cnt,
+	struct page **src_lst, int src_cnt, size_t src_sz)
+{
+	int ef =3D 1;
+
+	if (cap =3D=3D DMA_PQ || cap =3D=3D DMA_PQ_VAL) {
+		/* If RAID-6 capabilities were not activated don't try
+		 * to use them
+		 */
+		if (unlikely(!ppc440spe_r6_enabled))
+			return -1;
+	}
+	/*  In the current implementation of ppc440spe ADMA driver it
+	 * makes sense to pick out only pq case, because it may be
+	 * processed:
+	 * (1) either using Biskup method on DMA2;
+	 * (2) or on DMA0/1.
+	 *  Thus we give a favour to (1) if the sources are suitable;
+	 * else let it be processed on one of the DMA0/1 engines.
+	 *  In the sum_product case where destination is also the
+	 * source process it on DMA0/1 only.
+	 */
+	if (cap =3D=3D DMA_PQ && chan->chan_id =3D=3D PPC440SPE_XOR_ID) {
+
+		if (dst_cnt =3D=3D 1 && src_cnt =3D=3D 2 && dst_lst[0] =3D=3D
src_lst[1])
+			ef =3D 0; /* sum_product case, process on DMA0/1
*/
+		else if (ppc440spe_can_rxor(src_lst, src_cnt, src_sz))
+			ef =3D 3; /* override (DMA0/1 + idle) */
+		else
+			ef =3D 0; /* can't process on DMA2 if !rxor */
+	}
+
+	/* channel idleness increases the priority */
+	if (likely(ef) &&
+	    !ppc440spe_chan_is_busy(to_ppc440spe_adma_chan(chan)))
+		ef++;
+
+	return ef;
+}
+
+struct dma_chan *
+ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
+	struct page **dst_lst, int dst_cnt, struct page **src_lst,
+	int src_cnt, size_t src_sz)
+{
+	struct dma_chan *best_chan =3D NULL;
+	struct ppc_dma_chan_ref *ref;
+	int best_rank =3D -1;
+
+	list_for_each_entry(ref, &ppc440spe_adma_chan_list, node) {
+		if (dma_has_cap(cap, ref->chan->device->cap_mask)) {
+			int rank;
+
+			rank =3D ppc440spe_adma_estimate(ref->chan, cap,
dst_lst,
+					dst_cnt, src_lst, src_cnt,
src_sz);
+			if (rank > best_rank) {
+				best_rank =3D rank;
+				best_chan =3D ref->chan;
+			}
+		}
+	}
+
+	return best_chan;
+}
+EXPORT_SYMBOL_GPL(ppc440spe_async_tx_find_best_channel);
+
+/**
+ * ppc440spe_get_group_entry - get group entry with index idx
+ * @tdesc: is the last allocated slot in the group.
+ */
+static struct ppc440spe_adma_desc_slot *
+ppc440spe_get_group_entry(struct ppc440spe_adma_desc_slot *tdesc, u32
entry_idx)
+{
+	struct ppc440spe_adma_desc_slot *iter =3D tdesc->group_head;
+	int i =3D 0;
+
+	if (entry_idx < 0 || entry_idx >=3D (tdesc->src_cnt +
tdesc->dst_cnt)) {
+		printk("%s: entry_idx %d, src_cnt %d, dst_cnt %d\n",
+			__func__, entry_idx, tdesc->src_cnt,
tdesc->dst_cnt);
+		BUG();
+	}
+
+	list_for_each_entry(iter, &tdesc->group_list, chain_node) {
+		if (i++ =3D=3D entry_idx)
+			break;
+	}
+	return iter;
+}
+
+/**
+ * ppc440spe_adma_free_slots - flags descriptor slots for reuse
+ * @slot: Slot to free
+ * Caller must hold &ppc440spe_chan->lock while calling this function
+ */
+static void ppc440spe_adma_free_slots(struct ppc440spe_adma_desc_slot
*slot,
+				      struct ppc440spe_adma_chan *chan)
+{
+	int stride =3D slot->slots_per_op;
+
+	while (stride--) {
+		slot->slots_per_op =3D 0;
+		slot =3D list_entry(slot->slot_node.next,
+				struct ppc440spe_adma_desc_slot,
+				slot_node);
+	}
+}
+
+static void ppc440spe_adma_unmap(struct ppc440spe_adma_chan *chan,
+				 struct ppc440spe_adma_desc_slot *desc)
+{
+	u32 src_cnt, dst_cnt;
+	dma_addr_t addr;
+
+	/*
+	 * get the number of sources & destination
+	 * included in this descriptor and unmap
+	 * them all
+	 */
+	src_cnt =3D ppc440spe_desc_get_src_num(desc, chan);
+	dst_cnt =3D ppc440spe_desc_get_dst_num(desc, chan);
+
+	/* unmap destinations */
+	if (!(desc->async_tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		while (dst_cnt--) {
+			addr =3D ppc440spe_desc_get_dest_addr(
+				desc, chan, dst_cnt);
+			dma_unmap_page(chan->device->dev,
+					addr, desc->unmap_len,
+					DMA_FROM_DEVICE);
+		}
+	}
+
+	/* unmap sources */
+	if (!(desc->async_tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		while (src_cnt--) {
+			addr =3D ppc440spe_desc_get_src_addr(
+				desc, chan, src_cnt);
+			dma_unmap_page(chan->device->dev,
+					addr, desc->unmap_len,
+					DMA_TO_DEVICE);
+		}
+	}
+}
+
+/**
+ * ppc440spe_adma_run_tx_complete_actions - call functions to be called
+ * upon completion
+ */
+static dma_cookie_t ppc440spe_adma_run_tx_complete_actions(
+		struct ppc440spe_adma_desc_slot *desc,
+		struct ppc440spe_adma_chan *chan,
+		dma_cookie_t cookie)
+{
+	int i;
+
+	BUG_ON(desc->async_tx.cookie < 0);
+	if (desc->async_tx.cookie > 0) {
+		cookie =3D desc->async_tx.cookie;
+		desc->async_tx.cookie =3D 0;
+
+		/* call the callback (must not sleep or submit new
+		 * operations to this channel)
+		 */
+		if (desc->async_tx.callback)
+			desc->async_tx.callback(
+				desc->async_tx.callback_param);
+
+		/* unmap dma addresses
+		 * (unmap_single vs unmap_page?)
+		 *
+		 * actually, ppc's dma_unmap_page() functions are empty,
so
+		 * the following code is just for the sake of
completeness
+		 */
+		if (chan && chan->needs_unmap && desc->group_head &&
+		     desc->unmap_len) {
+			struct ppc440spe_adma_desc_slot *unmap =3D
+
desc->group_head;
+			/* assume 1 slot per op always */
+			u32 slot_count =3D unmap->slot_cnt;
+
+			/* Run through the group list and unmap
addresses */
+			for (i =3D 0; i < slot_count; i++) {
+				BUG_ON(!unmap);
+				ppc440spe_adma_unmap(chan, unmap);
+				unmap =3D unmap->hw_next;
+			}
+		}
+	}
+
+	/* run dependent operations */
+	dma_run_dependencies(&desc->async_tx);
+
+	return cookie;
+}
+
+/**
+ * ppc440spe_adma_clean_slot - clean up CDB slot (if ack is set)
+ */
+static int ppc440spe_adma_clean_slot(struct ppc440spe_adma_desc_slot
*desc,
+		struct ppc440spe_adma_chan *chan)
+{
+	/* the client is allowed to attach dependent operations
+	 * until 'ack' is set
+	 */
+	if (!async_tx_test_ack(&desc->async_tx))
+		return 0;
+
+	/* leave the last descriptor in the chain
+	 * so we can append to it
+	 */
+	if (list_is_last(&desc->chain_node, &chan->chain) ||
+	    desc->phys =3D=3D ppc440spe_chan_get_current_descriptor(chan))
+		return 1;
+
+	if (chan->device->id !=3D PPC440SPE_XOR_ID) {
+		/* our DMA interrupt handler clears opc field of
+		 * each processed descriptor. For all types of
+		 * operations except for ZeroSum we do not actually
+		 * need ack from the interrupt handler. ZeroSum is a
+		 * special case since the result of this operation
+		 * is available from the handler only, so if we see
+		 * such type of descriptor (which is unprocessed yet)
+		 * then leave it in chain.
+		 */
+		struct dma_cdb *cdb =3D desc->hw_desc;
+		if (cdb->opc =3D=3D DMA_CDB_OPC_DCHECK128)
+			return 1;
+	}
+
+	dev_dbg(chan->device->common.dev, "\tfree slot %llx: %d stride:
%d\n",
+		desc->phys, desc->idx, desc->slots_per_op);
+
+	list_del(&desc->chain_node);
+	ppc440spe_adma_free_slots(desc, chan);
+	return 0;
+}
+
+/**
+ * __ppc440spe_adma_slot_cleanup - this is the common clean-up routine
+ *	which runs through the channel CDBs list until reach the
descriptor
+ *	currently processed. When routine determines that all CDBs of
group
+ *	are completed then corresponding callbacks (if any) are called
and slots
+ *	are freed.
+ */
+static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan
*chan)
+{
+	struct ppc440spe_adma_desc_slot *iter, *_iter, *group_start =3D
NULL;
+	dma_cookie_t cookie =3D 0;
+	u32 current_desc =3D ppc440spe_chan_get_current_descriptor(chan);
+	int busy =3D ppc440spe_chan_is_busy(chan);
+	int seen_current =3D 0, slot_cnt =3D 0, slots_per_op =3D 0;
+
+	dev_dbg(chan->device->common.dev, "ppc440spe adma%d: %s\n",
+		chan->device->id, __func__);
+
+	if (!current_desc) {
+		/*  There were no transactions yet, so
+		 * nothing to clean
+		 */
+		return;
+	}
+
+	/* free completed slots from the chain starting with
+	 * the oldest descriptor
+	 */
+	list_for_each_entry_safe(iter, _iter, &chan->chain,
+					chain_node) {
+		dev_dbg(chan->device->common.dev, "\tcookie: %d slot: %d
"
+		    "busy: %d this_desc: %#llx next_desc: %#x "
+		    "cur: %#x ack: %d\n",
+		    iter->async_tx.cookie, iter->idx, busy, iter->phys,
+		    ppc440spe_desc_get_link(iter, chan), current_desc,
+		    async_tx_test_ack(&iter->async_tx));
+		prefetch(_iter);
+		prefetch(&_iter->async_tx);
+
+		/* do not advance past the current descriptor loaded
into the
+		 * hardware channel,subsequent descriptors are either in
process
+		 * or have not been submitted
+		 */
+		if (seen_current)
+			break;
+
+		/* stop the search if we reach the current descriptor
and the
+		 * channel is busy, or if it appears that the current
descriptor
+		 * needs to be re-read (i.e. has been appended to)
+		 */
+		if (iter->phys =3D=3D current_desc) {
+			BUG_ON(seen_current++);
+			if (busy || ppc440spe_desc_get_link(iter, chan))
{
+				/* not all descriptors of the group have
+				 * been completed; exit.
+				 */
+				break;
+			}
+		}
+
+		/* detect the start of a group transaction */
+		if (!slot_cnt && !slots_per_op) {
+			slot_cnt =3D iter->slot_cnt;
+			slots_per_op =3D iter->slots_per_op;
+			if (slot_cnt <=3D slots_per_op) {
+				slot_cnt =3D 0;
+				slots_per_op =3D 0;
+			}
+		}
+
+		if (slot_cnt) {
+			if (!group_start)
+				group_start =3D iter;
+			slot_cnt -=3D slots_per_op;
+		}
+
+		/* all the members of a group are complete */
+		if (slots_per_op !=3D 0 && slot_cnt =3D=3D 0) {
+			struct ppc440spe_adma_desc_slot *grp_iter,
*_grp_iter;
+			int end_of_chain =3D 0;
+
+			/* clean up the group */
+			slot_cnt =3D group_start->slot_cnt;
+			grp_iter =3D group_start;
+			list_for_each_entry_safe_from(grp_iter,
_grp_iter,
+				&chan->chain, chain_node) {
+
+				cookie =3D
ppc440spe_adma_run_tx_complete_actions(
+					grp_iter, chan, cookie);
+
+				slot_cnt -=3D slots_per_op;
+				end_of_chain =3D
ppc440spe_adma_clean_slot(
+				    grp_iter, chan);
+				if (end_of_chain && slot_cnt) {
+					/* Should wait for ZeroSum
completion */
+					if (cookie > 0)
+						chan->completed_cookie =3D
cookie;
+					return;
+				}
+
+				if (slot_cnt =3D=3D 0 || end_of_chain)
+					break;
+			}
+
+			/* the group should be complete at this point */
+			BUG_ON(slot_cnt);
+
+			slots_per_op =3D 0;
+			group_start =3D NULL;
+			if (end_of_chain)
+				break;
+			else
+				continue;
+		} else if (slots_per_op) /* wait for group completion */
+			continue;
+
+		cookie =3D ppc440spe_adma_run_tx_complete_actions(iter,
chan,
+		    cookie);
+
+		if (ppc440spe_adma_clean_slot(iter, chan))
+			break;
+	}
+
+	BUG_ON(!seen_current);
+
+	if (cookie > 0) {
+		chan->completed_cookie =3D cookie;
+		pr_debug("\tcompleted cookie %d\n", cookie);
+	}
+
+}
+
+/**
+ * ppc440spe_adma_tasklet - clean up watch-dog initiator
+ */
+static void ppc440spe_adma_tasklet(unsigned long data)
+{
+	struct ppc440spe_adma_chan *chan =3D (struct ppc440spe_adma_chan
*) data;
+
+	spin_lock_nested(&chan->lock, SINGLE_DEPTH_NESTING);
+	__ppc440spe_adma_slot_cleanup(chan);
+	spin_unlock(&chan->lock);
+}
+
+/**
+ * ppc440spe_adma_slot_cleanup - clean up scheduled initiator
+ */
+static void ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan
*chan)
+{
+	spin_lock_bh(&chan->lock);
+	__ppc440spe_adma_slot_cleanup(chan);
+	spin_unlock_bh(&chan->lock);
+}
+
+/**
+ * ppc440spe_adma_alloc_slots - allocate free slots (if any)
+ */
+static struct ppc440spe_adma_desc_slot *ppc440spe_adma_alloc_slots(
+		struct ppc440spe_adma_chan *chan, int num_slots,
+		int slots_per_op)
+{
+	struct ppc440spe_adma_desc_slot *iter =3D NULL, *_iter;
+	struct ppc440spe_adma_desc_slot *alloc_start =3D NULL;
+	struct list_head chain =3D LIST_HEAD_INIT(chain);
+	int slots_found, retry =3D 0;
+
+
+	BUG_ON(!num_slots || !slots_per_op);
+	/* start search from the last allocated descrtiptor
+	 * if a contiguous allocation can not be found start searching
+	 * from the beginning of the list
+	 */
+retry:
+	slots_found =3D 0;
+	if (retry =3D=3D 0)
+		iter =3D chan->last_used;
+	else
+		iter =3D list_entry(&chan->all_slots,
+				  struct ppc440spe_adma_desc_slot,
+				  slot_node);
+	list_for_each_entry_safe_continue(iter, _iter, &chan->all_slots,
+	    slot_node) {
+		prefetch(_iter);
+		prefetch(&_iter->async_tx);
+		if (iter->slots_per_op) {
+			slots_found =3D 0;
+			continue;
+		}
+
+		/* start the allocation if the slot is correctly aligned
*/
+		if (!slots_found++)
+			alloc_start =3D iter;
+
+		if (slots_found =3D=3D num_slots) {
+			struct ppc440spe_adma_desc_slot *alloc_tail =3D
NULL;
+			struct ppc440spe_adma_desc_slot *last_used =3D
NULL;
+
+			iter =3D alloc_start;
+			while (num_slots) {
+				int i;
+				/* pre-ack all but the last descriptor
*/
+				if (num_slots !=3D slots_per_op)
+					async_tx_ack(&iter->async_tx);
+
+				list_add_tail(&iter->chain_node,
&chain);
+				alloc_tail =3D iter;
+				iter->async_tx.cookie =3D 0;
+				iter->hw_next =3D NULL;
+				iter->flags =3D 0;
+				iter->slot_cnt =3D num_slots;
+				iter->xor_check_result =3D NULL;
+				for (i =3D 0; i < slots_per_op; i++) {
+					iter->slots_per_op =3D
slots_per_op - i;
+					last_used =3D iter;
+					iter =3D
list_entry(iter->slot_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						slot_node);
+				}
+				num_slots -=3D slots_per_op;
+			}
+			alloc_tail->group_head =3D alloc_start;
+			alloc_tail->async_tx.cookie =3D -EBUSY;
+			list_splice(&chain, &alloc_tail->group_list);
+			chan->last_used =3D last_used;
+			return alloc_tail;
+		}
+	}
+	if (!retry++)
+		goto retry;
+
+	/* try to free some slots if the allocation fails */
+	tasklet_schedule(&chan->irq_tasklet);
+	return NULL;
+}
+
+/**
+ * ppc440spe_adma_alloc_chan_resources -  allocate pools for CDB slots
+ */
+static int ppc440spe_adma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *slot =3D NULL;
+	char *hw_desc;
+	int i, db_sz;
+	int init;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+	init =3D ppc440spe_chan->slots_allocated ? 0 : 1;
+	chan->chan_id =3D ppc440spe_chan->device->id;
+
+	/* Allocate descriptor slots */
+	i =3D ppc440spe_chan->slots_allocated;
+	if (ppc440spe_chan->device->id !=3D PPC440SPE_XOR_ID)
+		db_sz =3D sizeof(struct dma_cdb);
+	else
+		db_sz =3D sizeof(struct xor_cb);
+
+	for (; i < (ppc440spe_chan->device->pool_size / db_sz); i++) {
+		slot =3D kzalloc(sizeof(struct ppc440spe_adma_desc_slot),
+			       GFP_KERNEL);
+		if (!slot) {
+			printk(KERN_INFO "SPE ADMA Channel only
initialized"
+				" %d descriptor slots", i--);
+			break;
+		}
+
+		hw_desc =3D (char *)
ppc440spe_chan->device->dma_desc_pool_virt;
+		slot->hw_desc =3D (void *) &hw_desc[i * db_sz];
+		dma_async_tx_descriptor_init(&slot->async_tx, chan);
+		slot->async_tx.tx_submit =3D ppc440spe_adma_tx_submit;
+		INIT_LIST_HEAD(&slot->chain_node);
+		INIT_LIST_HEAD(&slot->slot_node);
+		INIT_LIST_HEAD(&slot->group_list);
+		slot->phys =3D ppc440spe_chan->device->dma_desc_pool + i *
db_sz;
+		slot->idx =3D i;
+
+		spin_lock_bh(&ppc440spe_chan->lock);
+		ppc440spe_chan->slots_allocated++;
+		list_add_tail(&slot->slot_node,
&ppc440spe_chan->all_slots);
+		spin_unlock_bh(&ppc440spe_chan->lock);
+	}
+
+	if (i && !ppc440spe_chan->last_used) {
+		ppc440spe_chan->last_used =3D
+			list_entry(ppc440spe_chan->all_slots.next,
+				struct ppc440spe_adma_desc_slot,
+				slot_node);
+	}
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: allocated %d descriptor slots\n",
+		ppc440spe_chan->device->id, i);
+
+	/* initialize the channel and the chain with a null operation */
+	if (init) {
+		switch (ppc440spe_chan->device->id) {
+		case PPC440SPE_DMA0_ID:
+		case PPC440SPE_DMA1_ID:
+			ppc440spe_chan->hw_chain_inited =3D 0;
+			/* Use WXOR for self-testing */
+			if (!ppc440spe_r6_tchan)
+				ppc440spe_r6_tchan =3D ppc440spe_chan;
+			break;
+		case PPC440SPE_XOR_ID:
+			ppc440spe_chan_start_null_xor(ppc440spe_chan);
+			break;
+		default:
+			BUG();
+		}
+		ppc440spe_chan->needs_unmap =3D 1;
+	}
+
+	return (i > 0) ? i : -ENOMEM;
+}
+
+/**
+ * ppc440spe_desc_assign_cookie - assign a cookie
+ */
+static dma_cookie_t ppc440spe_desc_assign_cookie(
+		struct ppc440spe_adma_chan *chan,
+		struct ppc440spe_adma_desc_slot *desc)
+{
+	dma_cookie_t cookie =3D chan->common.cookie;
+
+	cookie++;
+	if (cookie < 0)
+		cookie =3D 1;
+	chan->common.cookie =3D desc->async_tx.cookie =3D cookie;
+	return cookie;
+}
+
+/**
+ * ppc440spe_rxor_set_region_data -
+ */
+static void ppc440spe_rxor_set_region(struct ppc440spe_adma_desc_slot
*desc,
+	u8 xor_arg_no, u32 mask)
+{
+	struct xor_cb *xcb =3D desc->hw_desc;
+
+	xcb->ops[xor_arg_no].h |=3D mask;
+}
+
+/**
+ * ppc440spe_rxor_set_src -
+ */
+static void ppc440spe_rxor_set_src(struct ppc440spe_adma_desc_slot
*desc,
+	u8 xor_arg_no, dma_addr_t addr)
+{
+	struct xor_cb *xcb =3D desc->hw_desc;
+
+	xcb->ops[xor_arg_no].h |=3D DMA_CUED_XOR_BASE;
+	xcb->ops[xor_arg_no].l =3D addr;
+}
+
+/**
+ * ppc440spe_rxor_set_mult -
+ */
+static void ppc440spe_rxor_set_mult(struct ppc440spe_adma_desc_slot
*desc,
+	u8 xor_arg_no, u8 idx, u8 mult)
+{
+	struct xor_cb *xcb =3D desc->hw_desc;
+
+	xcb->ops[xor_arg_no].h |=3D mult << (DMA_CUED_MULT1_OFF + idx *
8);
+}
+
+/**
+ * ppc440spe_adma_check_threshold - append CDBs to h/w chain if
threshold
+ *	has been achieved
+ */
+static void ppc440spe_adma_check_threshold(struct ppc440spe_adma_chan
*chan)
+{
+	dev_dbg(chan->device->common.dev, "ppc440spe adma%d: pending:
%d\n",
+		chan->device->id, chan->pending);
+
+	if (chan->pending >=3D PPC440SPE_ADMA_THRESHOLD) {
+		chan->pending =3D 0;
+		ppc440spe_chan_append(chan);
+	}
+}
+
+/**
+ * ppc440spe_adma_tx_submit - submit new descriptor group to the
channel
+ *	(it's not necessary that descriptors will be submitted to the
h/w
+ *	chains too right now)
+ */
+static dma_cookie_t ppc440spe_adma_tx_submit(struct
dma_async_tx_descriptor *tx)
+{
+	struct ppc440spe_adma_desc_slot *sw_desc;
+	struct ppc440spe_adma_chan *chan =3D
to_ppc440spe_adma_chan(tx->chan);
+	struct ppc440spe_adma_desc_slot *group_start, *old_chain_tail;
+	int slot_cnt;
+	int slots_per_op;
+	dma_cookie_t cookie;
+
+	sw_desc =3D tx_to_ppc440spe_adma_slot(tx);
+
+	group_start =3D sw_desc->group_head;
+	slot_cnt =3D group_start->slot_cnt;
+	slots_per_op =3D group_start->slots_per_op;
+
+	spin_lock_bh(&chan->lock);
+
+	cookie =3D ppc440spe_desc_assign_cookie(chan, sw_desc);
+
+	if (unlikely(list_empty(&chan->chain))) {
+		/* first peer */
+		list_splice_init(&sw_desc->group_list, &chan->chain);
+		chan_first_cdb[chan->device->id] =3D group_start;
+	} else {
+		/* isn't first peer, bind CDBs to chain */
+		old_chain_tail =3D list_entry(chan->chain.prev,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		list_splice_init(&sw_desc->group_list,
+		    &old_chain_tail->chain_node);
+		/* fix up the hardware chain */
+		ppc440spe_desc_set_link(chan, old_chain_tail,
group_start);
+	}
+
+	/* increment the pending count by the number of operations */
+	chan->pending +=3D slot_cnt / slots_per_op;
+	ppc440spe_adma_check_threshold(chan);
+	spin_unlock_bh(&chan->lock);
+
+	dev_dbg(chan->device->common.dev,
+		"ppc440spe adma%d: %s cookie: %d slot: %d tx %p\n",
+		chan->device->id, __func__,
+		sw_desc->async_tx.cookie, sw_desc->idx, sw_desc);
+
+	return cookie;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_interrupt - prepare CDB for a pseudo DMA
operation
+ */
+static struct dma_async_tx_descriptor
*ppc440spe_adma_prep_dma_interrupt(
+		struct dma_chan *chan, unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc, *group_start;
+	int slot_cnt, slots_per_op;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s\n", ppc440spe_chan->device->id,
+		__func__);
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	slot_cnt =3D slots_per_op =3D 1;
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
+			slots_per_op);
+	if (sw_desc) {
+		group_start =3D sw_desc->group_head;
+		ppc440spe_desc_init_interrupt(group_start,
ppc440spe_chan);
+		group_start->unmap_len =3D 0;
+		sw_desc->async_tx.flags =3D flags;
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_memcpy - prepare CDB for a MEMCPY operation
+ */
+static struct dma_async_tx_descriptor *ppc440spe_adma_prep_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dest,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc, *group_start;
+	int slot_cnt, slots_per_op;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	if (unlikely(!len))
+		return NULL;
+
+	BUG_ON(unlikely(len > PPC440SPE_ADMA_DMA_MAX_BYTE_COUNT));
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s len: %u int_en %d\n",
+		ppc440spe_chan->device->id, __func__, len,
+		flags & DMA_PREP_INTERRUPT ? 1 : 0);
+	slot_cnt =3D slots_per_op =3D 1;
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
+		slots_per_op);
+	if (sw_desc) {
+		group_start =3D sw_desc->group_head;
+		ppc440spe_desc_init_memcpy(group_start, flags);
+		ppc440spe_adma_set_dest(group_start, dma_dest, 0);
+		ppc440spe_adma_memcpy_xor_set_src(group_start, dma_src,
0);
+		ppc440spe_desc_set_byte_count(group_start,
ppc440spe_chan, len);
+		sw_desc->unmap_len =3D len;
+		sw_desc->async_tx.flags =3D flags;
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_memset - prepare CDB for a MEMSET operation
+ */
+static struct dma_async_tx_descriptor *ppc440spe_adma_prep_dma_memset(
+		struct dma_chan *chan, dma_addr_t dma_dest, int value,
+		size_t len, unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc, *group_start;
+	int slot_cnt, slots_per_op;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	if (unlikely(!len))
+		return NULL;
+
+	BUG_ON(unlikely(len > PPC440SPE_ADMA_DMA_MAX_BYTE_COUNT));
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s cal: %u len: %u int_en %d\n",
+		ppc440spe_chan->device->id, __func__, value, len,
+		flags & DMA_PREP_INTERRUPT ? 1 : 0);
+
+	slot_cnt =3D slots_per_op =3D 1;
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
+		slots_per_op);
+	if (sw_desc) {
+		group_start =3D sw_desc->group_head;
+		ppc440spe_desc_init_memset(group_start, value, flags);
+		ppc440spe_adma_set_dest(group_start, dma_dest, 0);
+		ppc440spe_desc_set_byte_count(group_start,
ppc440spe_chan, len);
+		sw_desc->unmap_len =3D len;
+		sw_desc->async_tx.flags =3D flags;
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_xor - prepare CDB for a XOR operation
+ */
+static struct dma_async_tx_descriptor *ppc440spe_adma_prep_dma_xor(
+		struct dma_chan *chan, dma_addr_t dma_dest,
+		dma_addr_t *dma_src, u32 src_cnt, size_t len,
+		unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc, *group_start;
+	int slot_cnt, slots_per_op;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	ADMA_LL_DBG(prep_dma_xor_dbg(ppc440spe_chan->device->id,
+				     dma_dest, dma_src, src_cnt));
+	if (unlikely(!len))
+		return NULL;
+	BUG_ON(unlikely(len > PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT));
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s src_cnt: %d len: %u int_en: %d\n",
+		ppc440spe_chan->device->id, __func__, src_cnt, len,
+		flags & DMA_PREP_INTERRUPT ? 1 : 0);
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	slot_cnt =3D ppc440spe_chan_xor_slot_count(len, src_cnt,
&slots_per_op);
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
+			slots_per_op);
+	if (sw_desc) {
+		group_start =3D sw_desc->group_head;
+		ppc440spe_desc_init_xor(group_start, src_cnt, flags);
+		ppc440spe_adma_set_dest(group_start, dma_dest, 0);
+		while (src_cnt--)
+			ppc440spe_adma_memcpy_xor_set_src(group_start,
+				dma_src[src_cnt], src_cnt);
+		ppc440spe_desc_set_byte_count(group_start,
ppc440spe_chan, len);
+		sw_desc->unmap_len =3D len;
+		sw_desc->async_tx.flags =3D flags;
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+static inline void
+ppc440spe_desc_set_xor_src_cnt(struct ppc440spe_adma_desc_slot *desc,
+				int src_cnt);
+static void ppc440spe_init_rxor_cursor(struct ppc440spe_rxor *cursor);
+
+/**
+ * ppc440spe_adma_init_dma2rxor_slot -
+ */
+static void ppc440spe_adma_init_dma2rxor_slot(
+		struct ppc440spe_adma_desc_slot *desc,
+		dma_addr_t *src, int src_cnt)
+{
+	int i;
+
+	/* initialize CDB */
+	for (i =3D 0; i < src_cnt; i++) {
+		ppc440spe_adma_dma2rxor_prep_src(desc,
&desc->rxor_cursor, i,
+						 desc->src_cnt,
(u32)src[i]);
+	}
+}
+
+/**
+ * ppc440spe_dma01_prep_mult -
+ * for Q operation where destination is also the source
+ */
+static struct ppc440spe_adma_desc_slot *ppc440spe_dma01_prep_mult(
+		struct ppc440spe_adma_chan *ppc440spe_chan,
+		dma_addr_t *dst, int dst_cnt, dma_addr_t *src, int
src_cnt,
+		const unsigned char *scf, size_t len, unsigned long
flags)
+{
+	struct ppc440spe_adma_desc_slot *sw_desc =3D NULL;
+	unsigned long op =3D 0;
+	int slot_cnt;
+
+	set_bit(PPC440SPE_DESC_WXOR, &op);
+	slot_cnt =3D 2;
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+
+	/* use WXOR, each descriptor occupies one slot */
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
1);
+	if (sw_desc) {
+		struct ppc440spe_adma_chan *chan;
+		struct ppc440spe_adma_desc_slot *iter;
+		struct dma_cdb *hw_desc;
+
+		chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+		set_bits(op, &sw_desc->flags);
+		sw_desc->src_cnt =3D src_cnt;
+		sw_desc->dst_cnt =3D dst_cnt;
+		/* First descriptor, zero data in the destination and
copy it
+		 * to q page using MULTICAST transfer.
+		 */
+		iter =3D list_first_entry(&sw_desc->group_list,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		/* set 'next' pointer */
+		iter->hw_next =3D list_entry(iter->chain_node.next,
+					   struct
ppc440spe_adma_desc_slot,
+					   chain_node);
+		clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MULTICAST;
+
+		ppc440spe_desc_set_dest_addr(iter, chan,
+					     DMA_CUED_XOR_BASE, dst[0],
0);
+		ppc440spe_desc_set_dest_addr(iter, chan, 0, dst[1], 1);
+		ppc440spe_desc_set_src_addr(iter, chan, 0,
DMA_CUED_XOR_HB,
+					    src[0]);
+		ppc440spe_desc_set_byte_count(iter, ppc440spe_chan,
len);
+		iter->unmap_len =3D len;
+
+		/*
+		 * Second descriptor, multiply data from the q page
+		 * and store the result in real destination.
+		 */
+		iter =3D list_first_entry(&iter->chain_node,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		iter->hw_next =3D NULL;
+		if (flags & DMA_PREP_INTERRUPT)
+			set_bit(PPC440SPE_DESC_INT, &iter->flags);
+		else
+			clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+		ppc440spe_desc_set_src_addr(iter, chan, 0,
+					    DMA_CUED_XOR_HB, dst[1]);
+		ppc440spe_desc_set_dest_addr(iter, chan,
+					     DMA_CUED_XOR_BASE, dst[0],
0);
+
+		ppc440spe_desc_set_src_mult(iter, chan,
DMA_CUED_MULT1_OFF,
+					    DMA_CDB_SG_DST1, scf[0]);
+		ppc440spe_desc_set_byte_count(iter, ppc440spe_chan,
len);
+		iter->unmap_len =3D len;
+		sw_desc->async_tx.flags =3D flags;
+	}
+
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc;
+}
+
+/**
+ * ppc440spe_dma01_prep_sum_product -
+ * Dx =3D A*(P+Pxy) + B*(Q+Qxy) operation where destination is also
+ * the source.
+ */
+static struct ppc440spe_adma_desc_slot
*ppc440spe_dma01_prep_sum_product(
+		struct ppc440spe_adma_chan *ppc440spe_chan,
+		dma_addr_t *dst, dma_addr_t *src, int src_cnt,
+		const unsigned char *scf, size_t len, unsigned long
flags)
+{
+	struct ppc440spe_adma_desc_slot *sw_desc =3D NULL;
+	unsigned long op =3D 0;
+	int slot_cnt;
+
+	set_bit(PPC440SPE_DESC_WXOR, &op);
+	slot_cnt =3D 3;
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+
+	/* WXOR, each descriptor occupies one slot */
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
1);
+	if (sw_desc) {
+		struct ppc440spe_adma_chan *chan;
+		struct ppc440spe_adma_desc_slot *iter;
+		struct dma_cdb *hw_desc;
+
+		chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+		set_bits(op, &sw_desc->flags);
+		sw_desc->src_cnt =3D src_cnt;
+		sw_desc->dst_cnt =3D 1;
+		/* 1st descriptor, src[1] data to q page and zero
destination */
+		iter =3D list_first_entry(&sw_desc->group_list,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		iter->hw_next =3D list_entry(iter->chain_node.next,
+					   struct
ppc440spe_adma_desc_slot,
+					   chain_node);
+		clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MULTICAST;
+
+		ppc440spe_desc_set_dest_addr(iter, chan,
DMA_CUED_XOR_BASE,
+					     *dst, 0);
+		ppc440spe_desc_set_dest_addr(iter, chan, 0,
+					     ppc440spe_chan->qdest, 1);
+		ppc440spe_desc_set_src_addr(iter, chan, 0,
DMA_CUED_XOR_HB,
+					    src[1]);
+		ppc440spe_desc_set_byte_count(iter, ppc440spe_chan,
len);
+		iter->unmap_len =3D len;
+
+		/* 2nd descriptor, multiply src[1] data and store the
+		 * result in destination */
+		iter =3D list_first_entry(&iter->chain_node,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		/* set 'next' pointer */
+		iter->hw_next =3D list_entry(iter->chain_node.next,
+					   struct
ppc440spe_adma_desc_slot,
+					   chain_node);
+		if (flags & DMA_PREP_INTERRUPT)
+			set_bit(PPC440SPE_DESC_INT, &iter->flags);
+		else
+			clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+		ppc440spe_desc_set_src_addr(iter, chan, 0,
DMA_CUED_XOR_HB,
+					    ppc440spe_chan->qdest);
+		ppc440spe_desc_set_dest_addr(iter, chan,
DMA_CUED_XOR_BASE,
+					     *dst, 0);
+		ppc440spe_desc_set_src_mult(iter, chan,
DMA_CUED_MULT1_OFF,
+					    DMA_CDB_SG_DST1, scf[1]);
+		ppc440spe_desc_set_byte_count(iter, ppc440spe_chan,
len);
+		iter->unmap_len =3D len;
+
+		/*
+		 * 3rd descriptor, multiply src[0] data and xor it
+		 * with destination
+		 */
+		iter =3D list_first_entry(&iter->chain_node,
+					struct ppc440spe_adma_desc_slot,
+					chain_node);
+		memset(iter->hw_desc, 0, sizeof(struct dma_cdb));
+		iter->hw_next =3D NULL;
+		if (flags & DMA_PREP_INTERRUPT)
+			set_bit(PPC440SPE_DESC_INT, &iter->flags);
+		else
+			clear_bit(PPC440SPE_DESC_INT, &iter->flags);
+
+		hw_desc =3D iter->hw_desc;
+		hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+		ppc440spe_desc_set_src_addr(iter, chan, 0,
DMA_CUED_XOR_HB,
+					    src[0]);
+		ppc440spe_desc_set_dest_addr(iter, chan,
DMA_CUED_XOR_BASE,
+					     *dst, 0);
+		ppc440spe_desc_set_src_mult(iter, chan,
DMA_CUED_MULT1_OFF,
+					    DMA_CDB_SG_DST1, scf[0]);
+		ppc440spe_desc_set_byte_count(iter, ppc440spe_chan,
len);
+		iter->unmap_len =3D len;
+		sw_desc->async_tx.flags =3D flags;
+	}
+
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc;
+}
+
+static struct ppc440spe_adma_desc_slot *ppc440spe_dma01_prep_pq(
+		struct ppc440spe_adma_chan *ppc440spe_chan,
+		dma_addr_t *dst, int dst_cnt, dma_addr_t *src, int
src_cnt,
+		const unsigned char *scf, size_t len, unsigned long
flags)
+{
+	int slot_cnt;
+	struct ppc440spe_adma_desc_slot *sw_desc =3D NULL, *iter;
+	unsigned long op =3D 0;
+	unsigned char mult =3D 1;
+
+	pr_debug("%s: dst_cnt %d, src_cnt %d, len %d\n",
+		 __func__, dst_cnt, src_cnt, len);
+	/*  select operations WXOR/RXOR depending on the
+	 * source addresses of operators and the number
+	 * of destinations (RXOR support only Q-parity calculations)
+	 */
+	set_bit(PPC440SPE_DESC_WXOR, &op);
+	if (!test_and_set_bit(PPC440SPE_RXOR_RUN,
&ppc440spe_rxor_state)) {
+		/* no active RXOR;
+		 * do RXOR if:
+		 * - there are more than 1 source,
+		 * - len is aligned on 512-byte boundary,
+		 * - source addresses fit to one of 4 possible regions.
+		 */
+		if (src_cnt > 1 &&
+		    !(len & MQ0_CF2H_RXOR_BS_MASK) &&
+		    (src[0] + len) =3D=3D src[1]) {
+			/* may do RXOR R1 R2 */
+			set_bit(PPC440SPE_DESC_RXOR, &op);
+			if (src_cnt !=3D 2) {
+				/* may try to enhance region of RXOR */
+				if ((src[1] + len) =3D=3D src[2]) {
+					/* do RXOR R1 R2 R3 */
+					set_bit(PPC440SPE_DESC_RXOR123,
+						&op);
+				} else if ((src[1] + len * 2) =3D=3D src[2])
{
+					/* do RXOR R1 R2 R4 */
+					set_bit(PPC440SPE_DESC_RXOR124,
&op);
+				} else if ((src[1] + len * 3) =3D=3D src[2])
{
+					/* do RXOR R1 R2 R5 */
+					set_bit(PPC440SPE_DESC_RXOR125,
+						&op);
+				} else {
+					/* do RXOR R1 R2 */
+					set_bit(PPC440SPE_DESC_RXOR12,
+						&op);
+				}
+			} else {
+				/* do RXOR R1 R2 */
+				set_bit(PPC440SPE_DESC_RXOR12, &op);
+			}
+		}
+
+		if (!test_bit(PPC440SPE_DESC_RXOR, &op)) {
+			/* can not do this operation with RXOR */
+			clear_bit(PPC440SPE_RXOR_RUN,
+				&ppc440spe_rxor_state);
+		} else {
+			/* can do; set block size right now */
+			ppc440spe_desc_set_rxor_block_size(len);
+		}
+	}
+
+	/* Number of necessary slots depends on operation type selected
*/
+	if (!test_bit(PPC440SPE_DESC_RXOR, &op)) {
+		/*  This is a WXOR only chain. Need descriptors for each
+		 * source to GF-XOR them with WXOR, and need descriptors
+		 * for each destination to zero them with WXOR
+		 */
+		slot_cnt =3D src_cnt;
+
+		if (flags & DMA_PREP_ZERO_P) {
+			slot_cnt++;
+			set_bit(PPC440SPE_ZERO_P, &op);
+		}
+		if (flags & DMA_PREP_ZERO_Q) {
+			slot_cnt++;
+			set_bit(PPC440SPE_ZERO_Q, &op);
+		}
+	} else {
+		/*  Need 1/2 descriptor for RXOR operation, and
+		 * need (src_cnt - (2 or 3)) for WXOR of sources
+		 * remained (if any)
+		 */
+		slot_cnt =3D dst_cnt;
+
+		if (flags & DMA_PREP_ZERO_P)
+			set_bit(PPC440SPE_ZERO_P, &op);
+		if (flags & DMA_PREP_ZERO_Q)
+			set_bit(PPC440SPE_ZERO_Q, &op);
+
+		if (test_bit(PPC440SPE_DESC_RXOR12, &op))
+			slot_cnt +=3D src_cnt - 2;
+		else
+			slot_cnt +=3D src_cnt - 3;
+
+		/*  Thus we have either RXOR only chain or
+		 * mixed RXOR/WXOR
+		 */
+		if (slot_cnt =3D=3D dst_cnt)
+			/* RXOR only chain */
+			clear_bit(PPC440SPE_DESC_WXOR, &op);
+	}
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	/* for both RXOR/WXOR each descriptor occupies one slot */
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
1);
+	if (sw_desc) {
+		ppc440spe_desc_init_dma01pq(sw_desc, dst_cnt, src_cnt,
+				flags, op);
+
+		/* setup dst/src/mult */
+		pr_debug("%s: set dst descriptor 0, 1: 0x%016llx,
0x%016llx\n",
+			 __func__, dst[0], dst[1]);
+		ppc440spe_adma_pq_set_dest(sw_desc, dst, flags);
+		while (src_cnt--) {
+			ppc440spe_adma_pq_set_src(sw_desc, src[src_cnt],
+						  src_cnt);
+
+			/* NOTE: "Multi =3D 0 is equivalent to =3D 1" as it
+			 * stated in 440SPSPe_RAID6_Addendum_UM_1_17.pdf
+			 * doesn't work for RXOR with DMA0/1! Instead,
multi=3D0
+			 * leads to zeroing source data after RXOR.
+			 * So, for P case set-up mult=3D1 explicitly.
+			 */
+			if (!(flags & DMA_PREP_PQ_DISABLE_Q))
+				mult =3D scf[src_cnt];
+			ppc440spe_adma_pq_set_src_mult(sw_desc,
+				mult, src_cnt,  dst_cnt - 1);
+		}
+
+		/* Setup byte count foreach slot just allocated */
+		sw_desc->async_tx.flags =3D flags;
+		list_for_each_entry(iter, &sw_desc->group_list,
+				chain_node) {
+			ppc440spe_desc_set_byte_count(iter,
+				ppc440spe_chan, len);
+			iter->unmap_len =3D len;
+		}
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	return sw_desc;
+}
+
+static struct ppc440spe_adma_desc_slot *ppc440spe_dma2_prep_pq(
+		struct ppc440spe_adma_chan *ppc440spe_chan,
+		dma_addr_t *dst, int dst_cnt, dma_addr_t *src, int
src_cnt,
+		const unsigned char *scf, size_t len, unsigned long
flags)
+{
+	int slot_cnt, descs_per_op;
+	struct ppc440spe_adma_desc_slot *sw_desc =3D NULL, *iter;
+	unsigned long op =3D 0;
+	unsigned char mult =3D 1;
+
+	BUG_ON(!dst_cnt);
+	/*pr_debug("%s: dst_cnt %d, src_cnt %d, len %d\n",
+		 __func__, dst_cnt, src_cnt, len);*/
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	descs_per_op =3D ppc440spe_dma2_pq_slot_count(src, src_cnt, len);
+	if (descs_per_op < 0) {
+		spin_unlock_bh(&ppc440spe_chan->lock);
+		return NULL;
+	}
+
+	/* depending on number of sources we have 1 or 2 RXOR chains */
+	slot_cnt =3D descs_per_op * dst_cnt;
+
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
1);
+	if (sw_desc) {
+		op =3D slot_cnt;
+		sw_desc->async_tx.flags =3D flags;
+		list_for_each_entry(iter, &sw_desc->group_list,
chain_node) {
+			ppc440spe_desc_init_dma2pq(iter, dst_cnt,
src_cnt,
+				--op ? 0 : flags);
+			ppc440spe_desc_set_byte_count(iter,
ppc440spe_chan,
+				len);
+			iter->unmap_len =3D len;
+
+
ppc440spe_init_rxor_cursor(&(iter->rxor_cursor));
+			iter->rxor_cursor.len =3D len;
+			iter->descs_per_op =3D descs_per_op;
+		}
+		op =3D 0;
+		list_for_each_entry(iter, &sw_desc->group_list,
chain_node) {
+			op++;
+			if (op % descs_per_op =3D=3D 0)
+				ppc440spe_adma_init_dma2rxor_slot(iter,
src,
+
src_cnt);
+			if (likely(!list_is_last(&iter->chain_node,
+						 &sw_desc->group_list)))
{
+				/* set 'next' pointer */
+				iter->hw_next =3D
+
list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+				ppc440spe_xor_set_link(iter,
iter->hw_next);
+			} else {
+				/* this is the last descriptor. */
+				iter->hw_next =3D NULL;
+			}
+		}
+
+		/* fixup head descriptor */
+		sw_desc->dst_cnt =3D dst_cnt;
+		if (flags & DMA_PREP_ZERO_P)
+			set_bit(PPC440SPE_ZERO_P, &sw_desc->flags);
+		if (flags & DMA_PREP_ZERO_Q)
+			set_bit(PPC440SPE_ZERO_Q, &sw_desc->flags);
+
+		/* setup dst/src/mult */
+		ppc440spe_adma_pq_set_dest(sw_desc, dst, flags);
+
+		while (src_cnt--) {
+			/* handle descriptors (if dst_cnt =3D=3D 2) inside
+			 * the ppc440spe_adma_pq_set_srcxxx() functions
+			 */
+			ppc440spe_adma_pq_set_src(sw_desc, src[src_cnt],
+						  src_cnt);
+			if (!(flags & DMA_PREP_PQ_DISABLE_Q))
+				mult =3D scf[src_cnt];
+			ppc440spe_adma_pq_set_src_mult(sw_desc,
+					mult, src_cnt, dst_cnt - 1);
+		}
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+	ppc440spe_desc_set_rxor_block_size(len);
+	return sw_desc;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_pq - prepare CDB (group) for a GF-XOR
operation
+ */
+static struct dma_async_tx_descriptor *ppc440spe_adma_prep_dma_pq(
+		struct dma_chan *chan, dma_addr_t *dst, dma_addr_t *src,
+		unsigned int src_cnt, const unsigned char *scf,
+		size_t len, unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc =3D NULL;
+	int dst_cnt =3D 0;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	ADMA_LL_DBG(prep_dma_pq_dbg(ppc440spe_chan->device->id,
+				    dst, src, src_cnt));
+	BUG_ON(!len);
+	BUG_ON(unlikely(len > PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT));
+	BUG_ON(!src_cnt);
+
+	if (src_cnt =3D=3D 1 && dst[1] =3D=3D src[0]) {
+		dma_addr_t dest[2];
+
+		if (len > PAGE_SIZE)
+			return NULL;
+
+		/* dst[1] is real destination (Q) */
+		dest[0] =3D dst[1];
+		/* this is the page to multicast source data to */
+		dest[1] =3D ppc440spe_chan->qdest;
+		sw_desc =3D ppc440spe_dma01_prep_mult(ppc440spe_chan,
+				dest, 2, src, src_cnt, scf, len, flags);
+		return sw_desc ? &sw_desc->async_tx : NULL;
+	}
+
+	if (src_cnt =3D=3D 2 && dst[1] =3D=3D src[1]) {
+		if (len > PAGE_SIZE)
+			return NULL;
+
+		sw_desc =3D
ppc440spe_dma01_prep_sum_product(ppc440spe_chan,
+					&dst[1], src, 2, scf, len,
flags);
+		return sw_desc ? &sw_desc->async_tx : NULL;
+	}
+
+	if (!(flags & DMA_PREP_PQ_DISABLE_P)) {
+		BUG_ON(!dst[0]);
+		dst_cnt++;
+		flags |=3D DMA_PREP_ZERO_P;
+	}
+
+	if (!(flags & DMA_PREP_PQ_DISABLE_Q)) {
+		BUG_ON(!dst[1]);
+		dst_cnt++;
+		flags |=3D DMA_PREP_ZERO_Q;
+	}
+
+	BUG_ON(!dst_cnt);
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s src_cnt: %d len: %u int_en: %d\n",
+		ppc440spe_chan->device->id, __func__, src_cnt, len,
+		flags & DMA_PREP_INTERRUPT ? 1 : 0);
+
+	switch (ppc440spe_chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		sw_desc =3D ppc440spe_dma01_prep_pq(ppc440spe_chan,
+				dst, dst_cnt, src, src_cnt, scf,
+				len, flags);
+		break;
+
+	case PPC440SPE_XOR_ID:
+		sw_desc =3D ppc440spe_dma2_prep_pq(ppc440spe_chan,
+				dst, dst_cnt, src, src_cnt, scf,
+				len, flags);
+		break;
+	}
+
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_pqzero_sum - prepare CDB group for
+ * a PQ_ZERO_SUM operation
+ */
+static struct dma_async_tx_descriptor
*ppc440spe_adma_prep_dma_pqzero_sum(
+		struct dma_chan *chan, dma_addr_t *pq, dma_addr_t *src,
+		unsigned int src_cnt, const unsigned char *scf, size_t
len,
+		enum sum_check_flags *pqres, unsigned long flags)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *sw_desc, *iter;
+	dma_addr_t pdest, qdest;
+	int slot_cnt, slots_per_op, idst, dst_cnt;
+
+	if (unlikely(!len))
+		return NULL;
+	if (len > PAGE_SIZE)
+		return NULL;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+
+	if (flags & DMA_PREP_PQ_DISABLE_P)
+		pdest =3D 0;
+	else
+		pdest =3D pq[0];
+
+	if (flags & DMA_PREP_PQ_DISABLE_Q)
+		qdest =3D 0;
+	else
+		qdest =3D pq[1];
+
+	ADMA_LL_DBG(prep_dma_pqzero_sum_dbg(ppc440spe_chan->device->id,
+					    src, src_cnt, scf));
+
+	/* Always use WXOR for P/Q calculations (two destinations).
+	 * Need 1 or 2 extra slots to verify results are zero.
+	 */
+	idst =3D dst_cnt =3D (pdest && qdest) ? 2 : 1;
+
+	/* One additional slot per destination to clone P/Q
+	 * before calculation (we have to preserve destinations).
+	 */
+	slot_cnt =3D src_cnt + dst_cnt * 2;
+	slots_per_op =3D 1;
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	sw_desc =3D ppc440spe_adma_alloc_slots(ppc440spe_chan, slot_cnt,
+					     slots_per_op);
+	if (sw_desc) {
+		ppc440spe_desc_init_dma01pqzero_sum(sw_desc, dst_cnt,
src_cnt);
+
+		/* Setup byte count for each slot just allocated */
+		sw_desc->async_tx.flags =3D flags;
+		list_for_each_entry(iter, &sw_desc->group_list,
chain_node) {
+			ppc440spe_desc_set_byte_count(iter,
ppc440spe_chan,
+						      len);
+			iter->unmap_len =3D len;
+		}
+
+		if (pdest) {
+			struct dma_cdb *hw_desc;
+			struct ppc440spe_adma_chan *chan;
+
+			iter =3D sw_desc->group_head;
+			chan =3D
to_ppc440spe_adma_chan(iter->async_tx.chan);
+			memset(iter->hw_desc, 0, sizeof(struct
dma_cdb));
+			iter->hw_next =3D
list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+			iter->src_cnt =3D 0;
+			iter->dst_cnt =3D 0;
+			ppc440spe_desc_set_dest_addr(iter, chan, 0,
+
ppc440spe_chan->pdest, 0);
+			ppc440spe_desc_set_src_addr(iter, chan, 0, 0,
pdest);
+			ppc440spe_desc_set_byte_count(iter,
ppc440spe_chan,
+						      len);
+			iter->unmap_len =3D 0;
+			/* override pdest to preserve original P */
+			pdest =3D ppc440spe_chan->pdest;
+		}
+		if (qdest) {
+			struct dma_cdb *hw_desc;
+			struct ppc440spe_adma_chan *chan;
+
+			iter =3D list_first_entry(&sw_desc->group_list,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			chan =3D
to_ppc440spe_adma_chan(iter->async_tx.chan);
+
+			if (pdest) {
+				iter =3D list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			}
+
+			memset(iter->hw_desc, 0, sizeof(struct
dma_cdb));
+			iter->hw_next =3D
list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			hw_desc =3D iter->hw_desc;
+			hw_desc->opc =3D DMA_CDB_OPC_MV_SG1_SG2;
+			iter->src_cnt =3D 0;
+			iter->dst_cnt =3D 0;
+			ppc440spe_desc_set_dest_addr(iter, chan, 0,
+
ppc440spe_chan->qdest, 0);
+			ppc440spe_desc_set_src_addr(iter, chan, 0, 0,
qdest);
+			ppc440spe_desc_set_byte_count(iter,
ppc440spe_chan,
+						      len);
+			iter->unmap_len =3D 0;
+			/* override qdest to preserve original Q */
+			qdest =3D ppc440spe_chan->qdest;
+		}
+
+		/* Setup destinations for P/Q ops */
+		ppc440spe_adma_pqzero_sum_set_dest(sw_desc, pdest,
qdest);
+
+		/* Setup zero QWORDs into DCHECK CDBs */
+		idst =3D dst_cnt;
+		list_for_each_entry_reverse(iter, &sw_desc->group_list,
+					    chain_node) {
+			/*
+			 * The last CDB corresponds to Q-parity check,
+			 * the one before last CDB corresponds
+			 * P-parity check
+			 */
+			if (idst =3D=3D DMA_DEST_MAX_NUM) {
+				if (idst =3D=3D dst_cnt) {
+					set_bit(PPC440SPE_DESC_QCHECK,
+						&iter->flags);
+				} else {
+					set_bit(PPC440SPE_DESC_PCHECK,
+						&iter->flags);
+				}
+			} else {
+				if (qdest) {
+					set_bit(PPC440SPE_DESC_QCHECK,
+						&iter->flags);
+				} else {
+					set_bit(PPC440SPE_DESC_PCHECK,
+						&iter->flags);
+				}
+			}
+			iter->xor_check_result =3D pqres;
+
+			/*
+			 * set it to zero, if check fail then result
will
+			 * be updated
+			 */
+			*iter->xor_check_result =3D 0;
+			ppc440spe_desc_set_dcheck(iter, ppc440spe_chan,
+				ppc440spe_qword);
+
+			if (!(--dst_cnt))
+				break;
+		}
+
+		/* Setup sources and mults for P/Q ops */
+		list_for_each_entry_continue_reverse(iter,
&sw_desc->group_list,
+						     chain_node) {
+			struct ppc440spe_adma_chan *chan;
+			u32 mult_dst;
+
+			chan =3D
to_ppc440spe_adma_chan(iter->async_tx.chan);
+			ppc440spe_desc_set_src_addr(iter, chan, 0,
+						    DMA_CUED_XOR_HB,
+						    src[src_cnt - 1]);
+			if (qdest) {
+				mult_dst =3D (dst_cnt - 1) ?
DMA_CDB_SG_DST2 :
+
DMA_CDB_SG_DST1;
+				ppc440spe_desc_set_src_mult(iter, chan,
+
DMA_CUED_MULT1_OFF,
+							    mult_dst,
+							    scf[src_cnt
- 1]);
+			}
+			if (!(--src_cnt))
+				break;
+		}
+	}
+	spin_unlock_bh(&ppc440spe_chan->lock);
+	return sw_desc ? &sw_desc->async_tx : NULL;
+}
+
+/**
+ * ppc440spe_adma_prep_dma_xor_zero_sum - prepare CDB group for
+ * XOR ZERO_SUM operation
+ */
+static struct dma_async_tx_descriptor
*ppc440spe_adma_prep_dma_xor_zero_sum(
+		struct dma_chan *chan, dma_addr_t *src, unsigned int
src_cnt,
+		size_t len, enum sum_check_flags *result, unsigned long
flags)
+{
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t pq[2];
+
+	/* validate P, disable Q */
+	pq[0] =3D src[0];
+	pq[1] =3D 0;
+	flags |=3D DMA_PREP_PQ_DISABLE_Q;
+
+	tx =3D ppc440spe_adma_prep_dma_pqzero_sum(chan, pq, &src[1],
+						src_cnt - 1, 0, len,
+						result, flags);
+	return tx;
+}
+
+/**
+ * ppc440spe_adma_set_dest - set destination address into descriptor
+ */
+static void ppc440spe_adma_set_dest(struct ppc440spe_adma_desc_slot
*sw_desc,
+		dma_addr_t addr, int index)
+{
+	struct ppc440spe_adma_chan *chan;
+
+	BUG_ON(index >=3D sw_desc->dst_cnt);
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* to do: support transfers lengths >
+		 * PPC440SPE_ADMA_DMA/XOR_MAX_BYTE_COUNT
+		 */
+		ppc440spe_desc_set_dest_addr(sw_desc->group_head,
+			chan, 0, addr, index);
+		break;
+	case PPC440SPE_XOR_ID:
+		sw_desc =3D ppc440spe_get_group_entry(sw_desc, index);
+		ppc440spe_desc_set_dest_addr(sw_desc,
+			chan, 0, addr, index);
+		break;
+	}
+}
+
+static void ppc440spe_adma_pq_zero_op(struct ppc440spe_adma_desc_slot
*iter,
+		struct ppc440spe_adma_chan *chan, dma_addr_t addr)
+{
+	/*  To clear destinations update the descriptor
+	 * (P or Q depending on index) as follows:
+	 * addr is destination (0 corresponds to SG2):
+	 */
+	ppc440spe_desc_set_dest_addr(iter, chan, DMA_CUED_XOR_BASE,
addr, 0);
+
+	/* ... and the addr is source: */
+	ppc440spe_desc_set_src_addr(iter, chan, 0, DMA_CUED_XOR_HB,
addr);
+
+	/* addr is always SG2 then the mult is always DST1 */
+	ppc440spe_desc_set_src_mult(iter, chan, DMA_CUED_MULT1_OFF,
+				    DMA_CDB_SG_DST1, 1);
+}
+
+/**
+ * ppc440spe_adma_pq_set_dest - set destination address into descriptor
+ * for the PQXOR operation
+ */
+static void ppc440spe_adma_pq_set_dest(struct ppc440spe_adma_desc_slot
*sw_desc,
+		dma_addr_t *addrs, unsigned long flags)
+{
+	struct ppc440spe_adma_desc_slot *iter;
+	struct ppc440spe_adma_chan *chan;
+	dma_addr_t paddr, qaddr;
+	dma_addr_t addr =3D 0, ppath, qpath;
+	int index =3D 0, i;
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+
+	if (flags & DMA_PREP_PQ_DISABLE_P)
+		paddr =3D 0;
+	else
+		paddr =3D addrs[0];
+
+	if (flags & DMA_PREP_PQ_DISABLE_Q)
+		qaddr =3D 0;
+	else
+		qaddr =3D addrs[1];
+
+	if (!paddr || !qaddr)
+		addr =3D paddr ? paddr : qaddr;
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* walk through the WXOR source list and set
P/Q-destinations
+		 * for each slot:
+		 */
+		if (!test_bit(PPC440SPE_DESC_RXOR, &sw_desc->flags)) {
+			/* This is WXOR-only chain; may have 1/2 zero
descs */
+			if (test_bit(PPC440SPE_ZERO_P, &sw_desc->flags))
+				index++;
+			if (test_bit(PPC440SPE_ZERO_Q, &sw_desc->flags))
+				index++;
+
+			iter =3D ppc440spe_get_group_entry(sw_desc,
index);
+			if (addr) {
+				/* one destination */
+				list_for_each_entry_from(iter,
+					&sw_desc->group_list,
chain_node)
+
ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE, addr,
0);
+			} else {
+				/* two destinations */
+				list_for_each_entry_from(iter,
+					&sw_desc->group_list,
chain_node) {
+
ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE,
paddr, 0);
+
ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE,
qaddr, 1);
+				}
+			}
+
+			if (index) {
+				/*  To clear destinations update the
descriptor
+				 * (1st,2nd, or both depending on flags)
+				 */
+				index =3D 0;
+				if (test_bit(PPC440SPE_ZERO_P,
+						&sw_desc->flags)) {
+					iter =3D
ppc440spe_get_group_entry(
+							sw_desc,
index++);
+					ppc440spe_adma_pq_zero_op(iter,
chan,
+							paddr);
+				}
+
+				if (test_bit(PPC440SPE_ZERO_Q,
+						&sw_desc->flags)) {
+					iter =3D
ppc440spe_get_group_entry(
+							sw_desc,
index++);
+					ppc440spe_adma_pq_zero_op(iter,
chan,
+							qaddr);
+				}
+
+				return;
+			}
+		} else {
+			/* This is RXOR-only or RXOR/WXOR mixed chain */
+
+			/* If we want to include destination into
calculations,
+			 * then make dest addresses cued with mult=3D1
(XOR).
+			 */
+			ppath =3D test_bit(PPC440SPE_ZERO_P,
&sw_desc->flags) ?
+					DMA_CUED_XOR_HB :
+					DMA_CUED_XOR_BASE |
+						(1 <<
DMA_CUED_MULT1_OFF);
+			qpath =3D test_bit(PPC440SPE_ZERO_Q,
&sw_desc->flags) ?
+					DMA_CUED_XOR_HB :
+					DMA_CUED_XOR_BASE |
+						(1 <<
DMA_CUED_MULT1_OFF);
+
+			/* Setup destination(s) in RXOR slot(s) */
+			iter =3D ppc440spe_get_group_entry(sw_desc,
index++);
+			ppc440spe_desc_set_dest_addr(iter, chan,
+						paddr ? ppath : qpath,
+						paddr ? paddr : qaddr,
0);
+			if (!addr) {
+				/* two destinations */
+				iter =3D
ppc440spe_get_group_entry(sw_desc,
+
index++);
+				ppc440spe_desc_set_dest_addr(iter, chan,
+						qpath, qaddr, 0);
+			}
+
+			if (test_bit(PPC440SPE_DESC_WXOR,
&sw_desc->flags)) {
+				/* Setup destination(s) in remaining
WXOR
+				 * slots
+				 */
+				iter =3D
ppc440spe_get_group_entry(sw_desc,
+								 index);
+				if (addr) {
+					/* one destination */
+					list_for_each_entry_from(iter,
+					    &sw_desc->group_list,
+					    chain_node)
+
ppc440spe_desc_set_dest_addr(
+							iter, chan,
+
DMA_CUED_XOR_BASE,
+							addr, 0);
+
+				} else {
+					/* two destinations */
+					list_for_each_entry_from(iter,
+					    &sw_desc->group_list,
+					    chain_node) {
+
ppc440spe_desc_set_dest_addr(
+							iter, chan,
+
DMA_CUED_XOR_BASE,
+							paddr, 0);
+
ppc440spe_desc_set_dest_addr(
+							iter, chan,
+
DMA_CUED_XOR_BASE,
+							qaddr, 1);
+					}
+				}
+			}
+
+		}
+		break;
+
+	case PPC440SPE_XOR_ID:
+		/* DMA2 descriptors have only 1 destination, so there
are
+		 * two chains - one for each dest.
+		 * If we want to include destination into calculations,
+		 * then make dest addresses cued with mult=3D1 (XOR).
+		 */
+		ppath =3D test_bit(PPC440SPE_ZERO_P, &sw_desc->flags) ?
+				DMA_CUED_XOR_HB :
+				DMA_CUED_XOR_BASE |
+					(1 << DMA_CUED_MULT1_OFF);
+
+		qpath =3D test_bit(PPC440SPE_ZERO_Q, &sw_desc->flags) ?
+				DMA_CUED_XOR_HB :
+				DMA_CUED_XOR_BASE |
+					(1 << DMA_CUED_MULT1_OFF);
+
+		iter =3D ppc440spe_get_group_entry(sw_desc, 0);
+		for (i =3D 0; i < sw_desc->descs_per_op; i++) {
+			ppc440spe_desc_set_dest_addr(iter, chan,
+				paddr ? ppath : qpath,
+				paddr ? paddr : qaddr, 0);
+			iter =3D list_entry(iter->chain_node.next,
+					  struct
ppc440spe_adma_desc_slot,
+					  chain_node);
+		}
+
+		if (!addr) {
+			/* Two destinations; setup Q here */
+			iter =3D ppc440spe_get_group_entry(sw_desc,
+				sw_desc->descs_per_op);
+			for (i =3D 0; i < sw_desc->descs_per_op; i++) {
+				ppc440spe_desc_set_dest_addr(iter,
+					chan, qpath, qaddr, 0);
+				iter =3D list_entry(iter->chain_node.next,
+						struct
ppc440spe_adma_desc_slot,
+						chain_node);
+			}
+		}
+
+		break;
+	}
+}
+
+/**
+ * ppc440spe_adma_pq_zero_sum_set_dest - set destination address into
descriptor
+ * for the PQ_ZERO_SUM operation
+ */
+static void ppc440spe_adma_pqzero_sum_set_dest(
+		struct ppc440spe_adma_desc_slot *sw_desc,
+		dma_addr_t paddr, dma_addr_t qaddr)
+{
+	struct ppc440spe_adma_desc_slot *iter, *end;
+	struct ppc440spe_adma_chan *chan;
+	dma_addr_t addr =3D 0;
+	int idx;
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+
+	/* walk through the WXOR source list and set P/Q-destinations
+	 * for each slot
+	 */
+	idx =3D (paddr && qaddr) ? 2 : 1;
+	/* set end */
+	list_for_each_entry_reverse(end, &sw_desc->group_list,
+				    chain_node) {
+		if (!(--idx))
+			break;
+	}
+	/* set start */
+	idx =3D (paddr && qaddr) ? 2 : 1;
+	iter =3D ppc440spe_get_group_entry(sw_desc, idx);
+
+	if (paddr && qaddr) {
+		/* two destinations */
+		list_for_each_entry_from(iter, &sw_desc->group_list,
+					 chain_node) {
+			if (unlikely(iter =3D=3D end))
+				break;
+			ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE,
paddr, 0);
+			ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE,
qaddr, 1);
+		}
+	} else {
+		/* one destination */
+		addr =3D paddr ? paddr : qaddr;
+		list_for_each_entry_from(iter, &sw_desc->group_list,
+					 chain_node) {
+			if (unlikely(iter =3D=3D end))
+				break;
+			ppc440spe_desc_set_dest_addr(iter, chan,
+						DMA_CUED_XOR_BASE, addr,
0);
+		}
+	}
+
+	/*  The remaining descriptors are DATACHECK. These have no need
in
+	 * destination. Actually, these destinations are used there
+	 * as sources for check operation. So, set addr as source.
+	 */
+	ppc440spe_desc_set_src_addr(end, chan, 0, 0, addr ? addr :
paddr);
+
+	if (!addr) {
+		end =3D list_entry(end->chain_node.next,
+				 struct ppc440spe_adma_desc_slot,
chain_node);
+		ppc440spe_desc_set_src_addr(end, chan, 0, 0, qaddr);
+	}
+}
+
+/**
+ * ppc440spe_desc_set_xor_src_cnt - set source count into descriptor
+ */
+static inline void ppc440spe_desc_set_xor_src_cnt(
+			struct ppc440spe_adma_desc_slot *desc,
+			int src_cnt)
+{
+	struct xor_cb *hw_desc =3D desc->hw_desc;
+
+	hw_desc->cbc &=3D ~XOR_CDCR_OAC_MSK;
+	hw_desc->cbc |=3D src_cnt;
+}
+
+/**
+ * ppc440spe_adma_pq_set_src - set source address into descriptor
+ */
+static void ppc440spe_adma_pq_set_src(struct ppc440spe_adma_desc_slot
*sw_desc,
+		dma_addr_t addr, int index)
+{
+	struct ppc440spe_adma_chan *chan;
+	dma_addr_t haddr =3D 0;
+	struct ppc440spe_adma_desc_slot *iter =3D NULL;
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		/* DMA0,1 may do: WXOR, RXOR, RXOR+WXORs chain
+		 */
+		if (test_bit(PPC440SPE_DESC_RXOR, &sw_desc->flags)) {
+			/* RXOR-only or RXOR/WXOR operation */
+			int iskip =3D test_bit(PPC440SPE_DESC_RXOR12,
+				&sw_desc->flags) ?  2 : 3;
+
+			if (index =3D=3D 0) {
+				/* 1st slot (RXOR) */
+				/* setup sources region (R1-2-3, R1-2-4,
+				 * or R1-2-5)
+				 */
+				if (test_bit(PPC440SPE_DESC_RXOR12,
+						&sw_desc->flags))
+					haddr =3D DMA_RXOR12 <<
+						DMA_CUED_REGION_OFF;
+				else if
(test_bit(PPC440SPE_DESC_RXOR123,
+				    &sw_desc->flags))
+					haddr =3D DMA_RXOR123 <<
+						DMA_CUED_REGION_OFF;
+				else if
(test_bit(PPC440SPE_DESC_RXOR124,
+				    &sw_desc->flags))
+					haddr =3D DMA_RXOR124 <<
+						DMA_CUED_REGION_OFF;
+				else if
(test_bit(PPC440SPE_DESC_RXOR125,
+				    &sw_desc->flags))
+					haddr =3D DMA_RXOR125 <<
+						DMA_CUED_REGION_OFF;
+				else
+					BUG();
+				haddr |=3D DMA_CUED_XOR_BASE;
+				iter =3D
ppc440spe_get_group_entry(sw_desc, 0);
+			} else if (index < iskip) {
+				/* 1st slot (RXOR)
+				 * shall actually set source address
only once
+				 * instead of first <iskip>
+				 */
+				iter =3D NULL;
+			} else {
+				/* 2nd/3d and next slots (WXOR);
+				 * skip first slot with RXOR
+				 */
+				haddr =3D DMA_CUED_XOR_HB;
+				iter =3D
ppc440spe_get_group_entry(sw_desc,
+				    index - iskip + sw_desc->dst_cnt);
+			}
+		} else {
+			int znum =3D 0;
+
+			/* WXOR-only operation; skip first slots with
+			 * zeroing destinations
+			 */
+			if (test_bit(PPC440SPE_ZERO_P, &sw_desc->flags))
+				znum++;
+			if (test_bit(PPC440SPE_ZERO_Q, &sw_desc->flags))
+				znum++;
+
+			haddr =3D DMA_CUED_XOR_HB;
+			iter =3D ppc440spe_get_group_entry(sw_desc,
+					index + znum);
+		}
+
+		if (likely(iter)) {
+			ppc440spe_desc_set_src_addr(iter, chan, 0,
haddr, addr);
+
+			if (!index &&
+			    test_bit(PPC440SPE_DESC_RXOR,
&sw_desc->flags) &&
+			    sw_desc->dst_cnt =3D=3D 2) {
+				/* if we have two destinations for RXOR,
then
+				 * setup source in the second descr too
+				 */
+				iter =3D
ppc440spe_get_group_entry(sw_desc, 1);
+				ppc440spe_desc_set_src_addr(iter, chan,
0,
+					haddr, addr);
+			}
+		}
+		break;
+
+	case PPC440SPE_XOR_ID:
+		/* DMA2 may do Biskup */
+		iter =3D sw_desc->group_head;
+		if (iter->dst_cnt =3D=3D 2) {
+			/* both P & Q calculations required; set P src
here */
+			ppc440spe_adma_dma2rxor_set_src(iter, index,
addr);
+
+			/* this is for Q */
+			iter =3D ppc440spe_get_group_entry(sw_desc,
+				sw_desc->descs_per_op);
+		}
+		ppc440spe_adma_dma2rxor_set_src(iter, index, addr);
+		break;
+	}
+}
+
+/**
+ * ppc440spe_adma_memcpy_xor_set_src - set source address into
descriptor
+ */
+static void ppc440spe_adma_memcpy_xor_set_src(
+		struct ppc440spe_adma_desc_slot *sw_desc,
+		dma_addr_t addr, int index)
+{
+	struct ppc440spe_adma_chan *chan;
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+	sw_desc =3D sw_desc->group_head;
+
+	if (likely(sw_desc))
+		ppc440spe_desc_set_src_addr(sw_desc, chan, index, 0,
addr);
+}
+
+/**
+ * ppc440spe_adma_dma2rxor_inc_addr  -
+ */
+static void ppc440spe_adma_dma2rxor_inc_addr(
+		struct ppc440spe_adma_desc_slot *desc,
+		struct ppc440spe_rxor *cursor, int index, int src_cnt)
+{
+	cursor->addr_count++;
+	if (index =3D=3D src_cnt - 1) {
+		ppc440spe_desc_set_xor_src_cnt(desc,
cursor->addr_count);
+	} else if (cursor->addr_count =3D=3D XOR_MAX_OPS) {
+		ppc440spe_desc_set_xor_src_cnt(desc,
cursor->addr_count);
+		cursor->addr_count =3D 0;
+		cursor->desc_count++;
+	}
+}
+
+/**
+ * ppc440spe_adma_dma2rxor_prep_src - setup RXOR types in DMA2 CDB
+ */
+static int ppc440spe_adma_dma2rxor_prep_src(
+		struct ppc440spe_adma_desc_slot *hdesc,
+		struct ppc440spe_rxor *cursor, int index,
+		int src_cnt, u32 addr)
+{
+	int rval =3D 0;
+	u32 sign;
+	struct ppc440spe_adma_desc_slot *desc =3D hdesc;
+	int i;
+
+	for (i =3D 0; i < cursor->desc_count; i++) {
+		desc =3D list_entry(hdesc->chain_node.next,
+				  struct ppc440spe_adma_desc_slot,
+				  chain_node);
+	}
+
+	switch (cursor->state) {
+	case 0:
+		if (addr =3D=3D cursor->addrl + cursor->len) {
+			/* direct RXOR */
+			cursor->state =3D 1;
+			cursor->xor_count++;
+			if (index =3D=3D src_cnt-1) {
+				ppc440spe_rxor_set_region(desc,
+					cursor->addr_count,
+					DMA_RXOR12 <<
DMA_CUED_REGION_OFF);
+				ppc440spe_adma_dma2rxor_inc_addr(
+					desc, cursor, index, src_cnt);
+			}
+		} else if (cursor->addrl =3D=3D addr + cursor->len) {
+			/* reverse RXOR */
+			cursor->state =3D 1;
+			cursor->xor_count++;
+			set_bit(cursor->addr_count,
&desc->reverse_flags[0]);
+			if (index =3D=3D src_cnt-1) {
+				ppc440spe_rxor_set_region(desc,
+					cursor->addr_count,
+					DMA_RXOR12 <<
DMA_CUED_REGION_OFF);
+				ppc440spe_adma_dma2rxor_inc_addr(
+					desc, cursor, index, src_cnt);
+			}
+		} else {
+			printk(KERN_ERR "Cannot build "
+				"DMA2 RXOR command block.\n");
+			BUG();
+		}
+		break;
+	case 1:
+		sign =3D test_bit(cursor->addr_count,
+				desc->reverse_flags)
+			? -1 : 1;
+		if (index =3D=3D src_cnt-2 || (sign =3D=3D -1
+			&& addr !=3D cursor->addrl - 2*cursor->len)) {
+			cursor->state =3D 0;
+			cursor->xor_count =3D 1;
+			cursor->addrl =3D addr;
+			ppc440spe_rxor_set_region(desc,
+				cursor->addr_count,
+				DMA_RXOR12 << DMA_CUED_REGION_OFF);
+			ppc440spe_adma_dma2rxor_inc_addr(
+				desc, cursor, index, src_cnt);
+		} else if (addr =3D=3D cursor->addrl + 2*sign*cursor->len) {
+			cursor->state =3D 2;
+			cursor->xor_count =3D 0;
+			ppc440spe_rxor_set_region(desc,
+				cursor->addr_count,
+				DMA_RXOR123 << DMA_CUED_REGION_OFF);
+			if (index =3D=3D src_cnt-1) {
+				ppc440spe_adma_dma2rxor_inc_addr(
+					desc, cursor, index, src_cnt);
+			}
+		} else if (addr =3D=3D cursor->addrl + 3*cursor->len) {
+			cursor->state =3D 2;
+			cursor->xor_count =3D 0;
+			ppc440spe_rxor_set_region(desc,
+				cursor->addr_count,
+				DMA_RXOR124 << DMA_CUED_REGION_OFF);
+			if (index =3D=3D src_cnt-1) {
+				ppc440spe_adma_dma2rxor_inc_addr(
+					desc, cursor, index, src_cnt);
+			}
+		} else if (addr =3D=3D cursor->addrl + 4*cursor->len) {
+			cursor->state =3D 2;
+			cursor->xor_count =3D 0;
+			ppc440spe_rxor_set_region(desc,
+				cursor->addr_count,
+				DMA_RXOR125 << DMA_CUED_REGION_OFF);
+			if (index =3D=3D src_cnt-1) {
+				ppc440spe_adma_dma2rxor_inc_addr(
+					desc, cursor, index, src_cnt);
+			}
+		} else {
+			cursor->state =3D 0;
+			cursor->xor_count =3D 1;
+			cursor->addrl =3D addr;
+			ppc440spe_rxor_set_region(desc,
+				cursor->addr_count,
+				DMA_RXOR12 << DMA_CUED_REGION_OFF);
+			ppc440spe_adma_dma2rxor_inc_addr(
+				desc, cursor, index, src_cnt);
+		}
+		break;
+	case 2:
+		cursor->state =3D 0;
+		cursor->addrl =3D addr;
+		cursor->xor_count++;
+		if (index) {
+			ppc440spe_adma_dma2rxor_inc_addr(
+				desc, cursor, index, src_cnt);
+		}
+		break;
+	}
+
+	return rval;
+}
+
+/**
+ * ppc440spe_adma_dma2rxor_set_src - set RXOR source address; it's
assumed that
+ *	ppc440spe_adma_dma2rxor_prep_src() has already done prior this
call
+ */
+static void ppc440spe_adma_dma2rxor_set_src(
+		struct ppc440spe_adma_desc_slot *desc,
+		int index, dma_addr_t addr)
+{
+	struct xor_cb *xcb =3D desc->hw_desc;
+	int k =3D 0, op =3D 0, lop =3D 0;
+
+	/* get the RXOR operand which corresponds to index addr */
+	while (op <=3D index) {
+		lop =3D op;
+		if (k =3D=3D XOR_MAX_OPS) {
+			k =3D 0;
+			desc =3D list_entry(desc->chain_node.next,
+				struct ppc440spe_adma_desc_slot,
chain_node);
+			xcb =3D desc->hw_desc;
+
+		}
+		if ((xcb->ops[k++].h & (DMA_RXOR12 <<
DMA_CUED_REGION_OFF)) =3D=3D
+		    (DMA_RXOR12 << DMA_CUED_REGION_OFF))
+			op +=3D 2;
+		else
+			op +=3D 3;
+	}
+
+	BUG_ON(k < 1);
+
+	if (test_bit(k-1, desc->reverse_flags)) {
+		/* reverse operand order; put last op in RXOR group */
+		if (index =3D=3D op - 1)
+			ppc440spe_rxor_set_src(desc, k - 1, addr);
+	} else {
+		/* direct operand order; put first op in RXOR group */
+		if (index =3D=3D lop)
+			ppc440spe_rxor_set_src(desc, k - 1, addr);
+	}
+}
+
+/**
+ * ppc440spe_adma_dma2rxor_set_mult - set RXOR multipliers; it's
assumed that
+ *	ppc440spe_adma_dma2rxor_prep_src() has already done prior this
call
+ */
+static void ppc440spe_adma_dma2rxor_set_mult(
+		struct ppc440spe_adma_desc_slot *desc,
+		int index, u8 mult)
+{
+	struct xor_cb *xcb =3D desc->hw_desc;
+	int k =3D 0, op =3D 0, lop =3D 0;
+
+	/* get the RXOR operand which corresponds to index mult */
+	while (op <=3D index) {
+		lop =3D op;
+		if (k =3D=3D XOR_MAX_OPS) {
+			k =3D 0;
+			desc =3D list_entry(desc->chain_node.next,
+					  struct
ppc440spe_adma_desc_slot,
+					  chain_node);
+			xcb =3D desc->hw_desc;
+
+		}
+		if ((xcb->ops[k++].h & (DMA_RXOR12 <<
DMA_CUED_REGION_OFF)) =3D=3D
+		    (DMA_RXOR12 << DMA_CUED_REGION_OFF))
+			op +=3D 2;
+		else
+			op +=3D 3;
+	}
+
+	BUG_ON(k < 1);
+	if (test_bit(k-1, desc->reverse_flags)) {
+		/* reverse order */
+		ppc440spe_rxor_set_mult(desc, k - 1, op - index - 1,
mult);
+	} else {
+		/* direct order */
+		ppc440spe_rxor_set_mult(desc, k - 1, index - lop, mult);
+	}
+}
+
+/**
+ * ppc440spe_init_rxor_cursor -
+ */
+static void ppc440spe_init_rxor_cursor(struct ppc440spe_rxor *cursor)
+{
+	memset(cursor, 0, sizeof(struct ppc440spe_rxor));
+	cursor->state =3D 2;
+}
+
+/**
+ * ppc440spe_adma_pq_set_src_mult - set multiplication coefficient into
+ * descriptor for the PQXOR operation
+ */
+static void ppc440spe_adma_pq_set_src_mult(
+		struct ppc440spe_adma_desc_slot *sw_desc,
+		unsigned char mult, int index, int dst_pos)
+{
+	struct ppc440spe_adma_chan *chan;
+	u32 mult_idx, mult_dst;
+	struct ppc440spe_adma_desc_slot *iter =3D NULL, *iter1 =3D NULL;
+
+	chan =3D to_ppc440spe_adma_chan(sw_desc->async_tx.chan);
+
+	switch (chan->device->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		if (test_bit(PPC440SPE_DESC_RXOR, &sw_desc->flags)) {
+			int region =3D test_bit(PPC440SPE_DESC_RXOR12,
+					&sw_desc->flags) ? 2 : 3;
+
+			if (index < region) {
+				/* RXOR multipliers */
+				iter =3D
ppc440spe_get_group_entry(sw_desc,
+					sw_desc->dst_cnt - 1);
+				if (sw_desc->dst_cnt =3D=3D 2)
+					iter1 =3D
ppc440spe_get_group_entry(
+							sw_desc, 0);
+
+				mult_idx =3D DMA_CUED_MULT1_OFF + (index
<< 3);
+				mult_dst =3D DMA_CDB_SG_SRC;
+			} else {
+				/* WXOR multiplier */
+				iter =3D
ppc440spe_get_group_entry(sw_desc,
+							index - region +
+
sw_desc->dst_cnt);
+				mult_idx =3D DMA_CUED_MULT1_OFF;
+				mult_dst =3D dst_pos ? DMA_CDB_SG_DST2 :
+						     DMA_CDB_SG_DST1;
+			}
+		} else {
+			int znum =3D 0;
+
+			/* WXOR-only;
+			 * skip first slots with destinations (if
ZERO_DST has
+			 * place)
+			 */
+			if (test_bit(PPC440SPE_ZERO_P, &sw_desc->flags))
+				znum++;
+			if (test_bit(PPC440SPE_ZERO_Q, &sw_desc->flags))
+				znum++;
+
+			iter =3D ppc440spe_get_group_entry(sw_desc, index
+ znum);
+			mult_idx =3D DMA_CUED_MULT1_OFF;
+			mult_dst =3D dst_pos ? DMA_CDB_SG_DST2 :
DMA_CDB_SG_DST1;
+		}
+
+		if (likely(iter)) {
+			ppc440spe_desc_set_src_mult(iter, chan,
+				mult_idx, mult_dst, mult);
+
+			if (unlikely(iter1)) {
+				/* if we have two destinations for RXOR,
then
+				 * we've just set Q mult. Set-up P now.
+				 */
+				ppc440spe_desc_set_src_mult(iter1, chan,
+					mult_idx, mult_dst, 1);
+			}
+
+		}
+		break;
+
+	case PPC440SPE_XOR_ID:
+		iter =3D sw_desc->group_head;
+		if (sw_desc->dst_cnt =3D=3D 2) {
+			/* both P & Q calculations required; set P mult
here */
+			ppc440spe_adma_dma2rxor_set_mult(iter, index,
1);
+
+			/* and then set Q mult */
+			iter =3D ppc440spe_get_group_entry(sw_desc,
+			       sw_desc->descs_per_op);
+		}
+		ppc440spe_adma_dma2rxor_set_mult(iter, index, mult);
+		break;
+	}
+}
+
+/**
+ * ppc440spe_adma_free_chan_resources - free the resources allocated
+ */
+static void ppc440spe_adma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	struct ppc440spe_adma_desc_slot *iter, *_iter;
+	int in_use_descs =3D 0;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+	ppc440spe_adma_slot_cleanup(ppc440spe_chan);
+
+	spin_lock_bh(&ppc440spe_chan->lock);
+	list_for_each_entry_safe(iter, _iter, &ppc440spe_chan->chain,
+					chain_node) {
+		in_use_descs++;
+		list_del(&iter->chain_node);
+	}
+	list_for_each_entry_safe_reverse(iter, _iter,
+			&ppc440spe_chan->all_slots, slot_node) {
+		list_del(&iter->slot_node);
+		kfree(iter);
+		ppc440spe_chan->slots_allocated--;
+	}
+	ppc440spe_chan->last_used =3D NULL;
+
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d %s slots_allocated %d\n",
+		ppc440spe_chan->device->id,
+		__func__, ppc440spe_chan->slots_allocated);
+	spin_unlock_bh(&ppc440spe_chan->lock);
+
+	/* one is ok since we left it on there on purpose */
+	if (in_use_descs > 1)
+		printk(KERN_ERR "SPE: Freeing %d in use descriptors!\n",
+			in_use_descs - 1);
+}
+
+/**
+ * ppc440spe_adma_is_complete - poll the status of an ADMA transaction
+ * @chan: ADMA channel handle
+ * @cookie: ADMA transaction identifier
+ */
+static enum dma_status ppc440spe_adma_is_complete(struct dma_chan
*chan,
+	dma_cookie_t cookie, dma_cookie_t *done, dma_cookie_t *used)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+	enum dma_status ret;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+	last_used =3D chan->cookie;
+	last_complete =3D ppc440spe_chan->completed_cookie;
+
+	if (done)
+		*done =3D last_complete;
+	if (used)
+		*used =3D last_used;
+
+	ret =3D dma_async_is_complete(cookie, last_complete, last_used);
+	if (ret =3D=3D DMA_SUCCESS)
+		return ret;
+
+	ppc440spe_adma_slot_cleanup(ppc440spe_chan);
+
+	last_used =3D chan->cookie;
+	last_complete =3D ppc440spe_chan->completed_cookie;
+
+	if (done)
+		*done =3D last_complete;
+	if (used)
+		*used =3D last_used;
+
+	return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+/**
+ * ppc440spe_adma_eot_handler - end of transfer interrupt handler
+ */
+static irqreturn_t ppc440spe_adma_eot_handler(int irq, void *data)
+{
+	struct ppc440spe_adma_chan *chan =3D data;
+
+	dev_dbg(chan->device->common.dev,
+		"ppc440spe adma%d: %s\n", chan->device->id, __func__);
+
+	tasklet_schedule(&chan->irq_tasklet);
+	ppc440spe_adma_device_clear_eot_status(chan);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ppc440spe_adma_err_handler - DMA error interrupt handler;
+ *	do the same things as a eot handler
+ */
+static irqreturn_t ppc440spe_adma_err_handler(int irq, void *data)
+{
+	struct ppc440spe_adma_chan *chan =3D data;
+
+	dev_dbg(chan->device->common.dev,
+		"ppc440spe adma%d: %s\n", chan->device->id, __func__);
+
+	tasklet_schedule(&chan->irq_tasklet);
+	ppc440spe_adma_device_clear_eot_status(chan);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ppc440spe_test_callback - called when test operation has been done
+ */
+static void ppc440spe_test_callback(void *unused)
+{
+	complete(&ppc440spe_r6_test_comp);
+}
+
+/**
+ * ppc440spe_adma_issue_pending - flush all pending descriptors to h/w
+ */
+static void ppc440spe_adma_issue_pending(struct dma_chan *chan)
+{
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+
+	ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+	dev_dbg(ppc440spe_chan->device->common.dev,
+		"ppc440spe adma%d: %s %d \n",
ppc440spe_chan->device->id,
+		__func__, ppc440spe_chan->pending);
+
+	if (ppc440spe_chan->pending) {
+		ppc440spe_chan->pending =3D 0;
+		ppc440spe_chan_append(ppc440spe_chan);
+	}
+}
+
+/**
+ * ppc440spe_chan_start_null_xor - initiate the first XOR operation
(DMA engines
+ *	use FIFOs (as opposite to chains used in XOR) so this is a XOR
+ *	specific operation)
+ */
+static void ppc440spe_chan_start_null_xor(struct ppc440spe_adma_chan
*chan)
+{
+	struct ppc440spe_adma_desc_slot *sw_desc, *group_start;
+	dma_cookie_t cookie;
+	int slot_cnt, slots_per_op;
+
+	dev_dbg(chan->device->common.dev,
+		"ppc440spe adma%d: %s\n", chan->device->id, __func__);
+
+	spin_lock_bh(&chan->lock);
+	slot_cnt =3D ppc440spe_chan_xor_slot_count(0, 2, &slots_per_op);
+	sw_desc =3D ppc440spe_adma_alloc_slots(chan, slot_cnt,
slots_per_op);
+	if (sw_desc) {
+		group_start =3D sw_desc->group_head;
+		list_splice_init(&sw_desc->group_list, &chan->chain);
+		async_tx_ack(&sw_desc->async_tx);
+		ppc440spe_desc_init_null_xor(group_start);
+
+		cookie =3D chan->common.cookie;
+		cookie++;
+		if (cookie <=3D 1)
+			cookie =3D 2;
+
+		/* initialize the completed cookie to be less than
+		 * the most recently used cookie
+		 */
+		chan->completed_cookie =3D cookie - 1;
+		chan->common.cookie =3D sw_desc->async_tx.cookie =3D cookie;
+
+		/* channel should not be busy */
+		BUG_ON(ppc440spe_chan_is_busy(chan));
+
+		/* set the descriptor address */
+		ppc440spe_chan_set_first_xor_descriptor(chan, sw_desc);
+
+		/* run the descriptor */
+		ppc440spe_chan_run(chan);
+	} else
+		printk(KERN_ERR "ppc440spe adma%d"
+			" failed to allocate null descriptor\n",
+			chan->device->id);
+	spin_unlock_bh(&chan->lock);
+}
+
+/**
+ * ppc440spe_test_raid6 - test are RAID-6 capabilities enabled
successfully.
+ *	For this we just perform one WXOR operation with the same source
+ *	and destination addresses, the GF-multiplier is 1; so if RAID-6
+ *	capabilities are enabled then we'll get src/dst filled with
zero.
+ */
+static int ppc440spe_test_raid6(struct ppc440spe_adma_chan *chan)
+{
+	struct ppc440spe_adma_desc_slot *sw_desc, *iter;
+	struct page *pg;
+	char *a;
+	dma_addr_t dma_addr, addrs[2];
+	unsigned long op =3D 0;
+	int rval =3D 0;
+
+	set_bit(PPC440SPE_DESC_WXOR, &op);
+
+	pg =3D alloc_page(GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
+
+	spin_lock_bh(&chan->lock);
+	sw_desc =3D ppc440spe_adma_alloc_slots(chan, 1, 1);
+	if (sw_desc) {
+		/* 1 src, 1 dsr, int_ena, WXOR */
+		ppc440spe_desc_init_dma01pq(sw_desc, 1, 1, 1, op);
+		list_for_each_entry(iter, &sw_desc->group_list,
chain_node) {
+			ppc440spe_desc_set_byte_count(iter, chan,
PAGE_SIZE);
+			iter->unmap_len =3D PAGE_SIZE;
+		}
+	} else {
+		rval =3D -EFAULT;
+		spin_unlock_bh(&chan->lock);
+		goto exit;
+	}
+	spin_unlock_bh(&chan->lock);
+
+	/* Fill the test page with ones */
+	memset(page_address(pg), 0xFF, PAGE_SIZE);
+	dma_addr =3D dma_map_page(chan->device->dev, pg, 0,
+				PAGE_SIZE, DMA_BIDIRECTIONAL);
+
+	/* Setup addresses */
+	ppc440spe_adma_pq_set_src(sw_desc, dma_addr, 0);
+	ppc440spe_adma_pq_set_src_mult(sw_desc, 1, 0, 0);
+	addrs[0] =3D dma_addr;
+	addrs[1] =3D 0;
+	ppc440spe_adma_pq_set_dest(sw_desc, addrs,
DMA_PREP_PQ_DISABLE_Q);
+
+	async_tx_ack(&sw_desc->async_tx);
+	sw_desc->async_tx.callback =3D ppc440spe_test_callback;
+	sw_desc->async_tx.callback_param =3D NULL;
+
+	init_completion(&ppc440spe_r6_test_comp);
+
+	ppc440spe_adma_tx_submit(&sw_desc->async_tx);
+	ppc440spe_adma_issue_pending(&chan->common);
+
+	wait_for_completion(&ppc440spe_r6_test_comp);
+
+	/* Now check if the test page is zeroed */
+	a =3D page_address(pg);
+	if ((*(u32 *)a) =3D=3D 0 && memcmp(a, a+4, PAGE_SIZE-4) =3D=3D 0) {
+		/* page is zero - RAID-6 enabled */
+		rval =3D 0;
+	} else {
+		/* RAID-6 was not enabled */
+		rval =3D -EINVAL;
+	}
+exit:
+	__free_page(pg);
+	return rval;
+}
+
+static void ppc440spe_adma_init_capabilities(struct
ppc440spe_adma_device *adev)
+{
+	switch (adev->id) {
+	case PPC440SPE_DMA0_ID:
+	case PPC440SPE_DMA1_ID:
+		dma_cap_set(DMA_MEMCPY, adev->common.cap_mask);
+		dma_cap_set(DMA_INTERRUPT, adev->common.cap_mask);
+		dma_cap_set(DMA_MEMSET, adev->common.cap_mask);
+		dma_cap_set(DMA_PQ, adev->common.cap_mask);
+		dma_cap_set(DMA_PQ_VAL, adev->common.cap_mask);
+		dma_cap_set(DMA_XOR_VAL, adev->common.cap_mask);
+		break;
+	case PPC440SPE_XOR_ID:
+		dma_cap_set(DMA_XOR, adev->common.cap_mask);
+		dma_cap_set(DMA_PQ, adev->common.cap_mask);
+		dma_cap_set(DMA_INTERRUPT, adev->common.cap_mask);
+		adev->common.cap_mask =3D adev->common.cap_mask;
+		break;
+	}
+
+	/* Set base routines */
+	adev->common.device_alloc_chan_resources =3D
+				ppc440spe_adma_alloc_chan_resources;
+	adev->common.device_free_chan_resources =3D
+				ppc440spe_adma_free_chan_resources;
+	adev->common.device_is_tx_complete =3D ppc440spe_adma_is_complete;
+	adev->common.device_issue_pending =3D
ppc440spe_adma_issue_pending;
+
+	/* Set prep routines based on capability */
+	if (dma_has_cap(DMA_MEMCPY, adev->common.cap_mask)) {
+		adev->common.device_prep_dma_memcpy =3D
+			ppc440spe_adma_prep_dma_memcpy;
+	}
+	if (dma_has_cap(DMA_MEMSET, adev->common.cap_mask)) {
+		adev->common.device_prep_dma_memset =3D
+			ppc440spe_adma_prep_dma_memset;
+	}
+	if (dma_has_cap(DMA_XOR, adev->common.cap_mask)) {
+		adev->common.max_xor =3D XOR_MAX_OPS;
+		adev->common.device_prep_dma_xor =3D
+			ppc440spe_adma_prep_dma_xor;
+	}
+	if (dma_has_cap(DMA_PQ, adev->common.cap_mask)) {
+		switch (adev->id) {
+		case PPC440SPE_DMA0_ID:
+			dma_set_maxpq(&adev->common,
+				DMA0_FIFO_SIZE / sizeof(struct dma_cdb),
0);
+			break;
+		case PPC440SPE_DMA1_ID:
+			dma_set_maxpq(&adev->common,
+				DMA1_FIFO_SIZE / sizeof(struct dma_cdb),
0);
+			break;
+		case PPC440SPE_XOR_ID:
+			adev->common.max_pq =3D XOR_MAX_OPS * 3;
+			break;
+		}
+		adev->common.device_prep_dma_pq =3D
+			ppc440spe_adma_prep_dma_pq;
+	}
+	if (dma_has_cap(DMA_PQ_VAL, adev->common.cap_mask)) {
+		switch (adev->id) {
+		case PPC440SPE_DMA0_ID:
+			adev->common.max_pq =3D DMA0_FIFO_SIZE /
+						sizeof(struct dma_cdb);
+			break;
+		case PPC440SPE_DMA1_ID:
+			adev->common.max_pq =3D DMA1_FIFO_SIZE /
+						sizeof(struct dma_cdb);
+			break;
+		}
+		adev->common.device_prep_dma_pq_val =3D
+			ppc440spe_adma_prep_dma_pqzero_sum;
+	}
+	if (dma_has_cap(DMA_XOR_VAL, adev->common.cap_mask)) {
+		switch (adev->id) {
+		case PPC440SPE_DMA0_ID:
+			adev->common.max_xor =3D DMA0_FIFO_SIZE /
+						sizeof(struct dma_cdb);
+			break;
+		case PPC440SPE_DMA1_ID:
+			adev->common.max_xor =3D DMA1_FIFO_SIZE /
+						sizeof(struct dma_cdb);
+			break;
+		}
+		adev->common.device_prep_dma_xor_val =3D
+			ppc440spe_adma_prep_dma_xor_zero_sum;
+	}
+	if (dma_has_cap(DMA_INTERRUPT, adev->common.cap_mask)) {
+		adev->common.device_prep_dma_interrupt =3D
+			ppc440spe_adma_prep_dma_interrupt;
+	}
+	pr_info("%s: AMCC(R) PPC440SP(E) ADMA Engine: "
+	  "( %s%s%s%s%s%s%s)\n",
+	  dev_name(adev->dev),
+	  dma_has_cap(DMA_PQ, adev->common.cap_mask) ? "pq " : "",
+	  dma_has_cap(DMA_PQ_VAL, adev->common.cap_mask) ? "pq_val " :
"",
+	  dma_has_cap(DMA_XOR, adev->common.cap_mask) ? "xor " : "",
+	  dma_has_cap(DMA_XOR_VAL, adev->common.cap_mask) ? "xor_val " :
"",
+	  dma_has_cap(DMA_MEMCPY, adev->common.cap_mask) ? "memcpy " :
"",
+	  dma_has_cap(DMA_MEMSET, adev->common.cap_mask)  ? "memset " :
"",
+	  dma_has_cap(DMA_INTERRUPT, adev->common.cap_mask) ? "intr " :
"");
+}
+
+static int ppc440spe_adma_setup_irqs(struct ppc440spe_adma_device
*adev,
+				     struct ppc440spe_adma_chan *chan,
+				     int *initcode)
+{
+	struct device_node *np;
+	int ret;
+
+	np =3D container_of(adev->dev, struct of_device, dev)->node;
+	if (adev->id !=3D PPC440SPE_XOR_ID) {
+		adev->err_irq =3D irq_of_parse_and_map(np, 1);
+		if (adev->err_irq =3D=3D NO_IRQ) {
+			dev_warn(adev->dev, "no err irq resource?\n");
+			*initcode =3D PPC_ADMA_INIT_IRQ2;
+			adev->err_irq =3D -ENXIO;
+		} else
+			atomic_inc(&ppc440spe_adma_err_irq_ref);
+	} else {
+		adev->err_irq =3D -ENXIO;
+	}
+
+	adev->irq =3D irq_of_parse_and_map(np, 0);
+	if (adev->irq =3D=3D NO_IRQ) {
+		dev_err(adev->dev, "no irq resource\n");
+		*initcode =3D PPC_ADMA_INIT_IRQ1;
+		ret =3D -ENXIO;
+		goto err_irq_map;
+	}
+	dev_dbg(adev->dev, "irq %d, err irq %d\n",
+		adev->irq, adev->err_irq);
+
+	ret =3D request_irq(adev->irq, ppc440spe_adma_eot_handler,
+			  0, dev_driver_string(adev->dev), chan);
+	if (ret) {
+		dev_err(adev->dev, "can't request irq %d\n",
+			adev->irq);
+		*initcode =3D PPC_ADMA_INIT_IRQ1;
+		ret =3D -EIO;
+		goto err_req1;
+	}
+
+	/* only DMA engines have a separate error IRQ
+	 * so it's Ok if err_irq < 0 in XOR engine case.
+	 */
+	if (adev->err_irq > 0) {
+		/* both DMA engines share common error IRQ */
+		ret =3D request_irq(adev->err_irq,
+				  ppc440spe_adma_err_handler,
+				  IRQF_SHARED,
+				  dev_driver_string(adev->dev),
+				  chan);
+		if (ret) {
+			dev_err(adev->dev, "can't request irq %d\n",
+				adev->err_irq);
+			*initcode =3D PPC_ADMA_INIT_IRQ2;
+			ret =3D -EIO;
+			goto err_req2;
+		}
+	}
+
+	if (adev->id =3D=3D PPC440SPE_XOR_ID) {
+		/* enable XOR engine interrupts */
+		iowrite32be(XOR_IE_CBCIE_BIT | XOR_IE_ICBIE_BIT |
+			    XOR_IE_ICIE_BIT | XOR_IE_RPTIE_BIT,
+			    &adev->xor_reg->ier);
+	} else {
+		u32 mask, enable;
+
+		np =3D of_find_compatible_node(NULL, NULL,
"ibm,i2o-440spe");
+		if (!np) {
+			pr_err("%s: can't find I2O device tree node\n",
+				__func__);
+			ret =3D -ENODEV;
+			goto err_req2;
+		}
+		adev->i2o_reg =3D of_iomap(np, 0);
+		if (!adev->i2o_reg) {
+			pr_err("%s: failed to map I2O registers\n",
__func__);
+			of_node_put(np);
+			ret =3D -EINVAL;
+			goto err_req2;
+		}
+		of_node_put(np);
+		/* Unmask 'CS FIFO Attention' interrupts and
+		 * enable generating interrupts on errors
+		 */
+		enable =3D (adev->id =3D=3D PPC440SPE_DMA0_ID) ?
+			 ~(I2O_IOPIM_P0SNE | I2O_IOPIM_P0EM) :
+			 ~(I2O_IOPIM_P1SNE | I2O_IOPIM_P1EM);
+		mask =3D ioread32(&adev->i2o_reg->iopim) & enable;
+		iowrite32(mask, &adev->i2o_reg->iopim);
+	}
+	return 0;
+
+err_req2:
+	free_irq(adev->irq, chan);
+err_req1:
+	irq_dispose_mapping(adev->irq);
+err_irq_map:
+	if (adev->err_irq > 0) {
+		if (atomic_dec_and_test(&ppc440spe_adma_err_irq_ref))
+			irq_dispose_mapping(adev->err_irq);
+	}
+	return ret;
+}
+
+static void ppc440spe_adma_release_irqs(struct ppc440spe_adma_device
*adev,
+					struct ppc440spe_adma_chan
*chan)
+{
+	u32 mask, disable;
+
+	if (adev->id =3D=3D PPC440SPE_XOR_ID) {
+		/* disable XOR engine interrupts */
+		mask =3D ioread32be(&adev->xor_reg->ier);
+		mask &=3D ~(XOR_IE_CBCIE_BIT | XOR_IE_ICBIE_BIT |
+			  XOR_IE_ICIE_BIT | XOR_IE_RPTIE_BIT);
+		iowrite32be(mask, &adev->xor_reg->ier);
+	} else {
+		/* disable DMAx engine interrupts */
+		disable =3D (adev->id =3D=3D PPC440SPE_DMA0_ID) ?
+			  (I2O_IOPIM_P0SNE | I2O_IOPIM_P0EM) :
+			  (I2O_IOPIM_P1SNE | I2O_IOPIM_P1EM);
+		mask =3D ioread32(&adev->i2o_reg->iopim) | disable;
+		iowrite32(mask, &adev->i2o_reg->iopim);
+	}
+	free_irq(adev->irq, chan);
+	irq_dispose_mapping(adev->irq);
+	if (adev->err_irq > 0) {
+		free_irq(adev->err_irq, chan);
+		if (atomic_dec_and_test(&ppc440spe_adma_err_irq_ref)) {
+			irq_dispose_mapping(adev->err_irq);
+			iounmap(adev->i2o_reg);
+		}
+	}
+}
+
+/**
+ * ppc440spe_adma_probe - probe the asynch device
+ */
+static int __devinit ppc440spe_adma_probe(struct of_device *ofdev,
+					  const struct of_device_id
*match)
+{
+	struct device_node *np =3D ofdev->node;
+	struct resource res;
+	struct ppc440spe_adma_device *adev;
+	struct ppc440spe_adma_chan *chan;
+	struct ppc_dma_chan_ref *ref, *_ref;
+	int ret =3D 0, initcode =3D PPC_ADMA_INIT_OK;
+	const u32 *idx;
+	int len;
+	void *regs;
+	u32 id, pool_size;
+
+	if (of_device_is_compatible(np, "amcc,xor-accelerator")) {
+		id =3D PPC440SPE_XOR_ID;
+		/* As far as the XOR engine is concerned, it does not
+		 * use FIFOs but uses linked list. So there is no
dependency
+		 * between pool size to allocate and the engine
configuration.
+		 */
+		pool_size =3D PAGE_SIZE << 1;
+	} else {
+		/* it is DMA0 or DMA1 */
+		idx =3D of_get_property(np, "cell-index", &len);
+		if (!idx || (len !=3D sizeof(u32))) {
+			dev_err(&ofdev->dev, "Device node %s has missing
"
+				"or invalid cell-index property\n",
+				np->full_name);
+			return -EINVAL;
+		}
+		id =3D *idx;
+		/* DMA0,1 engines use FIFO to maintain CDBs, so we
+		 * should allocate the pool accordingly to size of this
+		 * FIFO. Thus, the pool size depends on the FIFO depth:
+		 * how much CDBs pointers the FIFO may contain then so
+		 * much CDBs we should provide in the pool.
+		 * That is
+		 *   CDB size =3D 32B;
+		 *   CDBs number =3D (DMA0_FIFO_SIZE >> 3);
+		 *   Pool size =3D CDBs number * CDB size =3D
+		 *      =3D (DMA0_FIFO_SIZE >> 3) << 5 =3D DMA0_FIFO_SIZE <<
2.
+		 */
+		pool_size =3D (id =3D=3D PPC440SPE_DMA0_ID) ?
+			    DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
+		pool_size <<=3D 2;
+	}
+
+	if (of_address_to_resource(np, 0, &res)) {
+		dev_err(&ofdev->dev, "failed to get memory resource\n");
+		initcode =3D PPC_ADMA_INIT_MEMRES;
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	if (!request_mem_region(res.start, resource_size(&res),
+				dev_driver_string(&ofdev->dev))) {
+		dev_err(&ofdev->dev, "failed to request memory region "
+			"(0x%016llx-0x%016llx)\n",
+			(u64)res.start, (u64)res.end);
+		initcode =3D PPC_ADMA_INIT_MEMREG;
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	/* create a device */
+	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev) {
+		dev_err(&ofdev->dev, "failed to allocate device\n");
+		initcode =3D PPC_ADMA_INIT_ALLOC;
+		ret =3D -ENOMEM;
+		goto err_adev_alloc;
+	}
+
+	adev->id =3D id;
+	adev->pool_size =3D pool_size;
+	/* allocate coherent memory for hardware descriptors */
+	adev->dma_desc_pool_virt =3D dma_alloc_coherent(&ofdev->dev,
+					adev->pool_size,
&adev->dma_desc_pool,
+					GFP_KERNEL);
+	if (adev->dma_desc_pool_virt =3D=3D NULL) {
+		dev_err(&ofdev->dev, "failed to allocate %d bytes of
coherent "
+			"memory for hardware descriptors\n",
+			adev->pool_size);
+		initcode =3D PPC_ADMA_INIT_COHERENT;
+		ret =3D -ENOMEM;
+		goto err_dma_alloc;
+	}
+	dev_dbg(&ofdev->dev, "allocted descriptor pool virt 0x%p phys
0x%llx\n",
+		adev->dma_desc_pool_virt, (u64)adev->dma_desc_pool);
+
+	regs =3D ioremap(res.start, resource_size(&res));
+	if (!regs) {
+		dev_err(&ofdev->dev, "failed to ioremap regs!\n");
+		goto err_regs_alloc;
+	}
+
+	if (adev->id =3D=3D PPC440SPE_XOR_ID) {
+		adev->xor_reg =3D regs;
+		/* Reset XOR */
+		iowrite32be(XOR_CRSR_XASR_BIT, &adev->xor_reg->crsr);
+		iowrite32be(XOR_CRSR_64BA_BIT, &adev->xor_reg->crrr);
+	} else {
+		size_t fifo_size =3D (adev->id =3D=3D PPC440SPE_DMA0_ID) ?
+				   DMA0_FIFO_SIZE : DMA1_FIFO_SIZE;
+		adev->dma_reg =3D regs;
+		/* DMAx_FIFO_SIZE is defined in bytes,
+		 * <fsiz> - is defined in number of CDB pointers
(8byte).
+		 * DMA FIFO Length =3D CSlength + CPlength, where
+		 * CSlength =3D CPlength =3D (fsiz + 1) * 8.
+		 */
+		iowrite32(DMA_FIFO_ENABLE | ((fifo_size >> 3) - 2),
+			  &adev->dma_reg->fsiz);
+		/* Configure DMA engine */
+		iowrite32(DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP |
DMA_CFG_FALGN,
+			  &adev->dma_reg->cfg);
+		/* Clear Status */
+		iowrite32(~0, &adev->dma_reg->dsts);
+	}
+
+	adev->dev =3D &ofdev->dev;
+	adev->common.dev =3D &ofdev->dev;
+	INIT_LIST_HEAD(&adev->common.channels);
+	dev_set_drvdata(&ofdev->dev, adev);
+
+	/* create a channel */
+	chan =3D kzalloc(sizeof(*chan), GFP_KERNEL);
+	if (!chan) {
+		dev_err(&ofdev->dev, "can't allocate channel
structure\n");
+		initcode =3D PPC_ADMA_INIT_CHANNEL;
+		ret =3D -ENOMEM;
+		goto err_chan_alloc;
+	}
+
+	spin_lock_init(&chan->lock);
+	INIT_LIST_HEAD(&chan->chain);
+	INIT_LIST_HEAD(&chan->all_slots);
+	chan->device =3D adev;
+	chan->common.device =3D &adev->common;
+	list_add_tail(&chan->common.device_node,
&adev->common.channels);
+	tasklet_init(&chan->irq_tasklet, ppc440spe_adma_tasklet,
+		     (unsigned long)chan);
+
+	/* allocate and map helper pages for async validation or
+	 * async_mult/async_sum_product operations on DMA0/1.
+	 */
+	if (adev->id !=3D PPC440SPE_XOR_ID) {
+		chan->pdest_page =3D alloc_page(GFP_KERNEL);
+		chan->qdest_page =3D alloc_page(GFP_KERNEL);
+		if (!chan->pdest_page ||
+		    !chan->qdest_page) {
+			if (chan->pdest_page)
+				__free_page(chan->pdest_page);
+			if (chan->qdest_page)
+				__free_page(chan->qdest_page);
+			ret =3D -ENOMEM;
+			goto err_page_alloc;
+		}
+		chan->pdest =3D dma_map_page(&ofdev->dev,
chan->pdest_page, 0,
+					   PAGE_SIZE,
DMA_BIDIRECTIONAL);
+		chan->qdest =3D dma_map_page(&ofdev->dev,
chan->qdest_page, 0,
+					   PAGE_SIZE,
DMA_BIDIRECTIONAL);
+	}
+
+	ref =3D kmalloc(sizeof(*ref), GFP_KERNEL);
+	if (ref) {
+		ref->chan =3D &chan->common;
+		INIT_LIST_HEAD(&ref->node);
+		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
+	} else {
+		dev_err(&ofdev->dev, "failed to allocate channel
reference!\n");
+		ret =3D -ENOMEM;
+		goto err_ref_alloc;
+	}
+
+	ret =3D ppc440spe_adma_setup_irqs(adev, chan, &initcode);
+	if (ret)
+		goto err_irq;
+
+	ppc440spe_adma_init_capabilities(adev);
+
+	ret =3D dma_async_device_register(&adev->common);
+	if (ret) {
+		initcode =3D PPC_ADMA_INIT_REGISTER;
+		dev_err(&ofdev->dev, "failed to register dma device\n");
+		goto err_dev_reg;
+	}
+
+	goto out;
+
+err_dev_reg:
+	ppc440spe_adma_release_irqs(adev, chan);
+err_irq:
+	list_for_each_entry_safe(ref, _ref, &ppc440spe_adma_chan_list,
node) {
+		if (chan =3D=3D to_ppc440spe_adma_chan(ref->chan)) {
+			list_del(&ref->node);
+			kfree(ref);
+		}
+	}
+err_ref_alloc:
+	if (adev->id !=3D PPC440SPE_XOR_ID) {
+		dma_unmap_page(&ofdev->dev, chan->pdest,
+			       PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dma_unmap_page(&ofdev->dev, chan->qdest,
+			       PAGE_SIZE, DMA_BIDIRECTIONAL);
+		__free_page(chan->pdest_page);
+		__free_page(chan->qdest_page);
+	}
+err_page_alloc:
+	kfree(chan);
+err_chan_alloc:
+	if (adev->id =3D=3D PPC440SPE_XOR_ID)
+		iounmap(adev->xor_reg);
+	else
+		iounmap(adev->dma_reg);
+err_regs_alloc:
+	dma_free_coherent(adev->dev, adev->pool_size,
+			  adev->dma_desc_pool_virt,
+			  adev->dma_desc_pool);
+err_dma_alloc:
+	kfree(adev);
+err_adev_alloc:
+	release_mem_region(res.start, resource_size(&res));
+out:
+	if (id < PPC440SPE_ADMA_ENGINES_NUM)
+		ppc440spe_adma_devices[id] =3D initcode;
+
+	return ret;
+}
+
+/**
+ * ppc440spe_adma_remove - remove the asynch device
+ */
+static int __devexit ppc440spe_adma_remove(struct of_device *ofdev)
+{
+	struct ppc440spe_adma_device *adev =3D
dev_get_drvdata(&ofdev->dev);
+	struct device_node *np =3D ofdev->node;
+	struct resource res;
+	struct dma_chan *chan, *_chan;
+	struct ppc_dma_chan_ref *ref, *_ref;
+	struct ppc440spe_adma_chan *ppc440spe_chan;
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+	if (adev->id < PPC440SPE_ADMA_ENGINES_NUM)
+		ppc440spe_adma_devices[adev->id] =3D -1;
+
+	dma_async_device_unregister(&adev->common);
+
+	list_for_each_entry_safe(chan, _chan, &adev->common.channels,
+				 device_node) {
+		ppc440spe_chan =3D to_ppc440spe_adma_chan(chan);
+		ppc440spe_adma_release_irqs(adev, ppc440spe_chan);
+		tasklet_kill(&ppc440spe_chan->irq_tasklet);
+		if (adev->id !=3D PPC440SPE_XOR_ID) {
+			dma_unmap_page(&ofdev->dev,
ppc440spe_chan->pdest,
+					PAGE_SIZE, DMA_BIDIRECTIONAL);
+			dma_unmap_page(&ofdev->dev,
ppc440spe_chan->qdest,
+					PAGE_SIZE, DMA_BIDIRECTIONAL);
+			__free_page(ppc440spe_chan->pdest_page);
+			__free_page(ppc440spe_chan->qdest_page);
+		}
+		list_for_each_entry_safe(ref, _ref,
&ppc440spe_adma_chan_list,
+					 node) {
+			if (ppc440spe_chan =3D=3D
+			    to_ppc440spe_adma_chan(ref->chan)) {
+				list_del(&ref->node);
+				kfree(ref);
+			}
+		}
+		list_del(&chan->device_node);
+		kfree(ppc440spe_chan);
+	}
+
+	dma_free_coherent(adev->dev, adev->pool_size,
+			  adev->dma_desc_pool_virt,
adev->dma_desc_pool);
+	if (adev->id =3D=3D PPC440SPE_XOR_ID)
+		iounmap(adev->xor_reg);
+	else
+		iounmap(adev->dma_reg);
+	of_address_to_resource(np, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+	kfree(adev);
+	return 0;
+}
+
+/*
+ * /sys driver interface to enable h/w RAID-6 capabilities
+ * Files created in e.g. /sys/devices/plb.0/400100100.dma0/driver/
+ * directory are "devices", "enable" and "poly".
+ * "devices" shows available engines.
+ * "enable" is used to enable RAID-6 capabilities or to check
+ * whether these has been activated.
+ * "poly" allows setting/checking used polynomial (for PPC440SPe only).
+ */
+
+static ssize_t show_ppc440spe_devices(struct device_driver *dev, char
*buf)
+{
+	ssize_t size =3D 0;
+	int i;
+
+	for (i =3D 0; i < PPC440SPE_ADMA_ENGINES_NUM; i++) {
+		if (ppc440spe_adma_devices[i] =3D=3D -1)
+			continue;
+		size +=3D snprintf(buf + size, PAGE_SIZE - size,
+				 "PPC440SP(E)-ADMA.%d: %s\n", i,
+
ppc_adma_errors[ppc440spe_adma_devices[i]]);
+	}
+	return size;
+}
+
+static ssize_t show_ppc440spe_r6enable(struct device_driver *dev, char
*buf)
+{
+	return snprintf(buf, PAGE_SIZE,
+			"PPC440SP(e) RAID-6 capabilities are
%sABLED.\n",
+			ppc440spe_r6_enabled ? "EN" : "DIS");
+}
+
+static ssize_t store_ppc440spe_r6enable(struct device_driver *dev,
+					const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (!count || count > 11)
+		return -EINVAL;
+
+	if (!ppc440spe_r6_tchan)
+		return -EFAULT;
+
+	/* Write a key */
+	sscanf(buf, "%lx", &val);
+	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_XORBA, val);
+	isync();
+
+	/* Verify whether it really works now */
+	if (ppc440spe_test_raid6(ppc440spe_r6_tchan) =3D=3D 0) {
+		pr_info("PPC440SP(e) RAID-6 has been activated "
+			"successfully\n");
+		ppc440spe_r6_enabled =3D 1;
+	} else {
+		pr_info("PPC440SP(e) RAID-6 hasn't been activated!"
+			" Error key ?\n");
+		ppc440spe_r6_enabled =3D 0;
+	}
+	return count;
+}
+
+static ssize_t show_ppc440spe_r6poly(struct device_driver *dev, char
*buf)
+{
+	ssize_t size =3D 0;
+	u32 reg;
+
+#ifdef CONFIG_440SP
+	/* 440SP has fixed polynomial */
+	reg =3D 0x4d;
+#else
+	reg =3D dcr_read(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL);
+	reg >>=3D MQ0_CFBHL_POLY;
+	reg &=3D 0xFF;
+#endif
+
+	size =3D snprintf(buf, PAGE_SIZE, "PPC440SP(e) RAID-6 driver "
+			"uses 0x1%02x polynomial.\n", reg);
+	return size;
+}
+
+static ssize_t store_ppc440spe_r6poly(struct device_driver *dev,
+				      const char *buf, size_t count)
+{
+	unsigned long reg, val;
+
+#ifdef CONFIG_440SP
+	/* 440SP uses default 0x14D polynomial only */
+	return -EINVAL;
+#endif
+
+	if (!count || count > 6)
+		return -EINVAL;
+
+	/* e.g., 0x14D or 0x11D */
+	sscanf(buf, "%lx", &val);
+
+	if (val & ~0x1FF)
+		return -EINVAL;
+
+	val &=3D 0xFF;
+	reg =3D dcr_read(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL);
+	reg &=3D ~(0xFF << MQ0_CFBHL_POLY);
+	reg |=3D val << MQ0_CFBHL_POLY;
+	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL, reg);
+
+	return count;
+}
+
+static DRIVER_ATTR(devices, S_IRUGO, show_ppc440spe_devices, NULL);
+static DRIVER_ATTR(enable, S_IRUGO | S_IWUSR, show_ppc440spe_r6enable,
+		   store_ppc440spe_r6enable);
+static DRIVER_ATTR(poly, S_IRUGO | S_IWUSR, show_ppc440spe_r6poly,
+		   store_ppc440spe_r6poly);
+
+/*
+ * Common initialisation for RAID engines; allocate memory for
+ * DMAx FIFOs, perform configuration common for all DMA engines.
+ * Further DMA engine specific configuration is done at probe time.
+ */
+static int ppc440spe_configure_raid_devices(void)
+{
+	struct device_node *np;
+	struct resource i2o_res;
+	struct i2o_regs __iomem *i2o_reg;
+	dcr_host_t i2o_dcr_host;
+	unsigned int dcr_base, dcr_len;
+	int i, ret;
+
+	np =3D of_find_compatible_node(NULL, NULL, "ibm,i2o-440spe");
+	if (!np) {
+		pr_err("%s: can't find I2O device tree node\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(np, 0, &i2o_res)) {
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	i2o_reg =3D of_iomap(np, 0);
+	if (!i2o_reg) {
+		pr_err("%s: failed to map I2O registers\n", __func__);
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	/* Get I2O DCRs base */
+	dcr_base =3D dcr_resource_start(np, 0);
+	dcr_len =3D dcr_resource_len(np, 0);
+	if (!dcr_base && !dcr_len) {
+		pr_err("%s: can't get DCR registers base/len!\n",
+			np->full_name);
+		of_node_put(np);
+		iounmap(i2o_reg);
+		return -ENODEV;
+	}
+
+	i2o_dcr_host =3D dcr_map(np, dcr_base, dcr_len);
+	if (!DCR_MAP_OK(i2o_dcr_host)) {
+		pr_err("%s: failed to map DCRs!\n", np->full_name);
+		of_node_put(np);
+		iounmap(i2o_reg);
+		return -ENODEV;
+	}
+	of_node_put(np);
+
+	/* Provide memory regions for DMA's FIFOs: I2O, DMA0 and DMA1
share
+	 * the base address of FIFO memory space.
+	 * Actually we need twice more physical memory than programmed
in the
+	 * <fsiz> register (because there are two FIFOs for each DMA: CP
and CS)
+	 */
+	ppc440spe_dma_fifo_buf =3D kmalloc((DMA0_FIFO_SIZE +
DMA1_FIFO_SIZE) << 1,
+					 GFP_KERNEL);
+	if (!ppc440spe_dma_fifo_buf) {
+		pr_err("%s: DMA FIFO buffer allocation failed.\n",
__func__);
+		iounmap(i2o_reg);
+		dcr_unmap(i2o_dcr_host, dcr_len);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Configure h/w
+	 */
+	/* Reset I2O/DMA */
+	mtdcri(SDR0, DCRN_SDR0_SRST, DCRN_SDR0_SRST_I2ODMA);
+	mtdcri(SDR0, DCRN_SDR0_SRST, 0);
+
+	/* Setup the base address of mmaped registers */
+	dcr_write(i2o_dcr_host, DCRN_I2O0_IBAH, (u32)(i2o_res.start >>
32));
+	dcr_write(i2o_dcr_host, DCRN_I2O0_IBAL, (u32)(i2o_res.start) |
+						I2O_REG_ENABLE);
+	dcr_unmap(i2o_dcr_host, dcr_len);
+
+	/* Setup FIFO memory space base address */
+	iowrite32(0, &i2o_reg->ifbah);
+	iowrite32(((u32)__pa(ppc440spe_dma_fifo_buf)), &i2o_reg->ifbal);
+
+	/* set zero FIFO size for I2O, so the whole
+	 * ppc440spe_dma_fifo_buf is used by DMAs.
+	 * DMAx_FIFOs will be configured while probe.
+	 */
+	iowrite32(0, &i2o_reg->ifsiz);
+	iounmap(i2o_reg);
+
+	/* To prepare WXOR/RXOR functionality we need access to
+	 * Memory Queue Module DCRs (finally it will be enabled
+	 * via /sys interface of the ppc440spe ADMA driver).
+	 */
+	np =3D of_find_compatible_node(NULL, NULL, "ibm,mq-440spe");
+	if (!np) {
+		pr_err("%s: can't find MQ device tree node\n",
+			__func__);
+		ret =3D -ENODEV;
+		goto out_free;
+	}
+
+	/* Get MQ DCRs base */
+	dcr_base =3D dcr_resource_start(np, 0);
+	dcr_len =3D dcr_resource_len(np, 0);
+	if (!dcr_base && !dcr_len) {
+		pr_err("%s: can't get DCR registers base/len!\n",
+			np->full_name);
+		ret =3D -ENODEV;
+		goto out_mq;
+	}
+
+	ppc440spe_mq_dcr_host =3D dcr_map(np, dcr_base, dcr_len);
+	if (!DCR_MAP_OK(ppc440spe_mq_dcr_host)) {
+		pr_err("%s: failed to map DCRs!\n", np->full_name);
+		ret =3D -ENODEV;
+		goto out_mq;
+	}
+	of_node_put(np);
+	ppc440spe_mq_dcr_len =3D dcr_len;
+
+	/* Set HB alias */
+	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_BAUH,
DMA_CUED_XOR_HB);
+
+	/* Set:
+	 * - LL transaction passing limit to 1;
+	 * - Memory controller cycle limit to 1;
+	 * - Galois Polynomial to 0x14d (default)
+	 */
+	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL,
+		  (1 << MQ0_CFBHL_TPLM) | (1 << MQ0_CFBHL_HBCL) |
+		  (PPC440SPE_DEFAULT_POLY << MQ0_CFBHL_POLY));
+
+	atomic_set(&ppc440spe_adma_err_irq_ref, 0);
+	for (i =3D 0; i < PPC440SPE_ADMA_ENGINES_NUM; i++)
+		ppc440spe_adma_devices[i] =3D -1;
+
+	return 0;
+
+out_mq:
+	of_node_put(np);
+out_free:
+	kfree(ppc440spe_dma_fifo_buf);
+	return ret;
+}
+
+static struct of_device_id __devinitdata ppc440spe_adma_of_match[] =3D =
{
+	{ .compatible	=3D "ibm,dma-440spe", },
+	{ .compatible	=3D "amcc,xor-accelerator", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ppc440spe_adma_of_match);
+
+static struct of_platform_driver ppc440spe_adma_driver =3D {
+	.match_table =3D ppc440spe_adma_of_match,
+	.probe =3D ppc440spe_adma_probe,
+	.remove =3D __devexit_p(ppc440spe_adma_remove),
+	.driver =3D {
+		.name =3D "PPC440SP(E)-ADMA",
+		.owner =3D THIS_MODULE,
+	},
+};
+
+static __init int ppc440spe_adma_init(void)
+{
+	int ret;
+
+	ret =3D ppc440spe_configure_raid_devices();
+	if (ret)
+		return ret;
+
+	ret =3D of_register_platform_driver(&ppc440spe_adma_driver);
+	if (ret) {
+		pr_err("%s: failed to register platform driver\n",
+			__func__);
+		goto out_reg;
+	}
+
+	/* Initialization status */
+	ret =3D driver_create_file(&ppc440spe_adma_driver.driver,
+				 &driver_attr_devices);
+	if (ret)
+		goto out_dev;
+
+	/* RAID-6 h/w enable entry */
+	ret =3D driver_create_file(&ppc440spe_adma_driver.driver,
+				 &driver_attr_enable);
+	if (ret)
+		goto out_en;
+
+	/* GF polynomial to use */
+	ret =3D driver_create_file(&ppc440spe_adma_driver.driver,
+				 &driver_attr_poly);
+	if (!ret)
+		return ret;
+
+	driver_remove_file(&ppc440spe_adma_driver.driver,
+			   &driver_attr_enable);
+out_en:
+	driver_remove_file(&ppc440spe_adma_driver.driver,
+			   &driver_attr_devices);
+out_dev:
+	/* User will not be able to enable h/w RAID-6 */
+	pr_err("%s: failed to create RAID-6 driver interface\n",
+		__func__);
+	of_unregister_platform_driver(&ppc440spe_adma_driver);
+out_reg:
+	dcr_unmap(ppc440spe_mq_dcr_host, ppc440spe_mq_dcr_len);
+	kfree(ppc440spe_dma_fifo_buf);
+	return ret;
+}
+
+static void __exit ppc440spe_adma_exit(void)
+{
+	driver_remove_file(&ppc440spe_adma_driver.driver,
+			   &driver_attr_poly);
+	driver_remove_file(&ppc440spe_adma_driver.driver,
+			   &driver_attr_enable);
+	driver_remove_file(&ppc440spe_adma_driver.driver,
+			   &driver_attr_devices);
+	of_unregister_platform_driver(&ppc440spe_adma_driver);
+	dcr_unmap(ppc440spe_mq_dcr_host, ppc440spe_mq_dcr_len);
+	kfree(ppc440spe_dma_fifo_buf);
+}
+
+arch_initcall(ppc440spe_adma_init);
+module_exit(ppc440spe_adma_exit);
+
+MODULE_AUTHOR("Yuri Tikhonov <yur@emcraft.com>");
+MODULE_DESCRIPTION("PPC440SPE ADMA Engine Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/ppc440spe/ppc440spe_adma.h
b/drivers/dma/ppc440spe/ppc440spe_adma.h
new file mode 100644
index 0000000..9716282
--- /dev/null
+++ b/drivers/dma/ppc440spe/ppc440spe_adma.h
@@ -0,0 +1,195 @@
+/*
+ * 2006-2009 (C) DENX Software Engineering.
+ *
+ * Author: Yuri Tikhonov <yur@emcraft.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#ifndef _PPC440SPE_ADMA_H
+#define _PPC440SPE_ADMA_H
+
+#include <linux/types.h>
+#include "ppc440spe_dma.h"
+#include "ppc440spe_xor.h"
+
+#define to_ppc440spe_adma_chan(chan) \
+		container_of(chan, struct ppc440spe_adma_chan, common)
+#define to_ppc440spe_adma_device(dev) \
+		container_of(dev, struct ppc440spe_adma_device, common)
+#define tx_to_ppc440spe_adma_slot(tx) \
+		container_of(tx, struct ppc440spe_adma_desc_slot,
async_tx)
+
+/* Default polynomial (for 440SP is only available) */
+#define PPC440SPE_DEFAULT_POLY	0x4d
+
+#define PPC440SPE_ADMA_ENGINES_NUM	(XOR_ENGINES_NUM +
DMA_ENGINES_NUM)
+
+#define PPC440SPE_ADMA_WATCHDOG_MSEC	3
+#define PPC440SPE_ADMA_THRESHOLD	1
+
+#define PPC440SPE_DMA0_ID	0
+#define PPC440SPE_DMA1_ID	1
+#define PPC440SPE_XOR_ID	2
+
+#define PPC440SPE_ADMA_DMA_MAX_BYTE_COUNT	0xFFFFFFUL
+/* this is the XOR_CBBCR width */
+#define PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT	(1 << 31)
+#define PPC440SPE_ADMA_ZERO_SUM_MAX_BYTE_COUNT
PPC440SPE_ADMA_XOR_MAX_BYTE_COUNT
+
+#define PPC440SPE_RXOR_RUN	0
+
+#define MQ0_CF2H_RXOR_BS_MASK	0x1FF
+
+#undef ADMA_LL_DEBUG
+
+/**
+ * struct ppc440spe_adma_device - internal representation of an ADMA
device
+ * @dev: device
+ * @dma_reg: base for DMAx register access
+ * @xor_reg: base for XOR register access
+ * @i2o_reg: base for I2O register access
+ * @id: HW ADMA Device selector
+ * @dma_desc_pool_virt: base of DMA descriptor region (CPU address)
+ * @dma_desc_pool: base of DMA descriptor region (DMA address)
+ * @pool_size: size of the pool
+ * @irq: DMAx or XOR irq number
+ * @err_irq: DMAx error irq number
+ * @common: embedded struct dma_device
+ */
+struct ppc440spe_adma_device {
+	struct device *dev;
+	struct dma_regs __iomem *dma_reg;
+	struct xor_regs __iomem *xor_reg;
+	struct i2o_regs __iomem *i2o_reg;
+	int id;
+	void *dma_desc_pool_virt;
+	dma_addr_t dma_desc_pool;
+	size_t pool_size;
+	int irq;
+	int err_irq;
+	struct dma_device common;
+};
+
+/**
+ * struct ppc440spe_adma_chan - internal representation of an ADMA
channel
+ * @lock: serializes enqueue/dequeue operations to the slot pool
+ * @device: parent device
+ * @chain: device chain view of the descriptors
+ * @common: common dmaengine channel object members
+ * @all_slots: complete domain of slots usable by the channel
+ * @pending: allows batching of hardware operations
+ * @completed_cookie: identifier for the most recently completed
operation
+ * @slots_allocated: records the actual size of the descriptor slot
pool
+ * @hw_chain_inited: h/w descriptor chain initialization flag
+ * @irq_tasklet: bottom half where ppc440spe_adma_slot_cleanup runs
+ * @needs_unmap: if buffers should not be unmapped upon final
processing
+ * @pdest_page: P destination page for async validate operation
+ * @qdest_page: Q destination page for async validate operation
+ * @pdest: P dma addr for async validate operation
+ * @qdest: Q dma addr for async validate operation
+ */
+struct ppc440spe_adma_chan {
+	spinlock_t lock;
+	struct ppc440spe_adma_device *device;
+	struct list_head chain;
+	struct dma_chan common;
+	struct list_head all_slots;
+	struct ppc440spe_adma_desc_slot *last_used;
+	int pending;
+	dma_cookie_t completed_cookie;
+	int slots_allocated;
+	int hw_chain_inited;
+	struct tasklet_struct irq_tasklet;
+	u8 needs_unmap;
+	struct page *pdest_page;
+	struct page *qdest_page;
+	dma_addr_t pdest;
+	dma_addr_t qdest;
+};
+
+struct ppc440spe_rxor {
+	u32 addrl;
+	u32 addrh;
+	int len;
+	int xor_count;
+	int addr_count;
+	int desc_count;
+	int state;
+};
+
+/**
+ * struct ppc440spe_adma_desc_slot - PPC440SPE-ADMA software descriptor
+ * @phys: hardware address of the hardware descriptor chain
+ * @group_head: first operation in a transaction
+ * @hw_next: pointer to the next descriptor in chain
+ * @async_tx: support for the async_tx api
+ * @slot_node: node on the iop_adma_chan.all_slots list
+ * @chain_node: node on the op_adma_chan.chain list
+ * @group_list: list of slots that make up a multi-descriptor
transaction
+ *              for example transfer lengths larger than the supported
hw max
+ * @unmap_len: transaction bytecount
+ * @hw_desc: virtual address of the hardware descriptor chain
+ * @stride: currently chained or not
+ * @idx: pool index
+ * @slot_cnt: total slots used in an transaction (group of operations)
+ * @src_cnt: number of sources set in this descriptor
+ * @dst_cnt: number of destinations set in the descriptor
+ * @slots_per_op: number of slots per operation
+ * @descs_per_op: number of slot per P/Q operation see comment
+ *                for ppc440spe_prep_dma_pqxor function
+ * @flags: desc state/type
+ * @reverse_flags: 1 if a corresponding rxor address uses reversed
address order
+ * @xor_check_result: result of zero sum
+ * @crc32_result: result crc calculation
+ */
+struct ppc440spe_adma_desc_slot {
+	dma_addr_t phys;
+	struct ppc440spe_adma_desc_slot *group_head;
+	struct ppc440spe_adma_desc_slot *hw_next;
+	struct dma_async_tx_descriptor async_tx;
+	struct list_head slot_node;
+	struct list_head chain_node; /* node in channel ops list */
+	struct list_head group_list; /* list */
+	unsigned int unmap_len;
+	void *hw_desc;
+	u16 stride;
+	u16 idx;
+	u16 slot_cnt;
+	u8 src_cnt;
+	u8 dst_cnt;
+	u8 slots_per_op;
+	u8 descs_per_op;
+	unsigned long flags;
+	unsigned long reverse_flags[8];
+
+#define PPC440SPE_DESC_INT	0	/* generate interrupt on
complete */
+#define PPC440SPE_ZERO_P	1	/* clear P destionaion */
+#define PPC440SPE_ZERO_Q	2	/* clear Q destination */
+#define PPC440SPE_COHERENT	3	/* src/dst are coherent */
+
+#define PPC440SPE_DESC_WXOR	4	/* WXORs are in chain */
+#define PPC440SPE_DESC_RXOR	5	/* RXOR is in chain */
+
+#define PPC440SPE_DESC_RXOR123	8	/* CDB for RXOR123 operation */
+#define PPC440SPE_DESC_RXOR124	9	/* CDB for RXOR124 operation */
+#define PPC440SPE_DESC_RXOR125	10	/* CDB for RXOR125 operation */
+#define PPC440SPE_DESC_RXOR12	11	/* CDB for RXOR12 operation */
+#define PPC440SPE_DESC_RXOR_REV	12	/* CDB has srcs in
reversed order */
+
+#define PPC440SPE_DESC_PCHECK	13
+#define PPC440SPE_DESC_QCHECK	14
+
+#define PPC440SPE_DESC_RXOR_MSK	0x3
+
+	struct ppc440spe_rxor rxor_cursor;
+
+	union {
+		u32 *xor_check_result;
+		u32 *crc32_result;
+	};
+};
+
+#endif /* _PPC440SPE_ADMA_H */
diff --git a/drivers/dma/ppc440spe/ppc440spe_dma.h
b/drivers/dma/ppc440spe/ppc440spe_dma.h
new file mode 100644
index 0000000..bcde2df
--- /dev/null
+++ b/drivers/dma/ppc440spe/ppc440spe_dma.h
@@ -0,0 +1,223 @@
+/*
+ * 440SPe's DMA engines support header file
+ *
+ * 2006-2009 (C) DENX Software Engineering.
+ *
+ * Author: Yuri Tikhonov <yur@emcraft.com>
+ *
+ * This file is licensed under the term of  the GNU General Public
License
+ * version 2. The program licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef	_PPC440SPE_DMA_H
+#define _PPC440SPE_DMA_H
+
+#include <linux/types.h>
+
+/* Number of elements in the array with statical CDBs */
+#define	MAX_STAT_DMA_CDBS	16
+/* Number of DMA engines available on the contoller */
+#define DMA_ENGINES_NUM		2
+
+/* Maximum h/w supported number of destinations */
+#define DMA_DEST_MAX_NUM	2
+
+/* FIFO's params */
+#define DMA0_FIFO_SIZE		0x1000
+#define DMA1_FIFO_SIZE		0x1000
+#define DMA_FIFO_ENABLE		(1<<12)
+
+/* DMA Configuration Register. Data Transfer Engine PLB Priority: */
+#define DMA_CFG_DXEPR_LP	(0<<26)
+#define DMA_CFG_DXEPR_HP	(3<<26)
+#define DMA_CFG_DXEPR_HHP	(2<<26)
+#define DMA_CFG_DXEPR_HHHP	(1<<26)
+
+/* DMA Configuration Register. DMA FIFO Manager PLB Priority: */
+#define DMA_CFG_DFMPP_LP	(0<<23)
+#define DMA_CFG_DFMPP_HP	(3<<23)
+#define DMA_CFG_DFMPP_HHP	(2<<23)
+#define DMA_CFG_DFMPP_HHHP	(1<<23)
+
+/* DMA Configuration Register. Force 64-byte Alignment */
+#define DMA_CFG_FALGN		(1 << 19)
+
+/*UIC0:*/
+#define D0CPF_INT		(1<<12)
+#define D0CSF_INT		(1<<11)
+#define D1CPF_INT		(1<<10)
+#define D1CSF_INT		(1<<9)
+/*UIC1:*/
+#define DMAE_INT		(1<<9)
+
+/* I2O IOP Interrupt Mask Register */
+#define I2O_IOPIM_P0SNE		(1<<3)
+#define I2O_IOPIM_P0EM		(1<<5)
+#define I2O_IOPIM_P1SNE		(1<<6)
+#define I2O_IOPIM_P1EM		(1<<8)
+
+/* DMA CDB fields */
+#define DMA_CDB_MSK		(0xF)
+#define DMA_CDB_64B_ADDR	(1<<2)
+#define DMA_CDB_NO_INT		(1<<3)
+#define DMA_CDB_STATUS_MSK	(0x3)
+#define DMA_CDB_ADDR_MSK	(0xFFFFFFF0)
+
+/* DMA CDB OpCodes */
+#define DMA_CDB_OPC_NO_OP	(0x00)
+#define DMA_CDB_OPC_MV_SG1_SG2	(0x01)
+#define DMA_CDB_OPC_MULTICAST	(0x05)
+#define DMA_CDB_OPC_DFILL128	(0x24)
+#define DMA_CDB_OPC_DCHECK128	(0x23)
+
+#define DMA_CUED_XOR_BASE	(0x10000000)
+#define DMA_CUED_XOR_HB		(0x00000008)
+
+#ifdef CONFIG_440SP
+#define DMA_CUED_MULT1_OFF	0
+#define DMA_CUED_MULT2_OFF	8
+#define DMA_CUED_MULT3_OFF	16
+#define DMA_CUED_REGION_OFF	24
+#define DMA_CUED_XOR_WIN_MSK	(0xFC000000)
+#else
+#define DMA_CUED_MULT1_OFF	2
+#define DMA_CUED_MULT2_OFF	10
+#define DMA_CUED_MULT3_OFF	18
+#define DMA_CUED_REGION_OFF	26
+#define DMA_CUED_XOR_WIN_MSK	(0xF0000000)
+#endif
+
+#define DMA_CUED_REGION_MSK	0x3
+#define DMA_RXOR123		0x0
+#define DMA_RXOR124		0x1
+#define DMA_RXOR125		0x2
+#define DMA_RXOR12		0x3
+
+/* S/G addresses */
+#define DMA_CDB_SG_SRC		1
+#define DMA_CDB_SG_DST1		2
+#define DMA_CDB_SG_DST2		3
+
+/*
+ * DMAx engines Command Descriptor Block Type
+ */
+struct dma_cdb {
+	/*
+	 * Basic CDB structure (Table 20-17, p.499, 440spe_um_1_22.pdf)
+	 */
+	u8	pad0[2];        /* reserved */
+	u8	attr;		/* attributes */
+	u8	opc;		/* opcode */
+	u32	sg1u;		/* upper SG1 address */
+	u32	sg1l;		/* lower SG1 address */
+	u32	cnt;		/* SG count, 3B used */
+	u32	sg2u;		/* upper SG2 address */
+	u32	sg2l;		/* lower SG2 address */
+	u32	sg3u;		/* upper SG3 address */
+	u32	sg3l;		/* lower SG3 address */
+};
+
+/*
+ * DMAx hardware registers (p.515 in 440SPe UM 1.22)
+ */
+struct dma_regs {
+	u32	cpfpl;
+	u32	cpfph;
+	u32	csfpl;
+	u32	csfph;
+	u32	dsts;
+	u32	cfg;
+	u8	pad0[0x8];
+	u16	cpfhp;
+	u16	cpftp;
+	u16	csfhp;
+	u16	csftp;
+	u8	pad1[0x8];
+	u32	acpl;
+	u32	acph;
+	u32	s1bpl;
+	u32	s1bph;
+	u32	s2bpl;
+	u32	s2bph;
+	u32	s3bpl;
+	u32	s3bph;
+	u8	pad2[0x10];
+	u32	earl;
+	u32	earh;
+	u8	pad3[0x8];
+	u32	seat;
+	u32	sead;
+	u32	op;
+	u32	fsiz;
+};
+
+/*
+ * I2O hardware registers (p.528 in 440SPe UM 1.22)
+ */
+struct i2o_regs {
+	u32	ists;
+	u32	iseat;
+	u32	isead;
+	u8	pad0[0x14];
+	u32	idbel;
+	u8	pad1[0xc];
+	u32	ihis;
+	u32	ihim;
+	u8	pad2[0x8];
+	u32	ihiq;
+	u32	ihoq;
+	u8	pad3[0x8];
+	u32	iopis;
+	u32	iopim;
+	u32	iopiq;
+	u8	iopoq;
+	u8	pad4[3];
+	u16	iiflh;
+	u16	iiflt;
+	u16	iiplh;
+	u16	iiplt;
+	u16	ioflh;
+	u16	ioflt;
+	u16	ioplh;
+	u16	ioplt;
+	u32	iidc;
+	u32	ictl;
+	u32	ifcpp;
+	u8	pad5[0x4];
+	u16	mfac0;
+	u16	mfac1;
+	u16	mfac2;
+	u16	mfac3;
+	u16	mfac4;
+	u16	mfac5;
+	u16	mfac6;
+	u16	mfac7;
+	u16	ifcfh;
+	u16	ifcht;
+	u8	pad6[0x4];
+	u32	iifmc;
+	u32	iodb;
+	u32	iodbc;
+	u32	ifbal;
+	u32	ifbah;
+	u32	ifsiz;
+	u32	ispd0;
+	u32	ispd1;
+	u32	ispd2;
+	u32	ispd3;
+	u32	ihipl;
+	u32	ihiph;
+	u32	ihopl;
+	u32	ihoph;
+	u32	iiipl;
+	u32	iiiph;
+	u32	iiopl;
+	u32	iioph;
+	u32	ifcpl;
+	u32	ifcph;
+	u8	pad7[0x8];
+	u32	iopt;
+};
+
+#endif /* _PPC440SPE_DMA_H */
diff --git a/drivers/dma/ppc440spe/ppc440spe_xor.h
b/drivers/dma/ppc440spe/ppc440spe_xor.h
new file mode 100644
index 0000000..daed738
--- /dev/null
+++ b/drivers/dma/ppc440spe/ppc440spe_xor.h
@@ -0,0 +1,110 @@
+/*
+ * 440SPe's XOR engines support header file
+ *
+ * 2006-2009 (C) DENX Software Engineering.
+ *
+ * Author: Yuri Tikhonov <yur@emcraft.com>
+ *
+ * This file is licensed under the term of  the GNU General Public
License
+ * version 2. The program licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef _PPC440SPE_XOR_H
+#define _PPC440SPE_XOR_H
+
+#include <linux/types.h>
+
+/* Number of XOR engines available on the contoller */
+#define XOR_ENGINES_NUM		1
+
+/* Number of operands supported in the h/w */
+#define XOR_MAX_OPS		16
+
+/*
+ * XOR Command Block Control Register bits
+ */
+#define XOR_CBCR_LNK_BIT        (1<<31) /* link present */
+#define XOR_CBCR_TGT_BIT        (1<<30) /* target present */
+#define XOR_CBCR_CBCE_BIT       (1<<29) /* command block compete enable
*/
+#define XOR_CBCR_RNZE_BIT       (1<<28) /* result not zero enable */
+#define XOR_CBCR_XNOR_BIT       (1<<15) /* XOR/XNOR */
+#define XOR_CDCR_OAC_MSK        (0x7F)  /* operand address count */
+
+/*
+ * XORCore Status Register bits
+ */
+#define XOR_SR_XCP_BIT		(1<<31)	/* core processing */
+#define XOR_SR_ICB_BIT		(1<<17)	/* invalid CB */
+#define XOR_SR_IC_BIT		(1<<16)	/* invalid command */
+#define XOR_SR_IPE_BIT		(1<<15)	/* internal parity error */
+#define XOR_SR_RNZ_BIT		(1<<2)	/* result not Zero */
+#define XOR_SR_CBC_BIT		(1<<1)	/* CB complete */
+#define XOR_SR_CBLC_BIT		(1<<0)	/* CB list complete */
+
+/*
+ * XORCore Control Set and Reset Register bits
+ */
+#define XOR_CRSR_XASR_BIT	(1<<31)	/* soft reset */
+#define XOR_CRSR_XAE_BIT	(1<<30)	/* enable */
+#define XOR_CRSR_RCBE_BIT	(1<<29)	/* refetch CB enable */
+#define XOR_CRSR_PAUS_BIT	(1<<28)	/* pause */
+#define XOR_CRSR_64BA_BIT	(1<<27) /* 64/32 CB format */
+#define XOR_CRSR_CLP_BIT	(1<<25)	/* continue list processing */
+
+/*
+ * XORCore Interrupt Enable Register
+ */
+#define XOR_IE_ICBIE_BIT	(1<<17)	/* Invalid Command Block IRQ
Enable */
+#define XOR_IE_ICIE_BIT		(1<<16)	/* Invalid Command IRQ
Enable */
+#define XOR_IE_RPTIE_BIT	(1<<14)	/* Read PLB Timeout Error IRQ
Enable */
+#define XOR_IE_CBCIE_BIT	(1<<1)	/* CB complete interrupt enable
*/
+#define XOR_IE_CBLCI_BIT	(1<<0)	/* CB list complete interrupt
enable */
+
+/*
+ * XOR Accelerator engine Command Block Type
+ */
+struct xor_cb {
+	/*
+	 * Basic 64-bit format XOR CB (Table 19-1, p.463,
440spe_um_1_22.pdf)
+	 */
+	u32	cbc;		/* control */
+	u32	cbbc;		/* byte count */
+	u32	cbs;		/* status */
+	u8	pad0[4];	/* reserved */
+	u32	cbtah;		/* target address high */
+	u32	cbtal;		/* target address low */
+	u32	cblah;		/* link address high */
+	u32	cblal;		/* link address low */
+	struct {
+		u32 h;
+		u32 l;
+	} __attribute__ ((packed)) ops[16];
+} __attribute__ ((packed));
+
+/*
+ * XOR hardware registers Table 19-3, UM 1.22
+ */
+struct xor_regs {
+	u32	op_ar[16][2];	/* operand address[0]-high,[1]-low
registers */
+	u8	pad0[352];	/* reserved */
+	u32	cbcr;		/* CB control register */
+	u32	cbbcr;		/* CB byte count register */
+	u32	cbsr;		/* CB status register */
+	u8	pad1[4];	/* reserved */
+	u32	cbtahr;		/* operand target address high register
*/
+	u32	cbtalr;		/* operand target address low register
*/
+	u32	cblahr;		/* CB link address high register */
+	u32	cblalr;		/* CB link address low register */
+	u32	crsr;		/* control set register */
+	u32	crrr;		/* control reset register */
+	u32	ccbahr;		/* current CB address high register */
+	u32	ccbalr;		/* current CB address low register */
+	u32	plbr;		/* PLB configuration register */
+	u32	ier;		/* interrupt enable register */
+	u32	pecr;		/* parity error count register */
+	u32	sr;		/* status register */
+	u32	revidr;		/* revision ID register */
+};
+
+#endif /* _PPC440SPE_XOR_H */
--=20
1.6.2.5

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
