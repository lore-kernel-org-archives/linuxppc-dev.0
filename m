From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15370.44910.527310.435748@argo.ozlabs.ibm.com>
Date: Mon, 3 Dec 2001 09:47:10 +1100 (EST)
To: Martin Costabel <costabel@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
In-Reply-To: <3C0AA2AF.97E7FCB4@wanadoo.fr>
References: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
	<3C08CFF0.18A1FBC7@wanadoo.fr>
	<15369.65261.546405.15780@argo.ozlabs.ibm.com>
	<3C0AA2AF.97E7FCB4@wanadoo.fr>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel writes:

> I did some tests with the 2 useful modes of the 6400: 1024x768x8bit at
> 72Hz (vmode 15, cmode 8) and 800x600x16bit at 60Hz (vmode 10, cmode 16).
>
> The results, with or without Tom's patch, were the same as they always
> were:
> The vmode of MacOS is used by the Linux console; the cmode 16 is not
> recognized, so instead of vmode 10 16 one always gets vmode 10 8 as
> default. The log says
>
> kernel: Monitor sense value = 0x62b, <6>using video mode 10 and color
> mode 0

Ben H has just pointed out to me that macos stores some extra
device-tree properties in nvram, and uses that to store the default
resolution and depth.  For the control display, it uses a "gprf"
property, 8 bytes long, and in fact the 2nd and 3rd bytes are what we
are looking at.  Unfortunately OF doesn't add the nvram properties to
the device tree, but Ben seems to think we can add code to do that in
the kernel.

So it would be very interesting to see a dump of nvram on your machine
with the screen set to the different resolution/depth settings in
macos.  Also, if you have the DisplayNameRegistry app under macos,
open it and look at the properties on the valkyrie and see if there is
one with a little "chip" icon (looks like a 6-legged insect to me but
apparently it is supposed to be a chip :).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
