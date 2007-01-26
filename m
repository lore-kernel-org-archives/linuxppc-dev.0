Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF132DE43D
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:49:03 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ejphvfho.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<20070126171928.GA22275@colo.lackof.org>
	<m1ejphvfho.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 09:48:47 +1100
Message-Id: <1169851728.24996.194.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I think this is the only viable aproach to support MSI migration.
> > Basing the "virq" value on bits in the addr/data pair can't migrate.
> 
> Thus my initial surprise at people not liking create_irq().

The main reason _I_ don't like it is because I think I have something
better already :-) And thus I'm annoyed if something else starts
becoming a "generic" API. But I agree on the principle.

I'd be happy to help having the remapping core of arch/powerpc become
generic code though :-)

> If the irq controller the msi arrives at can redirect the irq the
> bits in the msi message could have some connection to the irq number.
> Likewise if some of those bits have nothing to do with migration.
> 
> For irqs going across traces on a motherboard and into interrupt pins
> you can embed a lot of that knowledge into the irq number.  For MSI
> with arbitrary programmable connections the numbers have less meaning
> and less need of meaning in that sense.

Sure, but that is totally local to the backend anyway, and thus pretty
much irrelevant to whether Michael model fits or not as it's totally
agnostic to what your backend choses to put in, or what HW vectors it
uses underneath. That's why I defined alloc() as returning a linux IRQ
number with a pre-initialized irq_desc/irq_chip. That's how the backend
does it's arch specific salad of allocating a linux irq, possibly a
vector too, and picking up the appropriate irq_chip for MSIs.

I don't see how x86 wouldn't fit nicely in that model.

> > Helping Michael make it work would be a constructive way forward.
> > I think Michael has the abstraction correct so it's NOT x86 centric
> > but still works optimally on x86.
> 
> NO NO NO NO Michaels abstraction does not work on x86.
> Which is a big part of the my problem.
> Michaels abstraction does not allow me to migrate irqs on x86.

How so ? It's certainly missing a raw_msi_update() to allow you to
change the addr/data but appart from that, what is the problem ?

> setup_msi_msg only gets called when you enable the msi.  Nothing
> gets called when irqbalaced changes the cpu mask, and there is no
> support that would allow that with Michael's msi ops.

irq_chip->set_affinity() which, along the rest of irq_chip callbacks, is
setup by your backend at alloc() time, and can do what it wants. There
is absolutely no point in doing it differently as the migration mecanism
is totally implementation dependant.

As I said, there is no design problem with the ops, only an small
implementation issue in that it lacks a raw_msi_udpate() to let you
udpate the addr/data from within your set_affinity() callback.

> I can't use Michaels msi_ops as they stand.

You can use the ops, you just need a few more helpers that aren't there
yet because we haven't needed them yet on powerpc.

> They also have the problem of trying to exist at two different levels
> of the interrupt hierarchy setup hierarchy simultaneously which is
> another part of the problem.

I don't understand the above.

> Micaheal's code is simple beautiful and doesn't work on x86, because
> he has not implemented what needs to be there.

We certainly haven't implemented everything that is needed for x86, that
is true, and that is why we aren't aiming at replacing x86 code just
yet, but again, I don't see what in the -model- prevents that and what
prevents x86 from fitting nicely in the model.
 
> That is why I have asked for an evolutionary approach and not this
> stupid drop and replace attempt.

Because while I think our model can fit x86 nicely, the current code
doesn't fit out needs at all and I strongly beleive it's the wrong
abstraction.

> Sorry for the rant I'm just a little annoyed that you hadn't hurd that
> what Micahel is doing does not work on x86.

It does not work out of the box, but you haven't yet convinced me that
there is anything fundamental in Michael's design that prevents it from
working.

Ben.
