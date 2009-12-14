Return-Path: <to-fleischer@t-online.de>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by ozlabs.org (Postfix) with ESMTP id CC4A2B6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Dec 2009 03:55:21 +1100 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Mon, 14 Dec 2009 17:54:41 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<200912091649.19380.to-fleischer@t-online.de>
	<fa686aa40912090946m12fe293cg2efb043cb7a7f573@mail.gmail.com>
In-Reply-To: <fa686aa40912090946m12fe293cg2efb043cb7a7f573@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912141754.41329.to-fleischer@t-online.de>
Cc: avorontsov@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 18:46:51 Grant Likely wrote:
> <to-fleischer@t-online.de> wrote:
> [...]
> > The following patch adds a function to get the active state of the chip
> > select of a SPI device by looking for the 'spi-cs-high' property in the
> > associated device tree node.
> > This function is used by the spi_mpc8xxx driver to set a proper initial
> > value to the associated GPIOs.
> >
> >
> > Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
> 
> I like this better.  See comments below.
> 
[...]

Hey Grant,

below there is a new version of the patch containing the modifications
according to your comments.

Thanks for the hints,
Torsten


Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
---

diff -ruN linux-2.6.32_orig//drivers/of/of_spi.c linux-2.6.32/drivers/of/of_spi.c
--- linux-2.6.32_orig//drivers/of/of_spi.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/of/of_spi.c	2009-12-11 17:57:22.016787665 +0100
@@ -12,6 +12,43 @@
 #include <linux/of_spi.h>
 
 /**
+ * of_get_spi_cs_active_state - Gets the chip select's active state of a SPI
+ * child devices.
+ * @np:        parent node of the SPI device nodes
+ * @index:     index/address of the SPI device (refers to the 'reg' property)
+ *
+ * Returns 0 for 'active low' or if the child's node can't be found.
+ * Otherwise it returns 1 ('active high').
+ */
+bool of_get_spi_cs_active_state(struct device_node *np, int index)
+{
+	struct device_node *child;
+	const int *prop;
+	int len;
+	bool active = 0;
+
+	/* search for the matching SPI device */
+	for_each_child_of_node(np, child) {
+		prop = of_get_property(child, "reg", &len);
+		if (!prop || len < sizeof(*prop)) {
+			/* property 'reg' not available (not an error) */
+			continue;
+		}
+
+		if ( *prop == index ) {
+			/* matching device found */
+			if (of_find_property(child, "spi-cs-high", NULL))
+				active = 1;
+			break;
+		}
+	}
+
+	return active;
+}
+EXPORT_SYMBOL(of_get_spi_cs_active_state);
+
+
+/**
  * of_register_spi_devices - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
  * @np:		parent node of SPI device nodes
diff -ruN linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.32/drivers/spi/spi_mpc8xxx.c
--- linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/spi/spi_mpc8xxx.c	2009-12-11 17:15:47.957379333 +0100
@@ -705,6 +705,7 @@
 	for (; i < ngpios; i++) {
 		int gpio;
 		enum of_gpio_flags flags;
+		bool astate;
 
 		gpio = of_get_gpio_flags(np, i, &flags);
 		if (!gpio_is_valid(gpio)) {
@@ -721,8 +722,18 @@
 		pinfo->gpios[i] = gpio;
 		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
 
+		/* get the active state of the SPI device */
+		astate = of_get_spi_cs_active_state(np, i);
+
+		/*
+		 *  alow_flags describe the wiring of the chip select
+		 *  (0 = non-inverted, 1 = inverted); this must be taken into
+		 *  account when setting the GPIO's initial value
+		 *  (see also mpc8xxx_spi_cs_control()); note that astate will
+		 *  be 0 for active low and 1 for active high respectively
+		 */
 		ret = gpio_direction_output(pinfo->gpios[i],
-					    pinfo->alow_flags[i]);
+					    pinfo->alow_flags[i] ^ !astate);
 		if (ret) {
 			dev_err(dev, "can't set output direction for gpio "
 				"#%d: %d\n", i, ret);
diff -ruN linux-2.6.32_orig//include/linux/of_spi.h linux-2.6.32/include/linux/of_spi.h
--- linux-2.6.32_orig//include/linux/of_spi.h	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/include/linux/of_spi.h	2009-12-11 17:10:21.681380685 +0100
@@ -15,4 +15,7 @@
 extern void of_register_spi_devices(struct spi_master *master,
 				    struct device_node *np);
 
+extern bool of_get_spi_cs_active_state(struct device_node *np,
+					   int index);
+
 #endif /* __LINUX_OF_SPI */
