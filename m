Date: Thu, 28 Oct 1999 10:15:02 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: Wang Yong <wung_y@263.net>
cc: linux-ppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: help, build Cross GCC
In-Reply-To: <38184905.117429CD@263.net>
Message-Id: <Pine.SOL.4.20.9910281010210.17862-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 28 Oct 1999, Wang Yong wrote:
> I want to build a cross GCC to build program for PPC401 in my 586. I
> have downloaded binutils-2.9.5.0.16 and gcc-2.95.2. when i build gcc,
> i was told that as: unrecognized option `-ppc'. Do i miss something?
> would you please show me how to build a cross GCC for PPC step by
> step? Thank you very much.

Wang,

This was posted to the list a few months back and should* be in the mail
archives. However, for those of you who missed it, here it is again. These
notes were drafted for EGCS and cross compiling from Solaris to Linux/PPC;
however, the steps are just as applicable to GCC 2.95.x and x86 to
Linux/PPC.

-----

    Building an EGCS PowerPC/Linux Cross Compiler For SPARC/Solaris

There are a number of resources on the Internet serving as a guide for
building a cross compiler. However, each addresses a particular version
of the compiler as well as a particular host/target combination; which
while generally useful as a base instruction set, doesn't cover the
intricacies of performing the feat for a different version and
host/target combination. This document attempts to document the process
of building an EGCS 1.1.2 cross compiler for PowerPC/Linux 2.2.10 on
SPARC/ Solaris 2.7 (aka Solaris 7, SunOS 5.7).

Conventions

In the instructions below, the following conventions are used:

              <archive dir> Location in which you store your
                            archive (i.e. *.tar.gz) files.

              <source dir>  Location in which you unpack your
                            archive files as various source
                            directories.

              <object dir>  Location in which you will build
                            object files from the source
                            dirctories located in
                            <source dir>. This may be the same
                            as <source dir>; however, that is
                            not recommended.

              <tool dir>    Location in which you will place
                            all of the built cross-compiler
                            tools and libraries.

              gmake         GNU version of make

              gtar          GNU version of tar

Instructions

Most of the following steps should work fine with default system tools.
However, the process for building tends to make a number of assumptions
about running with a GNU tool set, in particular, a native EGCS
compiler. That said, it may be useful (I certainly found it to be) to
have /usr/local/gnu/bin or an equivalent GNU tool set in your PATH
before your normal system tools (/usr/bin, /usr/xpg4/bin, /usr/ucb,
etc.). I used these tools:

Package   Version   Package   Version
=======   =======   =======   =======
autoconf    2.13    gzip       1.2.4a
automake    1.4	    id-utils    3.2  
bash        2.03    indent     1.10.0
binutils   2.9.1    less        340  
bison       1.28    libtool     1.3  
cpio       2.4.2    m4          1.4  
cvs        1.10.6   make        3.77 
diffutils   2.7	    patch       2.5  
ed          0.2	    rcs         5.7
egcs       1.1.2    readline    4.0  
enscript   1.6.1    regex       0.12 
fileutils   4.0	    sed         3.02 
findutils   4.1	    sh-utils    1.16 
flex       2.5.4a   sharutils   4.2  
gawk       3.0.4    tar         1.12 
gdb         4.18    termcap     1.3  
gdbm       1.8.0    termutils   2.0  
gettext     0.10    texinfo     3.12 
grep        2.3	    textutils   1.22 
groff      1.11a    time        1.7  
		    which       2.6  

It is also highly encouraged that all the below commands be run while
using bash (preferrably) or ksh as your shell. You will likely even have
better luck if you set the environment variable SHELL to bash or
ksh. All the subsequent examples will assume that this is the
case. Adjust accordingly if you are using csh, tcsh or some other shell.

Changing the optimization level of the compiler (e.g. -O3), either via
CFLAGS or by another means, is not recommened. Doing so will likely
result in either a failed build step in glibc or a broken
cross-compilation environment.

  1. Packages

     The following packages are required for this endeavor:

      Package              Version   Location

      binutils           2.9.1.0.25  Download

      egcs-core             1.1.2    Download

      egcs                  1.1.2    Download

      glibc                 2.1.1    Download

      glibc-crypt          2.0.111   Download

      glibc-linuxthreads    2.1.1    Download

      linux                2.2.10    Download

  2. Binutils

       1. Extract

            1. cd <source dir>
            2. gtar zxvf <archive dir>/binutils-2.9.1.0.25.tar.gz

       2. Build

            1. mkdir <tool dir>/host
            2. mkdir <tool dir>/host/sparc-sun-solaris
            3. mkdir <object dir>/binutils-2.9.1.0.25
            4. cd <object dir>/binutils-2.9.1.0.25
            5. <source dir>/binutils-2.9.1.0.25/configure
               --target=powerpc-linux
               --prefix=<tool dir>/host/sparc-sun-solaris
            6. gmake

       3. Install

            1. gmake install

       4. Access

          Subsequent build steps will need to use the tools created by
          this step. As such, the path to these tools will need to be 
          added to your environment's PATH variable:

            1. PATH=${PATH}":<tool dir>/host/sparc-sun-solaris/bin"
            2. export PATH

  3. Egcs (Core)

       1. Extract

            1. cd <source dir>
            2. gtar zxvf <archive dir>/egcs-core-1.1.2.tar.gz

       2. Build

            1. mkdir <object dir>/egcs-1.1.2
            2. cd <object dir>/egcs-1.1.2
            3. <source dir>/egcs-1.1.2/configure --target=powerpc-linux
               --prefix=<tool dir>/host/sparc-sun-solaris --with-newlib
            4. gmake

       3. Install

            1. gmake install

  4. Linux Headers

     The 2.2.10 kernel contains PowerPC support; however, it may not
     contain the absolute latest bleeding-edge changes to accomodate
     various PowerPC architectures. Such changes are maintained in the
     "vger" source tree. This is the code repository for the development
     work on non-x86 architectures.

       1. Extract

            1. cd <source dir>
            2. gtar zxvf <archive dir>/linux-2.2.10.tar.gz

          If you want to use the vger source instead of the 2.2.10 version
          source, do so.

            1. cd <source dir>
            2. set CVSROOT=":pserver:anonymous@cvs.on.openprojects.net:\
               /cvs/linux"
            3. export CVSROOT
            4. cvs login
            5. cvs -z 3 checkout -r linux_2_2 linux
            6. cvs logout

       2. Build

            1. cd <source dir>/linux
            2. Edit the Makefile
                 1. Comment out the existing "ARCH :=" line and add a new
                    line with "ARCH := ppc". line.
                 2. Find the "CROSS_COMPILE =" line and append
                    'powerpc-linux-' so that it reads "CROSS_COMPILE =
                    powerpc-linux-"

            3. If you have the GNU ncurses library installed, then "gmake
               menuconfig", otherwise "gmake config".
            4. gmake dep
            5. gmake clean
            6. gmake zImage

          The zImage build process does not have to complete successfully;
          only the headers are required.

       3. Verify

          Verify that the headers were created.

            1. find ./include/. -name "version.h"

          You should see output similar to: "./include/./linux/version.h".

          If you do not have the appropriate headers, use the "gmake
          distclean" command and repeat the steps for this section again.

  5. Glibc

       1. Link

            1. ln -sf <linux source dir>/include/asm
               <tool dir>/host/sparc-sun-solaris/powerpc-linux/include/asm
            2. ln -sf <linux source dir>/include/linux
               <tool dir>/host/sparc-sun-solaris/powerpc-linux/include/linux
            3. ls -la
               <tool dir>/host/sparc-sun-solaris/powerpc-linux/include/asm/*
            4. ls -la
               <tool dir>/host/sparc-sun-solaris/powerpc-linux/include/linux/*

       2. Extract

            1. cd <source dir>
            2. gtar zxvf <archive dir>/glibc-2.1.1.tar.gz
            3. cd <source dir>/glibc-2.1.1
            4. gtar zxvf <archive dir>/glibc-crypt-2.1.1.tar.gz
            5. gtar zxvf <archive dir>/glibc-linuxthreads-2.1.1.tar.gz

       3. Build

          First, Create a separate subdirectory, such as <tool dir>
          /target/powerpc-linux-gnu in which to install the glibc libraries.
          This will be the target of the --prefix configure switch.

          The configure script is quite specific about what versions (and
          flavors) of various build tools it requires. If it doesn't find
          what it's looking for, chance are that things won't build. Try to
          appease it.

            1. mkdir <tool dir>target
            2. mkdir <tool dir>target/powerpc-linux-gnu
            3. mkdir <object dir>/glibc-2.1.1
            4. cd <object dir>/glibc-2.1.1
            5. CC=powerpc-linux-gcc AR=powerpc-linux-ar
               RANLIB=powerpc-linux-ranlib
               <source dir>/glibc-2.1.1/configure --host=powerpc-linux
               --with-headers=<linux source dir>/include
               --enable-add-ons=crypt,linuxthreads
               --prefix=<tool dir>/target/powerpc-linux-gnu
            6. gmake

               There are a few likely pitfalls here. First, depending on
               which echo the make process finds (SVR4, BSD, GNU, shell
               built-in, etc.) there will be an error in csu/version-info.h
               if it picks the wrong one. Picking the wrong one results in
               '-n Version...' rather than the intended 'Version...' in
               csu/version-info.h.

               You will also probably notice in the csu/version-info.h file
               that it reports that it was compiled "on a Linux 5.7 system".
               I am not certain whether or not this should report "on a
               Solaris 2.7 system", on a "SunOS 5.7 system", or "on a Linux
               2.2.10 system". The first or second seem most reasonable. The
               choice you make here will in no may impact the success of
               your build.

            7. Edit and fix the csu/version-info.h file as necessary.
            8. gmake

               The second pitfall when building on a stock Solaris 2.7
               machine, is that there is a limit of 64 open file
               descriptors. This will result in an error building in the
               iconvdata/ subdirectory. This can be remedied by ratcheting
               up the limit to 1024:

            9. /usr/sbin/ulimit -n 1024
           10. gmake

          The overall build process should take several hours to complete,
          even on the brawniest of hardware.

       4. Install

            1. gmake install

               If your build process has completed successfully, the install
               process should go fairly smoothly. One tangle may occur when
               the install process attempts to run in the locale/ directory.
               There are either missing rules for, or the rules don't work
               quite correctly for, the i18n/locales/ and
               i18n/repertoiremaps/ targets.

               If you encounter this problem, to work around it, simply
               create the following directories yourself:

                 1. cd <tool dir>/target/powerpc-linux-gnu/share/
                 2. mkdir i18n
                 3. cd i18n
                 4. mkdir locales
                 5. mkdir repertoiremaps
                 6. cd <object dir>/glibc-2.1.1
                 7. gmake install

          The install process should take about 15 or so minutes, assuming
          that no errors are encountered.

  6. EGCS

     Provided that glibc compiled successfully, you are ready to go back 
     and rebuild the C compiler and, if you wish, build the Objective C, 
     C++ and F77 compilers.

       1. Extract

            1. cd <source dir>
            2. mv egcs-1.1.2 egcs-core-1.1.2
            3. gtar zxvf <archive dir>/egcs-1.1.2.tar.gz

       2. Build

            1. cd <object dir>
            2. mv egcs-1.1.2 egcs-core-1.1.2
            3. mkdir egcs-1.1.2
            4. cd egcs-1.1.2
            5. <source dir>/egcs-1.1.2/configure --target=powerpc-linux
               --prefix=<tool dir>/host/sparc-sun-solaris
               --with-headers=<tool dir>/target/powerpc-linux-gnu/include
               --with-libs=<tool dir>/target/powerpc-linux-gnu/lib
               --enable-shared --enable-languages="c,c++,f77"
            6. gmake

       3. Install

            1. gmake install

  7. Test

     user@ultraSPARC% pwd
     /home/user

     user@ultraSPARC% uname -a
     SunOS ultraSPARC 5.7 Generic sun4u sparc

     user@ultraSPARC% cat > hello.c
     #include <stdio.h>

     int main (void)
     {
             printf("Hello, %s!\n", argc >= 2 ? argv[1] : "world");

             return (0);
     }

     user@ultraSPARC% cat > hello.C
     #include <iostream.h>

     int main (void)
     {
             cout << "Hello, " << ((argc >= 2) ? argv[1] : "world") << "!" << endl;

             return (0);
     }

     user@ultraSPARC% cat > hello.f
             program hello

             print*,'Hello, world!'
             end

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-gcc -dumpmachine
     powerpc-linux

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-gcc -o helloc -s hello.c

     user@ultraSPARC% file helloc
     hello-c:        ELF 32-bit MSB executable PowerPC Version 1, dynamically linked, stripped

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-g++ -dumpmachine
     powerpc-linux

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-g++ -o helloC -s hello.C

     user@ultraSPARC% file helloC
     hello-c:        ELF 32-bit MSB executable PowerPC Version 1, dynamically linked, stripped

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-g77 -dumpmachine
     powerpc-linux

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-g77 -o hellof -s hello.f

     user@ultraSPARC% file hellof
     hello-c:        ELF 32-bit MSB executable PowerPC Version 1, dynamically linked, stripped

     user@ultraSPARC% ssh PowerMac

     user@PowerMac% pwd
     /home/user

     user@PowerMac% uname -a
     Linux PowerMac 2.2.6-15apmac #1 Mon May 31 03:54:09 EDT 1999 ppc unknown

     user@PowerMac% file helloc
     hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1, dynamically linked, stripped

     user@PowerMac% file helloC
     hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1, dynamically linked, stripped

     user@PowerMac% file hellof
     hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1, dynamically linked, stripped

     user@PowerMac% ldd ./helloc
             libc.so.6 => /lib/libc.so.6 (0x016be000)
             /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

     user@PowerMac% ldd ./helloC
             libstdc++.so.2.9 => /usr/lib/libstdc++.so.2.9 (0x0175b000)
             libm.so.6 => /lib/libm.so.6 (0x01783000)
             libc.so.6 => /lib/libc.so.6 (0x01641000)
             /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

     user@PowerMac% ldd ./hellof
             libm.so.6 => /lib/libm.so.6 (0x01783000)
             libc.so.6 => /lib/libc.so.6 (0x01641000)
             /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

     user@PowerMac% ./helloc
     Hello, world!

     user@PowerMac% ./helloC
     Hello, world!

     user@PowerMac% ./hellof
     Hello, world!

Parting Notes

Building all of the above requires a significant amount of space, on the
order of 150 MB for the powerpc-linux cross-development system hosted on
Sun Solaris 2.7. None of the above tools are stripped by default, so
doing so after installation will save an appreciable amount of space.

Useful Resources

   * http://egcs.cygnus.com/install/index.html
   * http://members.home.com/mmporter/cross.html
   * http://developer.intel.com/design/strong/applnots/sa1100lx/sa1100lx.htm
   * http://www.objsw.com/CrossGCC/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
