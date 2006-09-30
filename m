Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 88C8167C90
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:36:28 +1000 (EST)
Date: Sat, 30 Sep 2006 18:36:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/15] QE: remove typedefs
Message-Id: <20060930183614.61655604.kim.phillips@freescale.com>
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

remove typedefs from QE code

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/sysdev/qe_lib/qe_common.c |   18 ++--
 arch/powerpc/sysdev/qe_lib/ucc.c       |    2 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c  |   32 ++++----
 arch/powerpc/sysdev/qe_lib/ucc_slow.c  |   38 ++++-----
 include/asm-powerpc/immap_qe.h         |  136 ++++++++++++++++----------------
 include/asm-powerpc/qe.h               |   40 +++++----
 include/asm-powerpc/ucc.h              |   10 +-
 include/asm-powerpc/ucc_fast.h         |   76 +++++++++---------
 include/asm-powerpc/ucc_slow.h         |   78 +++++++++---------
 9 files changed, 215 insertions(+), 215 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
index 5c3381f..3780eae 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_common.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -35,24 +35,24 @@ #include <asm/rheap.h>
 
 /* QE snum state
 */
-typedef enum qe_snum_state {
+enum qe_snum_state {
 	QE_SNUM_STATE_USED,	/* used */
 	QE_SNUM_STATE_FREE	/* free */
-} qe_snum_state_e;
+};
 
 /* QE snum
 */
-typedef struct qe_snum {
+struct qe_snum {
 	u8 num;			/* snum  */
-	qe_snum_state_e state;	/* state */
-} qe_snum_t;
+	enum qe_snum_state state;	/* state */
+};
 
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
 EXPORT_SYMBOL(qe_immr);
-qe_map_t *qe_immr = NULL;
-static qe_snum_t snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs  */
+struct qe_immap *qe_immr = NULL;
+static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs  */
 
 static void qe_snums_init(void);
 static void qe_muram_init(void);
@@ -85,7 +85,7 @@ EXPORT_SYMBOL(get_qe_base);
 void qe_reset(void)
 {
 	if (qe_immr == NULL)
-		qe_immr = (qe_map_t *) ioremap(get_qe_base(), QE_IMMAP_SIZE);
+		qe_immr = (struct qe_immap *) ioremap(get_qe_base(), QE_IMMAP_SIZE);
 
 	qe_snums_init();
 
@@ -270,7 +270,7 @@ EXPORT_SYMBOL(qe_put_snum);
 
 static int qe_sdma_init(void)
 {
-	sdma_t *sdma = &qe_immr->sdma;
+	struct sdma *sdma = &qe_immr->sdma;
 	uint sdma_buf_offset;
 
 	if (!sdma)
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index edb0acb..d19f5e2 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -150,7 +150,7 @@ int ucc_mux_set_grant_tsa_bkpt(int ucc_n
 	return 0;
 }
 
-int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode)
+int ucc_set_qe_mux_rxtx(int ucc_num, enum qe_clock clock, enum comm_dir mode)
 {
 	volatile u32 *p_cmxucr;
 	u8 reg_num;
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 4312083..b078d4e 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -44,7 +44,7 @@ #else
 #define uccf_vdbg(fmt, args...) do { } while (0)
 #endif				/* UCCF_VERBOSE_DEBUG */
 
-void ucc_fast_dump_regs(ucc_fast_private_t * uccf)
+void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 {
 	uccf_info("UCC%d Fast registers:", uccf->uf_info->ucc_num);
 	uccf_info("Base address: 0x%08x", (u32) uccf->uf_regs);
@@ -112,14 +112,14 @@ u32 ucc_fast_get_qe_cr_subblock(int uccf
 	}
 }
 
-void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf)
+void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf)
 {
 	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
 }
 
-void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode)
+void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
-	ucc_fast_t *uf_regs;
+	struct ucc_fast *uf_regs;
 	u32 gumr;
 
 	uf_regs = uccf->uf_regs;
@@ -137,9 +137,9 @@ void ucc_fast_enable(ucc_fast_private_t 
 	out_be32(&uf_regs->gumr, gumr);
 }
 
-void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode)
+void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
-	ucc_fast_t *uf_regs;
+	struct ucc_fast *uf_regs;
 	u32 gumr;
 
 	uf_regs = uccf->uf_regs;
@@ -157,10 +157,10 @@ void ucc_fast_disable(ucc_fast_private_t
 	out_be32(&uf_regs->gumr, gumr);
 }
 
-int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret)
+int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret)
 {
-	ucc_fast_private_t *uccf;
-	ucc_fast_t *uf_regs;
+	struct ucc_fast_private *uccf;
+	struct ucc_fast *uf_regs;
 	u32 gumr = 0;
 	int ret;
 
@@ -225,20 +225,20 @@ int ucc_fast_init(ucc_fast_info_t * uf_i
 	}
 
 	uccf =
-	    (ucc_fast_private_t *) kmalloc(sizeof(ucc_fast_private_t),
+	    (struct ucc_fast_private *) kmalloc(sizeof(struct ucc_fast_private),
 					   GFP_KERNEL);
 	if (!uccf) {
 		uccf_err
 		    ("ucc_fast_init: No memory for UCC slow data structure!");
 		return -ENOMEM;
 	}
-	memset(uccf, 0, sizeof(ucc_fast_private_t));
+	memset(uccf, 0, sizeof(struct ucc_fast_private));
 
 	/* Fill fast UCC structure */
 	uccf->uf_info = uf_info;
 	/* Set the PHY base address */
 	uccf->uf_regs =
-	    (ucc_fast_t *) ioremap(uf_info->regs, sizeof(ucc_fast_t));
+	    (struct ucc_fast *) ioremap(uf_info->regs, sizeof(struct ucc_fast));
 	if (uccf->uf_regs == NULL) {
 		uccf_err
 		    ("ucc_fast_init: No memory map for UCC slow controller!");
@@ -259,7 +259,7 @@ #ifdef STATISTICS
 #endif				/* STATISTICS */
 
 	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((ucc_common_t *) (uf_regs)))) {
+	if ((ret = ucc_init_guemr((struct ucc_common *) (uf_regs)))) {
 		uccf_err("ucc_fast_init: Could not init the guemr register.");
 		ucc_fast_free(uccf);
 		return ret;
@@ -267,7 +267,7 @@ #endif				/* STATISTICS */
 
 	/* Set UCC to fast type */
 	if ((ret = ucc_set_type(uf_info->ucc_num,
-				(ucc_common_t *) (uf_regs),
+				(struct ucc_common *) (uf_regs),
 				UCC_SPEED_TYPE_FAST))) {
 		uccf_err("ucc_fast_init: Could not set type to fast.");
 		ucc_fast_free(uccf);
@@ -311,7 +311,7 @@ #endif				/* STATISTICS */
 	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
 		uccf_err
 		    ("ucc_fast_init: Can not allocate MURAM memory for "
-			"ucc_fast_tx_virtual_fifo_base_offset.");
+			"struct ucc_fastx_virtual_fifo_base_offset.");
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
@@ -393,7 +393,7 @@ #endif				/* STATISTICS */
 	return 0;
 }
 
-void ucc_fast_free(ucc_fast_private_t * uccf)
+void ucc_fast_free(struct ucc_fast_private * uccf)
 {
 	if (!uccf)
 		return;
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index a8232cd..0059de4 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -69,14 +69,14 @@ u32 ucc_slow_get_qe_cr_subblock(int uccs
 	}
 }
 
-void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs)
+void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs)
 {
 	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
 }
 
-void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs)
+void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs)
 {
-	ucc_slow_info_t *us_info = uccs->us_info;
+	struct ucc_slow_info *us_info = uccs->us_info;
 	u32 id;
 
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
@@ -84,27 +84,27 @@ void ucc_slow_graceful_stop_tx(ucc_slow_
 		     0);
 }
 
-void ucc_slow_stop_tx(ucc_slow_private_t * uccs)
+void ucc_slow_stop_tx(struct ucc_slow_private * uccs)
 {
-	ucc_slow_info_t *us_info = uccs->us_info;
+	struct ucc_slow_info *us_info = uccs->us_info;
 	u32 id;
 
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
 }
 
-void ucc_slow_restart_tx(ucc_slow_private_t * uccs)
+void ucc_slow_restart_tx(struct ucc_slow_private * uccs)
 {
-	ucc_slow_info_t *us_info = uccs->us_info;
+	struct ucc_slow_info *us_info = uccs->us_info;
 	u32 id;
 
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_RESTART_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
 }
 
-void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode)
+void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode)
 {
-	ucc_slow_t *us_regs;
+	struct ucc_slow *us_regs;
 	u32 gumr_l;
 
 	us_regs = uccs->us_regs;
@@ -122,9 +122,9 @@ void ucc_slow_enable(ucc_slow_private_t 
 	out_be32(&us_regs->gumr_l, gumr_l);
 }
 
-void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode)
+void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode)
 {
-	ucc_slow_t *us_regs;
+	struct ucc_slow *us_regs;
 	u32 gumr_l;
 
 	us_regs = uccs->us_regs;
@@ -142,14 +142,14 @@ void ucc_slow_disable(ucc_slow_private_t
 	out_be32(&us_regs->gumr_l, gumr_l);
 }
 
-int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret)
+int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** uccs_ret)
 {
 	u32 i;
-	ucc_slow_t *us_regs;
+	struct ucc_slow *us_regs;
 	u32 gumr;
 	u8 function_code = 0;
 	u8 *bd;
-	ucc_slow_private_t *uccs;
+	struct ucc_slow_private *uccs;
 	u32 id;
 	u32 command;
 	int ret;
@@ -176,14 +176,14 @@ int ucc_slow_init(ucc_slow_info_t * us_i
 	}
 
 	uccs =
-	    (ucc_slow_private_t *) kmalloc(sizeof(ucc_slow_private_t),
+	    (struct ucc_slow_private *) kmalloc(sizeof(struct ucc_slow_private),
 					   GFP_KERNEL);
 	if (!uccs) {
 		uccs_err
 		    ("ucc_slow_init: No memory for UCC slow data structure!");
 		return -ENOMEM;
 	}
-	memset(uccs, 0, sizeof(ucc_slow_private_t));
+	memset(uccs, 0, sizeof(struct ucc_slow_private));
 
 	/* Fill slow UCC structure */
 	uccs->us_info = us_info;
@@ -216,7 +216,7 @@ #endif				/* STATISTICS */
 	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
 
 	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((ucc_common_t *) (us_info->us_regs)))) {
+	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->us_regs)))) {
 		uccs_err("ucc_slow_init: Could not init the guemr register.");
 		ucc_slow_free(uccs);
 		return ret;
@@ -224,7 +224,7 @@ #endif				/* STATISTICS */
 
 	/* Set UCC to slow type */
 	if ((ret = ucc_set_type(us_info->ucc_num,
-				(ucc_common_t *) (us_info->us_regs),
+				(struct ucc_common *) (us_info->us_regs),
 				UCC_SPEED_TYPE_SLOW))) {
 		uccs_err("ucc_slow_init: Could not init the guemr register.");
 		ucc_slow_free(uccs);
@@ -386,7 +386,7 @@ #endif				/* STATISTICS */
 	return 0;
 }
 
-void ucc_slow_free(ucc_slow_private_t * uccs)
+void ucc_slow_free(struct ucc_slow_private * uccs)
 {
 	if (!uccs)
 		return;
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 754df2d..229ac58 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -25,15 +25,15 @@ #define QE_IMMAP_SIZE	(1024 * 1024)	/* 1
 
 /* QE I-RAM
 */
-typedef struct qe_iram {
+struct qe_iram {
 	u32 iadd;		/* I-RAM Address Register */
 	u32 idata;		/* I-RAM Data Register    */
 	u8 res0[0x78];
-} __attribute__ ((packed)) qe_iram_t;
+} __attribute__ ((packed));
 
 /* QE Interrupt Controller
 */
-typedef struct qe_ic_regs {
+struct qe_ic_regs {
 	u32 qicr;
 	u32 qivec;
 	u32 qripnr;
@@ -53,11 +53,11 @@ typedef struct qe_ic_regs {
 	u8 res2[0x20];
 	u32 qhivec;
 	u8 res3[0x1C];
-} __attribute__ ((packed)) qe_ic_t;
+} __attribute__ ((packed));
 
 /* Communications Processor
 */
-typedef struct cp_qe {
+struct cp_qe {
 	u32 cecr;		/* QE command register */
 	u32 ceccr;		/* QE controller configuration register */
 	u32 cecdr;		/* QE command data register */
@@ -91,11 +91,11 @@ typedef struct cp_qe {
 	u16 ceexm4;		/* QE external request 4 mask register */
 	u8 res12[0x2];
 	u8 res13[0x280];
-} __attribute__ ((packed)) cp_qe_t;
+} __attribute__ ((packed));
 
 /* QE Multiplexer
 */
-typedef struct qe_mux {
+struct qe_mux {
 	u32 cmxgcr;		/* CMX general clock route register    */
 	u32 cmxsi1cr_l;		/* CMX SI1 clock route low register    */
 	u32 cmxsi1cr_h;		/* CMX SI1 clock route high register   */
@@ -106,11 +106,11 @@ typedef struct qe_mux {
 	u32 cmxucr4;		/* CMX UCC6, UCC8 clock route register */
 	u32 cmxupcr;		/* CMX UPC clock route register        */
 	u8 res0[0x1C];
-} __attribute__ ((packed)) qe_mux_t;
+} __attribute__ ((packed));
 
 /* QE Timers
 */
-typedef struct qe_timers {
+struct qe_timers {
 	u8 gtcfr1;		/* Timer 1 and Timer 2 global configuration
 				   register */
 	u8 res0[0x3];
@@ -139,11 +139,11 @@ typedef struct qe_timers {
 	u16 gtevr4;		/* Timer 4 event register */
 	u16 gtps;		/* Timer 1 prescale register */
 	u8 res2[0x46];
-} __attribute__ ((packed)) qe_timers_t;
+} __attribute__ ((packed));
 
 /* BRG
 */
-typedef struct qe_brg {
+struct qe_brg {
 	u32 brgc1;		/* BRG1 configuration register  */
 	u32 brgc2;		/* BRG2 configuration register  */
 	u32 brgc3;		/* BRG3 configuration register  */
@@ -161,11 +161,11 @@ typedef struct qe_brg {
 	u32 brgc15;		/* BRG15 configuration register */
 	u32 brgc16;		/* BRG16 configuration register */
 	u8 res0[0x40];
-} __attribute__ ((packed)) qe_brg_t;
+} __attribute__ ((packed));
 
 /* SPI
 */
-typedef struct spi {
+struct spi {
 	u8 res0[0x20];
 	u32 spmode;		/* SPI mode register */
 	u8 res1[0x2];
@@ -180,11 +180,11 @@ typedef struct spi {
 	u32 spitd;		/* SPI transmit data register (cpu mode) */
 	u32 spird;		/* SPI receive data register (cpu mode) */
 	u8 res7[0x8];
-} __attribute__ ((packed)) spi_t;
+} __attribute__ ((packed));
 
 /* SI
 */
-typedef struct si1 {
+struct si1 {
 	u16 siamr1;		/* SI1 TDMA mode register */
 	u16 sibmr1;		/* SI1 TDMB mode register */
 	u16 sicmr1;		/* SI1 TDMC mode register */
@@ -229,19 +229,19 @@ typedef struct si1 {
 	u32 siml1;		/* SI1 multiframe limit register */
 	u8 siedm1;		/* SI1 extended diagnostic mode register */
 	u8 res9[0xBB];
-} __attribute__ ((packed)) si1_t;
+} __attribute__ ((packed));
 
 /* SI Routing Tables
 */
-typedef struct sir {
+struct sir {
 	u8 tx[0x400];
 	u8 rx[0x400];
 	u8 res0[0x800];
-} __attribute__ ((packed)) sir_t;
+} __attribute__ ((packed));
 
 /* USB Controller.
 */
-typedef struct usb_ctlr {
+struct usb_ctlr {
 	u8 usb_usmod;
 	u8 usb_usadr;
 	u8 usb_uscom;
@@ -260,21 +260,21 @@ typedef struct usb_ctlr {
 	u8 res5[2];
 	u16 usb_usfrn;
 	u8 res6[0x22];
-} __attribute__ ((packed)) usb_t;
+} __attribute__ ((packed));
 
 /* MCC
 */
-typedef struct mcc {
+struct mcc {
 	u32 mcce;		/* MCC event register */
 	u32 mccm;		/* MCC mask register */
 	u32 mccf;		/* MCC configuration register */
 	u32 merl;		/* MCC emergency request level register */
 	u8 res0[0xF0];
-} __attribute__ ((packed)) mcc_t;
+} __attribute__ ((packed));
 
 /* QE UCC Slow
 */
-typedef struct ucc_slow {
+struct ucc_slow {
 	u32 gumr_l;		/* UCCx general mode register (low) */
 	u32 gumr_h;		/* UCCx general mode register (high) */
 	u16 upsmr;		/* UCCx protocol-specific mode register */
@@ -290,11 +290,11 @@ typedef struct ucc_slow {
 	u16 utpt;
 	u8 guemr;		/* UCC general extended mode register */
 	u8 res4[0x200 - 0x091];
-} __attribute__ ((packed)) ucc_slow_t;
+} __attribute__ ((packed));
 
 /* QE UCC Fast
 */
-typedef struct ucc_fast {
+struct ucc_fast {
 	u32 gumr;		/* UCCx general mode register */
 	u32 upsmr;		/* UCCx protocol-specific mode register  */
 	u16 utodr;		/* UCCx transmit on demand register  */
@@ -324,27 +324,27 @@ typedef struct ucc_fast {
 	u8 res8[0x4C];
 	u8 guemr;		/* UCC general extended mode register */
 	u8 res9[0x100 - 0x091];
-} __attribute__ ((packed)) ucc_fast_t;
+} __attribute__ ((packed));
 
 /* QE UCC
 */
-typedef struct ucc_common {
+struct ucc_common {
 	u8 res1[0x90];
 	u8 guemr;
 	u8 res2[0x200 - 0x091];
-} __attribute__ ((packed)) ucc_common_t;
+} __attribute__ ((packed));
 
-typedef struct ucc {
+struct ucc {
 	union {
-		ucc_slow_t slow;
-		ucc_fast_t fast;
-		ucc_common_t common;
+		struct ucc_slow slow;
+		struct ucc_fast fast;
+		struct ucc_common common;
 	};
-} __attribute__ ((packed)) ucc_t;
+} __attribute__ ((packed));
 
 /* MultiPHY UTOPIA POS Controllers (UPC)
 */
-typedef struct upc {
+struct upc {
 	u32 upgcr;		/* UTOPIA/POS general configuration register  */
 	u32 uplpa;		/* UTOPIA/POS last PHY address */
 	u32 uphec;		/* ATM HEC register */
@@ -397,11 +397,11 @@ typedef struct upc {
 	u32 uper3;		/* Device 3 port enable register */
 	u32 uper4;		/* Device 4 port enable register */
 	u8 res2[0x150];
-} __attribute__ ((packed)) upc_t;
+} __attribute__ ((packed));
 
 /* SDMA
 */
-typedef struct sdma {
+struct sdma {
 	u32 sdsr;		/* Serial DMA status register */
 	u32 sdmr;		/* Serial DMA mode register */
 	u32 sdtr1;		/* SDMA system bus threshold register */
@@ -418,11 +418,11 @@ typedef struct sdma {
 	u8 res1[0x4];
 	u32 sdebcr;		/* SDMA CAM entries base register */
 	u8 res2[0x38];
-} __attribute__ ((packed)) sdma_t;
+} __attribute__ ((packed));
 
 /* Debug Space
 */
-typedef struct dbg {
+struct dbg {
 	u32 bpdcr;		/* Breakpoint debug command register */
 	u32 bpdsr;		/* Breakpoint debug status register */
 	u32 bpdmr;		/* Breakpoint debug mask register */
@@ -436,42 +436,42 @@ typedef struct dbg {
 	u32 bprmsr;		/* Breakpoint request mode serial register */
 	u32 bpemr;		/* Breakpoint exit mode register */
 	u8 res2[0x48];
-} __attribute__ ((packed)) dbg_t;
+} __attribute__ ((packed));
 
 /* RISC Special Registers (Trap and Breakpoint)
 */
-typedef struct rsp {
+struct rsp {
 	u8 fixme[0x100];
-} __attribute__ ((packed)) rsp_t;
+} __attribute__ ((packed));
 
-typedef struct qe_immap {
-	qe_iram_t iram;		/* I-RAM */
-	qe_ic_t ic;		/* Interrupt Controller */
-	cp_qe_t cp;		/* Communications Processor */
-	qe_mux_t qmx;		/* QE Multiplexer */
-	qe_timers_t qet;	/* QE Timers */
-	spi_t spi[0x2];		/* spi  */
-	mcc_t mcc;		/* mcc */
-	qe_brg_t brg;		/* brg */
-	usb_t usb;		/* USB */
-	si1_t si1;		/* SI */
+struct qe_immap {
+	struct qe_iram iram;		/* I-RAM */
+	struct qe_ic_regs ic;		/* Interrupt Controller */
+	struct cp_qe cp;		/* Communications Processor */
+	struct qe_mux qmx;		/* QE Multiplexer */
+	struct qe_timers qet;	/* QE Timers */
+	struct spi spi[0x2];		/* spi  */
+	struct mcc mcc;		/* mcc */
+	struct qe_brg brg;		/* brg */
+	struct usb_ctlr usb;		/* USB */
+	struct si1 si1;		/* SI */
 	u8 res11[0x800];
-	sir_t sir;		/* SI Routing Tables  */
-	ucc_t ucc1;		/* ucc1 */
-	ucc_t ucc3;		/* ucc3 */
-	ucc_t ucc5;		/* ucc5 */
-	ucc_t ucc7;		/* ucc7 */
+	struct sir sir;		/* SI Routing Tables  */
+	struct ucc ucc1;		/* ucc1 */
+	struct ucc ucc3;		/* ucc3 */
+	struct ucc ucc5;		/* ucc5 */
+	struct ucc ucc7;		/* ucc7 */
 	u8 res12[0x600];
-	upc_t upc1;		/* MultiPHY UTOPIA POS Controller 1 */
-	ucc_t ucc2;		/* ucc2 */
-	ucc_t ucc4;		/* ucc4 */
-	ucc_t ucc6;		/* ucc6 */
-	ucc_t ucc8;		/* ucc8 */
+	struct upc upc1;		/* MultiPHY UTOPIA POS Controller 1 */
+	struct ucc ucc2;		/* ucc2 */
+	struct ucc ucc4;		/* ucc4 */
+	struct ucc ucc6;		/* ucc6 */
+	struct ucc ucc8;		/* ucc8 */
 	u8 res13[0x600];
-	upc_t upc2;		/* MultiPHY UTOPIA POS Controller 2 */
-	sdma_t sdma;		/* SDMA */
-	dbg_t dbg;		/* Debug Space */
-	rsp_t rsp[0x2];		/* RISC Special Registers (Trap and Breakpoint)
+	struct upc upc2;		/* MultiPHY UTOPIA POS Controller 2 */
+	struct sdma sdma;		/* SDMA */
+	struct dbg dbg;		/* Debug Space */
+	struct rsp rsp[0x2];		/* RISC Special Registers (Trap and Breakpoint)
 				 */
 	u8 res14[0x300];
 	u8 res15[0x3A00];
@@ -479,9 +479,9 @@ typedef struct qe_immap {
 	u8 muram[0xC000];	/* 0x110000 -  0x11C000 Multi-user RAM */
 	u8 res17[0x24000];	/* 0x11C000 -  0x140000 */
 	u8 res18[0xC0000];	/* 0x140000 -  0x200000 */
-} __attribute__ ((packed)) qe_map_t;
+} __attribute__ ((packed));
 
-extern qe_map_t *qe_immr;
+extern struct qe_immap *qe_immr;
 extern phys_addr_t get_qe_base(void);
 
 static inline unsigned long immrbar_virt_to_phys(volatile void * address)
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 94623ee..2e43e45 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -51,18 +51,18 @@ void qe_muram_dump(void);
 void *qe_muram_addr(uint offset);
 /* Buffer descriptors.
 */
-typedef struct qe_bd {
+struct qe_bd {
 	u16 status;
 	u16 length;
 	u32 buf;
-} __attribute__ ((packed)) qe_bd_t;
+} __attribute__ ((packed));
 
-#define QE_SIZEOF_BD       sizeof(qe_bd_t)
+#define QE_SIZEOF_BD       sizeof(struct qe_bd)
 
 #define BD_STATUS_MASK                      0xffff0000
 #define BD_LENGTH_MASK                      0x0000ffff
 
-#define BD_BUFFER_ARG(bd)                   ((qe_bd_t *)bd)->buf
+#define BD_BUFFER_ARG(bd)                   ((struct qe_bd *)bd)->buf
 #define BD_BUFFER_CLEAR(bd)                 out_be32(&(BD_BUFFER_ARG(bd)), 0);
 #define BD_BUFFER(bd)                       in_be32(&(BD_BUFFER_ARG(bd)))
 #define BD_STATUS_AND_LENGTH_SET(bd, val)   out_be32((u32*)bd, val)
@@ -83,66 +83,66 @@ #define QE_ALIGNMENT_OF_PRAM            
 
 /* RISC allocation
 */
-typedef enum qe_risc_allocation {
+enum qe_risc_allocation {
 	QE_RISC_ALLOCATION_RISC1 = 1,	/* RISC 1 */
 	QE_RISC_ALLOCATION_RISC2 = 2,	/* RISC 2 */
 	QE_RISC_ALLOCATION_RISC1_AND_RISC2 = 3	/* Dynamically choose RISC 1 or
 						   RISC 2 */
-} qe_risc_allocation_e;
+};
 
 /* QE extended filtering Table Lookup Key Size
 */
-typedef enum qe_fltr_tbl_lookup_key_size {
+enum qe_fltr_tbl_lookup_key_size {
 	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
 		= 0x3f,		/* LookupKey parsed by the Generate LookupKey
 				   CMD is truncated to 8  bytes */
 	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
 		= 0x5f,		/* LookupKey parsed by the Generate LookupKey
 				   CMD is truncated to 16 bytes */
-} qe_fltr_tbl_lookup_key_size_e;
+};
 
 /* QE FLTR extended filtering Largest External Table Lookup Key Size
 */
-typedef enum qe_fltr_largest_external_tbl_lookup_key_size_ {
+enum qe_fltr_largest_external_tbl_lookup_key_size {
 	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
 		= 0x0,/* not used */
 	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
 		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,	/* 8  bytes */
 	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
 		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES	/* 16 bytes */
-} qe_fltr_largest_external_tbl_lookup_key_size_e;
+};
 
 /* structure representing QE parameter RAM
 */
-typedef struct qe_timer_tables {
+struct qe_timer_tables {
 	u16 tm_base;		/* QE timer table base adr */
 	u16 tm_ptr;		/* QE timer table pointer  */
 	u16 r_tmr;		/* QE timer mode register  */
 	u16 r_tmv;		/* QE timer valid register */
 	u32 tm_cmd;		/* QE timer cmd register   */
 	u32 tm_cnt;		/* QE timer internal cnt   */
-} __attribute__ ((packed)) qe_timer_tables_t;
+} __attribute__ ((packed));
 
 #define QE_FLTR_TAD_SIZE                8
 
 /* QE extended filtering Termination Action Descriptor (TAD)
 */
-typedef struct qe_fltr_tad {
+struct qe_fltr_tad {
 	u8 serialized[QE_FLTR_TAD_SIZE];
-} __attribute__ ((packed)) qe_fltr_tad_t;
+} __attribute__ ((packed));
 
 /* Communication Direction.
 */
-typedef enum comm_dir {
+enum comm_dir {
 	COMM_DIR_NONE = 0,
 	COMM_DIR_RX = 1,
 	COMM_DIR_TX = 2,
 	COMM_DIR_RX_AND_TX = 3
-} comm_dir_e;
+};
 
 /* Clocks and GRG's
 */
-typedef enum qe_clock {
+enum qe_clock {
 	QE_CLK_NONE = 0
 	    , QE_BRG1		/* Baud Rate Generator  1 */
 	    , QE_BRG2		/* Baud Rate Generator  2 */
@@ -185,7 +185,7 @@ typedef enum qe_clock {
 	    , QE_CLK23		/* Clock 23               */
 	    , QE_CLK24		/* Clock 24               */
 	    , QE_CLK_DUMMY
-} qe_clock_e;
+};
 
 /* QE CMXUCR Registers.
  * There are two UCCs represented in each of the four CMXUCR registers.
@@ -366,7 +366,7 @@ #define UCC_GUEMR_SET_RESERVED3 0x10	/* 
 
 /* structure representing UCC SLOW parameter RAM
 */
-typedef struct ucc_slow_pram {
+struct ucc_slow_pram {
 	u16 rbase;		/* RX BD base address       */
 	u16 tbase;		/* TX BD base address       */
 	u8 rfcr;		/* Rx function code         */
@@ -384,7 +384,7 @@ typedef struct ucc_slow_pram {
 	u32 ttemp;		/* Tx temp                  */
 	u32 rcrc;		/* temp receive CRC         */
 	u32 tcrc;		/* temp transmit CRC        */
-} __attribute__ ((packed)) ucc_slow_pram_t;
+} __attribute__ ((packed));
 
 /* General UCC SLOW Mode Register (GUMRH & GUMRL)
 */
diff --git a/include/asm-powerpc/ucc.h b/include/asm-powerpc/ucc.h
index 5c09df6..bca4966 100644
--- a/include/asm-powerpc/ucc.h
+++ b/include/asm-powerpc/ucc.h
@@ -24,13 +24,13 @@ #define UCC_MAX_NUM     8
 
 /* Slow or fast type for UCCs.
 */
-typedef enum ucc_speed_type {
+enum ucc_speed_type {
 	UCC_SPEED_TYPE_FAST, UCC_SPEED_TYPE_SLOW
-} ucc_speed_type_e;
+};
 
 /* Initial UCCs Parameter RAM address relative to: MEM_MAP_BASE (IMMR).
 */
-typedef enum ucc_pram_initial_offset {
+enum ucc_pram_initial_offset {
 	UCC_PRAM_OFFSET_UCC1 = 0x8400,
 	UCC_PRAM_OFFSET_UCC2 = 0x8500,
 	UCC_PRAM_OFFSET_UCC3 = 0x8600,
@@ -39,7 +39,7 @@ typedef enum ucc_pram_initial_offset {
 	UCC_PRAM_OFFSET_UCC6 = 0x8100,
 	UCC_PRAM_OFFSET_UCC7 = 0x8200,
 	UCC_PRAM_OFFSET_UCC8 = 0x8300
-} ucc_pram_initial_offset_e;
+};
 
 /* ucc_set_type
  * Sets UCC to slow or fast mode.
@@ -60,7 +60,7 @@ int ucc_init_guemr(struct ucc_common *re
 
 int ucc_set_qe_mux_mii_mng(int ucc_num);
 
-int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode);
+int ucc_set_qe_mux_rxtx(int ucc_num, enum qe_clock clock, enum comm_dir mode);
 
 int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask);
 
diff --git a/include/asm-powerpc/ucc_fast.h b/include/asm-powerpc/ucc_fast.h
index b1cfd00..1428e53 100644
--- a/include/asm-powerpc/ucc_fast.h
+++ b/include/asm-powerpc/ucc_fast.h
@@ -49,7 +49,7 @@ #define UCC_FAST_RECEIVE_VIRTUAL_FIFO_SI
 
 /* ucc_fast_channel_protocol_mode - UCC FAST mode.
 */
-typedef enum ucc_fast_channel_protocol_mode {
+enum ucc_fast_channel_protocol_mode {
 	UCC_FAST_PROTOCOL_MODE_HDLC = 0x00000000,
 	UCC_FAST_PROTOCOL_MODE_RESERVED01 = 0x00000001,
 	UCC_FAST_PROTOCOL_MODE_RESERVED_QMC = 0x00000002,
@@ -66,73 +66,73 @@ typedef enum ucc_fast_channel_protocol_m
 	UCC_FAST_PROTOCOL_MODE_RESERVED06 = 0x0000000D,
 	UCC_FAST_PROTOCOL_MODE_POS = 0x0000000E,
 	UCC_FAST_PROTOCOL_MODE_RESERVED07 = 0x0000000F
-} ucc_fast_channel_protocol_mode_e;
+};
 
 /* ucc_fast_transparent_txrx - UCC Fast Transparent TX & RX
 */
-typedef enum ucc_fast_transparent_txrx {
+enum ucc_fast_transparent_txrx {
 	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_NORMAL = 0x00000000,
 	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_TRANSPARENT = 0x18000000
-} ucc_fast_transparent_txrx_e;
+};
 
 /* UCC fast diagnostic mode
 */
-typedef enum ucc_fast_diag_mode {
+enum ucc_fast_diag_mode {
 	UCC_FAST_DIAGNOSTIC_NORMAL = 0x0,
 	UCC_FAST_DIAGNOSTIC_LOCAL_LOOP_BACK = 0x40000000,
 	UCC_FAST_DIAGNOSTIC_AUTO_ECHO = 0x80000000,
 	UCC_FAST_DIAGNOSTIC_LOOP_BACK_AND_ECHO = 0xC0000000
-} ucc_fast_diag_mode_e;
+};
 
 /* UCC fast Sync length (transparent mode only)
 */
-typedef enum ucc_fast_sync_len {
+enum ucc_fast_sync_len {
 	UCC_FAST_SYNC_LEN_NOT_USED = 0x0,
 	UCC_FAST_SYNC_LEN_AUTOMATIC = 0x00004000,
 	UCC_FAST_SYNC_LEN_8_BIT = 0x00008000,
 	UCC_FAST_SYNC_LEN_16_BIT = 0x0000C000
-} ucc_fast_sync_len_e;
+};
 
 /* UCC fast RTS mode
 */
-typedef enum ucc_fast_ready_to_send {
+enum ucc_fast_ready_to_send {
 	UCC_FAST_SEND_IDLES_BETWEEN_FRAMES = 0x00000000,
 	UCC_FAST_SEND_FLAGS_BETWEEN_FRAMES = 0x00002000
-} ucc_fast_ready_to_send_e;
+};
 
 /* UCC fast receiver decoding mode
 */
-typedef enum ucc_fast_rx_decoding_method {
+enum ucc_fast_rx_decoding_method {
 	UCC_FAST_RX_ENCODING_NRZ = 0x00000000,
 	UCC_FAST_RX_ENCODING_NRZI = 0x00000800,
 	UCC_FAST_RX_ENCODING_RESERVED0 = 0x00001000,
 	UCC_FAST_RX_ENCODING_RESERVED1 = 0x00001800
-} ucc_fast_rx_decoding_method_e;
+};
 
 /* UCC fast transmitter encoding mode
 */
-typedef enum ucc_fast_tx_encoding_method {
+enum ucc_fast_tx_encoding_method {
 	UCC_FAST_TX_ENCODING_NRZ = 0x00000000,
 	UCC_FAST_TX_ENCODING_NRZI = 0x00000100,
 	UCC_FAST_TX_ENCODING_RESERVED0 = 0x00000200,
 	UCC_FAST_TX_ENCODING_RESERVED1 = 0x00000300
-} ucc_fast_tx_encoding_method_e;
+};
 
 /* UCC fast CRC length
 */
-typedef enum ucc_fast_transparent_tcrc {
+enum ucc_fast_transparent_tcrc {
 	UCC_FAST_16_BIT_CRC = 0x00000000,
 	UCC_FAST_CRC_RESERVED0 = 0x00000040,
 	UCC_FAST_32_BIT_CRC = 0x00000080,
 	UCC_FAST_CRC_RESERVED1 = 0x000000C0
-} ucc_fast_transparent_tcrc_e;
+};
 
 /* Fast UCC initialization structure.
 */
-typedef struct ucc_fast_info {
+struct ucc_fast_info {
 	int ucc_num;
-	qe_clock_e rx_clock;
-	qe_clock_e tx_clock;
+	enum qe_clock rx_clock;
+	enum qe_clock tx_clock;
 	u32 regs;
 	int irq;
 	u32 uccm_mask;
@@ -157,17 +157,17 @@ typedef struct ucc_fast_info {
 	u16 utfet;
 	u16 utftt;
 	u16 ufpt;
-	ucc_fast_channel_protocol_mode_e mode;
-	ucc_fast_transparent_txrx_e ttx_trx;
-	ucc_fast_tx_encoding_method_e tenc;
-	ucc_fast_rx_decoding_method_e renc;
-	ucc_fast_transparent_tcrc_e tcrc;
-	ucc_fast_sync_len_e synl;
-} ucc_fast_info_t;
-
-typedef struct ucc_fast_private {
-	ucc_fast_info_t *uf_info;
-	ucc_fast_t *uf_regs;	/* a pointer to memory map of UCC regs. */
+	enum ucc_fast_channel_protocol_mode mode;
+	enum ucc_fast_transparent_txrx ttx_trx;
+	enum ucc_fast_tx_encoding_method tenc;
+	enum ucc_fast_rx_decoding_method renc;
+	enum ucc_fast_transparent_tcrc tcrc;
+	enum ucc_fast_sync_len synl;
+};
+
+struct ucc_fast_private {
+	struct ucc_fast_info *uf_info;
+	struct ucc_fast *uf_regs;	/* a pointer to memory map of UCC regs. */
 	u32 *p_ucce;		/* a pointer to the event register in memory. */
 	u32 *p_uccm;		/* a pointer to the mask register in memory.  */
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT)  */
@@ -191,7 +191,7 @@ #ifdef STATISTICS
 				   */
 #endif				/* STATISTICS */
 	u16 mrblr;		/* maximum receive buffer length */
-} ucc_fast_private_t;
+};
 
 /* ucc_fast_init
  * Initializes Fast UCC according to user provided parameters.
@@ -199,14 +199,14 @@ #endif				/* STATISTICS */
  *          uf_info  - (In) pointer to the fast UCC info structure.
  *          uccf_ret - (Out) pointer to the fast UCC structure.
  */
-int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret);
+int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret);
 
 /* ucc_fast_free
  * Frees all resources for fast UCC.
  *
  *          uccf - (In) pointer to the fast UCC structure.
  */
-void ucc_fast_free(ucc_fast_private_t * uccf);
+void ucc_fast_free(struct ucc_fast_private * uccf);
 
 /* ucc_fast_enable
  * Enables a fast UCC port.
@@ -215,7 +215,7 @@ void ucc_fast_free(ucc_fast_private_t * 
  *          uccf - (In) pointer to the fast UCC structure.
  *          mode - (In) TX, RX, or both.
  */
-void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode);
+void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode);
 
 /* ucc_fast_disable
  * Disables a fast UCC port.
@@ -224,7 +224,7 @@ void ucc_fast_enable(ucc_fast_private_t 
  *          uccf - (In) pointer to the fast UCC structure.
  *          mode - (In) TX, RX, or both.
  */
-void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode);
+void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode);
 
 /* ucc_fast_irq
  * Handles interrupts on fast UCC.
@@ -232,7 +232,7 @@ void ucc_fast_disable(ucc_fast_private_t
  *
  *          uccf - (In) pointer to the fast UCC structure.
  */
-void ucc_fast_irq(ucc_fast_private_t * uccf);
+void ucc_fast_irq(struct ucc_fast_private * uccf);
 
 /* ucc_fast_transmit_on_demand
  * Immediately forces a poll of the transmitter for data to be sent.
@@ -245,10 +245,10 @@ void ucc_fast_irq(ucc_fast_private_t * u
  *
  *          uccf - (In) pointer to the fast UCC structure.
  */
-void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf);
+void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf);
 
 u32 ucc_fast_get_qe_cr_subblock(int uccf_num);
 
-void ucc_fast_dump_regs(ucc_fast_private_t * uccf);
+void ucc_fast_dump_regs(struct ucc_fast_private * uccf);
 
 #endif				/* __UCC_FAST_H__ */
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
index 07db339..4bca460 100644
--- a/include/asm-powerpc/ucc_slow.h
+++ b/include/asm-powerpc/ucc_slow.h
@@ -87,15 +87,15 @@ #define ALIGNMENT_OF_UCC_SLOW_PRAM    64
 
 /* UCC Slow Channel Protocol Mode
 */
-typedef enum ucc_slow_channel_protocol_mode {
+enum ucc_slow_channel_protocol_mode {
 	UCC_SLOW_CHANNEL_PROTOCOL_MODE_QMC = 0x00000002,	/* QMC */
 	UCC_SLOW_CHANNEL_PROTOCOL_MODE_UART = 0x00000004,	/* UART */
 	UCC_SLOW_CHANNEL_PROTOCOL_MODE_BISYNC = 0x00000008	/* BISYNC */
-} ucc_slow_channel_protocol_mode_e;
+};
 
 /* UCC Slow Transparent Transmit CRC (TCRC)
 */
-typedef enum ucc_slow_transparent_tcrc {
+enum ucc_slow_transparent_tcrc {
 	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC16 = 0x00000000,	/* 16-bit
 								   CCITT CRC
 								   (HDLC).
@@ -109,11 +109,11 @@ typedef enum ucc_slow_transparent_tcrc {
 								   (Ethernet
 								   and HDLC).
 								 */
-} ucc_slow_transparent_tcrc_e;
+};
 
 /* UCC Slow oversampling rate for transmitter (TDCR)
 */
-typedef enum ucc_slow_tx_oversampling_rate {
+enum ucc_slow_tx_oversampling_rate {
 	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_1 = 0x00000000,	/* 1x clock
 								   mode */
 	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_8 = 0x00010000,	/* 8x clock
@@ -122,11 +122,11 @@ typedef enum ucc_slow_tx_oversampling_ra
 								   mode */
 	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_32 = 0x00030000	/* 32x clock
 								   mode */
-} ucc_slow_tx_oversampling_rate_e;
+};
 
 /* UCC Slow Oversampling rate for receiver (RDCR)
 */
-typedef enum ucc_slow_rx_oversampling_rate {
+enum ucc_slow_rx_oversampling_rate {
 	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_1 = 0x00000000,	/* 1x clock
 								   mode */
 	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_8 = 0x00004000,	/* 8x clock
@@ -135,36 +135,36 @@ typedef enum ucc_slow_rx_oversampling_ra
 								   mode */
 	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_32 = 0x0000c000	/* 32x clock
 								   mode */
-} ucc_slow_rx_oversampling_rate_e;
+};
 
 /* UCC Slow Transmitter encoding method (TENC)
 */
-typedef enum ucc_slow_tx_encoding_method {
+enum ucc_slow_tx_encoding_method {
 	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZ = 0x00000000,
 	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZI = 0x00000100
-} ucc_slow_tx_encoding_method_e;
+};
 
 /* UCC Slow Receiver decoding method (RENC)
 */
-typedef enum ucc_slow_rx_decoding_method {
+enum ucc_slow_rx_decoding_method {
 	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZ = 0x00000000,
 	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZI = 0x00000800
-} ucc_slow_rx_decoding_method_e;
+};
 
 /* UCC Slow Diagnostic mode (DIAG)
 */
-typedef enum ucc_slow_diag_mode {
+enum ucc_slow_diag_mode {
 	UCC_SLOW_DIAG_MODE_NORMAL = 0x00000000,
 	UCC_SLOW_DIAG_MODE_LOOPBACK = 0x00000040,
 	UCC_SLOW_DIAG_MODE_ECHO = 0x00000080,
 	UCC_SLOW_DIAG_MODE_LOOPBACK_ECHO = 0x000000c0
-} ucc_slow_diag_mode_e;
+};
 
-typedef struct ucc_slow_info {
+struct ucc_slow_info {
 	int ucc_num;
-	qe_clock_e rx_clock;
-	qe_clock_e tx_clock;
-	ucc_slow_t *us_regs;
+	enum qe_clock rx_clock;
+	enum qe_clock tx_clock;
+	struct ucc_slow *us_regs;
 	int irq;
 	u16 uccm_mask;
 	int data_mem_part;
@@ -189,19 +189,19 @@ typedef struct ucc_slow_info {
 	int tfl;
 	int txsy;
 	u16 max_rx_buf_length;
-	ucc_slow_transparent_tcrc_e tcrc;
-	ucc_slow_channel_protocol_mode_e mode;
-	ucc_slow_diag_mode_e diag;
-	ucc_slow_tx_oversampling_rate_e tdcr;
-	ucc_slow_rx_oversampling_rate_e rdcr;
-	ucc_slow_tx_encoding_method_e tenc;
-	ucc_slow_rx_decoding_method_e renc;
-} ucc_slow_info_t;
+	enum ucc_slow_transparent_tcrc tcrc;
+	enum ucc_slow_channel_protocol_mode mode;
+	enum ucc_slow_diag_mode diag;
+	enum ucc_slow_tx_oversampling_rate tdcr;
+	enum ucc_slow_rx_oversampling_rate rdcr;
+	enum ucc_slow_tx_encoding_method tenc;
+	enum ucc_slow_rx_decoding_method renc;
+};
 
-typedef struct ucc_slow_private {
-	ucc_slow_info_t *us_info;
-	ucc_slow_t *us_regs;	/* a pointer to memory map of UCC regs.  */
-	ucc_slow_pram_t *us_pram;	/* a pointer to the parameter RAM.  */
+struct ucc_slow_private {
+	struct ucc_slow_info *us_info;
+	struct ucc_slow *us_regs;	/* a pointer to memory map of UCC regs.  */
+	struct ucc_slow_pram *us_pram;	/* a pointer to the parameter RAM.  */
 	uint us_pram_offset;
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
 	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
@@ -230,7 +230,7 @@ #ifdef STATISTICS
 				   were discarded by the driver due to
 				   errors). */
 #endif				/* STATISTICS */
-} ucc_slow_private_t;
+};
 
 /* ucc_slow_init
  * Initializes Slow UCC according to provided parameters.
@@ -238,14 +238,14 @@ #endif				/* STATISTICS */
  *          us_info  - (In) pointer to the slow UCC info structure.
  *          uccs_ret - (Out) pointer to the slow UCC structure.
  */
-int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret);
+int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** uccs_ret);
 
 /* ucc_slow_free
  * Frees all resources for slow UCC.
  *
  *          uccs - (In) pointer to the slow UCC structure.
  */
-void ucc_slow_free(ucc_slow_private_t * uccs);
+void ucc_slow_free(struct ucc_slow_private * uccs);
 
 /* ucc_slow_enable
  * Enables a fast UCC port.
@@ -254,7 +254,7 @@ void ucc_slow_free(ucc_slow_private_t * 
  *          uccs - (In) pointer to the slow UCC structure.
  *          mode - (In) TX, RX, or both.
  */
-void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode);
+void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode);
 
 /* ucc_slow_disable
  * Disables a fast UCC port.
@@ -263,7 +263,7 @@ void ucc_slow_enable(ucc_slow_private_t 
  *          uccs - (In) pointer to the slow UCC structure.
  *          mode - (In) TX, RX, or both.
  */
-void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode);
+void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode);
 
 /* ucc_slow_poll_transmitter_now
  * Immediately forces a poll of the transmitter for data to be sent.
@@ -276,28 +276,28 @@ void ucc_slow_disable(ucc_slow_private_t
  *
  *          uccs - (In) pointer to the slow UCC structure.
  */
-void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs);
+void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs);
 
 /* ucc_slow_graceful_stop_tx
  * Smoothly stops transmission on a specified slow UCC.
  *
  *          uccs - (In) pointer to the slow UCC structure.
  */
-void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs);
+void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs);
 
 /* ucc_slow_stop_tx
  * Stops transmission on a specified slow UCC.
  *
  *          uccs - (In) pointer to the slow UCC structure.
  */
-void ucc_slow_stop_tx(ucc_slow_private_t * uccs);
+void ucc_slow_stop_tx(struct ucc_slow_private * uccs);
 
 /* ucc_slow_restart_x
  * Restarts transmitting on a specified slow UCC.
  *
  *          uccs - (In) pointer to the slow UCC structure.
  */
-void ucc_slow_restart_x(ucc_slow_private_t * uccs);
+void ucc_slow_restart_x(struct ucc_slow_private * uccs);
 
 u32 ucc_slow_get_qe_cr_subblock(int uccs_num);
 
-- 
1.4.2.1
