Message-ID: <3F452F86.2050004@mvista.com>
Date: Thu, 21 Aug 2003 15:45:58 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: C Doyle <cdoyle35@hotmail.com>
Cc: libusb-devel@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: libusb harhat/eldk cross-compile problems
References: <Law10-F1011bpqRbwXQ0004bf26@hotmail.com>
In-Reply-To: <Law10-F1011bpqRbwXQ0004bf26@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You will need to override the configure step for figuring out things via
compilation and running.

You will need to look at the configure script and see if you can
override the sizeof char.  (Similarly to how you overrode
ac_cv_func_setvbuf_reversed on the command line.)

If that is not possible, you will have to hack "configure" with the hard
coded value.  (To do it "right" you should modify configure.in, then run
autoconf.  However, that doesn't always work.)

--Mark

C Doyle wrote:
>
> Hello all,
>    I'm trying to get the libusb to cross compile using hardhat development
> kit.  I've also tried it with ELDK but get the same error in the
> ./configure
> script.  Note the last line in the screen grab below......Does this mean I
> will not be able to get it to work?? If anyone has got it to work can you
> let me know what flags and/or compiler preprocessing you done? Thanks v
> much
>
> Ciaran Doyle
>
>
> [root@MPC8266 libusb-0.1.7]# ac_cv_func_setvbuf_reversed=no
> CC=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc
> AS=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-as
> LD=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ld
> AR=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ar
> RANLIB=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ranlib
> CPP=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-cpp
> CXX=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-g++
> NM=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-nm
> STRIP=/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-strip ./configure
> --target=powerpc-linux --host=i686-pc-linux-gnu --build=powerpc-linux
> --prefix=/tftpboot/SID/usr/local/ --exec-prefix=/tftpboot/SID/usr/local/
> --bindir=/tftpboot/SID/usr/local/bin/
> --sbindir=/tftpboot/SID/usr/local/sbin/
> --libexecdir=/tftpboot/SID/usr/local/
> --datadir=/tftpboot/SID/usr/local/share/ --sysconfdir=/tftpboot/SID/etc/
> --localstatedir=/tftpboot/SID/var/ --libdir=/tftpboot/SID/usr/local/lib/
> --includedir=/tftpboot/SID/usr/local/include/
> loading cache ./config.cache
> checking for a BSD compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking whether make sets ${MAKE}... yes
> checking for working aclocal... found
> checking for working autoconf... found
> checking for working automake... found
> checking for working autoheader... found
> checking for working makeinfo... found
> checking for Cygwin environment... no
> checking for mingw32 environment... no
> checking how to run the C preprocessor...
> /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-cpp
> checking host system type... i686-pc-linux-gnu
> checking build system type... powerpc-unknown-linux-gnu
> checking for gcc... /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc
> checking whether the C compiler
> (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc  ) works... yes
> checking whether the C compiler
> (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc  ) is a cross-compiler...
> yes
> checking whether we are using GNU C... yes
> checking whether /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc accepts
> -g...
> yes
> checking for ld used by GCC... /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ld
> checking if the linker (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ld) is
> GNU
> ld... yes
> checking for /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ld option to reload
> object files... -r
> checking for BSD-compatible nm...
> /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-nm
> checking whether ln -s works... yes
> checking how to recognise dependant libraries... pass_all
> checking for object suffix... o
> checking for executable suffix... no
> checking command to parse /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-nm
> output... ok
> checking for dlfcn.h... yes
> checking for i686-pc-linux-gnu-ranlib...
> /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ranlib
> checking for i686-pc-linux-gnu-strip...
> /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-strip
> checking for objdir... .libs
> checking for /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc option to
> produce
> PIC... -fPIC
> checking if /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc PIC flag -fPIC
> works... yes
> checking if /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc static flag
> -static works... yes
> checking if /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc supports -c -o
> file.o... yes
> checking if /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc supports -c -o
> file.lo... yes
> checking if /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc supports
> -fno-rtti
> -fno-exceptions... yes
> checking whether the linker (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-ld)
> supports shared libraries... yes
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking dynamic linker characteristics... GNU/Linux ld.so
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking whether -lc should be explicitly linked in... no
> creating libtool
> checking whether to enable maintainer-specific portions of Makefiles... no
> checking host system type... i686-pc-linux-gnu
> checking for what USB OS support... Linux
> checking for gcc... (cached) /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc
> checking whether the C compiler
> (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc -g -O2 -g ) works... yes
> checking whether the C compiler
> (/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc -g -O2 -g ) is a
> cross-compiler... yes
> checking whether we are using GNU C... (cached) yes
> checking whether /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc accepts
> -g...
> (cached) yes
> checking for /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-gcc option to accept
> ANSI C... none needed
> checking for a BSD compatible install... /usr/bin/install -c
> checking for ANSI C header files... yes
> checking for vprintf... yes
> checking size of char... configure: error: can not run test program while
> cross compiling
> [root@MPC8266 libusb-0.1.7]#
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
