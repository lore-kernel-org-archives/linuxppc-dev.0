Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id CB218DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 18:33:32 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: How to add platform specific data to a of_device
Date: Sun, 15 Jul 2007 10:33:29 +0200
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
In-Reply-To: <1184446133.6059.284.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707151033.29894.jbe@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Saturday 14 July 2007 22:48, Benjamin Herrenschmidt wrote:
> On Sat, 2007-07-14 at 18:31 +0200, Juergen Beisert wrote:
> > Hi,
> >
> > I'm trying to use the drivers/spi/mpc52xx_psc_spi.c as an open firmware
> > device (ARCH=powerpc). This device needs some platform specific data (the
> > devices connected to the SPI bus and how to drive the chipselects to
> > these devices).
> >
> > The driver itself get a "struct of_device *op" in his probe function and
> > does something like this:
> >
> > struct fsl_spi_platform_data *pdata = op->dev.platform_data;
> >
> > My question is: How is the correct way to bring the platform specific
> > data into this device structure? Is there a way to do it in the OFTree
> > (dts file)?
>
> Your approach would work I suppose.... though it's a bit ugly.

Yes, I know it works (I'm currently using it), but also yes, its very ugly. So 
I want to change it.

> I'm not sure what you actually need here...

What the SPI master driver needs its something like the SPI bus number it 
controls, how many chipselect lines are available (=how many SPI slave 
devices are connected) and what platform specific functions it must call to 
set or reset the chipselect lines to make a data transfer on its bus.
It does not need the types of connected slave devices, as this will be 
controlled by the SPI framework.

struct fsl_spi_platform_data spi_master_platform_info =
{
	.initial_spmode = <something SPI related>,
	.sysclk = <mpc5200 internal systemclock - platform specific >,
	.bus_num = <SPI bus number for this master controller>,
	.max_chipselect = <platforms chipselect count>,
	.activate_cs = <platform function to activate one of the chipselects>,
	.deactivate_cs = <platform function to activate one of the chipselects>
};

Would it be possible to query these informations from the oftree? Can someone 
give an example how the oftree dts syntax would look like for this case?

> if it's to know what your 
> child devices are, you can always walk the device-tree, though for most
> things, it would be the child devices themslves who would call into your
> SPI driver with whatever identification they retreived from there.

Hmm, as I stated above: Handling the SPI slave devices is done in the SPI 
framework. But including this data into the dts sounds better than including 
it into the BSP. Is there some documentation around how to describe such a 
SPI bus with its devices in the dts?

Thanks so far
Juergen
