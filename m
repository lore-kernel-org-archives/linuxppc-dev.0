From: "Beena" <beena@gdatech.com>
To: "Silverton Aron-C1710C" <Aron.J.Silverton@motorola.com>,
	"'Ashwin Bihari'" <raz0redge@hotmail.com>, <listmember@orkun.us>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: <dank@kegel.com>
Subject: RE: Cross-compile package combinations
Date: Thu, 11 Dec 2003 15:15:48 -0800
Message-ID: <FFELLIHDBBOAPGLCBDIPEEADCDAA.beena@gdatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6F8DFFA2C996D711945800065BFC9E4A038ECB22@il02exm11>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have observed the same errors when trying to build the bootstrap gcc
3.2.3. I understand that
this is because gcc 3.2.3 build (in case of powerpc) looks for some glibc
files. So I first built gcc 2.95.3,
then glibc 2.2.1 and then built bootstrap gcc 3.2.2(you could try with
3.2.3) and it compiled fine.

Hope this helps.
Beena

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
Silverton Aron-C1710C
Sent: Thursday, December 11, 2003 1:57 PM
To: 'Ashwin Bihari'; 'listmember@orkun.us';
'linuxppc-embedded@lists.linuxppc.org'
Cc: 'dank@kegel.com'
Subject: RE: Cross-compile package combinations



Continuing this top-posting madness:

I am trying to build gcc 3.2.3 for powerpc-linux on i386.  I have binutils
2.14 built already.  I have not done anything with glibc as of yet.  Here is
where I die:

[lots of stuff omitted]
mkdir libgcc
mkdir nof
mkdir libgcc/nof
if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
/usr/proj/ssr/linux_bsp/mcip805/build-tools/build-boot-gcc/gcc/xgcc
-B/usr/proj/ssr/linux_bsp/mcip805/build-tools/build-boot-gcc/gcc/
-B/usr/proj/ssr/linux_bsp/mcip805/tools/powerpc-linux/bin/
-B/usr/proj/ssr/linux_bsp/mcip805/tools/powerpc-linux/lib/ -isystem
/usr/proj/ssr/linux_bsp/mcip805/tools/powerpc-linux/include -O2  -DIN_GCC
-DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes
-Wmissing-prototypes -isystem ./include  -fPIC -g -DHAVE_GTHR_DEFAULT
-DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -I. -I.
-I../../gcc-3.2.3/gcc -I../../gcc-3.2.3/gcc/. -I../../gcc-3.2.3/gcc/config
-I../../gcc-3.2.3/gcc/../include  -fPIC -mstrict-align -DL_muldi3 -c
../../gcc-3.2.3/gcc/libgcc2.c -o libgcc/./_muldi3.o
In file included from tconfig.h:21,
                 from ../../gcc-3.2.3/gcc/libgcc2.c:36:
../../gcc-3.2.3/gcc/config/rs6000/linux.h:81:20: signal.h: No such file or
directory
../../gcc-3.2.3/gcc/config/rs6000/linux.h:82:26: sys/ucontext.h: No such
file or directory
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: Leaving directory
`/usr/proj/ssr/linux_bsp/mcip805/build-tools/build-boot-gcc/gcc'
make[1]: *** [stmp-multilib] Error 2
make[1]: Leaving directory
`/usr/proj/ssr/linux_bsp/mcip805/build-tools/build-boot-gcc/gcc'
make: *** [all-gcc] Error 2

I issued the commands:

$ ../gcc-3.2.3/configure --target=$TARGET --prefix=${PREFIX}
--without-headers --with-newlib --enable-langauges=c

$ make all-gcc

I am not using crosstools.  I may trie it if I can figure out how to specify
the paths to put everything where I want it.

Any suggestions?

Thanks,

Aron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
