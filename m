Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DE0@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Access u-boot environment variables from Linux 
Date: Mon, 14 Jul 2003 11:05:47 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

I will start at the beginning, as I should have...

We will have multiple configurations of our target hardware (with/without
modem, no. of uarts, PCMCIA, USB and more...).

I would like the manufacturing to burn the H/W configuration and MAC to the
flash, and the TQ860L probably at 0x3ff00.  They will also burn u-boot,
kernel, ramdisk and jffs2 partitions.  We will provide a raw file for
programming, and they will modify the H/W configuration and MAC area.

I would like u-boot to read this data (H/W configuration and MAC) and put it
into environment variables.  I would like to read and modify those variables
from Linux user space.

We use MTD for updating the kernel, ramdisk, jffs2.  But, I can not (or
don't know how) the get access to the u-boot environment variables with MTD.
I have an MTD patch from Nye (Zuma networks) to do exactly that, but I did
not test it yet on kernel 2.4.4.

So I thought to use MTD for remote update and jffs2, and your patch to
busybox to get access to u-boot variables.

Regarding SELF:
I find it easier to use SELF.  We use ELDK for development and tests, but
for creating the final target images, SELF is great.

We added our own applications and module and libraries from work done with
ELDK like openssl and mgetty.  So we updated the SELF scripts to reflect new
kernel and libraries (2.2.5) and MTD from ELDK .

If there is a better/easier  way to get access to H/W configuration data
from Linux user space I will be glad to learn.

Now that I have read the README file in /tools/env I don't need the old
/dev/flasha anymore - Thanks :).

Thank you,
Eli Brin


I would like to get the H/W configuration

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Monday, July 14, 2003 12:05 AM
To: Eli Brin
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: Access u-boot environment variables from Linux


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163F5DDD@rokonet-e.rokonet.co.il>
you wrote:
>
> I have configure the config.mk.TQM860L_FEC file with: HAVE_FLASH_ENV =
> yes.

I thinkthis file is referring to a _very_ old version  of  the  Linux
kernel.  You'd  better use the Linux kernel and the SELF package that comes
included with the ELDK, or use the top of our CVS tree.

> modprobe: modprobe: Can't locate module char-major-60
> /dev/flasha: No such device
>
> I can see all /dev/flasha and others.
>
> The kernel is the default TQM860L_FEC  from the ELDK (not from SELF,
> but should be the same).

Grrrgh...

Your description gives no indication of what you're trying to do, and what
you're doing. Please note, that you have  two  options  for  the flash
driver:  the  old,  non-standard  character  device  interface [/dev/flash*]
(which is there just for  backward  compatibility  with some  existing
projects, and because it supports a mmap() interface),
or   you   can   use   the   standard   MTD   interface   [/dev/mtd*,
/dev/mtdblock*].

>From your description I think you want to use the MTD interface.

The  MTD  interface  is  also  what  is  being   used   the   default
configurations of our current kernel trees.

If I guess right, you want to access /dev/mtd*, not /dev/flash*


Also, judging from the subject of your posting, you  should  probably read
the "tools/env/README" file in the U-Boot source tree.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de A wise
person makes his  own  decisions,  a  weak  one  obeys  public
opinion.                                           -- Chinese proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
