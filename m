Date: Thu, 27 Apr 2000 16:35:53 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "W. Taylor Holliday" <wtholliday@ucdavis.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <39082033.38C75676@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0004271613030.8585-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Apr 2000, Michel Dänzer wrote:

>
> PS: I still think it should work with the r128 driver if it support the
> "fbdev" option...

 Yes it would work, there is a problem with the approach taken by
fbdev/glint, the BusID info isn't used at all there for the choise
of the device to be opened, without the fbdev option you always
get /dev/fb0 which might not be what you want.

Here is a small patch (untested) that changes r128 to use the "fbdev"
option instead of using BusID to get the fbdev device.
If the BusID and fbdev options don't match bad things will happen
so be carefull there.
For people that don't have more than one r128 card the previous behaviour
works better so don't use it...

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
