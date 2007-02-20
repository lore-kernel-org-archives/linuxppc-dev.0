Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73F76DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:25:14 +1100 (EST)
In-Reply-To: <200702201607.33249.arnd@arndb.de>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
	<200702201607.33249.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [0/14] Ebony support, 2nd spi
Date: Tue, 20 Feb 2007 16:25:00 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> And the ebony dts also has the a bus type of "ibm,opb" as well.
>
> We should really get a common name for these. I don't remember
> what the discussions were, but it seems we came up with different
> results for Axon and ppc4xx, which is very bad.

"Very bad"...  Well sure it's less than desirable, but
we have to deal with this problem anyway already.

> Using type "ibm,opb" rather than just "opb" makes sense to me,
> but I don't know if we already have shipping systems that use
> "opb" here.
>
> There is probably a similar problem with the nodes for "plb4",
> "plb5" and "ebc",

It makes sense for generic code to always if it is asked
to match for "vendor-code,some-name" also to match on
plain "some-name".  Well unless people start doing crazy
things like naming something "vendor-code,pci" which
isn't PCI compatible or something -- in that case there
could be a function that matches on exact name only, or
the caller can deal with it itself perhaps.

But in most cases the matching-without-prefix should work
fine.

> as well as the "compatible" property of the
> serial port, which, as you noted earlier is "ns16550" on
> ebony and "ns16750" on axon, although it is exactly the same
> macro.

So the "compatible" property should read ns16750, ns16550,
ns16450, i8250.  The kernel really only needs the device
to be compatible to the 8250; but since lots of device trees
mention only the newer UART types, you have to match on those
too.


Segher
