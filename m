Return-Path: <to-fleischer@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by ozlabs.org (Postfix) with ESMTP id 8F3C0B7B9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 03:36:45 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: avorontsov@ru.mvista.com
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Wed, 18 Nov 2009 17:20:06 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091117202211.GB27574@oksana.dev.rtsoft.ru>
	<20091117232823.GA19058@oksana.dev.rtsoft.ru>
In-Reply-To: <20091117232823.GA19058@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911181720.06390.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wen, Nov 18, 2009 00:28:23 Anton Vorontsov wrote:
[...]
> > > > > So it might be better to fix up initial value in the platform code?
> > > >
> > > > Oh, we actually cannot, because the driver calls
> > > > gpio_direction_output().
> > > >
> > > > And since we don't know the mode prior to SPI device's driver
> > > > probe() finished, we'll have to set up an initial state in the
> > > > first SPI transfer. I.e. something like this:
> > >
> > > In most cases the device drivers perform SPI transfers already in their
> > > probe() function. How can it be ensured that the CS of all other
> > > devices are inactive even if they are not initialized at that time?
> >
> > Good question. Oh, well... then we have to use spi-cs-high,
> > no matter that it is a duplication of the 'compatible' property.
> > SPI bus drivers don't know all the devices and their CS level,
> > and so spi-cs-high is the only way to tell that information. :-(
> 
> Oh. On the other hand, we can postpone the gpio_direction_output()
> call, and still require that the platform code (or firmware)
> should be responsible for setting a sane default values on the
> chip selects.
> 

How about that?


diff -u -r -N linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c
--- linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c	2009-11-10 01:32:31.000000000 +0100
+++ linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c	2009-11-18 10:47:06.000000000 +0100
@@ -114,6 +114,7 @@
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
 	u32 hw_mode;		/* Holds HW mode register settings */
+	int initialized;
 };
 
 static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
@@ -437,6 +438,7 @@
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
+		cs->initialized = 0;
 		spi->controller_state = cs;
 	}
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -503,15 +505,25 @@
 
 	return ret;
 }
+
+static void mpc8xxx_spi_cs_init(struct spi_device *spi);
+
+
 static int mpc8xxx_spi_transfer(struct spi_device *spi,
 				struct spi_message *m)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 	unsigned long flags;
 
 	m->actual_length = 0;
 	m->status = -EINPROGRESS;
 
+	if (cs && !cs->initialized) {
+		mpc8xxx_spi_cs_init(spi);
+		cs->initialized = 1;
+	}
+
 	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
 	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
 	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
@@ -671,6 +683,17 @@
 	gpio_set_value(gpio, on ^ alow);
 }
 
+static void mpc8xxx_spi_cs_init(struct spi_device *spi)
+{
+	struct device *dev = spi->dev.parent;
+	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
+	u16 cs = spi->chip_select;
+	int gpio = pinfo->gpios[cs];
+	bool on = (pinfo->alow_flags[cs] ^ !(spi->mode & SPI_CS_HIGH));
+
+	gpio_direction_output(gpio, on);
+}
+
 static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
 {
 	struct device_node *np = dev_archdata_get_node(&dev->archdata);
@@ -720,14 +743,6 @@
 
 		pinfo->gpios[i] = gpio;
 		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
-
-		ret = gpio_direction_output(pinfo->gpios[i],
-					    pinfo->alow_flags[i]);
-		if (ret) {
-			dev_err(dev, "can't set output direction for gpio "
-				"#%d: %d\n", i, ret);
-			goto err_loop;
-		}
 	}
 
 	pdata->max_chipselect = ngpios;
