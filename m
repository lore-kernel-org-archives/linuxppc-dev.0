Date: Sun, 27 Dec 1998 17:01:53 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jeff Rugen <jrugen@primenet.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.BSI.3.96.981226234556.25149A-100000@usr09.primenet.com>
Message-ID: <Pine.LNX.4.02.9812271407390.378-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Dec 1998, Jeff Rugen wrote:
> I'm having a couple problems using X Servers with the clgenfb framebuffer
> console on the Motorola Powerstack and was wondering if anyone else had
> similar problems with other framebuffers/X Server combinations.  I have the
> clgenfb console as the only console in the kernel right now, and it works
> fine as a console.
> 
> 1) When I try to use XF68_FBDev from the XFree 3.3.3 binaries, I get a while
> screen.  However, everything seems to be running fine -- the window manager
> and X Server, etc are included in the list of running processes. My first
> guess is the XF86Config file, but it could be something else.  Where isa
> good location to get a simple, basic XF86Config file that defaults to  
> 640x480x8 or similar?  (Or if you have a clue that it could be another
> problem with something in the clgenfb driver to look at?)

I suspect the address of the frame buffer in struct fb_fix_screeninfo. It must
be the _physical_ address of the frame buffer. If this is wrong, the X server
will map the wrong piece of memory space.

What does `fbset --info' say?

When using the console, can you read and write to /dev/fb0? With

    dd if=/dev/fb0 /tmp/screendump

you can create a screendump.

    dd if=/tmp/screendump of=/dev/fb0

should restore the dump.

> 3) If I set the console to 1024x768, I get a lot more rows on the screen.
> However, if I run gpm, it doesn't allow me to highlight text on the entire
> screen -- I think it only allows it on the original 80 column by 24 (?) row
> size.  Has anyone fixed this or looked into it yet?

Gpm is not aware of changing resolutions on different VCs. It dates back to the
PC era, where all VCs ran with the same resolution.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
