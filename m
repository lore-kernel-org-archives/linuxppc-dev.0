Message-Id: <200005120507.HAA02656@denx.local.net>
To: "Shuangjun Zhu" <r44089@email.sps.mot.com>
cc: "Lucinda Schafer" <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help about the libc-2.1.1 segmentation fault 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 May 2000 09:05:32 +0800."
             <001e01bfbbae$2d0e03a0$69f001dc@sjzhu.sps.mot.com>
Date: Fri, 12 May 2000 07:07:52 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001e01bfbbae$2d0e03a0$69f001dc@sjzhu.sps.mot.com> you wrote:
>
> Firstly, thank you for your kind help.
> In fact, my root file system is libc-1.99.so.  It assures me to begin to
> work.
> I build another file system to test the libc-2.1.1.so. It likes
>            ----  lib/libc-2.1.1.so
>           |
> /mnt ----------  bin -------- hello.dynamic, which built with libc-2.1.1.so
> library
>           |              |--- hello.static, which built with static library
>           |
>           ------ sbin/

Combining libc5 (1.99) and libc6 (2.1.x) withing one  system  is  not
easily done.

The only way I got  this  working  is  _strict_  separation  of  both
environments; separate directories is not enough.

Try the following: install a STATICALLY linked shell  (for  instance,
sash)  as  /mnt/bin/sh;  then  run "chroot /mnt /bin/sh", so that you
have a staicallly linked shell  running  in  a  chrooted  environment
where   ONLY  libc-2.1.x  files  (binaries,  libraries,  loader)  are
visible.

This way I've been testing my 2.1.x (x=1, 2 and 3) libs and  binaries
for a while.

Works fine for me, hope it helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
C++ was an interesting and valuable experiment, but we've learned its
lessons and it's time to move on.
                            - Peter Curran in <DCqM4z.BxB@isgtec.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
