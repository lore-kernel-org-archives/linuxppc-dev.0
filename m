Date: Sun, 23 May 1999 14:59:44 -0400 (EDT)
From: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
To: Tom Rini <tmrini@ntplx.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: FBDev XF86 crashing on 8600
In-Reply-To: <Pine.LNX.4.05.9905222156520.650-100000@pc.wackyland.com>
Message-ID: <Pine.GSO.4.05.9905231417180.14882-100000@mail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 May 1999, Tom Rini wrote:

> Hmm.  I wonder if it's another 4mb control problem.  Have you tried using
> just 2mb?

Okay: (1) It's definitely the screen blanking that crashes things. By
changing the timeout and cycle I can precisely control the time of the X
server failure - and it's totally reproduceable. (2) Booting without the OF
video ("No video driver" in BootX turned *off*, no special kernel args)
makes the problem go away, but I can now only use 16-bit or lower at
1152x870.

Also, I've noticed that when I boot with OF video *on*, fbset reports very
different information. Here's fbset -i using the pmac drivers:

mode
   geometry 1152 870 1152 910 16
   timings 9666 132 44 39 3 128 3
   hsync high
   vsync high
endmode

Name: control
Address: 0xa4800028
Size: 2097112
Type: PACKED PIXELS
Visual: DIRECTCOLOR
XPanStep: 0
YPanStep: 1
YWrapStep: 0
LineLength: 2304
MMIO Address: 0xa0001000
MMIO Size: 512
Accelerator: No

And now with OFfb:

mode
   geometry 1152 870 1152 870 32
   timings 10000 16 16 16 16 8 8
endmode

Name: OFfb control
Address: 0xa4800210
Size: 4036800
Type: PACKED PIXELS
Visual: TRUECOLOR
XPanStep: 0
YPanStep: 0
YWrapStep: 0
LineLength: 4640
Accelerator: No

Things that worry me here are:

 1. lack of MMIO registers under OFfb (probably why the FBIOPUTCMAP ioctl
fails?)
 2. Different base addresses and framebuffer layouts for the two drivers
Virtually everything is different - timings, YPanStep, LineLengths don't
have an integral relationship (the 16-bit pmac line length is 2304 x 2 =
4608 bytes, while the 32-bit OFfb line length is 4640 bytes; whence the
extra 32 bytes?). Why do the base addresses differ by 0x1e8 = 488 bytes?
That looks suspiciously close to the missing 512 bytes of MMIO registers,
yet the MMIO regs should be far away from the framebuffer, judging by the
reported addresses and sizes.

Anyone out there want to clue me in on how this stuff works? I'd be glad to
help out as much as I can - I'm not afraid of low-level hackery, though my
waking hours are already stretched rather thin...

........................................................................
Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
     Eagles may soar, but weasels don't get sucked into jet engines.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
