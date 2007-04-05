Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id EA69DDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 18:51:09 +1000 (EST)
Date: Thu, 5 Apr 2007 10:50:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: SPI devices and OF
Message-ID: <20070405085057.GC9910@localhost.localdomain>
References: <20070404110916.GA9910@localhost.localdomain>
	<a84b0389cf9e6730da79750b1afc1973@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a84b0389cf9e6730da79750b1afc1973@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 10:57:28AM -0500, Milton Miller wrote:
> On Wed Apr 4 21:09:16 EST 2007, Sascha Hauer wrote:
> 
> >I'm currently writing a driver for the mpc5200 spi controller (the
> >dedicated one, not the PSC ones).
> >
> >The driver has the form of a of_platform_driver. My problem is that I
> >don't know how to define the spi devices on the spi bus. My current
> >approach is having something like this in the OF tree:
> >
> >
> >        spi at f00 {
> >                device_type = "spi";
> >                compatible = "mpc5200b-spi\0mpc5200-spi";
> >                reg = <f00 20>;
> >                interrupts = <2 d 0 2 e 0>;
> >                interrupt-parent = <500>;
> >                mmc at 0 {
> >                        device_type = "mmc_spi";
> >                        compatible = "mmc_spi";
> 
> Why is the device_type mmc_spi?   Is this a MMC adapter?
> The type of a network card is "network", not "pci_network".

MMC cards have a SPI mode, so mmc_spi ist meant as "MMC over SPI". This
is the name the linux mmc over spi driver matches on.

> 
> 
> >                };
> >        };
> >
> >I can then parse the children in my spi driver with
> >
> >        while( (child = of_get_next_child(odev->node, child))) {
> >                struct spi_board_info info;
>                 (fill out info) ...
> >                spi_register_board_info(&info, 1);
> >        }
> >
> >I think it will work this way but I found no way getting the
> >platform_data for the spi devices.
> 
> Why do you need platform_data for the devices?  I understand for
> the master.   Actually, spi_device_info has a nice platform_info 
> pointer.

For example the AT25 eeprom driver needs the page_size and some other bits in
the platform_data.

> 
> However, looking at drivers/spi/spi.c, it looks
> spi_register_board_info is for staticly determined tables that are
> known at _init and the spi master busses are enumerated in some
> platform-dtermined way.  Since your proposed binding doesn't have
> an enumeration of the spi master, that does not match.  I guess you
> could register them with sequential numbers as you encounter the
> masters in the device tree.  However, if this is code is in your
> driver, it seems to be the wrong point in time, you need something
> _init_or_module.
> 
> Looking through the code, It seems you want to use spi_new_device()
> after calling spi_alloc_master() and spi_register_master().

Yes, you're right. I mixed that up. Anyway, it was only meant as pseudo
code to show what I'm trying to do.

Sascha
