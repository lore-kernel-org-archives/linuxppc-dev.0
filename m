Message-ID: <399BF76E.97108126@mpifr-bonn.mpg.de>
Date: Thu, 17 Aug 2000 16:32:14 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: PCI bus numbering help please
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes I _had_ pcmcia working on the Lombard, then I rsynced Ben's new kernel, and
the chaos started...  With this kernel, plus the small patch to fix three
registers in the CardBus bridge, the PCMCIA package reports both a vendor and a
device id of 0xffff of any inserted card. I think this is a result of the card
being on bus 1, and as max_bus in arch/ppc/kernel/pmac_pci.c is 0, the registers
are simply not read at all. I then tried to increase the bus number in the
routine add_bridges, but this lead to a kernel panic, although the device and
vendor id were read correctly now (see below)...  I assume I have to add the
CardBus bridge, but I have no idea _where_. Any help is welcome!

Albrecht.

pcmcia: Starting PCMCIA services:
pcmcia:  modules
kernel: Linux PCMCIA Card Services 3.1.20
kernel:   kernel build: 2.2.17pre13-ben1 #1 Thu Aug 17 11:38:59 CEST 2000
kernel:   options:  [pci] [cardbus]
kernel: Intel PCIC probe:
kernel:   TI 1211 rev 00 PCI-to-CardBus at slot 00:13, mem 0x80880000
kernel:     host opts [0]: [serial pci & irq] [pci irq 22] [lat 32/176] [bus
1/4]
kernel:     PCI card interrupts, polling interval = 1000 ms
pcmcia:  cardmgr.
rc: Starting pcmcia succeeded
cardmgr[367]: starting, version is 3.1.20
cardmgr[367]: watching 1 sockets
kernel: cs: cb_alloc(bus 1): vendor 0x9004, device 0x6075
cardmgr[367]: initializing socket 0
cardmgr[367]: socket 0: Adaptec APA-1480 SCSI Host Adapter
cardmgr[367]: executing: 'modprobe cb_enabler'
cardmgr[367]: executing: 'modprobe apa1480_cb'
inet: inetd startup succeeded
kernel: cs: cb_config(bus 1)
kernel:   fn 0 bar 1: io 0x1000-0x10ff
kernel:   fn 0 bar 2: mem 0x90030000-0x90030fff
kernel:   fn 0 rom: mem 0x90020000-0x9002ffff
kernel:   irq 22
kernel: apa1480_attach(device 01:00.0)
kernel: Machine check in kernel mode.  (regs at d1bb3450)
kernel: Caused by (from srr1): Unknown values in srr1
kernel: NIP: D886E398 XER: 20000000 LR: D886E378 REGS: d1bb3450 TRAP: 0200
kernel: MSR: 00009030 [EEIRDRME]
kernel: TASK = d1bb2000[367] 'cardmgr' mm->pgd d1bd2000 Last syscall: 54
kernel: last math d1ae6000
kernel: GPR00: 000000FF D1BB3500 D1BB2000 D8846000 D8846000 001FFFC0 C05DED00
C05DED38
kernel: GPR08: 00000008 C0140000 D1DF5CAC D8857000 22244424 10021CA4 00000000
100A4350
kernel: GPR16: 00000000 0000001F D8878AB0 D1BB38BC D1BB3508 00000000 00000000
D1BB3518
kernel: GPR24: 0000001E 0000003C D1DB0D7C D1BB37D8 000002D0 00000000 00000000
D1DBA000
kernel: Call backtrace:
kernel: D886E378 C00D95B8 C00DA174 D885911C D8857520 D8857730 D8830284
kernel: D8831A30 D8857218 D8857060 D884288C D88435F8 C003B6A4 C0003930
kernel: 10002A24 1000312C 100046A0 0FF0B69C 00000000
kernel: Kernel panic: machine check


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
