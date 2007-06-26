Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 409A6DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 01:22:15 +1000 (EST)
Message-ID: <46812F19.1070302@freescale.com>
Date: Tue, 26 Jun 2007 10:22:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
	<467FDA2C.8020607@freescale.com>
	<05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
	<467FE6E5.1070403@freescale.com>
	<b50d825c36a92dc2e16f486455e0623d@kernel.crashing.org>
In-Reply-To: <b50d825c36a92dc2e16f486455e0623d@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Yeah, that's fine.   I just meant the current kernel (before
> .25) could detect you are using a uboot that won't work after
> .25 anymore, and shout at the user.  Would save you some bug
> reports ;-)

I don't think that's possible.  I'm only updating the DTS files, not the kernel, because 
the kernel has already been updated.  Any 2.6.21 or later kernel will work with any U-Boot 
and any DTS.  The only time we're going to run into a problem is if someone updates the 
DTS but does *not* update U-Boot.  In this case, U-Boot won't find what it's looking for. 
  Some U-Boots will even panic in these cases.  Not only that, but older U-Boots don't 
even check the version number of the device tree they're parsing, and they'll just fail 
silently when they get a version they don't understand.  Unfortunately, I don't see how I 
can fix these problems.

>> In other words, the current U-Boot and Linux code is written to not 
>> care what the other one does.  I have no plans to remove the code in 
>> the kernel that looks for obsolete entries (I'm talking about function 
>> of_get_mac_address), because it's "safe".
> 
> Well you should remove the "address" thing, it is _not_ safe.

Checking for 'address' after finding no match on 'mac-address' and 'local-mac-address' is 
safe, because if that's the only property that has a valid MAC address, I want to use it. 
  As long as there are people out there using U-Boot 1.1.x, we'll need to keep that code 
around.

>> However, now that you mention it, I could update function 
>> of_get_mac_address() to display a warning if it only finds the 
>> 'address' property.
> 
> Yeah exactly.

Ok, I will submit a patch to do that.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
