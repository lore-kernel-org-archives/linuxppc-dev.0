Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200207311028.MAA25657@hzsms01.nl.lucent.com>
Date: Wed, 31 Jul 2002 12:28:38 +0200 (MEST)
From: Jaap-Jan <jjboor@lucent.com>
Reply-To: Jaap-Jan <jjboor@lucent.com>
Subject: occasionally segmentation faults
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've some problems with my built cross environment
from sparc-solaris to powerpc 8xx.

I configured and built gcc2.95.2 and glibc-2.1.3
and used that to build the file and sh utils etc.

I applied the cache line size patch, removed sysdeps/powerpc/memset.S
and used this config command for glibc:

CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
CFLAGS="-mcpu=860 -msoft-float -O2 -DNDEBUG=1"
../../src-nfp/glibc-2.1.3/configure  --host=powerpc-linux
--with-headers=$HOME/linux/include --enable-add-ons=crypt,linuxthreads
--enable-shared --without-fp --prefix=$HOME/crosstools/target/powerpc-linux-gnu

All seems to work initially on our target, however sometimes
I get a segmentation fault. E.g. I can run 5 times 'ls', then
suddenly the 6th time I get a seg. fault, the 7th time I get
this error from bash: 'child setpgid (266 to 265): Operation not permitted'

I also cross-compiled ldconfig and ran it on target to create a ld.so.cache
but that doesn;t help

eg:

bash-2.04# ls
bin  etc   lib      linuxrc     mnt   root  tmp
dev  home  libexec  lost+found  proc  sbin  usr

bash-2.04# ls
Segmentation fault

bash-2.04# ls
bash: child setpgid (266 to 265): Operation not permitted
bin  etc   lib      linuxrc     mnt   root  tmp
dev  home  libexec  lost+found  proc  sbin  usr

bash-2.04# cat /proc/ppc_htab
Non-error misses: 67059
Error misses    : 44

Anyone an idea?

thanks,

Jaap-Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
