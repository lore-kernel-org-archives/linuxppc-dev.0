Date: Sat, 8 May 2004 20:31:07 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: moving on -- build error in linuxppc-2.5 source
Message-ID: <Pine.LNX.4.58.0405081941280.2975@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  following previous advice, i BK-checked out the kernel source tree from
http://ppc.bkbits.net:8080/linuxppc-2.5 in order to configure and build a
basic kernel for my MPC850 board.  the results thus far -- after the
initial configure:
===========================================================
...
  ppc_8xx-gcc -Wp,-MD,arch/ppc/kernel/.ppc_ksyms.o.d -nostdinc
-iwithprefix include -D__KERNEL__ -Iinclude  -Iarch/ppc -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -O2 -fomit-frame-pointer     -DKBUILD_BASENAME=ppc_ksyms
-DKBUILD_MODNAME=ppc_ksyms -c -o arch/ppc/kernel/ppc_ksyms.o
arch/ppc/kernel/ppc_ksyms.c
arch/ppc/kernel/ppc_ksyms.c:344: `request_8xxirq' undeclared here (not in
a function)
arch/ppc/kernel/ppc_ksyms.c:344: initializer element is not constant
arch/ppc/kernel/ppc_ksyms.c:344: (near initialization for
`__ksymtab_request_8xxirq.value')
make[2]: *** [arch/ppc/kernel/ppc_ksyms.o] Error 1
make[1]: *** [arch/ppc/kernel] Error 2
make[1]: Leaving directory
`/home/rpjday/rdm/projects/2.5/TONTO/OS/linuxppc-2.5'
make: *** [build] Error 2
 ...
===========================================================

  been here before, the offending code in arch/ppc/kernel/ppc_ksyms.c is:

#if defined(CONFIG_8xx)
EXPORT_SYMBOL(request_8xxirq);
#endif

  since request_8xxirq appears to be undefined, i can just comment out
those three lines and move on, but it would be nice to know if i've
misconfigured something.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
