Return-Path: <jinjiu99@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 5C94767B54
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 00:37:28 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so1662549pyc
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 07:37:26 -0700 (PDT)
Message-ID: <d824fc380609300737v1c7c8e67l7325867fb28efc04@mail.gmail.com>
Date: Sat, 30 Sep 2006 09:37:25 -0500
From: "Jin Jiu" <jinjiu99@gmail.com>
To: dan@embeddedalley.com
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support --and device tree in
	general
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have been doing linuxppc porting for quite a couple years, though
rarely email here.

the flat-device-tree, copied from a server/workstation-alike
openfirmware concept, is doing more harm than good to freescale's
powerpc chips. IMHO.

embedded products are about customization, efficiency, and cost. it
will never be standardized on low-level(e.g. u-boot-kernel-interface)
like a server/workstation does, as there are hundreds, if not
thousands different applications. plus we don't need the
_unnecessary_over_complexity_ from the device tree(e.g., the bd_t is
not perfect, but simple enough and it works!). the one binary runs on
various platform idea is not that appealing at all. i do not want to
make one pair of shoe and fit all.

i, for one, now begin to use mips for my projects. the current
embedded linuxppc direction really confused me, and it makes simple
thing so complicated to say the least(ppc->powerpc,
openfirmware-alike-flat-dev-tree...).

again, it's my personal opinion.

Jinjiu

On Sep 27, 2006, at 12:22 PM, Olof Johansson wrote:


>> Yes, also called "board port hell".


I tend to think people skilled to do a board port
will still create something elegant and functional
given whatever the existing model.


>> ....   So you can boot the same kernel binary on
>> several boards, as long as the drivers are built in and the correct
>> device tree is used. Has everyone missed/forgotten that objective
>> completely?


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


>> The device tree describes the system, not how to program it. I think
>> that's where the confusion might be.


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
against the Freescale coding machine  :-)

Now, we have something that is way more complex than
we initially thought was necessary, trying to describe nearly
everything addressable in the system instead of just the
internal memory map.  I suspect the software to attain
(IMHO the useless) goal of a single binary for multiple
boards will create exponentially complex software,
something that highly reliable embedded systems
are trying to avoid.


>> I.e. create a generic "board-controller" device node, and put a
>> suitable "compatible" property in there, so the right board controller
>> driver can be chosen based on it. Having the address of the controller
>> in there helps too, especially if there are two boards out there with
>> the same controller but at different memory location.


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
