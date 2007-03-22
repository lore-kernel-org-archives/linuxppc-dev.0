Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E750DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:03:26 +1100 (EST)
In-Reply-To: <20070321234226.GB2295@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172848.GG29784@ld0162-tx32.am.freescale.net>
	<20070317012654.GE3969@localhost.localdomain>
	<c01196ee10aa2b13278465a835a49fdf@kernel.crashing.org>
	<20070321234226.GB2295@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7ce9c69ae76258f47790c5ceb851a355@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Date: Thu, 22 Mar 2007 12:02:56 +0100
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

>>> However, #address-cells=2, #size-cells=1 is common enough that we
>>> really need to support that case.
>>
>> On the root node?!?  Who would do such a strange thing?
>
> Ebony, for one, it works nicely for a 32-bit system with >32-bit bus.

It means you cannot have a 4GB-or-bigger region below your
root node.  Dunno if Ebony ever needs one, for I/O mapping
perhaps?

> Apple G5s do it too.

And they do a an awful workaround for their memory node
because of this.

Is their any reason why you couldn't use #a=#s=2 on 32-bit
systems?  The root node is one contiguous hunk of address
space, so the biggest (theoretically) possible size is equal
to the biggest address (+1).  It's not hard to come up with
an example where you need a size of 4GB or more.


Segher
