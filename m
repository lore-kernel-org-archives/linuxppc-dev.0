Date: Wed, 20 Jan 1999 14:37:20 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: luther@dpt-info.u-strasbg.fr
cc: Michel Daenzer <michdaen@iiic.ethz.ch>, nardinoc@CS.UniBO.IT,
        Linux/APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [pm2fb] update 990110 - first public release ;)
In-Reply-To: <19990120135435.L2459@maxime.u-strasbg.fr>
Message-ID: <Pine.LNX.4.03.9901201435570.21387-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > > > Yes. The X server must not do video mode initialization, but call the frame
> > > > buffer device instead.
> > > 
> > > what then is the stuff you initialize in the mach64 accel init stuff ?
> > 
> > Like you say, that's _accel_ _engine_ init stuff, not _graphics_ _engine_ init
> > stuff. The graphics engine takes care of the video mode (programmed in the
> > fbdev in the kernel), while the X server has to program the accel engine.
> 
> in the case of the permedia 2, the engine is only one long pipeline, so the graphic and
> accel engine are the same ?

Are you sure about that?

> but better would be to take another approach to my questions, ...
> 
> when are the init and renint function called ?
> 
> i guess init is the first time the Xserver is launched, and reinit is each time 
> you return from some console switch ?

Right.

> should we save the previous state and reset it on exiting X or something like that ?
> Or will the fbdev driver automatically reinitialize the pm2 when you switch back to console mode ?

The X server may restore the video mode by calling the FBIOPUT_VSCREENINFO
ioctl with the `var' it got on startup.

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
