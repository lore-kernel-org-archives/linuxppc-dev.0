Message-ID: <015701bfbf06$cc8dfe70$bf0102c8@dell191.sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: question about compiling glibc2.1.3
Date: Tue, 16 May 2000 15:17:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,
I am compiling my glibc2.1.3 using my own cross-compiler tool set.
I have passed the compiling stage, but there comed a problem during the
linkink stage.
the error is below:

powerpc-linux-gcc   -shared -Wl,-O1 -o
ysdeps/../libc.so  -Wl,-dynamic-linker=/
home/lhx/lib/ld.so.1 -Bsysdeps/../csu/  -Wl,-soname=libc.so.6  -nostdlib -no
star
tfiles -e __libc_main -u
__register_frame -L. -Lsysdeps/../math -Lsysdeps/../elf
 -Lsysdeps/../nss -Lsysdeps/../nis -Lsysdeps/../db2 -Lsysdeps/../rt -Lsysdep
s/..
/resolv -Lsysdeps/../linuxthreads -Wl,-rpath-link=.:sysdeps/../math:sysdeps/
../e
lf:sysdeps/../nss:sysdeps/../nis:sysdeps/../db2:sysdeps/../rt:sysdeps/../res
olv:
sysdeps/../linuxthreads -Wl,--whole-archive sysdeps/../elf/soinit.os
sysdeps/../
libc_pic.os sysdeps/../elf/sofini.os sysdeps/../elf/interp.os
sysdeps/../elf/ld.
so  -lgcc
/home/lhx/powerpc-linux/bin/ld: sysdeps/../libc.so: undefined versioned
symbol n
ame pthread_attr_init@@GLIBC_2.1
/home/lhx/powerpc-linux/bin/ld: failed to set dynamic section sizes: Bad
value
collect2: ld returned 1 exit status
powerpc-linux-gcc: file path prefix `sysdeps/../csu/' never used
make: *** [sysdeps/../libc.so] Error 1

The linker said it can't find the definition of
pthread_attr_init@@GLIBC_2.1
But I have seen the definition for it in the file
../glibc2.1.3/linuxthreads/attr.c.
the contents follow:

/* below is added by lhx , 2000.5.16 */
#ifndef HAVE_ELF
#define HAVE_ELF
#endif
#ifndef PIC
#define PIC
#endif
#ifndef DO_VERSIONING
#define DO_VERSIONING
#endif
#if defined HAVE_ELF && defined PIC && defined DO_VERSIONING
default_symbol_version (__pthread_attr_init_2_1, pthread_attr_init,
GLIBC_2.1);

Who can tell me why this happened ??????
Thanks a lot !


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
