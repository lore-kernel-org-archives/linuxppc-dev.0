Message-ID: <39AA5944.18063A3F@student.ethz.ch>
Date: Mon, 28 Aug 2000 14:21:25 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: sprenger <sprenger@in.tum.de>
CC: Stefan Berndtsson <stefan@nocrew.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf4 and lombard
References: <39A5E3F7.1030409@in.tum.de> <87em3dyy5m.fsf@hades.nocrew.org> <39AA6F8C.50707@in.tum.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


sprenger wrote:
>
> > May I just ask.. how the heck did you get xf4 running on lombard? :)
> >
> > All I manage to get is a black screen and I can't do anything anymore.
> > The machine is still running, so I can reboot it via network.
> >
> > It's a lombard/333 running 2.4.0-test6.
> >
> > xf4 is compiled from sources found on a link from the instructions
> > at linuxppc.org and the rsynced version of the ati-driver, as of
> > about 17.00 CET 2000-08-25.
> >
> use yaboot as said. at the moment i am running  2.4.0-t7 paulus-kernel.
> sometimes i have some blue dots on my screen but  the rest is fine.
>
> i have also attached my xf86config-file. the values in the screen
> section were floating around in the net - do not ask me where i found
> them. as you see i do not use them, the ati-driver determines its own
> values and they are much better. comment out the lines with "Xkb..." i
> need them because of my german keyboard layout.

Let me comment on a few things:


>     SubSection  "extmod"
>         Option  "omit xfree86-dga"
>     EndSubSection

You normally want to replace this with just

    Load "extmod"

as DGA is deactivated otherwise. This is from an outdated example XF86Config,
way back somewhere at 3.9.x when DGA wasn't working yet.


>     DefaultDepth 24
>
>     SubSection "Display"
>         Depth           32
>         Modes           "1024x768"
>         ViewPort        0 0
>         Virtual         1024 768

These ViewPort and Virtual values are default for the specified mode and as
such not needed.

>     EndSubSection

There is no depth 32 in X 4. 32 bpp is depth 24, fbbpp 32. If you want 32 bpp,
add

    DefaultFbBpp 32

under the DefaultDepth line and

	FbBpp		32

in a Display Subsection for Depth 24. OTOH maybe it's the default anyway
(driver dependent), grep -i bpp /var/log/XFree86.0.log tells for sure.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
