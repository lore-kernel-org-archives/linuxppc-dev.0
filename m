From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: PCI/SCSI help
Date: Mon, 5 Aug 2002 22:32:09 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEGADKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0011_01C23CCF.EFC7C9E0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0011_01C23CCF.EFC7C9E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am in the process of implementing PowerSpan PCI support into the 8260 PPC
tree. It appears that all the translations are working but when I try to use
the SYM53C8XX SCSI driver, it fails during the script execution for the
snoop test. I have tried both versions of the SCSI driver with the same
results. The ncr_snoop() test terminates with a script execution error.

Below is a log of the boot messages with debug statements. If anything looks
out of the ordinary please let me know.

======== Log messages =========

isa_io_base 0x00000000, isa_mem_base 0x48000000, pci_dram_offset 0x40000000
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
/* BAT setup for PCI base = 0x40000000, len = 0x10000000 */
est8260_pci:in sbs8260_find_bridges()
est8260_pci:powerspan_bridge_init
  EST8260_PCSR_BASE_ADDR 0x30000000
  PCI_ISA_IO_ADDR 0x40000000
  PCI_ISA_IO_SIZE 0x08000000
  PCI_ISA_MEM_ADDR 0x48000000
  PCI_ISA_MEM_SIZE 0x08000000
  PCI_DRAM_OFFSET 0x40000000
est8260_pci:powerspan_bridge_init
Setup PCSR registers
/* PCSR setup moves CSR from 0x30000000 -> 0xfe800000 */
setup_powerspan_pci (in): cfg_addr=0xfe800290  cfg_data=0xfe800294
setup_powerspan_pci (out): hose->cfg_addr=0xfe800290
hose->cfg_data=0xfe800294
powerspan_bridge_init() complete.
io_base_virt = 0x40000000
est8260_pci: do pciauto_bus_scan()
PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001
PCI Autoconfig: Found Bus 0, Device 15, Function 0
PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0x7ffff00
PCI Autoconfig: BAR 0x14, Mem size=0x400, address=0x7fffc00
PCI Autoconfig: BAR 0x18, Mem size=0x2000, address=0x7ffc000
PCI: Probing PCI hardware
pcibios_fixup_resources()
Fixup res 1 (200) of dev 00:00.0: 30000000 -> 78000000
Fixup res 2 (1208) of dev 00:00.0: 40000000 -> 88000000
pcibios_fixup_resources()
Fixup res 0 (101) of dev 00:0f.0: 7ffff00 -> 47ffff00 (I/O)
Fixup res 1 (200) of dev 00:0f.0: 7fffc00 -> 4ffffc00 (Mem)
Fixup res 2 (200) of dev 00:0f.0: 7ffc000 -> 4fffc000 (Mem)
pcibios_allocate_bus_resources()
pcibios_allocate_bus_resources()
pcibios_allocate_resources()
PCI:00:00.0: Resource 1: 78000000-78000fff (f=200)
PCI: Cannot allocate resource region 1 of device 00:00.0 (N/A)
PCI:00:00.0: Resource 2: 88000000-97ffffff (f=1208)
PCI: Cannot allocate resource region 2 of device 00:00.0 (N/A)
PCI:00:0f.0: Resource 0: 47ffff00-47ffffff (f=101)
PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=200)
PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=200)
pcibios_allocate_resources()
pcibios_assign_resources()
  PCI class: 0x0680
pcibios_update_resource()
PCI: Failed to allocate resource 2(50000000-4fffffff) for 00:00.0
  PCI class: 0x0100
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
sym53c8xx: np->base2_ba = 0x07ffc000 /* as read from BAR */
sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0) /* just byte swapping */
sym53c8xx: enter ncr_regtest()
sym53c8xx: snooptest() pc = 0x404bddc0, np->reg = 0x4ffffc00
CACHE TEST FAILED: DMA error (dstat=0x81). /* Script exec error */
  snooptest = 0x404bddc0, pc = 0x404bc008, end = 0x404bdde0
CACHE INCORRECTLY CONFIGURED.
sym53c895a-0: giving up ...

------=_NextPart_000_0011_01C23CCF.EFC7C9E0
Content-Type: text/plain;
	name="pci_scsi.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci_scsi.txt"

isa_io_base 0x00000000, isa_mem_base 0x48000000, pci_dram_offset =
0x40000000                          =0A=
Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb  =0A=
/* BAT setup for PCI base =3D 0x40000000, len =3D 0x10000000 */          =
                                  =0A=
est8260_pci:in sbs8260_find_bridges()=0A=
est8260_pci:powerspan_bridge_init=0A=
  EST8260_PCSR_BASE_ADDR 0x30000000=0A=
  PCI_ISA_IO_ADDR 0x40000000=0A=
  PCI_ISA_IO_SIZE 0x08000000=0A=
  PCI_ISA_MEM_ADDR 0x48000000=0A=
  PCI_ISA_MEM_SIZE 0x08000000=0A=
  PCI_DRAM_OFFSET 0x40000000=0A=
est8260_pci:powerspan_bridge_init=0A=
Setup PCSR registers=0A=
/* PCSR setup moves CSR from 0x30000000 -> 0xfe800000 */=0A=
setup_powerspan_pci (in): cfg_addr=3D0xfe800290  cfg_data=3D0xfe800294=0A=
setup_powerspan_pci (out): hose->cfg_addr=3D0xfe800290  =
hose->cfg_data=3D0xfe800294=0A=
powerspan_bridge_init() complete.=0A=
io_base_virt =3D 0x40000000=0A=
est8260_pci: do pciauto_bus_scan()=0A=
PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001=0A=
PCI Autoconfig: Found Bus 0, Device 15, Function 0=0A=
PCI Autoconfig: BAR 0x10, I/O, size=3D0x100, address=3D0x7ffff00=0A=
PCI Autoconfig: BAR 0x14, Mem size=3D0x400, address=3D0x7fffc00=0A=
PCI Autoconfig: BAR 0x18, Mem size=3D0x2000, address=3D0x7ffc000=0A=
PCI: Probing PCI hardware=0A=
pcibios_fixup_resources()=0A=
Fixup res 1 (200) of dev 00:00.0: 30000000 -> 78000000=0A=
Fixup res 2 (1208) of dev 00:00.0: 40000000 -> 88000000=0A=
pcibios_fixup_resources()=0A=
Fixup res 0 (101) of dev 00:0f.0: 7ffff00 -> 47ffff00 (I/O)=0A=
Fixup res 1 (200) of dev 00:0f.0: 7fffc00 -> 4ffffc00 (Mem)=0A=
Fixup res 2 (200) of dev 00:0f.0: 7ffc000 -> 4fffc000 (Mem)=0A=
pcibios_allocate_bus_resources()=0A=
pcibios_allocate_bus_resources()=0A=
pcibios_allocate_resources()=0A=
PCI:00:00.0: Resource 1: 78000000-78000fff (f=3D200)=0A=
PCI: Cannot allocate resource region 1 of device 00:00.0 (N/A)=0A=
PCI:00:00.0: Resource 2: 88000000-97ffffff (f=3D1208)=0A=
PCI: Cannot allocate resource region 2 of device 00:00.0 (N/A)=0A=
PCI:00:0f.0: Resource 0: 47ffff00-47ffffff (f=3D101)=0A=
PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=3D200)=0A=
PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=3D200)=0A=
pcibios_allocate_resources()=0A=
pcibios_assign_resources()=0A=
  PCI class: 0x0680=0A=
pcibios_update_resource()=0A=
PCI: Failed to allocate resource 2(50000000-4fffffff) for 00:00.0=0A=
  PCI class: 0x0100=0A=
SCSI subsystem driver Revision: 1.00=0A=
sym53c8xx: at PCI bus 0, device 15, function 0=0A=
sym53c8xx: 0x07fffc00 =3D pci_get_base_address(base)=0A=
sym53c8xx: 0x07ffc000 =3D pci_get_base_address(base_2)=0A=
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)=0A=
sym53c8xx: 53c895a detected=0A=
sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19=0A=
sym53c8xx: device->slot.base =3D 0x07fffc00=0A=
sym53c8xx: device->slot.base_2 =3D 0x07ffc000=0A=
sym53c895a-0: ID 7, Fast-40, Parity Checking=0A=
sym53c8xx: 0x404ba000 =3D vtobus(0xc04ba000)=0A=
sym53c8xx: 0x404bd800 =3D vtobus(0xc04bd800)=0A=
sym53c8xx: np->base2_ba =3D 0x07ffc000 /* as read from BAR */=0A=
sym53c8xx: 0x4fffc000 =3D remap_pci_mem(0x4fffc000, 0x00002000)=0A=
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)=0A=
sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)=0A=
sym53c8xx: 0xf0ccff07 =3D cpu_to_scr(0x07ffccf0) /* just byte swapping =
*/                                              =0A=
sym53c8xx: enter ncr_regtest()=0A=
sym53c8xx: snooptest() pc =3D 0x404bddc0, np->reg =3D 0x4ffffc00         =
                                =0A=
CACHE TEST FAILED: DMA error (dstat=3D0x81). /* Script exec error */=0A=
  snooptest =3D 0x404bddc0, pc =3D 0x404bc008, end =3D 0x404bdde0=0A=
CACHE INCORRECTLY CONFIGURED.=0A=
sym53c895a-0: giving up ...=0A=

------=_NextPart_000_0011_01C23CCF.EFC7C9E0--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
