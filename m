Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id D0B3EDDEFC
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 19:40:07 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1885990ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 00:40:06 -0800 (PST)
Message-ID: <528646bc0701170040y21cbecbeq55e0d1eb7c28ff01@mail.gmail.com>
Date: Wed, 17 Jan 2007 01:40:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
In-Reply-To: <1168928567.4803.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

(Added ML to the CC list)

On 1/15/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2007-01-15 at 16:37 +0100, Segher Boessenkool wrote:
> > > Same logic with interrupts.
> >
> > Interrupts go from a device to the interrupt controller, here
> > it is the other way around.

> That doesn't matter. The actual direction of the signal doesn't matter.
---snip---
> and at the end of the day it doesn't matter, It's up to Sylvain and Grant do decide
> what they want to do.

Well, I suppose I should stop sitting on the fence on this and
actually give my opinion.  I have to agree with Ben here, I don't
think the direction of the link matters.  One binding can be trivially
generated from the other no matter which way it is done.

I don't think the argument that the data should not be scattered about
in various device nodes holds a whole lot of water.  There is already
precedence for this with the interrupt binding.  I've already stated
that I don't think the signal direction matters, so I don't agree with
the argument that interrupts are different because that are connected
the other way around.

Putting the linkage in the device nodes does not bloat the tree, and
it does not duplicate information.  The device tree is just as
expressive either way around, so typical usage becomes the tie
breaker.  Typical usage is for the device driver to "call" the system
node; therefore put the linkage information in the device node where
it's most easily retrieved when needed.

Looking at the larger scope; we're talking about an SoC here.  While
most of the SoC device drivers don't need to know anything about the
SoC as a whole, the platform code should really know what SoC part it
is on.  SoC designers love to toss in special cases which don't really
slide nicely into our pretty device tree, and the OS almost always
needs chip specific support code to handle it.  I'm inclined to say
that the bindings from device node to shared soc registers may be
*recommended*, but not *required*.  As long as there is some form of
linkage between the soc and device nodes, and as long as the SoC node
describes exactly which SoC it is, then the OS has all the information
it needs to figure out which devices are connected to which bits of
which shared registers (based on register address).  Now, this might
be a bad precedence, but I'm hesitant to go down the path of trying to
describe something in the device tree which is inherent to the SoC
design.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
