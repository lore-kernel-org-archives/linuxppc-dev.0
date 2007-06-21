Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6ABC6DDF20
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 00:29:35 +1000 (EST)
In-Reply-To: <1182429733.24740.12.camel@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <558860c3d90100cd18df5f9a66cce3f9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Thu, 21 Jun 2007 16:29:27 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list <linuxppc-dev@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>               #address-cells = <1>;
>
> Why #address-cells set to 1 ? In a PIC node, in fact, I would expect it
> to be 0 to avoid any spurrious "reg" matching for interrupts.

The "#address-cells" property should be completely absent,
even; for interrupt matching, that means "treat as 0, no
unit address used in interrupt mapping, just the interrupt
number", and for the "normal" purpose (defining the format
of devices on the bus rooted at / represented by this node)
it means "there is no such bus" -- this is different from
#address-cells = 0.

> Just put the interrupt-parent pointer once in the isa bridge and all 
> isa
> devices below the bridge.

Definitely.

>>>               #address-cells = <1>;
>>>               #size-cells = <0>;                      // No physical
>> address.
>>
>> Comment is arguably incorrect.
>
> Yeah, not sure what that is supposed to be.

#size-cells = 0 means the addressing scheme on this bus is
not directly related to the mechanism (if any) by which
registers on a device on the bus are addressed.


Segher
