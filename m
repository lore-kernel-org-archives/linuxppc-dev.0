Date: Wed, 22 Dec 1999 20:37:25 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Update - Re: Open Sourced Glide on Linux PPC
In-Reply-To: <Pine.LNX.4.21.9912181510001.9036-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.05.9912222035500.574-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 18 Dec 1999, Kostas Gewrgiou wrote:
> On Fri, 17 Dec 1999, Jens Ch. Restemeier wrote:
> > - Glide compiles, after disabling the assembler triangle setup code.
> > >From the documentation I think that P6FENCE should avoid instruction
> > reordering between I/O accesses. From the information here I think 
> > eieio (sp?) it the PPC instruction to use.
> 
>   Yes if you look at the macos defines you see that they use eieio there
> they seem to do lots of read/writes without ever doing an eieio but since
> it is working in macos i am not too worried.

If you use the *mb() macros instead of eieio(), you don't have to use #ifdefs
and it'll work automagically on e.g. Alpha as well.

> > - Problems: E - N - D - I - A - N. sigh... /dev/3dfx returns several
> > values through a memory buffer. Guess... That's currently the point
> > where glide fails.
> 
>   They do all memory access through the GETxx SETxx defines you can 
> do the byteswapping there, the linux specific code doesn't use this 
> though so you'll have to change this too.

Use read*()/write*() for all accesses to PCI memory space, as per
linux/Documentation/IO-mapping.txt.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
