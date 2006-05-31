Return-Path: <nathanpilatzke@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id 0E59867B14
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 00:47:55 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so34079wra
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 07:47:54 -0700 (PDT)
Message-ID: <447DAAE4.7010503@gmail.com>
Date: Wed, 31 May 2006 10:40:36 -0400
From: Nathan Pilatzke <nathanpilatzke@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: >=2.6.17-rc4-mm1 kernel compilation problem (relocation truncated
	to fit)
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am getting compilation errors for 2.6.17-rc5-mm1 all the way back to
2.6.17-rc4-mm1.  Kernel 2.6.17-rc3-mm1 compiles better for me (I get the
undefined reference to __udivdi3 error that has been reported
previously).  Here are the errors that I get for 2.6.17-rc5-mm1:

  ... (previous output snipped)
  KLIBCCC usr/kinit/ipconfig/main.o
  KLIBCCC usr/kinit/ipconfig/netdev.o
  KLIBCCC usr/kinit/ipconfig/packet.o
  KLIBCCC usr/kinit/ipconfig/dhcp_proto.o
  KLIBCCC usr/kinit/ipconfig/bootp_proto.o
  LD      usr/kinit/ipconfig/lib.a
  KLIBCLD usr/kinit/ipconfig/static/ipconfig
  KLIBCLD usr/kinit/ipconfig/shared/ipconfig
usr/kinit/ipconfig/main.o: In function `complete_device':
main.c:(.text+0x6c): relocation truncated to fit: R_PPC_REL24 against
symbol `inet_ntoa' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x84): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0xac): relocation truncated to fit: R_PPC_REL24 against
symbol `inet_ntoa' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0xc4): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0xe4): relocation truncated to fit: R_PPC_REL24 against
symbol `inet_ntoa' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0xfc): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x134): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x158): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x17c): relocation truncated to fit: R_PPC_REL24 against
symbol `printf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x19c): relocation truncated to fit: R_PPC_REL24 against
symbol `snprintf' defined in .text section in
/usr/src/linux-2.6.17-rc5-mm1/usr/klibc/libc.so
main.c:(.text+0x1ac): additional relocation overflows omitted from the
output
make[3]: *** [usr/kinit/ipconfig/shared/ipconfig] Error 1
make[2]: *** [usr/kinit/ipconfig] Error 2
make[1]: *** [_usr_kinit] Error 2
make: *** [usr] Error 2

I assume that the errors I am seeing are regarding the klibc changes
that went into 2.6.17-rc4-mm1 (and apparently no one else is seeing
these errors as I would think that I would have found them reported
somewhere).  I am running a gentoo system on an eMac 7450 PowerPC.
Here's my gcc info:

# gcc -v
Reading specs from /usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.5/specs
Configured with: /var/tmp/portage/gcc-3.4.5-r1/work/gcc-3.4.5/configure
--prefix=/usr --bindir=/usr/powerpc-unknown-linux-gnu/gcc-bin/3.4.5
--includedir=/usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.5/include
--datadir=/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.5
--mandir=/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.5/man
--infodir=/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.5/info
--with-gxx-include-dir=/usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.5/include/g++-v3
--host=powerpc-unknown-linux-gnu --build=powerpc-unknown-linux-gnu
--enable-altivec --enable-nls --without-included-gettext
--with-system-zlib --disable-checking --disable-werror
--disable-libunwind-exceptions --disable-multilib --disable-libgcj
--enable-languages=c,c++,f77 --enable-shared --enable-threads=posix
--enable-__cxa_atexit --enable-clocale=gnu
Thread model: posix
gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)

Need anything else?  Can anyone offer some help or ideas?
Thanks, nathanp.
(please cc me on responses)
