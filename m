From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Linux kernel / USB keyboard scancode problems
Date: Tue, 26 Aug 2003 21:24:02 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <20030826093512.GA7637@iram.es>
In-Reply-To: <20030826093512.GA7637@iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308262124.04906.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 26 August 2003 11:35, Gabriel Paubert wrote:
> On Sat, Aug 23, 2003 at 02:09:24PM +0200, Frank Murphy wrote:
> >   To get the menu keysym, I'm supposed to press fn and Enter at the same
> > time. But, instead of getting Menu (X keycode 117), I get 99.
> > Unfortunately, that's the same keycode as Prior (PageUp), but I think
> > that's an X bug. On the console with showkey -k, I get 101. With showkey
> > -s, I get 0x5b 0xdb. Unfortunately, I don't know what these values are
> > supposed to be for Menu
>
> Indeed that's an X bug, like the one (fixed now?) with the keypad equal.

True, the fact that PageUp and Menu make the same keycode in X is an X bug.
However, if the kernel sent the normal (i.e. i386) keycode, the X bug
wouldn't be exposed.

> X does its own mapping of raw keycodes to keycodes, and the mapping
> is surjective (arghh). The option CustomKeyCodes in X allows you to bypass
> this mapping (medium raw modes) but I believe it is deprecated.
...

I've messed around with the CustomKeyCodes a bit, but mostly it makes the
situation worse:  some keys don't repeat properly and lots of non-core keys
aren't mapped at all.

> >   On the extended keyboard F13, F14, & F15 (in the positions of Print
> > Screen/SysRq, Scroll Lock, and Pause) also have strange keycodes. In X,
> > they are keycodes 93, 123, and 127, respectively. With showkey -k, I get
> > 85, 115, and 119. With showkey -s, I get 0x55 0xd5, 0x73 0xf3, and 0x77
> > 0xf7. Unfortunately, I don't know what these values are when connected to
> > an i386 Linux box because I don't have access to one right now (though I
> > might be able to). Mapping these keys to either the equivalent (in
> > position) or perhaps to "real" F13, F14, and F15 keys would make them
> > actually usable.
> >
> >   The right Apple-logo key was mysteriously fixed in 2.4.20 or 2.4.21.
> > I'll help any way I can to get these four other keys fixed, too. Does
> > anyone know who made the fix to the logo key?
>
> I believe it was benh in drivers/macintosh/adbhid.c on March 5th. Easy
> to find with bk (1.10 revision in the tree on my Pismo which I have not
> updated in a long time). Apparently the ADB keycodes have changed
> depending on PB revisions.

Thanks for the pointer! It looks like that's the right place. I've looked at
it quickly, and it'll take me a while to figure out what's going on.

Thanks a lot,

Frank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
