Message-ID: <387C3709.732D9A48@apus.co.at>
Date: Wed, 12 Jan 2000 09:10:49 +0100
From: "Reni Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: Dan Dickey <ddickey@charter.net>
CC: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <387AEF42.5115A6D9@apus.co.at> <kfyr9fo77re.fsf@kieraypc07.p.y.ki.era.ericsson.se> <387BECD0.4FFDB494@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


*Note to Dave Wolfe: Changed my mail (Netscape) settings, but I'm not*
*sure if its now the format that you need. If not,  please appologize*
*and give me some hints to upgrade my mail systems.*

Dan Dickey wrote:
> 
> Marcus Sundberg wrote:
> >
> > "Rene Pachernegg" <rene.pachernegg@apus.co.at> writes:
> >
> > > Hello,
> > >
> > > When building the GNU libc on a cross-compiler (i686 --> PowerPc 603e)
> > > I get the following linker error (current directory: elf):
> > > ../libc_pic.a(init-first.os): In function '_dl_start':
> > > init-first.os(.text+0xb8): multiple definition of '_dl_start'
> > > dl-allobjs.os(.text0x0): first defined here Warning: size of symbol
> > > '_dl_start' changed from 1576 to 16 in init-first.os collect2: ld
> > > returned 1 exit status make[1]: *** [librtld.os] Error 1 make: ***
> > > [elf/subdir_lib] Error2
> > >
> > > What can I do? Are there special linker/compiler options?
> >
> > What version of glibc are you using?
> > How did you configure glibc?
> > What make command line (s) did you use?
> 
> I'd also chime in with,
> What version of the compiler are you using?

Glibc 2.1.1 (from one of the linuxppc mirror sites, source/base/..)
Compiler: egcs-2.91.57 (thats what configure says)
configure --prefix=./tools/glibc --exec-prefix=./tools/glibc
--with-headers=**Dir of the cross-compiled Kernel and its headers**
--enable-add-ons --build=i686-*-linux --host=powerpc-*-linux-gnu
CC='powerpc-eabi-gcc -b powerpc-eabi' 
CFLAGS='-mcpu=603e -meabi'
Addons are just crypt und linuxthreads.

Still more has happend since yesterday. I removed everything, unpacked
the glibc again and started building. This time it went a bit further
and reportet:

/project/v4/software/ext-tools/egcs-1.1b-newlib/bin/powerpc-eabi-gcc -b
powerpc-eabi   -shared -Wl,-O1 -o libdb1.so 
-Wl,-dynamic-linker=./compile/lib/ld.so.1 -B../csu/
-Wl,--version-script=../libdb1.map -Wl,-soname=libdb1.so.2 
-Wl,-soname=libdb.so.2 -L.. -L../math -L../elf -L../nss -L../nis
-L../db2 -L../rt -L../resolv -L../linuxthreads
-Wl,-rpath-link=..:../math:../elf:../nss:../nis:../db2:../rt:../resolv:../linuxthreads
-Wl,--whole-archive libdb1_pic.a ../elf/interp.os ../libc.so
-Wl,--no-whole-archive
collect2: ld terminated with signal 11 [Segmentation fault]
powerpc-eabi-gcc: file path prefix `../csu/' never used
make[1]: *** [libdb1.so] Error 1
make[1]: Leaving directory `/opt/v4lx/work/linux_pkg/glibc/glibc2/db'
make: *** [db/others] Error 2 

I suppose I messed something up at the first try( I'am new to powerpc
cross compiling and not what you'd call an experienced linux user). I
hope you have got enough information for helping me a little bit. Thanks
in advance.

Regards 
	Rene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
