Date: Sat, 8 May 2004 08:27:23 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: 2.6.5 kernel build: 'macro "mfmsr" passed 1 arguments, but takes
 just 0'
Message-ID: <Pine.LNX.4.58.0405080817270.10599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  as did someone else on this list recently, i did a first attempt at
compiling the stock 2.6.5 kernel for an MPC8xx board.  from a verbose
build:
====================================================================
...
ppc_8xx-gcc -Wp,-MD,arch/ppc/syslib/.m8xx_setup.o.d -nostdinc -iwithprefix
include -D__KERNEL__ -Iinclude  -Iarch/ppc -D__KERNEL__ -Iinclude
-Iarch/ppc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -O2 -fomit-frame-pointer
-DKBUILD_BASENAME=m8xx_setup -DKBUILD_MODNAME=m8xx_setup -c -o
arch/ppc/syslib/m8xx_setup.o arch/ppc/syslib/m8xx_setup.c
arch/ppc/syslib/m8xx_setup.c:224:35: macro "mfmsr" passed 1 arguments, but
takes just 0
arch/ppc/syslib/m8xx_setup.c: In function `m8xx_restart':
arch/ppc/syslib/m8xx_setup.c:224: `mfmsr' undeclared (first use in this
function)
arch/ppc/syslib/m8xx_setup.c:224: (Each undeclared identifier is reported
only once
arch/ppc/syslib/m8xx_setup.c:224: for each function it appears in.)
arch/ppc/syslib/m8xx_setup.c:217: warning: unused variable `msr'
make[2]: *** [arch/ppc/syslib/m8xx_setup.o] Error 1
make[1]: *** [arch/ppc/syslib] Error 2
make[1]: Leaving directory
`/home/rpjday/rdm/projects/2.6/TONTO/OS/linux-2.6.5'
make: *** [build] Error 2
===================================================================

  the offending code in arch/ppc/syslib/m8xx_setup.c:

...
static void
m8xx_restart(char *cmd)
{
        __volatile__ unsigned char dummy;
        uint    msr;

        cli();
        ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;

        /* Clear the ME bit in MSR to cause checkstop on machine check
        */
        mtmsr(mfmsr(msr) & ~0x1000);      <--- that's the one
	...

poking around a bit more, i find in include/asm-ppc/reg.h (line 497):

/* Macros for setting and retrieving special purpose registers */
#ifndef __ASSEMBLY__
#define mfmsr()         ({unsigned int rval; \
                        asm volatile("mfmsr %0" : "=r" (rval)); rval;})
#define mtmsr(v)        asm volatile("mtmsr %0" : : "r" (v))


  i'm no expert at assembly, but it sure looks like mfmsr() is defined
to take no arguments, which obviously disagrees with its usage in the
m8xx_setup.c file.

  thoughts on this?

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
