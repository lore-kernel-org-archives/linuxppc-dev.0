Message-ID: <397DDB36.DA5B68F9@mvista.com>
Date: Tue, 25 Jul 2000 11:23:50 -0700
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
References: <Pine.LNX.4.10.10007251413580.434-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Mon, 24 Jul 2000, Iain Sandoe wrote:
> > BTW: on my system ll_rw_blk.c gets up to 750 us quite often when the system
> > is loaded... this **IS** a potential problem for audio use.
> >
> > log entry : 3  (16  history entries)
> >         Peak Block Time  :        430.0 us  (    7185) [ OK ]
> >         startFilename    : ll_rw_blk.c                    Line : 167
> >         endFileName      : ll_rw_blk.c                    Line : 179
> >
> > I still haven't found the "hard-block" that is effecting the overall audio
> > latency performance... ah well, back to the drawing board...
>
> Do you have IDE? The IDE driver turned out to be the major interrupt messing
> problem on m68k, since it can disable interrupts for quite a while.
>
> Gr{oetje,eeting}s,
>
>                                                 Geert

The IDE driver in v2.2.xx has a run-away cli(), which causes long
interrupt blocking times.  See my postings in linux-kernel mailing list
a while back (around March), if you can still find them.  A IDE driver
guys suggested a fix, but I am not sure if it there yet.  The function
is  do_rw_dis().

log entry : 3
(unplug_device in ll_rw_blk.c, calling dev->request_fn(),
 do_rw_disk() in ide-disk.c)
        blockingTime     : 39955
        startFileName    : ide-disk.c
        startFileLine    : 390
        startCount       : 3433912489
        endFileName      : ll_rw_blk.c
        endFileLine      : 172
        endCount         : 3433952444
        unused1,2        : 0, 0

I believe there is a user-land workaround, which involves using "hdparm"
to change some bits.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
