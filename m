To: sruel@oerlikon.ca
Cc: Scott Anderson <scott_anderson@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RPX-CLLF & Flash root filesystem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Oct 2001 17:50:37 EDT."
             <3BD5E62D.8000807@oerlikon.ca>
Date: Wed, 24 Oct 2001 00:55:05 +0200
Message-Id: <20011023225510.6AE3510CD6@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD5E62D.8000807@oerlikon.ca> you wrote:
>
> initrd.txt is only part of the answer. I'm missing info on how to tell
> Linux where to fetch the root filesystem.

This depends on how you load and boot Linux.

> Once a minimal/functional root filesystem has been created (and
> compressed), you have to put it somewhere in the Flash memory (just like
> the Linux image).

When using the "standard" bootloader method, you will run

	make zImage.initrd

which builds a  binary  image  that  contrains  the  bootloader,  the
compressed  Linux kernel image, and the (compressed) ramdisk image as
one file, "zImage.initrd".

With PPCBoot, you can build your kernel and ramdisk images separately
or optionally combine them as one file.

> When the system boots, it needs to "see" this root filesystem that is
> inside the flash.

The bootloader takes care of passing the  correct  arguments  to  the
Linux kernel.

With PPCBoot you pass the addresses of both images  as  arguments  to
the "bootm" command.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To the systems programmer,  users  and  applications  serve  only  to
provide a test load.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
