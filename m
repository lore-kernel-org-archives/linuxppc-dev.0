Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id F286767C0F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 21:02:53 +1100 (EST)
Subject: RE: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0612132349560.3439@gate.crashing.org>
References: <037901c71f14$a47115b0$020120ac@Jocke>
	<Pine.LNX.4.64.0612132349560.3439@gate.crashing.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:02:47 +0100
Message-Id: <1166090567.30422.73.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'David Brownell' <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-13 at 23:54 -0600, Kumar Gala wrote:
> What about something like the following were we pass in if we are in a 
> quicc engine to the driver via the platform device.
> 
> Joakim, I haven't tested this so would like to know if this works for you 
> on your 832x.  I was also wondering if there was a reason you wanted to 
> use the QE SPI in CPU mode and not QE mode, lack of driver, something 
> else?

Just lack of driver. The amont of data is small in my case so it does
not matter much.

> 
> Also, if this patch looks good to David, I'll clean it up and send it 
> upstream.  I want to rename the driver and cleanup the Kconfig to make it 
> a bit more generic to cover more than just mpc83xx. (The same driver 
> should work on the MPC8568 so I was going to rename the driver 
> spi_mpc8xxx.c).
> 
> - k

patch needs a litte work, the shift is diffrent for tx resp. rx so I 
adjusted that and added a temp hack(still in patch below) to force qe_mode.
The name qe_mode is misleading. This i a QE enabled CPU, but SPI is running in cpu mode. qe_mode implies that SPI is runing in native QUICC
mode.

Adjusted patch(lets hope I didn't mangle this one:):

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index ff0b048..0c31878 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -47,6 +47,7 @@ struct mpc83xx_spi_reg {
 #define	SPMODE_ENABLE		(1 << 24)
 #define	SPMODE_LEN(x)		((x) << 20)
 #define	SPMODE_PM(x)		((x) << 16)
+#define	SPMODE_OP		(1 << 14)
 
 /*
  * Default for SPI Mode:
@@ -85,6 +86,11 @@ struct mpc83xx_spi {
 	unsigned nsecs;		/* (clock cycle time)/2 */
 
 	u32 sysclk;
+	u32 rx_shift;		/* amount to adjust RX data regs if in qe mode */
+	u32 tx_shift;		/* amount to adjust TX data regs if in qe mode */
+
+	bool qe_mode;
+
 	void (*activate_cs) (u8 cs, u8 polarity);
 	void (*deactivate_cs) (u8 cs, u8 polarity);
 };
@@ -103,7 +109,7 @@ static inline u32 mpc83xx_spi_read_reg(_
 void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
 {									  \
 	type * rx = mpc83xx_spi->rx;					  \
-	*rx++ = (type)data;						  \
+	*rx++ = (type)(data >> mpc83xx_spi->rx_shift);			  \
 	mpc83xx_spi->rx = rx;						  \
 }
 
@@ -112,7 +118,7 @@ u32 mpc83xx_spi_tx_buf_##type(struct mpc
 {								\
 	u32 data;						\
 	const type * tx = mpc83xx_spi->tx;			\
-	data = *tx++;						\
+	data = *tx++ << mpc83xx_spi->tx_shift;			\
 	mpc83xx_spi->tx = tx;					\
 	return data;						\
 }
@@ -195,12 +201,22 @@ int mpc83xx_spi_setup_transfer(struct sp
 	    || ((bits_per_word > 16) && (bits_per_word != 32)))
 		return -EINVAL;
 
+	mpc83xx_spi->rx_shift = 0;
+	mpc83xx_spi->tx_shift = 0;
 	if (bits_per_word <= 8) {
 		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
+		if (mpc83xx_spi->qe_mode) {
+			mpc83xx_spi->rx_shift = 16;
+			mpc83xx_spi->tx_shift = 24;
+		}
 	} else if (bits_per_word <= 16) {
 		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u16;
 		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u16;
+		if (mpc83xx_spi->qe_mode) {
+			mpc83xx_spi->rx_shift = 16;
+			mpc83xx_spi->tx_shift = 16;
+		}
 	} else if (bits_per_word <= 32) {
 		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u32;
 		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u32;
@@ -369,8 +385,8 @@ static int __init mpc83xx_spi_probe(stru
 		ret = -ENODEV;
 		goto free_master;
 	}
-
 	mpc83xx_spi = spi_master_get_devdata(master);
+	pdata->qe_mode = 1; // temp hack to force 832x mode
 	mpc83xx_spi->bitbang.master = spi_master_get(master);
 	mpc83xx_spi->bitbang.chipselect = mpc83xx_spi_chipselect;
 	mpc83xx_spi->bitbang.setup_transfer = mpc83xx_spi_setup_transfer;
@@ -378,9 +394,17 @@ static int __init mpc83xx_spi_probe(stru
 	mpc83xx_spi->sysclk = pdata->sysclk;
 	mpc83xx_spi->activate_cs = pdata->activate_cs;
 	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
+	mpc83xx_spi->qe_mode = pdata->qe_mode;
 	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
 
+	mpc83xx_spi->rx_shift = 0;
+	mpc83xx_spi->tx_shift = 0;
+	if (mpc83xx_spi->qe_mode) {
+		mpc83xx_spi->rx_shift = 16;
+		mpc83xx_spi->tx_shift = 24;
+	}
+
 	mpc83xx_spi->bitbang.master->setup = mpc83xx_spi_setup;
 	init_completion(&mpc83xx_spi->done);
 
@@ -415,6 +439,9 @@ static int __init mpc83xx_spi_probe(stru
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	if (pdata->qe_mode)
+		regval |= SPMODE_OP;
+
 	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 
 	ret = spi_bitbang_start(&mpc83xx_spi->bitbang);
