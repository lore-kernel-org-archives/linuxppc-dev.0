Message-ID: <19990120135435.L2459@maxime.u-strasbg.fr>
Date: Wed, 20 Jan 1999 13:54:35 +0100
From: Sven LUTHER <luther@maxime.u-strasbg.fr>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        luther@dpt-info.u-strasbg.fr
Cc: Michel Daenzer <michdaen@iiic.ethz.ch>, nardinoc@CS.UniBO.IT,
        Linux/APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [pm2fb] update 990110 - first public release ;)
Reply-To: luther@dpt-info.u-strasbg.fr
References: <19990120133518.G2459@maxime.u-strasbg.fr> <Pine.LNX.4.03.9901201345040.21387-100000@mercator.cs.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.03.9901201345040.21387-100000@mercator.cs.kuleuven.ac.be>; from Geert Uytterhoeven on Wed, Jan 20, 1999 at 01:46:05PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 20, 1999 at 01:46:05PM +0100, Geert Uytterhoeven wrote:
> On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > On Wed, Jan 20, 1999 at 01:17:16PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > > > but then since i first booted in this mode, the bottom line of the
> > > > screen don't get erased anymore, very anoying, particularly
> > > > because it worked fine before.
> > > 
> > > I guess a problem with the clear_margins routine?
> > > 
> > > > also, Ilario and Geert, am i right in thinking that the pm2fb
> > > > initialize the permedia2 chip correclty, and that, when trying to
> > > > accelerate X i could use it directly, without having to do
> > > > initialization.
> > > 
> > > Yes. The X server must not do video mode initialization, but call the frame
> > > buffer device instead.
> > 
> > what then is the stuff you initialize in the mach64 accel init stuff ?
> 
> Like you say, that's _accel_ _engine_ init stuff, not _graphics_ _engine_ init
> stuff. The graphics engine takes care of the video mode (programmed in the
> fbdev in the kernel), while the X server has to program the accel engine.

in the case of the permedia 2, the engine is only one long pipeline, so the graphic and
accel engine are the same ?

but better would be to take another approach to my questions, ...

when are the init and renint function called ?

i guess init is the first time the Xserver is launched, and reinit is each time 
you return from some console switch ?

should we save the previous state and reset it on exiting X or something like that ?
Or will the fbdev driver automatically reinitialize the pm2 when you switch back to console mode ?

Friendly,

Sven LUTHER

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
