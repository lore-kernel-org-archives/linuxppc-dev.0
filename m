Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 13:54:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070321025447.GG27969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<20070320035957.GC21124@localhost.localdomain>
	<45FFE8FD.9020902@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45FFE8FD.9020902@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 09:00:29AM -0500, Timur Tabi wrote:
> David Gibson wrote:
> 
> > local-mac-address isn't a node, it's a property.  We never deal in
> > pointers (or handles) to properties.
> 
> Sorry, I sometimes use those terms interchangeably.
> 
> > Since mac-address is by definition a runtime property, it should
> > *never* exist in a static dts.
> 
> But it does today.  I think we need to be considerate of existing broken 
> installations.  Someone could be running an older U-Boot with an older 
> DTS, and if they boot a future kernel with it, then
> 
> > 
> >> Obviously, the DTS files shouldn't have mac-address in them.  But I
> >> haven't gotten around to cleaning that up, because I'm still waiting
> >> for the U-Boot maintainers to apply my pre-requisite patches.
> > 
> > I don't see why fixing the dts files relies on u-boot changes. 
> 
> Because today's U-Boot will, on some platforms, write to mac-address and 
> only mac-address.  If you remove that property from the DTS without 
> fixing U-Boot first, then U-Boot will never be able to pass the MAC 
> address to the kernel.

Ah, and it can't add the property if it's not there at all.  Ok, I
think I understand now.  But.. does u-boot directly use the dts files
from the kernel tree, or does it have its own copies?

> > u-boot
> > *can* know what's going on and might wish to set the mac-address
> > property, but that's its business.  The dts files which are used for
> > inclusion into a zImage should never have this property.
> 
> Bugs need to be fixed in the right order.  You can't fix the DTS files 
> until you fix all the software that uses them first.
> 
> >> Perhaps mac-address should be deleted instead of just ignored?  I
> >> don't know if that breaks kexec.
> > 
> > Hrm, maybe.
> 
> Would the cuImage bootwrapper run in a kexec'd kernel?  I hope not.  I 
> don't know anything about kexec.

The maybe was more in relation to should we delete the mac-address
property.  But that would have the same brokenness as removing
mac-address from the dts on old, broken u-boot's that set mac-address
instead of local-mac-address.

> > It's just that every insert could require copying most of the blob,
> > which is a bit sucky.
> 
> What if U-Boot were smart enough to insert all of the required items in 
> one shot, and then filled them in?

I don't see how that's reasonably possible when the items in question
are properties in different nodes.

> > I was thinking of making an extension to dtc for these properties that
> > are expected to be replaced in-place by the bootloader:  a special
> > token representing a value to be filled in later, so something like:
> > 	clock-frequency = < _ >;
> > or
> > 	local-mac-address = [??????];
> > The blob produced would just replace the blanks with either all 0s or
> > all 1s, so it doesn't actually do anything new, but it would provide a
> > strong visual clue in the source as to which properties are supposed
> > to be filled in later.  Would that overcome your reluctance to include
> > bootloader-replaced properties in the dts?
> 
> No, because it would require DTC to be constantly in sync with U-Boot, 
> and that sounds like a lose-lose proposition to me.  It takes months for 
> any U-Boot patch that I write to be accepted and applied.

Uh.. how does it require synchronization with u-boot?  This is really
just a form of internal documentation in the dts which shows which
properties are expected to be present, but overwrriten by the
bootloader.

> For instance, last month, I posted a fix for an old bug in U-Boot that 
> prevents initrd from working with any OF kernel.  U-Boot has had this 
> bug ever since it added OF support.  Despite repeated emails to WD 
> himself, I haven't even gotten an acknowledgment from him as to whether 
> he'll apply it, let alone when.
> 
> So as you can imagine, I am very wary about any design that requires 
> U-Boot to be updated in concert with any other software.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
