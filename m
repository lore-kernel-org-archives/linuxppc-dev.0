Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Booting Linux on a Custom PPC Board
From: Bob Beck <beck@assurtech.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <403FB112.3060101@embeddededge.com>
References: <Iq959772845498.03218@webmail1.inner-21cn.com>
	 <1077816291.4242.6.camel@budweiser>
	 <Pine.LNX.4.56.0402271730001.24044@mag.sysgo.com>
	 <1077834132.4625.2.camel@budweiser>
	 <Pine.LNX.4.56.0402271825410.24183@mag.sysgo.com>
	 <1077835127.4625.5.camel@budweiser>  <403F9B5C.7010707@embeddededge.com>
	 <1077845555.4625.15.camel@budweiser>  <403FB112.3060101@embeddededge.com>
Content-Type: text/plain
Message-Id: <1078181934.4198.20.camel@budweiser>
Mime-Version: 1.0
Date: 02 Mar 2004 12:58:54 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am booting Linux on a custom board and having many
problems.  The board contains a PPC603E, flash, an
ethernet controller, and a serial chip.

Here is what I have done so far.

o Configured the kernel to support 6xx/7xx boards
o Introduced a new defined named "CONFIG_ATCNVMS"
o Modified kernel/setup.c so that early_init() would
  skip the last 3 things it does that do not make
  sense for my board.
o Added a new embed_config() function in arch/ppc/boot/simple
  that populates a bd_t structure (from ppcboot.h)
o Added code to save registers r3-r7 at the beginning
  of start_ in simple/head.S. Restored these registers
  in relocate.S before the jump to 0.
o Updated the makefiles so that the zImage.embedded
would be created in the arch/ppc/boot/images directory.


We are writing our own boot loader code for a couple of reasons.

o U-Boot does not support our ethernet chip or serial chip.
o VxWorks is in flash and we cannot change that in the near future.
o The VxWorks boot loader initializes the hardware and
  we run our custom boot loader from its shell.


Here are the steps taken by our custom boot loader.

o Malloc a piece of memory and copy the ram disk from a file
  to the malloc'd memory.
o Malloc a piece of memory and copy the zImage.bin contents from
  a file to memory.
  powerpc-linux-objcopy -O binary zImage.embedded zImage.bin
o Prepare the registers
  r3 = ptr to bd_t
  r4 = ptr to initial ram disk bin in memory
  r5 = ptr to end of initial ram disk
  r6 = ptr to start of command line string
  r7 = ptr to end of command line string
o Jump to the start address where the zImage.bin has been loaded
  into memory.

In arch/ppc/boot/simple/head.S, I call a routine that blinks a light
(start_), but this light never blinks. I also call this routine
at __start in arch/ppc/kernel/head.S but the light never blinks.


I don't understand what to do at this point. In the past I
loaded the ram disk and vmlinux into memory and jumped to 0x10000.
Somebody on this list said that was guaranteed not to work.
However, the light did blink before the code had problems in
mmu initialization.

Regards,
Bob Beck
beck@assurtech.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
