Message-ID: <397D98EC.2E9C36C3@relog.ch>
Date: Tue, 25 Jul 2000 15:41:00 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
References: <Pine.LNX.4.21.0007250902380.1123-100000@johngrimes.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Grimes wrote:

> > > > > For some reason I can not get any other mode to work (i.e.
> > > > > 640x480,1024x768, 800x600).  If any would fail I would expect it to
> > > > > be 1280x1024 not the smaller modes.  I have no modelines defined,
> > > > > just letting XF86 decided which modes to use.  Any ideas why the
> > > > > defaults don't work?
> > > >
> > > > Look at the log. There should be a reason for every rejected mode.
> > >
> > > There aren't any rejected modes.
> >
> > How exactly do they not work then?
> >
> > > I think the suggestion taht I use fbset to create modelines is right on.
> >
> > Try it, but I think if that was the problem your modes would get rejected.
> > Do you use Option "UseFBDev"?
>
> Your right, didn't work.  I still can use only 1280x1024, the other modes
> are definetely screwed up when I cycle through them although I am using
> modelines taken from fbset -x.  So I don't know what's wrong.  Some modes
> are rejected but all of these should be rejected (1600x1200, ...)  It
> definetely s finding modes it thinks are OK (or using my modelines) but it
> isn't working.

So it looks like that bug still isn't fixed.

Ani, Ben, Kostas, Kevin: Any reason the r128 driver can't use fbdevhw to set
up modes? (like glint)


> > If the internal video isn't the default framebuffer device (where the
> > initial console comes up on), you'll have to add
> >
> >       Option  "fbdev" "/dev/fb1"
> >
> yup, this was exactly what I needed, unfortunately althought i definetely
> is finding this monitor it is not working either.  However I suspect this
> is a monitor config issue and will keep working on it (or maybe try
> another monitor).

Does the console work there? If yes, just don't specify any modelines and it
will use the console mode.

And beware: With Xinerama, all screens must have the same depth...


Michel


--
The three Rs of Microsoft support: Retry, Reboot, Reinstall.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
