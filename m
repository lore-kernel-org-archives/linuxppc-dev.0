To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: autoboot with initial RAM disk 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Dec 2001 15:44:51 +1100."
             <B164B53F5BD6D511888D009027732E1A0249CB@ntserver.act.domain>
Date: Fri, 21 Dec 2001 09:49:30 +0100
Message-Id: <20011221084935.0CEFB10E21@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B164B53F5BD6D511888D009027732E1A0249CB@ntserver.act.domain> you wrote:
>
> I am using ppcboot to start my 8260 based card. At the moment, we load Linux
> kernel via tftp and then start it. Linux kernel maps its root file system
> over the network. This works fine qith ppcboot autoboot feature.
>
> Now, we want to put initial RAM disk into RAM as well as compressed kernel.
> Do do that, both images have to be copied into card's memory using tftp and
> them bootm command will be used with two arguments to start kernel.
>
> To continue to use ppcboot autoboot feature we have to pass two commands as
> boot command (to tftp two kernels) and then issue bootm command with two
> arguments. Is there any way of doing it without altering the ppcboot source
> code?

There are many ways.

First, you can define a complex boot sequence  in  one  command,  for
instance like this:

=> setenv bootcmd tftp 100000 /tftpboot/pImage\;tftp 200000 /tftpboot/pRamdisk\;bootm 100000 200000

You can also get the IP configuration in the first step for instance using DHCP and then re-use this:

=> setenv bootcmd dhcpboot 100000\;tftp 200000 /tftpboot/pRamdisk\;bootm 100000 200000

etc.

But the most simple way is to combine the kernel and  ramdisk  images
into one PPCBoot image (using the "multi-file image" format) and just
use this:

=> setenv bootcmd tftp 100000 /tftpboot/pMulti\;bootm 100000

See the SELF Makefile for example how to build multifile images.  You
can find our Simple Embedded Linux Framework at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/SELF-2001-12-13-2335.tar.bz2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Far back in the mists of ancient time, in the great and glorious days
of the former Galactic Empire, life was wild, rich  and  largely  tax
free.         - Douglas Adams, _The Hitchhiker's Guide to the Galaxy_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
