Subject: Building an EGCS 1.1.2 PowerPC/Linux Cross Compiler for SPARC/Solaris
Date: Fri, 30 Jul 1999 23:23:02 -0000
From: Grant Erickson <erick205@tc.umn.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <iss.5e4a.37a29636.37be5.1@mhub3.tc.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


       Building an EGCS PowerPC/Linux Cross Compiler For SPARC/Solaris

There are a number of resources on the Internet serving as a guide for
building a cross compiler. However, each addresses a particular version of
the compiler as well as a particular host/target combination; which while
generally useful as a base instruction set, doesn't cover the intricacies 
of
performing the feat for a different version and host/target combination.

This document attempts to document the process of building an EGCS 1.1.2
cross compiler for PowerPC/Linux 2.2.10 on SPARC/Solaris 5.7.

Conventions
===========

In the instructions below, the following conventions are used:

              <archive dir> Location in which you store your
                            archive (i.e. *.tar.gz) files.

              <source dir>  Location in which you unpack your
                            archive files as various source
                            directories.

              <object dir>  Location in which you will build
                            object files from the source
                            dirctories located in <source
                            dir>. This may be the same as
                            <source dir>; however, that is not
                            recommended.

              <tool dir>    Location in which you will place
                            all of the built cross-compiler
                            tools and libraries.

              gmake         GNU version of make

              gtar          GNU version of tar

Instructions
============

Most of the following steps should work fine with default system tools
(Solaris 5.x). However, the process for building tends to make a number of
assumptions about running with a GNU tool set, in particular, a native 
EGCS
compiler. That said, it may be useful (I certainly found it to be) to have
/usr/local/gnu/bin or an equivalent GNU tool set in your PATH before your
normal system tools (/usr/bin, /usr/xpg4/bin, /usr/ucb, etc.). I used 
these
tools:

Package   Version   Package   Version
=======   =======   =======   =======
autoconf    2.13    groff      1.11a
automake    1.4		   gzip       1.2.4a
bash        2.03	   id-utils    3.2
binutils   2.9.1	   indent     1.10.0
bison       1.28	   less        340
cpio       2.4.2	   libtool     1.3
cvs        1.10.6	  m4          1.4
diffutils   2.7		   make        3.77
ed          0.2		   ncurses     4.2
egcs       1.1.2	   patch       2.5
enscript   1.6.1	   readline    4.0
fileutils   4.0		   regex       0.12
findutils   4.1		   sed         3.02
flex       2.5.4a	  sh-utils    1.16
gawk       3.0.4	   sharutils   4.2
gdb         4.18	   tar         1.12
gdbm       1.8.0	   termcap     1.3
gettext     0.10	   termutils   2.0
grep        2.3		   texinfo     3.12
               					textutils   1.22
				               	time        1.7
               					which       2.6

It is also highly encouraged that all the below commands be run while 
using
bash (preferrably) or ksh as your shell. You will likely even have better
luck if you set the environment variable "SHELL" to bash or ksh.

  1. Packages

     The following packages will need to be built for this endeavor:

      Package             Version    Location
      =======             ========   ========

      binutils           2.9.1.0.25  
ftp://ftp.varesearch.com/pub/support/hjl/
                                           
binutils/binutils-2.9.1.0.25.tar.gz
      
      egcs-core          1.1.2       ftp://sourceware.cygnus.com/pub/egcs/
                                           releases/egcs-1.1.2/
                                           egcs-core-1.1.2.tar.gz

      egcs               1.1.2       ftp://sourceware.cygnus.com/pub/egcs/
                                           releases/egcs-1.1.2/
                                           egcs-1.1.2.tar.gz

      glibc              2.1.1       ftp://sourceware.cygnus.com/pub/gnu/
                                           glibc/glibc--2.1.1.tar.gz

      glibc-crypt        2.0.111     ftp://sourceware.cygnus.com/pub/gnu/
                                           
glibc/glibc-crypt-2.0.111.tar.gz

      glibc-linuxthreads 2.1.1       ftp://sourceware.cygnus.com/pub/gnu/
                                           
glibc/glibc-linuxthreads-2.1.1.tar.gz

      linux              2.2.10      
ftp://ftp.kernel.org/pub/linux/kernel/
                                           v2.2/linux-2.2.10.tar.gz

  2. Binutils

       1. Extract
            1. cd <source dir>
            2. gtar zxvf <archive dir>/binutils-2.9.1.0.25.tar.gz

       2. Build
            1. mkdir <object dir>/binutils-2.9.1.0.25
            2. cd <object dir>/binutils-2.9.1.0.25
            3. <source dir>/binutils-2.9.1.0.25/configure
               --target=powerpc-linux --prefix=<tool dir>
            4. gmake

       3. Install
            1. gmake install

       4. Access

          Subsequent build steps will need to use the tools created by 
this
          step. As such, the path to these tools will need to be added to
          your environment's "PATH" variable. Using ksh or bash:

            1. set PATH=${PATH}":<tool dir>/bin"
            2. export PATH

  3. Egcs (Core)

       1. Extract
            1. cd <source dir>
            2. gtar zxvf <archive dir>/egcs-core-1.1.2.tar.gz

       2. Build
            1. mkdir <object dir>/egcs-1.1.2
            2. cd <object dir>/egcs-1.1.2
            3. <source dir>/egcs-1.1.2/configure --target=powerpc-linux
               --prefix=<tool dir> --with-newlib
            4. gmake

       3. Install
            1. gmake install

  4. Linux Headers

     The 2.2.10 kernel contains PowerPC support; however, it may not 
contain
     the absolute latest changes to accomodate various PowerPC
     architectures. Such changes are maintained in the "vger" source tree.
     This is the code repository for the development work on non-x86
     architectures.

       1. Extract
            1. cd <source dir>
            2. tar zxvf <archive dir>/linux-2.2.10.tar.gz

          If you want to use the vger source instead of the 2.2.10 version
          source, do so.

            1. cd <source dir>
            2. setenv CVSROOT 
":pserver:anonymous@cvs.on.openprojects.net:\
               /cvs/linux"
            3. cvs login
            4. cvs checkout linux

       2. Build
            1. cd <source dir>/linux
            2. Edit the Makefile
                 1. Comment out the existing "ARCH :=" line and add a new
                    line with "ARCH := ppc". line.
                 2. Find the "CROSS_COMPILE =" line and append
                    'powerpc-linux-' so that it reads "CROSS_COMPILE =
                    powerpc-linux-"

               If you have the GNU ncurses library installed:

            3. gmake menuconfig

               otherwise:

            4. gmake config

               in either case, then:

            5. gmake dep
            6. gmake clean
            7. gmake zImage

          The zImage build process does not have to complete successfully;
          only the headers are required.

       3. Verify

          Verify that the headers were created.

            1. find ./include/. -name "version.h"

          You should see output similar to: "./include/./linux/version.h".

          If you do not have the appropriate headers, use the "make
          distclean" command and repeat the steps for this section again.

  5. Glibc

       1. Link
            1. ln -sf <linux source dir>/include/asm <tool
               dir>/powerpc-linux/include/asm
            2. ln -sf <linux source dir>/include/linux <tool
               dir>/powerpc-linux/include/linux
            3. ls -la <tool dir>/powerpc-linux/include/asm/*
            4. ls -la >tool dir>/powerpc-linux/include/linux/*

       2. Extract
            1. cd <source dir>
            2. gtar zxvf <archive dir>/glibc-2.1.1.tar.gz
            3. cd <source dir>/glibc-2.1.1
            4. gtar zxvf <archive dir>/glibc-crypt-2.1.1.tar.gz
            5. gtar zxvf <archive dir>/glibc-linuxthreads-2.1.1.tar.gz

       3. Build

          The 'configure' script is quite specific about what versions 
(and
          flavors) of various build tools it requires. If it doesn't find
          what it's looking for, chance are that things won't build. Try 
to
          appease it.

            1. mkdir <object dir>/glibc-2.1.1
            2. cd <object dir>/glibc-2.1.1
            3. CC=powerpc-linux-gcc AR=powerpc-linux-ar
               RANLIB=powerpc-linux-ranlib <source
               dir>/glibc-2.1.1/configure --host=powerpc-linux
               --with-headers=$CVS_LINUX_TOP/include
               --enable-add-ons=crypt,linuxthreads --prefix=<tool
               dir>/powerpc-linux
            4. gmake

          There are a few likely pitfalls here. First, depending on which
          echo the make process finds (SVR4, BSD, GNU, shell built-in, 
etc.)
          there will be an error in csu/version-info.h if it picks the 
wrong
          one. Picking the wrong one results in '-n Version...' rather 
than
          the intended 'Version...' in csu/version-info.h.

          The second pitfall when building on a stock Solaris 5.7 machine,
          is that there is a limit of 64 open file descriptors. This will
          result in an error building in the iconvdata subdirectory. This
          can be remedied by ratcheting up the limit to 1024 and then
          running make again.

          The build process should take several hours to complete, even on
          the brawniest of hardware.

       4. Install

          If your make build process has completed successfully, the 
install
          process should go fairly smoothly. One tangle may occur when the
          make install process attempts to run in the locale directory.
          There are either missing rules for, or the rules don't work 
quite
          correctly for, the i18n/locales and i18n/repertoiremaps targets.

            1. gmake install

          If you encounter this problem, to work around it, simply create
          the following directories yourself:

            1. cd <tool dir>/powerpc-linux/share/
            2. mkdir i18n
            3. cd i18n/
            4. mkdir locales
            5. mkdir repertoiremaps

          The install process should take about 15 or so minutes, assuming
          that no errors are encountered.

  6. EGCS

     Provided that glibc compiled successfully, you are ready to go back 
and
     rebuild the C compiler and, if you wish, build the Objective C, C++ 
and
     F77 compilers.

       1. Extract
            1. cd <source dir>
            2. gtar zxvf <archive dir>/egcs-1.1.2.tar.gz

          Note that this will extract the entire EGCS suite on top of the
          previous core EGCS if you don't rename the previous source
          directory. Extraction on top of the previous directory shouldn't
          pose any problems.

       2. Build
            1. cd <object dir>/egcs-1.1.2
            2. <source dir>/egcs-1.1.2/configure --target=powerpc-linux
               --prefix=<tool dir> --with-headers=<tool
               dir>/powerpc-linux/include --with-libs=<tool
               dir>/powerpc-linux/lib --enable-languages="c,c++,f77"
            3. gmake

       3. Install
            1. gmake install

  7. Test

     user@ultraSPARC% pwd
     /home/user

     user@ultraSPARC% cat > hello.c
     #include <stdio.h>

     int main (void)
     {
             printf("Hello, world!\n");

             return (0);
     }

     user@ultraSPARC% uname -a
     SunOS ultraSPARC 5.7 Generic sun4u sparc

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-gcc -dumpmachine
     powerpc-linux

     user@ultraSPARC% ~/linuxppc/dev/bin/powerpc-linux-gcc -o hello 
hello.c
     user@ultraSPARC% file hello
     hello:          ELF 32-bit MSB executable PowerPC Version 1, 
dynamically linked

     user@PowerMac% pwd
     /home/user

     user@PowerMac% uname -a
     Linux PowerMac 2.2.6-15apmac #1 Mon May 31 03:54:09 EDT 1999 ppc 
unknown

     user@PowerMac% file hello
     hello: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1, 
dynamically linked

     user@PowerMac% ldd ./hello
             libc.so.6 => /lib/libc.so.6 (0x016be000)
             /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

     user@PowerMac% ./hello
     Hello, world!

Parting Notes
=============

Building all of the above requires a significant amount of space, on the
order of 150 MB for the powerpc-linux cross-development system hosted on 
Sun
Solaris 5.7. None of the above tools are stripped by default, so doing so
after installation will save an appreciable amount of space.

Useful Resources
================

   * http://egcs.cygnus.com/install/index.html
   * http://members.home.com/mmporter/cross.html
   * 
http://developer.intel.com/design/strong/applnots/sa1100lx/sa1100lx.htm
   * http://www.objsw.com/CrossGCC/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
