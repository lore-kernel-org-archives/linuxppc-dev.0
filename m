Message-Id: <4.3.2.7.2.20001003103030.00afc690@falcon.si.com>
Date: Tue, 03 Oct 2000 10:37:38 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: different memory map
In-Reply-To: <39D9E451.9A4E20D4@siemens.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your IMMR location will be a problem.  It must be above 0x8000000 (and I
believe above the kernel) or you will be making major mods to your kernel
(and that will be a _never ending_ task!).  Why are you setting your IMMR
to 0x10700000?  Note that you can change the IMMR in software just before
starting the kernel (assuming that you know where the IMMR is to start with
:-).

Search the archives http://lists.linuxppc.org/ for memory map information
and limitations.  Some notes from the archives...

           Details from Dan Malek <dan_malek@mvista.com> on 10/29/1999:

           The user application virtual space consumes the first 2 Gbytes
           (0x00000000 to 0x7FFFFFFF).  The kernel virtual text starts at
           0xC0000000, with data following.  There is a "protection hole"
           between the end of kernel data and the start of the kernel
           dynamically allocated space, but this space is still within
           0xCxxxxxxx.

           Obviously the kernel can't map any physical addresses 1:1 in
           these ranges.


           Details from Dan Malek <dan_malek@mvista.com> on 5/19/2000:

           During the early kernel initialization, the kernel virtual
           memory allocator is not operational.  Prior to this KVM
           initialization, we choose to map virtual to physical addresses
           1:1.  That is, the kernel virtual address exactly matches the
           physical address on the bus.  These mappings are typically done
           in arch/ppc/kernel/head.S, or arch/ppc/mm/init.c.  Only
           absolutely necessary mappings should be done at this time, for
           example board control registers or a serial uart.  Normal device
           driver initialization should map resources later when necessary.

           Although platform dependent, and certainly the case for embedded
           8xx, traditionally memory is mapped at physical address zero,
           and I/O devices above physical address 0x80000000.  The lowest
           and highest (above 0xf0000000) I/O addresses are traditionally
           used for devices or registers we need to map during kernel
           initialization and prior to KVM operation.  For this reason,
           and since it followed prior PowerPC platform examples, I chose
           to map the embedded 8xx kernel to the 0xc0000000 virtual address.
           This way, we can enable the MMU to map the kernel for proper
           operation, and still map a few windows before the KVM is
operational.

           On some systems, you could possibly run the kernel at the
           0x80000000 or any other virtual address.  It just depends upon
           mapping that must be done prior to KVM operational.  You can never
           map devices or kernel spaces that overlap with the user virtual
           space.  This is why default IMMR mapping used by most BDM tools
           won't work.  They put the IMMR at something like 0x10000000 or
           0x02000000 for example.  You simply can't map these addresses early
           in the kernel, and continue proper system operation.

           The embedded 8xx/82xx kernel is mature enough that all you should
           need to do is map the IMMR someplace at or above 0xf0000000 and it
           should boot far enough to get serial console messages and KGDB
           connected on any platform.  There are lots of other subtle memory
           management design features that you simply don't need to worry
           about.  If you are changing functions related to MMU initialization,
           you are likely breaking things that are known to work and are
           heading down a path of disaster and frustration.  Your changes
           should be to make the flexibility of the processor fit Linux,
           not force arbitrary and non-workable memory mappings into Linux.

         - You don't want to change KERNELLOAD or KERNELBASE, otherwise the
           virtual memory and MMU code will get confused.

           arch/ppc/Makefile:KERNELLOAD = 0xc0000000

           include/asm-ppc/page.h:#define PAGE_OFFSET    0xc0000000
           include/asm-ppc/page.h:#define KERNELBASE     PAGE_OFFSET

         - RAM is at physical address 0x00000000, and gets mapped to
           virtual address 0xC0000000 for the kernel.


         Physical addresses used by the Linux kernel:
         --------------------------------------------

         0x00000000-0x3FFFFFFF   1GB reserved for RAM
         0xF0000000-0xF001FFFF   128K IMMR  64K used for dual port memory,
                                  64K for 8260 registers


         Logical addresses used by the Linux kernel:
         -------------------------------------------

         0xF0000000-0xFFFFFFFF   256M BAT0 (IMMR: dual port RAM, registers)
         0xE0000000-0xEFFFFFFF   256M BAT1 (I/O space for custom boards)
         0xC0000000-0xCFFFFFFF   256M BAT2 (RAM)
         0xD0000000-0xDFFFFFFF   256M BAT3 (if RAM > 256MByte)


At 03:51 PM 10/3/00 +0200, Rainer Kloud wrote:

>Dear All,
>
>for porting the 2.4.0-test4 kernel to my Scout Board I
>used as base the EST8260 configuration.
>This two boards are very similar, but they have a different
>Memory Map.
>The EST board has the IMMR Registers at 0xf0000000, my
>Board has them at 0x10700000.
>
>Therefore I'd like to know which changes are necessary to
>get the Board running.
>All what I have done up to now is that I have changed the
>define for IMAP_ADDR and in MMU_init I setup the bat with
>index 0 from 0x10000000 (instead of 0xf0000000).
>
>With this two changes the kernel can boot correctly
>until it tries to execute the init process.
>When loading the init process via load_elf_binary
>the kernel gets a machine check execption in function
>clear_user (beqlr) which was called from padzero (first time
>that we are in user space?).
>The parameters for the function are: address: 0x10010528
>len: 0xad8
>This address resides in the BAT which I have used for my
>IMMR registers.
>
>Is there any coherence between the machine check exceptions
>and my changes for the different memory map?
>
>Any suggestions to fix my problem?
>
>Thank you in advance!
>
>Bye
>Rainer
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
