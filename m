Date: Fri, 16 May 2003 10:35:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Trevor Woerner <ppc339@vtnet.ca>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: address translation
In-Reply-To: <200305160002.57463.ppc339@vtnet.ca>
Message-ID: <Pine.GSO.4.21.0305161033240.3722-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 May 2003, Trevor Woerner wrote:
> >From a cursory look at the ide.c code, it appears the kernel wants to
> access the ATA registers one byte at a time. Unfortunately, because my
> device is wired directly, I have to access it 16 bits at a time. So it
> looks like I'm going to have to hack the ide.c code (or something like
> it) to combine adjacent registers together before reading/writing.

Which kernel are you using? In 2.4.21-rc2, you can easily override the
hwif->{IN,OUT}B() routines.

> Is it just me, or did the hard drive controllers of the 68k era
> (drivers/ide/legacy/macide.c) have memory-mapped registers? I was
> looking at their code today and it seems similar to what I'm looking
> for (i think).

Yes, on m68k all IDE interfaces are memory mapped (just like any other I/O).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
