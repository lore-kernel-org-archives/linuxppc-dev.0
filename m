Message-ID: <37209E59.BE289D2E@fi.infn.it>
Date: Fri, 23 Apr 1999 18:22:49 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>, Matt Porter <mmporter@home.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: A still not working, but cross-compiled kernel
References: <Pine.HPP.3.96.990421101949.20020T-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thanks to all your suggestion and help I finally get out from the kernel
cross-compilation; I obtained a zImage file that boot in the same manner
of the Gabriel Paubert images (i.e. still crash on the ethernet deriver,
but in the same way), so at least I can be confident that the
cross-compilation procedure is going right.

Next problem is to get the ethernet working: I tries to change the
ethernet setting as suggested; the output of the SROM command is this:

PPC4-Bug>srom

Device Address =$00007000 (N/Y)? y
Reading SROM into Local Buffer.....
$00 (&000) 0000?
$02 (&002) 0000?
$04 (&004) 0000?
$06 (&006) 0000?
$08 (&008) 0000?
$0A (&010) 0000?
$0C (&012) 0000?
$0E (&014) 0000?
$10 (&016) AF00?
$12 (&018) 0301?
$14 (&020) 0800?
$16 (&022) 3E28?
$18 (&024) 2800?
$1A (&026) 0E1E?
$1C (&028) 0000?
$1E (&030) 0008?	<---- Is this one?
$20 (&032) 0193?
$22 (&034) 0308?
$24 (&036) 0003?
$26 (&038) 0108?
$28 (&040) 0000?
$2A (&042) 0100?
$2C (&044) 0078?
$2E (&046) E001?
$30 (&048) 0050?
$32 (&050) 0018?
$34 (&052) 0000?
$36 (&054) 0000?
$38 (&056) 0000?
$3A (&058) 0000?
$3C (&060) 0000?
$3E (&062) 0000?
$40 (&064) 0000?
$42 (&066) 0000?
$44 (&068) 0000?
$46 (&070) 0000?
$48 (&072) 0000?
$4A (&074) 0000?
$4C (&076) 0000?
$4E (&078) 0000?
$50 (&080) 0000?
$52 (&082) 0000?
$54 (&084) 0000?
$56 (&086) 0000?
$58 (&088) 0000?
$5A (&090) 0000?
$5C (&092) 0000?
$5E (&094) 0000?
$60 (&096) 0000?
$62 (&098) 0000?
$64 (&100) 0000?
$66 (&102) 0000?
$68 (&104) 0000?
$6A (&106) 0000?
$6C (&108) 0000?
$6E (&110) 0000?
$70 (&112) 0000?
$72 (&114) 0000?
$74 (&116) 0000?
$76 (&118) 0000?
$78 (&120) 0000?
$7A (&122) 0000?
$7C (&124) 0000?
$7E (&126) ADFF?

I tried to put on 1E location (that one marked above) the value 0 but
the results were the same of before the changes, the kernel crash:

Linux/PPC load: console=ttyS0 root=/dev/nfs

Uncompressing the kernel...Kernel at 0x00000000, size=0x1026a4
Initrd at 0x00000000, size=0x0
Residual data at 0x00103000
Command line at 0x0010a000
done
Now booting...
PReP architecture
Total memory = 32MB; using 128kB for hash table (at c0120000)
Linux version 2.2.6 (root@vcorr1) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2
 release)) #11 Wed Apr 21 19:06:28 WET DST 1999
OpenPIC found at d1000000.
Boot arguments: console=ttyS0 root=/dev/nfs
OpenPIC Version ? (2 CPUs and 17 IRQ sources) at d1000000
OpenPIC timer frequency is 12500088 Hz
time_init: decrementer frequency = 998700000/60 (15MHz)
Calibrating delay loop... 465.31 BogoMIPS
Memory: 31272k available (652k kernel code, 784k data, 60k init)
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
NIP: C000FDF4 XER: 00000000 LR: C000FDD8 REGS: c0141ce0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0140000[1] 'swapper' mm->pgd c00ba000 Last syscall: 120
last math 00000000
GPR00: 00001032 C0141DD0 C0140000 00000001 00008000 00000000 00038C98
00000001
GPR08: 00000001 00007800 80000000 000001E0 0000001F 01F72040 00000000
00000000
GPR16: 00000000 00000000 20000002 00000000 00000000 E0001FFE 00000000
00000000
GPR24: 00000000 00000000 C00E0000 000000FA 00000000 00009032 C011D76C
C0141DD0
Call backtrace:
00000000 C009C1B8 C0095E1C C0094790 C00944C8 C005647C C00574E4
C00D560C C00D6304 C00D4DE8 C00D6790 C00CB714 C0004044 C0008720
Instruction DUMP: 2c090000  912b0000  41820008 <91690004> 3b800001 
48000008  3b
800000  73aa8000  38000000
Kernel panic: kernel access of bad area pc c000fdf4 lr c000fdd8 address
7804 tsk
 swapper/1

I tried also to apply the Matt Porter patch for dec21143 to my kernel
tree, but it didn't work (probably because it's based on kernel 2.2.5
and I'm using a 2.2.6 patched kernel). 

Still I'm working on setting up the bootp server and to build the root
tree, but I don't think that this can cause the crash of the system.

Many thanks to everybody. 

Bye

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
