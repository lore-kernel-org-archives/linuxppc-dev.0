Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7CEE8DDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 02:53:05 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1I9kWR-0000La-00
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 18:31:08 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: How to add platform specific data to a of_device
Date: Sat, 14 Jul 2007 18:31:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707141831.04107.jbe@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to use the drivers/spi/mpc52xx_psc_spi.c as an open firmware device
(ARCH=powerpc). This device needs some platform specific data (the devices
connected to the SPI bus and how to drive the chipselects to these devices).

The driver itself get a "struct of_device *op" in his probe function and
does something like this:

struct fsl_spi_platform_data *pdata = op->dev.platform_data;

My question is: How is the correct way to bring the platform specific data
into this device structure? Is there a way to do it in the OFTree (dts file)?

Or in a way like this?

static struct fsl_spi_platform_data my_spi_master_info = {
[....]
}

static int __init my_platform_register_spi(void)
{
       struct device_node *np = NULL;
       struct of_device *of_dev;

       if ((np = of_find_compatible_node(np, "spi", "mpc5200-psc-spi")) == NULL) {
               printk("couldn't find of tree node\n");
               return -1;
       }
       if ((of_dev = of_find_device_by_node(np)) == NULL) {
               printk("couldn't find device by node\n");
               return -1;
       }

       of_dev->dev.platform_data = &my_spi_master_info;

       return 0;
}

Or is there any other way?

Regards
Juergen
