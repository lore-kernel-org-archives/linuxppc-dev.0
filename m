Date: Thu, 13 Jul 2000 20:40:31 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <20000712114049.26089@mailhost.mipsys.com>
Message-ID: <Pine.SOL.3.95.1000713200643.25035H-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Benjamin Herrenschmidt wrote:

> >Yes, Lombard 333 MHz standard configuration.
> >
> >I did compile dmasound as module (I noticed that after applyiing your patch,
> >dmasound was unselected in .config - is there a reason for this?).
> >I will test this, though I'm not sure if it's easy to reproduce -
> >if it takes a prolonged time of sleep for the effect to come up...
>
> Did you experience this problem at all with previous kernel ? I'm
> wondering if it would be good to leave the powerbook a bit more time when
> coming out of sleep before turning back on the various parts.
>
Well, I tested a couple of configurations, and it seems to appear with
all varieties of 2.2.17pre10. I tried the following:

  dmasound- and mol-patched kernel with old dmasound module loaded
  ditto                            with sound module unloaded
  ditto                            with dmasound_awacs (+_core) loaded

  mol-patched kernel
  kernel as rsynced from linuxcare.com.au::linux-pmac-benh

The symptoms are basically always the same:
  When trying to wake sleeping PB, disk spins up, but backlight is
  not switched on (in some configurations, especially the first one,
  it powers off right then, but usually it wakes up the first time).
  I could verify that the PowerBook is indeed fully operative at this
  point, apart from the light -- I found out a strong light source placed
  behind the monitor makes a good substitute -- after all, the transparent
  apple on the lid has its practical use!
  It is even possible to do a regular shutdown from there. If you don't,
  and if you put it back to sleep, it immediately switches off when you
  try to awake it once more.
  When this has happened, all boot variables are set back to defaults and
  a few other PRAM settings seem to have been resetted, in particular
  the settings of the F1-12 keys are set back to brightness control etc.
  PRAM does not seem to be zapped completely, though, because my timezone
  e.g. is still set correctly (though the city had once switched to
  Stockholm).
  Trying to boot with yaboot right after resetting the boot vars
  (think I can type "setenv boot-device hd:7,\\ofboot.b" in my
  sleep by now ;-) immediately leads to crash and summary power-off again.
  After booting MacOS, Linux will boot from BootX.

  When I switched back to 2.2.17pre9, convinced that none of the pre10-
  versions would work properly, I seemed to have even worse luck:
  It also crashed with a power-off (booted w/ BootX) twice in a row.
  Ask me why I bothered to try a third time, I hoped I could glimpse at
  some of the xmon messages before it died, but that time it booted,
  and now all is working again -- so far at least, I have brought it
  back from sleep three times, once after several hours, and battery
  discharge is normal.

I can send you the System.map for the 2.2.17pre10 kernel, but since I could
never read much of xmon's output, it's probably of little use.
The startup crashes all seemed to occur at PID 1, swapper.

Another observation I made with the pre10-kernels is that the keys F1-12
seemed to work very badly when I had not set them as function key primary in
MacOS, i.e. when I had to press Fn-F1 etc. to make them function as F1.
I had to hit Cmd-Ctrl-Fn-F1 several times to get back to the first virtual
console.
The brightness regulation with these keys _did_not_work_at_all_ with pre10,
regardless of the setting chosen in MacOS. Of course this would make
clear why there was no chance to bring the display back by turning up
brightness, but I don't know if it is related to the general PMU problems.

Hope this sheds some light on the problem, I'll stay with 2.2.17pre9 for
a while.

Thanks,
								Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
