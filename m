From: "sting sting" <zstingx@hotmail.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: cross-compiling problems (linux to ppc)
Date: Wed, 31 Mar 2004 14:17:09 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F28k1Ixzl4anSs00047d9a@hotmail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
My host is a linux x86 RedHat machine.
My Target is Linux PowerPC  machine.

Now , I had followed the instructions on :
http://penguinppc.org/embedded/cross-compiling/
the only diffference I had made was added the "--prefix=/opt/ppc"
so that it will insatll it in a different directory (because
I need also original binutil and gcc to compile for x86 linux targets).


what I did is :
downloaded latest release tars of binutils and gcc.

for binutil:
I created a toplevel build directory and from there:

./configure --target=powerpc-linux --prefix=/opt/ppc
make
make install

and it went OK.

Now , fior gcc:
I created a toplevel build directory and from there:
./configure --target=powerpc-linux --prefix=/opt/ppc --disable-shared
--disable-threads --enable-languages=c --with-newlib

I get immediately the following mesage:
../gcc-3.3.2/configure --target=powerpc-linux --prefix=/opt/ppc
--disable-shared --disable-threads --enable-languages=c --with-newlib |more
Configuring for a i686-pc-linux-gnu host.
*** This configuration is not supported in the following subdirectories:
     target-libstdc++-v3 target-libf2c target-libffi target-boehm-gc
target-zlib target-libjava zlib fastjar target-libobjc
    (Any other directories should still work fine.)

but it finishes the ./configure command.

Then , in make , I get after some time the following error messages:

if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
/home/sad/src/build-gcc/gcc/xgcc -B/home/sad/src/build-gcc/gcc/ -B/opt/ppc
erpc-linux/bin/ -B/opt/ppc/powerpc-linux/lib/ -isystem /opt/ppc/powerpc-linu
clude -O2  -DIN_GCC -DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prot
es -Wmissing-prototypes -isystem ./include  -fPIC -g  -DIN_LIBGCC2 -D__GCC_F
_NOT_NEEDED -Dinhibit_libc -I. -I. -I../../gcc-3.3.2/gcc -I../../gcc-3.3.2/g
-I../../gcc-3.3.2/gcc/config -I../../gcc-3.3.2/gcc/../include  -fPIC -mstri
lign -DL_muldi3 -c ../../gcc-3.3.2/gcc/libgcc2.c -o libgcc/./_muldi3.o
In file included from tconfig.h:22,
                 from ../../gcc-3.3.2/gcc/libgcc2.c:36:
../../gcc-3.3.2/gcc/config/rs6000/linux.h:89:20: signal.h: No such file or d
tory
In file included from tconfig.h:22,
                 from ../../gcc-3.3.2/gcc/libgcc2.c:36:
../../gcc-3.3.2/gcc/config/rs6000/linux.h:98: error: parse error before "sta
"
../../gcc-3.3.2/gcc/config/rs6000/linux.h:98: warning: no semicolon at end o
ruct or union



Needless to say, but still , I have signal.h under /usr/include ,
/usr/include/linux, and in some other
locations



regards
sting


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
