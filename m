Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26755DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 04:51:38 +1100 (EST)
In-Reply-To: <1171417866.20192.126.camel@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<1171417866.20192.126.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <536d4ad153f9c23c817640bfd09b542b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 18:51:27 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +	UIC0: interrupt-controller { /* UIC0 */
>>>
>>>> +		#address-cells = <0>;
>>>> +		#size-cells = <0>;
>>>
>>> #address-cells = 0 never makes sense.
>>
>> Why not?  Children of this node have and need no reg property, and no
>> meaningful address.  Sounds like #address-cells = 0 to me.
>
> In fact, not only it does make perfect sense but it's also routinely
> used for ... interrupt controllers :-) That's among others why the
> interrupt map entries "second" part usually doesn't contain the address
> cells.

Can you please explain this in detail?  Children of such
a node (a node with #a = 0) have no "reg" property --
maybe something in the interrupt tree stuff still needs
a #a in the interrupt controller node, but I fail to
see what right now.

>>> You need a #address-cells, #size-cells here.
>>
>> Why?  The values inherited from the root node are perfectly ok here.
>
> Inheriting values is out of spec.

It's not just out of spec but directly contradicting it.

> The kernel somewhat does it but that's
> a bad habit, we should always have them explicit.

The kernel should really only do it on firmwares that
need this quirk.  Alternatively, some early fix up
pass could add the properties on such a firmware.


Segher
