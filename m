Date: Wed, 3 Jan 2001 23:51:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chris Boot <bootc@worldnet.fr>
cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes in the Valkyrie driver from 2.1.24 to 2.2.18
In-Reply-To: <B6796554.7E88%bootc@worldnet.fr>
Message-ID: <Pine.LNX.4.05.10101032349350.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 Jan 2001, Chris Boot wrote:
> It has struck me, after weeks of research, that my problems in booting my
> 5400/180 cold through OpenFirmware are caused by changes in the Linux
> kernel.  This machine uses the Valkyrie display device, and in 2.1.24 this
> is handled by directly accessing its memory, whereas in 2.2.18 it is
> accessed through OpenFirmware.  OpenFirmware is known to choke on this
> machine when using the display (as in CLAIM failed).
>
> My suspicions were aroused when, after disabling CONFIG_FB, the machine
> booted cold without any problems whatsoever.
>
> Is it at all possible to use Valkyrie without going through OpenFirmware at
> all?  It is not selectable if I disable CONFIG_FB_OF.  Would it be possible
> to port the older non-OF driver to the newer kernel?  What are the
> disadvantages of using the older memory-based driver to the newer OF-based
> driver?

Have you tried 2.4.0-testX yet?

In 2.4.0-testX, valkyriefb is initialized without the help of offb.
I don't have a 2.2.18 tree at hand, but you can probably use a similar method
in 2.2.18 with some hacking (call valkyriefb_init() from drivers/video/fbmem.c,
and not offb_init()).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
