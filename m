Message-ID: <366E47E0.24DD93F4@wanadoo.fr>
Date: Wed, 09 Dec 1998 10:50:24 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Takashi Oe <toe@unlinfo.unl.edu>
CC: Tom Rini <tmrini@ntplx.net>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: XF68_FBDev and option keys (was Re: XF68_FBDev under MkLinux? and Re:
 pre-R5&miscs)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

one of my several problems with X servers is solved, thanks to Takashi
Oe. I can now use the option keys as modifiers for the keyboard under
XF68_FBDev, and this in both R4 and pre-R5.

This was in fact a problem of my configuration, so it seems I did not
read enough documentation (or maybe there isn't enough, hint, hint :-)).

Takashi Oe <toe@unlinfo.unl.edu> wrote on Tue, 8 Dec 1998:
> You might want to double check that xkb is really used when you fire up
> XF68_FBDev.  XF68_FBDev should say something about "System: xkb bra bra
> bra ..." to stderr but nothing else about xkb.

There was, in fact, an error message that I neglected. It came from the
line
    xkb_symbols     { include "symbols/macintosh"  };
in /usr/X11/lib/X11/xkb/keymap/macintosh.
I did not know that this had to be changed. 

I think this is a bug, it should be "symbols/macintosh/us" in the
standard distribution, and it is now "symbols/macintosh/fr" for me, and
this makes my French keyboard work in XF68_FBDev just as it had been
working in XPmac all the time. 

If I don't set XkbKeymap "macintosh" in XF86Config, or if there is an
error as above, then XF68_FBDev uses the console keymap, but apparently
only incompletely, without the options keys as modifiers.

My two other problems persist: No mouse buttons 2&3 in XF68_FBDev (and
no, adb_buttons=1 in the boot command line is no solution!), neither in
R4 nor in pre-R5; and mixed-up color palette in XPmac in pre-R5. The
latter problem would, of course, lose its importance if the former were
solved.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
