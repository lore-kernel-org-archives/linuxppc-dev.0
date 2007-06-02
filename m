Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C816CDDEBB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:23:11 +1000 (EST)
In-Reply-To: <1180734314.5674.49.camel@rhino>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sat, 2 Jun 2007 10:22:59 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> "reg" included in "ranges"?  Something is wrong here.
>
> I think it's correct for soc nodes.

It is not.  "ranges" is the address space translation
between the parent and child busses; "reg" is the stuff
that's on the bridge device itself.

> At least, it appears that all of
> the dts files with soc nodes do similar things (including this one even
> without this patch).

Yes, but that doesn't make it right.

>>> +				pci_bridge@0 {
>>
>>> +					#size-cells = <2>;
>>> +					#address-cells = <3>;
>>> +					ranges = <02000000 0 80000000
>>> +						  02000000 0 80000000
>>> +						  0 20000000
>>> +						  01000000 0 00000000
>>> +						  01000000 0 00000000
>>> +						  0 00100000>;
>>> +
>>> +					isa@1e {
>>> +						#size-cells = <1>;
>>> +						#address-cells = <2>;
>>>
>>> +						ranges = <1 0 01000000 0 0
>>> +							  00001000>;
>>
>> You map the same range (4kB legacy I/O @ 0) for both
>> bridges here.
>
> There is a one-to-one mapping between the I/O spaces of "isa" and
> "pci_bridge", so wouldn't it be reasonable that a similar range be 
> used?

Oh wait, the ISA bridge is a child of the PCI bridge here.
It is obviously fine then.

>>> +						i8042@60 {
>>> +							reg = <1 60 1 1 64 1>;
>>
>> And this address space is included in both of those.
>
> Again, shouldn't the child's address space be in its parent's range?

Yes of course, I'm simply losing track of the nesting
here.  Sigh.

>>> +						i8259: i8259@4d0 {
>>
>> Needs "reg".  And 4d0 isn't the primary address
>> I think?
>
> Yes, this is a standard i8259 with additional registers at 0x20 and
> 0xa0.  I'll fix the address and add the registers.

That sounds good, thanks!


Segher
