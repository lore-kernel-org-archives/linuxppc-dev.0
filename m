Date: Wed, 21 Apr 1999 18:30:56 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME2306 : kernel 2.2.6 SUCCESS !
In-Reply-To: <371DE90F.6303BC2B@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990421181843.20020c-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 21 Apr 1999, Simone Piccardi wrote:

> Hi,
> I just finished to try this procedure (with some more step added) to
> cross-compile the kernel on my PC, but it does not work.
> I did all the step up to the distclean, then I modify the Makefile
> (according to Matt Porter instructions), I copied the
> mvme2600.config.nfsroot as .config and did make oldconfig.
> Everything up to here went fine, without any error or warning.
> Then I did make dep and make clean (always using the Matt Porter
> instruction) and the make zImage, at the end the error was this:
> 
> powerpc-linux-gcc -D__KERNEL__ -I/home/ppc/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char
> -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
> -mstring -mcpu=603e -D__powerpc__ -msoft-float -pipe -fno-builtin -Wall
> -mmultiple -mstring -I../boot -I/home/ppc/linux -D__KERNEL__ -O2
> -fomit-frame-pointer -mrelocatable -ffixed-r13 -D__BOOT__ -DDEBUG  -c -o
> zlib.o zlib.c
> zlib.c:83: string.h: No such file or directory
> zlib.c: In function `inflate_blocks':
> zlib.c:878: warning: implicit declaration of function `memcpy'
> make[1]: *** [zlib.o] Error 1
> make[1]: Leaving directory `/home/ppc/linux/arch/ppc/prepboot'
> make: *** [zImage] Error 2
> 
> I'm a little bit worried about the -mcpu=603e switch but I don't think
> this can be relate to the error. 


No, it does not. It is just an optimization because I happen to have 603e
and the default scheduling is bad on it (it tends to expand multiplies to
series of shift and add since it believes that multiplication is much more
expensive than it actually is on most PPC processors). Scheduling on 750
is probably different but this should not have any major adverse
effects.  

However this problem is obviously my fault, I did not track some changes
:-( You should include linux/string.h instead of string.h.


	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
