Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X
Date: Fri, 12 Oct 2001 14:13:58 -0400
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
References: <200110121647.f9CGlkY12389@aslan.scsiguy.com>
In-Reply-To: <200110121647.f9CGlkY12389@aslan.scsiguy.com>
MIME-Version: 1.0
Message-Id: <20011012181138.FUFA17332.tomts11-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> The old driver never issued more than 8 tags.  The new driver will
> attempt to dynamically determine the capabilities of the drive and can
> issue as much as 253 tags.  The algorithm used depends on the drive
> actually adhering to the SCSI spec and might fail on a buggy drive.  If
> you set the tag depth to 8 you may see similar behavior to the old
> driver.

> >> Perhaps the drive
> >> will function correctly if tagged queing is disabled for it.  You
> >> can do this only for target 1 with the "tag_info" option.  There may
> >> also be firmware updates for this drive.

Okay I used tag_info as you directed and set the Quantum Fireball drive to
use a maximum tag depth of 8 (like the old driver used) and everything
seems to work fine.

So can you point me to where in your driver code the depth of the tagged
queueing is dynamically determined?  I would like to play around a bit
with the driver code to see if I can tell if the Quantum Fireball is
simply spitting back bogus info or and if so what?

Thanks,

Kevin

> It is like the verbose option.  A sample modules.conf line might look
> like (assuming you are using a loadable module):
>
> options aic7xxx aic7xxx='"verbose.tag_info:{{253.8.16.92.0.0.0.0}}"'
>
> This sets the tag depth to 253, 8, 16, 92, and "don't do tags" for the
> targets 0, 1, 2, 3, and all others on adapter 0, respectively.  There is
> a comment section in the driver (I may have only updated it in 6.2.2 or
> 6.2.3) that discusses all of the driver options in detail.  The latest
> driver is 6.2.4.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
