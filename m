Message-ID: <3CD82C4B.60606@icon-labs.com>
Date: Tue, 07 May 2002 14:34:35 -0500
From: Pete Flugstad <pete_flugstad@icon-labs.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: problem compiling linuxppc_2_4_devel for MBX
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

   I'm attempting to build a snapshot of the linuxppc_2_4_devel
for the MBX board, and I'm getting a compile error.  I've setup
the binutils and cross-compiler for powerpc-linux and that all
went without a hitch.  I grabbed a snapshot of the PPC tree using
BK:

   bk clone bk://ppc.bkserver.net/linuxppc_2_4_devel linuxppc_2_4_devel

Then I did a "bk -r co" to get all the files in place (that step
should be documented somewhere - maybe on the "getting the kernel
page": http://penguinppc.org/dev/kernel.shtml ).

I did (is the "mbx_config" step documented anywhere?):

   make mbx_config
   make oldconfig
   make menuconfig -- update to taste/needs
   make dep
   make clean
   make zImage

The make zImage fails:

> make[1]: Entering directory `/home/pete/powerpc-linux/linuxppc_2_4_devel/arch/ppc/kernel'
> powerpc-linux-gcc -D__KERNEL__ -I/home/pete/powerpc-linux/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/pete/powerpc-linux/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -I /usr/local/lib/gcc-lib/powerpc-linux/2.95.3/include -DKBUILD_BASENAME=m8xx_setup  -c -o m8xx_setup.o m8xx_setup.c
> m8xx_setup.c: In function `m8xx_init_IRQ':
> m8xx_setup.c:285: structure has no member named `irq_offset'
> m8xx_setup.c:286: too few arguments to function `i8259_init'
> m8xx_setup.c: In function `platform_init':
> m8xx_setup.c:361: warning: implicit declaration of function `m8xx_setup_pci_ptrs'
> make[1]: *** [m8xx_setup.o] Error 1
> make[1]: Leaving directory `/home/pete/powerpc-linux/linuxppc_2_4_devel/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2

Looks like something changed drastically in the generic kernel
sources somewhere? The i8259_pic structure doesn't have anything
even resembling an "irq_offset" member.

Would I be better off dropping back to linuxppc_2_4 (stable), or is
that going to fail on me as well?

Thanks,
Pete Flugstad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
