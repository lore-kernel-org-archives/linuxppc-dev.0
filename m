Date: Fri, 7 Jan 2000 21:19:26 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with short in va_arg list with 2.95.1 gcc
Message-ID: <20000107211926.A27294@drow.res.cmu.edu>
References: <200001072251.OAA13463@sade.ddi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200001072251.OAA13463@sade.ddi.com>; from terman@ddi.com on Fri, Jan 07, 2000 at 02:51:19PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[FAQ]

short is not a legal type for va_arg.  Instead, use
(short)va_arg(arglist, int).

On Fri, Jan 07, 2000 at 02:51:19PM -0800, Jim Terman wrote:
> 
> I am having a problem with code that looks for type short in a va_arg list
> when optimization is turned on.  There is no problem with no optimization.
> It compiles fine but produces an undefined reference to `__va_arg_type_violation'
> which I assume is delibrate to flag an error.  Is there a workaround besides
> turning off optimizations?
> 
> If I compile the following file:
> test.c
> ------
> #include <stdarg.h>
> #include <stdio.h>
> 
> void printout(short d, ...)
> {
>   va_list arglist;
> 
>   printf("%d ", d);
>   d = va_arg (arglist, short);
>   while (d)
>     {
>       printf("%s ", d);
>       d = va_arg (arglist, short);
>     }
> }
> 
> int main()
> {
>   printout(1, 2, 0);
>   printout(2, 3,  4, 0);
>   return 0;
> }
> 
> with the command line:
> 
> > gcc -v -O test.c
> Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/specs
> gcc version 2.95.1 19990809 (prerelease)
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/cpp -lang-c -v -D__GNUC__=2 -D__GNUC_MINOR__=95 -DPPC -D__ELF__ -Dpowerpc -D__PPC__ -D__ELF__ -D__powerpc__ -D__PPC -D__powerpc -Acpu(powerpc) -Amachine(powerpc) -D__CHAR_UNSIGNED__ -D__OPTIMIZE__ -D_CALL_SYSV -D_BIG_ENDIAN -D__BIG_ENDIAN__ -Amachine(bigendian) -D_ARCH_PPC -D__unix__ -D__linux__ -Dunix -Dlinux -Asystem(unix) -Asystem(posix) test.c /tmp/ccnguSmk.i
> GNU CPP version 2.95.1 19990809 (prerelease) (PowerPC GNU/Linux)
> #include "..." search starts here:
> #include <...> search starts here:
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/../../../../ppc-redhat-linux/include
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/include
>  /usr/include
> End of search list.
> The following default directories have been omitted from the search path:
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/../../../../include/g++-3
>  /usr/local/include
> End of omitted list.
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/cc1 /tmp/ccnguSmk.i -quiet -dumpbase test.c -O -version -o /tmp/ccwsSAdv.s
> GNU C version 2.95.1 19990809 (prerelease) (ppc-redhat-linux) compiled by GNU C version 2.95.1 19990809 (prerelease).
>  as -mppc -V -Qy -o /tmp/ccF8j30K.o /tmp/ccwsSAdv.s
> GNU assembler version 2.9.5 (ppc-redhat-linux) using BFD version 2.9.5.0.14
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/collect2 -m elf32ppclinux -dynamic-linker /lib/ld.so.1 /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/crtbegin.o -L/usr/lib/gcc-lib/ppc-redhat-linux/2.95.1 /tmp/ccF8j30K.o /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/libgcc.a -lc /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/libgcc.a /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/crtend.o /usr/lib/crtn.o
> /tmp/ccF8j30K.o: In function `printout':
> /tmp/ccF8j30K.o(.text+0x60): undefined reference to `__va_arg_type_violation'
> /tmp/ccF8j30K.o(.text+0x60): relocation truncated to fit: R_PPC_REL24 __va_arg_type_violation
> collect2: ld returned 1 exit status
> 
> > gcc -v test.c
> Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/specs
> gcc version 2.95.1 19990809 (prerelease)
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/cpp -lang-c -v -D__GNUC__=2 -D__GNUC_MINOR__=95 -DPPC -D__ELF__ -Dpowerpc -D__PPC__ -D__ELF__ -D__powerpc__ -D__PPC -D__powerpc -Acpu(powerpc) -Amachine(powerpc) -D__CHAR_UNSIGNED__ -D_CALL_SYSV -D_BIG_ENDIAN -D__BIG_ENDIAN__ -Amachine(bigendian) -D_ARCH_PPC -D__unix__ -D__linux__ -Dunix -Dlinux -Asystem(unix) -Asystem(posix) test.c /tmp/ccTOmkZu.i
> GNU CPP version 2.95.1 19990809 (prerelease) (PowerPC GNU/Linux)
> #include "..." search starts here:
> #include <...> search starts here:
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/../../../../ppc-redhat-linux/include
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/include
>  /usr/include
> End of search list.
> The following default directories have been omitted from the search path:
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/../../../../include/g++-3
>  /usr/local/include
> End of omitted list.
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/cc1 /tmp/ccTOmkZu.i -quiet -dumpbase test.c -version -o /tmp/ccUI6hGQ.s
> GNU C version 2.95.1 19990809 (prerelease) (ppc-redhat-linux) compiled by GNU C version 2.95.1 19990809 (prerelease).
>  as -mppc -V -Qy -o /tmp/ccBIgJ3g.o /tmp/ccUI6hGQ.s
> GNU assembler version 2.9.5 (ppc-redhat-linux) using BFD version 2.9.5.0.14
>  /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/collect2 -m elf32ppclinux -dynamic-linker /lib/ld.so.1 /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/crtbegin.o -L/usr/lib/gcc-lib/ppc-redhat-linux/2.95.1 /tmp/ccBIgJ3g.o /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/libgcc.a -lc /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/libgcc.a /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/crtend.o /usr/lib/crtn.o
> > 
> -- 
> ______________________________________________________________________________
> Jim Terman       |   323 Vintage Park Dr.   |   Voice: (650) 356-5446
> terman@ddi.com   |   Foster City, CA        |   Fax:   (650) 356-5490
> Diab-SDS, Inc.   |   94404                  |   web site - http://www.ddi.com
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
