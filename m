Message-ID: <19990120144929.E3026@maxime.u-strasbg.fr>
Date: Wed, 20 Jan 1999 14:49:29 +0100
From: Sven LUTHER <luther@maxime.u-strasbg.fr>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        luther@dpt-info.u-strasbg.fr
Cc: Michel Daenzer <michdaen@iiic.ethz.ch>, nardinoc@CS.UniBO.IT,
        Linux/APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [pm2fb] update 990110 - first public release ;)
Reply-To: luther@dpt-info.u-strasbg.fr
References: <19990120135435.L2459@maxime.u-strasbg.fr> <Pine.LNX.4.03.9901201435570.21387-100000@mercator.cs.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.03.9901201435570.21387-100000@mercator.cs.kuleuven.ac.be>; from Geert Uytterhoeven on Wed, Jan 20, 1999 at 02:37:20PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 20, 1999 at 02:37:20PM +0100, Geert Uytterhoeven wrote:
> On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > > > > Yes. The X server must not do video mode initialization, but call the frame
> > > > > buffer device instead.
> > > > 
> > > > what then is the stuff you initialize in the mach64 accel init stuff ?
> > > 
> > > Like you say, that's _accel_ _engine_ init stuff, not _graphics_ _engine_ init
> > > stuff. The graphics engine takes care of the video mode (programmed in the
> > > fbdev in the kernel), while the X server has to program the accel engine.
> > 
> > in the case of the permedia 2, the engine is only one long pipeline, so the graphic and
> > accel engine are the same ?
> 
> Are you sure about that?

I think yes, all units are in one pipeline, the same for 2D and 3D, and only this units are documented in
the TI docs, but then i guess by graphic engine you mean the one responsible for 
sending data to the monitor ? it is the last unit of the pipeline.

anyway, Ilario told me that he initialized everything nicely in the fbdev, that is, he 
switch off every unused part of the pipeline. 

i will have to switch on the part i will need ( altough for X accel, i guess it is only
the copy stuff that is really important, and they are already used in the fbdev driver
for console acceleration, so ...). or do i have to switch on this stuff only when doing the 
actual moves ?

> 
> > but better would be to take another approach to my questions, ...
> > 
> > when are the init and renint function called ?
> > 
> > i guess init is the first time the Xserver is launched, and reinit is each time 
> > you return from some console switch ?
> 
> Right.
> 
> > should we save the previous state and reset it on exiting X or something like that ?
> > Or will the fbdev driver automatically reinitialize the pm2 when you switch back to console mode ?
> 
> The X server may restore the video mode by calling the FBIOPUT_VSCREENINFO
> ioctl with the `var' it got on startup.
> 

but there is no accel specific stuff that get launched on exiting X, isnt'it, there is only the the init
function that get called when you go to X. I could, for starting, have a empty such function,
that is i just copy the info from the fbdev info structs to the glint_info structs, like
you do at the begining of the mach64 init functions ?

I will try to work on this this week end, and hope that i don't get the same problems as last time ...

Friendly,

Sven LUTHER

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
