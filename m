Date: Sun, 4 Jul 2004 10:32:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Stef Simoens <stefaan.simoens@coditel.net>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] fix missing option in binutils version check
In-Reply-To: <20040704024149.GB2146@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be>
References: <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de>
 <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net>
 <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net>
 <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net>
 <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net>
 <20040704024149.GB2146@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Jul 2004, Tom Rini wrote:
> On Sun, Jul 04, 2004 at 03:30:47AM +0200, Stef Simoens wrote:
> > Olaf Hering wrote:
> > > On Tue, Jun 15, Tom Rini wrote:
> > >>And yes, passing -many does work on all older supported versions of
> > >>binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> > >>done with it now (and for future fixes of this sort).
> > >
> > >gcc 3.2 passes only -mppc, so all altive instructions will fail to
> > >compile without either -many or -maltivec
> >
> > Are there altivec instructions when CONFIG_ALTIVEC is not set?
>
> Yes.  And I can forsee in the future were we might have BookE specific
> ones in the same situation.

Perhaps it makes sense to add a directive to the assembler to switch on the
fly, cfr. the `.chip' directive on m68k? E.g. using

    .chip 68040

we switch to 68040 mode, and using

    .chip 68k

we switch back to generic mode. That way we can have instructions for different
CPU types in the same kernel, while the assembler still checks the validity
depending on the selected CPU type.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
