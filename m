Date: Thu, 7 Feb 2002 17:15:50 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
Message-ID: <20020207171550.L3189@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu> <20020207115559.G3189@reepicheep.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020207115559.G3189@reepicheep.ics.uci.edu>; from jronne@ics.uci.edu on Thu, Feb 07, 2002 at 11:55:59AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 07, 2002 at 11:55:59AM -0800, Jeffery von Ronne wrote:
> FYI, hacking the kernel's aty128fb driver---by removing the return 0;
> in aty128fb_init's PCI probe loop---I can get an aty128fb for both cards.
> So far, I've only gotten X's fbdev driver to work with it.  I looks closer
> into why r128/UseFB isn't working some other time.

I can get X's r128_drv/UseFB driver to work with /dev/fb0, but attempting
to use anything other than X's fbdev with /dev/fb1 sig-11's (it seems to
be the same no matter what driver /dev/fb0 is using).

> Second, it seems to have trouble erasing things (e.g. instead of putting
> up the X background grid when I move a window or even initially.)

This actually happens on both /dev/fb0 and /dev/fb1 when X's fbdev driver
is used.  It seems that it often just forgets to copy its shadow framebuffer
to the real framebuffer.  Setting ShadowFB to false, seemed to fix that.

PS An XF86Config-4 and XFree86.0.log from when I tried to use fbdev on /dev/fb0
   and r128 on /dev/fb1 is at http://www.ics.uci.edu/~jronne/tmp

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
