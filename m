Message-ID: <19990120154321.N3026@maxime.u-strasbg.fr>
Date: Wed, 20 Jan 1999 15:43:21 +0100
From: Sven LUTHER <luther@maxime.u-strasbg.fr>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        luther@dpt-info.u-strasbg.fr
Cc: Michel Daenzer <michdaen@iiic.ethz.ch>, nardinoc@CS.UniBO.IT,
        Linux/APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [pm2fb] update 990110 - first public release ;)
Reply-To: luther@dpt-info.u-strasbg.fr
References: <19990120144929.E3026@maxime.u-strasbg.fr> <Pine.LNX.4.03.9901201514370.24625-100000@mercator.cs.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.03.9901201514370.24625-100000@mercator.cs.kuleuven.ac.be>; from Geert Uytterhoeven on Wed, Jan 20, 1999 at 03:17:26PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 20, 1999 at 03:17:26PM +0100, Geert Uytterhoeven wrote:
> On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > On Wed, Jan 20, 1999 at 02:37:20PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 20 Jan 1999, Sven LUTHER wrote:
> > > > > > > Yes. The X server must not do video mode initialization, but call the frame
> > > > > > > buffer device instead.
> > > > > > 
> > > > > > what then is the stuff you initialize in the mach64 accel init stuff ?
> > > > > 
> > > > > Like you say, that's _accel_ _engine_ init stuff, not _graphics_ _engine_ init
> > > > > stuff. The graphics engine takes care of the video mode (programmed in the
> > > > > fbdev in the kernel), while the X server has to program the accel engine.
> > > > 
> > > > in the case of the permedia 2, the engine is only one long pipeline, so the graphic and
> > > > accel engine are the same ?
> > > 
> > > Are you sure about that?
> > 
> > I think yes, all units are in one pipeline, the same for 2D and 3D, and only this units are documented in
> > the TI docs, but then i guess by graphic engine you mean the one responsible for 
> > sending data to the monitor ? it is the last unit of the pipeline.
> 
> I don't have the Permedia2 docs here, but I don't see any reason why the
> graphics engine is supposed to be at the end of the pipeline. You don't change
> the graphics engine configuration when drawing data, you have to initialize the
> video mode (pixel clock, resolution, timings) only once.

i guess we are not speaking about the same things then, ... i will have to look at the docs again.

> Yes. But if you want to use the accel engine in X, you have to implement the
> reinit function. Well, that's XF68_FBDev, XF86_SVGA automagically does this :-)

One more reason to go with XF86_SVGA, isn't it ?

Friendly,

Sven LUTHER

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
