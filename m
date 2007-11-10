Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02B71DDE9D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 01:07:03 +1100 (EST)
Message-ID: <4735BB95.1080800@genesi-usa.com>
Date: Sat, 10 Nov 2007 14:09:25 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>		<4732396D.4040904@genesi-usa.com>		<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>		<473258B8.4060905@genesi-usa.com>		<9e4733910711071815x344319ebye89168320dd53c0@mail.gmail.com>		<47333939.6050106@freescale.com>	<9e4733910711080904h7d0dfb90o61d15d0326aedbf9@mail.gmail.com>
	<47336805.4040807@genesi-usa.com> <47336A38.1020807@freescale.com>
In-Reply-To: <47336A38.1020807@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> Matt Sealey wrote:
> 
>> this is a ridiculous
>> amount of specificity in a device tree, 
> 
> Except that some of that information _is_ specified elsewhere in other properties.  Speed, for example.

Which is fine..

>> and it also does not match the
>> datasheet (MPC7448 is the name of the chip).
> 
> Because the data sheets are _soooo_ reliable. :-)

Be careful or I'll start looking for the datasheets with your name on it :)

>> Indeed, so.. at some point we should all sit down and hammer out the
>> major issues in describing something like the MPC5121E because right
>> now Genesi has a vested interest in that.
> 
> You understand that _that_ is being worked on as we, er, speak?

Yeah I've seen it, recognise your name from the top of the device tree
definition, and I must say, it's not the most ideal...

>> If we could all agree on how it should be mapped out, with an example
>> tree which shows *every damn thing available* so platform developers
>> can pick and choose and OF developers can use it as a reference, it
>> would make a much happier process.
> 
> Right.  It's being nailed down, but it is a slow, community process...

Why? Freescale's chip, open standards, just design it right, and tell
the community they should be conforming with it.

The slow community process would have had the Efika come out this
month instead of this time last year if we had waited to fix the
device tree to "the right way to do it".

The device tree, hardware description in general, is down to the
silicon vendor and ODM, and should provide description of the
hardware which allows any driver (not just the ones in the BSP)
to get enough information from the tree where necessary.

I don't see that in the MPC5200 tree and I still don't see it in
the examples of the MPC5121E tree.

I also note the few users of the MPC5121E that there are outside
of Freescale, aren't involved (ahem) in this process unless they
join these mailing lists. You can't discuss anything on here with
that chip, it's locked down by NDA, release date tenuous, feature
state tenuous.. documentation is in draft/preliminary and nobody
else has it.

>> By the way while I was poking around the tree today I noticed that
>> there is a PCI errata fixup handled by a Kconfig in there. Why?
> 
> Happens occasionally.  And other places as well.
> 
>> Surely
>> this is something you check the PVR/SVR for and switch on that for
>> a runtime solution, 
> 
> That's not always fine-grained enough to base a decision on it.

It is in this case isn't it? The errata states that it only appears
on that particular revision.

>> and not trick users with the possibility of
>> forgetting to enable some obscure "PCI errata fix" configuration
>> item? (CONFIG_PPC_MPC5200_BUGFIX)
> 
> It should be in the defconfig. :-)

It shouldn't be a configuration option at all in my opinion :)

You either fix the bug or you don't, if you have to fix it in a
generic, multi-chip (5200/5200B) API like the PCI stuff, it
should be handled on a if/else basis. There's practically no benefit
to having it as a configuration option and being able to compile
it out, in fact.. it rather makes the whole presence of the fix
more complicated (to support 5200 and 5200B you need to compile
in the fix, and that means 5200B chips are implementing it when
they don't need to - and you need to recompile to fix it).

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
