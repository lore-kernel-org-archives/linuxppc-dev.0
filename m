Message-Id: <5.0.0.19.2.20000908155531.020f1200@mail.munich.netsurf.de>
Date: Fri, 08 Sep 2000 16:31:30 +0200
To: Michel Dänzer <daenzerm@student.ethz.ch>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: newer xfree86 4.0.1 patches
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
In-Reply-To: <39B83F7C.EA7B41FF@student.ethz.ch>
References: <20000906213248.A3749@suse.de>
 <5.0.0.19.2.20000907164805.01f19660@mail.munich.netsurf.de>
 <39B7AFC7.19AF37A1@student.ethz.ch>
 <00090723415902.31531@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 03:23 08.09.00, Michel Dänzer wrote:

>Franz Sirl wrote:
>
> > > > - what's the keycode situation in XF3/4 for Apus?
> > >
> > > AFAIK it isn't very clean with either, the best bet is still to disable
> > > Xkb.
> >
> > On PPC we can switch the keycodes between ADB and Linux with a sysctl.
> Linux
> > keycodes are ~95% compatible with AT keycodes, so XKB will work.
>
>That would be great IMHO.

And easy to do. See below.

> > > > - if your developer repository for 2.4 is different from BK
> > > > linuxppc_2_3, did you integrate your input layer drivers in your trees
> > > > and plan to submit them for 2.4?
> > >
> > > We have a CVS repository at SourceForge. Roman Zippel integrates
> bitkeeper
> > > into it, but unfortunately we don't have anyone for the reverse
> direction.
> > > How could that be done?
> >
> > Via Linus probably, but in this special case we could arrange something.
>
>Please post to linux-apus-devel@lists.sourceforge.net what we'd have to do.

- get yourself the linuxconsole CVS from sourceforge (codename ruby)
- copy ruby/.../input/amikbd.c to apus24tree/.../char/
- copy ruby/.../input/amimouse.c to apus24tree/.../char/
- modify apus24tree/.../char/Config.in and apus24tree/.../char/Makefile in
a way that CONFIG_INPUT_AMIKBD and CONFIG_INPUT_AMIMOUSE replace the
current amikeyb.c and amigamouse.c
- compile & install the kernel, with the following minimum options:
         CONFIG_INPUT=y
         CONFIG_INPUT_AMIKBD=y
         CONFIG_INPUT_AMIMOUSE=y
         CONFIG_INPUT_KEYBDEV=y
         CONFIG_INPUT_MOUSEDEV=y

- make sure _absolutely no_ keymap is loaded on bootup, on RH style setups,
this means "rm -f /etc/sysconfig/keyboard
/etc/sysconfig/console/default.kmap" (it may be a bit different, I'm
quoting from memory). The default kernel keymap in pc_keyb.c has to be in
effect on reboot.
- reboot with new kernel

Now, with the new kernel, most of the keys and the mouse (/dev/input/mice,
protocol ImPS/2 for X, imps2 for gpm) should still work. There are for sure
pitfalls in the above description, but these should be solvable by someone
knowing the [Cc]onfig.in and Makefile setup for Apus. You should at least
get to a point where you can tell if the ami*.c input drivers in the
linuxconsole CVS are useable already.

For Apus keycodes backwards compatibility take a look at what I did in
apus24tree/.../input/keybdev.c and apus24tree/../macintosh/machid.c. To
generate a conversion table, goto ruby/utils and do the following:

         gcc -Dfrom=code -Dto=atari gencodes.c -o gencodes
         ./gencodes

> > > > If you want to keep the current state of affairs I can see in the
> > > > linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On
> > > > the other hand, if you plan to integrate your input drivers into
> 2.4, it
> > > > makes perfect sense.
> > >
> > > I think it would be nice, but to be honest I don't fully understand what
> > > would be involved.
> >
> > Actually not much, given the Apus input drivers in the linuxconsole
> > repository ("ruby") on sourceforge are already functional,
>
>I don't know, so I assume not :(

Well, the code at least looks like someone already worked on it, so it may
be functional.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
