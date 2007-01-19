Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70B0FDDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 21:58:50 +1100 (EST)
In-Reply-To: <528646bc0701170040y21cbecbeq55e0d1eb7c28ff01@mail.gmail.com>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<45AA098C.70101@246tNt.com>
	<6189b01379f62aa4516484872f4ef86f@kernel.crashing.org>
	<1168810790.4803.11.camel@localhost.localdomain>
	<ccc8fbc935d8f8d3e30870d43959f6c7@kernel.crashing.org>
	<1168817449.4803.28.camel@localhost.localdomain>
	<ef64a4198a02929a00c28abb5f0934b5@kernel.crashing.org>
	<1168818533.4803.37.camel@localhost.localdomain>
	<a1af25147ea7308c394d243511b96f69@kernel.crashing.org>
	<1168928567.4803.55.camel@localhost.localdomain>
	<528646bc0701170040y21cbecbeq55e0d1eb7c28ff01@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CB20EEEE-9C3D-4FFC-869E-D331F8CA264A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Date: Fri, 19 Jan 2007 11:58:23 +0100
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't think the argument that the data should not be scattered about
> in various device nodes holds a whole lot of water.

It's one of the main design principles behind the device
tree at all, how can it _not_ make sense.  If you just put
random pieces of data wherever you feel like putting them
you end up with ACPI instead.

> There is already
> precedence for this with the interrupt binding.

With interrupts it is unavoidable, since you often have cascaded
controllers.

> Putting the linkage in the device nodes does not bloat the tree, and
> it does not duplicate information.  The device tree is just as
> expressive either way around,

Except you have to parse the whole tree to determine the function
of the one controller node.

> so typical usage becomes the tie
> breaker.  Typical usage is for the device driver to "call" the system
> node; therefore put the linkage information in the device node where
> it's most easily retrieved when needed.

You don't normally use the device tree at runtime; typical usage
is to parse it at startup and initialise some internal kernel
data structures from that.  The device tree needs to express the
system in a clear, extensible way; it is not its purpose to "make
things easy" for the Linux kernel (although that can happen as a
side effect).

> Looking at the larger scope; we're talking about an SoC here.  While
> most of the SoC device drivers don't need to know anything about the
> SoC as a whole, the platform code should really know what SoC part it
> is on.  SoC designers love to toss in special cases which don't really
> slide nicely into our pretty device tree, and the OS almost always
> needs chip specific support code to handle it.

Yep.  Which is why IMHO the OF binding shouldn't even try to
model the functionality of such a SoC controller node.  It has
to show what it is that is controlled though.

> I'm inclined to say
> that the bindings from device node to shared soc registers may be
> *recommended*, but not *required*.

If they aren't required, you obviously have some other way to
get that information, so it shouldn't be recommended either.

>   As long as there is some form of
> linkage between the soc and device nodes, and as long as the SoC node
> describes exactly which SoC it is, then the OS has all the information
> it needs to figure out which devices are connected to which bits of
> which shared registers (based on register address).

Yes exactly.  And if we can express all this in a simple
self-contained way, like for example put this all in one
device node, why do something terribly complex and kludgy
instead?

> Now, this might
> be a bad precedence, but I'm hesitant to go down the path of trying to
> describe something in the device tree which is inherent to the SoC
> design.

You shouldn't try to.  Since the "controlled" devices are in
the device tree however, you have to list them in the "controller"
node so you can figure out what is what.


Segher
