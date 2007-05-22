Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A0A0DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 06:08:25 +1000 (EST)
In-Reply-To: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c893fd7a08d9f2a8250a44045ce469bf@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Tue, 22 May 2007 22:08:17 +0200
To: pterry@micromemory.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> srio@c0000 {

Isn't there a nicer name, like "rapidio"?

>                 device_type = "srio";

No device_type please.

>                 compatible = "86xx,85xx";

compatible = "fsl,8641d-rapidio", "fsl,8540-rapidio";
and the latter only if the 8641d can actually be driven
as-if it were a 8540.

> 		reg = <c0000 20000>;
> 		law = <400000000 e00000000>;

What does "law" mean?  Please use a better name.  And
you write this as <4 0 e 0>.

> 		dbells = <0 ffff>;

"doorbells"

> 		mboxs = <0 4>;

"mailboxes"

> I'm
> assuming we are supposed to do away with all the CONFIG_RAPIDIO,

You still need config options to enable support for
rapidio etc.  The DTB is used at runtime to detect
what devices are actually there.

> btw how to I get the dtc to accept 36-bit numbers as above for laws?

The numbers inside < > are 32-bit integers.  64-bit
numbers are encoded as a pair of these.

> and am I allowed to invent properties like this or is there some keeper
> of the property names who I should genuflect before?

It would be nice to have a proper device binding for
rapidio, just like for PCI etc.  Since there isn't one
yet, try to invent one that would work for _all_ rapidio
hosts, so there won't be too many changes needed if
later a more generic device binding evolves.

Don't worry about it too much, just use common sense,
and you'll end up with an ad-hoc binding for this device
only that will work just fine; do the generic thing
later, when you have at least a chance to get it right ;-)


Segher
