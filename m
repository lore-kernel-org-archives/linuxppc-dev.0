Return-Path: <mgreer@mvista.com>
Date: Tue, 15 Jan 2008 12:08:06 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 3/4] powerpc: Katana750i - Add DTS file
Message-ID: <20080115190806.GD26853@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114225926.GB22862@mag.az.mvista.com>
	<20080114233406.GB20649@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114233406.GB20649@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 10:34:06AM +1100, David Gibson wrote:
> On Mon, Jan 14, 2008 at 03:59:26PM -0700, Mark A. Greer wrote:
> > From: Mark A. Greer <mgreer@mvista.com>

Hi David.  Thanks for the review.

> > Add DTS file for the Emerson Katana 750i & 752i platforms.
> 
> [snip]
> > +/dts-v1/;
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	model = "Katana-75xi";	/* Default */
> > +	compatible = "emerson,katana-750i";
> > +	coherency-off;
> 
> Where is this flag used from?

Its used in the bootwrapper if & when you use the mv64x60 code to setup
some of the windows to the I/O ctlrs.  This port does use that code
(because firmware doesn't do it properly) so I need the flag.

<snip>

> > +	mv64x60@f8100000 { /* Marvell Discovery */
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		model = "mv64360";	/* Default */
> > +		compatible = "marvell,mv64360";
> > +		clock-frequency = <133333333>;
> > +		hs_reg_valid;
> > +		reg = <0xf8100000 0x00010000>;
> > +		virtual-reg = <0xf8100000>;
> 
> You seem to have virtual-reg properties on a *lot* of nodes, are they
> really necessary?

Actually, not all of them for this board.  I copied them from prpmc2800
which does need all the ones that are there.  I'l remove the ones that
aren't used.

> virtual-reg should be used *only* for things which
> you need to access very early in the bootwrapper.  Usually that's only
> the serial port for the console.  Come to that, the CPU is a 750 which
> has a real mode, so it seems dubious that you would need any
> virtual-reg values at all.

Well, this came from a discussion about a year ago when we agreed that
this is how it should be done.  Just because MSR[IR,DR] can be cleared
doesn't mean that they are cleared when the firmware jumps to the
bootwraper (for all possible firmwares that are out there).

To be able to eliminate virtual-reg, we'd have to add "mmu_off" code to
the bootwrapper which isn't hard but its already in the kernel (for
32-bit anyway).  So why duplicate?

I'm not that attached to virtual-reg.  In fact, I'd be happy to get rid
of it but only if we can be sure it doesn't cause more mess down the
road.

> [snip]
> > +		flash@e8000000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "cfi-flash";
> > +			bank-width = <4>;
> > +			device-width = <2>;
> > +			reg = <0xe8000000 0x04000000>;
> > +			monitor@0 {
> > +				label = "Monitor";
> 
> If you're using the "label" property, it would be normal to name the
> nodes simply "partition@address".

I'm using the partition names that were used in the equivalent code
under arch/ppc.  I'm trying to keep things looking the same as they used
to as much as possible.  Besides, I don't see any others doing it that
way.

<snip>

> > +		mdio {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			device_type = "mdio";
> 
> This device_type value should not be here.

Yep.  Will fix.

<snip>

> > +		multiethernet@2000 {
> 
> This needs some sort of "compatible" value.

Okay.

> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x2000 0x2000>;
> > +			ethernet@0 {
> 
> [snip]
> > +		CUNIT: cunit@f200 {
> 
> What is this device?  It needs some sort of "compatible" value.

Does it?  Its a separate block of regs but its only used in the mpsc
node--its never looked up on its own by kernel code.  Do all nodes need
"compatible" even when it'll never be used?  (Just want to know.)

> > +			reg = <0xf200 0x200>;
> > +		};
> > +
> > +		MPSCROUTING: mpscrouting@b400 {
> 
> Ditto.

Ditto.

> > +			reg = <0xb400 0xc>;
> > +		};
> > +
> > +		MPSCINTR: mpscintr@b800 {
> 
> Ditto.

Ditto.

> > +			reg = <0xb800 0x100>;
> > +			virtual-reg = <0xf810b800>;
> > +		};
> 
> [snip]
> > +		i2c@c000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			device_type = "i2c";
> 
> This device_type value shouldn't be here either.

Oops, good catch.

<snip>

> > +		mpp@f000 {
> > +			compatible = "marvell,mv64360-mpp";
> > +			reg = <0xf000 0x10>;
> > +		};
> > +
> > +		gpp@f100 {
> > +			compatible = "marvell,mv64360-gpp";
> > +			reg = <0xf100 0x20>;
> > +		};
> 
> What are these two devices?

mpp == multi-purpose pins
gpp == general purpose pins

They're really 2 separate reg blocks and are used for any number of
things including incoming PCI interrupts.  I'm not accessing them
currently so I can eliminate them in this dts.

> > +		pci@80000000 {
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			#interrupt-cells = <1>;
> > +			device_type = "pci";
> > +			compatible = "marvell,mv64360-pci";
> > +			cell-index = <1>;
> > +			reg = <0x0c78 0x8>;
> > +			ranges = <0x01000000 0x0 0x0
> > +					0xb0000000 0x0 0x04000000
> > +				  0x02000000 0x0 0x80000000
> > +					0x80000000 0x0 0x30000000>;
> > +			bus-range = <0x0 0xff>;

<snip>

> > +		};
> > +
> > +		pci@f8080000 { /* Required to acces Hotswap register */
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			#interrupt-cells = <1>;
> > +			device_type = "pci";
> > +			compatible = "marvell,mv64360-pci";
> > +			cell-index = <0>;
> > +			reg = <0x0cf8 0x8>;
> > +			ranges = <0x01000000 0x0 0x0
> > +					0xf8080000 0x0 0x00010000
> > +				  0x02000000 0x0 0xf8090000
> > +					0xf8090000 0x0 0x00010000>;
> > +			bus-range = <0x0 0xff>;
> 
> Two PCI bridges with identical bus-range values seems potentially
> problematic...

Will fix.

> > +		};
> 
> [snip]
> > +	chosen {
> > +		bootargs = "ip=on";
> 
> The dts file should not include a "bootargs" value.  The wrapper will
> fill that in from the kernel config.

Actually, the kernel .config CONFIG_CMDLINE is only used by the kernel
when nothing is passed in from the bootwrapper.  The bootwrapper gets
the cmdline from either bootargs or from the __builtin_cmdline section.

I prefer to not rely on CONFIG_CMDLINE because it doesn't afford the
user a chance to edit or add to the cmdline when booting.  You can always
type in the whole thing at the "Linux/PowerPC load: " prompt but I'd rather
see what is going to be used and then edit it if I want to.  With
CONFIG_CMDLINE, it just gets used if nothing was passed in from the
bootwrapper.

That raises an issue that I've for time time (I've tried to get rid of
__builtin_cmdline before but was unsuccessful).

We currently have 3 possible sources for a default cmdline--seems like
at least one too many.

IMHO we need a way to change the default cmdline in the field so
sysadmins can change it per board and not have to type it in every time
they boot.  /chosen/bootargs and __builtin_cmdline can both do that.
We don't need both, though.  And, since bootargs is specified by OF
and documented in booting-without-of.txt, can we finally get rid of
__builtin_cmdline?  I'd sure like to.

We can probably get rid of CONFIG_CMDLINE too since everyone uses DTs
now and they can have a /chosen/bootargs.  Anyone have a reason to keep
CONFIG_CMDLINE around?

Would you mind elaborating on why you are opposed to /chosen/bootargs?

Mark
