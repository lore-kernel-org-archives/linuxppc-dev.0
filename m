MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14798.23332.833379.615321@esb.bbn.com>
Date: Sun, 24 Sep 2000 15:51:00 -0400
From: R Shapiro <rshapiro@bbn.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mostly good news:

1.  On the rev. a beige G3 w/Mach64 Rage II, the fbdev driver I built
yesterday from the latest rsync fixes the skew/wrap oddity.  In other
words, it seems to work fine on this platform now.


2. On the same machine, I now have a working multi(3)-headed X!  I'm
very impressed that the linuxppc X development team got this going so
quickly.  It only works with the fbdev driver (see below), but I'm not
complaining.  The only issue I've run into so far is the known bug
with screenblanking, which I can fix easily enough via xset.

I can't test xinerama on this platform because the three screen don't
all run at same depth (two use depth 15/16, one uses depth 8).  And my
preferred window manager (blackbox) doesn't seem to happy running more
than once from the same .blackboxrc (fvwm will do for now).  But these
are details...


3.  On the same machine, the ati driver I built yesterday hoses linux
completely and doesn't leave a core file.  I'm happy to help the
developers try to debug this, but I'm not sure what information I can
provide in this situation (it's also not my machine, so I can't always
crash it at will).


4. On the rev. b beige G3 w/Mach64 Rage Pro, the ati driver seems to
be working.  The XF probe still gets the wrong amount of vram, and it
still throws away the mode I constructed via fbset -x.  But it finds
another valid mode somewhere else (where are these default modes
coming from anyway?) and it definitely feels accelerated.  I'm a
little worried that it may be driving the monitor too hard but I'm not
sure how to find out.  xpydinfo doesn't say anything useful.  The
output from startx includes this:

(II) ATI(0): Monitor0: Using hsync range of  30.00- 94.00 kHz
(II) ATI(0): Monitor0: Using vrefresh range of  48.00-120.00 Hz

which are the numbers I put in the XF86Config (taken straight from the
monitor manual).  But somehow it looks like it's running too high a
sync rate.



All in all, worth coming in to work on a Sunday for :)


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
