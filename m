Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jan 2008 11:22:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/4] powerpc: Katana750i - Add DTS file
Message-ID: <20080116002228.GC4283@localhost.localdomain>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114225926.GB22862@mag.az.mvista.com>
	<20080114233406.GB20649@localhost.localdomain>
	<20080115190806.GD26853@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080115190806.GD26853@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 12:08:06PM -0700, Mark A. Greer wrote:
> On Tue, Jan 15, 2008 at 10:34:06AM +1100, David Gibson wrote:
> > On Mon, Jan 14, 2008 at 03:59:26PM -0700, Mark A. Greer wrote:
> > > From: Mark A. Greer <mgreer@mvista.com>
> 
> Hi David.  Thanks for the review.
> 
> > > Add DTS file for the Emerson Katana 750i & 752i platforms.
> > 
> > [snip]
> > > +/dts-v1/;
> > > +
> > > +/ {
> > > +	#address-cells = <1>;
> > > +	#size-cells = <1>;
> > > +	model = "Katana-75xi";	/* Default */
> > > +	compatible = "emerson,katana-750i";
> > > +	coherency-off;
> > 
> > Where is this flag used from?
> 
> Its used in the bootwrapper if & when you use the mv64x60 code to setup
> some of the windows to the I/O ctlrs.  This port does use that code
> (because firmware doesn't do it properly) so I need the flag.

Hrm.. ok.  I'm just wondering if a new flag is really the right
approach for this, or whether you should be basing the setup off the
compatible property, either for the board or for the main bridge.

> > > +	mv64x60@f8100000 { /* Marvell Discovery */
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		model = "mv64360";	/* Default */
> > > +		compatible = "marvell,mv64360";
> > > +		clock-frequency = <133333333>;
> > > +		hs_reg_valid;
> > > +		reg = <0xf8100000 0x00010000>;
> > > +		virtual-reg = <0xf8100000>;
> > 
> > You seem to have virtual-reg properties on a *lot* of nodes, are they
> > really necessary?
> 
> Actually, not all of them for this board.  I copied them from prpmc2800
> which does need all the ones that are there.  I'l remove the ones that
> aren't used.

Ok, good.

> > virtual-reg should be used *only* for things which
> > you need to access very early in the bootwrapper.  Usually that's only
> > the serial port for the console.  Come to that, the CPU is a 750 which
> > has a real mode, so it seems dubious that you would need any
> > virtual-reg values at all.
> 
> Well, this came from a discussion about a year ago when we agreed that
> this is how it should be done.  Just because MSR[IR,DR] can be cleared
> doesn't mean that they are cleared when the firmware jumps to the
> bootwraper (for all possible firmwares that are out there).
> 
> To be able to eliminate virtual-reg, we'd have to add "mmu_off" code to
> the bootwrapper which isn't hard but its already in the kernel (for
> 32-bit anyway).  So why duplicate?

Ok, that's a good enough reason for me. 

> I'm not that attached to virtual-reg.  In fact, I'd be happy to get rid
> of it but only if we can be sure it doesn't cause more mess down the
> road.
> 
> > [snip]
> > > +		flash@e8000000 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			compatible = "cfi-flash";
> > > +			bank-width = <4>;
> > > +			device-width = <2>;
> > > +			reg = <0xe8000000 0x04000000>;
> > > +			monitor@0 {
> > > +				label = "Monitor";
> > 
> > If you're using the "label" property, it would be normal to name the
> > nodes simply "partition@address".
> 
> I'm using the partition names that were used in the equivalent code
> under arch/ppc.  I'm trying to keep things looking the same as they used
> to as much as possible.  Besides, I don't see any others doing it that
> way.

My point is that the partition code uses either "label" (if present)
or the node name for the partition name.  If label properties are
present, the node name is redundant information, so it seems more
sensible to leave something generic there.

[snip]
> > > +		CUNIT: cunit@f200 {
> > 
> > What is this device?  It needs some sort of "compatible" value.
> 
> Does it?  Its a separate block of regs but its only used in the mpsc
> node--its never looked up on its own by kernel code.  Do all nodes need
> "compatible" even when it'll never be used?  (Just want to know.)

Hrm.. if it's really just extra mpsc registers, should it be a
seperate device, or just another range in the mpsc's "reg" property?

[snip]
> > > +		mpp@f000 {
> > > +			compatible = "marvell,mv64360-mpp";
> > > +			reg = <0xf000 0x10>;
> > > +		};
> > > +
> > > +		gpp@f100 {
> > > +			compatible = "marvell,mv64360-gpp";
> > > +			reg = <0xf100 0x20>;
> > > +		};
> > 
> > What are these two devices?
> 
> mpp == multi-purpose pins
> gpp == general purpose pins
> 
> They're really 2 separate reg blocks and are used for any number of
> things including incoming PCI interrupts.  I'm not accessing them
> currently so I can eliminate them in this dts.

Hrm.  The device tree should generally describe the hardware, even if
Linux doesn't use it yet.  Are these basically some sort of GPIO
interface?  If so you should look at the new GPIO binding which has
been proposed.

[snip] 
> > > +	chosen {
> > > +		bootargs = "ip=on";
> > 
> > The dts file should not include a "bootargs" value.  The wrapper will
> > fill that in from the kernel config.
> 
> Actually, the kernel .config CONFIG_CMDLINE is only used by the kernel
> when nothing is passed in from the bootwrapper.  The bootwrapper gets
> the cmdline from either bootargs or from the __builtin_cmdline section.
> 
> I prefer to not rely on CONFIG_CMDLINE because it doesn't afford the
> user a chance to edit or add to the cmdline when booting.  You can always
> type in the whole thing at the "Linux/PowerPC load: " prompt but I'd rather
> see what is going to be used and then edit it if I want to.  With
> CONFIG_CMDLINE, it just gets used if nothing was passed in from the
> bootwrapper.
> 
> That raises an issue that I've for time time (I've tried to get rid of
> __builtin_cmdline before but was unsuccessful).
> 
> We currently have 3 possible sources for a default cmdline--seems like
> at least one too many.

Yes :(.  I've looked at this before, though obviously I never got to
figuring out what to do about it.

> IMHO we need a way to change the default cmdline in the field so
> sysadmins can change it per board and not have to type it in every time
> they boot.  /chosen/bootargs and __builtin_cmdline can both do that.
> We don't need both, though.  And, since bootargs is specified by OF
> and documented in booting-without-of.txt, can we finally get rid of
> __builtin_cmdline?  I'd sure like to.
> 
> We can probably get rid of CONFIG_CMDLINE too since everyone uses DTs
> now and they can have a /chosen/bootargs.  Anyone have a reason to keep
> CONFIG_CMDLINE around?
> 
> Would you mind elaborating on why you are opposed to /chosen/bootargs?

Just because it's nasty for people to have to go in and change the dts
just to change their default command line - which they might well want
to do for things as simple as setting a default root device.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
