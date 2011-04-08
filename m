Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56354B6F7F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:12:53 +1000 (EST)
Received: by pwj3 with SMTP id 3so1955162pwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2011 02:12:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416D8CC@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D8CC@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Fri, 8 Apr 2011 11:12:50 +0200
Message-ID: <BANLkTim-KV=hfx3kN9vXDFcK_zjm3iOGxg@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Linux PPC <linuxppc-dev@ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Prabhakar,

On Fri, Apr 8, 2011 at 10:31 AM, Kushwaha Prabhakar-B32579
<B32579@freescale.com> wrote:
> Hi Leon,
>
>
>> -----Original Message-----
>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>> Sent: Friday, April 08, 2011 1:55 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff Garzik;
>> Linux PPC; Gupta Maneesh-B18878
>> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>>
>> Hello Prabhakar,
>>
>> On Fri, Apr 8, 2011 at 5:44 AM, Kushwaha Prabhakar-B32579
>> <B32579@freescale.com> wrote:
>> >> -----Original Message-----
>> >> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>> >> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
>> >> Sent: Thursday, April 07, 2011 10:23 PM
>> >> To: Kushwaha Prabhakar-B32579
>> >> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Tejun Heo;
>> >> Jeff Garzik
>> >> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>> >>
>> >> On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
>> >> <B32579@freescale.com> wrote:
>> >> > Can you please check p2020rdb.dts for IDSEL entries for pci0/1 node=
?
>> >> >
>> >> > In order to work in legacy mode, IDSEL entries are required.
>> >> >
>> >> No, the p1020rdb and p2020rdb do not have the IDSEL entries:
>> >> What would the correct IDSEL entries be?
>> >
>> > For legacy interrupt to work IDSEL values are required.. please find
>> the correct IDSEL values for pci0/1.
>> >
>> > =A0 =A0 =A0 =A0pci0: pcie@ffe09000 {
>> > ...
>> > Please try with this.. I am in process of pushing these IDSEL values t=
o
>> upstream.
>> >
>>
>> Do you have these for P1020RDB =A0as well? I found a P1020RDB board that
>> has the CE10 errata fixed, so IRQ0 is properly pulled up.
>>
>
> =A0Same IDSEL values are valid for P1020RDB also.
>
I compiled the new device tree binary, the dump is below(*) and booted
the P1020RDB from that.

I verified using an oscilloscope that IRQ0 indeed remains high.

However, no interrupt seems to come in from the sata_sil24 driver, see
boot log (**).

(*) dtb dump:
$ dtc -I dtb -O dts /tftpboot/p1020rdb/uImage.dtb

	pcie@ffe09000 {
		compatible =3D "fsl,mpc8548-pcie";
		device_type =3D "pci";
		#interrupt-cells =3D <0x1>;
		#size-cells =3D <0x2>;
		#address-cells =3D <0x3>;
		reg =3D <0x0 0xffe09000 0x0 0x1000>;
		bus-range =3D <0x0 0xff>;
		ranges =3D <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000
0x1000000 0x0 0x0 0x0 0xffc30000 0x0 0x10000>;
		clock-frequency =3D <0x1fca055>;
		interrupt-parent =3D <0x2>;
		interrupts =3D <0x10 0x2>;
		interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
		interrupt-map =3D <0x0 0x0 0x0 0x1 0x2 0x4 0x1 0x0 0x0 0x0 0x2 0x2 0x5
0x1 0x0 0x0 0x0 0x3 0x2 0x6 0x1 0x0 0x0 0x0 0x4 0x2 0x7 0x1>;

		pcie@0 {
			reg =3D <0x0 0x0 0x0 0x0 0x0>;
			#size-cells =3D <0x2>;
			#address-cells =3D <0x3>;
			device_type =3D "pci";
			ranges =3D <0x2000000 0x0 0xa0000000 0x2000000 0x0 0xa0000000 0x0
0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0 0x100000>;
		};
	};

	pcie@ffe0a000 {
		compatible =3D "fsl,mpc8548-pcie";
		device_type =3D "pci";
		#interrupt-cells =3D <0x1>;
		#size-cells =3D <0x2>;
		#address-cells =3D <0x3>;
		reg =3D <0x0 0xffe0a000 0x0 0x1000>;
		bus-range =3D <0x0 0xff>;
		ranges =3D <0x2000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000
0x1000000 0x0 0x0 0x0 0xffc20000 0x0 0x10000>;
		clock-frequency =3D <0x1fca055>;
		interrupt-parent =3D <0x2>;
		interrupts =3D <0x10 0x2>;
		interrupt-map =3D <0x0 0x0 0x0 0x1 0x2 0x0 0x1 0x0 0x0 0x0 0x2 0x2 0x1
0x1 0x0 0x0 0x0 0x3 0x2 0x2 0x1 0x0 0x0 0x0 0x4 0x2 0x3 0x1>;

		pcie@0 {
			reg =3D <0x0 0x0 0x0 0x0 0x0>;
			#size-cells =3D <0x2>;
			#address-cells =3D <0x3>;
			device_type =3D "pci";
			ranges =3D <0x2000000 0x0 0xc0000000 0x2000000 0x0 0xc0000000 0x0
0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0 0x100000>;
		};
	};
};

(**) boot log

[    0.000000] Using P1020 RDB machine description
[    0.000000] Memory CAM mapping: 256/256 Mb, residual: 0Mb
[    0.000000] Linux version 2.6.38 (leon@lunar) (gcc version 4.3.3
(GCC) ) #6 Fri Apr 8 11:00:10 CEST 2011
[    0.000000] Found legacy serial port 0 for /soc@ffe00000/serial@4500
[    0.000000]   mem=3Dffe04500, taddr=3Dffe04500, irq=3D0, clk=3D399999996=
, speed=3D0
[    0.000000] Found legacy serial port 1 for /soc@ffe00000/serial@4600
[    0.000000]   mem=3Dffe04600, taddr=3Dffe04600, irq=3D0, clk=3D399999996=
, speed=3D0
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Found FSL PCI host bridge at 0x00000000ffe09000.
Firmware bus number: 0->255
[    0.000000] PCI host bridge /pcie@ffe09000  ranges:
[    0.000000]  MEM 0x00000000a0000000..0x00000000bfffffff ->
0x00000000a0000000
[    0.000000]   IO 0x00000000ffc30000..0x00000000ffc3ffff -> 0x00000000000=
00000
[    0.000000] /pcie@ffe09000: PCICSRBAR @ 0xfff00000
[    0.000000] Found FSL PCI host bridge at 0x00000000ffe0a000.
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pcie@ffe0a000  ranges:
[    0.000000]  MEM 0x00000000c0000000..0x00000000dfffffff ->
0x00000000c0000000
[    0.000000]   IO 0x00000000ffc20000..0x00000000ffc2ffff -> 0x00000000000=
00000
[    0.000000] /pcie@ffe0a000: PCICSRBAR @ 0xfff00000
[    0.000000] MPC85xx RDB board from Freescale Semiconductor
[    0.000000] Top of RAM: 0x20000000, Total RAM: 0x20000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00020000
[    0.000000]   Normal   empty
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c062d9bc,
node_mem_map c07e1000
[    0.000000]   DMA zone: 1024 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 130048 pages, LIFO batch:31
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.0.7:/nfsroot/p1020rdb
ip=3D192.168.0.20:192.168.0.7:::P1020RDB:eth0:off console=3DttyS0,115200
ramdisk_size=3D200000 cache-sram-size=3D0x10000
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] High memory: 0k
[    0.000000] Memory: 511604k/524288k available (6112k kernel code,
12684k reserved, 256k data, 1686k bss, 220k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xff7da000..0xff800000  : early ioremap
[    0.000000]   * 0xe1000000..0xff7da000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0,
CPUs=3D1, Nodes=3D1
[    0.000000] NR_IRQS:512
[    0.000000] mpic: Setting up MPIC " OpenPIC  " version 1.2 at
ffe40000, max 2 CPUs
[    0.000000] mpic: ISU size: 256, shift: 8, mask: ff
[    0.000000] mpic: Initializing for 256 sources
[    0.000000] time_init: decrementer frequency =3D 50.000000 MHz
[    0.000000] time_init: processor frequency   =3D 799.999992 MHz
[    0.000000] clocksource: timebase mult[5000000] shift[22] registered
[    0.000000] clockevent: decrementer mult[ccccccc] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.010728] pid_max: default: 32768 minimum: 301
[    0.015483] Mount-cache hash table entries: 512
[    0.021404] devtmpfs: initialized
[    0.025042] NET: Registered protocol family 16
[    0.031180] irq: irq 47 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 47
[    0.031507] PCI: Probing PCI hardware
[    0.035144] pci_bus 0000:00: scanning bus
[    0.035167] pci 0000:00:00.0: [1957:0100] type 1 class 0x000b20
[    0.035188] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0x24
[    0.035197] pci 0000:00:00.0: ignoring class b20 (doesn't match
header type 01)
[    0.042429] pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0=
x54
[    0.042440] pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x110
[    0.042456] pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x50
[    0.042473] pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x19c
[    0.042488] pci 0000:00:00.0: supports D1 D2
[    0.042496] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.042505] pci 0000:00:00.0: PME# disabled
[    0.042525] pci_bus 0000:00: fixups for bus
[    0.042539] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    0.042546] pci 0000:00:00.0: bus configuration invalid, reconfiguring
[    0.042556] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.042577] pci_bus 0000:01: scanning bus
[    0.042584] pci_bus 0000:01: fixups for bus
[    0.042591] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.047728] pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disab=
led)
[    0.047738] pci 0000:00:00.0:   bridge window [mem
0x00000000-0x000fffff] (disabled)
[    0.047748] pci 0000:00:00.0:   bridge window [mem
0x00000000-0x000fffff pref] (disabled)
[    0.047760] pci_bus 0000:01: bus scan returning with max=3D01
[    0.047769] pci_bus 0000:00: bus scan returning with max=3D01
[    0.047902] pci_bus 0001:02: scanning bus
[    0.047920] pci 0001:02:00.0: [1957:0100] type 1 class 0x000b20
[    0.047932] pci 0001:02:00.0: calling quirk_mmio_always_on+0x0/0x24
[    0.047941] pci 0001:02:00.0: ignoring class b20 (doesn't match
header type 01)
[    0.055166] pci 0001:02:00.0: calling fixup_hide_host_resource_fsl+0x0/0=
x54
[    0.055177] pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x110
[    0.055188] pci 0001:02:00.0: calling quirk_fsl_pcie_header+0x0/0x50
[    0.055202] pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x19c
[    0.055215] pci 0001:02:00.0: supports D1 D2
[    0.055222] pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.055230] pci 0001:02:00.0: PME# disabled
[    0.055254] pci_bus 0001:02: fixups for bus
[    0.055265] pci 0001:02:00.0: scanning [bus 01-01] behind bridge, pass 0
[    0.055272] pci 0001:02:00.0: bus configuration invalid, reconfiguring
[    0.055282] pci 0001:02:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.055302] pci_bus 0001:03: scanning bus
[    0.055334] pci 0001:03:00.0: [1095:3132] type 0 class 0x000104
[    0.055346] pci 0001:03:00.0: calling quirk_mmio_always_on+0x0/0x24
[    0.055376] pci 0001:03:00.0: reg 10: [mem 0xc0000000-0xc000007f 64bit]
[    0.055401] pci 0001:03:00.0: reg 18: [mem 0xc0004000-0xc0007fff 64bit]
[    0.055420] pci 0001:03:00.0: reg 20: [io  0x1000-0x107f]
[    0.055448] pci 0001:03:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[    0.055461] pci 0001:03:00.0: calling pcibios_fixup_resources+0x0/0x110
[    0.055473] pci 0001:03:00.0: calling quirk_resource_alignment+0x0/0x19c
[    0.055513] pci 0001:03:00.0: supports D1 D2
[    0.055537] pci 0001:03:00.0: disabling ASPM on pre-1.1 PCIe
device.  You can enable it with 'pcie_aspm=3Dforce'
[    0.065457] pci_bus 0001:03: fixups for bus
[    0.065464] pci 0001:02:00.0: PCI bridge to [bus 03-ff]
[    0.070655] pci 0001:02:00.0:   bridge window [io  0x0000-0x0000] (disab=
led)
[    0.070664] pci 0001:02:00.0:   bridge window [mem 0xc0000000-0xc00fffff=
]
[    0.070674] pci 0001:02:00.0:   bridge window [mem
0x10000000-0x000fffff pref] (disabled)
[    0.070707] pci_bus 0001:03: bus scan returning with max=3D03
[    0.070716] pci_bus 0001:02: bus scan returning with max=3D03
[    0.070891] PCI 0000:00 Cannot reserve Legacy IO [io  0xff7ed000-0xff7ed=
fff]
[    0.070900] PCI 0001:02 Cannot reserve Legacy IO [io  0xff7db000-0xff7db=
fff]
[    0.070922] pci 0000:00:00.0: PCI bridge to [bus 01-01]
[    0.076063] pci 0000:00:00.0:   bridge window [io  0xff7ed000-0xff7fcfff=
]
[    0.082827] pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff=
]
[    0.089596] pci 0000:00:00.0:   bridge window [mem pref disabled]
[    0.095676] pci 0000:00:00.0: enabling device (0106 -> 0107)
[    0.101321] pci 0001:02:00.0: BAR 9: can't assign mem pref (size 0x10000=
0)
[    0.108175] pci 0001:03:00.0: BAR 6: assigned [mem
0xc0080000-0xc00fffff pref]
[    0.115377] pci 0001:02:00.0: PCI bridge to [bus 03-03]
[    0.120584] pci 0001:02:00.0:   bridge window [io  0xff7db000-0xff7eafff=
]
[    0.127355] pci 0001:02:00.0:   bridge window [mem 0xc0000000-0xdfffffff=
]
[    0.134124] pci 0001:02:00.0:   bridge window [mem pref disabled]
[    0.140203] pci 0001:02:00.0: enabling device (0106 -> 0107)
[    0.145845] pci_bus 0000:00: resource 0 [io  0xff7ed000-0xff7fcfff]
[    0.145854] pci_bus 0000:00: resource 1 [mem 0xa0000000-0xbfffffff]
[    0.145863] pci_bus 0000:01: resource 0 [io  0xff7ed000-0xff7fcfff]
[    0.145872] pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfffffff]
[    0.145880] pci_bus 0001:02: resource 0 [io  0xff7db000-0xff7eafff]
[    0.145889] pci_bus 0001:02: resource 1 [mem 0xc0000000-0xdfffffff]
[    0.145897] pci_bus 0001:03: resource 0 [io  0xff7db000-0xff7eafff]
[    0.145906] pci_bus 0001:03: resource 1 [mem 0xc0000000-0xdfffffff]
[    0.145942] Registering qe_ic with sysfs...
[    0.149031] bio: create slab <bio-0> at 0
[    0.153197] vgaarb: loaded
[    0.156055] SCSI subsystem initialized
[    0.159772] libata version 3.00 loaded.
[    0.159905] usbcore: registered new interface driver usbfs
[    0.165357] usbcore: registered new interface driver hub
[    0.170666] usbcore: registered new device driver usb
[    0.175707] Freescale Elo / Elo Plus DMA driver
[    0.180293] Advanced Linux Sound Architecture Driver Version 1.0.23.
[    0.186845] Switching to clocksource timebase
[    0.194746] NET: Registered protocol family 2
[    0.199032] Switched to NOHz mode on CPU #0
[    0.203314] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.210610] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    0.218015] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.224585] TCP: Hash tables configured (established 16384 bind 16384)
[    0.231022] TCP reno registered
[    0.234149] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.239974] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.246527] NET: Registered protocol family 1
[    0.251004] RPC: Registered udp transport module.
[    0.255632] RPC: Registered tcp transport module.
[    0.260308] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.266758] pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x50
[    0.266778] pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x724
[    0.266794] pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x50
[    0.266804] pci 0001:02:00.0: calling quirk_usb_early_handoff+0x0/0x724
[    0.266818] pci 0001:03:00.0: calling quirk_cardbus_legacy+0x0/0x50
[    0.266829] pci 0001:03:00.0: calling quirk_usb_early_handoff+0x0/0x724
[    0.266839] PCI: CLS 32 bytes, default 32
[    0.267012] irq: irq 42 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 42
[    0.267213] irq: irq 19 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 19
[    0.267604] irq: irq 16 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 16
[    0.267761] irq: irq 43 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 43
[    0.268030] irq: irq 59 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 59
[    0.268323] irq: irq 20 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 20
[    0.268335] of:fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-channel), i=
rq 20
[    0.275419] irq: irq 21 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 21
[    0.275430] of:fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-channel), i=
rq 21
[    0.282530] irq: irq 22 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 22
[    0.282540] of:fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-channel), i=
rq 22
[    0.289648] irq: irq 23 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 23
[    0.289659] of:fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-channel), i=
rq 23
[    0.297270] irq: irq 28 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 28
[    0.297360] irq: irq 72 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 72
[    0.297450] irq: irq 45 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 45
[    0.297469] irq: irq 58 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 58
[    0.297630] irq: irq 224 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 224
[    0.297649] irq: irq 225 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 225
[    0.297668] irq: irq 226 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 226
[    0.297686] irq: irq 227 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 227
[    0.297705] irq: irq 228 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 228
[    0.297723] irq: irq 229 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 229
[    0.297742] irq: irq 230 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 230
[    0.297760] irq: irq 231 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 231
[    0.297849] Setting up Freescale MSI support
[    0.298123] audit: initializing netlink socket (disabled)
[    0.303462] type=3D2000 audit(0.236:1): initialized
[    0.314074] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.320368] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.326841] NTFS driver 2.1.30 [Flags: R/O].
[    0.331296] JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
[    0.337596] msgmni has been set to 1001
[    0.341965] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    0.349288] io scheduler noop registered (default)
[    0.431003] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[    0.438061] serial8250.0: ttyS0 at MMIO 0xffe04500 (irq =3D 42) is a 165=
50A
[    0.444791] console [ttyS0] enabled, bootconsole disabled
[    0.456105] serial8250.0: ttyS1 at MMIO 0xffe04600 (irq =3D 42) is a 165=
50A
[    0.463482] Generic non-volatile memory driver v1.1
[    0.470831] brd: module loaded
[    0.475184] loop: module loaded
[    0.478439] nbd: registered device at major 43
[    0.485462] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[    0.492145] sata_sil24 0001:03:00.0: version 1.1 built on Apr  8
2011 11:00:08
[    0.492182] ata_host_alloc: ENTER
[    0.495504] ata_port_alloc: ENTER
[    0.498821] ata_port_alloc: ENTER
[    0.502525] __ata_port_freeze: ata4294967295 port frozen
[    0.508187] __ata_port_freeze: ata4294967295 port frozen
[    0.513580] ------------[ cut here ]------------
[    0.518188] WARNING: at drivers/ata/libata-core.c:6082
[    0.523316] Modules linked in:
[    0.526364] NIP: c02876b0 LR: c0287690 CTR: c0248934
[    0.531323] REGS: df837d00 TRAP: 0700   Not tainted  (2.6.38)
[    0.537058] MSR: 00029000 <EE,ME,CE>  CR: 20424022  XER: 20000000
[    0.543158] TASK =3D df838000[1] 'swapper' THREAD: df836000
[    0.548373] GPR00: 00000001 df837db0 df838000 00000000 00003cb6
ffffffff c0249690 00080000
[    0.556736] GPR08: c073b9bc ffffffff 0007ffff 00003cb6 20424022
66013a2a 1ff91d00 c056c170
[    0.565097] GPR16: c0546e94 00000001 00002040 00000400 00000008
0000020c e109e040 df807060
[    0.573459] GPR24: dfa58490 c06160d8 00000080 c029fc0c 00000000
c07d4a58 dfa58490 00000000
[    0.582013] NIP [c02876b0] ata_host_activate+0x48/0x11c
[    0.587232] LR [c0287690] ata_host_activate+0x28/0x11c
[    0.592360] Call Trace:
[    0.594801] [df837db0] [c0287690] ata_host_activate+0x28/0x11c (unreliab=
le)
[    0.601771] [df837de0] [c029faf8] sil24_init_one+0x420/0x534
[    0.607428] [df837e60] [c021d73c] local_pci_probe+0x24/0x34
[    0.612997] [df837e70] [c021d984] pci_device_probe+0x84/0xa8
[    0.618652] [df837ea0] [c0258a44] driver_probe_device+0xa8/0x1c8
[    0.624653] [df837ec0] [c0258c20] __driver_attach+0xbc/0xc0
[    0.630231] [df837ee0] [c02580ec] bus_for_each_dev+0x70/0xac
[    0.635885] [df837f10] [c0258844] driver_attach+0x24/0x34
[    0.641281] [df837f20] [c0257864] bus_add_driver+0xc4/0x294
[    0.646849] [df837f50] [c0258f98] driver_register+0x84/0x178
[    0.652504] [df837f70] [c021dc08] __pci_register_driver+0x4c/0xdc
[    0.658597] [df837f90] [c05ddfe4] sil24_init+0x24/0x34
[    0.663733] [df837fa0] [c0001dc0] do_one_initcall+0x34/0x1c8
[    0.669388] [df837fd0] [c05c11ec] kernel_init+0xcc/0x174
[    0.674696] [df837ff0] [c000cf98] kernel_thread+0x4c/0x68
[    0.680086] Instruction dump:
[    0.683045] 7cda3378 7cf93b78 7c7e1b78 4bfffc91 7c7f1b79 408200d8
2f9c0000 409e0034
[    0.690798] 7f69fe70 7d20da78 7c004850 54000ffe <0f000000> 80010034
7fc3f378 7f24cb78
[    0.698738] ---[ end trace ab638653f78364ad ]---
[    0.703813] scsi0 : sata_sil24
[    0.707083] scsi1 : sata_sil24
[    0.710242] ata1: SATA max UDMA/100 host m128@0xc0000000 port 0xc0004000
[    0.716951] ata2: SATA max UDMA/100 host m128@0xc0000000 port 0xc0006000
[    0.724592] ef000000.nor: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000001 Chip ID 0x002101
[    0.734612] Amd/Fujitsu Extended Query Table at 0x0040
[    0.739787]   Amd/Fujitsu Extended Query version 1.3.
[    0.744839] number of CFI chips: 1
[    0.748325] ata_port_schedule_eh: port EH scheduled
[    0.753217] ata_scsi_error: ENTER
[    0.756539] ata_eh_link_autopsy: ENTER
[    0.760286] ata_eh_recover: ENTER
[    0.763606] __ata_port_freeze: ata1 port frozen
[    0.768317] RedBoot partition parsing not available
[    0.773212] Creating 5 MTD partitions on "ef000000.nor":
[    0.778526] 0x000000000000-0x000000040000 : "NOR (RO) Vitesse-7385 Firmw=
are"
[    0.786280] 0x000000040000-0x000000080000 : "NOR (RO) DTB Image"
[    0.792876] 0x000000080000-0x000000400000 : "NOR (RO) Linux Kernel Image=
"
[    0.800257] 0x000000400000-0x000000f00000 : "NOR (RW) JFFS2 Root File Sy=
stem"
[    0.808001] 0x000000f00000-0x000001000000 : "NOR (RO) U-Boot Image"
[    0.815110] fsl-lbc ffe05000.localbus: read_byte beyond end of buffer
[    0.821564] fsl-lbc ffe05000.localbus: read_byte beyond end of buffer
[    0.828002] fsl-lbc ffe05000.localbus: read_byte beyond end of buffer
[    0.834443] NAND device: Manufacturer ID: 0xec, Chip ID: 0x75
(Samsung NAND 32MiB 3,3V 8-bit)
[    0.843174] Bad block table found at page 65504, version 0x01
[    0.843513] Bad block table found at page 65472, version 0x01
[    0.843876] RedBoot partition parsing not available
[    0.848772] Creating 6 MTD partitions on "ffa00000.flash":
[    0.854259] 0x000000000000-0x000000100000 : "NAND (RO) U-Boot Image"
[    0.861299] 0x000000100000-0x000000200000 : "NAND (RO) DTB Image"
[    0.868010] 0x000000200000-0x000000600000 : "NAND (RO) Linux Kernel Imag=
e"
[    0.875530] 0x000000600000-0x000000a00000 : "NAND (RO) Compressed RFS Im=
age"
[    0.883216] 0x000000a00000-0x000001100000 : "NAND (RW) JFFS2 Root
File System"
[    0.891042] 0x000001100000-0x000002000000 : "NAND (RW) Writable User are=
a"
[    0.898571] eLBC NAND device at 0xffa00000, bank 1
[    0.904384] Fixed MDIO Bus: probed
[    0.907964] irq: irq 29 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 29
[    0.907986] irq: irq 30 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 30
[    0.908005] irq: irq 34 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 34
[    0.908035] irq: irq 17 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 17
[    0.908054] irq: irq 18 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 18
[    0.908074] irq: irq 24 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 24
[    0.908588] eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:01:1=
f:49
[    0.915646] eth0: Running with NAPI enabled
[    0.919826] eth0: RX BD ring size for Q[0]: 256
[    0.924353] eth0: RX BD ring size for Q[1]: 256
[    0.928879] eth0: RX BD ring size for Q[2]: 256
[    0.933406] eth0: RX BD ring size for Q[3]: 256
[    0.937932] eth0: RX BD ring size for Q[4]: 256
[    0.942458] eth0: RX BD ring size for Q[5]: 256
[    0.946984] eth0: RX BD ring size for Q[6]: 256
[    0.951512] eth0: RX BD ring size for Q[7]: 256
[    0.956037] eth0: TX BD ring size for Q[0]: 256
[    0.960564] eth0: TX BD ring size for Q[1]: 256
[    0.965090] eth0: TX BD ring size for Q[2]: 256
[    0.969616] eth0: TX BD ring size for Q[3]: 256
[    0.974143] eth0: TX BD ring size for Q[4]: 256
[    0.978668] eth0: TX BD ring size for Q[5]: 256
[    0.983197] eth0: TX BD ring size for Q[6]: 256
[    0.987725] eth0: TX BD ring size for Q[7]: 256
[    0.992327] irq: irq 35 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 35
[    0.992348] irq: irq 36 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 36
[    0.992367] irq: irq 40 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 40
[    0.992397] irq: irq 51 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 51
[    0.992417] irq: irq 52 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 52
[    0.992436] irq: irq 67 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 67
[    0.992938] eth1: Gianfar Ethernet Controller Version 1.2, 00:04:9f:01:1=
f:4a
[    0.999992] eth1: Running with NAPI enabled
[    1.004172] eth1: RX BD ring size for Q[0]: 256
[    1.008699] eth1: RX BD ring size for Q[1]: 256
[    1.013226] eth1: RX BD ring size for Q[2]: 256
[    1.017753] eth1: RX BD ring size for Q[3]: 256
[    1.022280] eth1: RX BD ring size for Q[4]: 256
[    1.026806] eth1: RX BD ring size for Q[5]: 256
[    1.031333] eth1: RX BD ring size for Q[6]: 256
[    1.035860] eth1: RX BD ring size for Q[7]: 256
[    1.040387] eth1: TX BD ring size for Q[0]: 256
[    1.044914] eth1: TX BD ring size for Q[1]: 256
[    1.049441] eth1: TX BD ring size for Q[2]: 256
[    1.053967] eth1: TX BD ring size for Q[3]: 256
[    1.058495] eth1: TX BD ring size for Q[4]: 256
[    1.063022] eth1: TX BD ring size for Q[5]: 256
[    1.067552] eth1: TX BD ring size for Q[6]: 256
[    1.072079] eth1: TX BD ring size for Q[7]: 256
[    1.076679] irq: irq 31 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 31
[    1.076700] irq: irq 32 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 32
[    1.076719] irq: irq 33 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 33
[    1.076748] irq: irq 25 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 25
[    1.076768] irq: irq 26 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 26
[    1.076787] irq: irq 27 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 27
[    1.077315] eth2: Gianfar Ethernet Controller Version 1.2, 00:04:9f:01:1=
f:4b
[    1.084370] eth2: Running with NAPI enabled
[    1.088551] eth2: RX BD ring size for Q[0]: 256
[    1.093077] eth2: RX BD ring size for Q[1]: 256
[    1.097604] eth2: RX BD ring size for Q[2]: 256
[    1.102130] eth2: RX BD ring size for Q[3]: 256
[    1.106657] eth2: RX BD ring size for Q[4]: 256
[    1.111184] eth2: RX BD ring size for Q[5]: 256
[    1.115712] eth2: RX BD ring size for Q[6]: 256
[    1.120238] eth2: RX BD ring size for Q[7]: 256
[    1.124765] eth2: TX BD ring size for Q[0]: 256
[    1.129291] eth2: TX BD ring size for Q[1]: 256
[    1.133818] eth2: TX BD ring size for Q[2]: 256
[    1.138344] eth2: TX BD ring size for Q[3]: 256
[    1.142871] eth2: TX BD ring size for Q[4]: 256
[    1.147398] eth2: TX BD ring size for Q[5]: 256
[    1.151925] eth2: TX BD ring size for Q[6]: 256
[    1.156452] eth2: TX BD ring size for Q[7]: 256
[    1.161023] ucc_geth: QE UCC Gigabit Ethernet Controller
[    1.166721] Freescale PowerQUICC MII Bus: probed
[    1.171369] irq: irq 3 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 37
[    1.171760] irq: irq 2 on host /soc@ffe00000/pic@40000 mapped to
virtual irq 38
[    1.172142] Freescale PowerQUICC MII Bus: probed
[    1.178127] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.184817] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.191162] /soc@ffe00000/usb@22000: Invalid 'dr_mode' property,
fallback to host mode
[    1.199169] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[    1.205996] fsl-ehci fsl-ehci.0: new USB bus registered, assigned
bus number 1
[    1.235156] fsl-ehci fsl-ehci.0: irq 28, io mem 0xffe22000
[    1.251134] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
[    1.257090] hub 1-0:1.0: USB hub found
[    1.260860] hub 1-0:1.0: 1 port detected
[    1.264959] Initializing USB Mass Storage driver...
[    1.269918] usbcore: registered new interface driver usb-storage
[    1.275929] USB Mass Storage support registered.
[    1.280797] of:mpc-i2c ffe03000.i2c: timeout 1000000 us
[    1.286321] of:mpc-i2c ffe03100.i2c: timeout 1000000 us
[    1.291698] EDAC MC: Ver: 2.1.0 Apr  8 2011
[    1.295999] Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Softwa=
re
[    1.303043] mpc85xx_mc_err_probe: No ECC DIMMs discovered
[    1.308913] EDAC DEVICE0: Giving out device to module
'MPC85xx_edac' controller 'mpc85xx_l2_err': DEV 'mpc85xx_l2_err'
(INTERRUPT)
[    1.320684] MPC85xx_edac acquired irq 16 for L2 Err
[    1.325561] MPC85xx_edac L2 err registered
[    1.329874] sdhci: Secure Digital Host Controller Interface driver
[    1.336056] sdhci: Copyright(c) Pierre Ossman
[    1.340590] mmc0: SDHCI controller on ffe2e000.sdhci
[ffe2e000.sdhci] using DMA
[    1.348286] of:talitos ffe30000.crypto: hwrng
[    1.352766] of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-aes-talito=
s
[    1.359618] of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-3des-talit=
os
[    1.366583] of:talitos ffe30000.crypto: authenc-hmac-sha256-cbc-aes-tali=
tos
[    1.473638] of:talitos ffe30000.crypto: authenc-hmac-sha256-cbc-3des-tal=
itos
[    1.480747] of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-aes-talitos
[    1.487513] of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-3des-talito=
s
[    1.494358] of:talitos ffe30000.crypto: cbc-aes-talitos
[    1.499643] of:talitos ffe30000.crypto: cbc-3des-talitos
[    1.505015] of:talitos ffe30000.crypto: md5-talitos
[    1.509952] of:talitos ffe30000.crypto: sha1-talitos
[    1.514976] of:talitos ffe30000.crypto: sha224-talitos
[    1.520174] of:talitos ffe30000.crypto: sha256-talitos
[    1.525372] of:talitos ffe30000.crypto: sha384-talitos
[    1.530573] of:talitos ffe30000.crypto: sha512-talitos
[    1.536275] usbcore: registered new interface driver usbhid
[    1.541850] usbhid: USB HID core driver
[    1.545983] ALSA device list:
[    1.548958]   No soundcards found.
[    1.553108] IPv4 over IPv4 tunneling driver
[    1.557922] TCP cubic registered
[    1.561155] Initializing XFRM netlink socket
[    1.565847] NET: Registered protocol family 10
[    1.574266] IPv6 over IPv4 tunneling driver
[    1.579967] NET: Registered protocol family 17
[    1.584454] Registering the dns_resolver key type
[    1.590372] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.102073] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    2.939140] sil24_softreset: ENTER
[    2.955143] ata_dev_classify: found ATA device by sig
[    2.960194] sil24_softreset: EXIT, class=3D1
[    2.964295] ata_eh_thaw_port: ata1 port thawed
[    2.968734] ata_std_postreset: ENTER
[    2.972314] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    2.978315] ata_std_postreset: EXIT
[    2.981804] ata_eh_revalidate_and_attach: ENTER
[    2.986333] ata1.00: ata_dev_read_id: ENTER
[    2.986342] ata_sg_setup: ENTER, ata1
[    2.989996] ata_sg_setup: 1 sg elements mapped
[    2.994431] max_sge now 1
[    2.997041] max_sge now 1
[    3.147167] IP-Config: Guessing netmask 255.255.255.0
[    3.152315] IP-Config: Complete:
[    3.155546]      device=3Deth0, addr=3D192.168.0.20,
mask=3D255.255.255.0, gw=3D255.255.255.255,
[    3.163391]      host=3DP1020RDB, domain=3D, nis-domain=3D(none),
[    3.168962]      bootserver=3D192.168.0.7, rootserver=3D192.168.0.7, roo=
tpath=3D
[    4.147148] PHY: 0:01 - Link is Up - 1000/Full
[    4.151702] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    7.999132] __ata_port_freeze: ata1 port frozen
[    8.003672] ata_sg_clean: unmapping 1 sg elements
[    8.008369] ata1.00: qc timeout (cmd 0xec)
[    8.012474] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[    8.018566] ata_eh_revalidate_and_attach: EXIT rc=3D-5
[    8.023534] __ata_port_freeze: ata1 port frozen
[   10.167138] sil24_softreset: ENTER
[   10.183147] ata_dev_classify: found ATA device by sig
[   10.188197] sil24_softreset: EXIT, class=3D1
[   10.192298] ata_eh_thaw_port: ata1 port thawed
[   10.196737] ata_std_postreset: ENTER
[   10.200316] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   10.206318] ata_std_postreset: EXIT
[   10.209806] ata_eh_revalidate_and_attach: ENTER
[   10.214335] ata1.00: ata_dev_read_id: ENTER
[   10.214344] ata_sg_setup: ENTER, ata1
[   10.217998] ata_sg_setup: 1 sg elements mapped
[   14.539135] eth0: no IPv6 routers present
[   20.219208] __ata_port_freeze: ata1 port frozen
[   20.223743] ata_sg_clean: unmapping 1 sg elements
[   20.228439] ata1.00: qc timeout (cmd 0xec)
[   20.232540] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[   20.238631] ata_eh_revalidate_and_attach: EXIT rc=3D-5
[   20.243600] ata1: limiting SATA link speed to 1.5 Gbps
[   20.248739] __ata_port_freeze: ata1 port frozen
[   22.447139] sil24_softreset: ENTER
[   22.463149] ata_dev_classify: found ATA device by sig
[   22.468199] sil24_softreset: EXIT, class=3D1
[   22.472300] ata_eh_thaw_port: ata1 port thawed
[   22.476739] ata_std_postreset: ENTER
[   22.480318] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[   22.486406] ata_std_postreset: EXIT
[   22.489893] ata_eh_revalidate_and_attach: ENTER
[   22.494421] ata1.00: ata_dev_read_id: ENTER
[   22.494428] ata_sg_setup: ENTER, ata1
[   22.498080] ata_sg_setup: 1 sg elements mapped
[   52.499142] __ata_port_freeze: ata1 port frozen
[   52.503678] ata_sg_clean: unmapping 1 sg elements
[   52.508374] ata1.00: qc timeout (cmd 0xec)
[   52.512477] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[   52.518570] ata_eh_revalidate_and_attach: EXIT rc=3D-5
[   52.523536] __ata_port_freeze: ata1 port frozen
[   54.739148] sil24_softreset: ENTER
[   54.755149] ata_dev_classify: found ATA device by sig
[   54.760209] sil24_softreset: EXIT, class=3D1
[   54.764312] ata_eh_thaw_port: ata1 port thawed
[   54.768751] ata_std_postreset: ENTER
[   54.772330] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[   54.778419] ata_std_postreset: EXIT
[   54.781906] ata_eh_revalidate_and_attach: ENTER
[   54.786435] ata_eh_recover: EXIT, rc=3D0
[   54.790184] ata_scsi_error: EXIT
[   54.793440] ata_port_schedule_eh: port EH scheduled
[   54.798330] ata_scsi_error: ENTER
[   54.801651] ata_eh_link_autopsy: ENTER
[   54.805398] ata_eh_recover: ENTER
[   54.808717] __ata_port_freeze: ata2 port frozen
[   56.883149] ata_eh_thaw_port: ata2 port thawed
[   56.887593] ata_std_postreset: ENTER
[   56.891171] ata2: SATA link down (SStatus 0 SControl 0)
[   56.896392] ata_std_postreset: EXIT
[   56.899880] ata_eh_revalidate_and_attach: ENTER
[   56.904409] ata_eh_recover: EXIT, rc=3D0
[   56.908157] ata_scsi_error: EXIT
[   56.931100] VFS: Mounted root (nfs filesystem) on device 0:15.
[   56.937349] devtmpfs: mounted
[   56.940365] Freeing unused kernel memory: 220k init


[    0.518188] WARNING: at drivers/ata/libata-core.c:6082

which means that pdev->irq is 0

lspci -vvvn:

root@p1020rdb:~# lspci -nvv
0000:00:00.0 0604: 1957:0100 (rev 10)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: a0000000-bfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us,
L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: pcieport

0001:02:00.0 0604: 1957:0100 (rev 10)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: c0000000-dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us,
L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: pcieport

0001:03:00.0 0104: 1095:3132 (rev 01)
	Subsystem: 1095:7132
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=3D128]
	Region 2: Memory at c0004000 (64-bit, non-prefetchable) [size=3D16K]
	Region 4: I/O ports at 1000 [size=3D128]
	[virtual] Expansion ROM at c0080000 [disabled] [size=3D512K]
	Capabilities: [54] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [5c] MSI: Mask- 64bit+ Count=3D1/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 1024 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0
unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sata_sil24

root@p1020rdb:~#

		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [5c] MSI: Mask- 64bit+ Count=3D1/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 1024 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0
unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sata_sil24
	Kernel modules: sata_sil24


--=20
Leon
