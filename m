Message-Id: <m13BmoO-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: -Werror is causing some heart ache
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 10 Jul 2000 19:18:03 -0400 (EDT)
Cc: dan_malek@mvista.com, all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hardware:

	- EST SBC8260
	- MPC8260 Rev A.1 CPU/CPM/BUS: 200/133/66 Mhz

	Environment:

	- Linux: 2.4.0-test3

In one of the recent changesets, the CFLAGS definition in ./Makefile
was modified to add -Werror.  The -Werror option to gcc causes it to
treat warnings are errors.

In order to get arch/ppc/kernel/setup.c to compile, a functional
prototype for m8260_init needed to be created.

dell 384} bk diffs -u -r1.40 arch/ppc/kernel/setup.c
===== arch/ppc/kernel/setup.c 1.40 vs 1.41 =====
--- 1.40/arch/ppc/kernel/setup.c        Sun Jul  9 22:42:49 2000
+++ 1.41/arch/ppc/kernel/setup.c        Mon Jul 10 16:37:44 2000
@@ -63,6 +63,12 @@
                     unsigned long r6,
                     unsigned long r7);

+extern void m8260_init(unsigned long r3,
+                      unsigned long r4,
+                      unsigned long r5,
+                      unsigned long r6,
+                      unsigned long r7);
+
 extern void apus_init(unsigned long r3,
                       unsigned long r4,
                       unsigned long r5,

I am struggling to get arch/ppc/kernel/m8260_setup.c to compile.

gmake -C  arch/ppc/kernel
gmake[1]: Entering directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
/opt/hardhat/devkit/ppc/8xx/bin/powerpc-linux-gcc -D__KERNEL__ -I/usr/people/diekema/bk/linux-2.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Werror -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o m8260_setup.o m8260_setup.c
cc1: warnings being treated as errors
m8260_setup.c: In function `abort':
m8260_setup.c:105: warning: `noreturn' function does return
gmake[1]: *** [m8260_setup.o] Error 1
gmake[1]: Leaving directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
gmake: *** [_dir_arch/ppc/kernel] Error 2

If I used the -fno-builtin option, then gcc will compile this file.  I
added -fno-builtin to CFLAGS, and ran into problems with
arch/ppc/mm/init.c.

gmake[2]: Entering directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/mm'
/opt/hardhat/devkit/ppc/8xx/bin/powerpc-linux-gcc -D__KERNEL__ -I/usr/people/diekema/bk/linux-2.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Werror -fno-builtin -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o init.o init.c
cc1: warnings being treated as errors
init.c:614: warning: `get_mem_prop' declared `static' but never defined
gmake[2]: *** [init.o] Error 1
gmake[2]: Leaving directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/mm'
gmake[1]: *** [first_rule] Error 2
gmake[1]: Leaving directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/mm'
gmake: *** [_dir_arch/ppc/mm] Error 2

It will take a fair amount of time to clean up all the warnings...

I am going to remove -fno-builtin that I just added to to CFLAGS and -Werror.
I want to to see if I can compile Linux like I use to.  Yup, this did the trick.

dell 533} bk diffs -u -r1.62 Makefile
===== Makefile 1.62 vs 1.63 =====
--- 1.62/Makefile       Sun Jul  9 22:42:49 2000
+++ 1.63/Makefile       Mon Jul 10 19:09:55 2000
@@ -84,7 +84,7 @@

 CPPFLAGS := -D__KERNEL__ -I$(HPATH)

-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Werror
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)

 # use '-fno-strict-aliasing', but only if the compiler can take it

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
