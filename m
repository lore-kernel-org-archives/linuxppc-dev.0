Date: Thu, 7 Feb 2002 11:55:59 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
Message-ID: <20020207115559.G3189@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020204154626.C28199@reepicheep.ics.uci.edu>; from jronne@ics.uci.edu on Mon, Feb 04, 2002 at 03:46:26PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 04, 2002 at 03:46:26PM -0800, Jeffery von Ronne wrote:
> Does anyone know how hard it would be to hack aty128fb to support a
> second Rage 128?  Or am I better off trying to get the X server to talk
> directly to the second card?

FYI, hacking the kernel's aty128fb driver---by removing the return 0;
in aty128fb_init's PCI probe loop---I can get an aty128fb for both cards.
So far, I've only gotten X's fbdev driver to work with it.  I looks closer
into why r128/UseFB isn't working some other time.

Unfortunately /dev/fb1 (which is the one open firmware uses, BTW) has a couple
glitches.

First, it only seems to work in 8bpp: in other modes the screen splits
into three parts: a top-left, top-right, and bottom.  The bottom just
has garbage, and the top-left and top-right seem to be mirrored
minature of a garbaged version what the screen is supposed to contain.

Second, it seems to have trouble erasing things (e.g. instead of putting
up the X background grid when I move a window or even initially.)

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
