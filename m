Message-ID: <371DE90F.6303BC2B@fi.infn.it>
Date: Wed, 21 Apr 1999 17:04:47 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: David De Ridder <david.de.ridder@bitsmart.com>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME2306 : kernel 2.2.6 SUCCESS !
References: <Pine.SO4.4.05.9904201732460.14947-100000@hsins.uia.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David De Ridder wrote:
> 
> Hi,
> 
> a quick report :
> 
> * I patched my 2.2.4 source tree to 2.2.6 (through 2.2.5)
> * I applied Gabriel's latest patches (for 2.2.6). First generic,
>   then vme. There were no messages during patching (``patch -p0 -s'').
> * ``make distclean'' on the patched tree
> * ``make oldconfig'' using Gabriel's mvme2600.config.nfsroot for 2.2.6
> * ``make bzImage'' (went flawless)
> * ``make modules'' - no problems this time
> * ``make modules_install''
> * ``depmod -a'' gives no messages (this is good)
Hi,
I just finished to try this procedure (with some more step added) to
cross-compile the kernel on my PC, but it does not work.
I did all the step up to the distclean, then I modify the Makefile
(according to Matt Porter instructions), I copied the
mvme2600.config.nfsroot as .config and did make oldconfig.
Everything up to here went fine, without any error or warning.
Then I did make dep and make clean (always using the Matt Porter
instruction) and the make zImage, at the end the error was this:

powerpc-linux-gcc -D__KERNEL__ -I/home/ppc/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=603e -D__powerpc__ -msoft-float -pipe -fno-builtin -Wall
-mmultiple -mstring -I../boot -I/home/ppc/linux -D__KERNEL__ -O2
-fomit-frame-pointer -mrelocatable -ffixed-r13 -D__BOOT__ -DDEBUG  -c -o
zlib.o zlib.c
zlib.c:83: string.h: No such file or directory
zlib.c: In function `inflate_blocks':
zlib.c:878: warning: implicit declaration of function `memcpy'
make[1]: *** [zlib.o] Error 1
make[1]: Leaving directory `/home/ppc/linux/arch/ppc/prepboot'
make: *** [zImage] Error 2

I'm a little bit worried about the -mcpu=603e switch but I don't think
this can be relate to the error. 
I looked inside the kernel tree and there are many of these file inside:

/home/ppc/linux/include/asm-alpha/string.h
/home/ppc/linux/include/asm-arm/string.h
/home/ppc/linux/include/asm-i386/string.h
/home/ppc/linux/include/asm-m68k/string.h
/home/ppc/linux/include/asm-mips/string.h
/home/ppc/linux/include/asm-ppc/string.h
/home/ppc/linux/include/asm-sparc/string.h
/home/ppc/linux/include/asm-sparc64/string.h
/home/ppc/linux/include/linux/string.h


The code where the (1st) error come is:
         /* functions */

#include <string.h>
#define zmemcpy memcpy
#define zmemzero(dest, len)     memset(dest, 0, len)

and it seems absolutely normal to me.

The cross compiler was build installing egcs 1.1.2 and the glibc-2.1
over a Redhat 5.2, and then using the Matt Porter instruction (with the
exception of a newer version of binutils, because that one was not
accepted in the egcs upgrade).

If you have any idea about how to solve this I'll be happy.
Thanks to everybody
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
