Message-ID: <397D5639.97BCD510@relog.ch>
Date: Tue, 25 Jul 2000 10:56:25 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
References: <Pine.LNX.4.21.0007241055570.1920-100000@johngrimes.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Grimes wrote:

> > > For some reason I can not get any other mode to work (i.e.
> > > 640x480,1024x768, 800x600).  If any would fail I would expect it to be
> > > 1280x1024 not the smaller modes.  I have no modelines defined, just
> > > letting XF86 decided which modes to use.  Any ideas why the defaults
> > > don't work?
> >
> > Look at the log. There should be a reason for every rejected mode.
>
> There aren't any rejected modes.

How exactly do they not work then?

> I think the suggestion taht I use fbset to create modelines is right on.

Try it, but I think if that was the problem your modes would get rejected. Do
you use Option "UseFBDev"?


> > > First how do I find out the bus address of my internal video?  It
> > > doesn't show up in /proc/pci although it is in /proc/fb.  This is on a
> > > highly upgraded powercenter.
> >
> > If it's not in /proc/pci, the server probably doesn't bother about it
> > either, so you shouldn't have to care.
>
> ahh, i think i see now.  By defining a fb device the fbdev driver will
> figure it wou,

Yes. If the internal video isn't the default framebuffer device (where the
initial console comes up on), you'll have to add

	Option	"fbdev" "/dev/fb1"

in its Device Section though.

> unlike the r128 driver which wanted a bus id.

Actually, the bus ID is needed there because the higher level PCI code of the
X server will deactivate the chip otherwise. :)

(it can't determine the connection between the PCI and framebuffer devices
automatically)


> how do I do fbset -x to see the modelines on the second monitor?

There's an fbset option to select the framebuffer device, the second monitor
is probably /dev/fb1 .


Michel


--
UNIX is like Sex:
If you don't know it, you don't miss it. But if you know it, you'll need it.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
