Date: Sat, 3 Jul 2004 19:41:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stef Simoens <stefaan.simoens@coditel.net>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040704024149.GB2146@smtp.west.cox.net>
References: <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40E75DC7.7070601@coditel.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 03:30:47AM +0200, Stef Simoens wrote:

> Olaf Hering wrote:
>
> > On Tue, Jun 15, Tom Rini wrote:
> >
> >
> >>And yes, passing -many does work on all older supported versions of
> >>binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> >>done with it now (and for future fixes of this sort).
> >
> >
> >gcc 3.2 passes only -mppc, so all altive instructions will fail to
> >compile without either -many or -maltivec
>
> Are there altivec instructions when CONFIG_ALTIVEC is not set?

Yes.  And I can forsee in the future were we might have BookE specific
ones in the same situation.

> > ifdef CONFIG_4xx
> > EXTRA_AFLAGS		:= -Wa,-m405
> > endif
> >+ifdef CONFIG_6xx
> >+EXTRA_AFLAGS		:= -Wa,-maltivec
> >+endif
> > ifdef CONFIG_E500
> > EXTRA_AFLAGS		:= -Wa,-me500
> > endif
>
> So, shouldn't this be "ifdef CONFIG_ALTIVEC" ?

No, it should be always -Wa,-many.  The kernel has, and almost certainly
will, continue to put AltiVec, or BookE, or whatever, instructions in
code that will be compiled for, and run on, CPUs that can't use the
instructions (we nop them out at runtime).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
