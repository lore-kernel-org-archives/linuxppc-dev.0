Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2310BDDF3E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 01:00:33 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2KE0UTD011365
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 07:00:30 -0700 (MST)
Received: from Artemis.local (mvp-10-214-73-65.am.freescale.net [10.214.73.65])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2KE0TtN013935
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 09:00:30 -0500 (CDT)
Message-ID: <45FFE8FD.9020902@freescale.com>
Date: Tue, 20 Mar 2007 09:00:29 -0500
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
In-Reply-To: <20070320035957.GC21124@localhost.localdomain>
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

> local-mac-address isn't a node, it's a property.  We never deal in
> pointers (or handles) to properties.

Sorry, I sometimes use those terms interchangeably.

> Since mac-address is by definition a runtime property, it should
> *never* exist in a static dts.

But it does today.  I think we need to be considerate of existing broken 
installations.  Someone could be running an older U-Boot with an older 
DTS, and if they boot a future kernel with it, then

> 
>> Obviously, the DTS files shouldn't have mac-address in them.  But I
>> haven't gotten around to cleaning that up, because I'm still waiting
>> for the U-Boot maintainers to apply my pre-requisite patches.
> 
> I don't see why fixing the dts files relies on u-boot changes. 

Because today's U-Boot will, on some platforms, write to mac-address and 
only mac-address.  If you remove that property from the DTS without 
fixing U-Boot first, then U-Boot will never be able to pass the MAC 
address to the kernel.

> u-boot
> *can* know what's going on and might wish to set the mac-address
> property, but that's its business.  The dts files which are used for
> inclusion into a zImage should never have this property.

Bugs need to be fixed in the right order.  You can't fix the DTS files 
until you fix all the software that uses them first.

>> Perhaps mac-address should be deleted instead of just ignored?  I
>> don't know if that breaks kexec.
> 
> Hrm, maybe.

Would the cuImage bootwrapper run in a kexec'd kernel?  I hope not.  I 
don't know anything about kexec.

> It's just that every insert could require copying most of the blob,
> which is a bit sucky.

What if U-Boot were smart enough to insert all of the required items in 
one shot, and then filled them in?

> I was thinking of making an extension to dtc for these properties that
> are expected to be replaced in-place by the bootloader:  a special
> token representing a value to be filled in later, so something like:
> 	clock-frequency = < _ >;
> or
> 	local-mac-address = [??????];
> The blob produced would just replace the blanks with either all 0s or
> all 1s, so it doesn't actually do anything new, but it would provide a
> strong visual clue in the source as to which properties are supposed
> to be filled in later.  Would that overcome your reluctance to include
> bootloader-replaced properties in the dts?

No, because it would require DTC to be constantly in sync with U-Boot, 
and that sounds like a lose-lose proposition to me.  It takes months for 
any U-Boot patch that I write to be accepted and applied.

For instance, last month, I posted a fix for an old bug in U-Boot that 
prevents initrd from working with any OF kernel.  U-Boot has had this 
bug ever since it added OF support.  Despite repeated emails to WD 
himself, I haven't even gotten an acknowledgment from him as to whether 
he'll apply it, let alone when.

So as you can imagine, I am very wary about any design that requires 
U-Boot to be updated in concert with any other software.
