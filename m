Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21D8FDDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:34:19 +1100 (EST)
In-Reply-To: <46018315.1030703@freescale.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 20:34:13 +0100
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

>>> Eh, I don't think I agree with that.  mac-address is supposed to be 
>>> used if it exists, because it represents the "most recent MAC 
>>> address".
>> That's policy and belongs in user land, not in the kernel,
>> and certainly not in a device driver.
>
> The device driver needs to know what MAC address to program into the 
> hardware when it initializes it.

And it should use "local-mac-address" for that when it exists.

>  Everything else the driver needs is also in the device tree.  So 
> you're saying the driver should ignore the MAC address fields, and 
> then when it needs a MAC address, it should ......... ?

No, I'm saying that you shouldn't use "mac-address" for
something it isn't meant for.

You aren't supposed to have a "mac-address" property for
devices that weren't used during firmware execution / booting
_at all_.


Segher
