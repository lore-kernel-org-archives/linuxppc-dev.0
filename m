Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 3CB06DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 13:15:07 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so10228nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Nov 2007 18:15:06 -0800 (PST)
Message-ID: <9e4733910711071815x344319ebye89168320dd53c0@mail.gmail.com>
Date: Wed, 7 Nov 2007 21:15:04 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <473258B8.4060905@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
	<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>
	<473258B8.4060905@genesi-usa.com>
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

On 11/7/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Jon Smirl wrote:
> > I'm not in favor of all these fsl prefixes. These chip families do get
> > sold. What would we have done with intel,pxa320 all over the place
> > when they sold it to marvell? mass changes to marvell,pxa320?
>
> That's the idea, and there'd be a compatible entry for intel,pxa320.

The vendor part really isn't needed and it is going to be a source of
trouble. The vendors are smart enough not to create two chips with the
same part number. Adding a vendor qualifier complicates things
needlessly.

>
> Actually the spec says you should use the stock ticker (IBM, FSL, INTC,
> JAVA, MRVL) if they have one and if not, the company name in lower case.
>
> Freescale are a funny one because they used to have a stock ticker as
> MOT and then FSL but now they're privately owned, so it's gonna have to
> be lower case :]

Another example of how these vendor prefixes can change. The chip
numbers are never going to change. Just use them and drop these vendor
prefixes.


> It's just to separate out the fact that sometimes you get chips with
> very similar or identical names, or to mark out vendor-specific

You don't get chips with identical names. If they had identical names
you couldn't order them from a distributor. Similar yes, identical no.

> functionality. fsl,has-wdt differs from has-wdt ideally because

This one I can buy, but it should be fsl-has-wdt. Drop the vendor prefixes.

> Freescale watchdog timers aren't the same as other watchdog timers -
> the term is pretty pliable, Freescale's GPT on the MPC52xx isn't
> always a watchdog (it can be a normal, non-watchdog timer too..)
>
> > The mpc/pxa parts numbers don't get changes when chip families get sold.
>
> There is a case that between selling chips, some of them get updated
> or bug fixed, and you can tell which one you have by the name.

You can always tell which one you have. The vendors add suffixes to
the part numbers so that you can identify the steppings.

>
> There has to be some standardization on the first implementation of
> the device tree for the chip, otherwise the chopping and changing
> gets rather tedious.
>
> I'm sure you can see why we don't release firmware updates every time
> some Linux guy changes some lousy, hacky tree definition for yet another
> 6 times a year, until it finally stabilizes and the product is usually
> discontinued anyway :D

That's life in the Linux world, no backwards binary compatibility. I'm
in favor of the model since we can fix things until with get the right
instead of piling hacks upon hacks trying to keep ancient, broken
interfaces working (I used to work on the Windows kernel. it is major
ugly).

> However in the current situation it just means you need to flash new
> FDT blobs to your U-Boots which are more clean, and keep your kernel
> in sync, because Linux only handles what it currently thinks is the
> standard.
>
> The real loser is the real Open Firmware implementation, but nobody
> seems to think about that, the device trees on OF devices get more
> cluttered.

Open Firmware lost when it initially came out closed source and people
charged for it. uBoot/redboot/etc took the market because they were
open and free. If Open Firmware had been a free implementation from
day one things would have ended up differently.


-- 
Jon Smirl
jonsmirl@gmail.com
