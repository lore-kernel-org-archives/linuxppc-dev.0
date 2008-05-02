Return-Path: <afleming@ld0175-tx32.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D20B0DE496
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 04:03:42 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m42I3bVe012910
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:03:38 -0700 (MST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32.am.freescale.net
	[10.82.19.125])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m42I3Zrc014243
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 13:03:35 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2.6.26] powerpc: Fix a bunch of sparse warnings in the qe_lib
Date: Fri,  2 May 2008 13:03:35 -0500
Message-Id: <1209751415-25612-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mostly having to do with not marking things __iomem.  And some failure
to use appropriate accessors to read MMIO regs.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c       |    6 ++--
 arch/powerpc/sysdev/qe_lib/ucc.c      |    6 ++--
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |   16 ++++----
 include/asm-powerpc/immap_qe.h        |   58 ++++++++++++++++----------------
 include/asm-powerpc/ucc_fast.h        |    8 ++--
 5 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index cff550e..07260a6 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -65,7 +65,7 @@ static phys_addr_t qebase = -1;
 phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
-	unsigned int size;
+	int size;
 	const u32 *prop;
 
 	if (qebase != -1)
@@ -159,7 +159,7 @@ static unsigned int brg_clk = 0;
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
-	unsigned int size;
+	int size;
 	const u32 *prop;
 
 	if (brg_clk)
@@ -306,7 +306,7 @@ EXPORT_SYMBOL(qe_put_snum);
 
 static int qe_sdma_init(void)
 {
-	struct sdma *sdma = &qe_immr->sdma;
+	struct sdma __iomem *sdma = &qe_immr->sdma;
 	unsigned long sdma_buf_offset;
 
 	if (!sdma)
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index 0e348d9..4103dc1 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -87,7 +87,7 @@ int ucc_set_type(unsigned int ucc_num, enum ucc_speed_type speed)
 	return 0;
 }
 
-static void get_cmxucr_reg(unsigned int ucc_num, __be32 **cmxucr,
+static void get_cmxucr_reg(unsigned int ucc_num, __be32 __iomem **cmxucr,
 	unsigned int *reg_num, unsigned int *shift)
 {
 	unsigned int cmx = ((ucc_num & 1) << 1) + (ucc_num > 3);
@@ -99,7 +99,7 @@ static void get_cmxucr_reg(unsigned int ucc_num, __be32 **cmxucr,
 
 int ucc_mux_set_grant_tsa_bkpt(unsigned int ucc_num, int set, u32 mask)
 {
-	__be32 *cmxucr;
+	__be32 __iomem *cmxucr;
 	unsigned int reg_num;
 	unsigned int shift;
 
@@ -120,7 +120,7 @@ int ucc_mux_set_grant_tsa_bkpt(unsigned int ucc_num, int set, u32 mask)
 int ucc_set_qe_mux_rxtx(unsigned int ucc_num, enum qe_clock clock,
 	enum comm_dir mode)
 {
-	__be32 *cmxucr;
+	__be32 __iomem *cmxucr;
 	unsigned int reg_num;
 	unsigned int shift;
 	u32 clock_bits = 0;
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index bcf88e6..fcbec85 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -46,7 +46,7 @@ void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 	printk(KERN_INFO "uccm  : addr=0x%p, val=0x%08x\n",
 		  &uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
 	printk(KERN_INFO "uccs  : addr=0x%p, val=0x%02x\n",
-		  &uccf->uf_regs->uccs, uccf->uf_regs->uccs);
+		  &uccf->uf_regs->uccs, in_8(&uccf->uf_regs->uccs));
 	printk(KERN_INFO "urfb  : addr=0x%p, val=0x%08x\n",
 		  &uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
 	printk(KERN_INFO "urfs  : addr=0x%p, val=0x%04x\n",
@@ -68,7 +68,7 @@ void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 	printk(KERN_INFO "urtry : addr=0x%p, val=0x%08x\n",
 		  &uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
 	printk(KERN_INFO "guemr : addr=0x%p, val=0x%02x\n",
-		  &uccf->uf_regs->guemr, uccf->uf_regs->guemr);
+		  &uccf->uf_regs->guemr, in_8(&uccf->uf_regs->guemr));
 }
 EXPORT_SYMBOL(ucc_fast_dump_regs);
 
@@ -96,7 +96,7 @@ EXPORT_SYMBOL(ucc_fast_transmit_on_demand);
 
 void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
-	struct ucc_fast *uf_regs;
+	struct ucc_fast __iomem *uf_regs;
 	u32 gumr;
 
 	uf_regs = uccf->uf_regs;
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(ucc_fast_enable);
 
 void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
-	struct ucc_fast *uf_regs;
+	struct ucc_fast __iomem *uf_regs;
 	u32 gumr;
 
 	uf_regs = uccf->uf_regs;
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(ucc_fast_disable);
 int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret)
 {
 	struct ucc_fast_private *uccf;
-	struct ucc_fast *uf_regs;
+	struct ucc_fast __iomem *uf_regs;
 	u32 gumr;
 	int ret;
 
@@ -216,10 +216,10 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	uccf->stopped_tx = 0;
 	uccf->stopped_rx = 0;
 	uf_regs = uccf->uf_regs;
-	uccf->p_ucce = (u32 *) & (uf_regs->ucce);
-	uccf->p_uccm = (u32 *) & (uf_regs->uccm);
+	uccf->p_ucce = (u32 __iomem *) & (uf_regs->ucce);
+	uccf->p_uccm = (u32 __iomem *) & (uf_regs->uccm);
 #ifdef CONFIG_UGETH_TX_ON_DEMAND
-	uccf->p_utodr = (u16 *) & (uf_regs->utodr);
+	uccf->p_utodr = (u16 __iomem *) & (uf_regs->utodr);
 #endif
 #ifdef STATISTICS
 	uccf->tx_frames = 0;
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 7b6f411..644ed2f 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -424,46 +424,46 @@ struct rsp {
 	__be32 bior;
 	u8 res3[4];
 	__be32 iatr[4];
-	__be32 eccr;		/* Exception control configuration register */
+	__be32 eccr;	/* Exception control configuration register */
 	__be32 eicr;
 	u8 res4[0x100-0xf8];
 } __attribute__ ((packed));
 
 struct qe_immap {
-	struct qe_iram		iram;		/* I-RAM */
-	struct qe_ic_regs	ic;		/* Interrupt Controller */
-	struct cp_qe		cp;		/* Communications Processor */
-	struct qe_mux		qmx;		/* QE Multiplexer */
-	struct qe_timers	qet;		/* QE Timers */
-	struct spi		spi[0x2];	/* spi */
-	struct mcc		mcc;		/* mcc */
-	struct qe_brg		brg;		/* brg */
-	struct usb_ctlr		usb;		/* USB */
-	struct si1		si1;		/* SI */
-	u8			res11[0x800];
-	struct sir		sir;		/* SI Routing Tables */
-	struct ucc		ucc1;		/* ucc1 */
-	struct ucc		ucc3;		/* ucc3 */
-	struct ucc		ucc5;		/* ucc5 */
-	struct ucc		ucc7;		/* ucc7 */
-	u8			res12[0x600];
-	struct upc		upc1;		/* MultiPHY UTOPIA POS Ctrlr 1*/
-	struct ucc		ucc2;		/* ucc2 */
-	struct ucc		ucc4;		/* ucc4 */
-	struct ucc		ucc6;		/* ucc6 */
-	struct ucc		ucc8;		/* ucc8 */
-	u8			res13[0x600];
-	struct upc		upc2;		/* MultiPHY UTOPIA POS Ctrlr 2*/
-	struct sdma		sdma;		/* SDMA */
-	struct dbg		dbg;		/* 0x104080 - 0x1040FF
+	struct qe_iram __iomem	iram;		/* I-RAM */
+	struct qe_ic_regs __iomem ic;		/* Interrupt Controller */
+	struct cp_qe __iomem	cp;		/* Communications Processor */
+	struct qe_mux __iomem	qmx;		/* QE Multiplexer */
+	struct qe_timers __iomem qet;		/* QE Timers */
+	struct spi __iomem	spi[0x2];	/* spi */
+	struct mcc __iomem	mcc;		/* mcc */
+	struct qe_brg __iomem	brg;		/* brg */
+	struct usb_ctlr __iomem	usb;		/* USB */
+	struct si1 __iomem	si1;		/* SI */
+	u8	   		res11[0x800];
+	struct sir __iomem	sir;		/* SI Routing Tables */
+	struct ucc __iomem	ucc1;		/* ucc1 */
+	struct ucc __iomem	ucc3;		/* ucc3 */
+	struct ucc __iomem	ucc5;		/* ucc5 */
+	struct ucc __iomem	ucc7;		/* ucc7 */
+	u8	   		res12[0x600];
+	struct upc __iomem	upc1;		/* MultiPHY UTOPIA POS Ctrlr 1*/
+	struct ucc __iomem	ucc2;		/* ucc2 */
+	struct ucc __iomem	ucc4;		/* ucc4 */
+	struct ucc __iomem	ucc6;		/* ucc6 */
+	struct ucc __iomem	ucc8;		/* ucc8 */
+	u8	   		res13[0x600];
+	struct upc __iomem	upc2;		/* MultiPHY UTOPIA POS Ctrlr 2*/
+	struct sdma __iomem	sdma;		/* SDMA */
+	struct dbg __iomem	dbg;		/* 0x104080 - 0x1040FF
 						   Debug Space */
-	struct rsp		rsp[0x2];	/* 0x104100 - 0x1042FF
+	struct rsp __iomem	rsp[0x2];	/* 0x104100 - 0x1042FF
 						   RISC Special Registers
 						   (Trap and Breakpoint) */
 	u8			res14[0x300];	/* 0x104300 - 0x1045FF */
 	u8			res15[0x3A00];	/* 0x104600 - 0x107FFF */
 	u8			res16[0x8000];	/* 0x108000 - 0x110000 */
-	u8			muram[0xC000];	/* 0x110000 - 0x11C000
+	u8 __iomem		muram[0xC000];	/* 0x110000 - 0x11C000
 						   Multi-user RAM */
 	u8			res17[0x24000];	/* 0x11C000 - 0x140000 */
 	u8			res18[0xC0000];	/* 0x140000 - 0x200000 */
diff --git a/include/asm-powerpc/ucc_fast.h b/include/asm-powerpc/ucc_fast.h
index f529f70..fce16ab 100644
--- a/include/asm-powerpc/ucc_fast.h
+++ b/include/asm-powerpc/ucc_fast.h
@@ -156,11 +156,11 @@ struct ucc_fast_info {
 
 struct ucc_fast_private {
 	struct ucc_fast_info *uf_info;
-	struct ucc_fast *uf_regs;	/* a pointer to memory map of UCC regs. */
-	u32 *p_ucce;		/* a pointer to the event register in memory. */
-	u32 *p_uccm;		/* a pointer to the mask register in memory. */
+	struct ucc_fast __iomem *uf_regs; /* a pointer to the UCC regs. */
+	u32 __iomem *p_ucce;	/* a pointer to the event register in memory. */
+	u32 __iomem *p_uccm;	/* a pointer to the mask register in memory. */
 #ifdef CONFIG_UGETH_TX_ON_DEMAND
-	u16 *p_utodr;		/* pointer to the transmit on demand register */
+	u16 __iomem *p_utodr;	/* pointer to the transmit on demand register */
 #endif
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
 	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
-- 
1.5.4.GIT
