Date: Wed, 29 May 2002 07:36:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Hymod board support and related changes ...
Message-ID: <20020529143628.GK5997@opus.bloom.county>
References: <20020528201957.GB5997@opus.bloom.county> <23587.1022638036@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23587.1022638036@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 12:07:16PM +1000, Murray Jensen wrote:
>
> On Tue, 28 May 2002 13:19:57 -0700, Tom Rini <trini@kernel.crashing.org> writes:
> >On Tue, May 28, 2002 at 01:18:10PM -0700, Tom Rini wrote:
> >>
> >> On Tue, May 28, 2002 at 03:48:35PM +1000, Murray Jensen wrote:
> >>
> >> > - Hymod board support
> >>
> >> For the m8260_gorom() call, try using spin_lock_irqsave() instead of
> >> save_flags();cli() ... restore_flags();
> >
> >Nevermind, spoke too soon here.  But did you really need to add in what
> >you did or is it just a cleanup?
>
> I needed to add it. When I executed a "halt" on my Hymod board, at the point
> where it jumped to the ROM (in my case, this is ppcboot) things went crazy -
> it caught an exception and tried to print a message on the console, but it was
> really wierd, with only a few of the characters legible, others being
> substituted with wierd umlauts or punctuation etc. I couln't see any pattern,
> but when I turned off interrupts before executing the "gorom" function it
> stopped. Note that this only started happening recently, so something changed
> somewhere else which caused this problem.

Well, this is also at powerdown, yes?  Or can we actually power off the
board with the gorom call, rather than just exit Linux?  If so,
nevermind..

> Maybe the proper fix is for "gorom" to ensure interrupts are disabled? Cheers!

Nah.  It's an 8260-specific function, so I don't think it matters, so
why not just do it from the caller..  With a comment above that reminds
people grep'ing around that we're about to powerdown so it's OK to do
the save_flags();cli(); ... restore_flags();

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
