Message-ID: <371B741C.35603A35@fi.infn.it>
Date: Mon, 19 Apr 1999 20:21:16 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: New boot attempts on a MVME2431 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm still trying to boot LinucPPC on this board. Thanks to new kernel
images provided by G. Paubert in his site I could obtain some new
results (not a success but at least this time the boot is going a bit
further).

The board has no drive, so I tried two versions of the kernel image: the
initrd and the nfsroot, (this last try was to see if something different
happens, becauase I do not have a NFS root tree for the PPC).

When I boot the zImage.initrd-2.2.4 kernel I get these messages:

------ CLIP HERE ------

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

Bytes Received =&1387916, Bytes Loaded =&1387916
Bytes/Second   =&346979, Elapsed Time =4 Second(s)

Residual-Data Located at: $01F78000

Model:                            (e2)
Serial: MOT0359E66
Processor/Bus frequencies (Hz): 350006560/100001144
Time Base Divisor: 4000
Original MSR: 3040
Original HID0: 80a4
Original R31: 0

PCI: Probing PCI hardware

Linux/PPC load: console=ttyS0

Uncompressing the kernel...Kernel at 0x00000000, size=0x158ae4
Initrd at 0x00231000, size=0xb93a7
Residual data at 0x00159000
Command line at 0x00160000
done
Now booting...
PReP architecture
Total memory = 32MB; using 128kB for hash table (at c0160000)
Linux version 2.2.4 (root@vcorr1) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2
 release)) #32 Fri Apr 16 15:02:16 WET DST 1999
OpenPIC found at d1000000.
Boot arguments: console=ttyS0
OpenPIC Version ? (2 CPUs and 17 IRQ sources) at d1000000
OpenPIC timer frequency is 12500243 Hz
time_init: decrementer frequency = 998700000/60 (15MHz)
Calibrating delay loop... 465.31 BogoMIPS
Memory: 30184k available (896k kernel code, 856k data, 88k init)
[c0000000,c2000
000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting bridge 0
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
Starting kswapd v 1.5

------ END CLIP ------

and here it freeze and I have t reset the board.

My questions are: 
I have to give some parameter at the boot prompt?
And the ram disk image that the README said to be inside the file
initrd.gz 
is still inside the kernel image or it must be loade from this file?

It seems quite strange to me also the message:
OpenPIC Version ? (2 CPUs and 17 IRQ sources) at d1000000
Why 2 CPU?


The results of the zImage.nfsroot boot was obiuvsly different:

------ CLIP HERE ------

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

Bytes Received =&469612, Bytes Loaded =&469612
Bytes/Second   =&234806, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F78000

Model:                            (e2)
Serial: MOT0359E66
Processor/Bus frequencies (Hz): 350002752/99999904
Time Base Divisor: 4000
Original MSR: 3040
Original HID0: 80a4
Original R31: 0

PCI: Probing PCI hardware

Linux/PPC load: console=ttyS0 root=/dev/nfs

Uncompressing the kernel...Kernel at 0x00000000, size=0x1006a4
Initrd at 0x00000000, size=0x0
Residual data at 0x00101000
Command line at 0x00108000
done
Now booting...
PReP architecture
Total memory = 32MB; using 128kB for hash table (at c0120000)
Linux version 2.2.4 (root@vcorr1) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2
 release)) #33 Fri Apr 16 15:20:21 WET DST 1999
OpenPIC found at d1000000.
Boot arguments: console=ttyS0 root=/dev/nfs
OpenPIC Version ? (2 CPUs and 17 IRQ sources) at d1000000
OpenPIC timer frequency is 12500243 Hz
time_init: decrementer frequency = 998700000/60 (15MHz)
Calibrating delay loop... 465.31 BogoMIPS
Memory: 31280k available (652k kernel code, 776k data, 60k init)
[c0000000,c2000
000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting bridge 0
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
eth0: DC21143 at 0x11100 (PCI bus 0, device 14), h/w address
08:00:3e:28:28:00,
      and requires IRQ18 (provided by PCI BIOS).
de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com
NIP: C000FDE0 XER: 00000000 LR: C000FDC4 REGS: c0197ce0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0196000[1] 'swapper' mm->pgd c00ba000 Last syscall: 120
last math 00000000
GPR00: 00001032 C0197DD0 C0196000 00000001 00008000 00000000 00038C98
00000001
GPR08: 00000001 00007800 80000000 000001E0 0000001F 01F720A0 00000000
00000000
GPR16: 00000000 00000000 20000002 00000000 00000000 E0001FFE 00000000
00000000
GPR24: 00000000 00000000 C00E0000 000000FA 00000000 00009032 C011F76C
C0197DD0
Call backtrace:
00000000 C009BFD4 C0095C38 C00945AC C00942E4 C0056300 C0057368
C00D5608 C00D6300 C00D4DE4 C00D678C C00CB714 C0004044 C000870C
Instruction DUMP: 2c090000  912b0000  41820008 <91690004> 3b800001 
48000008  3b
800000  73aa8000  38000000
Kernel panic: kernel access of bad area pc c000fde0 lr c000fdc4 address
7804 tsk
 swapper/1

------ END CLIP ------

My question are: 
Is the way I gave the boot parameter (root=/dev/nfs) right? 
I exported an empty /home/ppc directory on the same PC that I used as 
tftp server, but how the board can recognize just this directory? And 
what files I have to put in this directory?

Many thanks to everybody for the help!

Ciao

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
