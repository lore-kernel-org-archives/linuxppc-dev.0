Date: Tue, 3 Oct 2000 17:42:40 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati driver with rage II/rage pro)
Message-ID: <20001003174240.B13904@suse.de>
References: <20001002224703.A15425@suse.de> <Pine.LNX.4.10.10010031301130.1187-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010031301130.1187-100000@cassiopeia.home>; from geert@linux-m68k.org on Tue, Oct 03, 2000 at 01:01:47PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 03, Geert Uytterhoeven wrote:

> > plum:~ # fbset
> >
> > mode "1024x768-60"
> >     # D: 64.666 MHz, H: 48.115 kHz, V: 59.696 Hz
> >     geometry 1024 768 1024 4080 8
>                              ^^^^
> >     timings 15464 144 40 29 3 136 6
> >     accel true
> >     rgba 8/0,8/0,8/0,0/0
> > endmode
> >
> > plum:~ # fbset -depth 24
> > ioctl FBIOPUT_VSCREENINFO: Invalid argument
>
> That's normal, you also have to decrease the virtual size, which was
> initialized to the maximum possible value w.r.t. RAM size.

It seems to be a problem with the color palette or somehow color depth
related.
First I just switched to 1024x768-60 and it didn't work, the next time I
added -depth 24 and it works fine. So mol can not increase the color
depth itself? I have depth 15 here right now in the molrc

plum:~ # fbset 1024x768-60 -a

-> crash

plum:~ # fbset 1024x768-60 -a -depth 24
plum:~ # exit
*** Mac-on-Linux full screen video console ***
Opening console video 1024*768, depth 32, 60.0 Hz  [offs:0, rb:4096]
Closing console video.
uOpening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
Exiting MOL
Closing console video.
plum:~ # fbset 1024x768-60 -a -depth 8
plum:~ # exit
*** Mac-on-Linux full screen video console ***
Opening console video 1024*768, depth 32, 60.0 Hz  [offs:0, rb:4096]
Closing console video.
Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
Closing console video.
Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
Closing console video.
Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
Exiting MOL
Closing console video.


So it looks like the atyfb driver doesnt init the color space stuff
correct.
How can we fix that?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
