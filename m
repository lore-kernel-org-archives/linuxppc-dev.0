Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45ABCB6FD5
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2012 03:06:52 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <broonie@opensource.wolfsonmicro.com>,
 <linuxppc-dev@ozlabs.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] [v3] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
Date: Mon, 19 Mar 2012 11:06:39 -0500
Message-ID: <1332173199-25877-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from fsl_guts.h.
The check was originally intended to allow the same header file to
be used on 85xx and 86xx systems, even though the Global Utilities
register could be different.  It turns out that they're not actually
different, and so the check is not necessary.  In addition, neither
macro is defined for 64-bit e5500 kernels, so that causes a build
break.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

The ASoC part of this patch applies cleanly to the ASoC for-3.4 branch,
so this patch should not cause any merge conflicts if carried on the
PowerPC branch, so I suggest that Kumar pick this up for 3.4 (it fixes a
potential 64-bit book-e build break), with an ACK from Mark. 

 arch/powerpc/include/asm/fsl_guts.h        |   26 +++++---------------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c     |    4 ++--
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c               |    8 ++++----
 sound/soc/fsl/p1022_ds.c                   |   10 +++++-----
 7 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index ce04530..aa4c488 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -16,15 +16,6 @@
 #define __ASM_POWERPC_FSL_GUTS_H__
 #ifdef __KERNEL__
 
-/*
- * These #ifdefs are safe because it's not possible to build a kernel that
- * runs on e500 and e600 cores.
- */
-
-#if !defined(CONFIG_PPC_85xx) && !defined(CONFIG_PPC_86xx)
-#error Only 85xx and 86xx SOCs are supported
-#endif
-
 /**
  * Global Utility Registers.
  *
@@ -36,11 +27,7 @@
  * different names.  In these cases, one name is chosen to avoid extraneous
  * #ifdefs.
  */
-#ifdef CONFIG_PPC_85xx
-struct ccsr_guts_85xx {
-#else
-struct ccsr_guts_86xx {
-#endif
+struct ccsr_guts {
 	__be32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
 	__be32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
 	__be32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
@@ -77,11 +64,8 @@ struct ccsr_guts_86xx {
 	u8	res0a8[0xb0 - 0xa8];
 	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
 	u8	res0b4[0xc0 - 0xb4];
-#ifdef CONFIG_PPC_85xx
-	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register */
-#else
-	__be32	elbcvselcr;	/* 0x.00c0 - eLBC Voltage Select Ctrl Reg */
-#endif
+	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register
+					     Called 'elbcvselcr' on 86xx SOCs */
 	u8	res0c4[0x224 - 0xc4];
 	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
@@ -136,7 +120,7 @@ struct ccsr_guts_86xx {
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * device: The device to set as the source (CCSR_GUTS_DMACR_DEV_xx)
  */
-static inline void guts_set_dmacr(struct ccsr_guts_86xx __iomem *guts,
+static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int device)
 {
 	unsigned int shift = 16 + (8 * (1 - co) + 2 * (3 - ch));
@@ -172,7 +156,7 @@ static inline void guts_set_dmacr(struct ccsr_guts_86xx __iomem *guts,
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * value: the new value for the bit (0 or 1)
  */
-static inline void guts_set_pmuxcr_dma(struct ccsr_guts_86xx __iomem *guts,
+static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int value)
 {
 	if ((ch == 0) || (ch == 3)) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index f33662b..e82f06f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -271,7 +271,7 @@ static void __init mpc85xx_mds_qe_init(void)
 
 	if (machine_is(p1021_mds)) {
 
-		struct ccsr_guts_85xx __iomem *guts;
+		struct ccsr_guts __iomem *guts;
 
 		np = of_find_node_by_name(NULL, "global-utilities");
 		if (np) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index db214cd..1a66c3d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -128,7 +128,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
 
-		struct ccsr_guts_85xx __iomem *guts;
+		struct ccsr_guts __iomem *guts;
 
 		np = of_find_node_by_name(NULL, "global-utilities");
 		if (np) {
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 0fe88e3..e74b7cd 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -150,7 +150,7 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 {
 	struct device_node *guts_node;
 	struct device_node *indirect_node = NULL;
-	struct ccsr_guts_85xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 	u8 __iomem *lbc_lcs0_ba = NULL;
 	u8 __iomem *lbc_lcs1_ba = NULL;
 	u8 b;
@@ -269,7 +269,7 @@ exit:
 void p1022ds_set_pixel_clock(unsigned int pixclock)
 {
 	struct device_node *guts_np = NULL;
-	struct ccsr_guts_85xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 	unsigned long freq;
 	u64 temp;
 	u32 pxclk;
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 13fa9a6..b8b1f33 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -226,7 +226,7 @@ void mpc8610hpcd_set_monitor_port(enum fsl_diu_monitor_port port)
 void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 {
 	struct device_node *guts_np = NULL;
-	struct ccsr_guts_86xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 	unsigned long freq;
 	u64 temp;
 	u32 pxclk;
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 0ea4a5a..1f4c3b7 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -58,9 +58,9 @@ static int mpc8610_hpcd_machine_probe(struct snd_soc_card *card)
 {
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
-	struct ccsr_guts_86xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 
-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_86xx));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
@@ -142,9 +142,9 @@ static int mpc8610_hpcd_machine_remove(struct snd_soc_card *card)
 {
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
-	struct ccsr_guts_86xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 
-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_86xx));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a5d4e80..d0dee59 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -46,7 +46,7 @@
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * device: The device to set as the target (CCSR_GUTS_DMUXCR_xxx)
  */
-static inline void guts_set_dmuxcr(struct ccsr_guts_85xx __iomem *guts,
+static inline void guts_set_dmuxcr(struct ccsr_guts __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int device)
 {
 	unsigned int shift = 16 + (8 * (1 - co) + 2 * (3 - ch));
@@ -90,9 +90,9 @@ static int p1022_ds_machine_probe(struct snd_soc_card *card)
 {
 	struct machine_data *mdata =
 		container_of(card, struct machine_data, card);
-	struct ccsr_guts_85xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 
-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_85xx));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
@@ -164,9 +164,9 @@ static int p1022_ds_machine_remove(struct snd_soc_card *card)
 {
 	struct machine_data *mdata =
 		container_of(card, struct machine_data, card);
-	struct ccsr_guts_85xx __iomem *guts;
+	struct ccsr_guts __iomem *guts;
 
-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_85xx));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
-- 
1.7.10.rc1.8.ga99c5.dirty
