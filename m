Date: Thu, 20 Jun 2002 14:39:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Message-ID: <20020620213925.GH16052@opus.bloom.county>
References: <20020620203455.GG16052@opus.bloom.county> <3D124351.1020800@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D124351.1020800@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 05:04:17PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >The first benefit of all of these changes is that it gets PCI working on
> >MBX (and any other 8xx system with PCI).
>
> No, it doesn't.  It just enables the 8259 to kinda work.  The PCI on MBX
> does not work well, and this does nothing to improve it.  Does anyone have
> a working MBX anymore?

Yes, Andy who did that part of the code and claims that PCI does indeed
work on it.

> >Comments?
>
> There is more to these patches than just the interrupt change.  Why is
> the CPM microcode, and so much of commproc.c changed?

I think I forgot to strip out a few things.  And so much of commproc.c
changed because the interrupt handling/assignment stuffs changed.  Aside
from the !CONFIG_UCODE_PATCH changes (which are seperate, I'll do those
later..) the rest is related to the changes themselves, or are updating
the callers to the new mechanisms (The old ones do still work and infact
did most of my testing that way).

> Of course, I don't like it, but oh well.......It's just another hack that
> doesn't do anything different.  Most importantly, I hate shit like this:
>
> 	request_irq(CPM_IRQ_OFFSET + CPMVEC_SMC2, ......
>
> because you have to program the CPM with only the CPM vector number, not the
> vector plus offset.

I don't follow you here.  Is this just another complaint about how the
normal way of handling cascades is ugly?

> I want a real cascaded interrupt design, not just
> another
> hack that opens the possibility to calling a generic PC function with the
> wrong parameters.

If a 'generic PC function' calls with the wrong parameters, fix the
function.  Right now we happily panic() on all of the correctly written
drivers as well as the broken ones.  This makes it possible to actually
test drivers to see which ones are broken and fix them.

> The OpenPIC/EPIC are hacked just as badly, and there are
> new integrated controllers coming that would benefit from a real design
> improvement instead of just another hack.

Perhaps sometime later in 2.5 a 'real design improvement' will happen.
But I also don't see what that has to do with this, other than the
8xx/8260 way of doing things is going.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
