Message-ID: <382B8585.D3922B01@263.net>
Date: Fri, 12 Nov 1999 11:12:05 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: TiVo Webmaster <webmaster@tivo.com>
Cc: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TiVo Kernel for 403GCX Update (was Re: Support for IBM CPUs?)
References: <NCBBKEJANBMELEFCJOGIGEKJDFAA.webmaster@tivo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i downloaded the toolchain from tivo/linux but failed to build it on my
i386 box. i have installed cross gcc for ppc-2.95.2 under 
    /usr/local/gcc-ppc.

below is what i did to build:
1. uncompress toolchain.tar.gz to my work directory
2. run libc-ppc/doConfig
3. create libc-ppc/configparms contains these lines:
   	  CC=/usr/local/gcc-ppc/bin/gcc
	  AR=/usr/local/gcc-ppc/bin/ar
	  RANLIB=/usr/local/gcc-ppc/bin/ranlib
	  AS=/usr/local/gcc-ppc/bin/as
	  LD=/usr/local/gcc-ppc/bin/ld
	  BUILD_CC=/usr/bin/gcc
4. run "make all" under directory "libc-ppc"
after a while, i was told something wrong:
mv -f /root/toolchain/libc-ppc/csu/crtn.s-new
/root/toolchain/libc-ppc/csu/crtn.s
/usr/local/gcc-ppc/bin/gcc -c  /root/toolchain/libc-ppc/csu/crti.s -o
/root/toolchain/libc-ppc/csu/crti.o
/usr/local/gcc-ppc/bin/gcc -c  /root/toolchain/libc-ppc/csu/crtn.s -o
/root/toolchain/libc-ppc/csu/crtn.o
/usr/local/gcc-ppc/bin/gcc ../sysdeps/powerpc/elf/crtbegin.S -c -I. -I..
-I../libio  -I/root/toolchain/libc-ppc -I../sysdeps/powerpo
/usr/local/gcc-ppc/bin/gcc ../sysdeps/powerpc/elf/crtend.S -c -I. -I..
-I../libio  -I/root/toolchain/libc-ppc -I../sysdeps/powerpc/o
make[2]: *** No rule to make target
`/root/toolchain/libc-ppc/csu/crtbeginS.o', needed by `others'.  Stop.
make[2]: Leaving directory `/root/toolchain/libc/csu'
make[1]: *** [csu/others] Error 2
make[1]: Leaving directory `/root/toolchain/libc'
make: *** [all] Error 2

i check the csu/Makefile and found the error may be caused by makefile.
so 
i build crtbegin.so by myself and copy to the right place and after
that i can go on. but another error appeared when build library of nss
and
nis. it seems it's also makefile's problem. 

is there something wrong in these steps? i think the makefile should
be correct and i must do something wrong. has anyone already build
libc-ppc 
successfully?





TiVo Webmaster wrote:
> 
> Got it done yesterday!
> 
> http://www.tivo.com/linux
> 
> enjoy,
> Richard Bullwinkle
> TiVo Webmaster
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
