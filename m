To: "AlessandroPPC" <aleppcrossi@libero.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ram root filesystem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Dec 2003 18:48:44 +0100."
             <019501c3b9c5$b339a060$0400a8c0@eurostudio.local>
Date: Wed, 03 Dec 2003 19:16:08 +0100
Message-Id: <20031203181613.75859C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Alessandro,

in message <019501c3b9c5$b339a060$0400a8c0@eurostudio.local> you wrote:
>
> To do this I have generated a ramdisk image derived from ELDK fs eliminating
> superfluous packages and using a makefile with

Question 1: why don't you use the  much  simpler  and  smaller  setup
based  on  the  SELF  ramdisk  example  image included with the ELDK?
Please see http://www.denx.de/twiki/bin/view/DULG/HowToAddFiles

>  dd if=/dev/zero of=$(RAMFS)/ramrootfs bs=1k count=36864
>  mke2fs -F -m0 $(RAMFS)/ramrootfs
>  mount -o loop -t ext2 $(RAMFS)/ramrootfs $(RAMFS)/tmp

Question 2: Why don't you simply use the genext2fs  tool  that  comes
included  with  the  ELDK?  It  is much simpler, and requires no root
permissions to create a ramdisk image.

> At this point the system boots and the kernel mounts the ram disk but at
> time of rc.sysint script I have this error :
...
> Notice that if  I write  rc.sysinit script to skip "Checking root
> filesystem" I obtain the prompt but the syslogd deamon fails the startup.

The "rc.sysint" was never meant to be used from a ramdisk based  root
filesystem.  If  you  change  your configuration, you are expected to
adapt all related config files and init scripts, too.

> Someone can say why fsck is not able to check ram fs and if the syslogd
> problem is related to ram fs?

It makes no sense to run fsck on  a  ramdisk  image  which  was  just
unpacked.  Also,  IMHO  it  makes littlee sense to use the full-blown
SysV init style scripts in an embedded system which is running from a
ramdisk image.

Have a look at the ELF image thatis included with the ELDK,  and  use
this as a base.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When all is said and done, more is said than done.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
