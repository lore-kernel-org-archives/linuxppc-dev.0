Subject: Re: R128 Scaling.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <878z7nuamf.fsf@hades.nocrew.org>
References: <878z7nuamf.fsf@hades.nocrew.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Apr 2002 15:20:30 +0200
Message-Id: <1018963230.1590.2438.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-04-16 at 13:49, Stefan Berndtsson wrote:
>
> When running XF4.2, without UseFBDev, scaling is no longer available, which
> makes sense if it's a patch in the framebuffer.

XFree86 4.2 does support scaling on its own, but you need to provide it
the panel resolution, as should be visible in the log.

> When running something in DGA (xmame for example), with XF4.1 and UseFBDev,
> the resolution is changed by MAME, but it seems it still gets the fullsize
> resolution passed to it, because it draws completely distorted graphics.
> The area indicates that 1024x768 is passed as resolution even though the
> display is set to 640x480 using scaling.

Or maybe it wrongly uses a 640 pitch? The virtual width is always 1024.

This could be a bug either in the X driver's DGA support or xmame.


> It would be very nice to be able to run MAME and other programs in
> fullscreen. :)

Note that fullscreen doesn't require DGA per se. Direct framebuffer
access is generally slow, xmame might be better off using normal X
images or pixmaps and relying on an optimized ImageWrite acceleration in
the driver.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
