Date: Mon, 13 Mar 2000 14:00:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org,
        Kevin Puetz <puetzk@iastate.edu>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <38CCC0A9.576D34FC@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003131356430.32105-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > A clean patch against XFree 4.0 would help to decide if I just missed some
> > more cache flush magic or if it's a real atydb bug.
>
> I suspect it is the latter as Kevin Puetz has reported a similar problem with
> Mach64 on the debian-powerpc list. The server locked the machine in
> fbdevHWModeInit(). If you could rebuild libfbdevhw.a with DEBUG defined (in
> fbdevhw.c), we might get more valuable information from the log.

Sounds like the very bug I'm chasing. It chokes on the FBIOPUT_VSCREENINFO
ioctl. The mode in question is reported as:

xfree init mode:        64902   1024 1064 1200 1344   768 771 777 806
fbdev init mode:        15407   1024 40 136 144   768 3 6 29   16 0:0:0

with the only thing that seems fishy the 0:0:0 as the res:blue:green
length values.

I'm going to disable the ioctl and see where it barfs after that.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
