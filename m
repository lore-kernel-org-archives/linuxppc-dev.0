Message-ID: <3987FAB1.14086A30@wanadoo.fr>
Date: Wed, 02 Aug 2000 12:40:49 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Michel D	nzer <daenzerm@student.ethz.ch>,
        Iain Sandoe
	<iain@sandoe.co.uk>, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <Pine.LNX.4.10.10007311758340.20511-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > >>And yes, there have been reports of people trying it (one yesterday - said
> > > >>it was quicker in some places & slower in others...)
> >
> > He didn't provide any numbers though. For all chipsets which have an
> > accelerated driver in X 4, it's almost certainly faster than anything else -
> > and also for the others it should be faster than X 3.3.x .
>
> Talking about x11perf on Mach64? It's faster for scrolls and rectcopys but
> as fast as the fbdev driver or slightly slower for other stuff. I can send
> logs (at 32 bpp) to anyone that cares to analyze them. Switching back to
> 3.3.x is something I always wanted to do but never found time for, but
> even the fbdev driver on 4.01 feels a lot faster than the 3.3.x one.

I installed Franz's XFree-4.0.1-0.36a RPMs, and with these I can run
either the new XFree68 server or the XF68_FBDev server from 3.3.6 or
Xpmac. In fact, I have all three of them running right now at the same
time on different VCs (well, Xpmac isn't really usable, because I don't
know how to talk it into using the new mouse stuff, but that's a
different story).

So I don't see any need to switch back to 3.3.x for anything except
possibly the server binary itself. All the rest, font server, libraries,
seem to be compatible.

And although I am only using the fbdev driver, it is definitely faster:
For x11perf -scroll500, I get (8 bit video on valkyriefb):

  36.5/sec for XFree-4.0.1
  13.0/sec for XF68_FBDev-3.3.6 (similarly for Xpmac, from memory)

So scrolling is nearly 3 times faster!

Two or three small annoying problems remain:

1) Clicking on a scroll arrow (in netscape, for example) for more than 1
or 2 seconds, sometimes even less, makes the window scroll all the way
to the end.

2) There are color palette problems on the 8 bit display. Probably the
defaults have changed for colors that cannot be allocated? Sometimes
this gives me black text on black background, for instance in "make
menuconfig" or in pinfo. These are unusable when some color hungry
program such as netscape is already running.

While these 2 problems only occur with the new XFree86 server and not
with XF68_FBDev, the following seems to come from the new libraries. To
verify this suspicion, I would have to revert to the XFree-3.3.6 RPMs.
It could also come from a number of other packages I upgraded recently.
Difficult to find out.

3) Mozilla-M16 (and M17_BRANCH) doesn't work any more. It starts
loading, and when called with an URL, gets to the first browser window.
Any further action gives "segmentation fault" or "illegal instruction"
or just silent death. When called without URL, it dies silently before
the first window comes up.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
