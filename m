Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0487DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 17:40:50 +1000 (EST)
In-Reply-To: <467FE6E5.1070403@freescale.com>
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
	<467FDA2C.8020607@freescale.com>
	<05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
	<467FE6E5.1070403@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b50d825c36a92dc2e16f486455e0623d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx,
	and 86xx device trees
Date: Tue, 26 Jun 2007 09:40:44 +0200
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

>> Yup, they're both marked for removal so let's just remove them
>> at the same time.
>
> As soon as Paul creates a "for-2.6.25" branch, that's when I was 
> planning on doing it.

Sounds like as good a time as any.

>> Does the kernel provide a warning to users of too-old firmware^Wuboot
>> telling them to update btw?
>
> Nope.  The current U-Boot code updates mac-address and/or 
> local-mac-address, whichever ones exist.  If neither exists, it 
> doesn't do anything.  If both exists, it updates both with the same 
> value.  This makes it DTS-agnostic, so to speak.
>
> The kernel looks at each of the properties and uses the first one that 
> has a valid MAC address.  Again, this is U-Boot- and DTS-agnostic.

Yeah, that's fine.   I just meant the current kernel (before
.25) could detect you are using a uboot that won't work after
.25 anymore, and shout at the user.  Would save you some bug
reports ;-)

> In other words, the current U-Boot and Linux code is written to not 
> care what the other one does.  I have no plans to remove the code in 
> the kernel that looks for obsolete entries (I'm talking about function 
> of_get_mac_address), because it's "safe".

Well you should remove the "address" thing, it is _not_ safe.

> However, now that you mention it, I could update function 
> of_get_mac_address() to display a warning if it only finds the 
> 'address' property.

Yeah exactly.

>   That property is definitely wrong and should never be in the DTS or 
> any device tree passed to the kernel.


Segher
