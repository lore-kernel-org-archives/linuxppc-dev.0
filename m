Message-ID: <003701c3e802$9770da40$0101a8c0@jidianyyf>
From: "Larry Zheng" <larryzheng@transengines.com>
To: <inuxppc-embedded@lists.linuxppc.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Question about PCI memory map on ibm-405ep board 
Date: Sat, 31 Jan 2004 22:00:31 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear all,
    We add two RTL8139 chip on our ibm-405ep embedded board, the chip
is founded when pci system setup, but the 8139 driver con't read any
8139 register(system will crash when rw 8139 memory space). i guess that
memory space map between 8139 and pci brige is not right or hardware's
bug. could anyone tell me how to test PCI bug(maybe read PCIC0_ERREN,
PCIC0_STATUS ) or hardware bug?
    BTW, if we disable 8139 driver, all thing is ok.

    here is my code read PCIC0_STATUS, in arch\ppc\kernel\pci_auto.c
...
     out_le32(hose->cfg_addr, ((0x06)& 0xfc)|0x80000000);
     printk("pci status reg = %x \n", in_le16(hose->cfg_data));
     out_le32(hose->cfg_addr, ((0x49)&0xfc)| 0x80000000);
     printk("pci error reg = %x \n", in_8(hose->cfg_data));
...

i open the pci debug option and add some dump message, system crash when
first rw 8139 register, the code is

rtl8139_init_board(...){
...
 /* Bring old chips out of low-power mode. */
 RTL_W8 (HltClk, 'R');                      // system crash at here--- larry
...
}

and the runtime console output is

------------------------------------------

boot jump debug
00500000123567
loaded at:     00500000 0081120C
relocated to:  00400000 0071120C
board data at: 0070E128 0070E17C
relocated to:  00405484 004054D8
zimage at:     00405A58 004F2AE3
initrd at:     004F3000 0070D636
avail ram:     00712000 08000000

Linux/PPC load: root=/dev/ram0 rw
Uncompressing Linux...done.
Now booting the kernel
compiled by davey
memsize:08000000
intfreq:0FE502AA
busfreq:07F28155
pllouta_freq03F940AA
cpc0_ucr:00000E0E
dll:00000000
dlm:00000000
enetaddr:0070E150-0070E156-0070E15C-0070E162-0070E168-0070E16E
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.22ppc (root@linux-test.transengines.com) (gcc version 3.2.1 20020930 (MontaVista)) #104 Sat Jan 31 21:17:22 CST 2004
pci config addr = e7fff000 , cfg_data = e7ffe004
ioremap PCLIO_BASE = 0xe7ffd000
PCI bridge regs before fixup
 pmm0ma 0x0
 pmm0ma 0xfffe0000
 pmm0ma 0xfffe0000
 pmm0ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm3ma 0x0
 pmm3ma 0x0
 pmm3ma 0x0
 pmm3ma 0x0
 ptm1ms 0x0
 ptm1la 0x0
 ptm2ms 0x0
 ptm2la 0x0
BUS 0, device 0, Function 0 bar 0x00000014 is 0x00000008
BUS 0, device 0, Function 0 bar 0x00000018 is 0x00000000
PCI bridge regs after fixup
 pmm0ma 0xc0000001
 pmm0ma 0x80000000
 pmm0ma 0x80000000
 pmm0ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm1ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm2ma 0x0
 pmm3ma 0x0
 pmm3ma 0x1
 pmm3ma 0x0
 pmm3ma 0x0
 ptm1ms 0x1
 ptm1la 0x0
 ptm2ms 0x0
 ptm2la 0x0
pci status reg = 0
pci error reg = 0
 pci_cfg = e7fff000 , pci_dat = e7ffe004
pci status reg = 0
pci error reg = 0
pci status reg = 0
pci error reg = 0
 pci_cfg = e7fff000 , pci_dat = e7ffe004
pci status reg = 0
pci error reg = 0
IBM 405EP Evaluation Board port (C) 2003 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 rw
dll=124
dlm=0
Calibrating delay loop... 266.24 BogoMIPS
Memory: 125076k available (1576k kernel code, 444k data, 252k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:08 [10ec/8129] 000200 00

------Begain dump pci configure zone---------

 ec
 10  29  81  6  0  0  2  10  0  0  2  0  80  0  0  1
 ff  0  0  0  ff  ff  bf  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  ec  11  29  81  0
 0  0  0  0  0  0  0  0  0  0  0  1e  1  20  20 ------End pci configure zone--------

PCI: Calling quirk c000b7d4 for 00:01.0
PCI: Calling quirk c01dcb0c for 00:01.0
Found 00:10 [10ec/8129] 000200 00

------Begain dump pci configure zone---------

 ec
 10  29  81  6  0  0  2  10  0  0  2  0  80  0  0  1
 fe  0  0  0  fe  ff  bf  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  ec  11  29  81  0
 0  0  0  0  0  0  0  0  0  0  0  1f  1  20  20 ------End pci configure zone--------

PCI: Calling quirk c000b7d4 for 00:02.0
PCI: Calling quirk c01dcb0c for 00:02.0
Fixups for bus 00
Bus scan for 00 returning with max=00
PCI: bridge rsrc 0..ffff (100), parent c01be814
PCI: bridge rsrc 80000000..bfffffff (200), parent c01be830
PCI:00:01.0: Resource 1: bfffff00-bfffffff (f=200)
PCI:00:02.0: Resource 1: bffffe00-bffffeff (f=200)
PCI:00:01.0: Resource 0: 0000ff00-0000ffff (f=101)
PCI:00:02.0: Resource 0: 0000fe00-0000feff (f=101)
PCI: Calling quirk c01dc950 for 00:01.0
PCI: Calling quirk c01dc950 for 00:02.0

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
emac: IBM OCP EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
mal0: Initialized, 4 tx channels, 2 rx channels
eth0: IBM emac, MAC 00:ff:00:ff:00:ff
eth0: Found Generic MII PHY (0x01)
eth1: IBM emac, MAC 00:ff:00:ff:00:ff
eth1: Found Generic MII PHY (0x00)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.26

------Begain dump pci configure zone---------

 ec
 10  29  81  6  0  0  2  10  0  0  2  0  80  0  0  1
 ff  0  0  0  ff  ff  bf  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  ec  11  29  81  0
 0  0  0  0  0  0  0  0  0  0  0  1e  1  20  20 ------End pci configure zone--------

PCI: Enabling device 00:01.0 (0006 -> 0007)
pio_star = ff00, pio_end = ffff
 mmio_start = bfffff00, mmio_end = bfffffff
pci_status = 0
pci_error = 0

------Begain dump pci configure zone---------

 ec
 10  29  81  7  0  0  2  10  0  0  2  0  80  0  0  1
 ff  0  0  0  ff  ff  bf  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  ec  11  29  81  0
 0  0  0  0  0  0  0  0  0  0  0  1e  1  20  20 ------End pci configure zone--------

Instruction machine check in kernel mode.
vector: 200 at pc = c01dadf8, lr = c01dade4
msr = 9030, sp = c03c5e90 [c03c5de0]
current = c03c4000, pid = 1, comm = swapper
mon> x Oops: machine check, sig: 7
NIP: C01DADF8 XER: 00000000 LR: C01DADE4 SP: C03C5E90 REGS: c03c5de0 TRAP: 0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c03c4000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0xbfffff5b acr=   0x00000000 besr=  0x00800000
PLB0 to OPB: bear= 0x80000000 besr0= 0x00000000 besr1= 0x00000000
GPR00: 00000052 C03C5E90 C03C4000 00000025 00001030 00000001 00000000 C01C56F7
GPR08: 00000000 C01BE7C4 C0210000 C03C5D70 C0210000 30000000 00000000 00000000
GPR16: 00000000 FFF022EA 00500000 00000000 00500000 00100000 00200000 C03C5F14
GPR24: 00000100 00000200 C0757C00 C0757D60 C905EF00 00000000 BFFFFF00 C04F1C00
Call backtrace:
C01DADE4 C01DB088 C0104D94 C0104E60 C01DB648 C01CE63C C01CE684
C0002480 C0006FE4
eth0: Link is Up
eth0: Speed: 100, Full duplex.
Kernel panic: Attempted to kill init!

---------------------------------------------

Best Regards
Larr zheng

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
