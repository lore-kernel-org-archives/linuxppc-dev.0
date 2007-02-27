Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8A17DDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 13:52:47 +1100 (EST)
In-Reply-To: <20070227023243.GC1861@localhost.localdomain>
References: <20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
	<20070227023243.GC1861@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Tue, 27 Feb 2007 03:52:41 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> And if a program parsing the device tree sees no valid
>> "interrupts" property, it can validly assume the device
>> doesn't have interrupts.
>>
>> Same problem.
>
> Sort of.  But the probable consequences of mistakenly believing a
> device has no interrupts are substantially less messy than mistakenly
> believing you understand the node's interrupts when you don't.

"Less messy"...  well the device won't work properly
in either case.  The kernel might completely screw
up programming the interrupts, which would mean it
doesn't do enough sanity checking; or it could give
spectacular oopses, where the "less messy" case would
simply be a device driver not running for your device.

If the one case gives you more information to track
down the problem than the other case, I argue that's
a shortcoming of the kernel, not of the OF binding.

Anyway, it's all a question of deployment: you just
have to make sure your users use a new enough kernel
with your device tree (and device), which you have
to do *anyway*.  Also DTS files are still conveniently
shipped with the kernel so it's even less of a problem.


Segher
