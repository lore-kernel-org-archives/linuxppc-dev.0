Date: Tue, 11 Jul 2000 19:48:33 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Keycodes for the new input layer
In-Reply-To: <200007110504.AAA31849@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000711185904.18657C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One more cheers to the backport of the new USB input layer! Finally, I'm
able to use the trackpad and the usbmouse with wheel simultaneously in X,
and together with gpm. I have a couple of minor problems with the
configuration of the keys on my 101 Powerbook (Lombard), though:

How do I figure out the keycodes for the "keypad"-enter key (between the
spacebar and the right option key, marked with a '_^')? I like this one
best for mousebutton emulation and mapped button 3 to kp_enter and
button 2 to fn-kp_enter. These had console keycodes 58 and 110.
With the new kernel, button 2 defaults to the fn-key alone (which makes
it useless for anything else) and, I think, option.
The only "enter" or "return" keys defined in input.h are KEY_ENTER=28 and
KEY_KPENTER=96, but when I print 96 to
/proc/sys/dev/mac_hid/mouse_button3_keycode, button 3 is emulated by the
fn-return combination (which is also marked by '_^').
I recall that this other enter key seemed to be lost already in previous
2.3 kernels, but I'd really like to get it back. Currently, this enter and
fn-enter are performing like the standard return key and no key at all,
respectively.
Another thing that puzzles me is that I can print 100 (KEY_RIGHTALT) to
mouse_button3_keycode. The left and right option keys on the PB keyboard
are indistinguishable, but with this setting, fn-opt is working as mouse-3,
and opt is still working normally. If fn-opt is not mapped to mouse-3,
however, it always gives the same keycodes as opt, so I found no way yet
to make it a regular right_alt or AltGr key. Is there a way to make it
generate a different keycode?

Thanks i.a.,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
