Message-Id: <4.3.2.7.2.20000712131641.037268e0@mail.lauterbach.com>
Date: Wed, 12 Jul 2000 13:25:38 +0200
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Keycodes for the new input layer
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SOL.3.95.1000712122230.21439C-100000@juliet>
References: <00071122442101.00729@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:41 12.07.00, Derek Homeier wrote:
>On Tue, 11 Jul 2000, Franz Sirl wrote:
>
> > On Tue, 11 Jul 2000, Derek Homeier wrote:
> > > One more cheers to the backport of the new USB input layer! Finally, I'm
> > > able to use the trackpad and the usbmouse with wheel simultaneously in X,
> > > and together with gpm. I have a couple of minor problems with the
> > > configuration of the keys on my 101 Powerbook (Lombard), though:
> > >
> > > How do I figure out the keycodes for the "keypad"-enter key (between the
> > > spacebar and the right option key, marked with a '_^')? I like this one
> > > best for mousebutton emulation and mapped button 3 to kp_enter and
> > > button 2 to fn-kp_enter. These had console keycodes 58 and 110.
> > > With the new kernel, button 2 defaults to the fn-key alone (which makes
> > > it useless for anything else) and, I think, option.
> > > The only "enter" or "return" keys defined in input.h are KEY_ENTER=28 and
> > > KEY_KPENTER=96, but when I print 96 to
> > > /proc/sys/dev/mac_hid/mouse_button3_keycode, button 3 is emulated by the
> > > fn-return combination (which is also marked by '_^').
> > > I recall that this other enter key seemed to be lost already in previous
> > > 2.3 kernels, but I'd really like to get it back. Currently, this
> enter and
> > > fn-enter are performing like the standard return key and no key at all,
> > > respectively.
> > > Another thing that puzzles me is that I can print 100 (KEY_RIGHTALT) to
> > > mouse_button3_keycode. The left and right option keys on the PB keyboard
> > > are indistinguishable, but with this setting, fn-opt is working as
> mouse-3,
> > > and opt is still working normally. If fn-opt is not mapped to mouse-3,
> > > however, it always gives the same keycodes as opt, so I found no way yet
> > > to make it a regular right_alt or AltGr key. Is there a way to make it
> > > generate a different keycode?
> >
> > Hmm, what kernel are you using? the binary on Ben's page or a selfcompiled
> > one? Old mode (kernel_sends_linux_keycodes==0) or new mode
> > (kernel_sends_linux_keycodes==0)?
> >
> > The Fn key is not really handled right now and probably requires more
> kernel
> > support for the key combos not handled in HW. Anyone has a list of these
> > combos?
> >
>That was with Ben's precompiled kernel, but I have just rsynced the
>2.2.17pre10-ben1 sources. The only differences are that the mouse buttons
>now are not emulated by anything by default (at least I could not find any
>key), the Fn key is not reported as an input event any longer (used to
>be xkb-code 80 with xev), and the second Enter is not recognized at all,
>neither w/ nor w/o Fn pressed. kernel_sends_linux_keycodes==1 does not
>change anything for the mousebuttons, but annoyingly sets META to Option
>(and of course resets the console map to US).

It should be:

ALT = optionL
ALTGR = optionR

by default in most PC maps and the default kernel maps I think. I'll have
an updated console-tools package ready later today, which will do it right
for most Macs:

ALT = optionL
ALTGR = commandL or commandR


>                                               _
>I have to correct the keycodes I gave for the ^ key:
>   _
>   ^:    52, xkb keycode 60 (keysym 0x0, NoSymbol), same_screen YES,
>         XLookupString gives 0 characters:  ""
>     _
>  Fn-^:  110, xkb keycode 118 (keysym 0xff8d, KP_Enter), same_screen YES,
>"   XLookupString gives 1 characters:  "
>
>  RET:   36, xkb keycode 44 (keysym 0xff0d, Return), same_screen YES,
>"   XLookupString gives 1 characters:  "
>
>  Fn-RET: 72, xkb keycode 84 (keysym 0xff8d, KP_Enter), same_screen YES,
>"   XLookupString gives 1 characters:  "
>
>Both Opt and Fn-Opt are 58 (xkb 66).
>(with 2.2.17pre9-benh1)
>With  2.2.17pre10-benh1, syslog reports:
>
>Jul 12 02:12:45 miranda kernel: Unhandled ADB key (scancode 0x34) pressed.
>Jul 12 02:12:45 miranda kernel: Unhandled ADB key (scancode 0x34) released.
>      _
>when ^ is pressed, and
>
>Jul 12 02:12:46 miranda kernel: Unhandled ADB key (scancode 0x6e) pressed.
>Jul 12 02:12:46 miranda kernel: Unhandled ADB key (scancode 0x6e) released.
>        _
>for Fn-^.

Ah, that's good information, just one question, what does the _^ key do in
MacOS? I mean what can I do with this key in MacOS? Is it a modifier? A
prefix? does it print characters?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
