To: gewrgiou@imbc.gr
Cc: daenzerm@student.ethz.ch, wtholliday@ucdavis.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: Your message of "Wed, 26 Apr 2000 16:54:44 +0300 (EEST)"
	<Pine.LNX.4.21.0004261635150.27506-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.21.0004261635150.27506-100000@idd-01.imbc.gr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000427015351E.roikawa@rr.iij4u.or.jp>
Date: Thu, 27 Apr 2000 01:53:51 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: XFree 4.0 dual monitor on AGP G4

> Thats what i use:
>
> Section "ServerLayout"
>         Identifier "Main Layout"
>         Screen "Screen 1"
>         Screen "Screen 2" LeftOf "Screen 1"
> EndSection
>
>  Unfortunately i don't think that it will work in this case,
> the second r128 will never be able to pick the right device
> (/dev/fb1 here) the BusID line is more or less ignored in the fbdev
> case so the second driver will open /dev/fb0 which will result
> in a kernel crash.
>
> Here is the related code from the xfree source, note the FIXME
> line there.....
>
> The only solutions for now (beyond fixing the code) is to use
> the unaccelerated fbdev driver for /dev/fb1,
Or export FRAMEBUFFER=/dev/fb0;startx;export FRAMEBUFFER=/dev/fb1;startx
(one server for each card like as XF68_FBDev) with r128 driver?

But if you don't want to be bothered by the fbdev, you can try

ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/xfree86/XFree86-4.0-mga-r128-v2.gz

WITHOUT Option "UseFBDev" nor "fbdev".
I'm using three heads(ATI and Matrox cards) with this server.

BTW, why do people like fbdev very much? It's easier to port XFree86
built-in drivers as Kostas mentioned before, and has advantages that
developers can port/update the server independent on the kernel, add
support the latest hardware without waiting for the kernel driver, etc.
This is just a thought, I may be wrong though.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
