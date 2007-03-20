Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Mar 2007 14:59:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070320035957.GC21124@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45FEA7B3.9090304@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 19, 2007 at 10:09:39AM -0500, Timur Tabi wrote:
> David Gibson wrote:
> 
> >> The problem with this version is that it only updates local-mac-address, 
> >> and only if it already exists.  
> > 
> > Uh.. no.  Both my version and Scott's use setprop. 
> 
> Sorry, I was reading the code wrong.  I saw "if (devp)" and I
> thought devp was a pointer to the local-mac-address node.

local-mac-address isn't a node, it's a property.  We never deal in
pointers (or handles) to properties.

> > Second, I don't think the zImage should be setting
> > mac-address anyway.  
> 
> Normally, that's true.  The problem is that device drivers first
> check mac-address and then local-mac-address (see
> of_get_mac_address()).  If the DTS define mac-address as something
> other than 00-00-00-00-00-00, the drivers are going to see
> mac-address that and use it.

Since mac-address is by definition a runtime property, it should
*never* exist in a static dts.

> Obviously, the DTS files shouldn't have mac-address in them.  But I
> haven't gotten around to cleaning that up, because I'm still waiting
> for the U-Boot maintainers to apply my pre-requisite patches.

I don't see why fixing the dts files relies on u-boot changes.  u-boot
*can* know what's going on and might wish to set the mac-address
property, but that's its business.  The dts files which are used for
inclusion into a zImage should never have this property.

>  > In OF that property is based on what the
> > interface has been used for during booting, which the zImage doesn't
> > know.  The kernel doesn't need mac-address if local-mac-address is
> > present, so we should just leave it out.
> 
> Perhaps mac-address should be deleted instead of just ignored?  I
> don't know if that breaks kexec.

Hrm, maybe.

> > I don't think that's really a good idea.  The bootloader certainly
> > should be able to add the property if it's not there, but it seems
> > silly to make the bootloader do memmove()s to insert a new property
> > when it's basically just as easy to set up the device tree to allow an
> > in-place edit.
> 
> I think it's better if the DTS only specifies properties that the
> bootloader can't.  We already need the ability to insert properties,
> so what's wrong with using that?  I think it doesn't make sense for
> the DTS to specify a MAC address.

It's just that every insert could require copying most of the blob,
which is a bit sucky.

I was thinking of making an extension to dtc for these properties that
are expected to be replaced in-place by the bootloader:  a special
token representing a value to be filled in later, so something like:
	clock-frequency = < _ >;
or
	local-mac-address = [??????];
The blob produced would just replace the blanks with either all 0s or
all 1s, so it doesn't actually do anything new, but it would provide a
strong visual clue in the source as to which properties are supposed
to be filled in later.  Would that overcome your reluctance to include
bootloader-replaced properties in the dts?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
