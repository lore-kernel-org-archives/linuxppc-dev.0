Date: Fri, 10 Aug 2001 04:06:49 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200108101106.EAA00491@krakatoa.gigabitnetworks.com>
To: linux1394-devel@lists.sourceforge.net
Subject: linux1394 (TOT) and HHL 2.4.2_hll20 on PowerPC
Cc: linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am developing a platform using a custom PPC board. CUrrently, I am
using the SIIG 3 port adapter, and have an IDE drive with an ADS FireWire
enclosure. Pretty standard stuff.

In the 2.4.4 HHL kernel I started out with, the version of the iee1394 subsystem
was only the following files:

aic5800.c  highlevel.c      ieee1394_syms.c          pcilynx.c  video1394.c
csr.c      hosts.c          ieee1394_transactions.c  raw1394.c
guid.c     ieee1394_core.c  ohci1394.c

(No SBP2 driver).

So, I followed the instructions on the homepage, and downloaded (via CVS)
all of the source code. I then ran into the following changes I needed to
make :

pci_lynx.c -- comment out call to pci_set_dma_mask(dev, 0xffffffff))

***** (got a linker error, not defined)

raw1394.c --
#if 0
		INIT_TQUEUE(&req->tq, (void(*)(void*))queue_complete_cb, NULL);
#else
                INIT_TQ_LINK(req->tq);
                req->tq.routine = (void(*)(void*))queue_complete_cb;
#endif

***** INIT_TQUEUE not defined. Replacement code is friom previous driver.

nodemgr.c --

#if 0
	INIT_TQUEUE(&hi->task, nodemgr_node_probe, host);
#else
	INIT_TQ_LINK(hi->task);
        hi->host->timeout_tq.routine = (void (*)(void*))nodemgr_node_probe;
        hi->host->timeout_tq.data = host;
#endif
***** INIT_TQUEUE not defined. Replacement code is friom previous driver.


hosts.c ---

#if 0
	INIT_TQUEUE(&h->timeout_tq, (void (*)(void*))abort_timedouts, h);
#else
	INIT_TQ_LINK(h->timeout_tq);
        h->timeout_tq.routine = (void (*)(void*))abort_timedouts;
        h->timeout_tq.data = h;
#endif
***** INIT_TQUEUE not defined. Replacement code is friom previous driver.


The first time it booted, it got the following error:

Linux version 2.4.2_hhl20 (jfd@atlantis) (gcc version 2.95.2 19991024 (release))
#446 Fri Aug 10 03:43:33 PDT 2001
cpu0: MPC8240/KAHLUA : MOUSSE Platform : 64MB RAM: MPLD Rev.  1
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
IP PNP: 802.3 Ethernet Address=<0:0:10:20:30:44>
IP PNP: mousse: eth0 IP 209.128.93.138/255.255.255.0 gateway 209.128.93.129
server 209.128.93.133
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600
ip=209.128.93.138:209.128.93.133:209.128.93.129:255.255.255.0:mousse:eth0
root=/dev/nfs rw nfsroot=209.128.93.133:/boot/root-fs,timeo=200,retrans=500
nfsaddrs=209.128.93.138:209.128.93.133
time_init: decrementer frequency = 16.666112 MHz
time_init: MPC8240 PCI Bus frequency = 33.332224 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 62284k available (1456k kernel code, 540k data, 80k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41293kB/13764kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0xffe08080 (irq = 4) is a ST16650
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present,
00:00:10:20:30:44, IRQ 1.
eth0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
kernel BUG at slab.c:804!
Oops: Exception in kernel mode, sig: 4
NIP: C002F11C XER: 20000000 LR: C002F11C SP: C035FE90 REGS: c035fde0 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c035e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C002F11C C035FE90 C035E000 0000001A 00001032 00000001 C01E0000 00000000
GPR08: C01E0000 C01B0000 00000000 C035FDD0 22442022 10019918 03F9FD00 007FFF00
GPR16: 00000000 00000001 007FFEC0 00000000 00000000 C01C0000 C01E0000 C03573F4
GPR24: C0194F50 C035FE98 C01B2CF0 C0170000 C035743C C0170000 C03573E0 C03573D8
Call backtrace:
C002F11C C01D5260 C01C8808 C01C88AC C0003E00 C0006A10
Kernel panic: Attempted to kill init!


So, I looked at slab.c and iffed out the sanity check to see how much
farther it would go:

#if 0
			/* The name field is constant - no lock needed. */
			if (!strcmp(pc->name, name))
				BUG();
#endif

Linux version 2.4.2_hhl20 (jfd@atlantis) (gcc version 2.95.2 19991024 (release)
#448 Fri Aug 10 03:48:59 PDT 2001
cpu0: MPC8240/KAHLUA : MOUSSE Platform : 64MB RAM: MPLD Rev.  1
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
IP PNP: 802.3 Ethernet Address=<0:0:10:20:30:44>
IP PNP: mousse: eth0 IP 209.128.93.138/255.255.255.0 gateway 209.128.93.129
serer 209.128.93.133
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600
ip=209.128.93.138:209.128.93.133:209.12.93.129:255.255.255.0:mousse:eth0
root=/dev/nfs rw nfsroot=209.128.93.133:/bootroot-fs,timeo=200,retrans=500
nfsaddrs=209.128.93.138:209.128.93.133
time_init: decrementer frequency = 16.666112 MHz
time_init: MPC8240 PCI Bus frequency = 33.332224 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 62284k available (1456k kernel code, 540k data, 80k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41293kB/13764kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enbled
ttyS00 at 0xffe08080 (irq = 4) is a ST16650
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present,
00:00:10:2030:44, IRQ 1.
eth0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
ohci1394: v0.51 08/08/01 Ben Collins <bcollins@debian.org>
ohci1394_0: Remapped memory spaces reg 0xbffff000
ohci1394_0: Soft reset finished
ohci1394_0: GUID: 00010800:00008d0a
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=1 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: Receive DMA ctx=2 initialized
ohci1394_0: Transmit DMA ctx=2 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[1]  MMIO=[bffff000-bffff800]  Max
Packet=2048]
ohci1394_0: request csr_rom address: c03e7000
ohci1394_0: request csr_rom address: c03e7000
ohci1394_0: devctl: Bus reset requested
raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi0 : IEEE-1394 SBP-2 protocol driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ohci1394_0: IntEvent: 04030010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: SelfID interrupt received (phyid 0, not root)
ohci1394_0: SelfID packet 0x807f8196 received
ieee1394: Including SelfID 0x807f8196
ohci1394_0: SelfID for this node is 0x807f8196
ohci1394_0: SelfID packet 0x817f87d4 received
ieee1394: Including SelfID 0x817f87d4
ohci1394_0: SelfID complete
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
floating point used in kernel (task=c0350000, pc=c0322f7c)
Oops: kernel access of bad area, sig: 11
NIP: C0322F7C XER: 20000000 LR: C001B260 SP: C0351EB0 REGS: c0351e00 TRAP: 0300
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 00802E3C, DSISR: 20000000
TASK = c0350000[2] 'keventd' Last syscall: 7
last math 00000000 last altivec 00000000
GPR00: C0322F7C C0351EB0 C0350000 C0322F38 00001032 C034FE68 C01AF3DC 00000000
GPR08: C3FE003C C0379544 00000000 C01E4C44 22444022 10019918 03F9FD00 007FFF00
GPR16: 00000000 00000001 007FFEC0 007FFF00 003FF000 03F99A68 00000002 C01B0000
GPR24: C01C0000 C01B0000 C03505C0 00000000 C01E4C44 C0351EC0 C01C0000 C0350000
Call backtrace:
C00122E8 C0024E9C C0006A10
ieee1394: send packet 400: ffc10140 ffc0ffff f0000404
ohci1394_0: Inserting packet for node 65473, tlabel=0, tcode=0x4, speed=2
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000021
ohci1394_0: Got reqTxComplete interrupt status=0x00008052
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x00 ack=0x12 spd=2
data=0x0000000 ctx=0
ohci1394_0: Got RSPkt interrupt status=0x00008451
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
ohci1394_0: Single packet rcv'd
ohci1394_0: Packet received from node 1 ack=0x11 spd=2 tcode=0x6 length=20 ctx=
tlabel=30
ieee1394: received packet: ffc00160 ffc10000 00000000 31333934
ieee1394: send packet 400: ffc10140 ffc0ffff f0000414
ohci1394_0: Inserting packet for node 65473, tlabel=0, tcode=0x4, speed=2
ohci1394_0: Waking transmit DMA ctx=0
ohci1394_0: IntEvent: 00000021
ohci1394_0: Got reqTxComplete interrupt status=0x00008052
ohci1394_0: Packet sent to node 1 tcode=0x4 tLabel=0x00 ack=0x12 spd=2
data=0x0000000 ctx=0
ohci1394_0: Got RSPkt interrupt status=0x00008451



Anyway, the previous code ran fine, but I couldn't mount a disk
so it wasn't very useful. I am wondering if this isn't an endian
issue as I see some notes that there are some issues with this.

Has anyone gotten the TOT 1394 drivers running on HHL and PowerPC?
Perhaps there is some other patch I need?

Many thanks in advance.
						-James


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
