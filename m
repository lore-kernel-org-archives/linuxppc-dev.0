From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel D?nzer <daenzerm@student.ethz.ch>
Subject: Re: newer xfree86 4.0.1 patches
Date: Thu, 7 Sep 2000 23:55:17 +0200
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org, linux-apus-devel@lists.sourceforge.net
References: <Pine.LNX.4.10.10009071853430.461-100000@cassiopeia.home>
In-Reply-To: <Pine.LNX.4.10.10009071853430.461-100000@cassiopeia.home>
MIME-Version: 1.0
Message-Id: <00090723551703.31531@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 07 Sep 2000, Geert Uytterhoeven wrote:
> On Thu, 7 Sep 2000, Michel [iso-8859-1] Dänzer wrote:
> > Franz Sirl wrote:
> > > I'm not quite sure about the following:
> > >
> > > - does Apus have it's own keycodes?
> >
> > Yes, I think so. At least we need our own keymaps.
> >
> > > If not, do you currently use ADB or AT keycodes?
> > > - what's the keycode situation in XF3/4 for Apus?
> >
> > AFAIK it isn't very clean with either, the best bet is still to disable
> > Xkb.
>
> And Franz also wrote:
> | My xf4 work I did for the linux keycodes support fixes that. It's a
> | configurable option now (well, in 4.0.2 I hope). XkbModel "macintosh_old"
> | or XkbKeycodes "macintosh" for ADB keycodes/MEDIUMRAW mode, everything
> | else
>
>
> ^^^^^^^^^^^^^^^
>
> | is Linux keycodes/RAW mode, or, if it can open the sysctl
>
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> | /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes, it tries to
> | autodetect. This will make PReP and CHRP users with PS2 keyboards happy I
> | hope :-).
>
> APUS uses Amiga keyboards. There are lots of other machines who use their
> own keymaps as well. If I only consider Linux/m68k, we have Atari, Sun-3,
> Apollo, HP9000/[34]00, ...
>
> I can't speak about XF4, but with XF3 all of these work out-of-the-box if
> you disable Xkb (using kernel keycodes). If you enable Xkb, it also works,
> but then you need the special X keymaps (for those that are available) (no
> surprise).
>
> And I'd say `everything else works fine if you use _MEDIUMRAW_ instead of
> RAW'.

Nope, you need to compile xf3/4 with ASSUME_CUSTOM_KEYCODES undefined _and_
use RAW keyboard mode, otherwise it won't work correctly for some keys and
XKB. Tested that on PC and PMac, cause I wanted to be sure that my xf4 patch
is as short as possible.

> > > If you want to keep the current state of affairs I can see in the
> > > linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On
> > > the other hand, if you plan to integrate your input drivers into 2.4,
> > > it makes perfect sense.
> >
> > I think it would be nice, but to be honest I don't fully understand what
> > would be involved.
>
> I hope this is _not_ about translating whatever-keyboard-type-keycodes to
> PC-style keycodes? We (ehrm, I) already opened that can of worms somewhere
> in 1995, and closed it ASAP.

Nope, Linux keycodes are linear keycodes from 0-511 (see
include/linux/input.h for a list), the range 1-127 is mostly PC compatible
though. Unfortunately NR_KEYS will probably not get bumped in 2.4, so
currently I have to map 5 keys back below 128.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
