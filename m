To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Jens Ch. Restemeier" <jrestemeier@currantbun.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Update - Re: Open Sourced Glide on Linux PPC
References: <Pine.LNX.4.05.9912222035500.574-100000@callisto.of.borg>
Reply-To: weasel@cs.stanford.edu
From: Peter Chang <Peter.Chang@irisa.fr>
Date: 27 Dec 1999 17:50:13 +0100
In-Reply-To: Geert Uytterhoeven's message of "Wed, 22 Dec 1999 20:37:25 +0100 (CET)"
Message-ID: <w9kr9g8mipm.fsf@euclide.irisa.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Sat, 18 Dec 1999, Kostas Gewrgiou wrote:
> > On Fri, 17 Dec 1999, Jens Ch. Restemeier wrote:
> > > - Glide compiles, after disabling the assembler triangle setup code.
> > > >From the documentation I think that P6FENCE should avoid instruction
> > > reordering between I/O accesses. From the information here I think
> > > eieio (sp?) it the PPC instruction to use.
> >
> >   Yes if you look at the macos defines you see that they use eieio there
> > they seem to do lots of read/writes without ever doing an eieio but since
> > it is working in macos i am not too worried.

This sort of depends on teh hw that you're talking to on the other
side. If it is v2 or better then it will take care of doing 'hole
counting' for you so that you don't need explicit fences to make the
hw happy. If you're doing this for sst1 or sst96 then you will need to
do fences so taht the command register on gets written after all of
the command data has been settled.

> If you use the *mb() macros instead of eieio(), you don't have to use #ifdefs
> and it'll work automagically on e.g. Alpha as well.

This I know less about, but these might fence more often than strictly necessary?

\p
---
The most vulnerable and yet most unconquerable of things is human
vanity; nay, through being wounded its strength increases and can grow
to giant proportions. --- Friedrich Nietzsche

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
