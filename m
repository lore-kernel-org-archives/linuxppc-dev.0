To: James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't acces s tt y; job control turned off 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 12 Jan 2003 15:58:30 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC0603B@SNCMAIL>
Date: Sun, 12 Jan 2003 23:39:34 +0100
Message-Id: <20030112223939.26B2CC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC0603B@SNCMAIL> you wrote:
>
> 2.) I added line "ttyS1::askfirst:-/bin/sh" to inittab ... and I get
> "Bummer, can't open /dev/ttyS1" ... which was funny enough to make me blow
> coffee out my nose ... whats this tty normally used for?

It is you who defines the use of the serial ports on your board -  we
cannot answer this question.

> 3.) I added line "ttyS0::askfirst:-/bin/sh" to inittab ... and that seems to
> work ...
>
> Three leads to a question ... here it is ...
>
> Should I change 'libbb.h' to open /dev/ttyS0 instead of ttyS ... see line

You probably don't want to make your ramdisk  image  dependend  on  a
specific  board / tty use.

If you look closer at our ELDK you will find that it contains a small
modification to  "login"  (calling  of  TIOCSCTTY  ioctl)  which  was
necessary  to  allow  for  using  /dev/console  as the default serial
console device specified in inittab. See the
build/target_rpms/util-linux/SOURCES/login-eldk.patch
file in the ELDK build environment.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing in progression can rest on its original plan. We may as  well
think  of  rocking  a grown man in the cradle of an infant.
- Edmund Burke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
