Date: Tue, 25 Jul 2000 09:10:17 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: daenzerm@student.ethz.ch
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <397D5639.97BCD510@relog.ch>
Message-ID: <Pine.LNX.4.21.0007250902380.1123-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> > > > For some reason I can not get any other mode to work (i.e.
> > > > 640x480,1024x768, 800x600).  If any would fail I would expect it to be
> > > > 1280x1024 not the smaller modes.  I have no modelines defined, just
> > > > letting XF86 decided which modes to use.  Any ideas why the defaults
> > > > don't work?
> > >
> > > Look at the log. There should be a reason for every rejected mode.
> >
> > There aren't any rejected modes.
>
> How exactly do they not work then?
>
> > I think the suggestion taht I use fbset to create modelines is right on.
>
> Try it, but I think if that was the problem your modes would get rejected. Do
> you use Option "UseFBDev"?

Your right, didn't work.  I still can use only 1280x1024, the other modes
are definetely screwed up when I cycle through them although I am using
modelines taken from fbset -x.  So I don't know what's wrong.  Some modes
are rejected but all of these should be rejected (1600x1200, ...)  It
definetely s finding modes it thinks are OK (or using my modelines) but it
isn't working.



>
>
> > > > First how do I find out the bus address of my internal video?  It
> > > > doesn't show up in /proc/pci although it is in /proc/fb.  This is on a
> > > > highly upgraded powercenter.
> > >
> > > If it's not in /proc/pci, the server probably doesn't bother about it
> > > either, so you shouldn't have to care.
> >
> > ahh, i think i see now.  By defining a fb device the fbdev driver will
> > figure it wou,
>
> Yes. If the internal video isn't the default framebuffer device (where the
> initial console comes up on), you'll have to add
>
> 	Option	"fbdev" "/dev/fb1"
>
yup, this was exactly what I needed, unfortunately althought i definetely
is finding this monitor it is not working either.  However I suspect this
is a monitor config issue and will keep working on it (or maybe try
another monitor).



> in its Device Section though.
>
> > unlike the r128 driver which wanted a bus id.
>
> Actually, the bus ID is needed there because the higher level PCI code of the
> X server will deactivate the chip otherwise. :)
>
> (it can't determine the connection between the PCI and framebuffer devices
> automatically)
>
>
> > how do I do fbset -x to see the modelines on the second monitor?
>
> There's an fbset option to select the framebuffer device, the second monitor
> is probably /dev/fb1 .

yup, found this is in the man page last night.

					thanks,
					john

PS As per earlier discussions of random lockups in linux that I thought
was related to either the frame buffer, X, or some people suggested sound
I was still getting this lockup wth XF864.01 (but it never happens if I am
not in my X console) However, I recompiled my kernel last night 2.2.17
from 2.2.14 so we shall see if that works out.




>
>
> Michel
>
>
>





--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
