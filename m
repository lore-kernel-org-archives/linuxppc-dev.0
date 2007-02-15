Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15291DDF16
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:03:16 +1100 (EST)
In-Reply-To: <1171488643.20192.177.camel@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<1171488643.20192.177.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 01:03:08 +0100
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

>> There cannot *exist* any children of the node.  Unless
>> your hardware is really weird.  I guess it is :-)
>>
>> In such a case, you just don't put a "reg" property in
>> the kid nodes.
>
> No. The #address-cells in the interrupt controller is necessary to
> define the size of the unit address part of the unit interrupt 
> specifier
> of interrupt children. Re-read your spec :-)

Like I said (perhaps elsewhere in this thread), there
might be something in the interrupt mapping spec yes.

But I don't see what...  read on...

> Having it set to 0 provides the necessary definition so that the "right
> hand" members of an interrupt map don't need a unit address in their
> unit interrupt specifier.

And a missing #address-cells property means 0 for the
purpose of interrupt mapping.  Here, have some quotes
from the spec:


> For nodes that represent devices, the number of cells to represent a 
> unit interrupt specifier  is the  sum of the "#address-cells"  and 
> "#interrupt-cells"  properties; for nodes that do  not represent 
> devices, there is no relevant "#address-cells"  value, so that the 
> number of cells  is solely determined by the "#interrupt-cells" value. 
>  The latter case exists due to the nature of representing interrupt 
> mapping outside the context of the normal device tree.


> Note that the "open-pic" node does not have a "#address-cells" 
> property, so that  the number of cells for the parent unit interrupt 
> specifiers is 2 (which is the value of its "#interrupt-cells" 
> property).


> if present( "#address-cells", parent-node )
> 	#cells = valueof( "#address-cells", parent-node )
> else #cells = 0   then



Segher
