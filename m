To: Walser Martin <walser.martin@rw.hirschmann.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: what files should be included in initrd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 May 2001 07:49:35 +0200."
             <040944A92C91D211954D00C095EE82680168FF32@POST>
Date: Wed, 09 May 2001 09:02:07 +0200
Message-Id: <20010509070212.1FF202814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <040944A92C91D211954D00C095EE82680168FF32@POST> you wrote:
>
> sorry for this question, but it's the first time I try to use linux on my

It's a good question, but it has been asked many, many times before.
See http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-13.html#ss13.2
and http://www.linux.org/docs/ldp/howto/Bootdisk-HOWTO/buildroot.html

> I'm using PPCBoot and the MontaVista kernel. Both work fine, but I don't
> know how to make a initrd image.

See "Documentation/initrd.txt" in your Linux source directory.

> Can someone give me a short overwiew on how to build such an image and what
> files should be included?

You include those files you need in your embedded system. The minimum
(without any tricks and modifications  to  the  Linux  kernel)  is  a
special  file  for  /dev/console (c 5 1) and a regular file with your
statically linked application that is started as init process.

See ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SIMPLE-PPCBOOT-ramdisk for
an example - this is a PPCBoot image ready for use; you can use

	dd if=SIMPLE-PPCBOOT-ramdisk bs=64 skip=1 of=ramdisk.image.gz

to create a "normal" ramdisk image.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women, and engi-
neers. While the first two are more pleasant, the third is by far the
more certain."                           - Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
