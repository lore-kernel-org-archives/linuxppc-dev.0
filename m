Message-ID: <371621E6.F54F8019@fi.infn.it>
Date: Thu, 15 Apr 1999 19:29:10 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: First attempt for LinuxPPC on a MVME2400
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As first thank to all people that helped me (but I think this is only
the beginning!).
The first step was to set the environment )PPC4bug> ENV) for booting
PReP using the options:
Network PReP-Boot Mode Enable = Y
and 
VME3PCI Master Master Enable = N

The second step was to set up a PC to provide the boot directory. I used
a Pentium with a RedHat 5.2, and copied all files from
ftp://vcorr1.iram.es/pub/linux-2.2/ to the /tftpboot directory on that
PC, and set up the tftpd daemon (inside inetd.conf).
i renamed the file zimage_initrd-2_2.1 as zimage.

The thirsd step was to setup the network on th MVME2400, we did:


Copyright Motorola Inc. 1988 - 1998, All Rights Reserved

PPC4 Debugger/Diagnostics Release Version 1.1 - 01/11/99 RM01
COLD Start

Local Memory Found =02000000 (&33554432)

MPU Clock Speed =350Mhz

BUS Clock Speed =100Mhz

Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

System Memory: 32MB, ECC Enabled (ECC-Memory Detected)
L2Cache:       1024KB, 140Mhz


PPC4-Bug>niot
Controller LUN =00?
Device LUN     =00?
Node Control Memory Address =01F9E000?
Client IP Address      =192.84.146.131?
Server IP Address      =192.84.146.24?
Subnet IP Address Mask =255.255.255.0?
Broadcast IP Address   =255.255.255.255?
Gateway IP Address     =0.0.0.0?
Boot File Name ("NULL" for None)     =zimage?
Argument File Name ("NULL" for None) =?
Boot File Load Address         =001F0000?
Boot File Execution Address    =001F0000?
Boot File Execution Delay      =00000000?
Boot File Length               =00000000?
Boot File Byte Offset          =00000000?
BOOTP/RARP Request Retry       =00?
TFTP/ARP Request Retry         =00?
Trace Character Buffer Address =00000000?
BOOTP/RARP Request Control: Always/When-Needed (A/W)=W?
BOOTP/RARP Reply Update Control: Yes/No (Y/N)       =Y?

The last step was the booting attempt:


PPC4-Bug>nbo
Network Booting from: DEC21143, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,19@e,0:0,0
Loading: zimage

Client IP Address      = 192.84.146.131
Server IP Address      = 192.84.146.24
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zimage
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1383272, Bytes Loaded =&1383272
Bytes/Second   =&345818, Elapsed Time =4 Second(s)

Residual-Data Located at: $01F78000

Model:                            (e2)
Serial: MOT0359E66
Processor/Bus frequencies (Hz): 350007040/100001144
Time Base Divisor: 4000
Original MSR: 3040
Original HID0: 80a4
Original R31: 0

PCI: Probing PCI hardware

Linux/PPC load: console=ttyS0

Uncompressing the kernel...Kernel at 0x00000000, size=0x157bb4
Initrd at 0x00230000, size=0xb9384
Residual data at 0x00158000
Command line at 0x0015f000
done
Now booting...
prep_init: WARNING: can't find an OpenPIC on what looks like a PowerPlus
board
Total memory = 32MB; using 128kB for hash table (at c0160000)
Linux version 2.2.1 (root@vcorr1) (gcc version egcs-2.91.60 19981201
(egcs-1.1.1
 release)) #8 Thu Feb 11 19:15:47 WET 1999
Boot arguments: console=ttyS0
request_irq(): irq 2 handler c0005274 name cascade dev_id 0000
time_init: decrementer frequency = 1499988240/60 (23MHz)
Calibrating delay loop... 699.60 BogoMIPS
Memory: 30188k available (892k kernel code, 856k data, 88k init)
[c0000000,c2000
000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting bridge 0
Interrupt mapping from 20 to 92
openpic.c:548: illegal irq 9 from c011d5d0,[c011c4bc],[[c012c36c]]
NIP: C000BBF8 XER: 00000000 LR: C000C474 REGS: c02edd60 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c02ec000[1] 'swapper' mm->pgd c0101000 Last syscall: -1
last math 00000000
GPR00: 00000000 C02EDE50 C02EC000 00010120 00400000 00400000 C0110000
C0115928
GPR08: 000F3E87 C0110000 000003F8 C02EDD90 00000000 01F721C0 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 C0110000
C0120000
GPR24: 00000000 00000001 C0134A1E C01349D7 C01349D8 00000000 00000001
00000009
Call backtrace:
C000C448 C011D5D0 C011C4BC C012C36C C011A7D8 C0004160 C0008598
Instruction DUMP: 38600000  4e800020  4e800020 <7c001c2c> 64008000 
7c001d2c  7c
0006ac  7c001c2c  740a4000
Kernel panic: kernel access of bad area pc c000bbf8 lr c000c474 address
10120 ts
k swapper/1
Rebooting in 180 seconds..

I tried also to start the  zimage_nfsroot-2_2.1 image, obtainig a
similar result, that is right because I did not setup any root tree for
the NFS.

My first questiona is: the warning:
prep_init: WARNING: can't find an OpenPIC on what looks like a PowerPlus
board

is due to the new hawk chipset? And the message:
openpic.c:548: illegal irq 9 from c011d5d0,[c011c4bc],[[c012c36c]]

is due to this problem? And what I have to do?

Before starting to build a tree I would like to know if there will be
any chance to boot on it at this stage or not. I'm still tring to build
a cross compiler, and for the moment I cannot try to build another
kernel.

Do you have any suggestion? 


Thank you in advance


-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
