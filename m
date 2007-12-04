Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 5ECFBDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 13:08:41 +1100 (EST)
Date: Mon, 3 Dec 2007 19:10:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071204021026.GB18903@mag.az.mvista.com>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071203015018.GC26919@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2007 at 12:50:18PM +1100, David Gibson wrote:
> On Thu, Nov 29, 2007 at 06:28:36PM +0300, Andrei Dolnikov wrote:
> > Device tree source file for the Emerson Katana Qp board
> > 
> > Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvisa.com>
> > 
> > ---
> >  katanaqp.dts |  360 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 360 insertions(+)
> > 
> > diff --git a/arch/powerpc/boot/dts/katanaqp.dts b/arch/powerpc/boot/dts/katanaqp.dts
> > new file mode 100644
> > index 0000000..98257a2
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/katanaqp.dts
> > @@ -0,0 +1,360 @@
> > +/* Device Tree Source for Emerson Katana Qp
> > + *
> > + * Authors: Vladislav Buzov <vbuzov@ru.mvista.com>
> > + *	    Andrei Dolnikov <adolnikov@ru.mvista.com>
> > + * 
> > + * Based on prpmc8200.dts by Mark A. Greer <mgreer@mvista.com>
> > + *
> > + * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> > + * the terms of the GNU General Public License version 2.  This program
> > + * is licensed "as is" without any warranty of any kind, whether express
> > + * or implied.
> > + *
> > + */
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	model = "Katana-Qp"; /* Default */
> > +	compatible = "emerson,Katana-Qp";
> > +	coherency-off;
> 
> What is this property for?

Its needed to tell the bootwrapper that the platform does not have
coherency enabled (since our policy is that you can't use a CONFIG_ option).
The bootwrapper needs to know that if/when it sets up the windows for
its I/O devices (e.g., enet, mpsc) to system memory.  I needed to do
this on the prpmc2800 because the firmware didn't set up those windows
correctly.  I don't know if the Katana Qp's firmware sets the up
correctly or not.

> > +	mv64x60@f8100000 { /* Marvell Discovery */
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		model = "mv64460";			/* Default */
> > +		compatible = "marvell,mv64x60";
> 
> Compatible properties should not have "x" asn in 64x60 here.  If
> there's a suitable name for the general register interface use that,
> otherwise use the specific model number of the earliest device to
> implement this register interface.  Later models should have a
> compatible property which lists their specific model, followed by the
> earlier model number with which they're compatible.

This came from the prpmc2800's dts which has become out-of-date.
Both dts files need to be updated.

> > +		ethernet@2000 {
> > +			reg = <2000 2000>;
> 
> Are the registers for the 3 ethernets really all together?  This bank
> can't be subdivided into seperate register blocks for each MAC?

Unfortunately there are some registers that are shared so you can't
divide them up nicely.

> > +			eth0 {
> > +				device_type = "network";
> > +				compatible = "marvell,mv64x60-eth";
> > +				block-index = <0>;
> 
> This block-index thing is crap.  If you really need to subindex nodes
> like this, use "reg", with an appropriate #address-cells in the
> parent, then the nodes will also get sensible unit addresses.

So how would that work for the "PHY Address Register 0x2000", say,
where bits 0-4 set the device addr for PHY 0; bits 5-9 set the device
addr for PHY 1; bts 10-14 set the devce addr for PHY 2?

> > +				interrupts = <20>;
> > +				interrupt-parent = <&/mv64x60/pic>;
> 
> You should use a label for the PIC to make things more readable.

More that needs to be updated in prpmc2800.  :(

> > +		sdma@4000 {
> > +			compatible = "marvell,mv64x60-sdma";
> > +			reg = <4000 c18>;
> > +			virtual-reg = <f8104000>;
> 
> Why does this node have virtual-reg?

"virtual-reg" is a special property that doesn't get translated thru
the parent mappings.  It should never be used in the kernel.  Its
purpose is to give code in the bootwrapper the exact address that it
should use to access a register or block of registers or ...
Its needed here because the MPSC (serial) driver uses the SDMA unit
to perform console I/O in the bootwrapper (e.g., cmdline editing, printf's).

Yes, this needs to be documented.

> > +		mpsc@8000 {
> > +			device_type = "serial";
> > +			compatible = "marvell,mpsc";
> > +			reg = <8000 38>;
> > +			virtual-reg = <f8108000>;
> > +			sdma = <&/mv64x60/sdma@4000>;
> > +			brg = <&/mv64x60/brg@b200>;
> > +			cunit = <&/mv64x60/cunit@f200>;
> > +			mpscrouting = <&/mv64x60/mpscrouting@b400>;
> > +			mpscintr = <&/mv64x60/mpscintr@b800>;
> > +			block-index = <0>;
> 
> What is this block-index thing about here?  Since the devices are
> disambiguated by their register address, why do you need it?

This particular one is needed to access the correct MPSC interrupt reg.
Maybe it would be better to make a new property for this but it was only
one reg and block-index was already there and basically served that
purpose so I used it.  I'd be happy to use an alternative if you have
something you think is better.

> > +		pic {
> 
> Needs a unit address.

Okay.

> > +		cpu-error@0070 {
> 
> The unit address should notr include leading zeroes.

Okay.

Mark
