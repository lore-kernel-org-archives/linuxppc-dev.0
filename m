Return-Path: <segher@kernel.crashing.org>
Received: from localhost.localdomain (adsl-63-203-10-66.dsl.lsan03.pacbell.net
	[63.203.10.66]) by ozlabs.org (Postfix) with SMTP id A755A2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:24:56 +1000 (EST)
Received: from [172.20.101.118] by localhost.localdomain for
	<linuxppc-embedded@ozlabs.org>; Tue, 28 Sep 2004 06:22:27 -7GMT
In-Reply-To: <20040927231438.D30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F80E3944-1116-11D9-8370-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 28 Sep 2004 01:23:53 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Cc: David Gardiner <daveg@sonartech.com.au>, linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>> This assumes a world where everything is managed by magic BIOS/OF
>>> initialization. That's not the case for this user's board port.
>>
>> The OS (Linux, specifically) won't do it for you.  It has to be set up
>> beforehand.  Unless "embedded Linux" gets this the wrong way around
>> as well.
>
> This isn't an "embedded Linux" (whatever that is) thing.

That;s why I put quotes around it :-)

> It is a
> non-full-featured firmware thing.  If you take a look at MIPS, ARM,
> SH, PPC embedded platforms you'll see a similar thing. But wait,
> you'll even see interrupt routing tables in the decidedly not embedded
> Alpha architecture. :) Linux does do it, and there is a very clear
> infrastructure for managing routing tables and standard/non-standard
> PCI swizzle mechanisms.

Sure.  But the interrupt _assignment_ should be done by firmware.

>> and b) it is wrong.  On the
>> majority of platforms, you can route any PCI IRQ to any number you 
>> want.
>> The firmware will tell you where it ends up (over PCI config space).

> On commodity platforms that's true. But on just about every single
> dedicated purpose platform (embedded systems), interrupt routing is
> a static board layout/design decision.

And the firmware should still program the final interrupt number
into the PCI device's config space.

> No, it also tells you which pin it is routed to (A-D). That's
> an important piece of information when routing interrupts.

Sure.  The firmware is still *required* by the PCI spec to fill
the IRQ # config space field, though.

> Again, on some platforms, not this one. Let's just agree that
> not everything is a x86/BIOS or ppc64/pmac/OF machine that
> has this done in some blackbox firmware.

Oh, I believe that.  But the firmware should be fixed, not a
terrible hack added to Linux.


Segher

p.s.  And I know this isn't always practically possible; but why
then support a product like that at all, in the Open Source
community?
