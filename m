From: "Georg Klug" <gklug@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Possible problem in asm/bitops.h
Date: Wed, 11 Dec 2002 16:31:14 +0100
Message-ID: <FFECLICFNBJAHONLGAKMMEEJCHAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

today I tried to compile the iproute2-2.4.7-now-ss010824 for my walnut-like
custom board. But unfortunately it fails: (original make output below)

The reason seems to be that linux/inetdevice.h uses the inline function ffz()
to define another inline function inet_mask_len(). The ffz() function is
defined in the include file asm/bitops.h. But now there is some inconsistency
between the asm-i386/ and the asm-ppc/ directory: while the asm-i386/bitops.h
defines the ffz function for all includes, the asm-ppc/bitops.h restricts the
ffz function (and also some others) to kernel files (with #ifdef __KERNEL__).

 I then tried to remove the #ifdef __KERNEL__ from the first significant line
of the asm-ppc/bitops.h file, but now the compiler complained about the missing
macro definition of PPC405_ERR77(). This one is defined in the asm-ppc/atomic.h
as well as in asm-ppc/ppc_asm.h, but - unfortunately - differently. (One has
double quotes, the other not.) The definition in atomic.h is only for kernel
files, but I moved it out of the #ifdef __KERNEL__ and could successfully
compile
iproute2.

 But here are my questions:
Q: Is the ffz() function desgined to work in a user space application, too? If
   yes, the file asm-ppc/bitops.h would need a change.
Q: Does it make any sense to define one single macro (PPC405_ERR77()) in
different
   ways in different include files?

What is your opinion?
Kind regards,
Georg Klug


------------- output of the make ---------------------------------
make KERNEL_INCLUDE=/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl21/include
CC=ppc_405-gcc
make[1]: Entering directory
`/var/samba/Users/gklug/Work/linux/tools/net/iproute2/lib'
ppc_405-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -Werror -g -I../include-
glibc -include
../include-glibc/glibc-bugs.h -I/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl
21/include -I../include -DRESOLVE_HOSTNAMES   -c -o ll_map.o ll_map.c
ppc_405-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -Werror -g -I../include-
glibc -include
../include-glibc/glibc-bugs.h -I/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl
21/include -I../include -DRESOLVE_HOSTNAMES   -c -o libnetlink.o libnetlink.c
ar rcs libnetlink.a ll_map.o libnetlink.o
ppc_405-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -Werror -g -I../include-
glibc -include
../include-glibc/glibc-bugs.h -I/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl
21/include -I../include -DRESOLVE_HOSTNAMES   -c -o utils.o utils.c
cc1: warnings being treated as errors
In file included from ../include/utils.h:6,
                 from utils.c:30:
/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl21/include/linux/inetdevice.h:
In function `inet_mask_len':
/var/samba/Users/gklug/Work/tmp/linux-2.4.17_mvl21/include/linux/inetdevice.h:16
3: warning: implicit declaration of function `ffz'
make[1]: *** [utils.o] Error 1
make[1]: Leaving directory
`/var/samba/Users/gklug/Work/linux/tools/net/iproute2/lib'
make: *** [all] Error 2
------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
