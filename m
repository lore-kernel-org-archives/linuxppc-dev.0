Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D7C5DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 12:01:13 +1100 (EST)
In-Reply-To: <20070228004040.GC11775@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
	<20070227023243.GC1861@localhost.localdomain>
	<0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
	<20070227034541.GD1861@localhost.localdomain>
	<e974c705d1088b60aa021856b8fb95a6@kernel.crashing.org>
	<20070228004040.GC11775@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <293fa602618ce81ba7f80be15684aa4b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Wed, 28 Feb 2007 02:00:42 +0100
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

>> It can't do a 100% job (of course; if it could it wouldn't
>> need a device tree at all since it would be omniscient), but
>> it still can do quite a reasonable job.
>
> Not in at least one common case:  where all interrupt controllers are
> of the same type.

You'll get a lot of collisions in that case, easy to detect.

>> And this isn't the end of the story; the kernel won't say
>> "huh where's my IRQ" but it will try a few more options
>> first (at least on PCI, it can be true on other buses as
>> well in principle) and quite likely it will return some
>> bad number.
>
> Um.. examples?  I can't think of any case except legacy ISA when we'd
> have either reason or method to go beyond the device tree information.

PCI isn't required to have a device tree at all, with the
flat tree.

>> And very likely ends up with a conflict on that second interrupt
>> since some other device uses it as well.  Stuff will complain
>> at initialisation time still and all is fine.
>
> Only if the other driver is present and doesn't allow sharing.

If _either_ doesn't allow sharing, i.e., almost all of
the time.

>> That would be the programmer who programmed the device tree
>> (unless he doesn't test his work) so I can't see why he would
>> be baffled.
>
> Not necessarily.  Maybe the error condition never happens in the
> device tree programmer's network environment.  The driver seems to
> work just fine for him.

Which just means he didn't do a proper job of testing.

> What?  It's perfectly possible to share level triggered interrupts.
> PCI devices do it all the time.

Erm yeah I goofed, sorry :-)

>> Yeah, funky interrupt problems are a bitch to resolve,
>> aren't they.  But the interrupt can't be shared so this
>> case cannot happen either.
>
> Again, yes they can be.

SoC interrupts shared?  Not very likely...
Sure in principle anything can happen.

>> Now back to the meat of the matter:
>>
>> Whenever you're writing a device tree, after every small
>> change to the tree you should check it for validity (by
>> hand or some checking tool), and see if it works on all
>> kernel versions you claim to support too (not quite the
>> same thing, heh).  If things go wrong you know what change
>> caused it.
>
> Ah, yes, every change should be tested in every configuration.  Lovely
> idea, never going to happen.

One device tree == one configuration.  Static
device trees are easy, heh.

>> And, lastly, the most important point that you conveniently
>> snipped off on your reply:
>>
>>>> Anyway, it's all a question of deployment: you just
>>>> have to make sure your users use a new enough kernel
>>>> with your device tree (and device), which you have
>>>> to do *anyway*.  Also DTS files are still conveniently
>>>> shipped with the kernel so it's even less of a problem.
>>
>> If you care about compatibility to random kernel versions
>> instead, you'd better not do surgery on the interrupt
>> mapping binding at all but just put an extra interrupt
>> nexus in your device tree.

It's still sitting here...

We can have a pointless fight over how hard to debug
certain device tree bugs are, but that's not really
important is it.


Segher
