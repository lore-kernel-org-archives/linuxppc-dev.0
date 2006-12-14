Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3850467C09
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 16:54:43 +1100 (EST)
Date: Wed, 13 Dec 2006 23:54:36 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: RE: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
In-Reply-To: <037901c71f14$a47115b0$020120ac@Jocke>
Message-ID: <Pine.LNX.4.64.0612132349560.3439@gate.crashing.org>
References: <037901c71f14$a47115b0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: 'David Brownell' <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What about something like the following were we pass in if we are in a 
quicc engine to the driver via the platform device.

Joakim, I haven't tested this so would like to know if this works for you 
on your 832x.  I was also wondering if there was a reason you wanted to 
use the QE SPI in CPU mode and not QE mode, lack of driver, something 
else?

Also, if this patch looks good to David, I'll clean it up and send it 
upstream.  I want to rename the driver and cleanup the Kconfig to make it 
a bit more generic to cover more than just mpc83xx. (The same driver 
should work on the MPC8568 so I was going to rename the driver 
spi_mpc8xxx.c).

- k


diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index ff0b048..9666440 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -47,6 +47,7 @@ struct mpc83xx_spi_reg {
  #define	SPMODE_ENABLE		(1 << 24)
  #define	SPMODE_LEN(x)		((x) << 20)
  #define	SPMODE_PM(x)		((x) << 16)
+#define	SPMODE_OP		(1 << 14)

  /*
   * Default for SPI Mode:
@@ -85,6 +86,10 @@ struct mpc83xx_spi {
  	unsigned nsecs;		/* (clock cycle time)/2 */

  	u32 sysclk;
+	u32 shift;		/* amount to adjust data regs if in qe mode */
+
+	bool qe_mode;
+
  	void (*activate_cs) (u8 cs, u8 polarity);
  	void (*deactivate_cs) (u8 cs, u8 polarity);
  };
@@ -103,7 +108,7 @@ static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)
  void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
  {									  \
  	type * rx = mpc83xx_spi->rx;					  \
-	*rx++ = (type)data;						  \
+	*rx++ = (type)(data >> mpc83xx_spi->shift);			  \
  	mpc83xx_spi->rx = rx;						  \
  }

@@ -112,7 +117,7 @@ u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
  {								\
  	u32 data;						\
  	const type * tx = mpc83xx_spi->tx;			\
-	data = *tx++;						\
+	data = *tx++ << mpc83xx_spi->shift;			\
  	mpc83xx_spi->tx = tx;					\
  	return data;						\
  }
@@ -198,12 +203,18 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
  	if (bits_per_word <= 8) {
  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
+		if (mpc83xx_spi->qe_mode)
+			mpc83xx_spi->shift = 24;
  	} else if (bits_per_word <= 16) {
  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u16;
  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u16;
+		if (mpc83xx_spi->qe_mode)
+			mpc83xx_spi->shift = 16;
  	} else if (bits_per_word <= 32) {
  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u32;
  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u32;
+		if (mpc83xx_spi->qe_mode)
+			mpc83xx_spi->shift = 0;
  	} else
  		return -EINVAL;

@@ -378,9 +389,15 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
  	mpc83xx_spi->sysclk = pdata->sysclk;
  	mpc83xx_spi->activate_cs = pdata->activate_cs;
  	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
+	mpc83xx_spi->qe_mode = pdata->qe_mode;
  	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
  	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;

+	if (mpc83xx_spi->qe_mode)
+		mpc83xx_spi->shift = 24;
+	else
+		mpc83xx_spi->shift = 0;
+
  	mpc83xx_spi->bitbang.master->setup = mpc83xx_spi_setup;
  	init_completion(&mpc83xx_spi->done);

@@ -415,6 +432,8 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)

  	/* Enable SPI interface */
  	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	if (pdata->qe_mode)
+		regval |= SPMODE_OP;
  	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);

  	ret = spi_bitbang_start(&mpc83xx_spi->bitbang);
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index abb64c4..a5bf40f 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -111,6 +111,7 @@ struct fsl_usb2_platform_data {

  struct fsl_spi_platform_data {
  	u32 	initial_spmode;	/* initial SPMODE value */
+	bool	qe_mode;
  	u16	bus_num;

  	/* board specific information */
