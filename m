Date: Mon, 9 Oct 2000 18:43:30 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010071939260.398-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010091818340.6974-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The problem is that the info struct is shared by all virtual consoles.
> > Thus if the video mode is set on a console which is not active, the
> > active console will be affected too. This typically results in a kernel
> > panic (the wrong set of console output functions is used).

   Oh the problems of console code interwoven with fbdev drivers. The
problem is the way mode setting happens. It goes from the fbdev layer to
the console layer when it should go in the opposite direction.

   You have to think changing mode of non visible VC means we store data
in fb_display and not set any hardware. For a visible VC we store data in
fb_info and set the hardware. It is durning VC switching that data is
moved into fb_display and new data is moved into info.

   What really needs to be done is that all handling of non visible VCs be
moved into fbcon.c and fbdev drivers deal only with the visible VC. For
mode setting of a single VC this can't be done with the current console
system :-(. For palette setting this is a different story. In fact it
is a simple patch. This does mean that color palette handling could be
moved from the fbdev layer to the console layer.

> Well, for aty128fb (which doesn't support a hardware cursor yet), the fix is
> what you propose. However, for atyfb I see no simple solution, apart from
> disabling the hardware cursor :-(

I have some ideas but it would requires some changes to the fbcon layer.
Also it would move palette handling from fbdev to the console layer.
Would these changes be included with the 2.4.0-testX kernels?

P.S

  BTW we really should be using display_fg in fb_info more. Using currcon
has it problems in multihead enviroments and drivers that support multiple
instantances of the same card. Moving currcon into fb_info is one solution
but why not use display_fg since it already is there.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
