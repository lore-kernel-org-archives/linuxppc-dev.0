Return-Path: <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5 v2] powerpc: DTS file for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080519005342.GB24125@yookeroo.seuss>
References: <1210966129.14883.1.camel@pcds-ts102.slac.stanford.edu>
	<20080519005342.GB24125@yookeroo.seuss>
Content-Type: text/plain
Date: Mon, 19 May 2008 10:53:02 -0700
Message-Id: <1211219583.19212.20.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Mon, 2008-05-19 at 10:53 +1000, David Gibson wrote: 
> On Fri, May 16, 2008 at 12:28:48PM -0700, Remi Machet wrote:
> > Support for the C2K cPCI Single Board Computer from GEFanuc
> > (PowerPC MPC7448 with a Marvell MV64460 chipset)
> > All features of the board are not supported yet, but the board
> > boots, flash works, all Ethernet ports are working and PCI 
> > devices are all found (USB and SATA on PCI1 do not work yet).
> > 
> > Part 1 of 5: DTS file describing the board peripherals. As far as I know
> > all peripherals except the FPGA are listed in there (I did not included
> > the FPGA because a lot of work is needed there).
> 
> Looking pretty good, but a hanful more comments below.
> 
> [snip]
> > +		mdio {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "marvell,mv64360-mdio";
> 
> Surely this needs a "reg" property, otherwise how to you access the
> mdio bus?
I am afraid this is another situation where the driver is not fully
using the OF description ... the PHY registers address is hard-coded in
drivers/net/mv643xx_eth.c. In any case I will add the reg property, and
later on can try to modify the driver to make use of it.

> [snip]
> > +		/* Devices attached to the device controller */
> > +		devicebus {
> > +			compatible = "marvell,mv64306-devctrl";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> 
> This looks like it needs either a "reg" or a "ranges" property.  If
> the address space of this "devicebus" is the same as the parent bus
> you need an empty "ranges" property.  *No* ranges property means the
> subordinate devices can't be directly accessed at all from the parent
> bus.
This is a static bus with chip selects, I will look at other dts files
to properly implement it (with the chipselect and range properties).

> 
> > +			nor_flash {
> 
> This needs a unit address, "nor_flash@f8000000".
> 
[ snip ]

> > +	chosen {
> > +		bootargs = "ip=off root=/dev/mtdblock3 rootfstype=jffs2";
> 
> You don't usually want to encode a default bootargs into the dts file;
> kernel command line arguments should usually be left to the user.
Ok I will remove that.

Thanks for all the comments, I will re-submit a patch as soon as I have
fixed all that.

Remi
