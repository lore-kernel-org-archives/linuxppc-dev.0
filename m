Message-ID: <39CE8B90.1B318DD2@student.ethz.ch>
Date: Mon, 25 Sep 2000 01:17:36 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: rshapiro@bbn.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net> <14798.23332.833379.615321@esb.bbn.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:

> 2. On the same machine, I now have a working multi(3)-headed X!  I'm
> very impressed that the linuxppc X development team got this going so
> quickly.  It only works with the fbdev driver (see below), but I'm not
> complaining.  The only issue I've run into so far is the known bug
> with screenblanking, which I can fix easily enough via xset.

What bug with screenblanking?


> I can't test xinerama on this platform because the three screen don't
> all run at same depth (two use depth 15/16, one uses depth 8).

What about just testing it with the two heads who run at 16 bpp, or run all
heads in depth 8?


> 3.  On the same machine, the ati driver I built yesterday hoses linux
> completely and doesn't leave a core file.  I'm happy to help the
> developers try to debug this, but I'm not sure what information I can
> provide in this situation (it's also not my machine, so I can't always
> crash it at will).

The server log and maybe the XF86Config are always a good start for
information.


> 4. On the rev. b beige G3 w/Mach64 Rage Pro, the ati driver seems to
> be working.  The XF probe still gets the wrong amount of vram,

Hint to Ani or whoever is working on the ati driver: Why not get the VRAM size
from the framebuffer device?

> and it still throws away the mode I constructed via fbset -x.

What reason does it give for rejecting it?

> But it finds another valid mode somewhere else (where are these default
> modes coming from anyway?)

They're built into the server binary. Mostly VESA standard modes AFAICT.

> and it definitely feels accelerated.  I'm a little worried that it may be
> driving the monitor too hard but I'm not sure how to find out.  xpydinfo
> doesn't say anything useful.

xvidtune gives information about the modes.

> The output from startx includes this:
>
> (II) ATI(0): Monitor0: Using hsync range of  30.00- 94.00 kHz
> (II) ATI(0): Monitor0: Using vrefresh range of  48.00-120.00 Hz
>
> which are the numbers I put in the XF86Config (taken straight from the
> monitor manual).  But somehow it looks like it's running too high a
> sync rate.

Look at the log (/var/log/XFree86.0.log), there should be values for all modes
used and rejected.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
