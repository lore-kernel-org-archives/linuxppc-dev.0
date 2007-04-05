Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7B2EEDDE46
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 05:11:56 +1000 (EST)
Date: Thu, 5 Apr 2007 21:11:45 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: SPI devices and OF
Message-ID: <20070405191145.GA20139@himalia.labnet.pengutronix.de>
References: <20070404110916.GA9910@localhost.localdomain>
	<a84b0389cf9e6730da79750b1afc1973@bga.com>
	<20070405085057.GC9910@localhost.localdomain>
	<030212e9acd638e71b2f50aa39fb90ed@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <030212e9acd638e71b2f50aa39fb90ed@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 05, 2007 at 09:44:13AM -0500, Milton Miller wrote:
> 
> 
> ok, so what is the problem with the platform data?

Not a problem of programming technique but a problem of where to
actually get the information in the platform from. device tree or
board setup code?

> You kzalloc the
> data structure that the device needs, fill it in, and fill out
> the pointer in the auto _info variable that gets copied by
> register_new_device.

My point is that we have two possibilities to handle spi devices. a) We
put the information about all devices connected to a spi bus into the
device tree in which case we must also put the data described in the
platform_data (e.g. the mentioned page_size for at25 eeproms) into the
tree. b) would be to put only the spi masters into the tree (well they
already are).

It seems b) is the prefered way. If I understand Ben correctly I can
then put some proprietary tag into the tree to differentiate between
different spi controllers so that the board code knows which spi
controller is which. So my tree could look like:

spi@f00 {
	device_type = "spi";
	compatible = "mpc5200b-spi\0mpc5200-spi";
	reg = <f00 20>;
	interrupts = <2 d 0 2 e 0>;
	interrupt-parent = <500>;
	identifier = <0>;
}

spi@xxx {
	device_type = "spi";
	...
	identifier = <1>;
}

I can then use the board code to populate the spi devices depending on
the identifier. Perhaps there is a better name instead of 'identifier'?

Sascha
