Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B569FDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 18:22:57 +1000 (EST)
In-Reply-To: <FF15186D-1D92-422E-AC6C-3127F6116C79@freescale.com>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
	<1181232276.5674.146.camel@rhino>
	<63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
	<FF15186D-1D92-422E-AC6C-3127F6116C79@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ddd8efa1565a98b4ac50666b91c3e325@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Fri, 8 Jun 2007 10:22:38 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I suppose I could create a device node for the Super I/O config
>>> registers and use those instead of hardcoding it here.
>>
>> I'd just hide it all, do this setup in the firmware,
>> where it belongs, and don't expose the superio config
>> in the device tree.
>
> No more.  No more firmware-only initializations.

This setup is very board specific, and the board cannot
reasonably work without that setup being done right.  You
really want to push _that_ into Linux?  Alternatively,
you could put it into the device tree, but that doesn't
help anything either.

> It sounds great, in principle, until you actually have to figure out 
> why someone's setup isn't working.  I'm tired of having to see if the 
> dts, u-boot, and Linux are in sync.  If Linux wants to use a device, I 
> think it's not unreasonable to have it setup the device itself.  That 
> way, Linux can do whatever it wants with the device, and not have to 
> rely on U-Boot (or some other firmware) setting up the appropriate 
> bits.

There is one and only one way to set up the superio for
a certain board (assuming the legacy I/O and IRQ values
are considered fixed values).

> Please...no.  What happens next is that we find a small bug that 
> requires we modify U-Boot to do the initialization slightly 
> differently, and then requires Linux to act slightly differently.

This is equivalent to needing a board-level fix really.


Segher
