Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8735CDDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:05:32 +1000 (EST)
In-Reply-To: <1179937253.11247.44.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
	<836bca7802dca173490f4d38e0c48b7a@kernel.crashing.org>
	<1179937253.11247.44.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <15e29856db235bcba4228266653c5982@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Thu, 24 May 2007 01:05:25 +0200
To: pterry@micromemory.com
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If the firmware sets up the "law", it should put a property
>> in the node describing the setting.  If Linux sets up the
>> laws, there shouldn't be a property (since it is a policy
>> decision).
> Ooops, I just posted a question to you before I saw this pop up sorry?

No problem.

> But when you say "firmware" do you mean u-boot or your kernel loading
> code or do you mean some aspect of the hardware, eg, its EEPROM program
> which can vary from hardware to hardware instantiation?

Any of those.  Anything before the kernel takes control.

> If you mean u-boot I'm confused (so whats new?). AFAIK u-boot can't
> probe and set this up

Maybe it should.

>  and even if it did, linux in the arch's I'm
> familiar with sets everything up anew regardless of what the boot 
> loader
> did.

...and maybe that needs changing.


If it's a platform thing, it's the platform firmware code
that should configure it (and then it belongs in the device
tree).  If reasonably the kernel should configure it later,
_it_ should do it (and then there shouldn't be a device tree
property).

I have no clue which it is.


Segher
