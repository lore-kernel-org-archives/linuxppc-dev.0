Message-ID: <39A3D9B2.2EED3005@uncc.edu>
Date: Wed, 23 Aug 2000 10:03:30 -0400
From: "William H. Schultz" <whschult@uncc.edu>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.10.10008221850420.377-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Tue, 22 Aug 2000, William H. Schultz wrote:
> > For all of you saying that controlfb is broken...  I rsynced the
> > bitkeeper tree a few days ago, got it to compile, booted, etc...
> > however:  I have a voodoo3 card, and it is set as my main display.  The
> > voodoo3 was ignored, and the video went straight to the built in
> > controlfb on my 8500.  It worked just fine, and it worked the best it's
> > worked in quite some time.  I had no video artifacts at all, and
> > everything worked...  nice and smooth...  etc....  etc...
> >
> > But the only way for me to use the voodoo3 (which is the card supporting
> > my BIG monitor) is to completely disable the video drivers from Boot
> > X...  odd quirk...
>
> So your voodoo3 does work with offb (video=ofonly or `no video driver')?
>
> In that case I'd expect it to work as well without `no video driver', since
> that would mean controlfb takes the control hardware, and offb takes what's
> left (i.e. the voodoo3).
>
> Or are you using the 2.2.x bk tree and not 2.3.x?
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds

I'm using the 2.3 tree --  2.4.0-test7 (yesterday's rsync).

While booting, it seems to recognize that there are two video cards--it
lists /dev/fb0 and /dev/fb1 during bootup, but /proc/fb only lists the
one currently being used.

The way I had it originally set to boot up was video=tdfxfb and it's
settings (which probably defaulted back to offb anyway).  With test7,
that little bit of text that pops up before the penguin shows up on the
voodoo, but it then swaps over to control.  Everything completes from
there and X starts up.  When I choose 'no video driver' I get my voodoo.

They both work, and it seems that if someone only had the built in
hardware (on the 8500) that it would work fine.  On the other hand, the
kernel no longer fully accepts that there are two frame buffers.
Several versions back, X was able to start up on both screens, but it no
longer will--and I think /proc/fb may have the explanation.


Hank

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
