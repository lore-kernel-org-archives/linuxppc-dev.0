Message-ID: <001e01bfbbae$2d0e03a0$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Lucinda Schafer" <lucsch@adaptivemicro.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Help about the libc-2.1.1 segmentation fault
Date: Fri, 12 May 2000 09:05:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Firstly, thank you for your kind help.
In fact, my root file system is libc-1.99.so.  It assures me to begin to
work.
I build another file system to test the libc-2.1.1.so. It likes
           ----  lib/libc-2.1.1.so
          |
/mnt ----------  bin -------- hello.dynamic, which built with libc-2.1.1.so
library
          |              |--- hello.static, which built with static library
          |
          ------ sbin/

1. static library application, use ld-2.1.1.so and libc-2.1.1.so load
bash# /mnt/lib/ld.so.1 --library-path /mnt/lib /mnt/hello.static
Segmentation fault

2. static library application, run under libc-1.99.so
bash# /mnt/hello.static
Hello, world

3. dynamic library application, use ld-2.1.1.so and libc-2.1.1.so load
bash# /mnt/lib/ld.so.1 --library-path /mnt/lib /mnt/hello.dynamic
Segmentation fault

4. dynamic library application, use ld.so.1 and libc-1.99.so load
bash# /mnt/hello.dynamic
/mnt/hello.dynamic: error in loading shared libraries
: undefined symbol: __libc_start_main

So, any suggestion?

Does anyone use libc-2.1.1 on MPC8xx-2.2.13-linux ?

-Shuangjun
    -----Original Message-----
    From: Lucinda Schafer <lucsch@adaptivemicro.com>
    To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>
    Date: Thursday, May 11, 2000 9:18 PM
    Subject: RE: Help about the libc-2.1.1 segmentation fault


    Your dynamic linker is still looking for libc-1.99.so, perhaps...

    For example, if your libraries are in /usr/local/powerpc-linux/lib and
your program is named "program", try running it by using

    /usr/local/powerpc-linux/lib/ld.so.1  --library-path
/usr/local/powerpc-linux/lib ./program

    If your program runs this way, that's your problem.

    -----Original Message-----
    From: Shuangjun Zhu [mailto:r44089@email.sps.mot.com]
    Sent: Wednesday, May 10, 2000 10:28 PM
    To: linuxppc-embedded@lists.linuxppc.org
    Subject: Help about the libc-2.1.1 segmentation fault




    Hello, everyone

    On a MPC823 FADS board, I run the mpc8xx-2.2.13 kernel.
    With the libc-2.1.1.so or libc-2.1.3.so, every application happened
        "Segmentation fault"
    But if I compile the "hello world" program with  statically
    linked library, or if I use the libc-1.99.so, there is no error.
    Can I upgrade the libc to 2.x.x?

    BTW, I have patched the linux kernel 2.3.33 FPU emulation patch.

    So, what's wrong?

    Thanks in advanced!

    BRs,
    Shuangjun


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
