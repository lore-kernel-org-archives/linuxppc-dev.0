Message-ID: <381912CE.9DB75640@263.net>
Date: Fri, 29 Oct 1999 11:21:50 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Andreas Tobler <a.tobler@schweiz.ch>,
        linux-ce-devel <linuxce-devel@linuxce.org>,
        linux-ppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: help, build Cross GCC
References: <38184905.117429CD@263.net> <38184DC8.6773D84D@schweiz.ch> <381878FB.8916CB9@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi, Dan:
i am now building a gcc for powerpc on i686. i have downloaded 
binutils-2.9.5.0.16 and gcc-2.95.2. i need the latest version of gcc
for i want to build program for powerpc403 and powerpc401.
and then, i first built binutils by these step:
1. decompress the binutils-2.9.5.0.16.tar to a temp directory.
2. chdir to that directory and run "./configure
--target=powerpc-linux-gnu"
3. run "make" and "make install"

after all these done, i build binutils to /usr/local/bin. 
next i begin to build gcc:
1. decompress the gcc-2.95.2 to another temp directory.
2. chdir to that directory and run "./configure
--target=powerpc-linux-gnu"
3. run "make" and "make install"

but this time, i failed. make told me it failed to find stdlib.h and
uinstd.h
when build libgcc2.a. then i tried to modify the Makefile and this line:
CFLAGS = -g -O2 -Dinhibit_libc

after run make, another error came out :-(
--------------------
checking for sys/time.h... yes
checking for sys/resource.h... yes
checking for sys/wait.h that is POSIX.1 compatible... no
checking whether the C compiler (/root/gcc-2.95.2/gcc/xgcc
-B/root/gcc-2.95.2/gcc/ -B/usr/local/powerpc-linux-gnu/bin/ -g -O2
-Dinho
configure: error: installation or configuration problem: C compiler
cannot create executables.
make[1]: Entering directory `/root/gcc-2.95.2/powerpc-linux-gnu/libio'
test x"no" != xyes ||\
  /root/gcc-2.95.2/gcc/xgcc -B/root/gcc-2.95.2/gcc/
-B/usr/local/powerpc-linux-gnu/bin/ -c -g -O2 -Dinhibit_libc -I. -I.
-D_IO_MTSAo
/root/gcc-2.95.2/gcc/xgcc -B/root/gcc-2.95.2/gcc/
-B/usr/local/powerpc-linux-gnu/bin/ -c -g -O2 -Dinhibit_libc -I. -I.
-D_IO_MTSAFEc
In file included from iogetline.c:26:
libioP.h:30: errno.h: No such file or directory
In file included from iolibio.h:1,
                 from libioP.h:47,
                 from iogetline.c:26:
libio.h:30: _G_config.h: No such file or directory
iogetline.c:27: string.h: No such file or directory
make[1]: *** [iogetline.o] Error 1
make[1]: Leaving directory `/root/gcc-2.95.2/powerpc-linux-gnu/libio'
make: *** [all-target-libio] Error 2
--------------------
somebody told me i must install lib and include file for the ppc first. 
but where to download them. 
do you think i still miss something.  would you please show me the right
step to build?

regards,
Wang



Dan Malek wrote:
> 
> Andreas Tobler wrote:
> 
> > Try here:
> > http://members.home.com/mmporter/linux/cross/
> 
> I have binaries for RedHat 5.2 Linux/x86 on ppc.kernel.org in
> the embedded directory.  It is a tar file called xppctools or
> something like that.  These load into /opt, so they are easy
> to remove if you want to do something else.  Just put the bin
> directory in your search path.
> 
> I believe this was the last EGCS version before the GCC merge.
> You will need to select your favorite libraries and include
> files, as those are not included.  It will build the kernel
> just fine.
> 
> It is something to get you started....
> 
>         -- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
