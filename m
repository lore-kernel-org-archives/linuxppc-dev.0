To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flash writing with Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Mar 2001 10:57:20 +0100."
             <3AB1E380.7E88EC47@esd-electronics.com>
Date: Fri, 16 Mar 2001 11:37:05 +0100
Message-Id: <20010316103710.64844281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AB1E380.7E88EC47@esd-electronics.com> you wrote:
>
> does anybody know if a flash writing tool for Linux is available ?

Which architecture, what type of flash?

> I want to update a flash image from a running Linux. The Linux is
> running from a ramdisk, so the flash can be erased and rewritten.

Yepp, that's what we do all the time.

> I think what I need are two thing: A device driver for accessing the
> flash and a command line tool for erasing and writing to the flash.

Please check the Patch "patch.drivers" (against PPC 2.4.3-pre3  tree)
in  ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/ or have a look at
our source snapshot at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.3-pre3-2001-03-11.tar.bz2

It includes a character device driver for CFI (AMD chips)  and  JEDEC
(Intel  chips) compliant flash types. So far, this has been tested on
big-endian systems (PowerPC only),  but  I  would  be  interested  in
receiving feedback for other architectures as well.

Of course there are also user  utilities  to  erase  the  flash.  For
writing no special tool is needed - just copy to the device (in fact,
if your write block size is a multiple of the erase block size of the
chips  the  driver  performs  an  auto-erase,  so  you don't need the
flash_erase command either).

Hope this helps - feel free to ask  if  there  are  any  question  or
problems.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If in any problem you find yourself doing an immense amount of  work,
the answer can be obtained by simple inspection.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
