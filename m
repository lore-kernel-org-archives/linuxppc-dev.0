Message-ID: <367CBE74.A3DDAF22@talknet.de>
Date: Sun, 20 Dec 1998 09:08:04 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Matt Porter <mmporter@home.com>, Loic Prylli <Loic.Prylli@ens-lyon.fr>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        VALETTE Eric <valette@crf.canon.fr>,
        Cort Dougan <cort@ladron.cs.nmt.edu>, minyard@acm.org,
        baccala@freesoft.org, Peter De Schrijver <p2@medelec.uia.ac.be>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: preploader (re:Linux-2.1.129 boot on MCP750)
References: <SIMEON.9812171602.B@g-mun-af.muenchen.europe.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have successfully booted the following systems using the preploader 
and a selfcompiled 2.1.130 kernel:
   RiscPC 603 66MHz
   RiscPC 604 133MHz
   RiscPC Plus 604 133MHz
All onboard PCI devices are detected and configured.


> 
> Subject: Re: preploader (re:Linux-2.1.129 boot on MCP750)
> Date: Tue, 15 Dec 1998 13:42:18 -0700 (MST)
> From: Matt Porter <mmporter@home.com>
> To: Gabriel Paubert <paubert@iram.es>
> CC: Loic Prylli <Loic.Prylli@ens-lyon.fr>, linuxppc-dev@lists.linuxppc.org,
>      "Eugene V. Ananishnov" <eugene-a@fort.tatarstan.ru>,
>      VALETTE Eric <valette@crf.canon.fr>,
>      Cort Dougan <cort@ladron.cs.nmt.edu>, minyard@acm.org,
>      baccala@freesoft.org,
>      Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>,
>      Peter De Schrijver <p2@medelec.uia.ac.be>,
>      Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> 
> On Tue, 15 Dec 1998, Gabriel Paubert wrote:
> 
> > usual site:
> >
> >       ftp://vcorr1.iram.es/pub/preploader.tgz
> >
> > ands the corresponding 2.1.130 zImage with builtin de4x5 and ncr53c8xx
> > drivers (ext2 and nfs filesystems but no root on NFS). This kernel also
> > includes support for OpenPIC on Raven machines.
> >
> > I would like to have as many reports as possible, both from failures and
> > successes.
> 
> Ok, here is my success report:
> 
> Tested on MVME230x,2300SC,2400,260x,2700, and 3600 as well as MTX.
> Everything appears to be detected properly as with my hacked version of
> the arch/ppc/boot/ code. I didn't bother trying to root to something since
> that should work as before.
> 
> I'm including two patches which provide for some general cleanup, cross
> compilation support, and inclusion into the arch/ppc/ tree.  The first
> patch to arch/ppc/Makefile enables building in the arch/ppc/prepboot
> directory.  The second patch is to be applied to the current
> preploader.tgz and then the resultant directory should be placed in
> arch/ppc/ and name 'prepboot'.  Doing the usual build routine will then
> also build a zImage with the alternative prep loader.
> 
> This should not break anything to put the alternative prep loader into CVS
> so if Cort is happy with this then I can provide one diff versus current
> CVS to make inclusion easy.
> 
> Oh, and I've made a local copy of preploader.tgz available at
> http://members.home.net/mmporter/linux.html for anyone else in the
> states that might have the same kind of bandwidth problems I had going to
> Gabriel's ftp server (took me 30+ minutes to get the 90k file).
> 
> ...patches follow...
> 
> --- linux.orig/arch/ppc/Makefile        Tue Dec 15 11:02:20 1998
> +++ linux/arch/ppc/Makefile     Tue Dec 15 11:08:09 1998
> @@ -45,6 +45,7 @@
>  MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
>  MAKECOFFBOOT = $(MAKE) -C arch/$(ARCH)/coffboot
>  MAKECHRPBOOT = $(MAKE) -C arch/$(ARCH)/chrpboot
> +MAKEPREPBOOT = $(MAKE) -C arch/$(ARCH)/prepboot
> 
>  ifdef CONFIG_8xx
>  SUBDIRS += arch/ppc/8xx_io
> @@ -67,6 +68,7 @@
>         @$(MAKECOFFBOOT) $@
>         @$(MAKEBOOT) $@
>         @$(MAKECHRPBOOT) $@
> +       @$(MAKEPREPBOOT) $@
> 
>  pmac_config:
>         rm -f .config arch/ppc/defconfig
> @@ -100,6 +102,7 @@
>         @$(MAKECOFFBOOT) clean
>         @$(MAKEBOOT) clean
>         @$(MAKECHRPBOOT) clean
> +       @$(MAKEPREPBOOT) clean
> 
>  archmrproper:
> 
> ....preploader patch....
> 
> diff -urN preploader/Makefile prepboot/Makefile
> --- preploader/Makefile Mon Dec 14 09:06:15 1998
> +++ prepboot/Makefile   Tue Dec 15 12:56:10 1998
> @@ -1,5 +1,5 @@
>  #
> -# arch/ppc/boot/Makefile
> +# arch/ppc/prepboot/Makefile
>  #
>  # This file is subject to the terms and conditions of the GNU General Public
>  # License.  See the file "COPYING" in the main directory of this archive
> @@ -10,12 +10,10 @@
>  # modified by Cort (cort@cs.nmt.edu)
>  # revised for PreP boot by Gabriel Paubert (paubert@iram.es)
> 
> -
>  # I tried to use r2 for the basic structure but it seems to be incompatible
>  # with the -m relocatable option.
> -INCPATH                = /usr/src/linux/arch/ppc/boot
> +
>  ASFLAGS                = -mrelocatable
> -CFLAGSINC      = -D__KERNEL__ -I/usr/src/linux/include -D__powerpc__
>  CFLAGS         := $(CFLAGS) -D__powerpc__ -msoft-float -pipe \
>                 -fno-builtin -Wall -mmultiple -mstring -I$(INCPATH)\
>                 -D__KERNEL__ -O2 -fomit-frame-pointer \
> @@ -60,20 +58,23 @@
>  #OBJECTS += vreset.o kbd.o
> 
>  zImage: $(OBJECTS) $(IMAGES) $(SIZES) ppcboot.lds
> -       ld -o zImage $(OBJECTS) -b binary $(IMAGES) -T ppcboot.lds \
> -       --defsym _vmlinux_size=`cut -f 1 <.vmlinux.size` -Map zImage.map
> +       $(CROSS_COMPILE)ld -o zImage $(OBJECTS) -b binary $(IMAGES) \
> +       -T ppcboot.lds --defsym _vmlinux_size=`cut -f 1 <.vmlinux.size` \
> +       -Map zImage.map
> 
>  # The 2 objcopy are quite ugly, but for now it was the simplest solution
>  # since the flags to expand the bss do not work on a binary output format.
>  # It would be better to know where the bss is and clear it in the bootloader,
>  # but the resulting vmlinux.gz expansion is  257 bytes, so it's not so bad.
> -vmlinux.gz .vmlinux.size: /usr/src/linux/vmlinux
> -       objcopy /usr/src/linux/vmlinux -S vmlinux -R .comment \
> -               --set-section-flags=.bss=alloc,load,data
> -       objcopy vmlinux vmlinux -O binary
> +vmlinux.gz .vmlinux.size: /usr/local/src/ppc/linux/vmlinux
> +       $(CROSS_COMPILE)objcopy /usr/local/src/ppc/linux/vmlinux -S vmlinux \
> +       -R .comment --set-section-flags=.bss=alloc,load,data
> +       $(CROSS_COMPILE)objcopy vmlinux vmlinux -O binary
>         du --bytes vmlinux >.vmlinux.size
>         gzip -vf9 vmlinux
> 
>  .depend dep:
>         $(CPP) -M *.S *.c -I$(INCPATH) > .depend
> 
> +clean:
> +       rm -f *.o vmlinux* zImage*
> diff -urN preploader/zlib.c prepboot/zlib.c
> --- preploader/zlib.c   Tue Sep  1 04:49:30 1998
> +++ prepboot/zlib.c     Tue Dec 15 12:56:10 1998
> @@ -80,7 +80,7 @@
> 
>           /* functions */
> 
> -#include <string.h>
> +#include <linux/string.h>
>  #define zmemcpy memcpy
>  #define zmemzero(dest, len)    memset(dest, 0, len)
> 
> --
> Matt Porter
> mmporter@home.com
> Unix is a Linux-like operating system.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
