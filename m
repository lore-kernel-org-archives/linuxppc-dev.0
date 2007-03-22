Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 11:06:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070322000620.GC2295@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<20070320035957.GC21124@localhost.localdomain>
	<45FFE8FD.9020902@freescale.com>
	<20070321025447.GG27969@localhost.localdomain>
	<460148DC.3020600@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <460148DC.3020600@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 10:01:48AM -0500, Timur Tabi wrote:
> David Gibson wrote:
> 
> > Ah, and it can't add the property if it's not there at all.  Ok, I
> > think I understand now.  But.. does u-boot directly use the dts files
> > from the kernel tree, or does it have its own copies?
> 
> I'm not sure what you mean by that.  You compile the DTS into a DTB, and 
> then make the DTB available to U-Boot.  That can mean either storing it 
> in flash, or tftp'ing it into memory.  When you boot Linux via the 
> U-Boot "bootm" command, you give it the address of the DTB in memory. 
> U-Boot than looks for various things and updates them.  It also creates 
> a couple new things, like a 'chosen' section.
> 
> If the DTB is in flash, it copies it to RAM.  Then it updates the 
> in-memory copy.  It's very hack-ish, though.  I think it just overwrites 
> various nodes as it pleases, and then reconnects everything.

I mean, does the u-boot source tree have its own copies of the dts
files which are built into a dtb during the u-boot build process?  Or
do you take the dts from the kernel tree and make the dtb from that
when you build a dtb aware u-boot for a particular machine?

> > The maybe was more in relation to should we delete the mac-address
> > property.  But that would have the same brokenness as removing
> > mac-address from the dts on old, broken u-boot's that set mac-address
> > instead of local-mac-address.
> 
> I was talking about the bootwrapper deleting the mac-address property, 
> *after* U-Boot has processed the DTB and handed it to the kernel.

Yes, but if have a version of u-boot that *only* sets mac-address and
not local-mac-address, doing so would clobber the only information
about the MAC address we have.  In any case, I don't think is relevant
for discussion of this function, because its only designed for use
with *non* device tree aware firmware.

> >> What if U-Boot were smart enough to insert all of the required items in 
> >> one shot, and then filled them in?
> > 
> > I don't see how that's reasonably possible when the items in question
> > are properties in different nodes.
> 
> Ok.
> 
> > Uh.. how does it require synchronization with u-boot?  
> > This is really
> > just a form of internal documentation in the dts which shows which
> > properties are expected to be present, but overwrriten by the
> > bootloader.
> 
> Ok, I understand now, but I don't know what value it has.  I don't see 
> the difference, from the DTS point-of-view, between
> 
> 	local-mac-address = [ 00 00 00 00 00 00 ]
> 
> and
> 
> 	local-mac-address = [ ? ? ? ? ? ? ];

In terms of the generated dtb output there is no difference.  Well,
probably.  It would It's
purely syntactic sugar / internal documentation.

> In both cases, the property exists in the DTS.  The whole point was to 
> remove it from the DTS entirely, 

Well, no.  You wanted to get rid of the property from the dts, I
didn't.  What I'm suggesting here is an idea to addresses at least one
possible objection to having the properties in the dts: the fact that
with actual values there it looks like the tree is complete and it
might not be obvious that a bootloader *must* tweak values to produce
a working tree.

I think it's useful to document in the dts that certain properties are
expected to be there, even if their actual values have to be
determined during boot.  This syntax allows a dts to show to someone
reading it that a property is expected, and what its expected size is,
but that the value must be filled in later.  It's for the benefit of
people reading the dts, not programs.  It has the nice additional
property that it lets the bootloader avoid extra memmove()s and
possibly string table scans.

> and let U-Boot realize that it needs to 
> be added.  I don't want DTC to need to know what's missing from a DTS.

It doesn't need to know, but neither does it hurt to know.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
