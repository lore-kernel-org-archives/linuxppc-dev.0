Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CCB26DDF12
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:10:31 +1100 (EST)
Date: Fri, 5 Dec 2008 23:10:30 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 2/7] spi_mpc83xx: Fix sparse warnings
Message-ID: <20081205201030.GB19758@oksana.dev.rtsoft.ru>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch fixes following sparse warnings:

  CHECK   spi_mpc83xx.c
spi_mpc83xx.c:145:1: warning: symbol 'mpc83xx_spi_rx_buf_u8' was not declared. Should it be static?
spi_mpc83xx.c:146:1: warning: symbol 'mpc83xx_spi_rx_buf_u16' was not declared. Should it be static?
spi_mpc83xx.c:147:1: warning: symbol 'mpc83xx_spi_rx_buf_u32' was not declared. Should it be static?
spi_mpc83xx.c:148:1: warning: symbol 'mpc83xx_spi_tx_buf_u8' was not declared. Should it be static?
spi_mpc83xx.c:149:1: warning: symbol 'mpc83xx_spi_tx_buf_u16' was not declared. Should it be static?
spi_mpc83xx.c:150:1: warning: symbol 'mpc83xx_spi_tx_buf_u32' was not declared. Should it be static?
spi_mpc83xx.c:175:32: warning: incorrect type in initializer (different address spaces)
spi_mpc83xx.c:175:32:    expected void *tmp_ptr
spi_mpc83xx.c:175:32:    got unsigned int [noderef] <asn:2>*<noident>
spi_mpc83xx.c:183:26: warning: incorrect type in argument 1 (different address spaces)
spi_mpc83xx.c:183:26:    expected unsigned int [noderef] [usertype] <asn:2>*reg
spi_mpc83xx.c:183:26:    got void *tmp_ptr
spi_mpc83xx.c:184:26: warning: incorrect type in argument 1 (different address spaces)
spi_mpc83xx.c:184:26:    expected unsigned int [noderef] [usertype] <asn:2>*reg
spi_mpc83xx.c:184:26:    got void *tmp_ptr
spi_mpc83xx.c:287:31: warning: incorrect type in initializer (different address spaces)
spi_mpc83xx.c:287:31:    expected void *tmp_ptr
spi_mpc83xx.c:287:31:    got unsigned int [noderef] <asn:2>*<noident>
spi_mpc83xx.c:295:25: warning: incorrect type in argument 1 (different address spaces)
spi_mpc83xx.c:295:25:    expected unsigned int [noderef] [usertype] <asn:2>*reg
spi_mpc83xx.c:295:25:    got void *tmp_ptr
spi_mpc83xx.c:296:25: warning: incorrect type in argument 1 (different address spaces)
spi_mpc83xx.c:296:25:    expected unsigned int [noderef] [usertype] <asn:2>*reg
spi_mpc83xx.c:296:25:    got void *tmp_ptr
spi_mpc83xx.c:486:13: warning: symbol 'mpc83xx_spi_irq' was not declared. Should it be static?

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index ac0e3e4..6ef8937 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -123,6 +123,7 @@ static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)
 }
 
 #define MPC83XX_SPI_RX_BUF(type) 					  \
+static									  \
 void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
 {									  \
 	type * rx = mpc83xx_spi->rx;					  \
@@ -131,6 +132,7 @@ void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
 }
 
 #define MPC83XX_SPI_TX_BUF(type)				\
+static								\
 u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
 {								\
 	u32 data;						\
@@ -172,7 +174,7 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 
 		if (cs->hw_mode != regval) {
 			unsigned long flags;
-			void *tmp_ptr = &mpc83xx_spi->base->mode;
+			__be32 __iomem *mode = &mpc83xx_spi->base->mode;
 
 			regval = cs->hw_mode;
 			/* Turn off IRQs locally to minimize time that
@@ -180,8 +182,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			 */
 			local_irq_save(flags);
 			/* Turn off SPI unit prior changing mode */
-			mpc83xx_spi_write_reg(tmp_ptr, regval & ~SPMODE_ENABLE);
-			mpc83xx_spi_write_reg(tmp_ptr, regval);
+			mpc83xx_spi_write_reg(mode, regval & ~SPMODE_ENABLE);
+			mpc83xx_spi_write_reg(mode, regval);
 			local_irq_restore(flags);
 		}
 		if (mpc83xx_spi->activate_cs)
@@ -284,7 +286,7 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 	if (cs->hw_mode != regval) {
 		unsigned long flags;
-		void *tmp_ptr = &mpc83xx_spi->base->mode;
+		__be32 __iomem *mode = &mpc83xx_spi->base->mode;
 
 		regval = cs->hw_mode;
 		/* Turn off IRQs locally to minimize time
@@ -292,8 +294,8 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		 */
 		local_irq_save(flags);
 		/* Turn off SPI unit prior changing mode */
-		mpc83xx_spi_write_reg(tmp_ptr, regval & ~SPMODE_ENABLE);
-		mpc83xx_spi_write_reg(tmp_ptr, regval);
+		mpc83xx_spi_write_reg(mode, regval & ~SPMODE_ENABLE);
+		mpc83xx_spi_write_reg(mode, regval);
 		local_irq_restore(flags);
 	}
 	return 0;
@@ -483,7 +485,7 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data)
+static irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data)
 {
 	struct mpc83xx_spi *mpc83xx_spi = context_data;
 	u32 event;
-- 
1.5.6.5
