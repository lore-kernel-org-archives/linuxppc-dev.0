Date: Sun, 26 Mar 2000 22:30:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound split
In-Reply-To: <20000324201650.D351@sirizidl.dialin.rrze.uni-erlangen.de>
Message-ID: <Pine.LNX.4.05.10003262222030.3263-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Richard Zidlicky wrote:
> found the bug that caused jerky play with the splitted driver (did you get
> my PM with the bug description??).
>
> The problem is with sq_setup() or its invocation, with the default 32K
> buffer size sq_setup gets called with a bufSize argument of 32  !!
> So it sets write_sq accordingly and little surprise - a buffer size of 32
> bytes is not enough for smooth playing.
> It appears as this bug would affect all architectures.

Thanks a lot!

I incorporated your driver for the Q40 and made a new release.

Changes:

  - Add support for Q40 (from Richard Zidlicky). The driver now consists of 5
    pieces:

       o dmasound_core: machine-independent stuff
       o dmasound_atari: support for Atari TT and Falcon [m68k]
       o dmasound_awacs: support for PowerMac Awacs/Burgundy [ppc]
       o dmasound_paula: support for Amiga Paula [m68k/ppc]
       o dmasound_q40: support for Q40

  - Disable sound on PowerBook when dmasound is not compiled in (triggered by a
    report from Michel Lanners).
  - Use the new module_{init,exit}() scheme, so dmasound_init() no longer has
    to be called in drivers/char/mem.c (triggered by a report from Iain
    Sandoe).
  - Removed unused DMASND_* definitions.
  - All buffer sizes are in bytes now, except for {read,write}BufSize and
    {MIN,MAX}_BUFSIZE, which are in KB (fixes bug reported by Richard
    Zidlicky).
  - Declared more small static functions inline.
  - Clean up of #include lists.
  - Remove dmasound_active, since it's not necessary (was never set anyway).
  - Many small clean ups.

Caveats:

  - Only dmasound_paula was tested on Amiga under Linux/m68k, using a modular
    configuration. I did compile the other drivers (also dmasound_paula under
    Linux/PPC). Dmasound_q40 did not compile due to the lack of some Q40
    specific definitions in the current Linux/m68k tree.

  - Builtin behavior has not been tested yet! Since the rest of the sound
    system is initialized using module_init() as well, correct operation
    depends on correct link order in drivers/sound/Makefile. Please let us know
    whether it works.

  - I forgot to move everything to drivers/sound/dmasound/. Since it's already
    late (BTW, I hate switching to DST!), I prefer to send out this patch
    first. Of course patches are welcomed :-)

Patches:

  - Against Linus' 2.3.99-pre3:

    http://home.tvd.be/cr26864/Patches/dmasound-v2.diff.gz

  - Against my previous release + patch:

    http://home.tvd.be/cr26864/Patches/dmasound-v1pl1-v2.diff.gz

Thank you very much for testing it on all supported platforms[*]!
If everything works fine, I'll send it to Linus for inclusion in 2.4.0.

Enjoy!

Gr{oetje,eeting}s,

						Geert

[*] I'm aware that Linux/m68k 2.3.x is broken on Atari, so I don't insist on
    reports for dmasound_atari :-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
