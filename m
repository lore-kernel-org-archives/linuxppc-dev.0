Message-ID: <6F8DFFA2C996D711945800065BFC9E4A038ECB22@il02exm11>
From: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
To: "'Ashwin Bihari'" <raz0redge@hotmail.com>,
	"'listmember@orkun.us'" <listmember@orkun.us>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'dank@kegel.com'" <dank@kegel.com>
Subject: RE: Cross-compile package combinations
Date: Thu, 11 Dec 2003 15:57:03 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

owner-linuxppc-embedded@lists.linuxppc.org
<mailto:owner-linuxppc-embedded@lists.linuxppc.org> wrote:
> I have indeed tried a fairly recent version of GCC, the
> aforementioned 3.2.3 with Linux 2.4.23 and it works like a charm
> in our PPC environment. I didn't bother with the 3.3.x release of
> GCC mainly because other toolchains used for other stuff in our
> environment also used 3.2.3, so I wanted to stay in lockstep with
> those versions.
>
> ~Ashwin
>
>
>
>
>> From: "listmember@orkun.us" <listmember@orkun.us>
>> To: linuxppc-embedded@lists.linuxppc.org
>> CC: "Dan Kegel" <dank@kegel.com>
>> Subject: Re: Cross-compile package combinations
>> Date: Thu, 11 Dec 2003 10:06:40 -0600 (CST)
>>
>>
>>>
>>> Silverton Aron-C1710C wrote:
>>>> Hello all,
>>>>
>>>> Can somebody give me a clue as to which versions of binutils,
>>>> gcc, and glibc are compatible with each other?  I'd like to
>>>> use gcc 3.2 or 3.3 and I am developing on i386 targeting
>>>> PowerPC.  I'll be using 2.4 kernels initially and then moving
>>>> to 2.6.
>>>>
>>>> If there is a known reference or recent previous post (I
>>>> didn't see one in my initial search) I'd appreciate a pointer.
>>>
>>> As Ashwin mentioned, http://kegel.com/crosstool might come in
>>> handy. See also the matrix at http://embeddedtux.org.
>>> - Dan
>>
>> Funny, I was just about to ask  very similar question. I will be
>> working an a IBM PPC405G based development board (Cogent CSB272)
>> for an internal project. I would like to use as up-to-date
>> versions of GCC, GLIBC and Linux 2.4 kernel as possible (without
>> sacrificing stability).
>>
>> - Has anyone used recently released 2.4.23 (kernel.org) in any
>> PPC project yet? If it is not good to use for PPC based
>> development? Do I need to get a ppc specific modified kernel or
>> do I need to apply any patches to linus 2.4.23 kernel to get it
>> working in PPC405 embedded environment.
>>
>> - Kernel 2.4.x README still says the official kernel compiler is
>> gcc
>> 2.95.3. Is it still the case or using a more recent GCC compiler
>> is now acceptable? In the last Linux embedded project I was in
>> we had used this one along with a very early build of kernel. I
>> was not the one to set the development environment so bear with
>> me if these sound basic questions to you.
>>
>> - I built a toolchain using crosstools based on gcc 3.3.2, glibc
>> 2.3.2 and binutils 2.14.90.0.5. Crosstools default .dat files
>> pull kernel
>> 2.4.21 but I also got the tools compiled using 2.4.23 sources. I
>> have not tested them yet since I don't have the board yet? Any
>> comments regarding this combination?
>>
>> Looking at some ppc linux distros (not necessarily embedded):
>>
>> YDL 3.0: kernel 2.4.20, gcc ? glibc 2.3.1, binutils ?
>> Mandrake: kernel 2.3.21, gcc 3.2.2, glibc, 2.3.1, binutils ?
>> Gentoo: kernel 2.4.22, gcc ? glibc 2.3.2?, binutils ?
>>
>> Tolunay
>>
>>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
