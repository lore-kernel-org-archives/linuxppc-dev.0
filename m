Date: Thu, 21 Jan 1999 09:36:48 +0100 (MET)
From: Marc Dejardin <Marc.Dejardin@cern.ch>
Reply-To: Marc Dejardin <Marc.Dejardin@cern.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel panic with Xpmac using recent kernel 2.2.0-pre7 
Message-ID: <Pine.A41.3.95a.990121093109.145812A-100000@rsplus07.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kernel panic with Xpmac using recent kernel 2.2.0-pre7 (or all > 2.1.24).

Recently I have tryed to update my kernel to recent ones (I was using 2.1.24 
witout any problem) and I encounter problem when I use Xwindow. In general I
have a kernel panic after some seconds or minutes when I launch an application
which uses X11 (xearth, gv, netscape, ...)
The problem does not occur always at the same time. It seems linked to the fact
that recent kernels for linuxppc are optimised for XFree86 and the
compatibility with the old Xpmac is not perfect.


Linux version 2.2.0-pre7 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version
egcs-2.91.57 19980901 (egcs-1.1 release)) #1 Fri Jan 15 15:50:46 CET 1999

ONE KERNEL PANIC :

Jan 18 09:26:21 xxxxxx kernel: NIP: C00CDF9C XER: E000BE6F LR: C00347CC REGS: c2535cb0 TRAP: 0300
Jan 18 09:26:21 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan 18 09:26:21 xxxxxx kernel: TASK = c2534000[304] 'X' mm->pgd c245e000 Last syscall: 142 
Jan 18 09:26:21 xxxxxx kernel: last math c2534000
Jan 18 09:26:21 xxxxxx kernel: GPR00: C00347CC C2535DA0 C2534000 00000407 00000000 00000000 00000000 C23006C4 
Jan 18 09:26:21 xxxxxx kernel: GPR08: 00000010 C0160000 00000004 C24E5A40 95533E39 01A87568 01A80000 6C7A336E 
Jan 18 09:26:21 xxxxxx kernel: GPR16: 01A8B3AC 01A8B52C 00000000 553DBE39 533DBE39 C2F58280 C2535E18 00000001 
Jan 18 09:26:21 xxxxxx kernel: GPR24: 00002ECD C2F58000 0000000F 00000000 C015A39C C2F58000 00000407 C1E8E000 
Jan 18 09:26:21 xxxxxx kernel: Call backtrace: 
Jan 18 09:26:21 xxxxxx kernel: C2F58000 C00347CC C0034BB8 C0007A70 C0003898 01837B64 0180E1D4 
Jan 18 09:26:21 xxxxxx kernel: 01822310 01801BD4 
Jan 18 09:26:21 xxxxxx kernel: Instruction DUMP: 41820028  3d20c019  83a94558 <4bf5b87d> 7c641b78  7f85e378  7fa3eb78  4bf44fa5  38000001 
Jan 18 09:26:21 xxxxxx kernel: Kernel panic: kernel access of bad area pc c00cdf9c lr c00347cc address 453 tsk X/304
Jan 18 09:30:30 xxxxxx syslogd 1.3-3: restart.


ANOTHER KERNEL PANIC :

Jan 20 14:44:23 xxxxxx kernel: NIP: C4216000 XER: E000BE6F LR: C4216000 REGS: c156dca0 TRAP: 0700
Jan 20 14:44:23 xxxxxx kernel: MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan 20 14:44:23 xxxxxx kernel: TASK = c156c000[319] 'X' mm->pgd c156b000 Last syscall: 142 
Jan 20 14:44:23 xxxxxx kernel: last math c156c000
Jan 20 14:44:23 xxxxxx kernel: GPR00: C4216000 C156DD90 C156C000 C1E77000 C1ADBE40 00000000 00000000 C1E77970 
Jan 20 14:44:23 xxxxxx kernel: GPR08: C1E77970 00000001 00000004 C17E7840 95533E99 01AA9438 77EA0EF0 01AABA68 
Jan 20 14:44:23 xxxxxx kernel: GPR16: 01AABBE8 01AA0000 00000000 553DBE99 533DBE99 C4216280 C156DE18 00000001 
Jan 20 14:44:23 xxxxxx kernel: GPR24: 0000239A C4216000 C1ADBE40 00000002 C156DDA0 95533E99 00000010 00000000 
Jan 20 14:44:23 xxxxxx kernel: Call backtrace: 
Jan 20 14:44:23 xxxxxx kernel: C4216000 706F6C6C 
Jan 20 14:44:23 xxxxxx kernel: Instruction DUMP: 00000000  00000000  00000000 <0000fffa> 00000000  00000000  00000000  0c000200  2e2e0000 
Jan 20 14:44:23 xxxxxx kernel: Kernel panic: Exception in kernel pc c4216000 signal 4
Jan 20 14:48:45 xxxxxx syslogd 1.3-3: restart.



-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux xxxxxx.xxxxxx.xxx.fr 2.2.0-pre7 #1 Fri Jan 15 15:50:46 CET 1999 ppc
unknown
Kernel modules         found
Gnu C                  egcs-2.91.60
Binutils               2.9.1
Linux C Library        ..
Dynamic Linker (ld.so) such
Linux C++ Library      2.8.1
Procps                 1.2.7
Mount                  2.7f
Net-tools              (1997-09-21)
Kbd                    0.93
Sh-utils               1.16

processor       : 0
cpu             : 604e
clock           : 180MHz
revision        : 2.2
bogomips        : 359.63
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/86 (0%)
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
L2 cache        : 256K unified
memory          : 80MB

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST32151N         Rev: 0560
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: MATSHITA Model: CD-ROM CR-8008   Rev: 8.0e
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: XP34301          Rev: 1037
  Type:   Direct-Access                    ANSI SCSI revision: 02

     


                                 Marc Dejardin


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
