Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26D64DDED0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 19:01:37 +1000 (EST)
In-Reply-To: <20070602085359.GA10333@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sat, 2 Jun 2007 11:01:29 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> +						i8259: i8259@4d0 {
>>>>
>>>> Needs "reg".  And 4d0 isn't the primary address
>>>> I think?
>>>
>>> Yes, this is a standard i8259 with additional registers at 0x20 and
>>> 0xa0.  I'll fix the address and add the registers.
>>
>> That sounds good, thanks!
>
> I'd beg to differ. There are three registers area:
>
> - 0x20 which is the master interrupt controller
>   (since the original 1981 IBM-PC)
> - 0xa0 which is the slave interrupt controller, connected to
>   IRQ2 of the master (introduced with the XT or the AT, I don't
>   remember)
> - 0x4d0 which was added later to allow per interrupt line setting
>   of edge or level triggering (instead of per controller).
>
> By far the most important registers are the ones at 0x20 since
> you access them at every interrupt. The registers at 0x4d0
> are typically set by firmware and never touched later, there
> is not a single access to them in sysdev/i8259.c.

Yes, I think we all agree -- it should be interrupt-controller@20,
with 20, a0, 4d0 in the "reg" property.

I'm not sure what "compatible" should be for this node, someone
else can dig that up :-)


Segher
