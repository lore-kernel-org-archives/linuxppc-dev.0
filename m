Message-ID: <37E1F2FF.BAA72804@broadlink.com>
Date: Fri, 17 Sep 1999 07:51:27 +0000
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: Dan Malek <dmalek@jlc.net>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with initrd on linux-2.3.18
References: <199909171404.QAA25414@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> 
> Hi,
> 
> I'm trying to get linux-2.3.18 running on  a  MPC850  system;  should
> this be working, or should I better stick with embedded-2.2.5?
> 
> The main problem I'm strugging with is loading the initrd.
> 
> My modified boot loader works, the kernel starts and finds all  para-
> meters and memory, it finds the compressed initrd image, uncompresses
> it,  but  then  it  does  not  run /linuxrc, nor can it find /init or
> /bin/sh, so it crashes with `Kernel panic: No init found'.

I had the exact same problem with the 2.3.10 kernel a while back.  It would
uncompress the ramdisk ok, but wouldn't start any of /linuxrc, /sbin/init,
/etc/init, /bin/sh. I tried hacking various things hoping to stumble on
something that would just make it work, but ended up reverting back to 2.2.5. 

> 
> The  problem  seems  to  be  in  drivers/block/rd.c:  the  gunzip  in
> crd_load()  returns  ok,  so  crd_load() return 0 to rd_load_image(),
> where we `goto successful_load'. There infile.f_op->release points to
> initrd_release(), which is  called:  it  releases  the  initrd,  sets
> initrd_start=0,  and  this  causes  init/main.c  to think there is no
> initrd.
> 
> Any ideas what's going on here?

Linux can't do much if it can't run init ;-)  

On a somewhat related sidenote, is there any work being done to access
FLASH from within Linux, either as a file or a filesystem (or anything)?
It would be *very* useful to read/store machine-specific configuration data 
IP address, etc) and/or update the kernel/initrd boot image remotely.
I hear uC/Linux has a FLASHFS for certain Motorola ColdFire CPU boards.

-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
