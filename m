Message-ID: <38516AA1.9CE83D69@ccrl.mot.com>
Date: Fri, 10 Dec 1999 15:03:29 -0600
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.2.13 kernel and BSE board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
this seems like something that should be trivial, so have patience with
me,
as I'm pretty new to embedded linux and just trying to get myself
familiar with
it...

I've pulled down mpc8xx-2.2.13.tgz and compiled it for the BSE
ip-Engine with only one slight modification in embed_config.c - I
changed
#include <sys/types.h>  to #include "linux/types.h" It wouldn't compile
otherwise - I imagine it wouldn't have been a problem if I was compiling

on a native PowerPC, but I compiled it on x86 linux (RH 6.0) using
binutils-2.9.1.0.19a and gcc-core-2.95.2

I tried to boot it with initrd on the ip-Engine as the embedded_notes
describes i.e. using ip-engine's firmware: bload zvmlinux.initrd 200000
(I get the same using zvmlinux or zvmlinux.initrd)

here's what I get:

Boot: BSE 1998 Jan 31 1999
>bload zvmlinux.initrd 200000
loading ...  done
>go 210000
loaded at:     00210000 0021B1F0
relocated to:  00100000 0010B1F0
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     00216000 002735EA
initrd at:     002735EA 0044A427
avail ram:     0044B000
01000000
Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (srossi@columbia) (gcc version 2.95.2 19991024
(release)) #30 Fri Dec 10 10:54:49 CST 1999
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.72 BogoMIPS
Memory: 13332k available (688k kernel code, 440k data, 36k init)
[c0000000,c1000000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
NIP: C000CCAC XER: 20000242 LR: C009E9AC REGS: c00c29d0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00c0c90[0] 'swapper' mm->pgd c00bf000 Last syscall: 0
last math 00000000
GPR00: C009E9AC C00C2A80 C00C0C90 002E7379 00000001 0000002A 00000054
FFFFFFFF
GPR08: FFFFFFFF 00000005 00000015 00000001 00000040 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 001001C4 00210000
C00E0000
GPR24: 00000000 00000004 C00CE6C4 00000004 00000001 C00D9154 6D746162
C00C2A80
Call backtrace:
00000000 C009E9AC C009EB80 C00D30D4 C00D0724 C000221C
Kernel panic: kernel access of bad area pc c000ccac lr c009e9ac address
2E7379 tsk swapper/0
In swapper task - not syncing
Rebooting in 180 seconds..

I've poked around it for a while, but I can't seem to find what is going
on.
I'm assuming the value of pc - c000ccac is a virtual address? Is the mmu

not mapping correctly to physical addresses? Am I missing something
completely obvious?

Thanks,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Research Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
