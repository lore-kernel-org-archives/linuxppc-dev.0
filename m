From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 27 Aug 2003 20:29:50 +0200
To: Frank Murphy <murphyf+linux-ppc@f-m.fm>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux kernel / USB keyboard scancode problems
Message-ID: <20030827182950.GA12646@iram.es>
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200308262124.04906.murphyf+linux-ppc@f-m.fm> <20030826200303.GA14385@iram.es> <200308270948.04190.murphyf+linux-ppc@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308270948.04190.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 27, 2003 at 09:48:04AM +0200, Frank Murphy wrote:
> On Tuesday 26 August 2003 10:03, Gabriel Paubert wrote:
> > On Tue, Aug 26, 2003 at 09:24:02PM +0200, Frank Murphy wrote:
> > > On Tuesday 26 August 2003 11:35, Gabriel Paubert wrote:
> > > > X does its own mapping of raw keycodes to keycodes, and the mapping
> > > > is surjective (arghh). The option CustomKeyCodes in X allows you to
> > > > bypass this mapping (medium raw modes) but I believe it is deprecated.
> >
> > On a PC, the Menu key sends e0 5d (and obviously e0 dd for key up). The
> > linux keycode is 127 but the X one is 117.
>
> Could you tell me what the keycodes are for Print Screen/SysRq, Scroll Lock,
> and Pause are on your keyboard? Just so I can track what F13, F14, & F15
> could be.

Well, except for Scroll Lock, it's a mess. It depends on the other which
are down at the time the key is pressed.

		Linux keycodes		"Raw" scancodes (hex)	X keycode

Print Screen:		99		e0 2a e0 37		111
Alt+Print Screen:	--    		54			92
Shift+Print Screen:	99		e0 37			111
Control+Print Screen:	99		e0 37			111

Scroll Lock:		70		46			78

Pause:			119		e0 1d 45		110
Control+Pause:		101		e0 46			114

>
> > The following might be sufficient (just a wild guess, and it will
> > certainly break if you don't use linux keycodes):
>
> Thanks for your guessed fix. I'll have to look at what you've done, but, wow,
> it's pretty cryptic.

Well, it is really simple. Replace 101 by 127 in the ADB to Linux keycode
mappings. In this way the translation back to "raw" keycodes (only cooked
twice!) gives 349, which is 256 + 93 (0xe0 0x5d).

>
> > BTW, I'd also like to keep somewhere the state of the fn key in the
> > ADB keyboard driver. I've seen a MacOS utility which allows you to
> > use the trackpad as a scroll wheel while the fn button is pressed.
> > Thta's what I'd ike to copy.

Hmm, seeing that last line, I should proofread sometimes before sending e-mail...

>
> Huh. That would be pretty cool. Perhaps the real numlock state as well (if
> that's even possible).

No, not the numlock. The keyboard utility under MacOS9 does not even know
how to do this (it switches the display to the state of the numlock when
it receives a keypad/non-keypad keycode). This is deep in the bowels of the PMU
microcontroller and I would not try to reprogram it myself.

OTOH, the fn keycodes are simply ignored (ADB code 0x3f IIRC) in the
kernel, but the PMU sends the key down and up events.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
