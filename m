Date: Fri, 18 Jun 1999 15:10:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: nicolas.boussekeyt@afoc.alcatel.fr
cc: linux-kernel@vger.rutgers.edu, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Compilation Problem with kernel 2.2.9
In-Reply-To: <"/GUID:QPEp010Ul0xGPlQAQS7cwaA*/G=nicolas/S=boussekeyt/O=afoc/PRMD=acab/ADMD=atlas/C=fr/"@MHS>
Message-ID: <Pine.LNX.4.10.9906181510240.30522-100000@michelin.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 18 Jun 1999 nicolas.boussekeyt@afoc.alcatel.fr wrote:
> I have a problem with my PB G3.
> When I compile the kernel, I have this message:
> gcc -D__KERNEL__ -I/usr/src/linux-2_2_9/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__SMP__ -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o pmac_setup.o pmac_setup.c
> pmac_setup.c: In function `pmac_init':
> pmac_setup.c:559: `ISA_DMA_THRESHOLD' undeclared (first use this function)
> pmac_setup.c:559: (Each undeclared identifier is reported only once
> pmac_setup.c:559: for each function it appears in.)
> pmac_setup.c:560: `DMA_MODE_READ' undeclared (first use this function)
> pmac_setup.c:561: `DMA_MODE_WRITE' undeclared (first use this function)
> make[1]: *** [pmac_setup.o] Error 1  
> 
> What can i do to compile the kernel ? 

Add

    #include <asm/dma.h>

to arch/ppc/kernel/pmac_setup.c.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
