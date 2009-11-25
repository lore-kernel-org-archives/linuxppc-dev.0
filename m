Return-Path: <to-fleischer@t-online.de>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by ozlabs.org (Postfix) with ESMTP id 8E7D7B6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 08:21:06 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Wed, 25 Nov 2009 21:41:59 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
In-Reply-To: <fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911252141.59549.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wen, Nov 25, 2009 at 01:33:57 Grant Likely wrote:
> Thanks.  However, there needs to be a proper description of what this
> patch does to go in the commit header.  Can you please write one?
> 
> Thanks,
> g.
> 
[...]

The initialization of the chip selects is removed from the probe() function of 
the spi_mpc8xxx driver, because the driver doesn't know the polarity of the 
chip selects of the SPI devices at the time of its initialization.

For this reason the initialization of the several chip selects is postponed 
to the point of time when the very first SPI transfer to the associated device
occurs.


Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
---

diff -u -r -N linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c
--- linux-2.6.31.6_orig//drivers/spi/spi_mpc8xxx.c	2009-11-10 01:32:31.000000000 +0100
+++ linux-2.6.31.6/drivers/spi/spi_mpc8xxx.c	2009-11-19 08:15:33.000000000 +0100
@@ -114,6 +114,7 @@
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
 	u32 hw_mode;		/* Holds HW mode register settings */
+	int initialized;
 };
 
 static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
@@ -503,15 +504,52 @@
 
 	return ret;
 }
+
+
+struct mpc8xxx_spi_probe_info {
+	struct fsl_spi_platform_data pdata;
+	int *gpios;
+	bool *alow_flags;
+};
+
+static struct mpc8xxx_spi_probe_info *
+to_of_pinfo(struct fsl_spi_platform_data *pdata)
+{
+	return container_of(pdata, struct mpc8xxx_spi_probe_info, pdata);
+}
+
+static int mpc8xxx_spi_cs_init(struct spi_device *spi)
+{
+	struct device *dev = spi->dev.parent;
+	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
+	u16 cs = spi->chip_select;
+	int gpio = pinfo->gpios[cs];
+	bool on = pinfo->alow_flags[cs] ^ !(spi->mode & SPI_CS_HIGH);
+
+	return gpio_direction_output(gpio, on);
+}
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
+		int ret;
+
+		ret = mpc8xxx_spi_cs_init(spi);
+		if (ret) {
+			dev_dbg(&spi->dev, "cs_init failed: %d\n", ret);
+			return ret;
+		}
+		cs->initialized = 1;
+	}
+
 	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
 	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
 	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
@@ -648,18 +686,6 @@
 	return 0;
 }
 
-struct mpc8xxx_spi_probe_info {
-	struct fsl_spi_platform_data pdata;
-	int *gpios;
-	bool *alow_flags;
-};
-
-static struct mpc8xxx_spi_probe_info *
-to_of_pinfo(struct fsl_spi_platform_data *pdata)
-{
-	return container_of(pdata, struct mpc8xxx_spi_probe_info, pdata);
-}
-
 static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
 {
 	struct device *dev = spi->dev.parent;
@@ -720,14 +746,6 @@
 
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
