Date: Mon, 17 Sep 2001 14:25:47 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: walnut configuration
In-Reply-To: <200109172115.f8HLFCc20783@hyper.wm.sps.mot.com>
Message-ID: <Pine.LNX.4.30.0109171423430.3695-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I compiled the linuxppc_2_4_devel tree last week (2.4.10-pre8, I believe)
for our 405GP without incident. However, I didn't do the 'make mrproper',
'make oldconfig', and I did 'make zImage.initrd' instead of just 'make'.

John

On Mon, 17 Sep 2001, Peter Barada wrote:

>
> Has *anyone* gotten the linuxppc_2_4_devel tree to build for a walnut board?
> If so, what did you have to do... I've tried the following:
>
> I've gotten a BK resync of the linuxppc_2_4_devel tree as of today and
> attempted to:
>
> 1) edit top level makefile to redefine ARCH to ppc, set CROSS_COMPILE
>    to my tool prefix
> 2) make mkproper
> 3) make walnut_config
> 4) make oldconfig
> 5) make dep
> 6) make
>
> This fails while trying to build head_4xx.S since
> CONFIG_PPC601_SYCN_FIX is set in .config when it shouldn't be.
>
>
> After getting past that, it fails next while trying to compile
> ppc4xx_pic.c with:
>
> powerpc-linux-gcc -D__KERNEL__ -I/home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403    -c -o ppc4xx_pic.o ppc4xx_pic.c
> {standard input}: Assembler messages:
> {standard input}:83: Error: unsupported relocation type
> {standard input}:84: Error: unsupported relocation type
> {standard input}:111: Error: unsupported relocation type
> {standard input}:128: Error: unsupported relocation type
> {standard input}:145: Error: unsupported relocation type
> {standard input}:149: Error: unsupported relocation type
> {standard input}:64: Error: unsupported relocation type
> make[1]: *** [ppc4xx_pic.o] Error 1
> make[1]: Leaving directory `/home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/arch/ppc/kernel'
>
> This is caused by in include/asm-ppc/processor.h, the following needs
> to be change from:
>
> #include <asm/mpc8xx.h>
>
> to:
>
> #ifdef CONFIG_4xx
> #include <asm/ppc4xx.h>
> #endif
> #ifdef CONFIG_8xx
> #include <asm/mpc8xx.h>
> #endif
>
>
> Now it gets past ppc4xx_pic.c, and now blows up compilling walnut_setup.c
> with:
>
> powerpc-linux-gcc -D__KERNEL__ -I/home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403    -c -o walnut_setup.o walnut_setup.c
> In file included from walnut_setup.c:22:
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h: In function `tasklet_disable_nosync':
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h:174: warning: implicit declaration of function `smp_mb'
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h: At top level:
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h:224: parse error before `global_bh_lock'
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h:224: warning: type defaults to `int' in declaration of `global_bh_lock'
> /home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/include/linux/interrupt.h:224: warning: data definition has no type or storage class
> walnut_setup.c: In function `walnut_init':
> walnut_setup.c:115: warning: assignment from incompatible pointer type
> walnut_setup.c: In function `walnut_setup_residual':
> walnut_setup.c:170: structure has no member named `bi_intfreq'
> walnut_setup.c:171: structure has no member named `bi_busfreq'
> walnut_setup.c: At top level:
> walnut_setup.c:234: conflicting types for `walnut_time_init'
> walnut_setup.h:43: previous declaration of `walnut_time_init'
> walnut_setup.c: In function `walnut_calibrate_decr':
> walnut_setup.c:286: structure has no member named `bi_intfreq'
> walnut_setup.c:288: `decrementer_count' undeclared (first use in this function)
> walnut_setup.c:288: (Each undeclared identifier is reported only once
> walnut_setup.c:288: for each function it appears in.)
> walnut_setup.c:289: `count_period_num' undeclared (first use in this function)
> walnut_setup.c:290: `count_period_den' undeclared (first use in this function)
> make[1]: *** [walnut_setup.o] Error 1
> make[1]: Leaving directory `/home/pbarada/work/penguinppc/linuxppc_2_4_devel.export.3/arch/ppc/kernel'
>
> At this point I thought I'd ask.
>
>
> --
> Peter Barada                                   Peter.Barada@motorola.com
> Wizard                                         781-852-2768 (direct)
> WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)
>
>

--
John Tyner
jtyner@cs.ucr.edu
Alumnus, Computer Science
University of California, Riverside
http://www.cs.ucr.edu/~jtyner/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
