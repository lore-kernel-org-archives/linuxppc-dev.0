Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id C0243DDFA6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:13:32 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2MFDTCw012741
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:13:29 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MFDSYo011643
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 10:13:28 -0500 (CDT)
Message-ID: <46029D17.5030304@freescale.com>
Date: Thu, 22 Mar 2007 10:13:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
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
	<20070322000620.GC2295@localhost.localdomain>
In-Reply-To: <20070322000620.GC2295@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> I mean, does the u-boot source tree have its own copies of the dts
> files which are built into a dtb during the u-boot build process?  

No.

> Or
> do you take the dts from the kernel tree and make the dtb from that
> when you build a dtb aware u-boot for a particular machine?

You don't build the DTB with U-Boot.  You build the DTB completely separately from U-Boot. 
  As far as U-Boot concerned, until you actually boot the kernel, the DTB is just another 
binary blob.

> Yes, but if have a version of u-boot that *only* sets mac-address and
> not local-mac-address, doing so would clobber the only information
> about the MAC address we have. 

That's true.

> In any case, I don't think is relevant
> for discussion of this function, because its only designed for use
> with *non* device tree aware firmware.

Ok.

> In terms of the generated dtb output there is no difference.  Well,
> probably.  It would It's
> purely syntactic sugar / internal documentation.

Then I suggest we just leave the compiler as is, and just update the U-Boot documentation 
to specify what it does with the various device tree properties.

>> In both cases, the property exists in the DTS.  The whole point was to 
>> remove it from the DTS entirely, 
> 
> Well, no.  You wanted to get rid of the property from the dts, I
> didn't.  What I'm suggesting here is an idea to addresses at least one
> possible objection to having the properties in the dts: the fact that
> with actual values there it looks like the tree is complete and it
> might not be obvious that a bootloader *must* tweak values to produce
> a working tree.

Hmmm... I can understand that.  But I still think documenting it in U-Boot is the easier 
solution.

> I think it's useful to document in the dts that certain properties are
> expected to be there, even if their actual values have to be
> determined during boot. 

The only problem with this is that the list of properties needed/used by U-Boot can change 
from one version of U-Boot to another, and I'd hate to have to update all of the DTS files 
every time this happens.

For instance,

> It has the nice additional
> property that it lets the bootloader avoid extra memmove()s and
> possibly string table scans.

True, but I don't see why we should go through such an effort to avoid these things. 
Besides, JVB is almost done getting libfdt into U-Boot, and that should make all this moot.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
