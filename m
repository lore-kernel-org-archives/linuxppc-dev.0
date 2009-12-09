Return-Path: <to-fleischer@t-online.de>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by ozlabs.org (Postfix) with ESMTP id CE251B6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 02:52:33 +1100 (EST)
Resent-Message-ID: <200912091652.14668.to-fleischer@t-online.de>
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Wed, 9 Dec 2009 16:49:19 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091126190101.GA19404@oksana.dev.rtsoft.ru>
	<fa686aa40911261117y4744e56bmf4d1d8260c7a51d0@mail.gmail.com>
In-Reply-To: <fa686aa40911261117y4744e56bmf4d1d8260c7a51d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912091649.19380.to-fleischer@t-online.de>
Cc: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 20:17:35,  Grant Likely wrote:
[...]
> spi-cs-high is definitely not a complete solution, but it isn't
> actively evil either.  Plus it is documented and (presumably) in
> active use. so support for it should not be dropped.
> 
> Regardless, there needs to be a library function for parsing all the
> SPI child nodes and returning the active state for each GPIO chip
> select.  All the code for parsing the old spi-cs-high properties can
> be contained in the same place as a new yet-to-be-defined bus node cs
> polarity property.  The rework to the driver itself is not ugly.
> 

The following patch adds a function to get the active state of the chip select
of a SPI device by looking for the 'spi-cs-high' property in the associated device
tree node.
This function is used by the spi_mpc8xxx driver to set a proper initial value
to the associated GPIOs.


Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
---

diff -ruN linux-2.6.32_orig//drivers/of/of_spi.c linux-2.6.32/drivers/of/of_spi.c
--- linux-2.6.32_orig//drivers/of/of_spi.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/of/of_spi.c	2009-12-09 12:37:01.000000000 +0100
@@ -10,6 +10,49 @@
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
+#include <linux/errno.h>
+
+/**
+ * of_get_spi_cs_active_state - Gets the chip select's active state of a SPI
+ * child devices.
+ * @np:        parent node of the SPI device nodes
+ * @index:     index/address of the SPI device (refers to the 'reg' property)
+ * @cs_active: pointer to return the chip select's active state
+ *             (true = active high; false = active low)
+ *
+ * Returns 0 on success; negative errno on failure
+ */
+int of_get_spi_cs_active_state(struct device_node *np, int index, bool *cs_active)
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
+
+			if (cs_active)
+				*cs_active = active;
+
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(of_get_spi_cs_active_state);
+
 
 /**
  * of_register_spi_devices - Register child devices onto the SPI bus
diff -ruN linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c linux-2.6.32/drivers/spi/spi_mpc8xxx.c
--- linux-2.6.32_orig//drivers/spi/spi_mpc8xxx.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/spi/spi_mpc8xxx.c	2009-12-09 12:50:36.000000000 +0100
@@ -705,6 +705,7 @@
 	for (; i < ngpios; i++) {
 		int gpio;
 		enum of_gpio_flags flags;
+		bool astate;
 
 		gpio = of_get_gpio_flags(np, i, &flags);
 		if (!gpio_is_valid(gpio)) {
@@ -721,8 +722,15 @@
 		pinfo->gpios[i] = gpio;
 		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
 
+		ret = of_get_spi_cs_active_state(np, i, &astate);
+		if (ret) {
+			dev_err(dev, "can't get cs active state of device "
+				"#%d: %d\n", i, ret);
+			goto err_loop;
+		}
+
 		ret = gpio_direction_output(pinfo->gpios[i],
-					    pinfo->alow_flags[i]);
+					    pinfo->alow_flags[i] ^ !astate);
 		if (ret) {
 			dev_err(dev, "can't set output direction for gpio "
 				"#%d: %d\n", i, ret);
diff -ruN linux-2.6.32_orig//include/linux/of_spi.h linux-2.6.32/include/linux/of_spi.h
--- linux-2.6.32_orig//include/linux/of_spi.h	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/include/linux/of_spi.h	2009-12-09 12:36:48.000000000 +0100
@@ -15,4 +15,7 @@
 extern void of_register_spi_devices(struct spi_master *master,
 				    struct device_node *np);
 
+extern int of_get_spi_cs_active_state(struct device_node *np,
+				      int index, bool *cs_active);
+
 #endif /* __LINUX_OF_SPI */
 
