From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 26 Aug 2003 11:35:12 +0200
To: Frank Murphy <murphyf+linux-ppc@f-m.fm>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux kernel / USB keyboard scancode problems
Message-ID: <20030826093512.GA7637@iram.es>
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308231409.24503.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 23, 2003 at 02:09:24PM +0200, Frank Murphy wrote:
>
> Hi all,
>
>   I recently upgraded my iBook (ppc) to the Debian stock 2.4.21 from the
> Debian stock 2.4.19 and I noticed a pleasant change:  where I used to get a
> strange keycode in X for the "right" Apple-logo key (222), I now get 116,
> which is the same code I get when using an external USB keyboard with 2
> Apple-logo keys. (On the iBook, the way to get the right key's code is to
> press this odd 'fn' key at the same time as the left logo key. Apple's
> description of how these keys should work can be found here:
> http://developer.apple.com/documentation/Hardware/Developer_Notes/Macintosh_CPUs-G3/original_iBook/iBook.25.html
>
>   The problems I want to talk about regards similar keys:  the Menu key, and
> F13, F14, & F15 (in the positions of Print Screen/SysRq, Scroll Lock, and
> Pause on an extended desktop keyboard).
>
>   To get the menu keysym, I'm supposed to press fn and Enter at the same time.
> But, instead of getting Menu (X keycode 117), I get 99. Unfortunately, that's
> the same keycode as Prior (PageUp), but I think that's an X bug. On the
> console with showkey -k, I get 101. With showkey -s, I get 0x5b 0xdb.
> Unfortunately, I don't know what these values are supposed to be for Menu

Indeed that's an X bug, like the one (fixed now?) with the keypad equal.
X does its own mapping of raw keycodes to keycodes, and the mapping
is surjective (arghh). The option CustomKeyCodes in X allows you to bypass this
mapping (medium raw modes) but I believe it is deprecated. I had even
found the source file in X in which this was handled but I have deleted
the source tree since then and I refuse to touch a file of source code
in which the only comment is a blurb of legalese at the beginning.

>
>   On the extended keyboard F13, F14, & F15 (in the positions of Print
> Screen/SysRq, Scroll Lock, and Pause) also have strange keycodes. In X, they
> are keycodes 93, 123, and 127, respectively. With showkey -k, I get 85, 115,
> and 119. With showkey -s, I get 0x55 0xd5, 0x73 0xf3, and 0x77 0xf7.
> Unfortunately, I don't know what these values are when connected to an i386
> Linux box because I don't have access to one right now (though I might be
> able to). Mapping these keys to either the equivalent (in position) or
> perhaps to "real" F13, F14, and F15 keys would make them actually usable.
>
>   The right Apple-logo key was mysteriously fixed in 2.4.20 or 2.4.21. I'll
> help any way I can to get these four other keys fixed, too. Does anyone know
> who made the fix to the logo key?

I believe it was benh in drivers/macintosh/adbhid.c on March 5th. Easy
to find with bk (1.10 revision in the tree on my Pismo which I have not
updated in a long time). Apparently the ADB keycodes have changed
depending on PB revisions.

	Regards,
	Gabriel
>
> Thanks,
>
> Frank
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
