To: "René Pachernegg" <rene.pachernegg@apus.co.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <387AEF42.5115A6D9@apus.co.at> <kfyr9fo77re.fsf@kieraypc07.p.y.ki.era.ericsson.se> <387BECD0.4FFDB494@charter.net> <387C3709.732D9A48@apus.co.at>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 12 Jan 2000 13:01:05 +0100
In-Reply-To: "René Pachernegg"'s message of "Wed, 12 Jan 2000 09:10:49 +0100"
Message-ID: <kfyembn7b3y.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"René Pachernegg" <rene.pachernegg@apus.co.at> writes:

> Glibc 2.1.1 (from one of the linuxppc mirror sites, source/base/..)
> Compiler: egcs-2.91.57 (thats what configure says)

Sounds old.

> configure --prefix=./tools/glibc --exec-prefix=./tools/glibc
> --with-headers=**Dir of the cross-compiled Kernel and its headers**
> --enable-add-ons --build=i686-*-linux --host=powerpc-*-linux-gnu
> CC='powerpc-eabi-gcc -b powerpc-eabi' 
> CFLAGS='-mcpu=603e -meabi'
> Addons are just crypt und linuxthreads.
> 
> Still more has happend since yesterday. I removed everything, unpacked
> the glibc again and started building. This time it went a bit further
> and reportet:
> 
> /project/v4/software/ext-tools/egcs-1.1b-newlib/bin/powerpc-eabi-gcc -b
> powerpc-eabi   -shared -Wl,-O1 -o libdb1.so 
> -Wl,-dynamic-linker=./compile/lib/ld.so.1 -B../csu/
> -Wl,--version-script=../libdb1.map -Wl,-soname=libdb1.so.2 
> -Wl,-soname=libdb.so.2 -L.. -L../math -L../elf -L../nss -L../nis
> -L../db2 -L../rt -L../resolv -L../linuxthreads
> -Wl,-rpath-link=..:../math:../elf:../nss:../nis:../db2:../rt:../resolv:../linuxthreads
> -Wl,--whole-archive libdb1_pic.a ../elf/interp.os ../libc.so
> -Wl,--no-whole-archive
> collect2: ld terminated with signal 11 [Segmentation fault]
> powerpc-eabi-gcc: file path prefix `../csu/' never used
> make[1]: *** [libdb1.so] Error 1
> make[1]: Leaving directory `/opt/v4lx/work/linux_pkg/glibc/glibc2/db'
> make: *** [db/others] Error 2 
> 
> I suppose I messed something up at the first try( I'am new to powerpc
> cross compiling and not what you'd call an experienced linux user). I
> hope you have got enough information for helping me a little bit. Thanks
> in advance.

I'm not really sure a compiler built for use with newlib and eabi (is
eabi what PPC Linux uses or is it another abi?) (which your compiler
path and name suggests), contains the correct startup code for use with
glibc and programs/libraries linked against it. The signal 11 in any
case suggests that there is something very wrong with your build tools.

I suggest you install binutils 2.9.1.0.25 and gcc 2.95.2 as cross tools,
and configure them with ppc-linux as target.

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
