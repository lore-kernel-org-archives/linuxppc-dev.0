Date: Sat, 13 Feb 1999 09:57:38 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Linux Framebuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: clgenfb updates (mainly for PReP)
Message-ID: <Pine.BSI.3.96.990213095048.24001A-100000@usr07.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I (mostly) have 16- and 32-bit color depths working.  A few modes are
still causing problems, and I have some small problem with the accelleration
code for those bit-depths, but they are coming up.  I also fixed a bug where
I was only using 5 of the 6 bits for the clock denominator, so more modes
are working then before.  In the higher color modes, occasionally my blit
code will move or clear more pixes than it should -- usually either when
deleting character or when scrolling up and down through the command
history.  Higher color modes won't work as a module (with 2.2.1 anyway) --
but you should just have to modify fbcon-cfbX.c the same way I have
fbcon-cfb8.c patched.

The fix may also allow higher color depths to work on non-prep boards
(previously, text colormaps for other depths were not being set).

Thanks to Cort, I have the patches at
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/clgenfb-prep

Patches are against 2.2.1.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
