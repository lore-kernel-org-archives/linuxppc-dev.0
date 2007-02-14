Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17123DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 04:48:30 +1100 (EST)
In-Reply-To: <20070214002210.GE11491@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 18:48:02 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +			clock-frequency = <5F5E100>; /* 100MHz FIXME: poke in zImage */
>>> +			timebase-frequency = <5F5E100>; /* 100MHz FIXME: wrong, poke in
>>> zImage */
>>
>> Can't you use decimal for these?
>
> dtc doesn't support decimal cells at present.  Suggest a good syntax
> for doing it, and I'll add the feature.

d# 100000000    like is used in "real" OF?

>>> +	UIC0: interrupt-controller { /* UIC0 */
>>
>>> +		#address-cells = <0>;
>>> +		#size-cells = <0>;
>>
>> #address-cells = 0 never makes sense.
>
> Why not?  Children of this node have and need no reg property, and no
> meaningful address.  Sounds like #address-cells = 0 to me.

There cannot *exist* any children of the node.  Unless
your hardware is really weird.  I guess it is :-)

In such a case, you just don't put a "reg" property in
the kid nodes.

>>> +	plb {
>>> +		device_type = "soc";
>>> +		compatible = "ibm,plb-440gp", "ibm,plb4";
>>> +		ranges;
>>
>> You need a #address-cells, #size-cells here.
>
> Why?  The values inherited from the root node are perfectly ok here.

Values aren't inherited.  Missing #address-cells, #size-cells
properties mean 2 and 1 respectively.  And it's good practice
to always fill them in explicitly.


Segher
