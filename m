Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D09BBDDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 22:49:35 +1100 (EST)
In-Reply-To: <20070227034541.GD1861@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
	<20070227023243.GC1861@localhost.localdomain>
	<0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
	<20070227034541.GD1861@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e974c705d1088b60aa021856b8fb95a6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Tue, 27 Feb 2007 12:49:26 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Segher, think for a moment instead of just arguing.

I do that already, thank you.  I just don't look at
the problem from the same angle as you it seems.

> There just isn't
> enough information available for the kernel to do sanity checking when
> there is an apparently valid 'interrupts' property.  Consider:

It can't do a 100% job (of course; if it could it wouldn't
need a device tree at all since it would be omniscient), but
it still can do quite a reasonable job.

> Interrupt controllers are generally initialized with all interrupts
> masked (yes, not always, but usually).

Yes, and one of the first things I do when debugging interrupt
stuff is this turn all interrupts on since this makes debugging
much much easier.

> So, if a client mistakenly
> believes a device has no interrupts, those interrupts will never be
> configured, and the CPU will never see those interrupts.  This is only
> going to cause a problem if there is an active driver which is
> expecting interrupts.  But if there's a driver expecting interrupts,
> it must at some point earlier have attempted to configure the
> interrupts (if the client is the kernel, that's a request_irq()).  In
> order to configure the interrupt, it would have parsed the device tree
> to find data about the interrupt.  In doing so it would have run into
> the lack of 'interrupts' property.

Yes, give or take some details / ordering of events.

> There's a good chance at this point it will just print an error saying
> "Huh? Where's my interrupt" and abort driver initialization.  If it
> doesn't do that, it's very likely it will immediately crash attempting
> to dereference or parse the non-existant property.

That would be a plain simple bug.

> Either way, the
> problem shows up at the point we're attempting to parse the interrupt
> tree, and will be pretty easy to debug.

Arguably the whole interrupt tree should be parsed at kernel
start, not at request_irq() time.

And this isn't the end of the story; the kernel won't say
"huh where's my IRQ" but it will try a few more options
first (at least on PCI, it can be true on other buses as
well in principle) and quite likely it will return some
bad number.

> Now, a different case.  Suppose we're using the 'interrupts' /
> 'interrupt-parents' approach.  We have a board with two identical
> interrupt controllers, cascaded.  It has a network device with two
> interrupts, the first is end-of-packet and is routed to the top-level
> IC, the second signals a fairly rare error condition and is routed to
> the cascaded IC.  The network device sits under a bridge which has a
> single interrupt routed to the primary IC (and thus has an
> 'interrupt-parent' property).  So, to an old-style parser it looks
> like the network device has two interrupts on the primary controller,
> routed via the bridge.
>
> When the network driver initializes, it requests its irqs, correctly
> configures the first, and misconfigures the second (because it follows
> the interrupt tree old-style and assumes they're all routed to the
> primary IC).

And very likely ends up with a conflict on that second interrupt
since some other device uses it as well.  Stuff will complain
at initialisation time still and all is fine.

> It sends and receives packets fine, then the error
> condition happens, but the recovery ISR is never called and the
> network suddenly stops at some random time after startup.  Programmer,
> baffled, tries half-a-dozen theories before noticing the error status
> bit and going "but why didn't we get an interrupt?".

That would be the programmer who programmed the device tree
(unless he doesn't test his work) so I can't see why he would
be baffled.

Also this is why I like to have all interrupts enabled
on all controllers, you notice the bunch you forgot
about.  If the argument for doing the opposite is "but
it gets really noisy if some unclaimed interrupts happen",
well, that is a very serious bug, right?  Just like you
don't want random DMAs happen, you don't want random
interrupts flying around either.

> Or suppose the second interrupt signals a (fairly unimportant) status
> change, level-sensitive.  The network driver works just fine.  Then
> along comes another driver that shares an interrupt with the second
> network driver interrupt.

It cannot share that interrupt unless the network driver (and
the other device's driver) say it can be shared.  And they
should not, it's level triggered after all.

> It crashes with an unhandled interrupt on
> startup if-and-only-if the network driver has had a status change
> event before the second driver started.  This is common on some
> networks and rare on others.  Bafflement all around...
>
> Or for that matter, the network driver could crash with an unhandled
> interrupt when the device which is really using what the network
> driver thinks is its second irq, generates an interrupt.  When that
> happens could depend on that other device, its driver, the board
> configuration, then network or other external environment...

Yeah, funky interrupt problems are a bitch to resolve,
aren't they.  But the interrupt can't be shared so this
case cannot happen either.

> And those are just the first 3 recipes for utter confusion I can come
> up.

Oh, I can think of many more, and I've seen most of them.

Now back to the meat of the matter:

Whenever you're writing a device tree, after every small
change to the tree you should check it for validity (by
hand or some checking tool), and see if it works on all
kernel versions you claim to support too (not quite the
same thing, heh).  If things go wrong you know what change
caused it.

Some other developer (who didn't change the device tree)
can't run into problems, unless he uses an unsupported
kernel version.  That's his own fault :-)

And, lastly, the most important point that you conveniently
snipped off on your reply:

>> Anyway, it's all a question of deployment: you just
>> have to make sure your users use a new enough kernel
>> with your device tree (and device), which you have
>> to do *anyway*.  Also DTS files are still conveniently
>> shipped with the kernel so it's even less of a problem.

If you care about compatibility to random kernel versions
instead, you'd better not do surgery on the interrupt
mapping binding at all but just put an extra interrupt
nexus in your device tree.


Segher
