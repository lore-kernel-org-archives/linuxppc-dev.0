To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question for module compile for ppc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 May 2001 15:35:59 +0900."
             <H00002af04cc5233@MHS>
Date: Wed, 02 May 2001 09:30:07 +0200
Message-Id: <20010502073012.AA8D72814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <H00002af04cc5233@MHS> you wrote:
>
> I use HHL CDK v1.2 and use linux-2.4.3-pre3-2001-03-11(W.Denk's patched kernel).

Please note that this is 2.4.3-pre<something>, not 2.4.13 !

> [root@ssljm 8xx_io]# make -f Makefile.test
> /opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -O2 -D__KERNEL__ -DMODULE
> -DMODVERSIONS -D__powerpc__ -mcpu=860
> -I/2ndhard/linux-2.4.13-pre3-2001-03-11/include -Wall
                      ^^^^
> -Wstrict-prototypes -Wno-uninitialized -fomit-frame-pointer
> -fsigned-char -msoft-float -fno-builtin -ffixed-r2 -pipe -mmultiple
> -mstring -I/2ndhard/linux-2.4.3-pre3-2001-03-11/arch/ppc/8xx_io
> -I/2ndhard/linux-2.4.13-pre3-2001-03-11/include/linux/modversions.h
                      ^^^

>  Warning: Kernel module version mismatch
>  test.o was compiled for kernel version 2.2.14
>  while this kernel is version 2.4.3-pre3

Your compiler did not find the current kernel's header files  because
you specified a wrong directory name (...13... instead of ...3...).

>  Here is Makefile.test
>  -------------------------------------------------------
>  CFLAGS  =       -O2
>
> CC	= /opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc
>
> MODULE_CFLAGS = -D__KERNEL__ -DMODULE -DMODVERSIONS \
> 	-D__powerpc__ -mcpu=860 \
> 	-I/2ndhard/linux-2.4.13-pre3-2001-03-11/include \
                            ^^^^
************************** ERROR ***

>         -Wall -Wstrict-prototypes -Wno-uninitialized \
> 	-fomit-frame-pointer \
> 	-fsigned-char -msoft-float -fno-builtin -ffixed-r2 \
>         -pipe -mmultiple -mstring \
> 	-I/2ndhard/linux-2.4.3-pre3-2001-03-11/arch/ppc/8xx_io \
>         -I/2ndhard/linux-2.4.13-pre3-2001-03-11/include/linux/modversions.h
                              ^^^^
**************************** ERROR ***

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
f u cn rd ths, itn tyg h myxbl cd.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
