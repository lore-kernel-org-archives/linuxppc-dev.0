Message-Id: <4.3.2.7.2.20000712141931.00c70690@mail.lauterbach.com>
Date: Wed, 12 Jul 2000 14:30:20 +0200
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Keycodes for the new input layer
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SOL.3.95.1000712132957.21439F-100000@juliet>
References: <4.3.2.7.2.20000712131641.037268e0@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 13:49 12.07.00, Derek Homeier wrote:
>On Wed, 12 Jul 2000, Franz Sirl wrote:
>
> > At 12:41 12.07.00, Derek Homeier wrote:
> > >On Tue, 11 Jul 2000, Franz Sirl wrote:
> > >
> > > > On Tue, 11 Jul 2000, Derek Homeier wrote:
>[snip]
> > > >
> > >That was with Ben's precompiled kernel, but I have just rsynced the
> > >2.2.17pre10-ben1 sources. The only differences are that the mouse buttons
> > >now are not emulated by anything by default (at least I could not find any
> > >key), the Fn key is not reported as an input event any longer (used to
> > >be xkb-code 80 with xev), and the second Enter is not recognized at all,
> > >neither w/ nor w/o Fn pressed. kernel_sends_linux_keycodes==1 does not
> > >change anything for the mousebuttons, but annoyingly sets META to Option
> > >(and of course resets the console map to US).
> >
> > It should be:
> >
> > ALT = optionL
> > ALTGR = optionR
> >
> > by default in most PC maps and the default kernel maps I think. I'll have
> > an updated console-tools package ready later today, which will do it right
> > for most Macs:
> >
> > ALT = optionL
> > ALTGR = commandL or commandR
> >
>I may disagree with a lot of people, but this does not seem right to me.
>On international keyboards you need Mode_switch for a lot of characters
>(as you'll certainly know ;-), which is usually bound to AltGr on PC-Hardware.
>Under MacOS, this is effected by Option-Key combinations, so for a fully
>MacOS-compatible keymap you need to have ALTGR bound to Option.
>Also I feel that the purpose of the Meta or ALT(L) on Unix is more similar
>to that of Cmd in MacOS, but that's rather my personal opinion.
>Of course, things do not become simpler by the fact that optionL and
>optionR are identical on most Mac keyboards. If it were possible to make
>Fn-Opt generate ALTGR (or vice-versa), this would add some flexibility.

The problem here is that newer Apple keyboards additionally label OptionL
as ALT and 3rd party keyboards with an additional OptionR label it as
ALTGR, which pretty much limits the correct choices :-(. Anyway, I'll put
keymap .inc files into console-tools that let you easily change it (eg.
option-left-as-alt.inc, command-leftright-as-altgr.inc, etc.).

> >
> > >                                               _
> > >I have to correct the keycodes I gave for the ^ key:
> > >   _
> > >   ^:    52, xkb keycode 60 (keysym 0x0, NoSymbol), same_screen YES,
> > >         XLookupString gives 0 characters:  ""
> > >     _
> > >  Fn-^:  110, xkb keycode 118 (keysym 0xff8d, KP_Enter), same_screen YES,
> > >"   XLookupString gives 1 characters:  "
> > >
> > >  RET:   36, xkb keycode 44 (keysym 0xff0d, Return), same_screen YES,
> > >"   XLookupString gives 1 characters:  "
> > >
> > >  Fn-RET: 72, xkb keycode 84 (keysym 0xff8d, KP_Enter), same_screen YES,
> > >"   XLookupString gives 1 characters:  "
> > >
> > >Both Opt and Fn-Opt are 58 (xkb 66).
> > >(with 2.2.17pre9-benh1)
> > >With  2.2.17pre10-benh1, syslog reports:
> > >
> > >Jul 12 02:12:45 miranda kernel: Unhandled ADB key (scancode 0x34) pressed.
> > >Jul 12 02:12:45 miranda kernel: Unhandled ADB key (scancode 0x34)
> released.
> > >      _
> > >when ^ is pressed, and
> > >
> > >Jul 12 02:12:46 miranda kernel: Unhandled ADB key (scancode 0x6e) pressed.
> > >Jul 12 02:12:46 miranda kernel: Unhandled ADB key (scancode 0x6e)
> released.
> > >        _
> > >for Fn-^.
> >
> > Ah, that's good information, just one question, what does the _^ key do in
> > MacOS? I mean what can I do with this key in MacOS? Is it a modifier? A
> > prefix? does it print characters?
> >
>It does mostly, but not always, the same as the Return key on the main
>keyboard. For some applications, it behaves differently. In the Finder,
>e.g. hitting KP_Enter will let you edit the name of the selected file.
>I think under MacOS, there's no difference between Fn-Return and the
>dedicated _^ key on the PB keyboard, and the standard ADB keyboard only
>has one KP_Enter anyway.

OK, so you want:
_^ = KEY_KPENTER
Fn-_^ = KEY_KPENTER
Fn-RET = KEY_KPENTER

Or something different for Fn-_^?


>I had another problem with the new input layer I forgot to mention:
>Though I selected /dev/mouse (-> inputs/mice) as input device and imps2
>as protocol, the mouse does not work in mol in the console mode.

Hmm, dunno about that, should be the same. Does it work if you kill gpm?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
