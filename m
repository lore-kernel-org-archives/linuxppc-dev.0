Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7D289DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:01:56 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2LF1n6i008527
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 08:01:53 -0700 (MST)
Received: from Artemis.local (mvp-10-214-72-23.am.freescale.net [10.214.72.23])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2LF1mPY003090
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 10:01:48 -0500 (CDT)
Message-ID: <460148DC.3020600@freescale.com>
Date: Wed, 21 Mar 2007 10:01:48 -0500
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
In-Reply-To: <20070321025447.GG27969@localhost.localdomain>
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

> Ah, and it can't add the property if it's not there at all.  Ok, I
> think I understand now.  But.. does u-boot directly use the dts files
> from the kernel tree, or does it have its own copies?

I'm not sure what you mean by that.  You compile the DTS into a DTB, and 
then make the DTB available to U-Boot.  That can mean either storing it 
in flash, or tftp'ing it into memory.  When you boot Linux via the 
U-Boot "bootm" command, you give it the address of the DTB in memory. 
U-Boot than looks for various things and updates them.  It also creates 
a couple new things, like a 'chosen' section.

If the DTB is in flash, it copies it to RAM.  Then it updates the 
in-memory copy.  It's very hack-ish, though.  I think it just overwrites 
various nodes as it pleases, and then reconnects everything.

> The maybe was more in relation to should we delete the mac-address
> property.  But that would have the same brokenness as removing
> mac-address from the dts on old, broken u-boot's that set mac-address
> instead of local-mac-address.

I was talking about the bootwrapper deleting the mac-address property, 
*after* U-Boot has processed the DTB and handed it to the kernel.

>> What if U-Boot were smart enough to insert all of the required items in 
>> one shot, and then filled them in?
> 
> I don't see how that's reasonably possible when the items in question
> are properties in different nodes.

Ok.

> Uh.. how does it require synchronization with u-boot?  
> This is really
> just a form of internal documentation in the dts which shows which
> properties are expected to be present, but overwrriten by the
> bootloader.

Ok, I understand now, but I don't know what value it has.  I don't see 
the difference, from the DTS point-of-view, between

	local-mac-address = [ 00 00 00 00 00 00 ]

and

	local-mac-address = [ ? ? ? ? ? ? ];

In both cases, the property exists in the DTS.  The whole point was to 
remove it from the DTS entirely, and let U-Boot realize that it needs to 
be added.  I don't want DTC to need to know what's missing from a DTS.
