Date: Tue, 14 Nov 2000 13:55:51 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: glibc and kernel build problems (EST8260)
Message-ID: <Pine.GSO.4.21.0011141339220.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to build glibc and the fsmlabs kernel for the EST8260 from
scratch and am having a few problems.

For glibc, I have read the HowTo and I think I applied the proper glibc
patches.  I have also patched my gcc specs file.  Here is where I am
dying:

powerpc-linux-gcc   -nostdlib -nostartfiles -r -o
/home/ford/linux/build/glibc/elf/librtld.os '-Wl,-('
/home/ford/linux/build/glibc/elf/dl-allobjs.os
/home/ford/linux/build/glibc/libc_pic.a -lgcc '-Wl,-)'
powerpc-linux-gcc   -nostdlib -nostartfiles -shared -o
/home/ford/linux/build/glibc/elf/ld.so  \
          /home/ford/linux/build/glibc/elf/librtld.os           \
          -Wl,--version-script=/home/ford/linux/build/glibc/ld.so.map
-Wl,-soname=ld.so.1
/home/ford/linux/tools/powerpc-linux/bin/ld: unable to find version
dependency `GLIBC_2.0'
collect2: ld returned 1 exit status

For the kernel, I get:

make[2]: Entering directory
`/home/ford/linux/src/linuxppc_fsm/arch/ppc/mm'
powerpc-linux-gcc -D__KERNEL__ -I/home/ford/linux/src/linuxppc_fsm/include
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring    -c -o init.o init.c
init.c: In function `__ioremap':
init.c:418: `isa_mem_base' undeclared (first use in this function)
init.c:418: (Each undeclared identifier is reported only once
init.c:418: for each function it appears in.)
init.c: In function `hash_init':
init.c:1486: warning: int format, long int arg (arg 2)
init.c: At top level:
init.c:661: warning: `get_mem_prop' declared `static' but never defined
make[2]: *** [init.o] Error 1

Any ideas?  Thanks.

--
Brian
Ford Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
