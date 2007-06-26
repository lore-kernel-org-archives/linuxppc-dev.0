Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C19FFDDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 01:42:59 +1000 (EST)
In-Reply-To: <46812F19.1070302@freescale.com>
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
	<467FDA2C.8020607@freescale.com>
	<05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
	<467FE6E5.1070403@freescale.com>
	<b50d825c36a92dc2e16f486455e0623d@kernel.crashing.org>
	<46812F19.1070302@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7b7186d108fee941496ea15fd902474@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx,
	and 86xx device trees
Date: Tue, 26 Jun 2007 17:42:51 +0200
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

>> Yeah, that's fine.   I just meant the current kernel (before
>> .25) could detect you are using a uboot that won't work after
>> .25 anymore, and shout at the user.  Would save you some bug
>> reports ;-)
>
> I don't think that's possible.

Hrm I phrased it incorrectly I suppose, I meant something just
like the patch you propose below :-)

> Unfortunately, I don't see how I can fix these problems.

You cannot fix it but you can sometimes detect it.  Not all
that important anyway.

>>> In other words, the current U-Boot and Linux code is written to not 
>>> care what the other one does.  I have no plans to remove the code in 
>>> the kernel that looks for obsolete entries (I'm talking about 
>>> function of_get_mac_address), because it's "safe".
>> Well you should remove the "address" thing, it is _not_ safe.
>
> Checking for 'address' after finding no match on 'mac-address' and 
> 'local-mac-address' is safe, because if that's the only property that 
> has a valid MAC address, I want to use it.  As long as there are 
> people out there using U-Boot 1.1.x, we'll need to keep that code 
> around.

It is not safe since you might happen upon a network device without
"mac-address" property (since the device hasn't been used at boot in
a real OF, or the firmware knows no mac address at all, etc.) and no
"local-mac-address" either -- but it _does_ have an "address", and
it can have an "address" with the correct semantics, not the broken
stuff.

It's not very likely for this happens, sure :-)

>>> However, now that you mention it, I could update function 
>>> of_get_mac_address() to display a warning if it only finds the 
>>> 'address' property.
>> Yeah exactly.
>
> Ok, I will submit a patch to do that.

Thanks!


Segher
