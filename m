Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org, mporter@cox.net
From: acurtis@onz.com
Subject: PCI revisited 2.4.17
Date: Thu, 08 Aug 2002 13:25:20 -0700 (PDT)
Message-Id: <20020808132524.10304.h002.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have made the recommended modifications and getting the same results. Look
below for the new configuration and boot log information. Any suggestions are
welcome.

PS: Take a look at the `lspci -v` output at the bottom. The host controller
output is interesting.

==========================

Our board:
Host phys: 0x40000000 - 0x47ffffff =>
Host virt: 0xe0000000 - 0xe0007fff =>
PCI I/O space 0x00000000 - 0x00007fff

Host phys: 0x48000000 - 0x4fffffff =>
PCI Memory space 0x00000000 - 0x07ffffff

PCI phys: 0x40000000 - 0x47ffffff =>
Host Memory 0x00000000 - 0x07ffffff

Host Memory:
phys: 0x00000000
virt: 0xc0000000
size: 0x08000000

PCI BAR: (only 1 bus)
Memory: 0x00000000
I/O: 0x00000000

======================

/* Changed I/O map initilization as follows:
 *  virtual address:  0xe0000000
 *  virtual size:     0x00007fff
 *  PCI memory not mapped at startup, only 32K I/O
 */
isa_io_base 0xe0000000, isa_mem_base 0x48000000, pci_dram_offset 0x40000000
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
m8260_map_io() - io_block_mapping()
Linux version 2.4.17_mvl21-sbc8260 (iseries@HardHat21) (gcc version 2.95.3
20010312
est8260_pci:in sbs8260_find_bridges()

est8260_pci:powerspan_bridge_init
PowerSpan_Bridge_Init()
Setup PCSR registers
setup_powerspan_pci (in): cfg_addr=0xfe800290  cfg_data=0xfe800294
setup_powerspan_pci (out): hose->cfg_addr=0xfe800290  hose->cfg_data=0xfe800294
powerspan_bridge_init() complete.
est8260_pci: do pciauto_bus_scan()
PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001
PCI Autoconfig: Found Bus 0, Device 15, Function 0
PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0x7f00
PCI Autoconfig: BAR 0x14, Mem size=0x400, address=0x7fffc00
PCI Autoconfig: BAR 0x18, Mem size=0x2000, address=0x7ffc000
est8260_pci:pciauto_bus_scan done
est8260_pci:powerspan_bridge_init
  PCI_ISA_IO_ADDR  0xe0000000   /* new virtual address */
  PCI_ISA_IO_SIZE  0x00008000   /* new virtual size */
  PCI_ISA_MEM_ADDR 0x48000000
  PCI_ISA_MEM_SIZE 0x08000000
  PCI_DRAM_OFFSET  0x40000000
  _ISA_MEM_BASE    0x48000000
  _IO_BASE         0xe0000000
  hose->io_resource.start  0x00000000
  hose->io_resource.end    0x00007fff
  hose->io_space.start     0x00000000
  hose->io_space.end       0x00007fff
  hose->io_base_phys       0x40000000
  hose->io_base_virt       0xe0000000
  isa_io_base              0xe0000000
  hose->mem_resources[0].start    0x48000000
  hose->mem_resources[0].end      0x4fffffff
  hose->mem_space.start           0x00000000
  hose->mem_space.end             0x07ffffff
  hose->pci_mem_offset            0x48000000
  isa_mem_base                    0x48000000
  pci_dram_offset                 0x40000000
PCI: Probing PCI hardware
pcibios_fixup_resources()
Fixup res 1 (200) of dev 00:00.0: 30000000 -> 78000000
Fixup res 2 (1208) of dev 00:00.0: 40000000 -> 88000000
pcibios_fixup_resources()
/*
 * Note: No I/O fixup here !
 */
Fixup res 1 (200) of dev 00:0f.0: 7fffc00 -> 4ffffc00
Fixup res 2 (200) of dev 00:0f.0: 7ffc000 -> 4fffc000
pcibios_fixup_bus()
Installing Powerspan ERROR handler

PCI ERRCS: MultiErr Cmd: 0xa AERR:0x0002000c
  P1CSR: Rcv_MstrAbort
  P1err: PB_ERR
pcibios_allocate_bus_resources()
pcibios_allocate_bus_resources()
pcibios_allocate_resources()
PCI:00:00.0: Resource 1: 78000000-78000fff (f=200)
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI:00:00.0: Resource 2: 88000000-97ffffff (f=1208)
PCI: Cannot allocate resource region 2 of device 00:00.0
PCI:00:0f.0: Resource 0: 00007f00-00007fff (f=101)
PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=200)
PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=200)
pcibios_allocate_resources()
pcibios_assign_resources()
  PCI class: 0x0680
pcibios_update_resource()
/*
 * Not sure what this is about
 */
PCI: Failed to allocate resource 2(50000000-4fffffff) for 00:00.0

  PCI class: 0x0100
/*
 * sym53c8xx - version 2 initialization output
 */
SCSI subsystem driver Revision: 1.00
sym.0.15.0: setting PCI_COMMAND_PARITY...
sym0: <895a> rev 0x1 on pci bus 0 device 15 function 0 irq 19
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
CACHE TEST FAILED: DMA error (dstat=0x81).sym0: CACHE INCORRECTLY CONFIGURED.
sym0: giving up ...
/*
 * sym53c8xx - version 1 initialization output
 *             (different build, not in same kernel)
 */
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 15, function 0
sym53c8xx: 0x07fffc00 = pci_get_base_address(base)
sym53c8xx: 0x07ffc000 = pci_get_base_address(base_2)
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c895a detected
sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
sym53c8xx: device->slot.base = 0x07fffc00
sym53c8xx: device->slot.base_2 = 0x07ffc000
sym53c895a-0: ID 7, Fast-40, Parity Checking
sym53c8xx: 0x404ba000 = vtobus(0xc04ba000)
sym53c8xx: 0x404bd800 = vtobus(0xc04bd800)
sym53c8xx: np->base2_ba = 0x07ffc000
sym53c8xx: 0xc9002000 = remap_pci_mem(0x4fffc000, 0x00002000)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
sym53c8xx: enter ncr_regtest()
sym53c8xx: snooptest() pc = 0x404bddc0, np->reg = 0xc9000c00
CACHE TEST FAILED: DMA error (dstat=0x81).
  snooptest = 0x404bddc0, pc = 0x404bc008, end = 0x404bdde0
  dmode = 0x00, dcntl = 0x00, ccntl0 = 0x00, ccntl1 = 0x00
CACHE INCORRECTLY CONFIGURED.
sym53c895a-0: giving up ...

/*
 * Look at the bridge resource list....?
 */
root@191.1.1.30:~# lspci -v
00:00.0 Bridge: Tundra Semiconductor Corp. CA91L8200 [PowerSpan]
        Subsystem: Unknown device babe:bead
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
        [virtual] Memory at 48000000 (32-bit, non-prefetchable) [size=4K]
        Memory at 50000000 (32-bit, prefetchable)
        Capabilities: [e4] #06 [0000]

00:0f.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895a (rev
01)
        Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
        Flags: bus master, medium devsel, latency 128, IRQ 19
        I/O ports at 7f00 [size=256]
        Memory at 4ffffc00 (32-bit, non-prefetchable) [size=1K]
        Memory at 4fffc000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
