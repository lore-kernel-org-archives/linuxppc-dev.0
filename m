Return-Path: <donaldrussell@lucent.com>
Received: from ihemail1.lucent.com (ihemail1.lucent.com [192.11.222.161])
	by ozlabs.org (Postfix) with ESMTP id 0A72667A7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 07:16:20 +1100 (EST)
Received: from mvcde.inse.lucent.com (h152-148-8-206.lucent.com
	[152.148.8.206])
	by ihemail1.lucent.com (8.12.11/8.12.11) with ESMTP id j2NJhE6a017893
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 13:43:15 -0600 (CST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <041201c52fe0$e472b670$0101010a@yy232>
From: "Don Russell" <donaldrussell@lucent.com>
Date: Wed, 23 Mar 2005 14:45:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Update: Booting Linux on a Custom PPC Board
Reply-To: Don Russell <donaldrussell@lucent.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To:  Bob Beck

Did you ever resolve the Linux on PPC boot problem?
Im attempting a similar thing.

Thanks
Don Russell
Lucent Technologies

-----Original Message-----
Ok. Now its making it to start_ in boot/simple/head.S.

It jumps to relocate in relocate.S after doing some 6xx
specific code. In util.S, it enters but never finishes
the flush_data_cache. ????????

Bob



-----Forwarded Message-----

From: Bob Beck <beck at assurtech.com>
To: linuxppc-embedded at lists.linuxppc.org
Subject: Booting Linux on a Custom PPC Board
Date: 02 Mar 2004 12:58:54 +1400


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
beck at assurtech.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
