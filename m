Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.0.20011017155249.03548ec0@pop.gmx.de>
Date: Wed, 17 Oct 2001 16:03:38 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Reducing glibc with mklibs.sh
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried to reduce the size of my self-compiled glibc 2.2.2, with the debian
script mklibs.sh, but it terminates with the following output:

---
++ echo :/usr/local/powerpc-linux/glibc-2.2.2
++ sed -e 's/::*/:/g' -e 's/^://' -e 's/:$//' -e 's/:/ -L/g'
++ cat /tmp/,mklibs.21079/lib-dependencies
++ sed 's/^/-l/'
+ powerpc-linux-gcc -nostdlib -nostartfiles -shared -Wl,-soname=libc.so
-uabort -ualarm -uatoi -uatol -ubcopy -ubindtextdomain -ubzero -uchdir
-uclearerr -uclose -uclosedir -uconfstr -u__ctype_b -u__ctype_tolower
-udcgettext -udup -udup2 -uendpwent -uenviron -u_environ -u__environ
-u__errno_location -uexecve -uexit -ufclose@GLIBC_2.0 -ufclose@@GLIBC_2.1
-ufcntl -ufdopen@GLIBC_2.0 -ufdopen@@GLIBC_2.1 -uferror -ufflush -ufileno
-ufnmatch -ufork -ufprintf -ufputs -ufree -ufwrite -u__fxstat64@GLIBC_2.1
-u__fxstat64@@GLIBC_2.2 -ugetcwd -ugetdtablesize -ugetegid -ugetenv
-ugeteuid -ugetgid -ugetgroups -ugethostname -ugetpeername -ugetpid
-ugetppid -ugetpwnam -ugetpwuid -ugetrlimit64@GLIBC_2.1
-ugetrlimit64@@GLIBC_2.2 -ugetrusage -ugetuid -uglob_pattern_p
-ugroup_member -u_init -u_IO_putc -uisalpha -uisatty -uisdigit -ukill
-u__libc_start_main -ulongjmp -ulseek64 -u__lxstat64@GLIBC_2.1
-u__lxstat64@@GLIBC_2.2 -umalloc -umemcpy -uopen64 -uopendir -upathconf
-upipe -uprintf -uputchar -uputs -uqsort -uread -ureaddir64@GLIBC_2.1
-ureaddir64@@GLIBC_2.2 -ureadlink -urealloc -usbrk -usetgid -u_setjmp
-usetlocale -usetrlimit64 -usetuid -usetvbuf -usigaction -usigaddset
-usigdelset -usigemptyset -usiginterrupt -usigprocmask -usprintf -ustderr
-ustdin -ustdout -ustrcasecmp -ustrcat -ustrchr -ustrcmp -ustrcpy
-ustrerror -ustrlen -ustrncmp -ustrncpy -ustrrchr -ustrsignal -ustrtod
-ustrtol -ustrtoul -usysconf -utcgetattr -utcsetattr -utextdomain -utime
-uttyname -uumask -uunlink -uvfprintf -uwaitpid -uwrite
-u__xstat64@GLIBC_2.1 -u__xstat64@@GLIBC_2.2 -o /tmp/,mklibs.21079/lib-so
/usr/local/powerpc-linux/glibc-2.2.2/libc_pic.a -L/ppcroot/smalllib
-L/usr/local/powerpc-linux/glibc-2.2.2
/usr/local/powerpc-linux/bin/ld: /tmp/,mklibs.21079/lib-so: undefined
versioned symbol name sys_siglist@@GLIBC_2.1
/usr/local/powerpc-linux/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
+ echo ./mklibs.sh: install-small-lib: powerpc-linux-gcc or
powerpc-linux-objcopy failed.
./mklibs.sh: install-small-lib: powerpc-linux-gcc or powerpc-linux-objcopy
failed.
+ exit 1
+ rm -fr /tmp/,mklibs.21079
---

The program call was:
----
#!/bin/sh
GCC=powerpc-linux-gcc \
OBJDUMP=powerpc-linux-objdump \
OBJCOPY=powerpc-linux-objcopy \
./mklibs.sh --verbose -L /usr/local/powerpc-linux/glibc-2.2.2 \
--dest-dir /ppcroot/smalllib \
/ppcroot/bin/bash
---

By default, only the libc_pic.a file is created. How can I create the other
PICs?

If you know any other tools to do this task, please let me know. Seems that
LIPO (Lineo) and LOT(HardHat) are not free.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
