Message-ID: <6BAD6986DF8FD211AB8300A0C931D855050F05@MAIL>
From: Brad Douglas <Brad@NERUO.com>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-fbdev] Re: macmodes/modedb
Date: Thu, 18 May 2000 12:54:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
>
> > What I can think of off hand is adding fb_mac_monitor_sense to fb_ops
(which
> > already looks like a less than optimal idea) or possibly depreciating
it.
>
> That's not a very good idea, since it's Mac only.
> From the other side, DDC is something similar, so a generic call in fb_ops
may
> be the good solution?

This may be a possibility.  Unfortunately, I'm not familiar with the inner
workings of DDC.  If anyone has docs on how this works, I'll take a stab at
adding support to fbdev.

> > Another option is to not try and do everything in fb_find_mode().
>
> You cannot do everything in fb_find_mode() since monitor sense is
> a per-monitor issue, not global.

As of now, all drivers have a 1:1 relationship with a monitor.  Even the
Matrox G400 driver insmods a second driver for the 2nd head.  Should we
expect this to change?  I do not believe fbdev is capable of initializing
two video cards from a single driver, but I could be wrong -- I have no
ability to test.

> One possible thing (in each fbdev driver :-(
>
>     default_mode = NULL;
> #ifdef CONFIG_PPC_ALL
>     sense = ...;
>     default_mode = mac_map_monitor_sense(sense);
> #endif
>     ... = fb_find_mode(..., default_mode, ...);

I believe this would be acceptable, but we'll have to change
mac_map_monitor_sense() to return fb_videomode instead of VMODE.
fb_find_mode() will be unhappy to get an int when it's expecting
fb_videomode. ;)

> Or: should it be considered as a real mode_option (if mode_option == NULL)
> instead of a default mode?

Looking at things now, I think the default_mode is the way to go.  "Pushing"
mode_options may make things a little more confusing (well, I guess it's
nothing a little documentation won't clear up).  I still like the fallback
to NVRAM values if there are no boot options or if the boot options fail.

It looks like we have a couple ways to do this.  Suggestions?

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
