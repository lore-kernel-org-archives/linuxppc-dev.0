Date: Tue, 3 Oct 2000 18:33:54 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <20001003174240.B13904@suse.de>
Message-ID: <Pine.LNX.4.10.10010031820450.15293-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > plum:~ # fbset -depth 24
> > > ioctl FBIOPUT_VSCREENINFO: Invalid argument
> >
> > That's normal, you also have to decrease the virtual size, which was
> > initialized to the maximum possible value w.r.t. RAM size.
>
> It seems to be a problem with the color palette or somehow color depth
> related.
> First I just switched to 1024x768-60 and it didn't work, the next time I
> added -depth 24 and it works fine. So mol can not increase the color

vmode also needs both arguments for me. fbset crashing when you omit the
depth argument is weird - does fbset not read the current depth from the
device before a mode set, Geert?

We sure could hack the kernel ioctl to take depth 0 as 'dont change' and
print a warning?

> depth itself? I have depth 15 here right now in the molrc
>
> plum:~ # fbset 1024x768-60 -a
>
> -> crash
>
> plum:~ # fbset 1024x768-60 -a -depth 24
> plum:~ # exit
> *** Mac-on-Linux full screen video console ***
> Opening console video 1024*768, depth 32, 60.0 Hz  [offs:0, rb:4096]
> Closing console video.
> uOpening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
> Exiting MOL
> Closing console video.
> plum:~ # fbset 1024x768-60 -a -depth 8
> plum:~ # exit
> *** Mac-on-Linux full screen video console ***
> Opening console video 1024*768, depth 32, 60.0 Hz  [offs:0, rb:4096]
> Closing console video.
> Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
> Closing console video.
> Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
> Closing console video.
> Opening console video 1024*768, depth 15, 60.0 Hz  [offs:0, rb:2048]
> Exiting MOL
> Closing console video.
>
>
> So it looks like the atyfb driver doesnt init the color space stuff
> correct.

What happened on each of the MOL runs? I don't see problems with MOL color
map setting at least for 32 bit depth.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
