Date: Sun, 6 Dec 1998 16:12:30 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Elgin Lee <ehl@funghi.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: <199812060154.RAA01357@porcini.funghi.com>
Message-ID: <Pine.LNX.4.02.9812061549170.323-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Dec 1998, Elgin Lee wrote:
> Recent (non-official) MkLinux kernels support /dev/adbmouse (busmouse
> emulation).  GPM works with it, so I suspect that XF68_FBdev would as
> well.  Choice #2 does seem the least amount of work.

Nice.

> One question--would acceleration would still require framebuffer
> devices?

No. Xpmac does it without frame buffer devices: it just mmap()s /dev/mem. All
that has to be changed is the interface to the frame buffer device API: instead
of asking the frame buffer device for address and size of frame buffer and MMIO
region, and mmap()ing that, something else has to be done.

One other thing to consider is video mode programming. XF68_FBDev uses
modelines (except for `mode "default"'), while Xpmac can take a vmode and cmode
argument. But I think this can be solved by putting the Modeline <->
vmode/cmode conversion routine in XF68_FBDev (cfr. drivers/video/macmodes.c).

And of course there won't be support for virtual screens, as the vmode/cmode
API doesn't provide for this.

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
