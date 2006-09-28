Return-Path: <dan@embeddedalley.com>
Received: from outbound1.mail.tds.net (outbound1.mail.tds.net [216.170.230.91])
	by ozlabs.org (Postfix) with ESMTP id 434F567B71
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 13:14:36 +1000 (EST)
In-Reply-To: <20060927112201.293fef44@localhost.localdomain>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Thu, 28 Sep 2006 00:10:16 -0400
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 27, 2006, at 12:22 PM, Olof Johansson wrote:

> Yes, also called "board port hell".

I tend to think people skilled to do a board port
will still create something elegant and functional
given whatever the existing model.

> ....   So you can boot the same kernel binary on
> several boards, as long as the drivers are built in and the correct
> device tree is used. Has everyone missed/forgotten that objective
> completely?

That was never an objective when we started, although
it seems some people involved in the implementation
think it's the only objective.  It just happens to be a side
effect when convenient.

If you could look back over the eight or more years
of embedded Linux development with PowerPC, this
discussion of supporting multiple boards with
single binaries has occurred.  In all cases, we never
considered it a requirement, there are many others
more important in embedded systems.  Our greatest
concern was sharing code among all platforms, but
in a way we could still configure the most compact
and highest performance code for a particular
processor and board.

Although processors are faster and memory is larger
today, embedded systems are still trying to do more with
less.  We still try to run the slowest processor speed to
conserve power and meet environmental requirements.
Memory still costs money, and designs try to use the
minimum amount to be cost competitive.  IMHO, the same
requirements for compact and efficient code are just
as important today as they were when we had the first
discussion years ago.  Conversion of the information,
kernel code just hanging around in case it may be used
on some board but not another and reliance on a
particular version of boot code are things we have
always tried to avoid.  We are competing against other
processor architectures that are more compact and
resource friendly, it would be nice to not lose in
those product designs.

> The device tree describes the system, not how to program it. I think
> that's where the confusion might be.

There is no confusion.  This device tree discussion was started
several years ago by a couple of us trying to find a way to better
describe the wide variety of PowerPC SOC processor peripheral
variants.  Kumar and I had many discussions about this, since
my old static internal memory maps weren't going to work well.
The IBM microelectronics folks were also looking for something
similar.  We thought a _simple_ flat device tree along with
the platform data would be sufficient to define this internal
peripheral mapping.  I wasn't too keen on the idea, but didn't
have the time to provide any alternative implementation
against the Freescale coding machine :-)

Now, we have something that is way more complex than
we initially thought was necessary, trying to describe nearly
everything addressable in the system instead of just the
internal memory map.  I suspect the software to attain
(IMHO the useless) goal of a single binary for multiple
boards will create exponentially complex software,
something that highly reliable embedded systems
are trying to avoid.

> I.e. create a generic "board-controller" device node, and put a
> suitable "compatible" property in there, so the right board controller
> driver can be chosen based on it. Having the address of the controller
> in there helps too, especially if there are two boards out there with
> the same controller but at different memory location.

What value does this provide to my client trying
to create a cost effective wireless home networking
device?  It certainly doesn't make the board port
from hell any easier, since cramming the software
into 4M of flash will likely cause the choice of a
processor other than PowerPC that can configure
a smaller kernel and use a tiny custom piece of
boot code.  Highly configurable development/evaluation
boards running a single binary aren't high volume
products, and the additional resources required
by such software could ensure real products aren't
developed with PPCs.  We need to be sensitive
to this.

Thanks.

	-- Dan
