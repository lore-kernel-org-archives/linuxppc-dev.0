Message-ID: <38319FEA.420FEA00@astro.wisc.edu>
Date: Tue, 16 Nov 1999 12:18:18 -0600
From: Matt Haffner <haffner@astro.wisc.edu>
Reply-To: haffner@astro.wisc.edu
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>, atong@uiuc.edu
CC: linuxppc-dev@lists.linuxppc.org
Subject: XFree, E, and refresh rates...
References: <Pine.LNX.4.10.9911151747090.699-100000@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote (in the user list):

> ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5, but they're quite old
> & out of date again.  Something new & improved <g> RSN.

Tom, Anthony, et al.,

I was curious if any of you had seen my posting on the users list a bit
ago about problems that cropped up with Enlightenment 0.16 related to
monitor refresh rates (B&W/400). There are two minor issues on this
topic.

(1)

There seems to be a general problem (at least on my system... I haven't
seen corroboration yet) that XFree chooses the _lowest_ vertical refresh
modeline instead of the highest one supported by the monitor. I have
lines like

    HorizSync   30.0-95.0
    VertRefresh 50.0-152.0

correctly put there by Xconfigurator for my monitor (& double checked by
me). Nonetheless, a default XFConfig file results in an X session at
60Hz. To force higher refresh rates, I need to comment out modelines for
the lower ones explicitly. 

(2)

Recently I installed Enlightenment 0.16 on top of Tom's 3.3.5 XFree and
Anthony's aty128fb (unaccelerated at that time). I had been using the
stock Enlightenment 0.15 with X running in 24-bit depth and a modeline
that gave me a refresh rate of something like 85 Hz. With the new
Enlightenment, X wouldn't even start dying with

  Fatal server error:
  Caught signal 11. Server aborting

Finding it worked at home on my PowerBase, I played around with the
XConfig file the next day. Strangely enough, E 0.16 only wanted to work
at lower refresh rates! I was forced to use 75 Hz at my current
resolution (1280x1024). Odd, but I could deal with it... 

Then I installed Anthony's newest Rage128 accelerated fbdev last week.
The same error cropped up again. Fortunately, switching to a new
modeline fixed the problem, but now I'm forced to run at 60-70Hz. Oddly
enough, a session run from gdm works at 70Hz, but one started in a
console via startx only works at 60Hz.

Any ideas? The odd thing for me is that a _window manager_ (or how it's
driving X) cares about my refresh rate. Think there is anything I can do
on this end to probe this more? I'd love to dive in with my hack 'n
slash debugging skills, but X is a bit too scary of a beast for me right
now :) Thanks for getting us this far!

mh
--
Matt Haffner                      /|------|\    University of Wisconsin
Dept. of Astronomy               /|--------|\            Madison
haffner@astro.wisc.edu          /|----------|\  
           WHAM project -- http://www.astro.wisc.edu/wham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
