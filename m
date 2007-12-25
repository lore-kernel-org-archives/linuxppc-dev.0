Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Dec 2007 12:04:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
Message-ID: <20071225010412.GL21311@localhost.localdomain>
References: <476D61DB.2090201@scram.de>
	<20071223230342.GA20636@localhost.localdomain>
	<476F918F.4050909@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476F918F.4050909@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 24, 2007 at 12:01:35PM +0100, Jochen Friedrich wrote:
> Hi David,
> 
> >> +	localbus@8000000 {
> >> +		compatible = "betaresearch,dbox2-localbus";
> > 
> > Is this bus interface really board specific?  I would have thought the
> > localbus bridge would have been part of the SoC in which case the
> > compatible string should mention the 823 rather than the dbox.
> > 
> >> +		#address-cells = <1>;
> > 
> > It's also usual for these localbus things, to have #address-cells of
> > 2, with the chipselect explicitly present as the first cell.
> 
> The setup of the localbus is already done in the boot loader. However, i'll
> recode this to reflect the mapping of addresses to chipselects.

Sure, that's normal.  But to the greatest extent possible, the device
tree should describe the hardware, not the configuration that's been
set up by the firmware/bootloader.  It's usually not possible to get
all the way there, but encoding the chipselect information this way
gets you closer.  It means that if you later need to adapt the device
tree to the same board with a firmware that does things differently,
only the "ranges" property should need changing.  Or, if you later
need a kernel port to a version with no-firmware or minimal firmware
that doesn't configure the bus, the necessary information is in the
tree to configure the bridge.

> >> +		#size-cells = <1>;
> >> +		reg = <8000000 18000000>;
> >> +
> >> +		ranges = <0 8000000 18000000>;
> >> +
> >> +		enx@0 {
> >> +			compatible = "c-cube,enx";
> > 
> > What are these mysterious enx, gtx, etc. devices?  Some comments might
> > be nice.
> 
> Those are mostly devices for video processing (MPEG demux, on screen display, MPEG decoder, etc).
> Drivers (for ARCH=ppc) are available on cvs.tuxbox.org with GPL license. A work in progress port
> to ARCH=powerpc is at git://git.bocc.de/dbox2.git.

Ok.  Again, some comments so a casual read of the tree tells you
roughly what they are would be nice.

> >> +			// Port D is LCD exclusive. Don't export as GPIO
> >> +			CPM1_PIO: pio@970 {
> >> +				compatible = "fsl,cpm1-pario";
> >> +				reg = <970 180>;
> >> +				num-ports = <3>;
> >> +				#gpio-cells = <2>;
> >> +			};
> >> +
> >> +			lcd@970 {
> >> +				reg = <970 10>;
> >> +				compatible = "samsung,ks0713";
> > 
> > Is this representing an LCD controller, or the display itself.  Either
> > way I'm surprised there's something here in the SoC that has a
> > compatible string that's not "fsl,something"
> 
> It's a LCD controller wired to PortD. PortD is used for four 1bit lines
> and one 8bit bus.

I'm still kind of confused here.  Does the pio@970 node above
represent the PortD controller?  If the LCD controller is accessed
solely through PortD, then it should be a child of the PortD node.

At present, pio and lcd have overlapping reg resources which is
certainly wrong.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
