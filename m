Message-ID: <6BAD6986DF8FD211AB8300A0C931D855050F15@mail.neruo.com>
From: Brad Douglas <Brad@NERUO.com>
To: "'Geert Uytterhoeven'" <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-fbdev] Re: macmodes/modedb
Date: Fri, 19 May 2000 08:02:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Geert Uytterhoeven [mailto:Geert.Uytterhoeven@sonycom.com]
>
> > > You cannot do everything in fb_find_mode() since monitor sense is
> > > a per-monitor issue, not global.
> >
> > As of now, all drivers have a 1:1 relationship with a monitor.  Even the
> > Matrox G400 driver insmods a second driver for the 2nd head.  Should we
> > expect this to change?  I do not believe fbdev is capable of
initializing
> > two video cards from a single driver, but I could be wrong -- I have no
> > ability to test.
>
> Yes it is. There are drivers that can handle multiple cards. And you can
have
> different cards as well.

I'm not totally sure what I was thinking when I wrote that.  Ani added
support into the aty128 driver that at least allowed detection of multiple
cards of the same class.  I guess what I wasn't sure of was if the
underlying system could handle it.

> > > One possible thing (in each fbdev driver :-(
> > >
> > >     default_mode = NULL;
> > > #ifdef CONFIG_PPC_ALL
> > >     sense = ...;
> > >     default_mode = mac_map_monitor_sense(sense);
> > > #endif
> > >     ... = fb_find_mode(..., default_mode, ...);

So I'm assuming that this is the route to go until we/I have more detail on
DDC?

In the end, I think that an addition to fb_ops would be appropriate.

I see that DDC is supported in X4.  Are there any legal reasons why I
couldn't just "figure it out" from the X code?  $350 USD seems a bit steep
to find out how an industry standard works...

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
