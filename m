Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0602E@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: GCC: why can't i compile with --enable-threads
Date: Sat, 11 Jan 2003 13:27:48 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just built gcc with glibc for x86 to ppc ... for an embedded MPC860 board
...

I had problems compiling with the --enable-threads flag enabled ... as per
instructions on www.pengunppc.org ...

I am built glibc with the enable threads package I believe ... anyone know
why this would happen ...

By three build scipts are below:
1.) build-gccBOOTSTRAP
2.) build-glibc
3.) build-gccWITH_GLBIC

The errors I get are below as well ...

I really would like to figure out what I have done wrong ... and suggestions
would be great ...

Best Regards,
Jim


>
>
----------------------------------------------------------------------------
-
> 1.) build-gccBOOTSTRAP
>
----------------------------------------------------------------------------
-
>
> #!/bin/bash
> #-------------------------------------------------------------
> # This bash script creates a linux x866 gcc cross compiler
> # for powerpc. This file has been tested with the following
> # modules:
> #    1.) binutils-2.13.90.0.2.tar.gz
> #    2.) gcc-3.2.tar.gz
> #    3.) newlib-synSept12-2002.tar.gz
> #-------------------------------------------------------------
>
> # Defining target
> TARGET=powerpc-linux
>
>
> # Defining prefix - final toolchain location
> PREFIX=$HOME/ppcgcc
>
> # PATH must updated
> PATH=$PREFIX/bin:$PATH
> export PATH
>
> # My local includes
> INCLUDE=/usr/include/
>
> # Configuring packages versions
> GCC_VER=2.95.3
> BINUTILS_VER=2.13.90.0.2
> NEWLIB_VER=1.10.0
>
>
> echo ===================================================
> echo BUILDING BINUTILS FOR $TARGET
> echo ===================================================
> # binutils
> rm -rf binutils-$BINUTILS_VER binutils
> tar zxvf binutils-$BINUTILS_VER.tar.gz
> mkdir binutils
> cd binutils
> ../binutils-$BINUTILS_VER/configure --target=$TARGET --prefix=$PREFIX
> make all
> make install
> cd ..
>
>
>
> echo ===================================================
> echo BUILDING GCC FOR $TARGET
> echo ===================================================
>
> echo extract GCC source from tar ball ...
> rm -rf gcc-$GCC_VER gcc
> tar zxvf gcc-core-$GCC_VER.tar.gz
> tar zxvf gcc-g++-$GCC_VER.tar.gz
>
>
> echo extract newlib source from tar ball- needed for gcc ...
> rm -rf  newlib-$NEWLIB_VER newlib
> tar zxvf newlib-$NEWLIB_VER.tar.gz
>
> echo set up symbolic links to newlib in gcc dir
> cd  gcc-$GCC_VER
> ln -s ../newlib-$NEWLIB_VER/newlib newlib
> ln -s ../newlib-$NEWLIB_VER/libgloss libgloss
> cd ..
>
> echo build gcc ...
> mkdir gcc
> cd gcc
> ../gcc-$GCC_VER/configure --target=$TARGET --with-newlib --prefix=$PREFIX
--with-gnu-as --with-gnu-ld --with-headers=$INCLUDE
> make all
> make install
> cd ..
>
>
>
> echo ===================================================
> echo BUILDING NEWLIB FOR $TARGET
> echo ===================================================
> # newlib
> mkdir newlib
> cd newlib
> ../newlib-$NEWLIB_VER/configure --target=$TARGET --prefix=$PREFIX --nfp
> make all
> make install
> cd ..
>
>
>
>
----------------------------------------------------------------------------
-
> 2.) build-glibc
>
----------------------------------------------------------------------------
-
> #!/bin/bash
>
> #-------------------------------------------------------------
> # This file builds glibc and recompiles gcc to link it to gcc
> #
> # This bash script creates a linux x866 gcc cross compiler
> # for powerpc. This file has been tested with the following
> # modules:
> #    1.) binutils-2.13.90.0.2.tar.gz
> #    2.) gcc-3.2.tar.gz
> #    3.) newlib-synSept12-2002.tar.gz
> #-------------------------------------------------------------
>
> # Defining target
> TARGET=powerpc-linux
>
>
> # Defining prefix - final toolchain location
> PREFIX=$HOME/ppcgcc
>
> # PATH must updated
> PATH=$PREFIX/bin:$PATH
> export PATH
>
> # My local includes
> INCLUDE=/usr/include/
>
> # Configuring packages versions
> GCC_VER=2.95.3
> BINUTILS_VER=2.13.90.0.2
> NEWLIB_VER=1.10.0
>
>
> #Define where kernel source is
> KERNEL_SOURCE=$HOME/ppclinux
>
> #These are the glibc files I am using ...
> #   glibc-linuxthreads-2.3.1.tar.gz
> #   glibc-2.3.1.tar.gz
> GLIBC_THREADS_VER=2.2.3
> GLIBC_VER=2.2.3
>
> #
> #Where we want to install compiled glibc
> #
> INSTALL_DIR=$HOME/powerpc-linux-gcc-glibc/
>
>
>
>
>
>
>
> echo ===================================================
> echo BUILDING GLIBC FOR $TARGET
> echo ===================================================
> ln -sf $KERNEL_SOURCE/include/asm $INSTALL_DIR/include/asm
> ln -sf $KERNEL_SOURCE/include/linux $INSTALL_DIR/include/linux
> tar zxfv glibc-$GLIBC_VER.tar.gz
> cd glibc-$GLIBC_VER
> tar zxfv ../glibc-linuxthreads-$GLIBC_THREADS_VER.tar.gz
> CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
./configure --host=powerpc-linux --enable-add-ons
--with-headers=$INSTALL_DIR/include --prefix=
> make
> make install_root=$INSTALL_DIR install
>
>
>
>
----------------------------------------------------------------------------
-
> 3.) build-gccWITH_GLBIC
>
----------------------------------------------------------------------------
-
> #!/bin/bash
>
> #-------------------------------------------------------------
> # This file builds glibc and recompiles gcc to link it to gcc
> #
> # This bash script creates a linux x866 gcc cross compiler
> # for powerpc. This file has been tested with the following
> # modules:
> #    1.) binutils-2.13.90.0.2.tar.gz
> #    2.) gcc-3.2.tar.gz
> #    3.) newlib-synSept12-2002.tar.gz
> #-------------------------------------------------------------
>
> # Defining target
> TARGET=powerpc-linux
>
>
> # Defining prefix - final toolchain location
> PREFIX=$HOME/ppcgcc
>
> # PATH must updated
> PATH=$PREFIX/bin:$PATH
> export PATH
>
> # My local includes
> #INCLUDE=/usr/include/
> INCLUDE=$HOME/powerpc-linux-gcc-glibc/include
>
> # Configuring packages versions
> GCC_VER=2.95.3
> BINUTILS_VER=2.13.90.0.2
> NEWLIB_VER=1.10.0
>
>
> #Define where kernel source is
> KERNEL_SOURCE=$HOME/ppclinux
>
> #These are the glibc files I am using ...
> #   glibc-linuxthreads-2.3.1.tar.gz
> #   glibc-2.3.1.tar.gz
> GLIBC_THREADS_VER=2.2.3
> GLIBC_VER=2.2.3
>
> #
> #Where we want to install compiled glibc
> #
> INSTALL_DIR=$HOME/powerpc-linux-gcc-glibc/
>
> # These are the instructions to build glibc from penguinppc.org ...
> #
> #You must first follow the kernel instructions, but you may omit the make
zImage portion
> #      ln -sf <top of Linux kernel tree>/include/asm
/usr/powerpc-linux/include/asm
> #      ln -sf <top of Linux kernel tree>/include/linux
/usr/powerpc-linux/include/linux
> #      tar zxf glibc-x.x.x.tar.gz
> #      cd glibc-x.x.x
> #      tar zxf ../glibc-linuxthreads-x.x.x.tar.gz
> #      CC=powerpc-linux-gcc
> #      AR=powerpc-linux-ar
> #      RANLIB=powerpc-linux-ranlib
> #      ./configure --host=powerpc-linux --enable-add-ons
--with-headers=/usr/local/powerpc-linux/include --prefix=
> #      make
> #DANGER: You WILL screw up your system if you forget the install_root part
of the next command.
> #      make install_root=/usr/local/powerpc-linux install
>
>
> echo ===================================================
> echo BUILDING GLIBC FOR $TARGET
> echo ===================================================
> #ln -sf $KERNEL_SOURCE/include/asm $INSTALL_DIR/include/asm
>
> #ln -sf $KERNEL_SOURCE/include/linux $INSTALL_DIR/include/linux
>
> #tar zxfv glibc-$GLIBC_VER.tar.gz
>
> #cd glibc-$GLIBC_VER
>
> #tar zxfv ../glibc-linuxthreads-$GLIBC_THREADS_VER.tar.gz
>
> #CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
./configure --host=powerpc-linux --enable-add-ons
--with-headers=$INSTALL_DIR/include --prefix=
>
> #make
>
> #make install_root=$INSTALL_DIR install
>
>
> echo ===================================================
> echo BUILDING GCC WITH GLIBC FOR $TARGET
> echo ===================================================
> cd $PREFIX
> rm -rf gcc-$GCC_VER gcc-glibc
> tar zxvf gcc-core-$GCC_VER.tar.gz
> tar zxvf gcc-g++-$GCC_VER.tar.gz
>
>
> #To rebuild gcc using glibc instead of newlib for the library:
> mkdir gcc-glibc
> cd gcc-glibc
> #../gcc-$GCC_VER/configure --target=powerpc-linux --enable-shared
--enable-threads
> ../gcc-$GCC_VER/configure --target=$TARGET --prefix=$PREFIX
--enable-shared --enable-threads --with-gnu-as --with-gnu-ld
--with-headers=$INCLUDE
> make
> make install
> cd ..
>
> echo ===================================================
> echo FINISHED BUILDING GCC WITH GLIBC FOR $TARGET
> echo ===================================================
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
