Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <005301c2fa43$73a1c690$1464a8c0@sjeng3>
From: "El Topo" <ElTopo@myrealbox.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20030403072726.78B9EC587C@atlas.denx.de>
Subject: Re: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2? 
Date: Thu, 3 Apr 2003 16:45:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The 2.4.4 LInux kernel as included in this version of the ELDK is not
> suitable for 4xx systems. Please use  the  linuxppc_2_4_devel  kernel
> tree instead; see http://penguinppc.org/dev/kernel.shtml
>
>
> Wolfgang Denk

Thanks Wolfgang.

I've got the linuxppc_2_4_devel tree, made config for 440/Ebony,
then when I compiled the kernel, I got this problem:

================= output of "make vmlinux" ====================
ppc_4xx-gcc -D__KERNEL__ -I/home/lxl/linuxppc_2_4_devel/include -Wall -Wstri
ct-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-fra
me-pointer -I/home/lxl/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-floa
t -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405   -nostd
inc -iwithprefix
include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o
sched.c
In file included from /home/lxl/linuxppc_2_4_devel/include/linux/wait.h:13,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/fs.h:12,
                 from
/home/lxl/linuxppc_2_4_devel/include/linux/capability.h:17,
                 from
/home/lxl/linuxppc_2_4_devel/include/linux/binfmts.h:5,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/sched.h:9,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/mm.h:4,
                 from sched.c:23:
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No such
file or directory
In file included from /home/lxl/linuxppc_2_4_devel/include/linux/wait.h:13,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/fs.h:12,
                 from
/home/lxl/linuxppc_2_4_devel/include/linux/capability.h:17,
                 from
/home/lxl/linuxppc_2_4_devel/include/linux/binfmts.h:5,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/sched.h:9,
                 from /home/lxl/linuxppc_2_4_devel/include/linux/mm.h:4,
                 from sched.c:23:
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:74: parse error before
`va_list'
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:74: warning: function
declaration isn't a prototype
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:77: parse error before
`va_list'
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:77: warning: function
declaration isn't a prototype
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:81: parse error before
`va_list'
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:81: warning: function
declaration isn't a prototype
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/home/lxl/linuxppc_2_4_devel/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/lxl/linuxppc_2_4_devel/kernel'
make: *** [_dir_kernel] Error 2
===============end of output of "make vmlinux" ====================

This is indeed weird, how could ppc_4xx-gcc not find "stdarg.h"? the same
version
still works for the stable linuxppc-2.4.4, and I saw
/home/lxl/linuxppc_2_4_devel/include/linux/kernel.h
also has #include <stdarg.h> but ppc_4xx-gcc has no problem finding
stdarg.h.
I doubt checked and made sure I have stdarg.h at
$(eldk_root)/ppc_4xx/usr/lib/gcc-lib/ppc-linux/2.95.4/include/stdarg.h

Anybody has this problem? or has any idea how I can make it work?

Thanks,

El


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
