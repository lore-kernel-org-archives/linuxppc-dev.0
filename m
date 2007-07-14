Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F728DDDE4
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 06:49:03 +1000 (EST)
Subject: Re: How to add platform specific data to a of_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Beisert <jbe@pengutronix.de>
In-Reply-To: <200707141831.04107.jbe@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
Content-Type: text/plain
Date: Sun, 15 Jul 2007 06:48:53 +1000
Message-Id: <1184446133.6059.284.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-14 at 18:31 +0200, Juergen Beisert wrote:
> Hi,
> 
> I'm trying to use the drivers/spi/mpc52xx_psc_spi.c as an open firmware device
> (ARCH=powerpc). This device needs some platform specific data (the devices
> connected to the SPI bus and how to drive the chipselects to these devices).
> 
> The driver itself get a "struct of_device *op" in his probe function and
> does something like this:
> 
> struct fsl_spi_platform_data *pdata = op->dev.platform_data;
> 
> My question is: How is the correct way to bring the platform specific data
> into this device structure? Is there a way to do it in the OFTree (dts file)?

Your approach would work I suppose.... though it's a bit ugly. I've long
considered removing platform_data from struct device, and make it part
strictly of platform device...

I'm not sure what you actually need here... if it's to know what your
child devices are, you can always walk the device-tree, though for most
things, it would be the child devices themslves who would call into your
SPI driver with whatever identification they retreived from there.

Ben.
