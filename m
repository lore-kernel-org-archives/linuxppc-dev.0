Message-Id: <200003110808.AA00070@shanghai.cityfujisawa.ne.jp>
From: Quan Qu <ququan@cityfujisawa.ne.jp>
Date: Sat, 11 Mar 2000 17:08:31 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: cdk building
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,everybody.I am new to this mail-list.

I am using Mr. wolfgang 's solution below on Redhat6.1  to build CDK.

>Summary: I've put the scripts I'm using to build the PPC Cross
>Development Kit for the MPC8xx CPUs on
>
>	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz
>
>or URL where I got the sources from:
>
>ftp://ftp.valinux.com/pub/support/hjl/binutils/binutils-2.9.5.0.22.t
ar.bz2
>ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-core-2.95.2.
tar.bz2
>ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-2.95.2.tar.b
z2
>ftp://ftp.sunet.se/pub/gnu/glibc/glibc-2.1.2.tar.gz
>ftp://ftp.gwdg.de/pub/linux/glibc/2.1.2/glibc-crypt-2.1.2.tar.gz
>ftp://ftp.sunet.se/pub/gnu/glibc/glibc-linuxthreads-2.1.2.tar.gz
>ftp://linuxppc.cs.nmt.edu/pub/mirror/PPC/embedded/mpc8xx-2.2.13.tgz
>	(renamed to linux-2.2.13.tar.gz)

I copy the downloaded gzip source to the /LinuxPPC/usr/src/tarballs
,and modify ENVIRONMENT.
then do:
make binutils
make egcs-core
make linux
make glibc
make egcs

everything go smoothly until I reach the glibc. I got linker error:
----------------------------------------------------------
a - elf/dl-addr.os
a - elf/dl-profstub.os
a - elf/dl-origin.os
: /LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/libc_pic.a
powerpc-linux-gcc   -nostdlib -nostartfiles -r -o
/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/elf/librtld.os '-Wl,-('
/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/elf/dl-allobjs.os
/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/libc_pic.a -lgcc '-Wl,-)'
/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/libc_pic.a(init-first.os): In
function
`_dl_start':
init-first.os(.text+0x128): multiple definition of `_dl_start'
/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/elf/dl-allobjs.os(.text+0x680):
first
defined here
/LinuxPPC/CDK/powerpc-linux/bin/ld: Warning: size of symbol
`_dl_start' changed
from 568 to 48 in init-first.os
collect2: ld returned 1 exit status
gmake[4]: *** [/LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/elf/librtld.os]
Error 1
----------------------------------------------------------
it seems that /LinuxPPC/CDK/powerpc-linux/bin/ld can not handle
the dynamic link libary.Does anyone have the same failure ?
and any suggestion? thanks


----
Quan Qu  ququan@cityfujisawa.ne.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
