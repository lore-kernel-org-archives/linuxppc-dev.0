Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: PCI enlightenment follow-up
Date: Tue, 6 Aug 2002 21:46:08 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEHCDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Can anyone tell me what is wrong with the following PCI configuration. The
board configuration and the corresponding boot log has been attached. There
must be a subtle error that I just can not see. At the end of the boot
messages you will find sym53c8xx SCSI device driver initialization messages.
They are not both included in the same build but included here for
completeness.

TIA

BTW: Thanks for all the feedback!

======= Board specs ========
Host phys: 0x40000000 - 0x47ffffff	=>
PCI I/O space 0x00000000 - 0x07ffffff

Host phys: 0x48000000 - 0x4fffffff =>
PCI Memory space 0x00000000 - 0x07ffffff

PCI phys: 0x40000000 -  0x47ffffff =>
Host Memory 0x00000000 - 0x07ffffff

Host Memory:
phys: 0x00000000
virt: 0xc0000000
size: 0x08000000

PCI BAR: (only 1 bus)
Memory: 0x00000000
I/O:    0x00000000

========== Boot Messages ===========
isa_io_base 0x00000000, isa_mem_base 0x48000000, pci_dram_offset 0x40000000
est8260_pci:in sbs8260_find_bridges()
est8260_pci:powerspan_bridge_init
PowerSpan_Bridge_Init()
Setup PCSR registers
setup_powerspan_pci (in): cfg_addr=0xfe800290  cfg_data=0xfe800294
setup_powerspan_pci (out): hose->cfg_addr=0xfe800290
hose->cfg_data=0xfe800294
powerspan_bridge_init() complete.
io_base_virt = 40000000 /* phys == virt due to 1-to-1 BAT mapping for PCI */
est8260_pci: do pciauto_bus_scan()
PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001
PCI Autoconfig: Found Bus 0, Device 15, Function 0
PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0x7ffff00
PCI Autoconfig: BAR 0x14, Mem size=0x400, address=0x7fffc00
PCI Autoconfig: BAR 0x18, Mem size=0x2000, address=0x7ffc000
est8260_pci:pciauto_bus_scan done
est8260_pci:powerspan_bridge_init
  PCI_ISA_IO_ADDR  0x40000000
  PCI_ISA_IO_SIZE  0x08000000
  PCI_ISA_MEM_ADDR 0x48000000
  PCI_ISA_MEM_SIZE 0x08000000
  PCI_DRAM_OFFSET  0x40000000
  hose->io_resource.start  0x00000000
  hose->io_resource.end    0x07ffffff
  hose->io_space.start     0x00000000
  hose->io_space.end       0x07ffffff
  hose->io_base_phys       0x40000000
  hose->io_base_virt       0x40000000
  isa_io_base              0x00000000
  hose->mem_resources[0].start    0x48000000
  hose->mem_resources[0].end      0x4fffffff
  hose->mem_space.start           0x00000000
  hose->mem_space.end             0x07ffffff
  hose->pci_mem_offset            0x48000000
  isa_mem_base                    0x48000000
  pci_dram_offset                 0x40000000

/* isa_io_base is 0 above so fixup works
 * if (isa_io_base == hose->io_base_virt)
 *    then offset == 0 in fixup and nothing is done
 */

PCI: Probing PCI hardware
pcibios_fixup_resources()
Fixup res 1 (200) of dev 00:00.0: 30000000 -> 78000000
Fixup res 2 (1208) of dev 00:00.0: 40000000 -> 88000000
pcibios_fixup_resources()
/* If (isa_io_base == io_base_virt) then
 *    the I/O fixup does not happen here.
 */
Fixup res 0 (101) of dev 00:0f.0: 7ffff00 -> 47ffff00
Fixup res 1 (200) of dev 00:0f.0: 7fffc00 -> 4ffffc00
Fixup res 2 (200) of dev 00:0f.0: 7ffc000 -> 4fffc000
pcibios_fixup_bus()
Installing Powerspan ERROR handler
PCI ERRCS: MultiErr Cmd: 0xa AERR:0x0002000c
  P1CSR: Rcv_MstrAbort
  P1err: PB_ERR

/* Now that fixup is done set isa_io_base to hose->io_base_virt */
Setting isa_io_base to 0x40000000

pcibios_allocate_bus_resources()
pcibios_allocate_bus_resources()
pcibios_allocate_resources()

/* These are for the PowerSpan and not necessary for operation */
PCI:00:00.0: Resource 1: 78000000-78000fff (f=200) /* I2O BAR */
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI:00:00.0: Resource 2: 88000000-97ffffff (f=1208) /* Reg BAR from PCI */
PCI: Cannot allocate resource region 2 of device 00:00.0

/* SCSI controller resource allocation is fine */
PCI:00:0f.0: Resource 0: 47ffff00-47ffffff (f=101)
PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=200)
PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=200)
pcibios_allocate_resources()
pcibios_assign_resources()
  PCI class: 0x0680
pcibios_update_resource()

/* Not sure where this is coming from */
PCI: Failed to allocate resource 2(50000000-4fffffff) for 00:00.0
  PCI class: 0x0100

/* ==== sym53c8xx version 2 output ==== */
SCSI subsystem driver Revision: 1.00
sym.0.15.0: setting PCI_COMMAND_PARITY...
sym0: <895a> rev 0x1 on pci bus 0 device 15 function 0 irq 19
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking

/* SCSI initialization fails due to script error, not PCI address access */
CACHE TEST FAILED: DMA error (dstat=0x81).sym0: CACHE INCORRECTLY
CONFIGURED.
sym0: giving up ...

/* ==== sym53c8xx version 1 output ==== */
sym53c8xx: at PCI bus 0, device 15, function 0
sym53c8xx: 0x07fffc00 = pci_get_base_address(base)
sym53c8xx: 0x07ffc000 = pci_get_base_address(base_2)
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c895a detected
sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
sym53c8xx: device->slot.base = 0x07fffc00
sym53c8xx: device->slot.base_2 = 0x07ffc000
sym53c895a-0: ID 7, Fast-40, Parity Checking
/* vtobus() mapping looks ok */
sym53c8xx: 0x404ba000 = vtobus(0xc04ba000)
sym53c8xx: 0x404bd800 = vtobus(0xc04bd800)
sym53c8xx: np->base2_ba = 0x07ffc000
/* 1-to-1 BAT mapping */
sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
/* ncr_regtest() looks ok */
sym53c8xx: enter ncr_regtest()
sym53c8xx: snooptest() pc = 0x404bddc0, np->reg = 0x4ffffc00
CACHE TEST FAILED: DMA error (dstat=0x81).
  snooptest = 0x404bddc0, pc = 0x404bc008, end = 0x404bdde0
  dmode = 0x00, dcntl = 0x00, ccntl0 = 0x00, ccntl1 = 0x00
CACHE INCORRECTLY CONFIGURED.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
