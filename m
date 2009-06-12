Return-Path: <rini@arvoo.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA4BBB71D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 18:59:41 +1000 (EST)
Received: from smtp0.euronet.nl (smtp0.euronet.nl [194.134.35.141])
	by ozlabs.org (Postfix) with ESMTP id EE8ADDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:59:40 +1000 (EST)
Message-ID: <4A3218F4.20503@arvoo.nl>
Date: Fri, 12 Jun 2009 10:59:32 +0200
From: Rini van Zetten <rini@arvoo.nl>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
References: <4A30CA1F.4000702@arvoo.nl>
	<7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
In-Reply-To: <7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
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

--- drivers/spi/spi_mpc8xxx.c.org	2009-06-12 10:45:21.000000000 +0200
+++ drivers/spi/spi_mpc8xxx.c	2009-06-12 10:54:48.000000000 +0200
@@ -666,9 +666,10 @@ static void mpc8xxx_spi_cs_control(struc
  	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
  	u16 cs = spi->chip_select;
  	int gpio = pinfo->gpios[cs];
-	bool alow = pinfo->alow_flags[cs];
-
-	gpio_set_value(gpio, on ^ alow);
+	if (gpio != -EEXIST) {
+		bool alow = pinfo->alow_flags[cs];
+		gpio_set_value(gpio, on ^ alow);
+	}
  }

  static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
@@ -707,27 +708,29 @@ static int of_mpc8xxx_spi_get_chipselect
  		enum of_gpio_flags flags;

  		gpio = of_get_gpio_flags(np, i, &flags);
-		if (!gpio_is_valid(gpio)) {
+		if (gpio_is_valid(gpio)) {
+			ret = gpio_request(gpio, dev_name(dev));
+			if (ret) {
+				dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
+				goto err_loop;
+			}
+
+			pinfo->gpios[i] = gpio;
+			pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
+
+			ret = gpio_direction_output(pinfo->gpios[i],
+					pinfo->alow_flags[i]);
+			if (ret) {
+				dev_err(dev, "can't set output direction for gpio "
+						"#%d: %d\n", i, ret);
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
--
