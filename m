Date: Fri, 22 Jan 1999 01:58:18 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Dual CPU MTX first boot
Message-ID: <Pine.LNX.4.04.9901220152070.12144-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just to let you all know, I have managed to boot an MTX board with both
CPU's. This is 2.2.0-pre7, with my integrated version of Gabriel Paubert's
and Corey Minyard's patches.

Also, to start SMP, I have to access the residual data. Right now I've got
an ugly hack that does it in the bootloader, which sets MSR[IP] to zero,
then I use the OpenPIC to reset the CPU.

What would it take to map in the residual data so this could be cleaner
(and save a couple of uneeded copies of it also..)

(There is a problem with kswapd though.. ;) 

Total memory = 128MB; using 512kB for hash table (at c0200000)
Linux version 2.2.0-pre7 (hozer@altus.local.drgw.net) (gcc version
egcs-2.91.60 199
Boot arguments: root=/dev/sdb4 console=tty0 console=ttyS0
OpenPIC Version 1.2 (2 CPUs and 16 IRQ sources) at d1000000
OpenPIC Vendor 0 (Unknown), Device 0 (Unknown), Stepping 1
OpenPIC timer frequency is 8333565 Hz
request_irq(): irq 16 handler c000c998 name 82c59 cascade dev_id 0000
request_irq(): irq 2 handler c0005564 name cascade dev_id 0000
time_init: decrementer frequency = 1000491960/60 (15MHz)
Console: colour VGA+ 80x25
Calibrating delay loop... 199.48 BogoMIPS
Memory: 127432k available (1036k kernel code, 2512k data, 92k init)
[c0000000,c800]
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Resetting CPU1 
CPU1 reset, waiting
SMP 1: start_secondary()
SMP 1: smp_callin()
Processor 1 found.
SMP 0: smp_commence()
SMP 1: smp_callin done
PCI: Probing PCI hardware
Setting bridge 0
Interrupt mapping from 20 to 116
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
request_irq(): irq 1 handler c00ca860 name keyboard dev_id 0000
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
_spin_lock(c012f274) CPU#1 NIP c0030628 holder: cpu 0 pc C0004224
Floppy drive(s): fd0 is 2.88M
request_irq(): irq 6 handler c00a3414 name floppy dev_id 0000
FDC 0 is a National Semiconductor PC87306
ncr53c8xx: at PCI bus 0, device 12, function 0
request_irq(): irq 6 handler 00000000 name <NULL> dev_id 0000
ncr53c8xx: reallocating base (Wacky IBM)ncr53c8xx: reallocating base2
(Wacky IBM)<
ncr53c875-0: rev=0x04, base=0x1041000, io_port=0x10000, irq=19   
ncr53c875-0: NCR clock is 26691KHz, 26772KHz
ncr53c875-0: ID 7, Fast-20, Parity Checking
ncr53c875-0: on-chip RAM at 0x1040000
request_irq(): irq 19 handler c00f61f0 name ncr53c8xx dev_id c019c080
ncr53c875-0: restart (scsi reset).
ncr53c875-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - revision 3.1d
scsi : 1 host.
Trying to vfree() nonexistent vm area (ffffffff)
NIP: 00000000 XER: 00000000 LR: 00000000 REGS: c0415e30 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0414000[3] 'kswapd' mm->pgd c012a000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 1
GPR00: 00000000 C0415F20 C0414000 00000031 00000001 00000000 C0140000 00000000
GPR08: 00000000 C0160000 00000000 C0415E50 84200024 07F71700 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
GPR24: 00000000 C0135304 C0140000 C0140000 C0180000 00000000 C0140000 C00FF17C
Call backtrace:
00000000 80097188
Instruction DUMP:NIP: C0007344 XER: 20000000 LR: C000732C REGS: c0415cf0
TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0414000[3] 'kswapd' mm->pgd c012a000 Last syscall: -1
last math 00000000 CPU: 0 last CPU: 1
GPR00: C000732C C0415DE0 C0414000 00000011 00000000 00000000 00000000 00000000
GPR08: 00000000 C0160000 00000000 C0415D20 84200024 07F71700 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00415E20 00000000 C0003A98
GPR24: C00057A8 C0135304 C0140000 C0140000 C0100000 00000000 FFFFFFF4 FFFFFFFD
Call backtrace:
C000732C C00055D0 C00057EC C0003A98 00000000 80097188
Instruction DUMP: 309fffff  7c842110  548606bc <7cbee82e> 548406ba
60840020  60c6
Kernel panic: kernel access of bad area pc c0007344 lr c000732c address
FFFFFFF4 t3
OpenPIC IPI support not done yet!!
Rebooting in 180 seconds..  Vendor: IBM       Model: DORS-32160W
Rev: WA0A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
ncr53c875-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15) 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
