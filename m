Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 01AE1B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Nov 2009 05:00:09 +1100 (EST)
Date: Mon, 16 Nov 2009 21:00:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Torsten Fleischer <to-fleischer@t-online.de>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091116180008.GA6748@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091116171037.GA26163@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091116171037.GA26163@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 08:10:37PM +0300, Anton Vorontsov wrote:
[...]
> > I also tried to set alow_flags[x] = 0 for active low. In this case the 
> > transfer works, but the initial value for the CS is wrong (Low instead of 
> > High).
> 
> So it might be better to fix up initial value in the platform code?

Oh, we actually cannot, because the driver calls
gpio_direction_output().

And since we don't know the mode prior to SPI device's driver
probe() finished, we'll have to set up an initial state in the
first SPI transfer. I.e. something like this:

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 0fd0ec4..3b95382 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -114,6 +114,7 @@ struct spi_mpc8xxx_cs {
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
 	u32 hw_mode;		/* Holds HW mode register settings */
+	int initialized;
 };
 
 static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
@@ -507,11 +508,17 @@ static int mpc8xxx_spi_transfer(struct spi_device *spi,
 				struct spi_message *m)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 	unsigned long flags;
 
 	m->actual_length = 0;
 	m->status = -EINPROGRESS;
 
+	if (cs && !cs->initialized) {
+		mpc8xxx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+		cs->initialized = 1;
+	}
+
 	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
 	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
 	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
