Message-Id: <200109061503.LAA11727@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME5100 and bugboot fails
Date: Thu, 6 Sep 2001 10:55:46 -0400
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am playing with the MVME5100 and I am having a bit of trouble with booting
using bugboot and an initrd. I get a message at bootup saying initrd > 16 MB
and then as it is booting it gets an oops in mem_init.

It appears that the oops happens when ClearPageReserved() is called. Here is
a snippet of the code from arch/ppc/mm/init.d mem_init()
#ifdef CONFIG_BLK_DEV_INITRD
        /* if we are booted from BootX with an initial ramdisk,
           make sure the ramdisk pages aren't reserved. */
        if (initrd_start) {
                for (addr = initrd_start; addr < initrd_end; addr +=
PAGE_SIZE)
                        ClearPageReserved(virt_to_page(addr));
        }
#endif /* CONFIG_BLK_DEV_INITRD */

My question is is the failure due to the bootloader not relocating the initrd
or is it that ClearPageReserved() is being called when the initrd is in
FLASH? Any ideas?


Here is my boot output:

ROMBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue
loaded at:     F4000014 F400A1D0
relocated to:  00800000 0080A1BC
zimage at:     F4007014 F40AA2B3
initrd at:     F40AA2B3 F423083D
avail ram:     00400000 00800000

Linux/PPC load: ip=on root=/dev/ram0
initrd_start located > 16M
Uncompressing Linux...done.
Now booting the kernel
mem_pieces_remove: [f40aa2b3,f423083d) not in any region
Total memory = 64MB; using 256kB for hash table (at c01c0000)
Linux version 2.4.9 (bwaite@chicory.cspi.com) (gcc version 2.95.3 20010111
(prerelease/franzo/20010111)) #29 Thu Sep 6 09:54:58 EDT 2001
MVME5100 port (C) 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=on root=/dev/ram0
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at f3f80000
OpenPIC timer frequency is 4.166602 MHz
time_init: decrementer frequency = 25.000680 MHz
Calibrating delay loop... 799.53 BogoMIPS
Oops: kernel access of bad area, sig: 11
NIP: C017DC18 XER: 00000000 LR: C017DBBC SP: C0168430 REGS: c0168380 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C42DCE5C, DSISR: 40000000
TASK = c0166490[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: 000F40AA C0168430 C0166490 00003CE6 00001032 00209000 C0190000 C0190000
GPR08: 80000000 C42DCE5C B40AA2B3 C020A11C 20000029 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 00000000 40000000 00807040 0080702C 00000000 00000000 00000000
Call backtrace:
C017DBBC C017B71C 00003B9C
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
--
Thanks

Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
