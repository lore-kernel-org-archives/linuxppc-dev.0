Date: Tue, 7 Mar 2000 21:50:43 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: dmasound split
Message-ID: <Pine.LNX.4.05.10003072104330.484-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is my first test release for splitting the DMA sound driver in different
parts:

  - dmasound_core: machine independent code
  - dmasound_atari: Atari TT and Falcon code (does it make sense to split this
		    further?)
  - dmasound_awacs: PowerMac `Awacs' code
  - dmasound_paula: Amiga `Paula' code

I also cleant up the code a lot, and made the following changes (let's hope I
don't forget to mention some):

  - Add more machine specific function pointers to the MACHINE struct.
  - Merge the duplicated code for write_sq and read_sq as much as possible.
  - I use lots of #defines to `do {} while (0)' to avoid having too many
    occurrencies of #ifdef HAS_READ_SOUND (for recording).
  - Generate the copy-and-convert routines for Amiga using #defines. As a
    result we now have different routines for ulaw and alaw, which expands the
    object code a bit, but it's less error-prone.
  - Use resource management on Amiga.

The total source code did grow a bit, though. Mainly due to duplicated comments
and include statements in the modules.

Note that this is meant for 2.3.x. I haven't done 2.2.x since a long time.


Tested parts:

  - I only tested the driver for Amiga, as a loadable module. It worked even
    better than the old driver, since it plays all frames now (don't ask me
    why). `cat file > /dev/audio' still hangs at the end, though (killable by
    CTRL-C). (cfr. my previous mail to the linux-m68k list).


Known problems:

  - You can still rmmod the dmasound_{atari,awacs,paula} module while sound is
    playing, causing a crash.


To do:

  - Test it on other platforms.
  - Test recording on PowerMac.
  - Fix the locking issues.
  - Use module_{init,exit}(), conforming to the latest fashion.
  - Clean up, inline more small functions.
  - Disable heartbeat when playing sound on Amiga (heartbeat influences the
    low-pass filter and thus causes distortion).
  - Provide a small module to play with htotal when amifb is not used on Amiga
    (The DMA controller assigns DMA slots to the audio controller per video
    scanline, hence increasing the horizontal sync rate allows higher playback
    rates. Yes, that's what we call `integrated multimedia' :-).


Download:

    http://home.tvd.be/cr26864/Patches/dmasound.readme
    http://home.tvd.be/cr26864/Patches/dmasound.tar.gz


Instructions:

  - Extract dmasound.tar.gz

  - Delete obsolete files:

      rm drivers/sound/dmasound.[ch]

  - Copy new files:

      cp dmasound.h dmasound_* drivers/sound

  - Apply the patch:

      patch -p1 < dmasound.diff

  - Remove all lines containing `DMASOUND' from .config

  - Run `make oldconfig' and compile and install the modules

  - Make sure to remove the old dmasound.o from /lib/modules/<version>/misc/
    if you intend to use `modprobe' instead of `insmod', since `modprobe' may
    decide to load the old module also!

Good luck!! Thanks for your comments and test results!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
