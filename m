Date: Thu, 4 Jan 2001 12:51:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems when recompiling dmasound modules
In-Reply-To: <200101040956.JAA16492@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.05.10101041250340.665-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Jan 2001, Iain Sandoe wrote:
> > Whenever I rebuild my linux-pmac-devel tree when the kernel version changed I
> > get bitten by this:
> > The sound modules don't get rebuilt so their version doesn't match the kernel
> > version and they can't be insmoded.
> > I can investigate to find a solution myself but I figured it should be easier
> > for Geert or one of the other dmasound hackers to fix it.
>
> I just did (after an absence of nearly six months ;-) :
>
> rsync ppc.samba.og::linux-pmac-devel - which picked up 2.4.0-t13-p3
> make mrproper
> make menuconfig (selected, amongst other things, sound card support built
> in, pmac sound as module)
> make dep vmlinux modules modules_install
>   - I saw it compile the damsound_core, dmasound_awacs
> copied the kernel to my MacOS partition...
> rebooted
> modprobe dmasound_awacs
>
> and viola!
> it seemed to work as before...
>
> (so maybe that wasn't what you were saying at all ;-)

Real men don't have the time to do `make mrproper' and `make menuconfig' every
time the kernel changed, so they rely on `make oldconfig' and `make dep'
instead...

Sorry Michel, no clue...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
