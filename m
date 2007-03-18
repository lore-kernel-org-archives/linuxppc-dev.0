Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Mar 2007 22:56:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070318115656.GA12765@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45FC8643.1080807@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2007 at 07:22:27PM -0500, Timur Tabi wrote:
> David Gibson wrote:
> 
> >        while ((addr = va_arg(ap, void *))) {
> >                devp = find_node_by_prop_value(NULL,
> > linux,network-index",
> >                                               &index, sizeof(index));
> > 
> >                if (devp)
> >                       setprop(devp, "local-mac-address", addr, 6);
> 
> The problem with this version is that it only updates local-mac-address, 
> and only if it already exists.  

Uh.. no.  Both my version and Scott's use setprop.  I think at present
that won't add the property if it doesn't exist, but that's a bug
which one of Scott's other patches fixes.  In any case, they have the
same behaviour in terms of whether the property needs to exist first.

> Scott's version also updates 
> mac-address.  

Well, first, details shmetails.  It's the interface and approach I
thin is better.  Second, I don't think the zImage should be setting
mac-address anyway.  In OF that property is based on what the
interface has been used for during booting, which the zImage doesn't
know.  The kernel doesn't need mac-address if local-mac-address is
present, so we should just leave it out.

> Also, in the future, we hope to eliminate *all* MAC 
> address entries from the DTS files, and the boot loader and/or 
> bootwrapper will add one.

I don't think that's really a good idea.  The bootloader certainly
should be able to add the property if it's not there, but it seems
silly to make the bootloader do memmove()s to insert a new property
when it's basically just as easy to set up the device tree to allow an
in-place edit.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
