Message-ID: <3D81B066.66AD59CE@imc-berlin.de>
Date: Fri, 13 Sep 2002 11:31:18 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with 2.4.20 and includes...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I just pulled the BITKEEPERs linuxppc_2_4_devel and have trouble building it:
...
ppc_8xx-gcc -D__KERNEL__ -I/opt/BITKEEPER/devel-2.4.20-pre6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/opt/BITKEEPER/devel-2.4.20-pre6/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o
sched.o sched.c
In file included from /opt/BITKEEPER/devel-2.4.20-pre6/include/linux/wait.h:13,
                 from /opt/BITKEEPER/devel-2.4.20-pre6/include/linux/fs.h:12,
                 from
/opt/BITKEEPER/devel-2.4.20-pre6/include/linux/capability.h:17,
                 from
/opt/BITKEEPER/devel-2.4.20-pre6/include/linux/binfmts.h:5,
                 from /opt/BITKEEPER/devel-2.4.20-pre6/include/linux/sched.h:9,
                 from /opt/BITKEEPER/devel-2.4.20-pre6/include/linux/mm.h:4,
                 from sched.c:23:
/opt/BITKEEPER/devel-2.4.20-pre6/include/linux/kernel.h:10: stdarg.h: Datei oder
Verzeichnis nicht gefunden
...

scholz@pinguin:/opt/BITKEEPER/devel-2.4.20-pre6> locate stdarg.h
/opt/ELDK/ppc_8xx/usr/lib/gcc-lib/ppc-linux/2.95.3/include/stdarg.h
/opt/ELDK/usr/lib/gcc-lib/ppc-linux/2.95.3/include/stdarg.h

I am using the ELDK as build environment. 2.4.19 kernel compiled with no
problems!

I found the problem in the main Makefile:

---------------
@@ -261,7 +262,7 @@
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not
UML
 # then your code is broken!  KAO.

-kbuild_2_4_nostdinc    := -nostdinc -iwithprefix include
+kbuild_2_4_nostdinc    := -nostdinc $(shell $(CC) -print-search-dirs | sed -ne
's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc

 export CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
---------------

After changing this line back to the old one (from 2.4.19) I can build the
kernel.

Could someone please explain to me what happend, why it happened and what I am
supposed to do about it (except changing this line to the old one)!?


Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
