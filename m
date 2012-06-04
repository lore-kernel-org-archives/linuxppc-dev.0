Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc4-s23.blu0.hotmail.com (blu0-omc4-s23.blu0.hotmail.com
 [65.55.111.162]) by ozlabs.org (Postfix) with ESMTP id AAB86B6FBA
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2012 19:30:55 +1000 (EST)
Message-ID: <BLU124-W2698234E7804847D67B76EB40F0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_65f48cb2-51eb-451e-a074-e3ca2f62ba40_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: NIC bring-up issue on powerpc-440 based board
Date: Mon, 4 Jun 2012 09:25:47 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_65f48cb2-51eb-451e-a074-e3ca2f62ba40_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All=2C
I'm trying to bring-up a PCIe based NIC(e1000e) card on a PowerPC-440 based=
 board=2C I'm able to list this device under lspci from the user space=2C b=
ut the driver probe fails and looks like mmio mapping doesn't look right. F=
ollowing is the bootlog of the kernel. Can anyone point out what is going w=
rong here? The kernel is a relocatable one and system memory is mapped at 0=
x5000_0000 to 0x6000_0000
I dont have a serial console=2C I use ttyprintk to get the userspace prints=
 (on dmesg).

<6>[    0.000000] Using XXX machine description<5>[    0.000000] Linux vers=
ion 3.3.0-rc2 (root@sumeshkn) (gcc version 4.4.6 20110214 (4.4.5-6) (GCC) )=
 #125 PREEMPT Mon Jun 4 04:51:02 EDT 2012<7>[    0.000000] Found initrd at =
0xc0937000:0xc0d8803b<7>[    0.000000] Top of RAM: 0x60000000=2C Total RAM:=
 0x10000000<7>[    0.000000] Memory hole size: 1280MB<7>[    0.000000] Zone=
 PFN ranges:<7>[    0.000000]   DMA      0x00050000 -> 0x00060000<7>[    0.=
000000]   Normal   empty<7>[    0.000000]   HighMem  empty<7>[    0.000000]=
 Movable zone start PFN for each node<7>[    0.000000] Early memory PFN ran=
ges<7>[    0.000000]     0: 0x00050000 -> 0x00060000<7>[    0.000000] On no=
de 0 totalpages: 65536<7>[    0.000000] free_area_init_node: node 0=2C pgda=
t c026d258=2C node_mem_map c02b0000<7>[    0.000000]   DMA zone: 512 pages =
used for memmap<7>[    0.000000]   DMA zone: 0 pages reserved<7>[    0.0000=
00]   DMA zone: 65024 pages=2C LIFO batch:15<6>[    0.000000] MMU: Allocate=
d 1088 bytes of context maps for 255 contexts<7>[    0.000000] pcpu-alloc: =
s0 r0 d32768 u32768 alloc=3D1*32768<7>[    0.000000] pcpu-alloc: [0] 0 <7>[=
    0.000000] Built 1 zonelists in Zone order=2C mobility grouping on.  Tot=
al pages: 65024<5>[    0.000000] Kernel command line: root=3D/dev/ram<6>[  =
  0.000000] PID hash table entries: 1024 (order: 0=2C 4096 bytes)<6>[    0.=
000000] Dentry cache hash table entries: 32768 (order: 5=2C 131072 bytes)<6=
>[    0.000000] Inode-cache hash table entries: 16384 (order: 4=2C 65536 by=
tes)<7>[    0.000000] High memory: 0k<6>[    0.000000] Memory: 252632k/2621=
44k available (2372k kernel code=2C 9512k reserved=2C 148k data=2C 222k bss=
=2C 160k init)<6>[    0.000000] Kernel virtual memory layout:<6>[    0.0000=
00]   * 0xfffcf000..0xfffff000  : fixmap<6>[    0.000000]   * 0xffc00000..0=
xffe00000  : highmem PTEs<6>[    0.000000]   * 0xffa00000..0xffc00000  : co=
nsistent mem<6>[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap<6=
>[    0.000000]   * 0xd1000000..0xffa00000  : vmalloc & ioremap<6>[    0.00=
0000] NR_IRQS:512<6>[    0.000000] kmemleak: Kernel memory leak detector di=
sabled<7>[    0.000000] time_init: decrementer frequency =3D 166.666667 MHz=
<7>[    0.000000] time_init: processor frequency   =3D 666.666664 MHz<6>[  =
  0.000000] clocksource: timebase mult[6000000] shift[24] registered<7>[   =
 0.000000] clockevent: decrementer mult[2aaaaaac] shift[32] cpu[0]<6>[    0=
.000000] Console: colour dummy device 80x25<6>[    0.000000] console [tty0]=
 enabled<4>[    0.000000] kmemleak: Early log buffer exceeded (907)=2C plea=
se increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE<6>[    0.000061] pid_max: default=
: 32768 minimum: 301<6>[    0.000085] Mount-cache hash table entries: 512<6=
>[    0.000279] NET: Registered protocol family 16<6>[    0.104014] PCI hos=
t bridge /pciex (primary) ranges:<6>[    0.104017]  MEM 0x0000000080000000.=
.0x000000009fffffff -> 0x0000000080000000 <6>[    0.104019]   IO 0x00000000=
b0000000..0x00000000b00fffff -> 0x0000000000000000<6>[    0.104029] PCIE0: =
successfully set as root-complex<6>[    0.104072] PCI: Probing PCI hardware=
<7>[    0.104075] PCI: Scanning PHB /pciex<7>[    0.104076] PCI: PHB IO res=
ource    =3D 0000000000000000-00000000000fffff [100]<7>[    0.104077] PCI: =
PHB MEM resource 0 =3D 0000000080000000-000000009fffffff [200]<7>[    0.104=
077] PCI: PHB MEM offset     =3D 0000000000000000<7>[    0.104078] PCI: PHB=
 IO  offset     =3D 00000000<6>[    0.104110] PCI host bridge to bus 0000:0=
0<6>[    0.104113] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]<=
6>[    0.104115] pci_bus 0000:00: root bus resource [mem 0x80000000-0x9ffff=
fff]<7>[    0.104116] pci-common-    probe mode: 0<7>[    0.104117] pci_bus=
 0000:00: PCI_DRIVER: pci_scanning_bus<7>[    0.104119] PCI_DRIVER: pci_set=
up_device <7>[    0.104121] pci 0000:00:00.0: PCI_DRIVER [8086:105e] type 0=
 class 0x000200<7>[    0.104121] pci 0000:00:00.0: pci_cfg_space_size -befo=
re<7>[    0.104122] pci 0000:00:00.0: pci_cfg_space_size - after<7>[    0.1=
04122] PCI_DRIVER: pci_fixup_device<7>[    0.104123] PCI_DRIVER: case pci_f=
ixup_early<7>[    0.104124] pci 0000:00:00.0: calling fixup_xxx+0x0/0x64<7>=
[    0.104125] XXX_FIXUP_EARLY: vendor : 8086=2C device: 105e<7>[    0.1041=
26] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0x24<7>[    0.104127=
] pci 0000:00:00.0: pci_fxup_device (pci_fixup_early)<7>[    0.104127] PCI_=
DRIVER: pci_read_bases:vendor:8086=2Cdevice:105e  Pos : 0x0=2C Reg:0x10<7>[=
    0.104128] pci 0000:00:00.0: reg 10: [mem 0x80000000-0x8001ffff]<7>[    =
0.104129] PCI_DRIVER: pci_read_bases:vendor:8086=2Cdevice:105e  Pos : 0x1=
=2C Reg:0x14<7>[    0.104130] pci 0000:00:00.0: reg 14: [mem 0x00000000-0x0=
001ffff]<7>[    0.104130] PCI_DRIVER: pci_read_bases:vendor:8086=2Cdevice:1=
05e  Pos : 0x2=2C Reg:0x18<7>[    0.104131] pci 0000:00:00.0: reg 18: [io  =
0x0000-0x001f]<7>[    0.104132] PCI_DRIVER: pci_read_bases:vendor:8086=2Cde=
vice:105e  Pos : 0x3=2C Reg:0x1c<7>[    0.104132] PCI_DRIVER: pci_read_base=
s:vendor:8086=2Cdevice:105e  Pos : 0x4=2C Reg:0x20<7>[    0.104133] PCI_DRI=
VER: pci_read_bases:vendor:8086=2Cdevice:105e  Pos : 0x5=2C Reg:0x24<7>[   =
 0.104134] pci 0000:00:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]<7>[  =
  0.104135] PCI_DRIVER: pci_fixup_device<7>[    0.104135] PCI_DRIVER: case =
pci_fixup_header<7>[    0.104136] pci 0000:00:00.0: calling pcibios_fixup_r=
esources+0x0/0x284<7>[    0.104143] PCI:0000:00:00.0 Resource 0 00000000800=
00000-000000008001ffff [40200] fixup...<7>[    0.104143] PCI:0000:00:00.0  =
          0000000080000000-000000008001ffff<7>[    0.104146] PCI:0000:00:00=
.0 Resource 1 0000000000000000-000000000001ffff [40200] fixup...<7>[    0.1=
04146] PCI:0000:00:00.0            0000000000000000-000000000001ffff<7>[   =
 0.104149] PCI:0000:00:00.0 Resource 2 0000000000000000-000000000000001f [4=
0101] fixup...<7>[    0.104150] PCI:0000:00:00.0            000000000000000=
0-000000000000001f<7>[    0.104152] PCI:0000:00:00.0 Resource 6 00000000000=
00000-000000000001ffff [4e200] fixup...<7>[    0.104153] PCI:0000:00:00.0  =
          0000000000000000-000000000001ffff<7>[    0.104154] pci 0000:00:00=
.0: calling fixup_ppc4xx_pci_bridge+0x0/0x14c<6>[    0.104156] PCI: Hiding =
4xx host bridge resources 0000:00:00.0<7>[    0.104158] pci 0000:00:00.0: c=
alling quirk_resource_alignment+0x0/0x1d4<7>[    0.104160] pci 0000:00:00.0=
: PME# supported from D0 D3hot D3cold<7>[    0.104161] pci 0000:00:00.0: PM=
E# disabled<7>[    0.104162] PCI_DRIVER: pci_scan_single_device <7>[    0.1=
04163] PCI_DRIVER: pci_scan_slotPCI_DRIVER: pci_scan_slot: Done<7>[    0.10=
4164] fixups for bus<7>[    0.104164] PCI: Fixup bus devices 0 (PHB)<7>[   =
 0.104165] PCI: Try to map irq for 0000:00:00.0...<7>[    0.104166] pci 000=
0:00:00.0: scanning [bus 00-00] behind bridge=2C pass 0<7>[    0.104167] pc=
i 0000:00:00.0: bus configuration invalid=2C reconfiguring<7>[    0.104167]=
 pci 0000:00:00.0: scanning [bus 00-00] behind bridge=2C pass 1<7>[    0.10=
4171] pci_bus 0000:01: PCI_DRIVER: pci_scanning_bus<7>[    0.104172] PCI_DR=
IVER: pci_scan_slot: Done<7>[    0.104172] fixups for bus<6>[    0.104173] =
pci 0000:00:00.0: PCI bridge to [bus 01-ff]<7>[    0.104174] PCI: Fixup bus=
 devices 1 (0000:00:00.0)<7>[    0.104175] pci_bus 0000:01: bus scan return=
ing with max=3D01<7>[    0.104176] pci_bus 0000:00: bus scan returning with=
 max=3D01<7>[    0.104176] pci-common-    pcibios_scan_phb : Done<7>[    0.=
104239] PCI: Allocating bus resources for 0000:00...<7>[    0.104240] PCI: =
PHB (bus 0) bridge rsrc 4: 0000000000000000-00000000000fffff [0x100]=2C par=
ent c0255db0 (PCI IO)<7>[    0.104241] PCI: PHB (bus 0) bridge rsrc 5: 0000=
000080000000-000000009fffffff [0x200]=2C parent c0255d88 (PCI mem)<7>[    0=
.104242] PCI: Allocating bus resources for 0000:01...<6>[    0.104961] bio:=
 create slab <bio-0> at 0<6>[    0.105072] vgaarb: loaded<6>[    0.105221] =
Switching to clocksource timebase<7>[    0.107533] PCI_QUIRKS : pci_apply_f=
inal_quirks<7>[    0.107534] PCI_DRIVER: pci_fixup_device<7>[    0.107534] =
PCI_DRIVER: case pci_fixup_final <7>[    0.107536] pci 0000:00:00.0: callin=
g quirk_e100_interrupt+0x0/0x1b0<7>[    0.107538] pci 0000:00:00.0: calling=
 quirk_cardbus_legacy+0x0/0x50<7>[    0.107539] pci 0000:00:00.0: calling q=
uirk_usb_early_handoff+0x0/0x718<7>[    0.107540] PCI: CLS 128 bytes=2C def=
ault 32<6>[    0.107647] Trying to unpack rootfs image as initramfs...<6>[ =
   0.108413] rootfs image is not initramfs (no cpio magic)=3B looks like an=
 initrd<6>[    0.110225] Freeing initrd memory: 4424k freed<6>[    0.110462=
] msgmni has been set to 502<6>[    0.110471] io scheduler noop registered<=
6>[    0.110472] io scheduler deadline registered<6>[    0.110478] io sched=
uler cfq registered (default)<6>[    0.128194] brd: module loaded<6>[    0.=
128860] loop: module loaded<6>[    0.128864] e1000e: Intel(R) PRO/1000 Netw=
ork Driver - 1.5.1-k<6>[    0.128865] e1000e: Copyright(c) 1999 - 2011 Inte=
l Corporation.<6>[    0.128870] e1000e 0000:00:00.0: Disabling ASPM  L1<7>[=
    0.128871] PCI_DRIVER: pci_fixup_device<7>[    0.128872] PCI_DRIVER: cas=
e pci_fixup_enable<7>[    0.128873] e1000e 0000:00:00.0: enabling bus maste=
ring<7>[    0.128895] e1000e DRIVER probe: mmio_start: cf9bc000=2C mmio_len=
: 0<7>[    0.128896] __ioremap(): phys addr 0x0 is RAM lr c01c6bf0<4>[    0=
.128899] e1000e: probe of 0000:00:00.0 failed with error -5<5>[    0.128993=
] RAMDISK: gzip image found at block 0<6>[    0.178833] VFS: Mounted root (=
ext2 filesystem) on device 1:0.<6>[    0.178924] Freeing unused kernel memo=
ry: 160k freed<6>[    0.178957] Executing /sbin/init<6>[    0.181707] [U] l=
spci -xxx :<6>[    0.183257] [U] 00:00.0 Class 0200: Device 8086:105e (rev =
06)<6>[    0.183268] [U] 00: 86 80 5e 10 00 00 10 00 06 00 00 02 20 00 80 0=
0<6>[    0.183271] [U] 10: 00 00 00 80 00 00 00 00 01 01 01 00 00 00 00 00<=
6>[    0.183274] [U] 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 40 03<6>=
[    0.183277] [U] 30: 00 00 00 00 c8 00 00 00 00 00 00 00 00 01 00 00<6>[ =
   0.183280] [U] 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[   =
 0.183283] [U] 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0=
.183285] [U] 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.1=
83288] [U] 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183=
291] [U] 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.18329=
4] [U] 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183296]=
 [U] a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183299] [=
U] b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183302] [U]=
 c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 21<6>[    0.183305] [U] d=
0: 05 e0 80 00 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183307] [U] e0:=
 10 00 01 00 c1 0c 00 00 10 28 10 00 41 64 03 00<6>[    0.183310] [U] f0: 0=
0 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00<6>[    0.183312] [U] <6>[   =
 0.184285] [U] lspci -vvv :<6>[    0.185108] [U] 00:00.0 Class 0200: Device=
 8086:105e (rev 06)<6>[    0.185113] [U] 	Subsystem: Device 1014:0340<6>[  =
  0.185115] [U] 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop=
- ParErr- Stepping- SERR- FastB2B- DisINTx-<6>[    0.185119] [U] 	Status: C=
ap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >=
SERR- <PERR- INTx-<6>[    0.185121] [U] 	Interrupt: pin A routed to IRQ 0<6=
>[    0.185124] [U] 	Region 0: Memory at <ignored> (32-bit=2C non-prefetcha=
ble) [disabled]<6>[    0.185126] [U] 	Region 2: I/O ports at <ignored> [dis=
abled]<6>[    0.185131] [U] 	Capabilities: [c8] Power Management version 2<=
6>[    0.185134] [U] 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+=
=2CD1-=2CD2-=2CD3hot+=2CD3cold+)<6>[    0.185137] [U] 		Status: D0 NoSoftRs=
t- PME-Enable- DSel=3D0 DScale=3D1 PME-<6>[    0.185139] [U] 	Capabilities:=
 [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+<6>[    0.185142] [U] 		Addr=
ess: 0000000000000000  Data: 0000<6>[    0.185144] [U] 	Capabilities: [e0] =
Express (v1) Endpoint=2C MSI 00<6>[    0.185147] [U] 		DevCap:	MaxPayload 2=
56 bytes=2C PhantFunc 0=2C Latency L0s <512ns=2C L1 <64us<6>[    0.185150] =
[U] 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-<6>[    0.185152] [U]=
 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-<6>[  =
  0.185154] [U] 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+<6>[    0.18=
5156] [U] 			MaxPayload 128 bytes=2C MaxReadReq 512 bytes<6>[    0.185158] =
[U] 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-<6=
>[    0.185161] [U] 		LnkCap:	Port #0=2C Speed 2.5GT/s=2C Width x4=2C ASPM =
L0s=2C Latency L0 <4us=2C L1 <64us<6>[    0.185164] [U] 			ClockPM- Surpris=
e- LLActRep- BwNot-<6>[    0.185166] [U] 		LnkCtl:	ASPM Disabled=3B RCB 64 =
bytes Disabled- Retrain- CommClk-<6>[    0.185168] [U] 			ExtSynch- ClockPM=
- AutWidDis- BWInt- AutBWInt-<6>[    0.185170] [U] 		LnkSta:	Speed 2.5GT/s=
=2C Width x4=2C TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-<6>[    0.=
185175] [U] 	Capabilities: [100 v1] Advanced Error Reporting<6>[    0.18517=
8] [U] 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Ma=
lfTLP- ECRC- UnsupReq- ACSViol-<6>[    0.185182] [U] 		UEMsk:	DLP- SDES- TL=
P- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSVio=
l-<6>[    0.185185] [U] 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<6>[    0.185188] [U] 		CE=
Sta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-<6>[    0.18519=
0] [U] 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-<6>[=
    0.185193] [U] 		AERCap:	First Error Pointer: 00=2C GenCap- CGenEn- ChkC=
ap- ChkEn-<6>[    0.185196] [U] 	Capabilities: [140 v1] Device Serial Numbe=
r e4-1f-13-ff-ff-51-06-82<6>[    0.185206] [U]=20


Regards=2CSumesh 		 	   		  =

--_65f48cb2-51eb-451e-a074-e3ca2f62ba40_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<div>Hi All=2C</div><div><br></div><div>I'm trying to bring-up a PCIe based=
 NIC(e1000e) card on a PowerPC-440 based board=2C I'm able to list this dev=
ice under lspci from the user space=2C but the driver probe fails and looks=
 like mmio mapping doesn't look right. Following is the bootlog of the kern=
el. Can anyone point out what is going wrong here? The kernel is a relocata=
ble one and system memory is mapped at 0x5000_0000 to 0x6000_0000</div><div=
><br></div><div>I dont have a serial console=2C I use ttyprintk to get the =
userspace prints (on dmesg).</div><div><br></div><div><br></div><div>&lt=3B=
6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Using XXX machine description</div><div=
>&lt=3B5&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Linux version 3.3.0-rc2 (root@su=
meshkn) (gcc version 4.4.6 20110214 (4.4.5-6) (GCC) ) #125 PREEMPT Mon Jun =
4 04:51:02 EDT 2012</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Fou=
nd initrd at 0xc0937000:0xc0d8803b</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.000000] Top of RAM: 0x60000000=2C Total RAM: 0x10000000</div><div>&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Memory hole size: 1280MB</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Zone PFN ranges:</div><div>&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B DMA &nbsp=3B &nbsp=3B &nbsp=3B0=
x00050000 -&gt=3B 0x00060000</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.00=
0000] &nbsp=3B Normal &nbsp=3B empty</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbs=
p=3B0.000000] &nbsp=3B HighMem &nbsp=3Bempty</div><div>&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.000000] Movable zone start PFN for each node</div><div>&lt=3B=
7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Early memory PFN ranges</div><div>&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B &nbsp=3B 0: 0x00050000 -&gt=
=3B 0x00060000</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] On node =
0 totalpages: 65536</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] fre=
e_area_init_node: node 0=2C pgdat c026d258=2C node_mem_map c02b0000</div><d=
iv>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B DMA zone: 512 pages u=
sed for memmap</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B=
 DMA zone: 0 pages reserved</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000=
000] &nbsp=3B DMA zone: 65024 pages=2C LIFO batch:15</div><div>&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.000000] MMU: Allocated 1088 bytes of context maps f=
or 255 contexts</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] pcpu-al=
loc: s0 r0 d32768 u32768 alloc=3D1*32768</div><div>&lt=3B7&gt=3B[ &nbsp=3B =
&nbsp=3B0.000000] pcpu-alloc: [0] 0&nbsp=3B</div><div>&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.000000] Built 1 zonelists in Zone order=2C mobility grouping =
on. &nbsp=3BTotal pages: 65024</div><div>&lt=3B5&gt=3B[ &nbsp=3B &nbsp=3B0.=
000000] Kernel command line: root=3D/dev/ram</div><div>&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.000000] PID hash table entries: 1024 (order: 0=2C 4096 bytes)=
</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Dentry cache hash tabl=
e entries: 32768 (order: 5=2C 131072 bytes)</div><div>&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.000000] Inode-cache hash table entries: 16384 (order: 4=2C 65=
536 bytes)</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] High memory:=
 0k</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Memory: 252632k/262=
144k available (2372k kernel code=2C 9512k reserved=2C 148k data=2C 222k bs=
s=2C 160k init)</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Kernel =
virtual memory layout:</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] =
&nbsp=3B * 0xfffcf000..0xfffff000 &nbsp=3B: fixmap</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.000000] &nbsp=3B * 0xffc00000..0xffe00000 &nbsp=3B: hig=
hmem PTEs</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B * 0x=
ffa00000..0xffc00000 &nbsp=3B: consistent mem</div><div>&lt=3B6&gt=3B[ &nbs=
p=3B &nbsp=3B0.000000] &nbsp=3B * 0xffa00000..0xffa00000 &nbsp=3B: early io=
remap</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B * 0xd100=
0000..0xffa00000 &nbsp=3B: vmalloc &amp=3B ioremap</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.000000] NR_IRQS:512</div><div>&lt=3B6&gt=3B[ &nbsp=3B &=
nbsp=3B0.000000] kmemleak: Kernel memory leak detector disabled</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] time_init: decrementer frequency =
=3D 166.666667 MHz</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] time=
_init: processor frequency &nbsp=3B =3D 666.666664 MHz</div><div>&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.000000] clocksource: timebase mult[6000000] shift[2=
4] registered</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] clockeven=
t: decrementer mult[2aaaaaac] shift[32] cpu[0]</div><div>&lt=3B6&gt=3B[ &nb=
sp=3B &nbsp=3B0.000000] Console: colour dummy device 80x25</div><div>&lt=3B=
6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] console [tty0] enabled</div><div>&lt=3B=
4&gt=3B[ &nbsp=3B &nbsp=3B0.000000] kmemleak: Early log buffer exceeded (90=
7)=2C please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE</div><div>&lt=3B6&gt=3B=
[ &nbsp=3B &nbsp=3B0.000061] pid_max: default: 32768 minimum: 301</div><div=
>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000085] Mount-cache hash table entries: =
512</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000279] NET: Registered pro=
tocol family 16</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104014] PCI hos=
t bridge /pciex (primary) ranges:</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.104017] &nbsp=3BMEM 0x0000000080000000..0x000000009fffffff -&gt=3B 0x0=
000000080000000&nbsp=3B</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104019]=
 &nbsp=3B IO 0x00000000b0000000..0x00000000b00fffff -&gt=3B 0x0000000000000=
000</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104029] PCIE0: successfully=
 set as root-complex</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104072] PC=
I: Probing PCI hardware</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104075]=
 PCI: Scanning PHB /pciex</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.10407=
6] PCI: PHB IO resource &nbsp=3B &nbsp=3B=3D 0000000000000000-00000000000ff=
fff [100]</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104077] PCI: PHB MEM =
resource 0 =3D 0000000080000000-000000009fffffff [200]</div><div>&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.104077] PCI: PHB MEM offset &nbsp=3B &nbsp=3B =3D 0=
000000000000000</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104078] PCI: PH=
B IO &nbsp=3Boffset &nbsp=3B &nbsp=3B =3D 00000000</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.104110] PCI host bridge to bus 0000:00</div><div>&lt=3B=
6&gt=3B[ &nbsp=3B &nbsp=3B0.104113] pci_bus 0000:00: root bus resource [io =
&nbsp=3B0x0000-0xfffff]</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104115]=
 pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104116] pci-common- &nbsp=3B &nbsp=3Bprobe=
 mode: 0</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104117] pci_bus 0000:0=
0: PCI_DRIVER: pci_scanning_bus</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0=
.104119] PCI_DRIVER: pci_setup_device&nbsp=3B</div><div>&lt=3B7&gt=3B[ &nbs=
p=3B &nbsp=3B0.104121] pci 0000:00:00.0: PCI_DRIVER [8086:105e] type 0 clas=
s 0x000200</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104121] pci 0000:00:=
00.0: pci_cfg_space_size -before</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B=
0.104122] pci 0000:00:00.0: pci_cfg_space_size - after</div><div>&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.104122] PCI_DRIVER: pci_fixup_device</div><div>&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104123] PCI_DRIVER: case pci_fixup_early</di=
v><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104124] pci 0000:00:00.0: calling =
fixup_xxx+0x0/0x64</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104125] XXX_=
FIXUP_EARLY: vendor : 8086=2C device: 105e</div><div>&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.104126] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0x=
24</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104127] pci 0000:00:00.0: pc=
i_fxup_device (pci_fixup_early)</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0=
.104127] PCI_DRIVER: pci_read_bases:vendor:8086=2Cdevice:105e &nbsp=3BPos :=
 0x0=2C Reg:0x10</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104128] pci 00=
00:00:00.0: reg 10: [mem 0x80000000-0x8001ffff]</div><div>&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.104129] PCI_DRIVER: pci_read_bases:vendor:8086=2Cdevice:10=
5e &nbsp=3BPos : 0x1=2C Reg:0x14</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B=
0.104130] pci 0000:00:00.0: reg 14: [mem 0x00000000-0x0001ffff]</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104130] PCI_DRIVER: pci_read_bases:vendor:=
8086=2Cdevice:105e &nbsp=3BPos : 0x2=2C Reg:0x18</div><div>&lt=3B7&gt=3B[ &=
nbsp=3B &nbsp=3B0.104131] pci 0000:00:00.0: reg 18: [io &nbsp=3B0x0000-0x00=
1f]</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104132] PCI_DRIVER: pci_rea=
d_bases:vendor:8086=2Cdevice:105e &nbsp=3BPos : 0x3=2C Reg:0x1c</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104132] PCI_DRIVER: pci_read_bases:vendor:=
8086=2Cdevice:105e &nbsp=3BPos : 0x4=2C Reg:0x20</div><div>&lt=3B7&gt=3B[ &=
nbsp=3B &nbsp=3B0.104133] PCI_DRIVER: pci_read_bases:vendor:8086=2Cdevice:1=
05e &nbsp=3BPos : 0x5=2C Reg:0x24</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.104134] pci 0000:00:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]</di=
v><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104135] PCI_DRIVER: pci_fixup_devi=
ce</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104135] PCI_DRIVER: case pci=
_fixup_header</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104136] pci 0000:=
00:00.0: calling pcibios_fixup_resources+0x0/0x284</div><div>&lt=3B7&gt=3B[=
 &nbsp=3B &nbsp=3B0.104143] PCI:0000:00:00.0 Resource 0 0000000080000000-00=
0000008001ffff [40200] fixup...</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0=
.104143] PCI:0000:00:00.0 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B0000000080000000-000000008001ffff</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nb=
sp=3B0.104146] PCI:0000:00:00.0 Resource 1 0000000000000000-000000000001fff=
f [40200] fixup...</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104146] PCI:=
0000:00:00.0 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B000000000=
0000000-000000000001ffff</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104149=
] PCI:0000:00:00.0 Resource 2 0000000000000000-000000000000001f [40101] fix=
up...</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104150] PCI:0000:00:00.0 =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B0000000000000000-00000=
0000000001f</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104152] PCI:0000:00=
:00.0 Resource 6 0000000000000000-000000000001ffff [4e200] fixup...</div><d=
iv>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104153] PCI:0000:00:00.0 &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B0000000000000000-000000000001ffff</=
div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104154] pci 0000:00:00.0: callin=
g fixup_ppc4xx_pci_bridge+0x0/0x14c</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.104156] PCI: Hiding 4xx host bridge resources 0000:00:00.0</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104158] pci 0000:00:00.0: calling quirk_re=
source_alignment+0x0/0x1d4</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.1041=
60] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold</div><div>&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.104161] pci 0000:00:00.0: PME# disabled</div><di=
v>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104162] PCI_DRIVER: pci_scan_single_dev=
ice&nbsp=3B</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104163] PCI_DRIVER:=
 pci_scan_slotPCI_DRIVER: pci_scan_slot: Done</div><div>&lt=3B7&gt=3B[ &nbs=
p=3B &nbsp=3B0.104164] fixups for bus</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nb=
sp=3B0.104164] PCI: Fixup bus devices 0 (PHB)</div><div>&lt=3B7&gt=3B[ &nbs=
p=3B &nbsp=3B0.104165] PCI: Try to map irq for 0000:00:00.0...</div><div>&l=
t=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104166] pci 0000:00:00.0: scanning [bus 00-=
00] behind bridge=2C pass 0</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104=
167] pci 0000:00:00.0: bus configuration invalid=2C reconfiguring</div><div=
>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104167] pci 0000:00:00.0: scanning [bus =
00-00] behind bridge=2C pass 1</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.=
104171] pci_bus 0000:01: PCI_DRIVER: pci_scanning_bus</div><div>&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.104172] PCI_DRIVER: pci_scan_slot: Done</div><div>&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104172] fixups for bus</div><div>&lt=3B6&g=
t=3B[ &nbsp=3B &nbsp=3B0.104173] pci 0000:00:00.0: PCI bridge to [bus 01-ff=
]</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104174] PCI: Fixup bus device=
s 1 (0000:00:00.0)</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104175] pci_=
bus 0000:01: bus scan returning with max=3D01</div><div>&lt=3B7&gt=3B[ &nbs=
p=3B &nbsp=3B0.104176] pci_bus 0000:00: bus scan returning with max=3D01</d=
iv><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104176] pci-common- &nbsp=3B &nbs=
p=3Bpcibios_scan_phb : Done</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104=
239] PCI: Allocating bus resources for 0000:00...</div><div>&lt=3B7&gt=3B[ =
&nbsp=3B &nbsp=3B0.104240] PCI: PHB (bus 0) bridge rsrc 4: 0000000000000000=
-00000000000fffff [0x100]=2C parent c0255db0 (PCI IO)</div><div>&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.104241] PCI: PHB (bus 0) bridge rsrc 5: 00000000800=
00000-000000009fffffff [0x200]=2C parent c0255d88 (PCI mem)</div><div>&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104242] PCI: Allocating bus resources for 00=
00:01...</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104961] bio: create sl=
ab &lt=3Bbio-0&gt=3B at 0</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.10507=
2] vgaarb: loaded</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.105221] Switc=
hing to clocksource timebase</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.10=
7533] PCI_QUIRKS : pci_apply_final_quirks</div><div>&lt=3B7&gt=3B[ &nbsp=3B=
 &nbsp=3B0.107534] PCI_DRIVER: pci_fixup_device</div><div>&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.107534] PCI_DRIVER: case pci_fixup_final&nbsp=3B</div><div=
>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.107536] pci 0000:00:00.0: calling quirk_=
e100_interrupt+0x0/0x1b0</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.107538=
] pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x50</div><div>&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.107539] pci 0000:00:00.0: calling quirk_usb_earl=
y_handoff+0x0/0x718</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.107540] PCI=
: CLS 128 bytes=2C default 32</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.1=
07647] Trying to unpack rootfs image as initramfs...</div><div>&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.108413] rootfs image is not initramfs (no cpio magi=
c)=3B looks like an initrd</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.1102=
25] Freeing initrd memory: 4424k freed</div><div>&lt=3B6&gt=3B[ &nbsp=3B &n=
bsp=3B0.110462] msgmni has been set to 502</div><div>&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.110471] io scheduler noop registered</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.110472] io scheduler deadline registered</div><div>&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.110478] io scheduler cfq registered (default=
)</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.128194] brd: module loaded</d=
iv><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.128860] loop: module loaded</div>=
<div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.128864] e1000e: Intel(R) PRO/1000 Ne=
twork Driver - 1.5.1-k</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.128865] =
e1000e: Copyright(c) 1999 - 2011 Intel Corporation.</div><div>&lt=3B6&gt=3B=
[ &nbsp=3B &nbsp=3B0.128870] e1000e 0000:00:00.0: Disabling ASPM &nbsp=3BL1=
</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.128871] PCI_DRIVER: pci_fixup_=
device</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.128872] PCI_DRIVER: case=
 pci_fixup_enable</div><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.128873] e1000=
e 0000:00:00.0: enabling bus mastering</div><div>&lt=3B7&gt=3B[ &nbsp=3B &n=
bsp=3B0.128895] e1000e DRIVER probe: mmio_start: cf9bc000=2C mmio_len: 0</d=
iv><div>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.128896] __ioremap(): phys addr 0x=
0 is RAM lr c01c6bf0</div><div>&lt=3B4&gt=3B[ &nbsp=3B &nbsp=3B0.128899] e1=
000e: probe of 0000:00:00.0 failed with error -5</div><div>&lt=3B5&gt=3B[ &=
nbsp=3B &nbsp=3B0.128993] RAMDISK: gzip image found at block 0</div><div>&l=
t=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.178833] VFS: Mounted root (ext2 filesystem)=
 on device 1:0.</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.178924] Freeing=
 unused kernel memory: 160k freed</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.178957] Executing /sbin/init</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.181707] [U] lspci -xxx :</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.1=
83257] [U] 00:00.0 Class 0200: Device 8086:105e (rev 06)</div><div>&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.183268] [U] 00: 86 80 5e 10 00 00 10 00 06 00 00 =
02 20 00 80 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183271] [U] 10: =
00 00 00 80 00 00 00 00 01 01 01 00 00 00 00 00</div><div>&lt=3B6&gt=3B[ &n=
bsp=3B &nbsp=3B0.183274] [U] 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 =
40 03</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183277] [U] 30: 00 00 00 =
00 c8 00 00 00 00 00 00 00 00 01 00 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &n=
bsp=3B0.183280] [U] 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00</di=
v><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183283] [U] 50: 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.1=
83285] [U] 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00</div><div>&l=
t=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183288] [U] 70: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183291] [U=
] 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00</div><div>&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.183294] [U] 90: 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183296] [U] a0: 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00</div><div>&lt=3B6&gt=3B[ &nbs=
p=3B &nbsp=3B0.183299] [U] b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183302] [U] c0: 00 00 00 00=
 00 00 00 00 01 d0 22 c8 00 20 00 21</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbs=
p=3B0.183305] [U] d0: 05 e0 80 00 00 00 00 00 00 00 00 00 00 00 00 00</div>=
<div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183307] [U] e0: 10 00 01 00 c1 0c 00=
 00 10 28 10 00 41 64 03 00</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183=
310] [U] f0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00</div><div>&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.183312] [U]&nbsp=3B</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.184285] [U] lspci -vvv :</div><div>&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.185108] [U] 00:00.0 Class 0200: Device 8086:105e (rev 06)</di=
v><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185113] [U] <span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">	</span>Subsystem: Device 1014:0340</div=
><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185115] [U] <span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>Control: I/O- Mem- BusMaster- Spe=
cCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-</div><=
div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185119] [U] <span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>Status: Cap+ 66MHz- UDF- FastB2B- P=
arErr- DEVSEL=3Dfast &gt=3BTAbort- &lt=3BTAbort- &lt=3BMAbort- &gt=3BSERR- =
&lt=3BPERR- INTx-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185121] [U] <=
span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Interrupt: =
pin A routed to IRQ 0</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185124] [=
U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Region =
0: Memory at &lt=3Bignored&gt=3B (32-bit=2C non-prefetchable) [disabled]</d=
iv><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185126] [U] <span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>Region 2: I/O ports at &lt=3Big=
nored&gt=3B [disabled]</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185131] =
[U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Capabi=
lities: [c8] Power Management version 2</div><div>&lt=3B6&gt=3B[ &nbsp=3B &=
nbsp=3B0.185134] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">		</span>Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+=2CD1-=2CD2=
-=2CD3hot+=2CD3cold+)</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185137] [=
U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Status=
: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-</div><div>&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.185139] [U] <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>Capabilities: [d0] MSI: Enable- Count=3D1/1 Maska=
ble- 64bit+</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185142] [U] <span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Address: 0000000=
000000000 &nbsp=3BData: 0000</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.18=
5144] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
Capabilities: [e0] Express (v1) Endpoint=2C MSI 00</div><div>&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.185147] [U] <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>DevCap:<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>MaxPayload 256 bytes=2C PhantFunc 0=2C Latency L0s &lt=
=3B512ns=2C L1 &lt=3B64us</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.18515=
0] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>E=
xtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-</div><div>&lt=3B6&gt=3B[ &nb=
sp=3B &nbsp=3B0.185152] [U] <span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>DevCtl:<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>Report errors: Correctable- Non-Fatal- Fatal- Unsupported-<=
/div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185154] [U] <span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">			</span>RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185156] [U] <=
span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>MaxPayloa=
d 128 bytes=2C MaxReadReq 512 bytes</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.185158] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>DevSta:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-</div><div>=
&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185161] [U] <span class=3D"Apple-tab-span=
" style=3D"white-space:pre">		</span>LnkCap:<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>Port #0=2C Speed 2.5GT/s=2C Width x4=2C A=
SPM L0s=2C Latency L0 &lt=3B4us=2C L1 &lt=3B64us</div><div>&lt=3B6&gt=3B[ &=
nbsp=3B &nbsp=3B0.185164] [U] <span class=3D"Apple-tab-span" style=3D"white=
-space:pre">			</span>ClockPM- Surprise- LLActRep- BwNot-</div><div>&lt=3B6=
&gt=3B[ &nbsp=3B &nbsp=3B0.185166] [U] <span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>LnkCtl:<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>ASPM Disabled=3B RCB 64 bytes Disabled- Retrai=
n- CommClk-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185168] [U] <span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>ExtSynch- Clock=
PM- AutWidDis- BWInt- AutBWInt-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0=
.185170] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">		</s=
pan>LnkSta:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>Speed 2.5GT/s=2C Width x4=2C TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWM=
gmt-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185175] [U] <span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>Capabilities: [100 v1] A=
dvanced Error Reporting</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185178]=
 [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>UESt=
a:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DLP- SDE=
S- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- A=
CSViol-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185182] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>UEMsk:<span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>DLP- SDES- TLP- FCP- Cmp=
ltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-</div><di=
v>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185185] [U] <span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">		</span>UESvrt:<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">	</span>DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt=
- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-</div><div>&lt=3B6&gt=3B=
[ &nbsp=3B &nbsp=3B0.185188] [U] <span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>CESta:<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-=
</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185190] [U] <span class=3D"App=
le-tab-span" style=3D"white-space:pre">		</span>CEMsk:<span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout- NonFatalErr-</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185193=
] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>AER=
Cap:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>First =
Error Pointer: 00=2C GenCap- CGenEn- ChkCap- ChkEn-</div><div>&lt=3B6&gt=3B=
[ &nbsp=3B &nbsp=3B0.185196] [U] <span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>Capabilities: [140 v1] Device Serial Number e4-1f-13=
-ff-ff-51-06-82</div><div>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.185206] [U]&nbs=
p=3B</div><div><br></div><div><br></div><div><br></div><div>Regards=2C</div=
><div>Sumesh</div> 		 	   		  </div></body>
</html>=

--_65f48cb2-51eb-451e-a074-e3ca2f62ba40_--
