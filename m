Date: Wed, 7 Jun 2000 09:59:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: schmitz@opal.biophys.uni-duesseldorf.de, nicoya@apia.dhs.org,
        drow@false.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <200006062158.XAA00842@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.05.10006070957160.26785-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Jun 2000, Michel Lanners wrote:
> On   6 Jun, this message from Michael Schmitz echoed through cyberspace:
> >> Anyways, that's the long answer. The short answer is: no, you probably
> >> don't want to cache the framebuffer.
> >
> > Thanks for the long answer, and all those nasty gremlins have actually
> > been observed long time ago when people started to play with the
> > framebuffer drivers. At least on m68k, the framebuffer address space was
> > set non-cacheable right from the start (in head.S). I would hope that
> > somehow translated to PPC as well :-)
>
> That's what fbmem.c does in its default mmap(). However, at least for
> control (and maybe other comparable video implementations as well), you
> get much better performance on scroll and other fb-to-fb copy
> operations, without visible inconvenients, when the framebuffer is set
> to write-through caching.

| $ grep ioremap drivers/video/amifb.c
| 	videomemory = (u_long)ioremap_writethrough(videomemory_phys, videomemorysize);

It does mean that if the accel engine draws something, and the CPU wants to
chnge that, that there may be a cache incoherency. For amifb that doesn't
matter since it's unaccelerated.

Summarized: use write-through cachine for unaccelerated hardware, no caching
for accelerated hardware.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
