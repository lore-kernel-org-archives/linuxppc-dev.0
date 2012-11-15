Return-Path: <sumeshkkn@hotmail.com>
Received: from snt0-omc3-s51.snt0.hotmail.com (snt0-omc3-s51.snt0.hotmail.com
 [65.54.51.88]) by ozlabs.org (Postfix) with ESMTP id B97532C03B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 00:33:43 +1100 (EST)
Message-ID: <SNT002-W17818D7BCAD1235D2D86CDBB4520@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_ec61903b-5fc6-4dac-9d7c-235603216e30_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: FW: e1000e hardware bring-up problem
Date: Thu, 15 Nov 2012 13:28:29 +0000
In-Reply-To: <OF69EAD6CA.250DF267-ON65257AB7.0045C620-65257AB7.0045EB55@in.ibm.com>
References: <OF69EAD6CA.250DF267-ON65257AB7.0045C620-65257AB7.0045EB55@in.ibm.com>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_ec61903b-5fc6-4dac-9d7c-235603216e30_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello All=2C
I am trying to bring-up a network interface on my card. The card which is b=
ased on PowerPC 440=2C running linux=2C has an Intel NIC plugged onto PCIe =
link.
When I do a ping test =2C following happens:
1.  The card (10.10.10.111) and a PC (10.10.10.2) are connected to a switch=
. PC has Wireshark installed.2.  Pinging from the card to PC - issued ping =
10.10.10.2 -c 2 (used a startup script. No serial console)3.  PC receives a=
n ARP REQ prior to ICMP from the CARD.       <--------- observed on Wiresha=
rk installed on the PC.4.  PC responses with an ARP RESP .5.  the NIC(intel=
 GigE)  on the card receives ARP RESP and the NIC counters are incremented.=
 But=2C Neither DD (Descriptor Done) nor EOP (End Of Packet) bits are set o=
n the descriptor.
When the NIC receives a frame=2C NIC is supposed to issue the DMA operation=
 to store the received frame to the host buffer and upon successful DMA of =
the frame to host memory=2C the NIC is supposed to increment RDH (Receive D=
escriptor Head) pointer and set DD and EOP bits on the status field of desc=
riptor and has to notify the processor. But that did not happen. I'm fine r=
eceiving other interrupts.
Can anyone point out why this can happen? Any pointers would be great help.
Following is the bootlog of the machine: (Userspace prints are observed usi=
ng ttyprintk method=2C the lines starting with '[U]' prefixed are from user=
land)

<6>[    0.000000] Using XXX machine description<5>[    0.000000] Linux vers=
ion 3.3.0-rc2 (root@sumeshkn) (gcc version 4.4.6 20110731 (gcc 7.2-4) (GCC)=
 ) #119 PREEMPT Wed Nov 14 06:09:47 EST 2012<7>[    0.000000] Found initrd =
at 0xc0991000:0xc0faeac2<7>[    0.000000] Top of RAM: 0x60000000=2C Total R=
AM: 0x10000000<7>[    0.000000] Memory hole size: 1280MB<7>[    0.000000] Z=
one PFN ranges:<7>[    0.000000]   DMA      0x00050000 -> 0x00060000<7>[   =
 0.000000]   Normal   empty<7>[    0.000000]   HighMem  empty<7>[    0.0000=
00] Movable zone start PFN for each node<7>[    0.000000] Early memory PFN =
ranges<7>[    0.000000]     0: 0x00050000 -> 0x00060000<7>[    0.000000] On=
 node 0 totalpages: 65536<7>[    0.000000] free_area_init_node: node 0=2C p=
gdat c0322ce8=2C node_mem_map c035b000<7>[    0.000000]   DMA zone: 512 pag=
es used for memmap<7>[    0.000000]   DMA zone: 0 pages reserved<7>[    0.0=
00000]   DMA zone: 65024 pages=2C LIFO batch:15<6>[    0.000000] MMU: Alloc=
ated 1088 bytes of context maps for 255 contexts<7>[    0.000000] pcpu-allo=
c: s0 r0 d32768 u32768 alloc=3D1*32768<7>[    0.000000] pcpu-alloc: [0] 0 <=
7>[    0.000000] Built 1 zonelists in Zone order=2C mobility grouping on.  =
Total pages: 65024<5>[    0.000000] Kernel command line: root=3D/dev/ram in=
it=3D_no_such_application rw<6>[    0.000000] PID hash table entries: 1024 =
(order: 0=2C 4096 bytes)<6>[    0.000000] Dentry cache hash table entries: =
32768 (order: 5=2C 131072 bytes)<6>[    0.000000] Inode-cache hash table en=
tries: 16384 (order: 4=2C 65536 bytes)<7>[    0.000000] High memory: 0k<6>[=
    0.000000] Memory: 250108k/262144k available (3076k kernel code=2C 12036=
k reserved=2C 168k data=2C 182k bss=2C 176k init)<6>[    0.000000] Kernel v=
irtual memory layout:<6>[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap=
<6>[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs<6>[    0.00000=
0]   * 0xffa00000..0xffc00000  : consistent mem<6>[    0.000000]   * 0xffa0=
0000..0xffa00000  : early ioremap<6>[    0.000000]   * 0xd1000000..0xffa000=
00  : vmalloc & ioremap<6>[    0.000000] NR_IRQS:512<6>[    0.000000] kmeml=
eak: Kernel memory leak detector disabled<7>[    0.000000] [XXXEIC] Found X=
XX pseudo intc driver<7>[    0.000000] [XXXEIC] No 'interrupts' Found=2C br=
eaking<7>[    0.000000] [XXXEIC] Alloc and init an irq_host structure: irq_=
alloc_host():Successfull<7>[    0.000000] [XXXEIC] calling irq_set_default_=
host<7>[    0.000000] time_init: decrementer frequency =3D 166.666667 MHz<7=
>[    0.000000] time_init: processor frequency   =3D 666.666664 MHz<6>[    =
0.000000] clocksource: timebase mult[6000000] shift[24] registered<7>[    0=
.000000] clockevent: decrementer mult[2aaaaaac] shift[32] cpu[0]<6>[    0.0=
00000] Console: colour dummy device 80x25<6>[    0.000000] console [tty0] e=
nabled<4>[    0.000000] kmemleak: Early log buffer exceeded (908)=2C please=
 increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE<6>[    0.000059] pid_max: default: =
32768 minimum: 301<6>[    0.000079] Mount-cache hash table entries: 512<6>[=
    0.000288] NET: Registered protocol family 16<7>[    0.000468] XXX_PCIE:=
ibm=2Cplb-pciex-440xxx matching : xxx_device_mbase : 0xd1000000<1>[    0.00=
0469] XXX_PCIE: inside Core init <3>[    0.000473] XXX_PCIE: ppc4xx_pciex_c=
heck_core_init : Done <3>[    0.000474] XXX_PCIE: device_type : pci <3>[   =
 0.000476] XXX_PCIE: dcr_resource_start : Done <3>[    0.000477] XXX_PCIE: =
dcr_map : Done <1>[    0.000478] XXX_PCIE: inside init port hw <3>[    0.10=
4007] XXX_PCIE: ppc4xx_pciex_port_init : Done <7>[    0.104009] XXX_PCIE: b=
us-range : 0 - 1XXX_PCIE: pci_bios allocation success <1>[    0.104011] XXX=
_PCIE: ppc4xx_pciex_port_setup_hose - port->endpoint: 0  <1>[    0.104013] =
XXX_PCIE: hose->ops: Done  <6>[    0.104014] PCI host bridge /pciex (primar=
y) ranges:<6>[    0.104015] ranges property :not null<6>[    0.104016]  MEM=
 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 <1>[    0.104=
018] XXX_PCIE: pci_process_bridge_OF_ranges : Done  <1>[    0.104019] XXX_P=
CIE: ppc4xx_parse_dma_ranges : Done  <6>[    0.104021] PCIE0: successfully =
set as root-complex<3>[    0.104022] XXX_PCIE: ppc4xx_pciex_port_setup_hose=
 : Done <3>[    0.104024] XXX_PCIE:  ppc4xx_pci_find_bridges : Done <6>[   =
 0.104064] PCI: Probing PCI hardware<7>[    0.104067] PCI: Scanning PHB /pc=
iex<4>[    0.104068] PCI: I/O resource not set for host bridge /pciex (doma=
in 0)<7>[    0.104069] PCI: PHB IO resource    =3D 0000000000000000-0000000=
0ffffffff [100]<7>[    0.104070] PCI: PHB MEM resource 0 =3D 00000000800000=
00-000000009fffffff [200]<7>[    0.104070] PCI: PHB MEM offset     =3D 0000=
000000000000<7>[    0.104071] PCI: PHB IO  offset     =3D 00000000<6>[    0=
.104102] PCI host bridge to bus 0000:00<6>[    0.104106] pci_bus 0000:00: r=
oot bus resource [io  0x0000-0xffffffff]<6>[    0.104108] pci_bus 0000:00: =
root bus resource [mem 0x80000000-0x9fffffff]<7>[    0.104109] pci-common- =
   probe mode: 0<7>[    0.104109] pci_bus 0000:00: scanning bus<7>[    0.10=
4113] pci 0000:00:04.0: [8086:105e] type 0 class 0x000200<7>[    0.104115] =
pci 0000:00:04.0: calling fixup_xxx+0x0/0x1f8<7>[    0.104115] XXX_FIXUP_EA=
RLY: vendor : 8086=2C device: 105e<7>[    0.104116] <6>XXX_FIXUP : val1 at =
0x0 is 8086<7>[    0.104116] <6>XXX_FIXUP : 0x2 is 105e<7>[    0.104117] <6=
>XXX_FIXUP : 0x4 is 0<7>[    0.104117] <6>XXX_FIXUP : 0x6 is 10<7>[    0.10=
4117] <6>XXX_FIXUP : base 0 is 80000000<7>[    0.104118] <6>XXX_FIXUP : bas=
e 1 80020000<7>[    0.104118] PCI-common: enabling interrupts in thumper<7>=
[    0.104119] XXX_FIXUP_EARLY: PCI_INTERRUPT_LINE:  c<7>[    0.104119] XXX=
_FIXUP_EARLY: mfmsr : 29000<7>[    0.104120] pci 0000:00:04.0: calling quir=
k_mmio_always_on+0x0/0x24<7>[    0.104121] pci 0000:00:04.0: reg 10: [mem 0=
x80000000-0x8001ffff]<7>[    0.104122] pci 0000:00:04.0: reg 14: [mem 0x800=
20000-0x8003ffff]<7>[    0.104123] pci 0000:00:04.0: reg 18: [io  0x8204000=
0-0x8204001f]<7>[    0.104124] pci 0000:00:04.0: reg 30: [mem 0x83000000-0x=
8301ffff pref]<7>[    0.104125] pci 0000:00:04.0: calling pcibios_fixup_res=
ources+0x0/0x270<6>[    0.104125] XXX_PCIE: pcibios_fixup_resources : start=
 <6>[    0.104127] XXX_PCIE: pcibios_fixup_resources : this is bridge : DEV=
ICE_CNT_RSRC: 11<6>[    0.104128] XXX_PCIE: pcibios_fixup_resources : res->=
start: 0x80000000=2C pci_reassign: 0=2C probe_only:4<7>[    0.104131] PCI:0=
000:00:04.0 Resource 0 0000000080000000-000000008001ffff [40200] fixup...<7=
>[    0.104131] PCI:0000:00:04.0            0000000080000000-000000008001ff=
ff<6>[    0.104132] XXX_PCIE: pcibios_fixup_resources : res->start: 0x80020=
000=2C pci_reassign: 0=2C probe_only:4<7>[    0.104134] PCI:0000:00:04.0 Re=
source 1 0000000080020000-000000008003ffff [40200] fixup...<7>[    0.104134=
] PCI:0000:00:04.0            0000000080020000-000000008003ffff<6>[    0.10=
4135] XXX_PCIE: pcibios_fixup_resources : res->start: 0x82040000=2C pci_rea=
ssign: 0=2C probe_only:4<7>[    0.104137] PCI:0000:00:04.0 Resource 2 00000=
00082040000-000000008204001f [40101] fixup...<7>[    0.104138] PCI:0000:00:=
04.0            0000000082040000-000000008204001f<6>[    0.104138] XXX_PCIE=
: pcibios_fixup_resources : res->start: 0x83000000=2C pci_reassign: 0=2C pr=
obe_only:4<7>[    0.104140] PCI:0000:00:04.0 Resource 6 0000000083000000-00=
0000008301ffff [4e200] fixup...<7>[    0.104141] PCI:0000:00:04.0          =
  0000000083000000-000000008301ffff<7>[    0.104142] pci 0000:00:04.0: call=
ing fixup_ppc4xx_pci_bridge+0x0/0x14c<6>[    0.104142] XXX_PCIE: fixup_ppc4=
xx_pci_bridge <7>[    0.104144] pci 0000:00:04.0: calling quirk_resource_al=
ignment+0x0/0x1d4<7>[    0.104146] pci 0000:00:04.0: PME# supported from D0=
 D3hot<7>[    0.104147] pci 0000:00:04.0: PME# disabled<7>[    0.104149] pc=
i_bus 0000:00: pci_scan_slot: Done<7>[    0.104149] pci_bus 0000:00: fixups=
 for bus<7>[    0.104150] PCI: Fixup bus devices 0 (PHB)<7>[    0.104150] P=
CI: Try to map irq for 0000:00:04.0...<7>[    0.104151]  No map ! Using lin=
e 12 (pin 1) from PCI config<7>[    0.104153] [XXXEIC] xxx_intc_map called:=
 irq: 12<7>[    0.104154] [XXXEIC] set flow type 8<7>[    0.104155]  Mapped=
 to linux irq 16<7>[    0.104155] pci 0000:00:04.0: scanning [bus 00-04] be=
hind bridge=2C pass 0<7>[    0.104156] pci 0000:00:04.0: bus configuration =
invalid=2C reconfiguring<7>[    0.104156] pci 0000:00:04.0: scanning [bus 0=
0-00] behind bridge=2C pass 1<7>[    0.104160] pci_bus 0000:01: scanning bu=
s<7>[    0.104161] pci_bus 0000:01: pci_scan_slot: Done<7>[    0.104161] pc=
i_bus 0000:01: fixups for bus<6>[    0.104162] pci 0000:00:04.0: PCI bridge=
 to [bus 01-ff]<7>[    0.104163] PCI: Fixup bus devices 1 (0000:00:04.0)<7>=
[    0.104164] pci_bus 0000:01: bus scan returning with max=3D01<7>[    0.1=
04165] pci_bus 0000:00: bus scan returning with max=3D01<7>[    0.104165] p=
ci-common-    pcibios_scan_phb : Done<6>[    0.104223] XXX_PCIE: pci_bus_ad=
d_devices<7>[    0.104226] PCI: Allocating bus resources for 0000:00...<7>[=
    0.104227] PCI: PHB (bus 0) bridge rsrc 4: 0000000000000000-00000000ffff=
ffff [0x100]=2C parent c0305df0 (PCI IO)<7>[    0.104228] PCI: PHB (bus 0) =
bridge rsrc 5: 0000000080000000-000000009fffffff [0x200]=2C parent c0305dc8=
 (PCI mem)<7>[    0.104229] PCI: Allocating bus resources for 0000:01...<7>=
[    0.104231] PCI: Allocating 0000:00:04.0: Resource 0: 0000000080000000..=
000000008001ffff [40200]<7>[    0.104231] PCI: Allocating 0000:00:04.0: Res=
ource 1: 0000000080020000..000000008003ffff [40200]<7>[    0.104232] PCI: A=
llocating 0000:00:04.0: Resource 2: 0000000082040000..000000008204001f [401=
01]<7>[    0.104233] PCI: Allocating 0000:00:04.0: Resource 6: 000000008300=
0000..000000008301ffff [4e200]<6>[    0.104233] XXX_PCIE: pcibios_resource_=
survey():Done<6>[    0.105446] bio: create slab <bio-0> at 0<6>[    0.10554=
9] vgaarb: loaded<6>[    0.105719] Switching to clocksource timebase<6>[   =
 0.107988] NET: Registered protocol family 2<6>[    0.108411] IP route cach=
e hash table entries: 2048 (order: 1=2C 8192 bytes)<6>[    0.108475] TCP es=
tablished hash table entries: 8192 (order: 4=2C 65536 bytes)<6>[    0.10850=
7] TCP bind hash table entries: 8192 (order: 3=2C 32768 bytes)<6>[    0.108=
522] TCP: Hash tables configured (established 8192 bind 8192)<6>[    0.1085=
25] TCP reno registered<6>[    0.108527] UDP hash table entries: 256 (order=
: 0=2C 4096 bytes)<6>[    0.108530] UDP-Lite hash table entries: 256 (order=
: 0=2C 4096 bytes)<6>[    0.108557] NET: Registered protocol family 1<7>[  =
  0.108561] PCI_QUIRKS : pci_apply_final_quirks<7>[    0.108564] pci 0000:0=
0:04.0: calling quirk_e100_interrupt+0x0/0x1b0<7>[    0.108565] pci 0000:00=
:04.0: calling quirk_cardbus_legacy+0x0/0x50<7>[    0.108566] pci 0000:00:0=
4.0: calling quirk_usb_early_handoff+0x0/0x718<7>[    0.108567] PCI: CLS 12=
8 bytes=2C default 32<6>[    0.108670] Trying to unpack rootfs image as ini=
tramfs...<6>[    0.109118] rootfs image is not initramfs (no cpio magic)=3B=
 looks like an initrd<6>[    0.111639] Freeing initrd memory: 6264k freed<6=
>[    0.111883] msgmni has been set to 500<6>[    0.111955] io scheduler no=
op registered<6>[    0.111958] io scheduler deadline registered<6>[    0.11=
1964] io scheduler cfq registered (default)<6>[    0.128011] Serial: 8250/1=
6550 driver=2C 4 ports=2C IRQ sharing disabled<6>[    0.129473] brd: module=
 loaded<6>[    0.130417] loop: module loaded<6>[    0.130446] Xilinx System=
ACE device driver=2C major=3D254<6>[    0.130558] e1000e: Intel(R) PRO/1000=
 Network Driver - 1.5.1-k<6>[    0.130562] e1000e: Copyright(c) 1999 - 2011=
 Intel Corporation.<6>[    0.130567] e1000e 0000:00:04.0: Disabling ASPM  L=
1<6>[    0.130569] e1000e 0000:00:04.0: enabling device (0000 -> 0002)<7>[ =
   0.130571] e1000e 0000:00:04.0: enabling bus mastering<3>[    0.130595] e=
1000e 0000:00:04.0: (unregistered net_device): Failed to initialize MSI int=
errupts.  Falling back to legacy interrupts.<6>[    0.313821] e1000e 0000:0=
0:04.0: eth0: (PCI Express:2.5GT/s:Width x4) e4:1f:13:4f:28:d4<6>[    0.313=
825] e1000e 0000:00:04.0: eth0: Intel(R) PRO/1000 Network Connection<6>[   =
 0.313837] e1000e 0000:00:04.0: eth0: MAC: 0=2C PHY: 4=2C PBA No: E34292-00=
4<6>[    0.313949] mousedev: PS/2 mouse device common for all mice<6>[    0=
.314063] TCP cubic registered<6>[    0.314066] NET: Registered protocol fam=
ily 17<6>[    0.314074] NET: Registered protocol family 15<5>[    0.314140]=
 RAMDISK: gzip image found at block 0<4>[    0.369460] EXT2-fs (ram0): warn=
ing: mounting unchecked fs=2C running e2fsck is recommended<6>[    0.369472=
] VFS: Mounted root (ext2 filesystem) on device 1:0.<6>[    0.369569] Freei=
ng unused kernel memory: 176k freed<6>[    0.369573] Executing _no_such_app=
lication<4>[    0.369587] Failed to execute _no_such_application.  Attempti=
ng defaults...<6>[    0.369588] Executing /sbin/hello_world<6>[    0.369600=
] /sbin/hello_world --- Failed.<6>[    0.369601] Executing /sbin/init<6>[  =
  0.371822] [U] lspci -vv<6>[    0.372849] [U] 00:04.0 Class 0200: Device 8=
086:105e (rev 06)<6>[    0.372854] [U] 	Subsystem: Device 1014:0340<6>[    =
0.372856] [U] 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-<6>[    0.372860] [U] 	Status: Cap=
+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SE=
RR- <PERR- INTx-<6>[    0.372862] [U] 	Latency: 0=2C Cache Line Size: 128 b=
ytes<6>[    0.372864] [U] 	Interrupt: pin A routed to IRQ 16<6>[    0.37286=
6] [U] 	Region 0: Memory at 80000000 (32-bit=2C non-prefetchable) [size=3D1=
28K]<6>[    0.372869] [U] 	Region 1: Memory at 80020000 (32-bit=2C non-pref=
etchable) [size=3D128K]<6>[    0.372871] [U] 	Region 2: I/O ports at 820400=
00 [disabled] [size=3D32]<6>[    0.372873] [U] 	Expansion ROM at 83000000 [=
disabled] [size=3D128K]<6>[    0.372878] [U] 	Capabilities: [c8] Power Mana=
gement version 2<6>[    0.372881] [U] 		Flags: PMEClk- DSI+ D1- D2- AuxCurr=
ent=3D0mA PME(D0+=2CD1-=2CD2-=2CD3hot+=2CD3cold-)<6>[    0.372884] [U] 		St=
atus: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-<6>[    0.372886] [=
U] 	Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+<6>[    0.3=
72888] [U] 		Address: 0000000000000000  Data: 0000<6>[    0.372891] [U] 	Ca=
pabilities: [e0] Express (v1) Endpoint=2C MSI 00<6>[    0.372893] [U] 		Dev=
Cap:	MaxPayload 256 bytes=2C PhantFunc 0=2C Latency L0s <512ns=2C L1 <64us<=
6>[    0.372896] [U] 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-<6>[=
    0.372898] [U] 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-<6>[    0.372900] [U] 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoS=
noop+<6>[    0.372902] [U] 			MaxPayload 128 bytes=2C MaxReadReq 512 bytes<=
6>[    0.372904] [U] 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- Aux=
Pwr- TransPend-<6>[    0.372907] [U] 		LnkCap:	Port #0=2C Speed 2.5GT/s=2C =
Width x4=2C ASPM L0s=2C Latency L0 <4us=2C L1 <64us<6>[    0.372909] [U] 		=
	ClockPM- Surprise- LLActRep- BwNot-<6>[    0.372911] [U] 		LnkCtl:	ASPM Di=
sabled=3B RCB 64 bytes Disabled- Retrain- CommClk-<6>[    0.372913] [U] 			=
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-<6>[    0.372916] [U] 		LnkSt=
a:	Speed 2.5GT/s=2C Width x4=2C TrErr- Train- SlotClk+ DLActive- BWMgmt- AB=
WMgmt-<6>[    0.372920] [U] 	Capabilities: [100 v1] Advanced Error Reportin=
g<6>[    0.372923] [U] 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- Un=
xCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<6>[    0.372927] [U] 		UEMs=
k:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- =
UnsupReq- ACSViol-<6>[    0.372930] [U] 		UESvrt:	DLP+ SDES- TLP- FCP+ Cmpl=
tTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<6>[    0.=
372933] [U] 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr=
-<6>[    0.372935] [U] 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- =
NonFatalErr-<6>[    0.372937] [U] 		AERCap:	First Error Pointer: 00=2C GenC=
ap- CGenEn- ChkCap- ChkEn-<6>[    0.372940] [U] 	Capabilities: [140 v1] Dev=
ice Serial Number e4-1f-13-ff-ff-4f-28-d4<6>[    0.372951] [U] <6>[    0.37=
3275] [U] 1.ifconfig eth0 10.10.10.10 netmask 255.0.0.0 up<7>[    0.373613]=
 netdev.c:e1000_open<7>[    0.483627] netdev.c: e1000e_configure<7>[    0.4=
83627] e1000_configure_rx: rdlen: 1000<7>[    0.509726] e1000_alloc_rx_buff=
ers: buffer_info[0]->dma: 5ec97022=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 2270c95e<7>[    0.509732] e1000_alloc_rx_buffers: buffer_info[1=
]->dma: 5f2ea822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a82e=
5f<7>[    0.509734] e1000_alloc_rx_buffers: buffer_info[2]->dma: 5f2ea022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a02e5f<7>[    0.5097=
39] e1000_alloc_rx_buffers: buffer_info[3]->dma: 5f2cf822=2Crx_buffer_len:5=
f2=2C rx_desc->read.buffer_addr=3B 22f82c5f<7>[    0.509742] e1000_alloc_rx=
_buffers: buffer_info[4]->dma: 5f2cf022=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22f02c5f<7>[    0.509747] e1000_alloc_rx_buffers: buffer_i=
nfo[5]->dma: 5f2d0822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2=
2082d5f<7>[    0.509750] e1000_alloc_rx_buffers: buffer_info[6]->dma: 5f2d0=
022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22002d5f<7>[    0.5=
09755] e1000_alloc_rx_buffers: buffer_info[7]->dma: 5f2d1822=2Crx_buffer_le=
n:5f2=2C rx_desc->read.buffer_addr=3B 22182d5f<7>[    0.509757] e1000_alloc=
_rx_buffers: buffer_info[8]->dma: 5f2d1022=2Crx_buffer_len:5f2=2C rx_desc->=
read.buffer_addr=3B 22102d5f<7>[    0.509762] e1000_alloc_rx_buffers: buffe=
r_info[9]->dma: 5f2d2822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22282d5f<7>[    0.509765] e1000_alloc_rx_buffers: buffer_info[10]->dma:=
 5f2d2022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22202d5f<7>[ =
   0.509770] e1000_alloc_rx_buffers: buffer_info[11]->dma: 5f2d3822=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22382d5f<7>[    0.509773] e100=
0_alloc_rx_buffers: buffer_info[12]->dma: 5f2d3022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22302d5f<7>[    0.509777] e1000_alloc_rx_buffer=
s: buffer_info[13]->dma: 5f2d4822=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22482d5f<7>[    0.509780] e1000_alloc_rx_buffers: buffer_info[14=
]->dma: 5f2d4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22402d=
5f<7>[    0.509785] e1000_alloc_rx_buffers: buffer_info[15]->dma: 5f2d5822=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22582d5f<7>[    0.5097=
88] e1000_alloc_rx_buffers: buffer_info[16]->dma: 5f2d5022=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22502d5f<7>[    0.509792] e1000_alloc_r=
x_buffers: buffer_info[17]->dma: 5f2d6822=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22682d5f<7>[    0.509795] e1000_alloc_rx_buffers: buffer=
_info[18]->dma: 5f2d6022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22602d5f<7>[    0.509799] e1000_alloc_rx_buffers: buffer_info[19]->dma:=
 5f2d7822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22782d5f<7>[ =
   0.509804] e1000_alloc_rx_buffers: buffer_info[20]->dma: 5f2d7022=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22702d5f<7>[    0.509808] e100=
0_alloc_rx_buffers: buffer_info[21]->dma: 5f2d9822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22982d5f<7>[    0.509811] e1000_alloc_rx_buffer=
s: buffer_info[22]->dma: 5f2d9022=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22902d5f<7>[    0.509816] e1000_alloc_rx_buffers: buffer_info[23=
]->dma: 5f2da822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a82d=
5f<7>[    0.509819] e1000_alloc_rx_buffers: buffer_info[24]->dma: 5f2da022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a02d5f<7>[    0.5098=
23] e1000_alloc_rx_buffers: buffer_info[25]->dma: 5f2db822=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22b82d5f<7>[    0.509826] e1000_alloc_r=
x_buffers: buffer_info[26]->dma: 5f2db022=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22b02d5f<7>[    0.509830] e1000_alloc_rx_buffers: buffer=
_info[27]->dma: 5f2dc822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22c82d5f<7>[    0.509833] e1000_alloc_rx_buffers: buffer_info[28]->dma:=
 5f2dc022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c02d5f<7>[ =
   0.509838] e1000_alloc_rx_buffers: buffer_info[29]->dma: 5f2c1822=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22182c5f<7>[    0.509841] e100=
0_alloc_rx_buffers: buffer_info[30]->dma: 5f2c1022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22102c5f<7>[    0.509845] e1000_alloc_rx_buffer=
s: buffer_info[31]->dma: 5f2c2822=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22282c5f<7>[    0.509848] e1000_alloc_rx_buffers: buffer_info[32=
]->dma: 5f2c2022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22202c=
5f<7>[    0.509852] e1000_alloc_rx_buffers: buffer_info[33]->dma: 5f2c3822=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22382c5f<7>[    0.5098=
55] e1000_alloc_rx_buffers: buffer_info[34]->dma: 5f2c3022=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22302c5f<7>[    0.509860] e1000_alloc_r=
x_buffers: buffer_info[35]->dma: 5f2c4822=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22482c5f<7>[    0.509863] e1000_alloc_rx_buffers: buffer=
_info[36]->dma: 5f2c4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22402c5f<7>[    0.509868] e1000_alloc_rx_buffers: buffer_info[37]->dma:=
 5f2c5822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22582c5f<7>[ =
   0.509871] e1000_alloc_rx_buffers: buffer_info[38]->dma: 5f2c5022=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22502c5f<7>[    0.509875] e100=
0_alloc_rx_buffers: buffer_info[39]->dma: 5f2ce822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22e82c5f<7>[    0.509879] e1000_alloc_rx_buffer=
s: buffer_info[40]->dma: 5f2ce022=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22e02c5f<7>[    0.509884] e1000_alloc_rx_buffers: buffer_info[41=
]->dma: 5f91f822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f891=
5f<7>[    0.509887] e1000_alloc_rx_buffers: buffer_info[42]->dma: 5f91f022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0915f<7>[    0.5098=
91] e1000_alloc_rx_buffers: buffer_info[43]->dma: 5f923822=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 2238925f<7>[    0.509894] e1000_alloc_r=
x_buffers: buffer_info[44]->dma: 5f923022=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 2230925f<7>[    0.509898] e1000_alloc_rx_buffers: buffer=
_info[45]->dma: 5f8ef822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22f88e5f<7>[    0.509901] e1000_alloc_rx_buffers: buffer_info[46]->dma:=
 5f8ef022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f08e5f<7>[ =
   0.509906] e1000_alloc_rx_buffers: buffer_info[47]->dma: 5f89b822=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b8895f<7>[    0.509909] e100=
0_alloc_rx_buffers: buffer_info[48]->dma: 5f89b022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22b0895f<7>[    0.509913] e1000_alloc_rx_buffer=
s: buffer_info[49]->dma: 5f8e3822=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22388e5f<7>[    0.509916] e1000_alloc_rx_buffers: buffer_info[50=
]->dma: 5f8e3022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22308e=
5f<7>[    0.509921] e1000_alloc_rx_buffers: buffer_info[51]->dma: 5f8eb822=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b88e5f<7>[    0.5099=
24] e1000_alloc_rx_buffers: buffer_info[52]->dma: 5f8eb022=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22b08e5f<7>[    0.509928] e1000_alloc_r=
x_buffers: buffer_info[53]->dma: 5f8e4822=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22488e5f<7>[    0.509931] e1000_alloc_rx_buffers: buffer=
_info[54]->dma: 5f8e4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22408e5f<7>[    0.509935] e1000_alloc_rx_buffers: buffer_info[55]->dma:=
 5f851822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2218855f<7>[ =
   0.509938] e1000_alloc_rx_buffers: buffer_info[56]->dma: 5f851022=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2210855f<7>[    0.509943] e100=
0_alloc_rx_buffers: buffer_info[57]->dma: 5f894822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 2248895f<7>[    0.509946] e1000_alloc_rx_buffer=
s: buffer_info[58]->dma: 5f894022=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 2240895f<7>[    0.509950] e1000_alloc_rx_buffers: buffer_info[59=
]->dma: 5f899822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 229889=
5f<7>[    0.509954] e1000_alloc_rx_buffers: buffer_info[60]->dma: 5f899022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2290895f<7>[    0.5099=
59] e1000_alloc_rx_buffers: buffer_info[61]->dma: 5f893822=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 2238895f<7>[    0.509962] e1000_alloc_r=
x_buffers: buffer_info[62]->dma: 5f893022=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 2230895f<7>[    0.509967] e1000_alloc_rx_buffers: buffer=
_info[63]->dma: 5f9f1822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22189f5f<7>[    0.509969] e1000_alloc_rx_buffers: buffer_info[64]->dma:=
 5f9f1022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22109f5f<7>[ =
   0.509974] e1000_alloc_rx_buffers: buffer_info[65]->dma: 5e3dc822=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c83d5e<7>[    0.509977] e100=
0_alloc_rx_buffers: buffer_info[66]->dma: 5e3dc022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22c03d5e<7>[    0.509983] e1000_alloc_rx_buffer=
s: buffer_info[67]->dma: 5f84a822=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22a8845f<7>[    0.509986] e1000_alloc_rx_buffers: buffer_info[68=
]->dma: 5f84a022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a084=
5f<7>[    0.509990] e1000_alloc_rx_buffers: buffer_info[69]->dma: 5ec4e822=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e8c45e<7>[    0.5099=
93] e1000_alloc_rx_buffers: buffer_info[70]->dma: 5ec4e022=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22e0c45e<7>[    0.509998] e1000_alloc_r=
x_buffers: buffer_info[71]->dma: 5ec4f822=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22f8c45e<7>[    0.510001] e1000_alloc_rx_buffers: buffer=
_info[72]->dma: 5ec4f022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22f0c45e<7>[    0.510005] e1000_alloc_rx_buffers: buffer_info[73]->dma:=
 5f9f8822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22889f5f<7>[ =
   0.510008] e1000_alloc_rx_buffers: buffer_info[74]->dma: 5f9f8022=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22809f5f<7>[    0.510013] e100=
0_alloc_rx_buffers: buffer_info[75]->dma: 5f9f9822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22989f5f<7>[    0.510016] e1000_alloc_rx_buffer=
s: buffer_info[76]->dma: 5f9f9022=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22909f5f<7>[    0.510020] e1000_alloc_rx_buffers: buffer_info[77=
]->dma: 5f9a0822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22089a=
5f<7>[    0.510023] e1000_alloc_rx_buffers: buffer_info[78]->dma: 5f9a0022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22009a5f<7>[    0.5100=
28] e1000_alloc_rx_buffers: buffer_info[79]->dma: 5f9a1822=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 22189a5f<7>[    0.510032] e1000_alloc_r=
x_buffers: buffer_info[80]->dma: 5f9a1022=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 22109a5f<7>[    0.510036] e1000_alloc_rx_buffers: buffer=
_info[81]->dma: 5f83f822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22f8835f<7>[    0.510039] e1000_alloc_rx_buffers: buffer_info[82]->dma:=
 5f83f022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0835f<7>[ =
   0.510044] e1000_alloc_rx_buffers: buffer_info[83]->dma: 5f3fe822=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e83f5f<7>[    0.510047] e100=
0_alloc_rx_buffers: buffer_info[84]->dma: 5f3fe022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22e03f5f<7>[    0.510051] e1000_alloc_rx_buffer=
s: buffer_info[85]->dma: 5f3ff822=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22f83f5f<7>[    0.510054] e1000_alloc_rx_buffers: buffer_info[86=
]->dma: 5f3ff022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f03f=
5f<7>[    0.510058] e1000_alloc_rx_buffers: buffer_info[87]->dma: 5ec36822=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2268c35e<7>[    0.5100=
61] e1000_alloc_rx_buffers: buffer_info[88]->dma: 5ec36022=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 2260c35e<7>[    0.510066] e1000_alloc_r=
x_buffers: buffer_info[89]->dma: 5ec37822=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 2278c35e<7>[    0.510069] e1000_alloc_rx_buffers: buffer=
_info[90]->dma: 5ec37022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 2270c35e<7>[    0.510073] e1000_alloc_rx_buffers: buffer_info[91]->dma:=
 5f3c4822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22483c5f<7>[ =
   0.510076] e1000_alloc_rx_buffers: buffer_info[92]->dma: 5f3c4022=2Crx_bu=
ffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22403c5f<7>[    0.510081] e100=
0_alloc_rx_buffers: buffer_info[93]->dma: 5f3c5822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22583c5f<7>[    0.510084] e1000_alloc_rx_buffer=
s: buffer_info[94]->dma: 5f3c5022=2Crx_buffer_len:5f2=2C rx_desc->read.buff=
er_addr=3B 22503c5f<7>[    0.510088] e1000_alloc_rx_buffers: buffer_info[95=
]->dma: 5ec04822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2248c0=
5e<7>[    0.510091] e1000_alloc_rx_buffers: buffer_info[96]->dma: 5ec04022=
=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2240c05e<7>[    0.5100=
96] e1000_alloc_rx_buffers: buffer_info[97]->dma: 5ec05822=2Crx_buffer_len:=
5f2=2C rx_desc->read.buffer_addr=3B 2258c05e<7>[    0.510099] e1000_alloc_r=
x_buffers: buffer_info[98]->dma: 5ec05022=2Crx_buffer_len:5f2=2C rx_desc->r=
ead.buffer_addr=3B 2250c05e<7>[    0.510103] e1000_alloc_rx_buffers: buffer=
_info[99]->dma: 5ec16822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 2268c15e<7>[    0.510108] e1000_alloc_rx_buffers: buffer_info[100]->dma=
: 5ec16022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2260c15e<7>[=
    0.510112] e1000_alloc_rx_buffers: buffer_info[101]->dma: 5ec66822=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2268c65e<7>[    0.510115] e1=
000_alloc_rx_buffers: buffer_info[102]->dma: 5ec66022=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 2260c65e<7>[    0.510120] e1000_alloc_rx_b=
uffers: buffer_info[103]->dma: 5ec67822=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 2278c65e<7>[    0.510122] e1000_alloc_rx_buffers: buffer_i=
nfo[104]->dma: 5ec67022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 2270c65e<7>[    0.510127] e1000_alloc_rx_buffers: buffer_info[105]->dma: 5=
f3f2822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22283f5f<7>[   =
 0.510130] e1000_alloc_rx_buffers: buffer_info[106]->dma: 5f3f2022=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22203f5f<7>[    0.510134] e1000=
_alloc_rx_buffers: buffer_info[107]->dma: 5f3f3822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22383f5f<7>[    0.510137] e1000_alloc_rx_buffer=
s: buffer_info[108]->dma: 5f3f3022=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22303f5f<7>[    0.510142] e1000_alloc_rx_buffers: buffer_info[1=
09]->dma: 5eca2822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2228=
ca5e<7>[    0.510144] e1000_alloc_rx_buffers: buffer_info[110]->dma: 5eca20=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2220ca5e<7>[    0.51=
0149] e1000_alloc_rx_buffers: buffer_info[111]->dma: 5eca3822=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 2238ca5e<7>[    0.510152] e1000_allo=
c_rx_buffers: buffer_info[112]->dma: 5eca3022=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 2230ca5e<7>[    0.510156] e1000_alloc_rx_buffers: bu=
ffer_info[113]->dma: 5f35c822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22c8355f<7>[    0.510159] e1000_alloc_rx_buffers: buffer_info[114]->=
dma: 5f35c022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c0355f<=
7>[    0.510164] e1000_alloc_rx_buffers: buffer_info[115]->dma: 5f35d822=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22d8355f<7>[    0.510167]=
 e1000_alloc_rx_buffers: buffer_info[116]->dma: 5f35d022=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22d0355f<7>[    0.510171] e1000_alloc_rx_=
buffers: buffer_info[117]->dma: 5f37e822=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22e8375f<7>[    0.510174] e1000_alloc_rx_buffers: buffer_=
info[118]->dma: 5f37e022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22e0375f<7>[    0.510179] e1000_alloc_rx_buffers: buffer_info[119]->dma=
: 5f37f822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f8375f<7>[=
    0.510183] e1000_alloc_rx_buffers: buffer_info[120]->dma: 5f37f022=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0375f<7>[    0.510187] e1=
000_alloc_rx_buffers: buffer_info[121]->dma: 5f31f822=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22f8315f<7>[    0.510190] e1000_alloc_rx_b=
uffers: buffer_info[122]->dma: 5f31f022=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22f0315f<7>[    0.510195] e1000_alloc_rx_buffers: buffer_i=
nfo[123]->dma: 5f9fc822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22c89f5f<7>[    0.510198] e1000_alloc_rx_buffers: buffer_info[124]->dma: 5=
f9fc022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c09f5f<7>[   =
 0.510202] e1000_alloc_rx_buffers: buffer_info[125]->dma: 5f9fd822=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22d89f5f<7>[    0.510205] e1000=
_alloc_rx_buffers: buffer_info[126]->dma: 5f9fd022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22d09f5f<7>[    0.510210] e1000_alloc_rx_buffer=
s: buffer_info[127]->dma: 5f3ac822=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22c83a5f<7>[    0.510213] e1000_alloc_rx_buffers: buffer_info[1=
28]->dma: 5f3ac022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c0=
3a5f<7>[    0.510217] e1000_alloc_rx_buffers: buffer_info[129]->dma: 5f3ad8=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22d83a5f<7>[    0.51=
0220] e1000_alloc_rx_buffers: buffer_info[130]->dma: 5f3ad022=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 22d03a5f<7>[    0.510225] e1000_allo=
c_rx_buffers: buffer_info[131]->dma: 5ec9e822=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22e8c95e<7>[    0.510228] e1000_alloc_rx_buffers: bu=
ffer_info[132]->dma: 5ec9e022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22e0c95e<7>[    0.510232] e1000_alloc_rx_buffers: buffer_info[133]->=
dma: 5ec9f822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f8c95e<=
7>[    0.510235] e1000_alloc_rx_buffers: buffer_info[134]->dma: 5ec9f022=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0c95e<7>[    0.510240]=
 e1000_alloc_rx_buffers: buffer_info[135]->dma: 5ecce822=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22e8cc5e<7>[    0.510243] e1000_alloc_rx_=
buffers: buffer_info[136]->dma: 5ecce022=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22e0cc5e<7>[    0.510247] e1000_alloc_rx_buffers: buffer_=
info[137]->dma: 5eccf822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22f8cc5e<7>[    0.510250] e1000_alloc_rx_buffers: buffer_info[138]->dma=
: 5eccf022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0cc5e<7>[=
    0.510255] e1000_alloc_rx_buffers: buffer_info[139]->dma: 5d3de822=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e83d5d<7>[    0.510259] e1=
000_alloc_rx_buffers: buffer_info[140]->dma: 5d3de022=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22e03d5d<7>[    0.510263] e1000_alloc_rx_b=
uffers: buffer_info[141]->dma: 5f9d4822=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22489d5f<7>[    0.510266] e1000_alloc_rx_buffers: buffer_i=
nfo[142]->dma: 5f9d4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22409d5f<7>[    0.510271] e1000_alloc_rx_buffers: buffer_info[143]->dma: 5=
f9d5822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22589d5f<7>[   =
 0.510274] e1000_alloc_rx_buffers: buffer_info[144]->dma: 5f9d5022=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22509d5f<7>[    0.510278] e1000=
_alloc_rx_buffers: buffer_info[145]->dma: 5f9b4822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22489b5f<7>[    0.510281] e1000_alloc_rx_buffer=
s: buffer_info[146]->dma: 5f9b4022=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22409b5f<7>[    0.510286] e1000_alloc_rx_buffers: buffer_info[1=
47]->dma: 5f9b5822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2258=
9b5f<7>[    0.510288] e1000_alloc_rx_buffers: buffer_info[148]->dma: 5f9b50=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22509b5f<7>[    0.51=
0293] e1000_alloc_rx_buffers: buffer_info[149]->dma: 5f91c822=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 22c8915f<7>[    0.510296] e1000_allo=
c_rx_buffers: buffer_info[150]->dma: 5f91c022=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22c0915f<7>[    0.510300] e1000_alloc_rx_buffers: bu=
ffer_info[151]->dma: 5f91d822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22d8915f<7>[    0.510303] e1000_alloc_rx_buffers: buffer_info[152]->=
dma: 5f91d022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22d0915f<=
7>[    0.510308] e1000_alloc_rx_buffers: buffer_info[153]->dma: 5f2cc822=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c82c5f<7>[    0.510311]=
 e1000_alloc_rx_buffers: buffer_info[154]->dma: 5f2cc022=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22c02c5f<7>[    0.510315] e1000_alloc_rx_=
buffers: buffer_info[155]->dma: 5f2cd822=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22d82c5f<7>[    0.510318] e1000_alloc_rx_buffers: buffer_=
info[156]->dma: 5f2cd022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22d02c5f<7>[    0.510323] e1000_alloc_rx_buffers: buffer_info[157]->dma=
: 5f2c8822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22882c5f<7>[=
    0.510326] e1000_alloc_rx_buffers: buffer_info[158]->dma: 5f2c8022=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22802c5f<7>[    0.510330] e1=
000_alloc_rx_buffers: buffer_info[159]->dma: 5f2c9822=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22982c5f<7>[    0.510334] e1000_alloc_rx_b=
uffers: buffer_info[160]->dma: 5f2c9022=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22902c5f<7>[    0.510339] e1000_alloc_rx_buffers: buffer_i=
nfo[161]->dma: 5f2cb822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22b82c5f<7>[    0.510342] e1000_alloc_rx_buffers: buffer_info[162]->dma: 5=
f2cb022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b02c5f<7>[   =
 0.510346] e1000_alloc_rx_buffers: buffer_info[163]->dma: 5f840822=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 2208845f<7>[    0.510349] e1000=
_alloc_rx_buffers: buffer_info[164]->dma: 5f840022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 2200845f<7>[    0.510354] e1000_alloc_rx_buffer=
s: buffer_info[165]->dma: 5f841822=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 2218845f<7>[    0.510357] e1000_alloc_rx_buffers: buffer_info[1=
66]->dma: 5f841022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2210=
845f<7>[    0.510361] e1000_alloc_rx_buffers: buffer_info[167]->dma: 5f8428=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2228845f<7>[    0.51=
0364] e1000_alloc_rx_buffers: buffer_info[168]->dma: 5f842022=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 2220845f<7>[    0.510368] e1000_allo=
c_rx_buffers: buffer_info[169]->dma: 5f843822=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 2238845f<7>[    0.510371] e1000_alloc_rx_buffers: bu=
ffer_info[170]->dma: 5f843022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 2230845f<7>[    0.510376] e1000_alloc_rx_buffers: buffer_info[171]->=
dma: 5f854822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2248855f<=
7>[    0.510379] e1000_alloc_rx_buffers: buffer_info[172]->dma: 5f854022=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2240855f<7>[    0.510383]=
 e1000_alloc_rx_buffers: buffer_info[173]->dma: 5f855822=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 2258855f<7>[    0.510386] e1000_alloc_rx_=
buffers: buffer_info[174]->dma: 5f855022=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 2250855f<7>[    0.510391] e1000_alloc_rx_buffers: buffer_=
info[175]->dma: 5f856822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 2268855f<7>[    0.510394] e1000_alloc_rx_buffers: buffer_info[176]->dma=
: 5f856022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2260855f<7>[=
    0.510398] e1000_alloc_rx_buffers: buffer_info[177]->dma: 5f857822=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2278855f<7>[    0.510401] e1=
000_alloc_rx_buffers: buffer_info[178]->dma: 5f857022=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 2270855f<7>[    0.510406] e1000_alloc_rx_b=
uffers: buffer_info[179]->dma: 5f918822=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 2288915f<7>[    0.510410] e1000_alloc_rx_buffers: buffer_i=
nfo[180]->dma: 5f918022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 2280915f<7>[    0.510414] e1000_alloc_rx_buffers: buffer_info[181]->dma: 5=
f91a822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a8915f<7>[   =
 0.510417] e1000_alloc_rx_buffers: buffer_info[182]->dma: 5f91a022=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a0915f<7>[    0.510422] e1000=
_alloc_rx_buffers: buffer_info[183]->dma: 5f91b822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22b8915f<7>[    0.510424] e1000_alloc_rx_buffer=
s: buffer_info[184]->dma: 5f91b022=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22b0915f<7>[    0.510431] e1000_alloc_rx_buffers: buffer_info[1=
85]->dma: 5f958822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2288=
955f<7>[    0.510434] e1000_alloc_rx_buffers: buffer_info[186]->dma: 5f9580=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2280955f<7>[    0.51=
0438] e1000_alloc_rx_buffers: buffer_info[187]->dma: 5f95a822=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 22a8955f<7>[    0.510441] e1000_allo=
c_rx_buffers: buffer_info[188]->dma: 5f95a022=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22a0955f<7>[    0.510445] e1000_alloc_rx_buffers: bu=
ffer_info[189]->dma: 5f95b822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22b8955f<7>[    0.510448] e1000_alloc_rx_buffers: buffer_info[190]->=
dma: 5f95b022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b0955f<=
7>[    0.510453] e1000_alloc_rx_buffers: buffer_info[191]->dma: 5f9b0822=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22089b5f<7>[    0.510456]=
 e1000_alloc_rx_buffers: buffer_info[192]->dma: 5f9b0022=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22009b5f<7>[    0.510460] e1000_alloc_rx_=
buffers: buffer_info[193]->dma: 5f9b1822=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22189b5f<7>[    0.510463] e1000_alloc_rx_buffers: buffer_=
info[194]->dma: 5f9b1022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22109b5f<7>[    0.510468] e1000_alloc_rx_buffers: buffer_info[195]->dma=
: 5f9b2822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22289b5f<7>[=
    0.510471] e1000_alloc_rx_buffers: buffer_info[196]->dma: 5f9b2022=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22209b5f<7>[    0.510476] e1=
000_alloc_rx_buffers: buffer_info[197]->dma: 5f9b3822=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22389b5f<7>[    0.510479] e1000_alloc_rx_b=
uffers: buffer_info[198]->dma: 5f9b3022=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22309b5f<7>[    0.510483] e1000_alloc_rx_buffers: buffer_i=
nfo[199]->dma: 5f96c822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22c8965f<7>[    0.510487] e1000_alloc_rx_buffers: buffer_info[200]->dma: 5=
f96c022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c0965f<7>[   =
 0.510492] e1000_alloc_rx_buffers: buffer_info[201]->dma: 5f96e822=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e8965f<7>[    0.510495] e1000=
_alloc_rx_buffers: buffer_info[202]->dma: 5f96e022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22e0965f<7>[    0.510499] e1000_alloc_rx_buffer=
s: buffer_info[203]->dma: 5f96f822=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22f8965f<7>[    0.510502] e1000_alloc_rx_buffers: buffer_info[2=
04]->dma: 5f96f022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22f0=
965f<7>[    0.510506] e1000_alloc_rx_buffers: buffer_info[205]->dma: 5f92c8=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22c8925f<7>[    0.51=
0509] e1000_alloc_rx_buffers: buffer_info[206]->dma: 5f92c022=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 22c0925f<7>[    0.510514] e1000_allo=
c_rx_buffers: buffer_info[207]->dma: 5f92d822=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22d8925f<7>[    0.510516] e1000_alloc_rx_buffers: bu=
ffer_info[208]->dma: 5f92d022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22d0925f<7>[    0.510521] e1000_alloc_rx_buffers: buffer_info[209]->=
dma: 5f92e822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e8925f<=
7>[    0.510524] e1000_alloc_rx_buffers: buffer_info[210]->dma: 5f92e022=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22e0925f<7>[    0.510529]=
 e1000_alloc_rx_buffers: buffer_info[211]->dma: 5f92f822=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22f8925f<7>[    0.510531] e1000_alloc_rx_=
buffers: buffer_info[212]->dma: 5f92f022=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22f0925f<7>[    0.510536] e1000_alloc_rx_buffers: buffer_=
info[213]->dma: 5f9e4822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22489e5f<7>[    0.510539] e1000_alloc_rx_buffers: buffer_info[214]->dma=
: 5f9e4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22409e5f<7>[=
    0.510543] e1000_alloc_rx_buffers: buffer_info[215]->dma: 5f9e5822=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22589e5f<7>[    0.510546] e1=
000_alloc_rx_buffers: buffer_info[216]->dma: 5f9e5022=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22509e5f<7>[    0.510551] e1000_alloc_rx_b=
uffers: buffer_info[217]->dma: 5f9e6822=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22689e5f<7>[    0.510554] e1000_alloc_rx_buffers: buffer_i=
nfo[218]->dma: 5f9e6022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22609e5f<7>[    0.510558] e1000_alloc_rx_buffers: buffer_info[219]->dma: 5=
f9e7822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22789e5f<7>[   =
 0.510563] e1000_alloc_rx_buffers: buffer_info[220]->dma: 5f9e7022=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22709e5f<7>[    0.510567] e1000=
_alloc_rx_buffers: buffer_info[221]->dma: 5f9d1822=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22189d5f<7>[    0.510570] e1000_alloc_rx_buffer=
s: buffer_info[222]->dma: 5f9d1022=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 22109d5f<7>[    0.510575] e1000_alloc_rx_buffers: buffer_info[2=
23]->dma: 5f9d2822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2228=
9d5f<7>[    0.510578] e1000_alloc_rx_buffers: buffer_info[224]->dma: 5f9d20=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22209d5f<7>[    0.51=
0582] e1000_alloc_rx_buffers: buffer_info[225]->dma: 5f9d3822=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 22389d5f<7>[    0.510585] e1000_allo=
c_rx_buffers: buffer_info[226]->dma: 5f9d3022=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22309d5f<7>[    0.510589] e1000_alloc_rx_buffers: bu=
ffer_info[227]->dma: 5f9f4822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22489f5f<7>[    0.510592] e1000_alloc_rx_buffers: buffer_info[228]->=
dma: 5f9f4022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22409f5f<=
7>[    0.510597] e1000_alloc_rx_buffers: buffer_info[229]->dma: 5f9f5822=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22589f5f<7>[    0.510599]=
 e1000_alloc_rx_buffers: buffer_info[230]->dma: 5f9f5022=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 22509f5f<7>[    0.510604] e1000_alloc_rx_=
buffers: buffer_info[231]->dma: 5f9f6822=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 22689f5f<7>[    0.510607] e1000_alloc_rx_buffers: buffer_=
info[232]->dma: 5f9f6022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 22609f5f<7>[    0.510611] e1000_alloc_rx_buffers: buffer_info[233]->dma=
: 5f9f7822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22789f5f<7>[=
    0.510614] e1000_alloc_rx_buffers: buffer_info[234]->dma: 5f9f7022=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22709f5f<7>[    0.510619] e1=
000_alloc_rx_buffers: buffer_info[235]->dma: 5e3d8822=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22883d5e<7>[    0.510622] e1000_alloc_rx_b=
uffers: buffer_info[236]->dma: 5e3d8022=2Crx_buffer_len:5f2=2C rx_desc->rea=
d.buffer_addr=3B 22803d5e<7>[    0.510627] e1000_alloc_rx_buffers: buffer_i=
nfo[237]->dma: 5e3d9822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B=
 22983d5e<7>[    0.510630] e1000_alloc_rx_buffers: buffer_info[238]->dma: 5=
e3d9022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22903d5e<7>[   =
 0.510634] e1000_alloc_rx_buffers: buffer_info[239]->dma: 5e3da822=2Crx_buf=
fer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a83d5e<7>[    0.510638] e1000=
_alloc_rx_buffers: buffer_info[240]->dma: 5e3da022=2Crx_buffer_len:5f2=2C r=
x_desc->read.buffer_addr=3B 22a03d5e<7>[    0.510642] e1000_alloc_rx_buffer=
s: buffer_info[241]->dma: 5ecb8822=2Crx_buffer_len:5f2=2C rx_desc->read.buf=
fer_addr=3B 2288cb5e<7>[    0.510645] e1000_alloc_rx_buffers: buffer_info[2=
42]->dma: 5ecb8022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2280=
cb5e<7>[    0.510650] e1000_alloc_rx_buffers: buffer_info[243]->dma: 5ecb98=
22=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2298cb5e<7>[    0.51=
0653] e1000_alloc_rx_buffers: buffer_info[244]->dma: 5ecb9022=2Crx_buffer_l=
en:5f2=2C rx_desc->read.buffer_addr=3B 2290cb5e<7>[    0.510657] e1000_allo=
c_rx_buffers: buffer_info[245]->dma: 5ecba822=2Crx_buffer_len:5f2=2C rx_des=
c->read.buffer_addr=3B 22a8cb5e<7>[    0.510660] e1000_alloc_rx_buffers: bu=
ffer_info[246]->dma: 5ecba022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_a=
ddr=3B 22a0cb5e<7>[    0.510665] e1000_alloc_rx_buffers: buffer_info[247]->=
dma: 5ecbb822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b8cb5e<=
7>[    0.510667] e1000_alloc_rx_buffers: buffer_info[248]->dma: 5ecbb022=2C=
rx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22b0cb5e<7>[    0.510672]=
 e1000_alloc_rx_buffers: buffer_info[249]->dma: 5ecc8822=2Crx_buffer_len:5f=
2=2C rx_desc->read.buffer_addr=3B 2288cc5e<7>[    0.510675] e1000_alloc_rx_=
buffers: buffer_info[250]->dma: 5ecc8022=2Crx_buffer_len:5f2=2C rx_desc->re=
ad.buffer_addr=3B 2280cc5e<7>[    0.510680] e1000_alloc_rx_buffers: buffer_=
info[251]->dma: 5ecc9822=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=
=3B 2298cc5e<7>[    0.510683] e1000_alloc_rx_buffers: buffer_info[252]->dma=
: 5ecc9022=2Crx_buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 2290cc5e<7>[=
    0.510687] e1000_alloc_rx_buffers: buffer_info[253]->dma: 5ecca822=2Crx_=
buffer_len:5f2=2C rx_desc->read.buffer_addr=3B 22a8cc5e<7>[    0.510690] e1=
000_alloc_rx_buffers: buffer_info[254]->dma: 5ecca022=2Crx_buffer_len:5f2=
=2C rx_desc->read.buffer_addr=3B 22a0cc5e<7>[    0.510697] e1000_intr: ICR:=
 80000004<7>[    0.510700] e1000_clean_rx_irq:staterr: 0=2C skb->len: 0=2C =
skb->data_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2=
270c95e=2C buf_info.len: 0<7>[    0.510701] 2270c95e       0       0       =
0<6>[    0.511312] [U] ethtool -d eth0<6>[    0.512139] [U] MAC Registers<6=
>[    0.512143] [U] -------------<6>[    0.512196] [U] 0x00000: CTRL (Devic=
e control register)  0x400C0241<6>[    0.512200] [U]       Endian mode (buf=
fers):             little<6>[    0.512202] [U]       Link reset:           =
             normal<6>[    0.512204] [U]       Set link up:                =
       1<6>[    0.512206] [U]       Invert Loss-Of-Signal:             no<6=
>[    0.512208] [U]       Receive flow control:              disabled<6>[  =
  0.512210] [U]       Transmit flow control:             disabled<6>[    0.=
512212] [U]       VLAN mode:                         enabled<6>[    0.51221=
4] [U]       Auto speed detect:                 disabled<6>[    0.512216] [=
U]       Speed select:                      1000Mb/s<6>[    0.512218] [U]  =
     Force speed:                       no<6>[    0.512219] [U]       Force=
 duplex:                      no<6>[    0.512221] [U] 0x00008: STATUS (Devi=
ce status register) 0x00080341<6>[    0.512223] [U]       Duplex:          =
                  full<6>[    0.512225] [U]       Link up:                 =
          no link config<6>[    0.512227] [U]       TBI mode:              =
            disabled<6>[    0.512229] [U]       Link speed:                =
        100Mb/s<6>[    0.512231] [U]       Bus type:                       =
   PCI Express<6>[    0.512233] [U]       Port number:                     =
  0<6>[    0.512234] [U] 0x00100: RCTL (Receive control register) 0x0400800=
2<6>[    0.512236] [U]       Receiver:                          enabled<6>[=
    0.512238] [U]       Store bad packets:                 disabled<6>[    =
0.512240] [U]       Unicast promiscuous:               disabled<6>[    0.51=
2242] [U]       Multicast promiscuous:             disabled<6>[    0.512244=
] [U]       Long packet:                       disabled<6>[    0.512246] [U=
]       Descriptor minimum threshold size: 1/2<6>[    0.512247] [U]       B=
roadcast accept mode:             accept<6>[    0.512249] [U]       VLAN fi=
lter:                       disabled<6>[    0.512251] [U]       Canonical f=
orm indicator:          disabled<6>[    0.512253] [U]       Discard pause f=
rames:              filtered<6>[    0.512255] [U]       Pass MAC control fr=
ames:           don't pass<6>[    0.512256] [U]       Receive buffer size: =
              2048<6>[    0.512258] [U] 0x02808: RDLEN (Receive desc length=
)     0x00001000<6>[    0.512260] [U] 0x02810: RDH   (Receive desc head)   =
    0x00000000<6>[    0.512262] [U] 0x02818: RDT   (Receive desc tail)     =
  0x000000F0<6>[    0.512264] [U] 0x02820: RDTR  (Receive delay timer)     =
0x00000020<6>[    0.512265] [U] 0x00400: TCTL (Transmit ctrl register)   0x=
3103F0F8<6>[    0.512267] [U]       Transmitter:                       disa=
bled<6>[    0.512269] [U]       Pad short packets:                 enabled<=
6>[    0.512271] [U]       Software XOFF Transmission:        disabled<6>[ =
   0.512273] [U]       Re-transmit on late collision:     enabled<6>[    0.=
512274] [U] 0x03808: TDLEN (Transmit desc length)    0x00001000<6>[    0.51=
2276] [U] 0x03810: TDH   (Transmit desc head)      0x00000000<6>[    0.5122=
78] [U] 0x03818: TDT   (Transmit desc tail)      0x00000000<6>[    0.512280=
] [U] 0x03820: TIDV  (Transmit delay timer)    0x00000008<6>[    0.512281] =
[U] PHY type:                                unknown<6>[    0.512641] [U] 3=
.ping 10.10.10.2 -c 3<6>[    0.513100] [U] PING 10.10.10.2 (10.10.10.2): 56=
 data bytes<7>[    0.513845] e1000_intr: ICR: 80000010<7>[    0.513847] e10=
00_clean_rx_irq:staterr: 0=2C skb->len: 0=2C skb->data_len: 0=2Cring.rx_des=
c[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0<7>[=
    0.513848] 2270c95e       0       0       0<7>[    0.561398] e1000_intr:=
 ICR: 80000004<7>[    0.561400] e1000_clean_rx_irq:staterr: 0=2C skb->len: =
0=2C skb->data_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.d=
ma: 2270c95e=2C buf_info.len: 0<7>[    0.561400] 2270c95e       0       0  =
     0<6>[    0.562524] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex=2C=
 Flow Control: Rx/Tx<6>[    0.562528] e1000e 0000:00:04.0: eth0: 10/100 spe=
ed: disabling TSO<7>[    0.562536] e1000_intr: ICR: 80000012<7>[    0.56253=
7] e1000_clean_rx_irq:staterr: 0=2C skb->len: 0=2C skb->data_len: 0=2Cring.=
rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len:=
 0<7>[    0.562538] 2270c95e       0       0       0<7>[    2.826136] e1000=
_intr: ICR: 80000011<7>[    2.826138] e1000_clean_rx_irq:staterr: 0=2C skb-=
>len: 0=2C skb->data_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_=
info.dma: 2270c95e=2C buf_info.len: 0<7>[    2.826139] 2270c95e       0    =
   0       0<7>[    4.821733] e1000_intr: ICR: 80000011<7>[    4.821735] e1=
000_clean_rx_irq:staterr: 0=2C skb->len: 0=2C skb->data_len: 0=2Cring.rx_de=
sc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0<7>=
[    4.821736] 2270c95e       0       0       0<7>[    6.821727] e1000_intr=
: ICR: 80000010<7>[    6.821728] e1000_clean_rx_irq:staterr: 0=2C skb->len:=
 0=2C skb->data_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.=
dma: 2270c95e=2C buf_info.len: 0<7>[    6.821729] 2270c95e       0       0 =
      0<7>[    8.821732] e1000_intr: ICR: 80000010<7>[    8.821734] e1000_c=
lean_rx_irq:staterr: 0=2C skb->len: 0=2C skb->data_len: 0=2Cring.rx_desc[0]=
=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0<7>[    =
8.821735] 2270c95e       0       0       0<7>[   10.821727] e1000_intr: ICR=
: 80000010<7>[   10.821728] e1000_clean_rx_irq:staterr: 0=2C skb->len: 0=2C=
 skb->data_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: =
2270c95e=2C buf_info.len: 0<7>[   10.821729] 2270c95e       0       0      =
 0<6>[   12.529730] [U] <6>[   12.529734] [U] --- 10.10.10.2 ping statistic=
s ---<6>[   12.529737] [U] 3 packets transmitted=2C 0 packets received=2C 1=
00% packet loss<6>[   12.530068] [U] cat /proc/interrupts<6>[   12.530432] =
[U]            CPU0       <6>[   12.530435] [U]  16:         18  XXX INTC L=
evel     eth0<6>[   12.530436] [U] LOC:       3132   Local timer interrupts=
<6>[   12.530438] [U] SPU:          0   Spurious interrupts<6>[   12.530439=
] [U] CNT:          0   Performance monitoring interrupts<6>[   12.530440] =
[U] MCE:          0   Machine check exceptions<6>[   12.530770] [U] cat /pr=
oc/meminfo | grep em<6>[   12.531658] [U] executing /home/stat.sh<6>[   12.=
532611] [U] 1) stat.sh: ifconfig eth0<6>[   12.533383] [U] eth0      Link e=
ncap:Ethernet  HWaddr E4:1F:13:4F:28:D4  <6>[   12.533400] [U]           in=
et addr:10.10.10.111  Bcast:10.255.255.255  Mask:255.0.0.0<6>[   12.533428]=
 [U]           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1<6>[   12.=
533439] [U]           RX packets:2 errors:0 dropped:0 overruns:0 frame:0<6>=
[   12.533447] [U]           TX packets:2 errors:0 dropped:0 overruns:0 car=
rier:0<6>[   12.533453] [U]           collisions:0 txqueuelen:1000 <6>[   1=
2.533465] [U]           RX bytes:128 (128.0 B)  TX bytes:128 (128.0 B)<6>[ =
  12.533472] [U]           Interrupt:16 Memory:80000000-80020000 <6>[   12.=
533474] [U] <6>[   12.533832] [U] 1) stat.sh: ethtool -S eth0 | grep x_pack=
<6>[   12.534042] [U] NIC statistics:<6>[   12.534049] [U]      rx_packets:=
 2<6>[   12.534050] [U]      tx_packets: 2<6>[   12.534051] [U]      rx_byt=
es: 128<6>[   12.534052] [U]      tx_bytes: 128<6>[   12.534054] [U]      r=
x_broadcast: 0<6>[   12.534055] [U]      tx_broadcast: 2<6>[   12.534056] [=
U]      rx_multicast: 0<6>[   12.534057] [U]      tx_multicast: 0<6>[   12.=
534059] [U]      rx_errors: 0<6>[   12.534060] [U]      tx_errors: 0<6>[   =
12.534061] [U]      tx_dropped: 0<6>[   12.534062] [U]      multicast: 0<6>=
[   12.534064] [U]      collisions: 0<6>[   12.534065] [U]      rx_length_e=
rrors: 0<6>[   12.534066] [U]      rx_over_errors: 0<6>[   12.534067] [U]  =
    rx_crc_errors: 0<6>[   12.534069] [U]      rx_frame_errors: 0<6>[   12.=
534070] [U]      rx_no_buffer_count: 0<6>[   12.534071] [U]      rx_missed_=
errors: 0<6>[   12.534073] [U]      tx_aborted_errors: 0<6>[   12.534074] [=
U]      tx_carrier_errors: 0<6>[   12.534075] [U]      tx_fifo_errors: 0<6>=
[   12.534077] [U]      tx_heartbeat_errors: 0<6>[   12.534078] [U]      tx=
_window_errors: 0<6>[   12.534079] [U]      tx_abort_late_coll: 0<6>[   12.=
534081] [U]      tx_deferred_ok: 0<6>[   12.534082] [U]      tx_single_coll=
_ok: 0<6>[   12.534083] [U]      tx_multi_coll_ok: 0<6>[   12.534085] [U]  =
    tx_timeout_count: 0<6>[   12.534086] [U]      tx_restart_queue: 0<6>[  =
 12.534087] [U]      rx_long_length_errors: 0<6>[   12.534089] [U]      rx_=
short_length_errors: 0<6>[   12.534090] [U]      rx_align_errors: 0<6>[   1=
2.534092] [U]      tx_tcp_seg_good: 0<6>[   12.534093] [U]      tx_tcp_seg_=
failed: 0<6>[   12.534094] [U]      rx_flow_control_xon: 0<6>[   12.534096]=
 [U]      rx_flow_control_xoff: 0<6>[   12.534097] [U]      tx_flow_control=
_xon: 0<6>[   12.534098] [U]      tx_flow_control_xoff: 0<6>[   12.534100] =
[U]      rx_long_byte_count: 128<6>[   12.534101] [U]      rx_csum_offload_=
good: 0<6>[   12.534103] [U]      rx_csum_offload_errors: 0<6>[   12.534104=
] [U]      rx_header_split: 0<6>[   12.534105] [U]      alloc_rx_buff_faile=
d: 0<6>[   12.534107] [U]      tx_smbus: 0<6>[   12.534108] [U]      rx_smb=
us: 0<6>[   12.534109] [U]      dropped_smbus: 0<6>[   12.534110] [U]      =
rx_dma_failed: 0<6>[   12.534112] [U]      tx_dma_failed: 0


Regards=2CSumesh. 		 	   		  =

--_ec61903b-5fc6-4dac-9d7c-235603216e30_
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
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div><div><font face=3D"Calibri=
=2C sans-serif"><div>Hello All=2C</div><div><br></div><div>I am trying to b=
ring-up a network interface on my card. The card which is based on PowerPC =
440=2C running linux=2C has an Intel NIC plugged onto PCIe link.</div><div>=
<br></div><div>When I do a ping test =2C following happens:</div><div><br><=
/div><div>1. &nbsp=3BThe card (10.10.10.111) and a PC (10.10.10.2) are conn=
ected to a switch. PC has Wireshark installed.</div><div>2. &nbsp=3BPinging=
 from the card to PC - issued ping 10.10.10.2 -c 2 (used a startup script. =
No serial console)</div><div>3. &nbsp=3BPC receives an ARP REQ prior to ICM=
P from the CARD. &nbsp=3B &nbsp=3B &nbsp=3B &lt=3B--------- observed on Wir=
eshark installed on the PC.</div><div>4. &nbsp=3BPC responses with an ARP R=
ESP .</div><div>5. &nbsp=3Bthe NIC(intel GigE) &nbsp=3Bon the card receives=
 ARP RESP and the NIC counters are incremented. But=2C Neither DD (Descript=
or Done) nor EOP (End Of Packet) bits are set on the descriptor.</div><div>=
<br></div><div>When the NIC receives a frame=2C NIC is supposed to issue th=
e DMA operation to store the received frame to the host buffer and upon suc=
cessful DMA of the frame to host memory=2C the NIC is supposed to increment=
 RDH (Receive Descriptor Head) pointer and set DD and EOP bits on the statu=
s field of descriptor and has to notify the processor. But that did not hap=
pen. I'm fine receiving other interrupts.</div><div><br></div><div>Can anyo=
ne point out why this can happen? Any pointers would be great help.</div><d=
iv><br></div><div>Following is the bootlog of the machine: (Userspace print=
s are observed using ttyprintk method=2C the lines starting with '[U]' pref=
ixed are from userland)</div><div><br></div></font></div><div><font face=3D=
"Calibri=2C sans-serif"><br></font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Using XXX machine descrip=
tion</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B5&gt=3B[ &=
nbsp=3B &nbsp=3B0.000000] Linux version 3.3.0-rc2 (root@sumeshkn) (gcc vers=
ion 4.4.6 20110731 (gcc 7.2-4) (GCC) ) #119 PREEMPT Wed Nov 14 06:09:47 EST=
 2012</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ =
&nbsp=3B &nbsp=3B0.000000] Found initrd at 0xc0991000:0xc0faeac2</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.000000] Top of RAM: 0x60000000=2C Total RAM: 0x10000000</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.0=
00000] Memory hole size: 1280MB</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Zone PFN ranges:</font=
></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &n=
bsp=3B0.000000] &nbsp=3B DMA &nbsp=3B &nbsp=3B &nbsp=3B0x00050000 -&gt=3B 0=
x00060000</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B Normal &nbsp=3B empty</font></div>=
<div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0=
.000000] &nbsp=3B HighMem &nbsp=3Bempty</font></div><div><font face=3D"Cali=
bri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Movable zone s=
tart PFN for each node</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Early memory PFN ranges</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbs=
p=3B0.000000] &nbsp=3B &nbsp=3B 0: 0x00050000 -&gt=3B 0x00060000</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.000000] On node 0 totalpages: 65536</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] free_area_ini=
t_node: node 0=2C pgdat c0322ce8=2C node_mem_map c035b000</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.0000=
00] &nbsp=3B DMA zone: 512 pages used for memmap</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=
=3B DMA zone: 0 pages reserved</font></div><div><font face=3D"Calibri=2C sa=
ns-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] &nbsp=3B DMA zone: 6502=
4 pages=2C LIFO batch:15</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] MMU: Allocated 1088 bytes of =
context maps for 255 contexts</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] pcpu-alloc: s0 r0 d32768=
 u32768 alloc=3D1*32768</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] pcpu-alloc: [0] 0&nbsp=3B</fon=
t></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &=
nbsp=3B0.000000] Built 1 zonelists in Zone order=2C mobility grouping on. &=
nbsp=3BTotal pages: 65024</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B5&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Kernel command line: root=3D=
/dev/ram init=3D_no_such_application rw</font></div><div><font face=3D"Cali=
bri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] PID hash table=
 entries: 1024 (order: 0=2C 4096 bytes)</font></div><div><font face=3D"Cali=
bri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Dentry cache h=
ash table entries: 32768 (order: 5=2C 131072 bytes)</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] In=
ode-cache hash table entries: 16384 (order: 4=2C 65536 bytes)</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.=
000000] High memory: 0k</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Memory: 250108k/262144k availa=
ble (3076k kernel code=2C 12036k reserved=2C 168k data=2C 182k bss=2C 176k =
init)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.000000] Kernel virtual memory layout:</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.00000=
0] &nbsp=3B * 0xfffcf000..0xfffff000 &nbsp=3B: fixmap</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] =
&nbsp=3B * 0xffc00000..0xffe00000 &nbsp=3B: highmem PTEs</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.00000=
0] &nbsp=3B * 0xffa00000..0xffc00000 &nbsp=3B: consistent mem</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.=
000000] &nbsp=3B * 0xffa00000..0xffa00000 &nbsp=3B: early ioremap</font></d=
iv><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.000000] &nbsp=3B * 0xd1000000..0xffa00000 &nbsp=3B: vmalloc &amp=3B io=
remap</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.000000] NR_IRQS:512</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] kmemleak: Kerne=
l memory leak detector disabled</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] [XXXEIC] Found XXX pse=
udo intc driver</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] [XXXEIC] No 'interrupts' Found=2C br=
eaking</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[=
 &nbsp=3B &nbsp=3B0.000000] [XXXEIC] Alloc and init an irq_host structure: =
irq_alloc_host():Successfull</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] [XXXEIC] calling irq_set_=
default_host</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&=
gt=3B[ &nbsp=3B &nbsp=3B0.000000] time_init: decrementer frequency =3D 166.=
666667 MHz</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.000000] time_init: processor frequency &nbsp=3B =3D=
 666.666664 MHz</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] clocksource: timebase mult[6000000] =
shift[24] registered</font></div><div><font face=3D"Calibri=2C sans-serif">=
&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000000] clockevent: decrementer mult[2aaa=
aaac] shift[32] cpu[0]</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000000] Console: colour dummy device 80=
x25</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &n=
bsp=3B &nbsp=3B0.000000] console [tty0] enabled</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B4&gt=3B[ &nbsp=3B &nbsp=3B0.000000] kmemle=
ak: Early log buffer exceeded (908)=2C please increase DEBUG_KMEMLEAK_EARLY=
_LOG_SIZE</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.000059] pid_max: default: 32768 minimum: 301</font>=
</div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nb=
sp=3B0.000079] Mount-cache hash table entries: 512</font></div><div><font f=
ace=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.000288] NET=
: Registered protocol family 16</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.000468] XXX_PCIE:ibm=2Cplb-pci=
ex-440xxx matching : xxx_device_mbase : 0xd1000000</font></div><div><font f=
ace=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=3B &nbsp=3B0.000469] XXX=
_PCIE: inside Core init&nbsp=3B</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B3&gt=3B[ &nbsp=3B &nbsp=3B0.000473] XXX_PCIE: ppc4xx_pciex=
_check_core_init : Done&nbsp=3B</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B3&gt=3B[ &nbsp=3B &nbsp=3B0.000474] XXX_PCIE: device_type =
: pci&nbsp=3B</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B3=
&gt=3B[ &nbsp=3B &nbsp=3B0.000476] XXX_PCIE: dcr_resource_start : Done&nbsp=
=3B</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B3&gt=3B[ &n=
bsp=3B &nbsp=3B0.000477] XXX_PCIE: dcr_map : Done&nbsp=3B</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=3B &nbsp=3B0.0004=
78] XXX_PCIE: inside init port hw&nbsp=3B</font></div><div><font face=3D"Ca=
libri=2C sans-serif">&lt=3B3&gt=3B[ &nbsp=3B &nbsp=3B0.104007] XXX_PCIE: pp=
c4xx_pciex_port_init : Done&nbsp=3B</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104009] XXX_PCIE: bus-ran=
ge : 0 - 1XXX_PCIE: pci_bios allocation success&nbsp=3B</font></div><div><f=
ont face=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=3B &nbsp=3B0.104011=
] XXX_PCIE: ppc4xx_pciex_port_setup_hose - port-&gt=3Bendpoint: 0 &nbsp=3B<=
/font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=
=3B &nbsp=3B0.104013] XXX_PCIE: hose-&gt=3Bops: Done &nbsp=3B</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.=
104014] PCI host bridge /pciex (primary) ranges:</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104015] range=
s property :not null</font></div><div><font face=3D"Calibri=2C sans-serif">=
&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104016] &nbsp=3BMEM 0x0000000080000000..0=
x000000009fffffff -&gt=3B 0x0000000080000000&nbsp=3B</font></div><div><font=
 face=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=3B &nbsp=3B0.104018] X=
XX_PCIE: pci_process_bridge_OF_ranges : Done &nbsp=3B</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B1&gt=3B[ &nbsp=3B &nbsp=3B0.104019] =
XXX_PCIE: ppc4xx_parse_dma_ranges : Done &nbsp=3B</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104021] PCIE=
0: successfully set as root-complex</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B3&gt=3B[ &nbsp=3B &nbsp=3B0.104022] XXX_PCIE: ppc4xx_=
pciex_port_setup_hose : Done&nbsp=3B</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B3&gt=3B[ &nbsp=3B &nbsp=3B0.104024] XXX_PCIE: &nbsp=
=3Bppc4xx_pci_find_bridges : Done&nbsp=3B</font></div><div><font face=3D"Ca=
libri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104064] PCI: Probing=
 PCI hardware</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.104067] PCI: Scanning PHB /pciex</font></div><di=
v><font face=3D"Calibri=2C sans-serif">&lt=3B4&gt=3B[ &nbsp=3B &nbsp=3B0.10=
4068] PCI: I/O resource not set for host bridge /pciex (domain 0)</font></d=
iv><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.104069] PCI: PHB IO resource &nbsp=3B &nbsp=3B=3D 0000000000000000-000=
00000ffffffff [100]</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104070] PCI: PHB MEM resource 0 =3D 000000=
0080000000-000000009fffffff [200]</font></div><div><font face=3D"Calibri=2C=
 sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104070] PCI: PHB MEM offset =
&nbsp=3B &nbsp=3B =3D 0000000000000000</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104071] PCI: PHB IO &nb=
sp=3Boffset &nbsp=3B &nbsp=3B =3D 00000000</font></div><div><font face=3D"C=
alibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104102] PCI host br=
idge to bus 0000:00</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104106] pci_bus 0000:00: root bus resource=
 [io &nbsp=3B0x0000-0xffffffff]</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104108] pci_bus 0000:00: root =
bus resource [mem 0x80000000-0x9fffffff]</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104109] pci-common- &=
nbsp=3B &nbsp=3Bprobe mode: 0</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104109] pci_bus 0000:00: scannin=
g bus</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ =
&nbsp=3B &nbsp=3B0.104113] pci 0000:00:04.0: [8086:105e] type 0 class 0x000=
200</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.104115] pci 0000:00:04.0: calling fixup_xxx+0x0/0x1f8</fon=
t></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &=
nbsp=3B0.104115] XXX_FIXUP_EARLY: vendor : 8086=2C device: 105e</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B=
0.104116] &lt=3B6&gt=3BXXX_FIXUP : val1 at 0x0 is 8086</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104116]=
 &lt=3B6&gt=3BXXX_FIXUP : 0x2 is 105e</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104117] &lt=3B6&gt=3BXXX=
_FIXUP : 0x4 is 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104117] &lt=3B6&gt=3BXXX_FIXUP : 0x6 is 10</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.104117] &lt=3B6&gt=3BXXX_FIXUP : base 0 is 80000000</font></d=
iv><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.104118] &lt=3B6&gt=3BXXX_FIXUP : base 1 80020000</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104118] =
PCI-common: enabling interrupts in thumper</font></div><div><font face=3D"C=
alibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104119] XXX_FIXUP_E=
ARLY: PCI_INTERRUPT_LINE: &nbsp=3Bc</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104119] XXX_FIXUP_EARLY: =
mfmsr : 29000</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.104120] pci 0000:00:04.0: calling quirk_mmio_alw=
ays_on+0x0/0x24</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104121] pci 0000:00:04.0: reg 10: [mem 0x800=
00000-0x8001ffff]</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104122] pci 0000:00:04.0: reg 14: [mem 0x800=
20000-0x8003ffff]</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104123] pci 0000:00:04.0: reg 18: [io &nbsp=
=3B0x82040000-0x8204001f]</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104124] pci 0000:00:04.0: reg 30: [m=
em 0x83000000-0x8301ffff pref]</font></div><div><font face=3D"Calibri=2C sa=
ns-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104125] pci 0000:00:04.0: calli=
ng pcibios_fixup_resources+0x0/0x270</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104125] XXX_PCIE: pcibios=
_fixup_resources : start&nbsp=3B</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104127] XXX_PCIE: pcibios_fix=
up_resources : this is bridge : DEVICE_CNT_RSRC: 11</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104128] XX=
X_PCIE: pcibios_fixup_resources : res-&gt=3Bstart: 0x80000000=2C pci_reassi=
gn: 0=2C probe_only:4</font></div><div><font face=3D"Calibri=2C sans-serif"=
>&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104131] PCI:0000:00:04.0 Resource 0 0000=
000080000000-000000008001ffff [40200] fixup...</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104131] PCI:00=
00:00:04.0 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B00000000800=
00000-000000008001ffff</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104132] XXX_PCIE: pcibios_fixup_resourc=
es : res-&gt=3Bstart: 0x80020000=2C pci_reassign: 0=2C probe_only:4</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbs=
p=3B0.104134] PCI:0000:00:04.0 Resource 1 0000000080020000-000000008003ffff=
 [40200] fixup...</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104134] PCI:0000:00:04.0 &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B0000000080020000-000000008003ffff</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbs=
p=3B0.104135] XXX_PCIE: pcibios_fixup_resources : res-&gt=3Bstart: 0x820400=
00=2C pci_reassign: 0=2C probe_only:4</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104137] PCI:0000:00:04.0=
 Resource 2 0000000082040000-000000008204001f [40101] fixup...</font></div>=
<div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0=
.104138] PCI:0000:00:04.0 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B0000000082040000-000000008204001f</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104138] XXX_PCIE: pcibio=
s_fixup_resources : res-&gt=3Bstart: 0x83000000=2C pci_reassign: 0=2C probe=
_only:4</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B=
[ &nbsp=3B &nbsp=3B0.104140] PCI:0000:00:04.0 Resource 6 0000000083000000-0=
00000008301ffff [4e200] fixup...</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104141] PCI:0000:00:04.0 &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B0000000083000000-000000008=
301ffff</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B=
[ &nbsp=3B &nbsp=3B0.104142] pci 0000:00:04.0: calling fixup_ppc4xx_pci_bri=
dge+0x0/0x14c</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6=
&gt=3B[ &nbsp=3B &nbsp=3B0.104142] XXX_PCIE: fixup_ppc4xx_pci_bridge&nbsp=
=3B</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.104144] pci 0000:00:04.0: calling quirk_resource_alignment=
+0x0/0x1d4</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.104146] pci 0000:00:04.0: PME# supported from D0 D3=
hot</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.104147] pci 0000:00:04.0: PME# disabled</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.10414=
9] pci_bus 0000:00: pci_scan_slot: Done</font></div><div><font face=3D"Cali=
bri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104149] pci_bus 0000:0=
0: fixups for bus</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104150] PCI: Fixup bus devices 0 (PHB)</font=
></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &n=
bsp=3B0.104150] PCI: Try to map irq for 0000:00:04.0...</font></div><div><f=
ont face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104151=
] &nbsp=3BNo map ! Using line 12 (pin 1) from PCI config</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.10415=
3] [XXXEIC] xxx_intc_map called: irq: 12</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104154] [XXXEIC] set =
flow type 8</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&g=
t=3B[ &nbsp=3B &nbsp=3B0.104155] &nbsp=3BMapped to linux irq 16</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B=
0.104155] pci 0000:00:04.0: scanning [bus 00-04] behind bridge=2C pass 0</f=
ont></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B=
 &nbsp=3B0.104156] pci 0000:00:04.0: bus configuration invalid=2C reconfigu=
ring</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &=
nbsp=3B &nbsp=3B0.104156] pci 0000:00:04.0: scanning [bus 00-00] behind bri=
dge=2C pass 1</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7=
&gt=3B[ &nbsp=3B &nbsp=3B0.104160] pci_bus 0000:01: scanning bus</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.104161] pci_bus 0000:01: pci_scan_slot: Done</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104161] pci_=
bus 0000:01: fixups for bus</font></div><div><font face=3D"Calibri=2C sans-=
serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104162] pci 0000:00:04.0: PCI brid=
ge to [bus 01-ff]</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104163] PCI: Fixup bus devices 1 (0000:00:04=
.0)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.104164] pci_bus 0000:01: bus scan returning with max=3D01<=
/font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.104165] pci_bus 0000:00: bus scan returning with max=3D01</fo=
nt></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B =
&nbsp=3B0.104165] pci-common- &nbsp=3B &nbsp=3Bpcibios_scan_phb : Done</fon=
t></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &=
nbsp=3B0.104223] XXX_PCIE: pci_bus_add_devices</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104226] PCI: A=
llocating bus resources for 0000:00...</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104227] PCI: PHB (bus 0=
) bridge rsrc 4: 0000000000000000-00000000ffffffff [0x100]=2C parent c0305d=
f0 (PCI IO)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&g=
t=3B[ &nbsp=3B &nbsp=3B0.104228] PCI: PHB (bus 0) bridge rsrc 5: 0000000080=
000000-000000009fffffff [0x200]=2C parent c0305dc8 (PCI mem)</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.1=
04229] PCI: Allocating bus resources for 0000:01...</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104231] PC=
I: Allocating 0000:00:04.0: Resource 0: 0000000080000000..000000008001ffff =
[40200]</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B=
[ &nbsp=3B &nbsp=3B0.104231] PCI: Allocating 0000:00:04.0: Resource 1: 0000=
000080020000..000000008003ffff [40200]</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.104232] PCI: Allocating=
 0000:00:04.0: Resource 2: 0000000082040000..000000008204001f [40101]</font=
></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &n=
bsp=3B0.104233] PCI: Allocating 0000:00:04.0: Resource 6: 0000000083000000.=
.000000008301ffff [4e200]</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.104233] XXX_PCIE: pcibios_resource_s=
urvey():Done</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.105446] bio: create slab &lt=3Bbio-0&gt=3B at 0</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.105549] vgaarb: loaded</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.105719] Switching to cloc=
ksource timebase</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.107988] NET: Registered protocol family 2</f=
ont></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B=
 &nbsp=3B0.108411] IP route cache hash table entries: 2048 (order: 1=2C 819=
2 bytes)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.108475] TCP established hash table entries: 8192 (o=
rder: 4=2C 65536 bytes)</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.108507] TCP bind hash table entries: 8=
192 (order: 3=2C 32768 bytes)</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.108522] TCP: Hash tables configu=
red (established 8192 bind 8192)</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.108525] TCP reno registered</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.108527] UDP hash table entries: 256 (order: 0=2C 4096 bytes)<=
/font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.108530] UDP-Lite hash table entries: 256 (order: 0=2C 4096 by=
tes)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &=
nbsp=3B &nbsp=3B0.108557] NET: Registered protocol family 1</font></div><di=
v><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.10=
8561] PCI_QUIRKS : pci_apply_final_quirks</font></div><div><font face=3D"Ca=
libri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.108564] pci 0000:00:=
04.0: calling quirk_e100_interrupt+0x0/0x1b0</font></div><div><font face=3D=
"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.108565] pci 0000:=
00:04.0: calling quirk_cardbus_legacy+0x0/0x50</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.108566] pci 00=
00:00:04.0: calling quirk_usb_early_handoff+0x0/0x718</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.108567] =
PCI: CLS 128 bytes=2C default 32</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.108670] Trying to unpack root=
fs image as initramfs...</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.109118] rootfs image is not initramfs=
 (no cpio magic)=3B looks like an initrd</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.111639] Freeing initr=
d memory: 6264k freed</font></div><div><font face=3D"Calibri=2C sans-serif"=
>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.111883] msgmni has been set to 500</font=
></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &n=
bsp=3B0.111955] io scheduler noop registered</font></div><div><font face=3D=
"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.111958] io schedu=
ler deadline registered</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.111964] io scheduler cfq registered (d=
efault)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B=
[ &nbsp=3B &nbsp=3B0.128011] Serial: 8250/16550 driver=2C 4 ports=2C IRQ sh=
aring disabled</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B=
6&gt=3B[ &nbsp=3B &nbsp=3B0.129473] brd: module loaded</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.130417]=
 loop: module loaded</font></div><div><font face=3D"Calibri=2C sans-serif">=
&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.130446] Xilinx SystemACE device driver=2C=
 major=3D254</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.130558] e1000e: Intel(R) PRO/1000 Network Driver =
- 1.5.1-k</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.130562] e1000e: Copyright(c) 1999 - 2011 Intel Corp=
oration.</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.130567] e1000e 0000:00:04.0: Disabling ASPM &nbsp=
=3BL1</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.130569] e1000e 0000:00:04.0: enabling device (0000 -&gt=
=3B 0002)</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.130571] e1000e 0000:00:04.0: enabling bus mastering=
</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B3&gt=3B[ &nbsp=
=3B &nbsp=3B0.130595] e1000e 0000:00:04.0: (unregistered net_device): Faile=
d to initialize MSI interrupts. &nbsp=3BFalling back to legacy interrupts.<=
/font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.313821] e1000e 0000:00:04.0: eth0: (PCI Express:2.5GT/s:Width=
 x4) e4:1f:13:4f:28:d4</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.313825] e1000e 0000:00:04.0: eth0: Inte=
l(R) PRO/1000 Network Connection</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.313837] e1000e 0000:00:04.0: =
eth0: MAC: 0=2C PHY: 4=2C PBA No: E34292-004</font></div><div><font face=3D=
"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.313949] mousedev:=
 PS/2 mouse device common for all mice</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.314063] TCP cubic regis=
tered</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.314066] NET: Registered protocol family 17</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.=
314074] NET: Registered protocol family 15</font></div><div><font face=3D"C=
alibri=2C sans-serif">&lt=3B5&gt=3B[ &nbsp=3B &nbsp=3B0.314140] RAMDISK: gz=
ip image found at block 0</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B4&gt=3B[ &nbsp=3B &nbsp=3B0.369460] EXT2-fs (ram0): warning: mou=
nting unchecked fs=2C running e2fsck is recommended</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.369472] VF=
S: Mounted root (ext2 filesystem) on device 1:0.</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.369569] Freei=
ng unused kernel memory: 176k freed</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.369573] Executing _no_suc=
h_application</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B4=
&gt=3B[ &nbsp=3B &nbsp=3B0.369587] Failed to execute _no_such_application. =
&nbsp=3BAttempting defaults...</font></div><div><font face=3D"Calibri=2C sa=
ns-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.369588] Executing /sbin/hello_w=
orld</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &=
nbsp=3B &nbsp=3B0.369600] /sbin/hello_world --- Failed.</font></div><div><f=
ont face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.369601=
] Executing /sbin/init</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.371822] [U] lspci -vv</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.3728=
49] [U] 00:04.0 Class 0200: Device 8086:105e (rev 06)</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372854] =
[U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Subsys=
tem: Device 1014:0340</font></div><div><font face=3D"Calibri=2C sans-serif"=
>&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372856] [U] <span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>Control: I/O- Mem+ BusMaster+ SpecCycl=
e- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B=
0.372860] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</s=
pan>Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=3BTAbort- &=
lt=3BTAbort- &lt=3BMAbort- &gt=3BSERR- &lt=3BPERR- INTx-</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.37286=
2] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Lat=
ency: 0=2C Cache Line Size: 128 bytes</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372864] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Interrupt: pin A rout=
ed to IRQ 16</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.372866] [U] <span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>Region 0: Memory at 80000000 (32-bit=2C non-pr=
efetchable) [size=3D128K]</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372869] [U] <span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>Region 1: Memory at 80020000 (32-b=
it=2C non-prefetchable) [size=3D128K]</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372871] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Region 2: I/O ports a=
t 82040000 [disabled] [size=3D32]</font></div><div><font face=3D"Calibri=2C=
 sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372873] [U] <span class=3D"A=
pple-tab-span" style=3D"white-space:pre">	</span>Expansion ROM at 83000000 =
[disabled] [size=3D128K]</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372878] [U] <span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>Capabilities: [c8] Power Management=
 version 2</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.372881] [U] <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME=
(D0+=2CD1-=2CD2-=2CD3hot+=2CD3cold-)</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372884] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Status: D0 NoSoftRst=
- PME-Enable- DSel=3D0 DScale=3D1 PME-</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372886] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Capabilities: [d0] MS=
I: Enable- Count=3D1/1 Maskable- 64bit+</font></div><div><font face=3D"Cali=
bri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372888] [U] <span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">		</span>Address: 0000000000=
000000 &nbsp=3BData: 0000</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372891] [U] <span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>Capabilities: [e0] Express (v1) En=
dpoint=2C MSI 00</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372893] [U] <span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">		</span>DevCap:<span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>MaxPayload 256 bytes=2C PhantFunc 0=2C Laten=
cy L0s &lt=3B512ns=2C L1 &lt=3B64us</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372896] [U] <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">			</span>ExtTag- AttnBtn- At=
tnInd- PwrInd- RBE- FLReset-</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372898] [U] <span class=3D"Apple-=
tab-span" style=3D"white-space:pre">		</span>DevCtl:<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>Report errors: Correctable- Non-F=
atal- Fatal- Unsupported-</font></div><div><font face=3D"Calibri=2C sans-se=
rif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372900] [U] <span class=3D"Apple-tab=
-span" style=3D"white-space:pre">			</span>RlxdOrd+ ExtTag- PhantFunc- AuxP=
wr- NoSnoop+</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.372902] [U] <span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>MaxPayload 128 bytes=2C MaxReadReq 512 bytes=
</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.372904] [U] <span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>DevSta:<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.372907] [U] <span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>LnkCap:<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>Port #0=2C Speed 2.5GT/s=2C Width x4=2C ASPM L0s=2C Latency L=
0 &lt=3B4us=2C L1 &lt=3B64us</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372909] [U] <span class=3D"Apple-=
tab-span" style=3D"white-space:pre">			</span>ClockPM- Surprise- LLActRep- =
BwNot-</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[=
 &nbsp=3B &nbsp=3B0.372911] [U] <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>LnkCtl:<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>ASPM Disabled=3B RCB 64 bytes Disabled- Retrain- CommCl=
k-</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nb=
sp=3B &nbsp=3B0.372913] [U] <span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">			</span>ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.372916] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>LnkSta:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>Speed 2.5GT/s=2C Width x4=2C TrErr- Train- SlotClk+ DLActive- BWMgmt- =
ABWMgmt-</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.372920] [U] <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>Capabilities: [100 v1] Advanced Error Reporting</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.372923] [U] <span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>UESta:<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.372927] [U] <span class=3D"Apple-=
tab-span" style=3D"white-space:pre">		</span>UEMsk:<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">	</span>DLP- SDES- TLP- FCP- CmpltTO- Cmpl=
tAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.37293=
0] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>UE=
Svrt:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DLP+ =
SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq=
- ACSViol-</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.372933] [U] <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>CESta:<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalE=
rr-</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &n=
bsp=3B &nbsp=3B0.372935] [U] <span class=3D"Apple-tab-span" style=3D"white-=
space:pre">		</span>CEMsk:<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-</fo=
nt></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B =
&nbsp=3B0.372937] [U] <span class=3D"Apple-tab-span" style=3D"white-space:p=
re">		</span>AERCap:<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>First Error Pointer: 00=2C GenCap- CGenEn- ChkCap- ChkEn-</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbs=
p=3B0.372940] [U] <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>Capabilities: [140 v1] Device Serial Number e4-1f-13-ff-ff-4f-28-d4=
</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B &nbsp=3B0.372951] [U]&nbsp=3B</font></div><div><font face=3D"Calibri=2C=
 sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.373275] [U] 1.ifconfig eth0 =
10.10.10.10 netmask 255.0.0.0 up</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.373613] netdev.c:e1000_open</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.483627] netdev.c: e1000e_configure</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.483627] e1000=
_configure_rx: rdlen: 1000</font></div><div><font face=3D"Calibri=2C sans-s=
erif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509726] e1000_alloc_rx_buffers: buf=
fer_info[0]-&gt=3Bdma: 5ec97022=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.b=
uffer_addr=3B 2270c95e</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509732] e1000_alloc_rx_buffers: buffer_=
info[1]-&gt=3Bdma: 5f2ea822=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffe=
r_addr=3B 22a82e5f</font></div><div><font face=3D"Calibri=2C sans-serif">&l=
t=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509734] e1000_alloc_rx_buffers: buffer_info=
[2]-&gt=3Bdma: 5f2ea022=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_ad=
dr=3B 22a02e5f</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B=
7&gt=3B[ &nbsp=3B &nbsp=3B0.509739] e1000_alloc_rx_buffers: buffer_info[3]-=
&gt=3Bdma: 5f2cf822=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=
=3B 22f82c5f</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&=
gt=3B[ &nbsp=3B &nbsp=3B0.509742] e1000_alloc_rx_buffers: buffer_info[4]-&g=
t=3Bdma: 5f2cf022=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B =
22f02c5f</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=
=3B[ &nbsp=3B &nbsp=3B0.509747] e1000_alloc_rx_buffers: buffer_info[5]-&gt=
=3Bdma: 5f2d0822=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 2=
2082d5f</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B=
[ &nbsp=3B &nbsp=3B0.509750] e1000_alloc_rx_buffers: buffer_info[6]-&gt=3Bd=
ma: 5f2d0022=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22002=
d5f</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B0.509755] e1000_alloc_rx_buffers: buffer_info[7]-&gt=3Bdma: =
5f2d1822=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22182d5f<=
/font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B0.509757] e1000_alloc_rx_buffers: buffer_info[8]-&gt=3Bdma: 5f2=
d1022=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22102d5f</fo=
nt></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B =
&nbsp=3B0.509762] e1000_alloc_rx_buffers: buffer_info[9]-&gt=3Bdma: 5f2d282=
2=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22282d5f</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbs=
p=3B0.509765] e1000_alloc_rx_buffers: buffer_info[10]-&gt=3Bdma: 5f2d2022=
=2Crx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22202d5f</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.509770] e1000_alloc_rx_buffers: buffer_info[11]-&gt=3Bdma: 5f2d3822=2C=
rx_buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22382d5f</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B=
0.509773] e1000_alloc_rx_buffers: buffer_info[12]-&gt=3Bdma: 5f2d3022=2Crx_=
buffer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22302d5f</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.5=
09777] e1000_alloc_rx_buffers: buffer_info[13]-&gt=3Bdma: 5f2d4822=2Crx_buf=
fer_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22482d5f</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.5097=
80] e1000_alloc_rx_buffers: buffer_info[14]-&gt=3Bdma: 5f2d4022=2Crx_buffer=
_len:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22402d5f</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509785]=
 e1000_alloc_rx_buffers: buffer_info[15]-&gt=3Bdma: 5f2d5822=2Crx_buffer_le=
n:5f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22582d5f</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509788] e1=
000_alloc_rx_buffers: buffer_info[16]-&gt=3Bdma: 5f2d5022=2Crx_buffer_len:5=
f2=2C rx_desc-&gt=3Bread.buffer_addr=3B 22502d5f</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509792] e1000=
_alloc_rx_buffers: buffer_info[17]-&gt=3Bdma: 5f2d6822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22682d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509795] e1000_=
alloc_rx_buffers: buffer_info[18]-&gt=3Bdma: 5f2d6022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22602d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509799] e1000_=
alloc_rx_buffers: buffer_info[19]-&gt=3Bdma: 5f2d7822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22782d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509804] e1000_=
alloc_rx_buffers: buffer_info[20]-&gt=3Bdma: 5f2d7022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22702d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509808] e1000_=
alloc_rx_buffers: buffer_info[21]-&gt=3Bdma: 5f2d9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22982d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509811] e1000_=
alloc_rx_buffers: buffer_info[22]-&gt=3Bdma: 5f2d9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22902d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509816] e1000_=
alloc_rx_buffers: buffer_info[23]-&gt=3Bdma: 5f2da822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a82d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509819] e1000_=
alloc_rx_buffers: buffer_info[24]-&gt=3Bdma: 5f2da022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a02d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509823] e1000_=
alloc_rx_buffers: buffer_info[25]-&gt=3Bdma: 5f2db822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b82d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509826] e1000_=
alloc_rx_buffers: buffer_info[26]-&gt=3Bdma: 5f2db022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b02d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509830] e1000_=
alloc_rx_buffers: buffer_info[27]-&gt=3Bdma: 5f2dc822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c82d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509833] e1000_=
alloc_rx_buffers: buffer_info[28]-&gt=3Bdma: 5f2dc022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c02d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509838] e1000_=
alloc_rx_buffers: buffer_info[29]-&gt=3Bdma: 5f2c1822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22182c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509841] e1000_=
alloc_rx_buffers: buffer_info[30]-&gt=3Bdma: 5f2c1022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22102c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509845] e1000_=
alloc_rx_buffers: buffer_info[31]-&gt=3Bdma: 5f2c2822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22282c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509848] e1000_=
alloc_rx_buffers: buffer_info[32]-&gt=3Bdma: 5f2c2022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22202c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509852] e1000_=
alloc_rx_buffers: buffer_info[33]-&gt=3Bdma: 5f2c3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22382c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509855] e1000_=
alloc_rx_buffers: buffer_info[34]-&gt=3Bdma: 5f2c3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22302c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509860] e1000_=
alloc_rx_buffers: buffer_info[35]-&gt=3Bdma: 5f2c4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22482c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509863] e1000_=
alloc_rx_buffers: buffer_info[36]-&gt=3Bdma: 5f2c4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22402c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509868] e1000_=
alloc_rx_buffers: buffer_info[37]-&gt=3Bdma: 5f2c5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22582c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509871] e1000_=
alloc_rx_buffers: buffer_info[38]-&gt=3Bdma: 5f2c5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22502c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509875] e1000_=
alloc_rx_buffers: buffer_info[39]-&gt=3Bdma: 5f2ce822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e82c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509879] e1000_=
alloc_rx_buffers: buffer_info[40]-&gt=3Bdma: 5f2ce022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e02c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509884] e1000_=
alloc_rx_buffers: buffer_info[41]-&gt=3Bdma: 5f91f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509887] e1000_=
alloc_rx_buffers: buffer_info[42]-&gt=3Bdma: 5f91f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509891] e1000_=
alloc_rx_buffers: buffer_info[43]-&gt=3Bdma: 5f923822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2238925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509894] e1000_=
alloc_rx_buffers: buffer_info[44]-&gt=3Bdma: 5f923022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2230925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509898] e1000_=
alloc_rx_buffers: buffer_info[45]-&gt=3Bdma: 5f8ef822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f88e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509901] e1000_=
alloc_rx_buffers: buffer_info[46]-&gt=3Bdma: 5f8ef022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f08e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509906] e1000_=
alloc_rx_buffers: buffer_info[47]-&gt=3Bdma: 5f89b822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b8895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509909] e1000_=
alloc_rx_buffers: buffer_info[48]-&gt=3Bdma: 5f89b022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b0895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509913] e1000_=
alloc_rx_buffers: buffer_info[49]-&gt=3Bdma: 5f8e3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22388e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509916] e1000_=
alloc_rx_buffers: buffer_info[50]-&gt=3Bdma: 5f8e3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22308e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509921] e1000_=
alloc_rx_buffers: buffer_info[51]-&gt=3Bdma: 5f8eb822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b88e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509924] e1000_=
alloc_rx_buffers: buffer_info[52]-&gt=3Bdma: 5f8eb022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b08e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509928] e1000_=
alloc_rx_buffers: buffer_info[53]-&gt=3Bdma: 5f8e4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22488e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509931] e1000_=
alloc_rx_buffers: buffer_info[54]-&gt=3Bdma: 5f8e4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22408e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509935] e1000_=
alloc_rx_buffers: buffer_info[55]-&gt=3Bdma: 5f851822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2218855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509938] e1000_=
alloc_rx_buffers: buffer_info[56]-&gt=3Bdma: 5f851022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2210855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509943] e1000_=
alloc_rx_buffers: buffer_info[57]-&gt=3Bdma: 5f894822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2248895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509946] e1000_=
alloc_rx_buffers: buffer_info[58]-&gt=3Bdma: 5f894022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2240895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509950] e1000_=
alloc_rx_buffers: buffer_info[59]-&gt=3Bdma: 5f899822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2298895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509954] e1000_=
alloc_rx_buffers: buffer_info[60]-&gt=3Bdma: 5f899022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2290895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509959] e1000_=
alloc_rx_buffers: buffer_info[61]-&gt=3Bdma: 5f893822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2238895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509962] e1000_=
alloc_rx_buffers: buffer_info[62]-&gt=3Bdma: 5f893022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2230895f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509967] e1000_=
alloc_rx_buffers: buffer_info[63]-&gt=3Bdma: 5f9f1822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22189f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509969] e1000_=
alloc_rx_buffers: buffer_info[64]-&gt=3Bdma: 5f9f1022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22109f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509974] e1000_=
alloc_rx_buffers: buffer_info[65]-&gt=3Bdma: 5e3dc822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c83d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509977] e1000_=
alloc_rx_buffers: buffer_info[66]-&gt=3Bdma: 5e3dc022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c03d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509983] e1000_=
alloc_rx_buffers: buffer_info[67]-&gt=3Bdma: 5f84a822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a8845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509986] e1000_=
alloc_rx_buffers: buffer_info[68]-&gt=3Bdma: 5f84a022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a0845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509990] e1000_=
alloc_rx_buffers: buffer_info[69]-&gt=3Bdma: 5ec4e822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8c45e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509993] e1000_=
alloc_rx_buffers: buffer_info[70]-&gt=3Bdma: 5ec4e022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0c45e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.509998] e1000_=
alloc_rx_buffers: buffer_info[71]-&gt=3Bdma: 5ec4f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8c45e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510001] e1000_=
alloc_rx_buffers: buffer_info[72]-&gt=3Bdma: 5ec4f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0c45e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510005] e1000_=
alloc_rx_buffers: buffer_info[73]-&gt=3Bdma: 5f9f8822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22889f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510008] e1000_=
alloc_rx_buffers: buffer_info[74]-&gt=3Bdma: 5f9f8022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22809f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510013] e1000_=
alloc_rx_buffers: buffer_info[75]-&gt=3Bdma: 5f9f9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22989f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510016] e1000_=
alloc_rx_buffers: buffer_info[76]-&gt=3Bdma: 5f9f9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22909f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510020] e1000_=
alloc_rx_buffers: buffer_info[77]-&gt=3Bdma: 5f9a0822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22089a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510023] e1000_=
alloc_rx_buffers: buffer_info[78]-&gt=3Bdma: 5f9a0022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22009a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510028] e1000_=
alloc_rx_buffers: buffer_info[79]-&gt=3Bdma: 5f9a1822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22189a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510032] e1000_=
alloc_rx_buffers: buffer_info[80]-&gt=3Bdma: 5f9a1022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22109a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510036] e1000_=
alloc_rx_buffers: buffer_info[81]-&gt=3Bdma: 5f83f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8835f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510039] e1000_=
alloc_rx_buffers: buffer_info[82]-&gt=3Bdma: 5f83f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0835f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510044] e1000_=
alloc_rx_buffers: buffer_info[83]-&gt=3Bdma: 5f3fe822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e83f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510047] e1000_=
alloc_rx_buffers: buffer_info[84]-&gt=3Bdma: 5f3fe022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e03f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510051] e1000_=
alloc_rx_buffers: buffer_info[85]-&gt=3Bdma: 5f3ff822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f83f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510054] e1000_=
alloc_rx_buffers: buffer_info[86]-&gt=3Bdma: 5f3ff022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f03f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510058] e1000_=
alloc_rx_buffers: buffer_info[87]-&gt=3Bdma: 5ec36822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2268c35e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510061] e1000_=
alloc_rx_buffers: buffer_info[88]-&gt=3Bdma: 5ec36022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2260c35e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510066] e1000_=
alloc_rx_buffers: buffer_info[89]-&gt=3Bdma: 5ec37822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2278c35e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510069] e1000_=
alloc_rx_buffers: buffer_info[90]-&gt=3Bdma: 5ec37022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2270c35e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510073] e1000_=
alloc_rx_buffers: buffer_info[91]-&gt=3Bdma: 5f3c4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22483c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510076] e1000_=
alloc_rx_buffers: buffer_info[92]-&gt=3Bdma: 5f3c4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22403c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510081] e1000_=
alloc_rx_buffers: buffer_info[93]-&gt=3Bdma: 5f3c5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22583c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510084] e1000_=
alloc_rx_buffers: buffer_info[94]-&gt=3Bdma: 5f3c5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22503c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510088] e1000_=
alloc_rx_buffers: buffer_info[95]-&gt=3Bdma: 5ec04822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2248c05e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510091] e1000_=
alloc_rx_buffers: buffer_info[96]-&gt=3Bdma: 5ec04022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2240c05e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510096] e1000_=
alloc_rx_buffers: buffer_info[97]-&gt=3Bdma: 5ec05822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2258c05e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510099] e1000_=
alloc_rx_buffers: buffer_info[98]-&gt=3Bdma: 5ec05022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2250c05e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510103] e1000_=
alloc_rx_buffers: buffer_info[99]-&gt=3Bdma: 5ec16822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2268c15e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510108] e1000_=
alloc_rx_buffers: buffer_info[100]-&gt=3Bdma: 5ec16022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2260c15e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510112] e1000_=
alloc_rx_buffers: buffer_info[101]-&gt=3Bdma: 5ec66822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2268c65e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510115] e1000_=
alloc_rx_buffers: buffer_info[102]-&gt=3Bdma: 5ec66022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2260c65e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510120] e1000_=
alloc_rx_buffers: buffer_info[103]-&gt=3Bdma: 5ec67822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2278c65e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510122] e1000_=
alloc_rx_buffers: buffer_info[104]-&gt=3Bdma: 5ec67022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2270c65e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510127] e1000_=
alloc_rx_buffers: buffer_info[105]-&gt=3Bdma: 5f3f2822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22283f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510130] e1000_=
alloc_rx_buffers: buffer_info[106]-&gt=3Bdma: 5f3f2022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22203f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510134] e1000_=
alloc_rx_buffers: buffer_info[107]-&gt=3Bdma: 5f3f3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22383f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510137] e1000_=
alloc_rx_buffers: buffer_info[108]-&gt=3Bdma: 5f3f3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22303f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510142] e1000_=
alloc_rx_buffers: buffer_info[109]-&gt=3Bdma: 5eca2822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2228ca5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510144] e1000_=
alloc_rx_buffers: buffer_info[110]-&gt=3Bdma: 5eca2022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2220ca5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510149] e1000_=
alloc_rx_buffers: buffer_info[111]-&gt=3Bdma: 5eca3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2238ca5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510152] e1000_=
alloc_rx_buffers: buffer_info[112]-&gt=3Bdma: 5eca3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2230ca5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510156] e1000_=
alloc_rx_buffers: buffer_info[113]-&gt=3Bdma: 5f35c822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c8355f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510159] e1000_=
alloc_rx_buffers: buffer_info[114]-&gt=3Bdma: 5f35c022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c0355f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510164] e1000_=
alloc_rx_buffers: buffer_info[115]-&gt=3Bdma: 5f35d822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d8355f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510167] e1000_=
alloc_rx_buffers: buffer_info[116]-&gt=3Bdma: 5f35d022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d0355f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510171] e1000_=
alloc_rx_buffers: buffer_info[117]-&gt=3Bdma: 5f37e822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8375f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510174] e1000_=
alloc_rx_buffers: buffer_info[118]-&gt=3Bdma: 5f37e022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0375f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510179] e1000_=
alloc_rx_buffers: buffer_info[119]-&gt=3Bdma: 5f37f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8375f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510183] e1000_=
alloc_rx_buffers: buffer_info[120]-&gt=3Bdma: 5f37f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0375f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510187] e1000_=
alloc_rx_buffers: buffer_info[121]-&gt=3Bdma: 5f31f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8315f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510190] e1000_=
alloc_rx_buffers: buffer_info[122]-&gt=3Bdma: 5f31f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0315f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510195] e1000_=
alloc_rx_buffers: buffer_info[123]-&gt=3Bdma: 5f9fc822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c89f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510198] e1000_=
alloc_rx_buffers: buffer_info[124]-&gt=3Bdma: 5f9fc022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c09f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510202] e1000_=
alloc_rx_buffers: buffer_info[125]-&gt=3Bdma: 5f9fd822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d89f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510205] e1000_=
alloc_rx_buffers: buffer_info[126]-&gt=3Bdma: 5f9fd022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d09f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510210] e1000_=
alloc_rx_buffers: buffer_info[127]-&gt=3Bdma: 5f3ac822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c83a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510213] e1000_=
alloc_rx_buffers: buffer_info[128]-&gt=3Bdma: 5f3ac022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c03a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510217] e1000_=
alloc_rx_buffers: buffer_info[129]-&gt=3Bdma: 5f3ad822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d83a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510220] e1000_=
alloc_rx_buffers: buffer_info[130]-&gt=3Bdma: 5f3ad022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d03a5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510225] e1000_=
alloc_rx_buffers: buffer_info[131]-&gt=3Bdma: 5ec9e822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8c95e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510228] e1000_=
alloc_rx_buffers: buffer_info[132]-&gt=3Bdma: 5ec9e022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0c95e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510232] e1000_=
alloc_rx_buffers: buffer_info[133]-&gt=3Bdma: 5ec9f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8c95e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510235] e1000_=
alloc_rx_buffers: buffer_info[134]-&gt=3Bdma: 5ec9f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0c95e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510240] e1000_=
alloc_rx_buffers: buffer_info[135]-&gt=3Bdma: 5ecce822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510243] e1000_=
alloc_rx_buffers: buffer_info[136]-&gt=3Bdma: 5ecce022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510247] e1000_=
alloc_rx_buffers: buffer_info[137]-&gt=3Bdma: 5eccf822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510250] e1000_=
alloc_rx_buffers: buffer_info[138]-&gt=3Bdma: 5eccf022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510255] e1000_=
alloc_rx_buffers: buffer_info[139]-&gt=3Bdma: 5d3de822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e83d5d</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510259] e1000_=
alloc_rx_buffers: buffer_info[140]-&gt=3Bdma: 5d3de022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e03d5d</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510263] e1000_=
alloc_rx_buffers: buffer_info[141]-&gt=3Bdma: 5f9d4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22489d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510266] e1000_=
alloc_rx_buffers: buffer_info[142]-&gt=3Bdma: 5f9d4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22409d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510271] e1000_=
alloc_rx_buffers: buffer_info[143]-&gt=3Bdma: 5f9d5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22589d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510274] e1000_=
alloc_rx_buffers: buffer_info[144]-&gt=3Bdma: 5f9d5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22509d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510278] e1000_=
alloc_rx_buffers: buffer_info[145]-&gt=3Bdma: 5f9b4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22489b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510281] e1000_=
alloc_rx_buffers: buffer_info[146]-&gt=3Bdma: 5f9b4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22409b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510286] e1000_=
alloc_rx_buffers: buffer_info[147]-&gt=3Bdma: 5f9b5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22589b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510288] e1000_=
alloc_rx_buffers: buffer_info[148]-&gt=3Bdma: 5f9b5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22509b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510293] e1000_=
alloc_rx_buffers: buffer_info[149]-&gt=3Bdma: 5f91c822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c8915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510296] e1000_=
alloc_rx_buffers: buffer_info[150]-&gt=3Bdma: 5f91c022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c0915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510300] e1000_=
alloc_rx_buffers: buffer_info[151]-&gt=3Bdma: 5f91d822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d8915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510303] e1000_=
alloc_rx_buffers: buffer_info[152]-&gt=3Bdma: 5f91d022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d0915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510308] e1000_=
alloc_rx_buffers: buffer_info[153]-&gt=3Bdma: 5f2cc822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c82c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510311] e1000_=
alloc_rx_buffers: buffer_info[154]-&gt=3Bdma: 5f2cc022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c02c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510315] e1000_=
alloc_rx_buffers: buffer_info[155]-&gt=3Bdma: 5f2cd822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d82c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510318] e1000_=
alloc_rx_buffers: buffer_info[156]-&gt=3Bdma: 5f2cd022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d02c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510323] e1000_=
alloc_rx_buffers: buffer_info[157]-&gt=3Bdma: 5f2c8822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22882c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510326] e1000_=
alloc_rx_buffers: buffer_info[158]-&gt=3Bdma: 5f2c8022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22802c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510330] e1000_=
alloc_rx_buffers: buffer_info[159]-&gt=3Bdma: 5f2c9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22982c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510334] e1000_=
alloc_rx_buffers: buffer_info[160]-&gt=3Bdma: 5f2c9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22902c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510339] e1000_=
alloc_rx_buffers: buffer_info[161]-&gt=3Bdma: 5f2cb822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b82c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510342] e1000_=
alloc_rx_buffers: buffer_info[162]-&gt=3Bdma: 5f2cb022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b02c5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510346] e1000_=
alloc_rx_buffers: buffer_info[163]-&gt=3Bdma: 5f840822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2208845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510349] e1000_=
alloc_rx_buffers: buffer_info[164]-&gt=3Bdma: 5f840022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2200845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510354] e1000_=
alloc_rx_buffers: buffer_info[165]-&gt=3Bdma: 5f841822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2218845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510357] e1000_=
alloc_rx_buffers: buffer_info[166]-&gt=3Bdma: 5f841022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2210845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510361] e1000_=
alloc_rx_buffers: buffer_info[167]-&gt=3Bdma: 5f842822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2228845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510364] e1000_=
alloc_rx_buffers: buffer_info[168]-&gt=3Bdma: 5f842022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2220845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510368] e1000_=
alloc_rx_buffers: buffer_info[169]-&gt=3Bdma: 5f843822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2238845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510371] e1000_=
alloc_rx_buffers: buffer_info[170]-&gt=3Bdma: 5f843022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2230845f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510376] e1000_=
alloc_rx_buffers: buffer_info[171]-&gt=3Bdma: 5f854822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2248855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510379] e1000_=
alloc_rx_buffers: buffer_info[172]-&gt=3Bdma: 5f854022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2240855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510383] e1000_=
alloc_rx_buffers: buffer_info[173]-&gt=3Bdma: 5f855822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2258855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510386] e1000_=
alloc_rx_buffers: buffer_info[174]-&gt=3Bdma: 5f855022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2250855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510391] e1000_=
alloc_rx_buffers: buffer_info[175]-&gt=3Bdma: 5f856822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2268855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510394] e1000_=
alloc_rx_buffers: buffer_info[176]-&gt=3Bdma: 5f856022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2260855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510398] e1000_=
alloc_rx_buffers: buffer_info[177]-&gt=3Bdma: 5f857822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2278855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510401] e1000_=
alloc_rx_buffers: buffer_info[178]-&gt=3Bdma: 5f857022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2270855f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510406] e1000_=
alloc_rx_buffers: buffer_info[179]-&gt=3Bdma: 5f918822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2288915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510410] e1000_=
alloc_rx_buffers: buffer_info[180]-&gt=3Bdma: 5f918022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2280915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510414] e1000_=
alloc_rx_buffers: buffer_info[181]-&gt=3Bdma: 5f91a822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a8915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510417] e1000_=
alloc_rx_buffers: buffer_info[182]-&gt=3Bdma: 5f91a022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a0915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510422] e1000_=
alloc_rx_buffers: buffer_info[183]-&gt=3Bdma: 5f91b822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b8915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510424] e1000_=
alloc_rx_buffers: buffer_info[184]-&gt=3Bdma: 5f91b022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b0915f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510431] e1000_=
alloc_rx_buffers: buffer_info[185]-&gt=3Bdma: 5f958822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2288955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510434] e1000_=
alloc_rx_buffers: buffer_info[186]-&gt=3Bdma: 5f958022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2280955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510438] e1000_=
alloc_rx_buffers: buffer_info[187]-&gt=3Bdma: 5f95a822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a8955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510441] e1000_=
alloc_rx_buffers: buffer_info[188]-&gt=3Bdma: 5f95a022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a0955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510445] e1000_=
alloc_rx_buffers: buffer_info[189]-&gt=3Bdma: 5f95b822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b8955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510448] e1000_=
alloc_rx_buffers: buffer_info[190]-&gt=3Bdma: 5f95b022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b0955f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510453] e1000_=
alloc_rx_buffers: buffer_info[191]-&gt=3Bdma: 5f9b0822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22089b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510456] e1000_=
alloc_rx_buffers: buffer_info[192]-&gt=3Bdma: 5f9b0022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22009b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510460] e1000_=
alloc_rx_buffers: buffer_info[193]-&gt=3Bdma: 5f9b1822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22189b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510463] e1000_=
alloc_rx_buffers: buffer_info[194]-&gt=3Bdma: 5f9b1022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22109b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510468] e1000_=
alloc_rx_buffers: buffer_info[195]-&gt=3Bdma: 5f9b2822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22289b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510471] e1000_=
alloc_rx_buffers: buffer_info[196]-&gt=3Bdma: 5f9b2022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22209b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510476] e1000_=
alloc_rx_buffers: buffer_info[197]-&gt=3Bdma: 5f9b3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22389b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510479] e1000_=
alloc_rx_buffers: buffer_info[198]-&gt=3Bdma: 5f9b3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22309b5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510483] e1000_=
alloc_rx_buffers: buffer_info[199]-&gt=3Bdma: 5f96c822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c8965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510487] e1000_=
alloc_rx_buffers: buffer_info[200]-&gt=3Bdma: 5f96c022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c0965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510492] e1000_=
alloc_rx_buffers: buffer_info[201]-&gt=3Bdma: 5f96e822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510495] e1000_=
alloc_rx_buffers: buffer_info[202]-&gt=3Bdma: 5f96e022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510499] e1000_=
alloc_rx_buffers: buffer_info[203]-&gt=3Bdma: 5f96f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510502] e1000_=
alloc_rx_buffers: buffer_info[204]-&gt=3Bdma: 5f96f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0965f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510506] e1000_=
alloc_rx_buffers: buffer_info[205]-&gt=3Bdma: 5f92c822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c8925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510509] e1000_=
alloc_rx_buffers: buffer_info[206]-&gt=3Bdma: 5f92c022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22c0925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510514] e1000_=
alloc_rx_buffers: buffer_info[207]-&gt=3Bdma: 5f92d822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d8925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510516] e1000_=
alloc_rx_buffers: buffer_info[208]-&gt=3Bdma: 5f92d022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22d0925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510521] e1000_=
alloc_rx_buffers: buffer_info[209]-&gt=3Bdma: 5f92e822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e8925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510524] e1000_=
alloc_rx_buffers: buffer_info[210]-&gt=3Bdma: 5f92e022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22e0925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510529] e1000_=
alloc_rx_buffers: buffer_info[211]-&gt=3Bdma: 5f92f822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f8925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510531] e1000_=
alloc_rx_buffers: buffer_info[212]-&gt=3Bdma: 5f92f022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22f0925f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510536] e1000_=
alloc_rx_buffers: buffer_info[213]-&gt=3Bdma: 5f9e4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22489e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510539] e1000_=
alloc_rx_buffers: buffer_info[214]-&gt=3Bdma: 5f9e4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22409e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510543] e1000_=
alloc_rx_buffers: buffer_info[215]-&gt=3Bdma: 5f9e5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22589e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510546] e1000_=
alloc_rx_buffers: buffer_info[216]-&gt=3Bdma: 5f9e5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22509e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510551] e1000_=
alloc_rx_buffers: buffer_info[217]-&gt=3Bdma: 5f9e6822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22689e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510554] e1000_=
alloc_rx_buffers: buffer_info[218]-&gt=3Bdma: 5f9e6022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22609e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510558] e1000_=
alloc_rx_buffers: buffer_info[219]-&gt=3Bdma: 5f9e7822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22789e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510563] e1000_=
alloc_rx_buffers: buffer_info[220]-&gt=3Bdma: 5f9e7022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22709e5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510567] e1000_=
alloc_rx_buffers: buffer_info[221]-&gt=3Bdma: 5f9d1822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22189d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510570] e1000_=
alloc_rx_buffers: buffer_info[222]-&gt=3Bdma: 5f9d1022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22109d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510575] e1000_=
alloc_rx_buffers: buffer_info[223]-&gt=3Bdma: 5f9d2822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22289d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510578] e1000_=
alloc_rx_buffers: buffer_info[224]-&gt=3Bdma: 5f9d2022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22209d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510582] e1000_=
alloc_rx_buffers: buffer_info[225]-&gt=3Bdma: 5f9d3822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22389d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510585] e1000_=
alloc_rx_buffers: buffer_info[226]-&gt=3Bdma: 5f9d3022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22309d5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510589] e1000_=
alloc_rx_buffers: buffer_info[227]-&gt=3Bdma: 5f9f4822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22489f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510592] e1000_=
alloc_rx_buffers: buffer_info[228]-&gt=3Bdma: 5f9f4022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22409f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510597] e1000_=
alloc_rx_buffers: buffer_info[229]-&gt=3Bdma: 5f9f5822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22589f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510599] e1000_=
alloc_rx_buffers: buffer_info[230]-&gt=3Bdma: 5f9f5022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22509f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510604] e1000_=
alloc_rx_buffers: buffer_info[231]-&gt=3Bdma: 5f9f6822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22689f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510607] e1000_=
alloc_rx_buffers: buffer_info[232]-&gt=3Bdma: 5f9f6022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22609f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510611] e1000_=
alloc_rx_buffers: buffer_info[233]-&gt=3Bdma: 5f9f7822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22789f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510614] e1000_=
alloc_rx_buffers: buffer_info[234]-&gt=3Bdma: 5f9f7022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22709f5f</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510619] e1000_=
alloc_rx_buffers: buffer_info[235]-&gt=3Bdma: 5e3d8822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22883d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510622] e1000_=
alloc_rx_buffers: buffer_info[236]-&gt=3Bdma: 5e3d8022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22803d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510627] e1000_=
alloc_rx_buffers: buffer_info[237]-&gt=3Bdma: 5e3d9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22983d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510630] e1000_=
alloc_rx_buffers: buffer_info[238]-&gt=3Bdma: 5e3d9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22903d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510634] e1000_=
alloc_rx_buffers: buffer_info[239]-&gt=3Bdma: 5e3da822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a83d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510638] e1000_=
alloc_rx_buffers: buffer_info[240]-&gt=3Bdma: 5e3da022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a03d5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510642] e1000_=
alloc_rx_buffers: buffer_info[241]-&gt=3Bdma: 5ecb8822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2288cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510645] e1000_=
alloc_rx_buffers: buffer_info[242]-&gt=3Bdma: 5ecb8022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2280cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510650] e1000_=
alloc_rx_buffers: buffer_info[243]-&gt=3Bdma: 5ecb9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2298cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510653] e1000_=
alloc_rx_buffers: buffer_info[244]-&gt=3Bdma: 5ecb9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2290cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510657] e1000_=
alloc_rx_buffers: buffer_info[245]-&gt=3Bdma: 5ecba822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a8cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510660] e1000_=
alloc_rx_buffers: buffer_info[246]-&gt=3Bdma: 5ecba022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a0cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510665] e1000_=
alloc_rx_buffers: buffer_info[247]-&gt=3Bdma: 5ecbb822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b8cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510667] e1000_=
alloc_rx_buffers: buffer_info[248]-&gt=3Bdma: 5ecbb022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22b0cb5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510672] e1000_=
alloc_rx_buffers: buffer_info[249]-&gt=3Bdma: 5ecc8822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2288cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510675] e1000_=
alloc_rx_buffers: buffer_info[250]-&gt=3Bdma: 5ecc8022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2280cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510680] e1000_=
alloc_rx_buffers: buffer_info[251]-&gt=3Bdma: 5ecc9822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2298cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510683] e1000_=
alloc_rx_buffers: buffer_info[252]-&gt=3Bdma: 5ecc9022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 2290cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510687] e1000_=
alloc_rx_buffers: buffer_info[253]-&gt=3Bdma: 5ecca822=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a8cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510690] e1000_=
alloc_rx_buffers: buffer_info[254]-&gt=3Bdma: 5ecca022=2Crx_buffer_len:5f2=
=2C rx_desc-&gt=3Bread.buffer_addr=3B 22a0cc5e</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510697] e1000_=
intr: ICR: 80000004</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510700] e1000_clean_rx_irq:staterr: 0=2C s=
kb-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_a=
ddr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0</font></div><div><font f=
ace=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.510701] 227=
0c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &n=
bsp=3B &nbsp=3B 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.511312] [U] ethtool -d eth0</font></div><div=
><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512=
139] [U] MAC Registers</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512143] [U] -------------</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.=
512196] [U] 0x00000: CTRL (Device control register) &nbsp=3B0x400C0241</fon=
t></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &=
nbsp=3B0.512200] [U] &nbsp=3B &nbsp=3B &nbsp=3B Endian mode (buffers): &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B little</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.51220=
2] [U] &nbsp=3B &nbsp=3B &nbsp=3B Link reset: &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3Bnormal</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.512204] [U] &nbsp=3B &nbsp=3B &nbsp=3B Set link up:=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B 1</font></div><div><font face=3D"Calibri=2C sans-s=
erif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512206] [U] &nbsp=3B &nbsp=3B &nbsp=
=3B Invert Loss-Of-Signal: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B no</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.512208] [U] &nbsp=3B &nbsp=3B &nbsp=3B Receive flow=
 control: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bdis=
abled</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.512210] [U] &nbsp=3B &nbsp=3B &nbsp=3B Transmit flow con=
trol: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B disabled</font>=
</div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nb=
sp=3B0.512212] [U] &nbsp=3B &nbsp=3B &nbsp=3B VLAN mode: &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B &nbsp=3B enabled</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512214] [U] &nbsp=3B &nbsp=3B &nbsp=3B =
Auto speed detect: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B disabled</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512216] [U] &nbsp=3B &nbsp=3B &nbsp=
=3B Speed select: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B1000Mb/s</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512218] [U] =
&nbsp=3B &nbsp=3B &nbsp=3B Force speed: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B no</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.512219] [U] &nbsp=3B &nbsp=3B &nbsp=3B Force duplex: &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3Bno</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.512221] [U] 0x00008: STATUS (Device status register=
) 0x00080341</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B &nbsp=3B0.512223] [U] &nbsp=3B &nbsp=3B &nbsp=3B Duplex: &n=
bsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bfull</font></div><div><font=
 face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512225] [=
U] &nbsp=3B &nbsp=3B &nbsp=3B Link up: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B no link config</font></div><div><font face=3D"Calibri=2C sans-serif">=
&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512227] [U] &nbsp=3B &nbsp=3B &nbsp=3B TB=
I mode: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bdisabled</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.5122=
29] [U] &nbsp=3B &nbsp=3B &nbsp=3B Link speed: &nbsp=3B &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B100Mb/s</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&g=
t=3B[ &nbsp=3B &nbsp=3B0.512231] [U] &nbsp=3B &nbsp=3B &nbsp=3B Bus type: &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3BPCI Express</font></div><div><font =
face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512233] [U=
] &nbsp=3B &nbsp=3B &nbsp=3B Port number: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B 0</font>=
</div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nb=
sp=3B0.512234] [U] 0x00100: RCTL (Receive control register) 0x04008002</fon=
t></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &=
nbsp=3B0.512236] [U] &nbsp=3B &nbsp=3B &nbsp=3B Receiver: &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3Benabled</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512238] [U] &nbsp=3B &nbsp=3B =
&nbsp=3B Store bad packets: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B disabled</font></div><div><font face=3D"Calibri=2C=
 sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512240] [U] &nbsp=3B &nbsp=
=3B &nbsp=3B Unicast promiscuous: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B disabled</font></div><div><font face=3D"Calibri=2C sa=
ns-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512242] [U] &nbsp=3B &nbsp=3B &=
nbsp=3B Multicast promiscuous: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 &nbsp=3B disabled</font></div><div><font face=3D"Calibri=2C sans-serif">&l=
t=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512244] [U] &nbsp=3B &nbsp=3B &nbsp=3B Long=
 packet: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B disabled</font></div><div><font face=3D"Ca=
libri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512246] [U] &nbsp=3B=
 &nbsp=3B &nbsp=3B Descriptor minimum threshold size: 1/2</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.5122=
47] [U] &nbsp=3B &nbsp=3B &nbsp=3B Broadcast accept mode: &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B accept</font></div><div><font face=3D"=
Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512249] [U] &nbsp=
=3B &nbsp=3B &nbsp=3B VLAN filter: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B disabled</font><=
/div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbs=
p=3B0.512251] [U] &nbsp=3B &nbsp=3B &nbsp=3B Canonical form indicator: &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bdisabled</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512253] [U] &=
nbsp=3B &nbsp=3B &nbsp=3B Discard pause frames: &nbsp=3B &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bfiltered</font></div><div><font face=3D"=
Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512255] [U] &nbsp=
=3B &nbsp=3B &nbsp=3B Pass MAC control frames: &nbsp=3B &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B don't pass</font></div><div><font face=3D"Calibri=2C sans-=
serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512256] [U] &nbsp=3B &nbsp=3B &nbs=
p=3B Receive buffer size: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B 2048</font></div><div><font face=3D"Calibri=2C sans-serif">&l=
t=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512258] [U] 0x02808: RDLEN (Receive desc le=
ngth) &nbsp=3B &nbsp=3B 0x00001000</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512260] [U] 0x02810: RDH =
&nbsp=3B (Receive desc head) &nbsp=3B &nbsp=3B &nbsp=3B 0x00000000</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.512262] [U] 0x02818: RDT &nbsp=3B (Receive desc tail) &nbsp=3B &nbsp=
=3B &nbsp=3B 0x000000F0</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512264] [U] 0x02820: RDTR &nbsp=3B(Rec=
eive delay timer) &nbsp=3B &nbsp=3B 0x00000020</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512265] [U] 0x=
00400: TCTL (Transmit ctrl register) &nbsp=3B 0x3103F0F8</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.51226=
7] [U] &nbsp=3B &nbsp=3B &nbsp=3B Transmitter: &nbsp=3B &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B disa=
bled</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &=
nbsp=3B &nbsp=3B0.512269] [U] &nbsp=3B &nbsp=3B &nbsp=3B Pad short packets:=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B en=
abled</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B &nbsp=3B0.512271] [U] &nbsp=3B &nbsp=3B &nbsp=3B Software XOFF Tra=
nsmission: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bdisabled</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512273]=
 [U] &nbsp=3B &nbsp=3B &nbsp=3B Re-transmit on late collision: &nbsp=3B &nb=
sp=3B enabled</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6=
&gt=3B[ &nbsp=3B &nbsp=3B0.512274] [U] 0x03808: TDLEN (Transmit desc length=
) &nbsp=3B &nbsp=3B0x00001000</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512276] [U] 0x03810: TDH &nbsp=
=3B (Transmit desc head) &nbsp=3B &nbsp=3B &nbsp=3B0x00000000</font></div><=
div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.=
512278] [U] 0x03818: TDT &nbsp=3B (Transmit desc tail) &nbsp=3B &nbsp=3B &n=
bsp=3B0x00000000</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512280] [U] 0x03820: TIDV &nbsp=3B(Transmit =
delay timer) &nbsp=3B &nbsp=3B0x00000008</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.512281] [U] PHY type:=
 &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bunknow=
n</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbs=
p=3B &nbsp=3B0.512641] [U] 3.ping 10.10.10.2 -c 3</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=3B0.513100] [U] =
PING 10.10.10.2 (10.10.10.2): 56 data bytes</font></div><div><font face=3D"=
Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.513845] e1000_intr=
: ICR: 80000010</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.513847] e1000_clean_rx_irq:staterr: 0=2C skb=
-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_add=
r:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0</font></div><div><font fac=
e=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.513848] 2270c=
95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbs=
p=3B &nbsp=3B 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.561398] e1000_intr: ICR: 80000004</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=
=3B0.561400] e1000_clean_rx_irq:staterr: 0=2C skb-&gt=3Blen: 0=2C skb-&gt=
=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 227=
0c95e=2C buf_info.len: 0</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.561400] 2270c95e &nbsp=3B &nbsp=3B &n=
bsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B &nbsp=
=3B0.562524] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex=2C Flow Contr=
ol: Rx/Tx</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B &nbsp=3B0.562528] e1000e 0000:00:04.0: eth0: 10/100 speed: di=
sabling TSO</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&g=
t=3B[ &nbsp=3B &nbsp=3B0.562536] e1000_intr: ICR: 80000012</font></div><div=
><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B0.562=
537] e1000_clean_rx_irq:staterr: 0=2C skb-&gt=3Blen: 0=2C skb-&gt=3Bdata_le=
n: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C b=
uf_info.len: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B=
7&gt=3B[ &nbsp=3B &nbsp=3B0.562538] 2270c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &=
nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0</font></div><div><=
font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B2.82613=
6] e1000_intr: ICR: 80000011</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B2.826138] e1000_clean_rx_irq:stater=
r: 0=2C skb-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_d=
esc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0</font></div><di=
v><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B2.82=
6139] 2270c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &n=
bsp=3B &nbsp=3B &nbsp=3B 0</font></div><div><font face=3D"Calibri=2C sans-s=
erif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B4.821733] e1000_intr: ICR: 80000011</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B4.821735] e1000_clean_rx_irq:staterr: 0=2C skb-&gt=3Blen: 0=2C =
skb-&gt=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.d=
ma: 2270c95e=2C buf_info.len: 0</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B4.821736] 2270c95e &nbsp=3B &nbs=
p=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=
=3B &nbsp=3B6.821727] e1000_intr: ICR: 80000010</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B6.821728] e1000_=
clean_rx_irq:staterr: 0=2C skb-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cring=
.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.len=
: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &n=
bsp=3B &nbsp=3B6.821729] 2270c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nb=
sp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B8.821732] e1000_=
intr: ICR: 80000010</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B8.821734] e1000_clean_rx_irq:staterr: 0=2C s=
kb-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cring.rx_desc[0]=2C rx_desc.buf_a=
ddr:0=2C buf_info.dma: 2270c95e=2C buf_info.len: 0</font></div><div><font f=
ace=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B &nbsp=3B8.821735] 227=
0c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &n=
bsp=3B &nbsp=3B 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B7&gt=3B[ &nbsp=3B 10.821727] e1000_intr: ICR: 80000010</font></div><div>=
<font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[ &nbsp=3B 10.821728] e10=
00_clean_rx_irq:staterr: 0=2C skb-&gt=3Blen: 0=2C skb-&gt=3Bdata_len: 0=2Cr=
ing.rx_desc[0]=2C rx_desc.buf_addr:0=2C buf_info.dma: 2270c95e=2C buf_info.=
len: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B7&gt=3B[=
 &nbsp=3B 10.821729] 2270c95e &nbsp=3B &nbsp=3B &nbsp=3B 0 &nbsp=3B &nbsp=
=3B &nbsp=3B 0 &nbsp=3B &nbsp=3B &nbsp=3B 0</font></div><div><font face=3D"=
Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.529730] [U]&nbsp=3B</font=
></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12=
.529734] [U] --- 10.10.10.2 ping statistics ---</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.529737] [U] 3 packets=
 transmitted=2C 0 packets received=2C 100% packet loss</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.530068] [U] ca=
t /proc/interrupts</font></div><div><font face=3D"Calibri=2C sans-serif">&l=
t=3B6&gt=3B[ &nbsp=3B 12.530432] [U] &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3BCPU0 &nbsp=3B &nbsp=3B &nbsp=3B&nbsp=3B</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.530435] [U] &n=
bsp=3B16: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B 18 &nbsp=3BXXX INTC Level &nb=
sp=3B &nbsp=3B eth0</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B6&gt=3B[ &nbsp=3B 12.530436] [U] LOC: &nbsp=3B &nbsp=3B &nbsp=3B 3132 =
&nbsp=3B Local timer interrupts</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.530438] [U] SPU: &nbsp=3B &nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B0 &nbsp=3B Spurious interrupts</font></div><div><fo=
nt face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.530439] [U] CN=
T: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B0 &nbsp=3B Performance monit=
oring interrupts</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B 12.530440] [U] MCE: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B0 &nbsp=3B Machine check exceptions</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.530770] [U] cat /proc=
/meminfo | grep em</font></div><div><font face=3D"Calibri=2C sans-serif">&l=
t=3B6&gt=3B[ &nbsp=3B 12.531658] [U] executing /home/stat.sh</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.532611] =
[U] 1) stat.sh: ifconfig eth0</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533383] [U] eth0 &nbsp=3B &nbsp=3B &nbs=
p=3BLink encap:Ethernet &nbsp=3BHWaddr E4:1F:13:4F:28:D4 &nbsp=3B</font></d=
iv><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533=
400] [U] &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B inet addr:10.10.10.11=
1 &nbsp=3BBcast:10.255.255.255 &nbsp=3BMask:255.0.0.0</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533428] [U] &nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B UP BROADCAST RUNNING MULTICAST &n=
bsp=3BMTU:1500 &nbsp=3BMetric:1</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533439] [U] &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B RX packets:2 errors:0 dropped:0 overruns:0 frame:0</f=
ont></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B=
 12.533447] [U] &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B TX packets:2 e=
rrors:0 dropped:0 overruns:0 carrier:0</font></div><div><font face=3D"Calib=
ri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533453] [U] &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B collisions:0 txqueuelen:1000&nbsp=3B</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.53346=
5] [U] &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B RX bytes:128 (128.0 B) =
&nbsp=3BTX bytes:128 (128.0 B)</font></div><div><font face=3D"Calibri=2C sa=
ns-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.533472] [U] &nbsp=3B &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B Interrupt:16 Memory:80000000-80020000&nbsp=3B</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.5334=
74] [U]&nbsp=3B</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B 12.533832] [U] 1) stat.sh: ethtool -S eth0 | grep x_pa=
ck</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nb=
sp=3B 12.534042] [U] NIC statistics:</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534049] [U] &nbsp=3B &nbsp=3B &n=
bsp=3Brx_packets: 2</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B6&gt=3B[ &nbsp=3B 12.534050] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_packets:=
 2</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nb=
sp=3B 12.534051] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_bytes: 128</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534052] =
[U] &nbsp=3B &nbsp=3B &nbsp=3Btx_bytes: 128</font></div><div><font face=3D"=
Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534054] [U] &nbsp=3B &nbs=
p=3B &nbsp=3Brx_broadcast: 0</font></div><div><font face=3D"Calibri=2C sans=
-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534055] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx=
_broadcast: 2</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6=
&gt=3B[ &nbsp=3B 12.534056] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_multicast: 0</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B 12.534057] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_multicast: 0</font></div><d=
iv><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534059] =
[U] &nbsp=3B &nbsp=3B &nbsp=3Brx_errors: 0</font></div><div><font face=3D"C=
alibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534060] [U] &nbsp=3B &nbsp=
=3B &nbsp=3Btx_errors: 0</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B 12.534061] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_dro=
pped: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B=
[ &nbsp=3B 12.534062] [U] &nbsp=3B &nbsp=3B &nbsp=3Bmulticast: 0</font></di=
v><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.5340=
64] [U] &nbsp=3B &nbsp=3B &nbsp=3Bcollisions: 0</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534065] [U] &nbsp=3B =
&nbsp=3B &nbsp=3Brx_length_errors: 0</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534066] [U] &nbsp=3B &nbsp=3B &n=
bsp=3Brx_over_errors: 0</font></div><div><font face=3D"Calibri=2C sans-seri=
f">&lt=3B6&gt=3B[ &nbsp=3B 12.534067] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_crc_=
errors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=
=3B[ &nbsp=3B 12.534069] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_frame_errors: 0</=
font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B 12.534070] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_no_buffer_count: 0</font></=
div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.53=
4071] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_missed_errors: 0</font></div><div><f=
ont face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534073] [U] &=
nbsp=3B &nbsp=3B &nbsp=3Btx_aborted_errors: 0</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534074] [U] &nbsp=3B =
&nbsp=3B &nbsp=3Btx_carrier_errors: 0</font></div><div><font face=3D"Calibr=
i=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534075] [U] &nbsp=3B &nbsp=3B &=
nbsp=3Btx_fifo_errors: 0</font></div><div><font face=3D"Calibri=2C sans-ser=
if">&lt=3B6&gt=3B[ &nbsp=3B 12.534077] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_hea=
rtbeat_errors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B 12.534078] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_window_err=
ors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[=
 &nbsp=3B 12.534079] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_abort_late_coll: 0</f=
ont></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B=
 12.534081] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_deferred_ok: 0</font></div><di=
v><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534082] [=
U] &nbsp=3B &nbsp=3B &nbsp=3Btx_single_coll_ok: 0</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534083] [U] &nbsp=
=3B &nbsp=3B &nbsp=3Btx_multi_coll_ok: 0</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534085] [U] &nbsp=3B &nbsp=
=3B &nbsp=3Btx_timeout_count: 0</font></div><div><font face=3D"Calibri=2C s=
ans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534086] [U] &nbsp=3B &nbsp=3B &nbsp=
=3Btx_restart_queue: 0</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B 12.534087] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_long_=
length_errors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B 12.534089] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_short_leng=
th_errors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B 12.534090] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_align_errors: 0=
</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B 12.534092] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_tcp_seg_good: 0</font></div=
><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.53409=
3] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_tcp_seg_failed: 0</font></div><div><fon=
t face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534094] [U] &nb=
sp=3B &nbsp=3B &nbsp=3Brx_flow_control_xon: 0</font></div><div><font face=
=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534096] [U] &nbsp=3B =
&nbsp=3B &nbsp=3Brx_flow_control_xoff: 0</font></div><div><font face=3D"Cal=
ibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534097] [U] &nbsp=3B &nbsp=
=3B &nbsp=3Btx_flow_control_xon: 0</font></div><div><font face=3D"Calibri=
=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534098] [U] &nbsp=3B &nbsp=3B &n=
bsp=3Btx_flow_control_xoff: 0</font></div><div><font face=3D"Calibri=2C san=
s-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534100] [U] &nbsp=3B &nbsp=3B &nbsp=3Br=
x_long_byte_count: 128</font></div><div><font face=3D"Calibri=2C sans-serif=
">&lt=3B6&gt=3B[ &nbsp=3B 12.534101] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_csum_=
offload_good: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=
=3B6&gt=3B[ &nbsp=3B 12.534103] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_csum_offlo=
ad_errors: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&=
gt=3B[ &nbsp=3B 12.534104] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_header_split: 0=
</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=
=3B 12.534105] [U] &nbsp=3B &nbsp=3B &nbsp=3Balloc_rx_buff_failed: 0</font>=
</div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.=
534107] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_smbus: 0</font></div><div><font fa=
ce=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534108] [U] &nbsp=
=3B &nbsp=3B &nbsp=3Brx_smbus: 0</font></div><div><font face=3D"Calibri=2C =
sans-serif">&lt=3B6&gt=3B[ &nbsp=3B 12.534109] [U] &nbsp=3B &nbsp=3B &nbsp=
=3Bdropped_smbus: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&=
lt=3B6&gt=3B[ &nbsp=3B 12.534110] [U] &nbsp=3B &nbsp=3B &nbsp=3Brx_dma_fail=
ed: 0</font></div><div><font face=3D"Calibri=2C sans-serif">&lt=3B6&gt=3B[ =
&nbsp=3B 12.534112] [U] &nbsp=3B &nbsp=3B &nbsp=3Btx_dma_failed: 0</font></=
div></div><div><font face=3D"Calibri=2C sans-serif"><br></font></div><div><=
font face=3D"Calibri=2C sans-serif"><br></font></div><div><font face=3D"Cal=
ibri=2C sans-serif"><br></font></div><div><font face=3D"Calibri=2C sans-ser=
if">Regards=2C</font></div><div><font face=3D"Calibri=2C sans-serif">Sumesh=
.</font></div> 		 	   		  </div></body>
</html>=

--_ec61903b-5fc6-4dac-9d7c-235603216e30_--
