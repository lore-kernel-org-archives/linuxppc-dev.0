Return-Path: <rini@arvoo.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78F5CB72D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 17:26:22 +1000 (EST)
Received: from smtp1.euronet.nl (smtp1.euronet.nl [194.134.35.133])
	by ozlabs.org (Postfix) with ESMTP id 92BBEDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 17:26:20 +1000 (EST)
Message-ID: <4A3B3D90.5030100@arvoo.nl>
Date: Fri, 19 Jun 2009 09:26:08 +0200
From: Rini van Zetten <rini@arvoo.nl>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH -mm v3][POWERPC] mpc8xxx : allow SPI without cs.
References: <4A39DC80.7030906@arvoo.nl>	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
In-Reply-To: <EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the possibility to have a spi device without a cs.

For example, the dts file should look something like this:

spi-controller {
        gpios = <&pio1 1 0      /* cs0 */
                 0              /* cs1, no GPIO */
                 &pio2 2 0>;    /* cs2 */

Signed-off-by: Rini van Zetten <rini@arvoo.nl>
---
Changes :
	patch against 2.6.30-rc8-mm1
	style updates
	compiler warning fix
comment :
	This feature is needed on our home made board to program an onboard fpga.
	The fpga needs some special pin toggling to put it in programming mode.
	That's why we want to skip the usual gpio cs and do the pin toggling
	in our driver
	

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 0fd0ec4..3a367ce 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -666,9 +666,12 @@ static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
  	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
  	u16 cs = spi->chip_select;
  	int gpio = pinfo->gpios[cs];
-	bool alow = pinfo->alow_flags[cs];

-	gpio_set_value(gpio, on ^ alow);
+	if (gpio != -EEXIST) {
+		bool alow = pinfo->alow_flags[cs];
+
+		gpio_set_value(gpio, on ^ alow);
+	}
  }

  static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
@@ -707,27 +710,31 @@ static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
  		enum of_gpio_flags flags;

  		gpio = of_get_gpio_flags(np, i, &flags);
-		if (!gpio_is_valid(gpio)) {
+		if (gpio_is_valid(gpio)) {
+			ret = gpio_request(gpio, dev_name(dev));
+			if (ret) {
+				dev_err(dev, "can't request gpio #%d: %d\n",
+							 i, ret);
+				goto err_loop;
+			}
+
+			pinfo->gpios[i] = gpio;
+			pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
+
+			ret = gpio_direction_output(pinfo->gpios[i],
+					pinfo->alow_flags[i]);
+			if (ret) {
+				dev_err(dev, "can't set output direction for"
+							"gpio #%d: %d\n",
+							i, ret);
+				goto err_loop;
+			}
+		} else if (gpio == -EEXIST) {
+			pinfo->gpios[i] = -EEXIST;
+		} else {
  			dev_err(dev, "invalid gpio #%d: %d\n", i, gpio);
  			goto err_loop;
  		}
-
-		ret = gpio_request(gpio, dev_name(dev));
-		if (ret) {
-			dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
-			goto err_loop;
-		}
-
-		pinfo->gpios[i] = gpio;
-		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
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
