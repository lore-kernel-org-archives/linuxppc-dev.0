Date: Sat, 13 Feb 1999 15:10:09 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brad Midgley <brad@pht.com>
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] some modes "default" solutions 
In-Reply-To: <Pine.LNX.3.95.990212150920.1876A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.4.02.9902131443500.1064-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 Feb 1999, Brad Midgley wrote:
> I have been experimenting to try to find out when and why modes "default"
> doesn't work with Xfb.
> 
> 1. modes default is incompatible with acceleration provided by Xfb.
> problems range from messed up colormaps to a white screen pocked with
> artifacts. if you need modes default, turn off acceleration:
> 
> Section "Device"
>     Identifier "Linux Frame Buffer Device"
>     Option "noaccel"
> EndSection

That's strange. I have no explanation for that.

> 2. if you run vmode and it reports something like "0 32" for the current
> mode, Xfb will come up with an oversize virtual screen if it's run with
> modes default. however, if vmode comes up with something like "15 32" then
> the virtual screen size will match the real screen size. 

By default atyfb enables a virtual screen to speed up text scrolling.
With `mode default' XF68_FBDev will use this virtual screen, unless you
override the virtual screen size with `Virtual x y' in your XF86Config.

> unfortunately, the os is not setting the first parameter correctly at
> startup, so the only way to have vmode return something sensible is to use
> it to set the value, eg by running vmode 15 32 at startup.
> 
> i am going to look into why the os isn't setting the first value properly.

Vmode returns `0' for the video mode if you're using a mode that's not one of
the 20 MacOS modes.

But you're right: the vertical virtual screen size must not be considered to
find out the MacOS vmode number. What about

--- drivers/video/macmodes.c.orig	Sun Jan 24 15:04:06 1999
+++ drivers/video/macmodes.c	Sat Feb 13 15:09:19 1999
@@ -363,7 +363,7 @@
 	const struct mac_mode *mode = mac_modes_inv[i];
 	if (var->xres > mode->xres || var->yres > mode->yres)
 	    continue;
-	if (var->xres_virtual > mode->xres || var->yres_virtual > mode->yres)
+	if (var->xres_virtual > mode->xres)
 	    continue;
 	if (var->pixclock > mode->pixclock)
 	    continue;

> i'm observing both these behaviors on an imac and on a powermac 7500 with
> an ati xclaim vr board. 

Both use atyfb.

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
