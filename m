Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 45372DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 14:14:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so37228wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Nov 2007 19:14:10 -0800 (PST)
Message-ID: <fa686aa40711071914w1e0a483sfc3b1f61010cc667@mail.gmail.com>
Date: Wed, 7 Nov 2007 20:14:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
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
>
> Actually the spec says you should use the stock ticker (IBM, FSL, INTC,
> JAVA, MRVL) if they have one and if not, the company name in lower case.
>
> Freescale are a funny one because they used to have a stock ticker as
> MOT and then FSL but now they're privately owned, so it's gonna have to
> be lower case :]

And really, this doesn't even matter.  So what if 'mot,' --> 'fsl,'
--> 'freescale,'?  Even if an older name is used, it is still
unambiguous and therefore a useful property.

Besides, If you're designing a device tree for a board, and Linux or
some other OS already has support for a similar board, it would be
madness to use property values different from what the OS already uses
just to make the values "more correct".

ie. even if Marvell sells the pxa255 for then next 5 years, it is
still correct to call it an "intel,pxa255".

> It's just to seperate out the fact that sometimes you get chips with
> very similar or identical names, or to mark out vendor-specific
> functionality. fsl,has-wdt differs from has-wdt ideally because
> Freescale watchdog timers aren't the same as other watchdog timers -
> the term is pretty pliable, Freescale's GPT on the MPC52xx isn't
> always a watchdog (it can be a normal, non-watchdog timer too..)
>
> > The mpc/pxa parts numbers don't get changes when chip families get sold.
>
> There is a case that between selling chips, some of them get updated
> or bugfixed, and you can tell which one you have by the name.
>
> There has to be some standardisation on the first implementation of
> the device tree for the chip, otherwise the chopping and changing
> gets rather tedious.
>
> I'm sure you can see why we don't release firmware updates every time
> some Linux guy changes some lousy, hacky tree definition for yet another
> 6 times a year, until it finally stabilises and the product is usually
> discontinued anyway :D

Oh come on; I've hardly changed the mpc5200 bindings at all since we
last talked about them...  :-P   (Totally joking, see comment and
eating-of-crow below).

>
> However in the current situation it just means you need to flash new
> FDT blobs to your U-Boots which are more clean, and keep your kernel
> in sync, because Linux only handles what it currently thinks is the
> standard.
>
> The real loser is the real Open Firmware implementation, but nobody
> seems to think about that, the device trees on OF devices get more
> cluttered..

Not quite true; I personally am now quite loath to changing
conventions without maintaining compatibility with the old.  I also
tend to make the assumption that upgrading the kernel should not
always require a device tree upgrade also.

In other words:
Changing conventions to better match the OF guidelines: possibly a
good thing, especially if it results in more clarity.
 --- but ---
Breaking boards with trees that follow older conventions: Bad!

This is probably a good time for me to apologize for the pain that
I've caused in the past on this issue.  My stance in the past on
designing mpc5200 device trees was wrong headed on a couple of points.
 First, insisting that the Efika device tree should exactly match what
was currently in vogue was wrong.  Second, assuming that it was even
possible to define a 'perfect' and 'exact' mpc5200 device tree binding
was pure hubris.

So, I'm sorry and I apologize.  Experience has taught me better over
the past year.

I'm now of the opinion that device trees are *never* perfect, and
that's not even the point.  The point is that a device tree should
uniquely and unambiguously describe the platform.  If the device tree
isn't quite unambiguous in one aspect, other aspects of the tree will
provide enough information to work around what is lacking.  Every
device driver may have a current-as-of-now idea on what those
properties should look like, but that should not cause platforms with
device trees which differ from that to be punted as unsupportable.

I do not think that means that vendors can put whatever they want into
a device tree without regard to current conventions (at the time of
designing their tree).  Doing so generally causes friction with the
folks who are writing software for it (and I'm not directing this
comment at bPlan either).  But I do think that changing conventions
must always be done with care and without breaking earlier users;
either by modifying the tree at platform setup time or retaining
compatibility with the old property name.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
