Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37667DDF3E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 00:45:52 +1100 (EST)
In-Reply-To: <45FEA7B3.9090304@freescale.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 14:45:36 +0100
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Normally, that's true.  The problem is that device drivers first check 
> mac-address and
> then local-mac-address (see of_get_mac_address()).  If the DTS define 
> mac-address as
> something other than 00-00-00-00-00-00, the drivers are going to see 
> mac-address that and
> use it.

So fix that :-)  It's a layering violation anyway, a device
driver has no business peering at "mac-address", that's info
for a way higher layer ;-)

> Obviously, the DTS files shouldn't have mac-address in them.  But I 
> haven't gotten around
> to cleaning that up, because I'm still waiting for the U-Boot 
> maintainers to apply my
> pre-requisite patches.

Well there's that, sure.  Please put comments in your source
code saying this _is_ a hack and for _what_ and that it should
be removed when your dependency is fixed, and all is fine.

> Perhaps mac-address should be deleted instead of just ignored?

That would be incorrect behaviour if you get passed a device
tree where "mac-address" is correctly set (i.e., the device
has been used for booting, or something).

> I think it's better if the DTS only specifies properties that the 
> bootloader can't.  We
> already need the ability to insert properties, so what's wrong with 
> using that?

Agreed.  It was good before, when the tools weren't powerful
enough; but now it's hardly worth saving a few cycles.

> I think
> it doesn't make sense for the DTS to specify a MAC address.

In a few cases it might (during development, for example).
Or maybe a crazy firmware passed you a DTS instead of a DTB,
who knows ;-)


Segher
