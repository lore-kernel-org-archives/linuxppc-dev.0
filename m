Date: Fri, 19 Mar 1999 10:01:07 +0100 (MET)
From: Marc Dejardin <Marc.Dejardin@cern.ch>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-user@lists.linuxppc.org
Subject: Kernel panic with telnet using 2.2.2 and f771 with 2.2.3
Message-ID: <Pine.A41.3.95a.990319095602.150872B-100000@rsplus06.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have got kernel panics in telnet and f771 (according to log/messages) ...
I don't know if it could be usefull to anybody ?
I don't know really what to do with this.
But if one of the goal of linux is to be the most stable OS, perhaps it could be
interreting to understand why it happens.

Thanks for your help.

            Marc Déjardin

First kernel panic :

Linux version 2.2.2 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version egcs-2.91.57
19980901 (egcs-1.1 release)) #1 Fri Mar 5 10:45:47 CET 
1999

Mar 18 18:00:36 xxxxxx kernel: NIP: C00CDFDC XER: 20000000 LR: C002966C REGS: c1cfbd20 TRAP: 0300
Mar 18 18:00:36 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Mar 18 18:00:36 xxxxxx kernel: TASK = c1cfa000[2269] 'telnet' mm->pgd c3fdf000 Last syscall: 4 
Mar 18 18:00:36 xxxxxx kernel: last math c1dde000
Mar 18 18:00:36 xxxxxx kernel: GPR00: 00000000 C1CFBE10 C1CFA000 00000304 01858A96 00000026 C19BF258 00000000 
Mar 18 18:00:36 xxxxxx kernel: GPR08: 00000000 00000000 00000000 C4527460 3004E400 0185B750 018A3D78 018A3430 
Mar 18 18:00:36 xxxxxx kernel: GPR16: 7FFFF3F0 00000000 00000000 00000000 00009032 01CFBE80 00000000 C0003A8C 
Mar 18 18:00:36 xxxxxx kernel: GPR24: C0003844 01858A96 C19BF240 00000026 C00CDF68 FFFFFFEA C45274B4 C19BF240 
Mar 18 18:00:36 xxxxxx kernel: Call backtrace: 
Mar 18 18:00:36 xxxxxx kernel: C42325CC C002966C C0003898 00000000 0180F650 01806BE4 0180BC28 
Mar 18 18:00:36 xxxxxx kernel: 01807718 0180B0DC 0180B1E8 01804070 018066C8 018014AC 
Mar 18 18:00:36 xxxxxx kernel: Instruction DUMP: 2c000000  7c1c0378  4082000 <839a0050> 2c1c0000  3d20c016  3bc9b750  5463043e 7fe00026 
Mar 18 18:00:36 xxxxxx kernel: Kernel panic: kernel access of bad area pc c00cdfdc lr c002966c address 8 tsk telnet/2269

In system.map :
c00cdfdc --> c00cdf68 t tty_write
C002966C --> c0029544 T sys_write
C0003898 --> c0003898 T syscall_ret_1

Second one :
Linux version 2.2.3 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version egcs-2.91.57 19980901 (egcs-1.1 release)) #1 Thu Mar 18 11:38:28 CET 1999

Mar 19 09:25:58 xxxxxx kernel: NIP: C000530C XER: 00000000 LR: C000528C REGS: c4c97d70 TRAP: 0300
Mar 19 09:25:58 xxxxxx kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Mar 19 09:25:58 xxxxxx kernel: TASK = c4c96000[678] 'f771' mm->pgd c2276000 Last syscall: 45 
Mar 19 09:25:58 xxxxxx kernel: last math c4c96000
Mar 19 09:25:58 xxxxxx kernel: GPR00: 00000000 C4C97E60 C4C96000 00090202 00000000 01BF7420 01AE0000 00000006 
Mar 19 09:25:58 xxxxxx kernel: GPR08: 0000032C 51780000 00000000 0035BFFC 24224032 01AE9B20 01D88428 00000000 
Mar 19 09:25:58 xxxxxx kernel: GPR16: 01D88448 00000000 7FFC4B5C 00000000 00001032 04C97E80 00000000 C0003A8C 
Mar 19 09:25:58 xxxxxx kernel: GPR24: C0005270 01BF7380 00000000 00000000 C4C97E90 00000000 01ADFFE0 00000000 
Mar 19 09:25:58 xxxxxx kernel: Call backtrace: 
Mar 19 09:25:58 xxxxxx kernel: C00054B4 C0003A8C 01974910 019706B0 01895684 018183CC 018143C8 
Mar 19 09:25:58 xxxxxx kernel: 01873244 01867AA4 0187104C 01868598 0184E350 0184DF28 0184A57C 
Mar 19 09:25:58 xxxxxx kernel: 01844178 01842AD4 0184579C 01843E74 01844228 01842AD4 01844D20 
Mar 19 09:25:58 xxxxxx kernel: 01890318 01848614 01893D28 01897478 01801130 
Mar 19 09:25:58 xxxxxx kernel: Instruction DUMP: 390b093c  7fcb2e70 556b103a <7d27582e> 7d404c2c  7c08582e  7d4a0379  4082ff8c  37deffe0 
Mar 19 09:25:58 xxxxxx kernel: Kernel panic: kernel access of bad area pc c000530c lr c000528c address 35C002 tsk f771/678

In system.map :
c000530c --> c0005270 T do_IRQ
C00054B4 --> c0005270 T do_IRQ
C0003A8C --> c0003a8c T int_return


-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux xxxxxx.xxxxxx.xxx.fr 2.2.2 #1 Fri Mar 5 10:45:47 CET 1999 ppc unknown
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





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
