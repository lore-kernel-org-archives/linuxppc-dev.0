Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 13:50:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071204025032.GH32577@localhost.localdomain>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
	<20071204021026.GB18903@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204021026.GB18903@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2007 at 07:10:26PM -0700, Mark A. Greer wrote:
> On Mon, Dec 03, 2007 at 12:50:18PM +1100, David Gibson wrote:
> > On Thu, Nov 29, 2007 at 06:28:36PM +0300, Andrei Dolnikov wrote:
[snip]
> > > +		ethernet@2000 {
> > > +			reg = <2000 2000>;
> > 
> > Are the registers for the 3 ethernets really all together?  This bank
> > can't be subdivided into seperate register blocks for each MAC?
> 
> Unfortunately there are some registers that are shared so you can't
> divide them up nicely.

Ok, fair enough then.  But, see below..

> > > +			eth0 {
> > > +				device_type = "network";
> > > +				compatible = "marvell,mv64x60-eth";
> > > +				block-index = <0>;
> > 
> > This block-index thing is crap.  If you really need to subindex nodes
> > like this, use "reg", with an appropriate #address-cells in the
> > parent, then the nodes will also get sensible unit addresses.
> 
> So how would that work for the "PHY Address Register 0x2000", say,
> where bits 0-4 set the device addr for PHY 0; bits 5-9 set the device
> addr for PHY 1; bts 10-14 set the devce addr for PHY 2?

So use 'reg' to do the indexing.  As long as you have no 'ranges'
property in the parent 'ethernet' node, which you don't, you can use
'reg' as a private index.  That's basically what non-translatable reg
values are about.

Incidentally you should probably call the subnodes "ethernet@0"
etc. and the parent one "multiethernet" or something.  It's the
subnodes that represent an individual ethernet interface, so they
should take the "ethernet" name and not the parent, by generic names
conventions.

[snip]
> > > +		sdma@4000 {
> > > +			compatible = "marvell,mv64x60-sdma";
> > > +			reg = <4000 c18>;
> > > +			virtual-reg = <f8104000>;
> > 
> > Why does this node have virtual-reg?
> 
> "virtual-reg" is a special property that doesn't get translated thru
> the parent mappings.  It should never be used in the kernel.  Its
> purpose is to give code in the bootwrapper the exact address that it
> should use to access a register or block of registers or ...
> Its needed here because the MPSC (serial) driver uses the SDMA unit
> to perform console I/O in the bootwrapper (e.g., cmdline editing, printf's).
> 
> Yes, this needs to be documented.

Ok.  "it's used for serial in the bootwrapper" would have sufficed - I
questioned it because it wasn't obvious that this was needed to use
the mpsc.

> 
> > > +		mpsc@8000 {
> > > +			device_type = "serial";
> > > +			compatible = "marvell,mpsc";
> > > +			reg = <8000 38>;
> > > +			virtual-reg = <f8108000>;
> > > +			sdma = <&/mv64x60/sdma@4000>;
> > > +			brg = <&/mv64x60/brg@b200>;
> > > +			cunit = <&/mv64x60/cunit@f200>;
> > > +			mpscrouting = <&/mv64x60/mpscrouting@b400>;
> > > +			mpscintr = <&/mv64x60/mpscintr@b800>;
> > > +			block-index = <0>;
> > 
> > What is this block-index thing about here?  Since the devices are
> > disambiguated by their register address, why do you need it?
> 
> This particular one is needed to access the correct MPSC interrupt reg.
> Maybe it would be better to make a new property for this but it was only
> one reg and block-index was already there and basically served that
> purpose so I used it.  I'd be happy to use an alternative if you have
> something you think is better.

No, that's an acceptable use for something like this, except that
"cell-index" seems to be the name we've standardised on for other
similar cases.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
