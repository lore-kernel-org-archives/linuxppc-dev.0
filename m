Message-ID: <3C99BD40.1090107@pacbell.net>
Date: Thu, 21 Mar 2002 11:00:16 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Kim young-kyun <elecguy@netian.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Q] kernel-compile error for walnut with 2.4.18 ?
References: <3C9968B3.8090307@netian.com>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim young-kyun wrote:
> Hi, all.
>
> I try to comile kernel 2.4.18 for walnut(IBM PowerPC 405GP) board on
> Red-Hat 7.1.
> I met below error message and I cannot solve this problem.
>
> powerpc-linux-gcc -D__KERNEL__
> -I/home/elecguy/work/ppclinux/linux-2.4.18/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
> -Wa,-m403 -mcpu=403 -DKBUILD_BASENAME=ppc4xx_pic -c -o ppc4xx_pic.o
> ppc4xx_pic.c
> {standard input}: Assembler messages:
> {standard input}:83: Error: unsupported relocation against DCRN_EXISR
> {standard input}:84: Error: unsupported relocation against DCRN_EXIER
> {standard input}:111: Error: unsupported relocation against DCRN_EXIER
> {standard input}:128: Error: unsupported relocation against DCRN_EXIER
> {standard input}:145: Error: unsupported relocation against DCRN_EXIER
> {standard input}:149: Error: unsupported relocation against DCRN_EXISR
> {standard input}:64: Error: unsupported relocation against DCRN_EXIER
>
> Cross-compiler is builded by following order.
>
> 1) binutils-2.12.90.0.1
> ./configure --target=powerpc-linux --with-cpu=403
> make; make install
>
> 2) gcc-core-2.95.3
> ./configure --target=powerpc-linux --enable-shared --enable-languages=c
> --with-newlib --with-cpu=403
> make; make install
>
> linux-2.4.18 with ppc-patch-2.4.18
> *in Makefile
> ARCH := ppc
> CROSS_COMPILE=powerppc-linux-
> AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS) -Wa,-m403
> *in arch/ppc/Makefile
> CFLAGS := (Original flags)... -Wa,-m403
> *in make menuconfig
> Processor Type -> 4xx
> Machine Type -> Walnut
>
> What's wrong?
>
>
>
>
>

Try a newer kernel.  DCRN_EXIER is an older implimentaion and is only
used on any 403 cpus. Your -m403 looks fishy, we are usin -m405 & -mcpu=405

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
