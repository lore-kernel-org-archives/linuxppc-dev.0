Date: Wed, 20 Jan 1999 13:17:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: luther@dpt-info.u-strasbg.fr
cc: Michel Daenzer <michdaen@iiic.ethz.ch>, nardinoc@CS.UniBO.IT,
        Linux/APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [pm2fb] update 990110 - first public release ;)
In-Reply-To: <19990120120240.B2072@maxime.u-strasbg.fr>
Message-ID: <Pine.LNX.4.03.9901201307200.21387-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 20 Jan 1999, Sven LUTHER wrote:
> but then since i first booted in this mode, the bottom line of the
> screen don't get erased anymore, very anoying, particularly
> because it worked fine before.

I guess a problem with the clear_margins routine?

> also, Ilario and Geert, am i right in thinking that the pm2fb
> initialize the permedia2 chip correclty, and that, when trying to
> accelerate X i could use it directly, without having to do
> initialization.

Yes. The X server must not do video mode initialization, but call the frame
buffer device instead.

> also there is a whole part missing in the xfree pm2 accel servers,
> so i don't know if it would be a good idea to use them.
> 
> Ilario, you released the pm2 includes uinder the GPL to go into
> the kernel, is it ok to put them also in X ? 

I don't think that's a good idea: we want to be _integrated_ with XFree86, not
diverge from them. So IMHO we should use the XFree86 include definitions for
Permedia2.

BTW, Gerd Knorr added fbdev support to XF86_SVGA. Currently it supports Matrox
only (or no accel on other boards) in fbdev mode, but it's a good start.
Starting from that is probably the best way to have as much acceleration
support as possible. The unified XFree86 4.0 will be much more similar to the
current XF86_SVGA than to the other current accelerated servers like
XF86_{Mach64,S3,S3V}. Adding more accel code to XF68_FBDev is a waste of time.

Yes, I really should try to get XF86_SVGA working on my CHRP box. Once we have
it working for one chipset, the others should follow soon. XF86_SVGA does
support not only Permedia2, but also ATI Mach64, S3 Trio64 and S3 ViRGE.

The only things lacking in a fbdev'ed XF86_SVGA for us are the missing support
for Amiga and Atari bitplanes.

XF86_SVGA has another advantages for PPC: since it works on the `plain'
chipset, too, we can have a unified X server that uses fbdev where available,
and bangs the hardware completely where not (e.g. the PPC PReP boxes with S3 or
Cirrus Logic).

Sven: I'll forward Gerd's patches.

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
