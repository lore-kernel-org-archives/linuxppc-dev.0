Message-ID: <38C91091.DFFA1DC2@cray.com>
Date: Fri, 10 Mar 2000 09:11:13 -0600
From: Mike Wolf <mwolf@sgi.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ?'s on user code for embedded PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
  I'm trying to boot the IBM 403.  I'm working off of Grant Ericksons
changes and using snoop I see it is getting to the point of loading
libc-1.99.so and it hangs.

I have asked Grant questions in the past and here is a comment he made
about libc:

"Not really. The trick with the 403 is that all the userland stuff needs
to
be compiled using -msoft-float because of the lack of an FPU. Further,
the
C library may need to be hacked as was done for the 8xx-based stuff
because of the 16-byte cache lines.

Dan Malek <dan@netx4.com> has done LOTS of work in this area and could
probably offer some valuable insight. You might* even try to use his
minimal mbxroot file system image as a starting point."

I've also noticed that the user code is not as hardware dependant that
most of the code is compiled other PPC's running linux and then used for
the embedded application.  So I got the mbxroot libraries and shell and
tried running them without success.

Should this have worked?

I've also attempted cross-compiling the TiVo library.  I have a cross
compiler set up on a system running Irix6.5 and a cross compiler setup
on a sun sparc 5 running RedHat 6.0.  The cross compiler uses:
binutils-2.9.5.0.22.tar.gz
gcc-2.95.2.tar.gz
gcc-core-2.95.2.tar.gz
glibc-2.1.2.tar.gz
glibc-crypt-2.1.2.tar.gz
glibc-linuxthreads-2.1.2.tar.gz

The error I get is:
powerpc-linux-gcc ../sysdeps/powerpc/elf/crtbegin.S -c -I. -I..
-I../libio  -I/opt/home/mwolf/src/tivo/toolchain/libc-ppc
-I../sysdeps/powerpc/elf -I../des-crypt/sysdeps/unix
-I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv
-I../linuxthreads/sysdeps/unix -I../sysdeps/unix/sysv/linux/powerpc
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc
-I../sysdeps/wordsize-32 -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754
-I../sysdeps/generic -I../sysdeps/stub  -D_LIBC_REENTRANT
-DUSE_NEW_MALLOC -include ../libc-symbols.h     -DHAVE_INITFINI
-DASSEMBLER  -o
/opt/home/mwolf/src/tivo/toolchain/libc-ppc/csu/crtbegin.o
powerpc-linux-gcc ../sysdeps/powerpc/elf/crtend.S -c -I. -I..
-I../libio  -I/opt/home/mwolf/src/tivo/toolchain/libc-ppc
-I../sysdeps/powerpc/elf -I../des-crypt/sysdeps/unix
-I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv
-I../linuxthreads/sysdeps/unix -I../sysdeps/unix/sysv/linux/powerpc
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc
-I../sysdeps/wordsize-32 -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754
-I../sysdeps/generic -I../sysdeps/stub  -D_LIBC_REENTRANT
-DUSE_NEW_MALLOC -include ../libc-symbols.h     -DHAVE_INITFINI
-DASSEMBLER  -o /opt/home/mwolf/src/tivo/toolchain/libc-ppc/csu/crtend.o
gmake[2]: *** No rule to make target
`/opt/home/mwolf/src/tivo/toolchain/libc-ppc/csu/crtbeginS.o', needed by
`others'.  Stop.
gmake[2]: Leaving directory
`/opt/home/mwolf/src/tivo/toolchain/libc/csu'
gmake[1]: *** [csu/others] Error 2
gmake[1]: Leaving directory `/opt/home/mwolf/src/tivo/toolchain/libc'
gmake: *** [all] Error 2


Is this a problem with the version of the libc I'm trying to compile
with
my cross compiler?

Would this be easier to compile on a PPC running linux?  If so I'm
thinking
about getting a G4 tower and running YellowDog on it.  I'm assuming any
G4 I'd purchase today would be a 'sawtooth' and I noticed that Ben
Bodley is
reporting problems with this booting.  Any suggestions for a reliable
system
and PPC release.  It doesnt need to be high powered, I dont need to run
MacOS, I would prefer to have only the linux loaded.

--
Mike Wolf
Cray Research
655-F Lone Oak Drive, Eagan, MN 55121
mwolf@cray.com          (651)683-5313

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
