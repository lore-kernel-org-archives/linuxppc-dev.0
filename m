Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9EDF1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:40:01 +1000 (AEST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Date: Tue, 14 Jul 2015 11:19:56 +0200
Message-Id: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The register layout of the PSC devices differ between MPC5121 and
MPC5125, but the registers are named nearly identical and their purpose
is similar enough ("freescale identical") such that substituting
mpc52xx_psc by mpc5125_psc is nearly enough to make the driver work on
MPC5125. To keep supporting MPC5121 this patch introduces a cpp
macro to select the right struct that defines the register layout.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |  5 ++-
 drivers/spi/spi-mpc512x-psc.c          | 70 +++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index d0ece257d310..04c7e8fc24c2 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -150,7 +150,10 @@
 
 /* Structure of the hardware registers */
 struct mpc52xx_psc {
-	u8		mode;		/* PSC + 0x00 */
+	union {
+		u8	mode;		/* PSC + 0x00 */
+		u8	mr2;
+	};
 	u8		reserved0[3];
 	union {				/* PSC + 0x04 */
 		u16	status;
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 965d2bdcfdcc..280794dd248a 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -30,11 +30,37 @@
 #include <linux/gpio.h>
 #include <asm/mpc52xx_psc.h>
 
+enum {
+	TYPE_MPC5121,
+	TYPE_MPC5125,
+};
+
+/*
+ * This macro abstracts the differences in the PSC register layout between
+ * MPC5121 (which uses a struct mpc52xx_psc) and MPC5125 (using mpc5125_psc).
+ */
+#define psc_addr(mps, regname) ({					\
+	void *__ret;							\
+	switch(mps->type) {						\
+	case TYPE_MPC5121: {						\
+			struct mpc52xx_psc __iomem *psc = mps->psc;	\
+			__ret = &psc->regname;				\
+		};							\
+		break;							\
+	case TYPE_MPC5125: {						\
+			struct mpc5125_psc __iomem *psc = mps->psc;	\
+			__ret = &psc->regname;				\
+		};							\
+		break;							\
+	}								\
+	__ret; })
+
 struct mpc512x_psc_spi {
 	void (*cs_control)(struct spi_device *spi, bool on);
 
 	/* driver internal data */
-	struct mpc52xx_psc __iomem *psc;
+	int type;
+	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
@@ -71,13 +97,12 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 	u32 sicr;
 	u32 ccr;
 	int speed;
 	u16 bclkdiv;
 
-	sicr = in_be32(&psc->sicr);
+	sicr = in_be32(psc_addr(mps, sicr));
 
 	/* Set clock phase and polarity */
 	if (spi->mode & SPI_CPHA)
@@ -94,9 +119,9 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 		sicr |= 0x10000000;
 	else
 		sicr &= ~0x10000000;
-	out_be32(&psc->sicr, sicr);
+	out_be32(psc_addr(mps, sicr), sicr);
 
-	ccr = in_be32(&psc->ccr);
+	ccr = in_be32(psc_addr(mps, ccr));
 	ccr &= 0xFF000000;
 	speed = cs->speed_hz;
 	if (!speed)
@@ -104,7 +129,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	bclkdiv = (mps->mclk_rate / speed) - 1;
 
 	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
-	out_be32(&psc->ccr, ccr);
+	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
 	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
@@ -315,16 +340,15 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 
 	dev_dbg(&master->dev, "%s()\n", __func__);
 
 	/* Zero MR2 */
-	in_8(&psc->mode);
-	out_8(&psc->mode, 0x0);
+	in_8(psc_addr(mps, mr2));
+	out_8(psc_addr(mps, mr2), 0x0);
 
 	/* enable transmitter/receiver */
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
 
 	return 0;
 }
@@ -332,13 +356,12 @@ static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
 static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_master *master)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 
 	dev_dbg(&master->dev, "%s()\n", __func__);
 
 	/* disable transmitter/receiver and fifo interrupt */
-	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
 	out_be32(&fifo->tximr, 0);
 
 	return 0;
@@ -388,7 +411,6 @@ static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 static int mpc512x_psc_spi_port_config(struct spi_master *master,
 				       struct mpc512x_psc_spi *mps)
 {
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 	u32 sicr;
 	u32 ccr;
@@ -396,12 +418,12 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 	u16 bclkdiv;
 
 	/* Reset the PSC into a known state */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
-	out_8(&psc->command, MPC52xx_PSC_RST_TX);
-	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_RST_RX);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_RST_TX);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
 
 	/* Disable psc interrupts all useful interrupts are in fifo */
-	out_be16(&psc->isr_imr.imr, 0);
+	out_be16(psc_addr(mps, isr_imr.imr), 0);
 
 	/* Disable fifo interrupts, will be enabled later */
 	out_be32(&fifo->tximr, 0);
@@ -417,18 +439,18 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 		0x00004000 |	/* MSTR = 1   -- SPI master */
 		0x00000800;	/* UseEOF = 1 -- SS low until EOF */
 
-	out_be32(&psc->sicr, sicr);
+	out_be32(psc_addr(mps, sicr), sicr);
 
-	ccr = in_be32(&psc->ccr);
+	ccr = in_be32(psc_addr(mps, ccr));
 	ccr &= 0xFF000000;
 	speed = 1000000;	/* default 1MHz */
 	bclkdiv = (mps->mclk_rate / speed) - 1;
 	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
-	out_be32(&psc->ccr, ccr);
+	out_be32(psc_addr(mps, ccr), ccr);
 
 	/* Set 2ms DTL delay */
-	out_8(&psc->ctur, 0x00);
-	out_8(&psc->ctlr, 0x82);
+	out_8(psc_addr(mps, ctur), 0x00);
+	out_8(psc_addr(mps, ctlr), 0x82);
 
 	/* we don't use the alarms */
 	out_be32(&fifo->rxalarm, 0xfff);
@@ -482,6 +504,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 
 	dev_set_drvdata(dev, master);
 	mps = spi_master_get_devdata(master);
+	mps->type = (int)of_device_get_match_data(dev);
 	mps->irq = irq;
 
 	if (pdata == NULL) {
@@ -589,7 +612,8 @@ static int mpc512x_psc_spi_of_remove(struct platform_device *op)
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
-	{ .compatible = "fsl,mpc5121-psc-spi", },
+	{ .compatible = "fsl,mpc5121-psc-spi", .data = (void *)TYPE_MPC5121 },
+	{ .compatible = "fsl,mpc5125-psc-spi", .data = (void *)TYPE_MPC5125 },
 	{},
 };
 
-- 
2.1.4
