Message-ID: <39092B2B.249FFC07@student.ethz.ch>
Date: Fri, 28 Apr 2000 08:09:47 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004280051.RAA20647@pop3.ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:
>
> >
> >  Yes it would work, there is a problem with the approach taken by
> > fbdev/glint, the BusID info isn't used at all there for the choise
> > of the device to be opened, without the fbdev option you always
> > get /dev/fb0 which might not be what you want.
>
> According to the XFree 4 documentation, the BusID determines the device, and
> thus the framebuffer used, even in the case of fbdev. So I'm kinda confused.

This doesn't apply to framebuffer devices, I guess it's about the PCI devices.
There's currently no safe way to find the corresponding fbdev for a given PCI
device and vice versa. But it's being worked on.


> > Here is a small patch (untested) that changes r128 to use the "fbdev"
> > option instead of using BusID to get the fbdev device.
> > If the BusID and fbdev options don't match bad things will happen
> > so be carefull there.
> > For people that don't have more than one r128 card the previous behaviour
> > works better so don't use it...
>
> If I apply your patch and recompile, how should I modify the config file?
> Get rid of all BusID's? Just for the second monitor?

I suggest always giving all BusIDs, it doesn't hurt as long as BusID and fbdev
match.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
