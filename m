Return-Path: <to-fleischer@t-online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by ozlabs.org (Postfix) with ESMTP id 24BDDB6EF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 03:08:52 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Sat, 21 Nov 2009 17:08:47 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091118232920.GA24307@oksana.dev.rtsoft.ru>
	<fa686aa40911210045v4be84e8dg8ef490472e06017b@mail.gmail.com>
In-Reply-To: <fa686aa40911210045v4be84e8dg8ef490472e06017b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911211708.47253.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 21, 2009 at 09:45:50 Grant Likely wrote:
[...]
> Hey Torsten,  do you have an updated version of this change to address
> the comments?  I'm collecting the last few things for some linux-next
> exposure now.

Hey Grant,

here is the updated version of the patch containing the recommended
changes.

Best Regards
Torsten


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
