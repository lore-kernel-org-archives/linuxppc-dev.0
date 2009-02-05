Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id B74EEDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 03:44:51 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so127298yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2009 08:44:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ccb913ac0902042306k2b0747f2r69092dc2c326752@mail.gmail.com>
References: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
	<fa686aa40902040954m5eb9d259t7168a82484643060@mail.gmail.com>
	<ccb913ac0902042306k2b0747f2r69092dc2c326752@mail.gmail.com>
Date: Thu, 5 Feb 2009 09:44:50 -0700
Message-ID: <fa686aa40902050844h45fa79bco9a82594f0f23ffc6@mail.gmail.com>
Subject: Re: MPC5200 PCI Issues
From: Grant Likely <grant.likely@secretlab.ca>
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 5, 2009 at 12:06 AM, Tobias Knutsson
<tobias.knutsson@gmail.com> wrote:
> When enabling the debug-printouts, it came to me that I forgot to
> mention something kind of important. Using the standard mpc52xx_pci.c,
> even the memory resources are mapped to zero.
>
> After disabling this code block, the memory regions are mapped out
> fine (but still no IO):

Reenable this code, enable debug in arch/powerpc/kernel/pci-common.c,
and post the results.

When this code is disabled then you're just getting the leftovers from
U-Boot's scan of the PCI bus.  For MPC5200 support Linux does its own
scan and its own allocation of memory/IO address space and this code
is needed to make sure that happens.

g.

>
> static void
> mpc52xx_pci_fixup_resources(struct pci_dev *dev)
> {
>        int i;
>
>        pr_debug("mpc52xx_pci_fixup_resources() %.4x:%.4x\n",
>                 dev->vendor, dev->device);
>
>        /* We don't rely on boot loader for PCI and resets all
>           devices */
>        for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
>                struct resource *res =3D &dev->resource[i];
>                if (res->end > res->start) {    /* Only valid resources */
>                        res->end -=3D res->start;
>                        res->start =3D 0;
>                        res->flags |=3D IORESOURCE_UNSET;
>                }
>        }
>
> What is the purpose of this code? Since all resources are reset here,
> where are they inteded to be re-allocated?
>
> Here is the bootlog with the aforementioned code enabled:
>
>
> reading cuImage.lite5200b
>
> 1833699 bytes read
> ## Booting kernel from Legacy Image at 00201400 ...
>   Image Name:   Linux-2.6.28
>   Created:      2009-02-05   6:54:20 UTC
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1833635 Bytes =3D  1.7 MB
>   Load Address: 00400000
>   Entry Point:  004005a0
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> [    0.000000] Using lite5200 machine description
> [    0.000000] Linux version 2.6.28 (tknutsson@ztn-ubuntu) (gcc
> version 4.3.2 (Sourcery G++ Lite 4.3-50) ) #66 Thu Feb 5 07:51:46 CET
> 2009
> [    0.000000] Adding MPC52xx PCI host bridge /pci@f0000d00
> [    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
> [    0.000000]  MEM 0x0000000050000000..0x000000005fffffff -> 0x000000005=
0000000
> [    0.000000]   IO 0x0000000060000000..0x0000000060ffffff -> 0x000000000=
0000000
> [    0.000000] mpc52xx_pci_setup(hose=3Dc03ec000, pci_regs=3Dfdffad00)
> [    0.000000] mem_resource[0] =3D {.start=3D50000000, .end=3D5fffffff, .=
flags=3D200}
> [    0.000000] .io_resource=3D{.start=3D0,.end=3Dffffff,.flags=3D100}
> .io_base_phys=3D0x60000000
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00004000
> [    0.000000]   Normal   0x00004000 -> 0x00004000
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x00004000
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 16256
> [    0.000000] Kernel command line: console=3DttyPSC0,115200 root=3D/dev/=
sda2 rw
> [    0.000000] MPC52xx PIC is up and running!
> [    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
> [    0.000000] clocksource: timebase mult[7d00000] shift[22] registered
> [    0.000263] console [ttyPSC0] enabled
> [    0.121690] Dentry cache hash table entries: 8192 (order: 3, 32768 byt=
es)
> [    0.129012] Inode-cache hash table entries: 4096 (order: 2, 16384 byte=
s)
> [    0.147433] Memory: 60844k/65536k available (3704k kernel code,
> 4624k reserved, 156k data, 117k bss, 180k init)
> [    0.157672] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0,
> CPUs=3D1, Nodes=3D1
> [    0.165373] Calibrating delay loop... 63.87 BogoMIPS (lpj=3D127744)
> [    0.236265] Mount-cache hash table entries: 512
> [    0.245719] net_namespace: 288 bytes
> [    0.250237] NET: Registered protocol family 16
> [    0.284887] PCI: Probing PCI hardware
> [    0.289670] mpc52xx_pci_fixup_resources() 1057:5809
> [    0.294799] PCI:0000:00:17.0 Resource 0
> 0000000050400000-00000000507fffff [21208] fixup...
> [    0.303180] PCI:0000:00:17.0            0000000050400000-00000000507ff=
fff
> [    0.309998] PCI:0000:00:17.0 Resource 1
> 0000000050800000-0000000050ffffff [20200] fixup...
> [    0.318262] PCI:0000:00:17.0            0000000050800000-0000000050fff=
fff
> [    0.325062] PCI:0000:00:17.0 Resource 2
> 0000000060000000-000000006000000f [20101] fixup...
> [    0.333326] PCI:0000:00:17.0            0000000060000000-0000000060000=
00f
> [    0.340124] mpc52xx_pci_fixup_resources() 104c:9065
> [    0.345242] PCI:0000:00:18.0 Resource 0
> 0000000051000000-00000000513fffff [21208] fixup...
> [    0.353519] PCI:0000:00:18.0            0000000051000000-00000000513ff=
fff
> [    0.360319] PCI:0000:00:18.0 Resource 1
> 0000000051800000-0000000051ffffff [20200] fixup...
> [    0.368583] PCI:0000:00:18.0            0000000051800000-0000000051fff=
fff
> [    0.375383] PCI:0000:00:18.0 Resource 2
> 0000000060000010-000000006000001f [20101] fixup...
> [    0.383647] PCI:0000:00:18.0            0000000060000010-0000000060000=
01f
> [    0.390444] mpc52xx_pci_fixup_resources() 104c:9065
> [    0.395549] PCI:0000:00:19.0 Resource 0
> 0000000052000000-00000000523fffff [21208] fixup...
> [    0.403826] PCI:0000:00:19.0            0000000052000000-00000000523ff=
fff
> [    0.410626] PCI:0000:00:19.0 Resource 1
> 0000000052800000-0000000052ffffff [20200] fixup...
> [    0.418889] PCI:0000:00:19.0            0000000052800000-0000000052fff=
fff
> [    0.425690] PCI:0000:00:19.0 Resource 2
> 0000000060000020-000000006000002f [20101] fixup...
> [    0.433954] PCI:0000:00:19.0            0000000060000020-0000000060000=
02f
> [    0.440751] mpc52xx_pci_fixup_resources() 104c:9065
> [    0.445854] PCI:0000:00:1a.0 Resource 0
> 0000000053000000-00000000533fffff [21208] fixup...
> [    0.454130] PCI:0000:00:1a.0            0000000053000000-00000000533ff=
fff
> [    0.460930] PCI:0000:00:1a.0 Resource 1
> 0000000053800000-0000000053ffffff [20200] fixup...
> [    0.469194] PCI:0000:00:1a.0            0000000053800000-0000000053fff=
fff
> [    0.475994] PCI:0000:00:1a.0 Resource 2
> 0000000060000030-000000006000003f [20101] fixup...
> [    0.484258] PCI:0000:00:1a.0            0000000060000030-0000000060000=
03f
> [    0.491056] mpc52xx_pci_fixup_resources() 104c:9065
> [    0.495999] PCI: Fixup bus 0 (PHB)
> [    0.499383] PCI: device 0000:00:16.0 OF node: <none>
> [    0.504371] PCI: device 0000:00:17.0 OF node: <none>
> [    0.509363] PCI: device 0000:00:18.0 OF node: <none>
> [    0.514354] PCI: device 0000:00:19.0 OF node: <none>
> [    0.519345] PCI: device 0000:00:1a.0 OF node: <none>
> [    0.524332] Try to map irq for 0000:00:16.0...
> [    0.528808] Try to map irq for 0000:00:17.0...
> [    0.533334]  -> got one, spec 3 cells (0x00000001 0x00000001...) on
> /soc5200@f0000000/interrupt-controller@500
> [    0.543389]  -> mapped to linux irq 65
> [    0.547117] Try to map irq for 0000:00:18.0...
> [    0.551626]  -> got one, spec 3 cells (0x00000001 0x00000001...) on
> /soc5200@f0000000/interrupt-controller@500
> [    0.561629]  -> mapped to linux irq 65
> [    0.565353] Try to map irq for 0000:00:19.0...
> [    0.569858]  -> got one, spec 3 cells (0x00000001 0x00000001...) on
> /soc5200@f0000000/interrupt-controller@500
> [    0.579863]  -> mapped to linux irq 65
> [    0.583587] Try to map irq for 0000:00:1a.0...
> [    0.588099]  -> got one, spec 3 cells (0x00000001 0x00000001...) on
> /soc5200@f0000000/interrupt-controller@500
> [    0.598103]  -> mapped to linux irq 65
> [    0.605144] PCI: PHB (bus 0) bridge rsrc 0:
> 0000000000000000-0000000000ffffff [0x100], parent c03a1fdc (PCI IO)
> [    0.615266] PCI: PHB (bus 0) bridge rsrc 1:
> 0000000050000000-000000005fffffff [0x200], parent c03a1fc0 (PCI mem)
> [    0.625539] PCI: Assigning unassigned resouces...
> [    0.630304] bus: 00 index 0 io port: [0x00-0xffffff]
> [    0.635299] bus: 00 index 1 mmio: [0x50000000-0x5fffffff]
> [    0.640909] DMA: MPC52xx BestComm driver
> [    0.645214] DMA: MPC52xx BestComm engine @f0001200 ok !
> [    0.678739] SCSI subsystem initialized
> [    0.709498] NET: Registered protocol family 2
> [    0.754980] IP route cache hash table entries: 1024 (order: 0, 4096 by=
tes)
> [    0.762429] TCP established hash table entries: 2048 (order: 2, 16384 =
bytes)
> [    0.769716] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.776224] TCP: Hash tables configured (established 2048 bind 2048)
> [    0.782604] TCP reno registered
> [    0.795054] NET: Registered protocol family 1
> [    0.846171] JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
> [    0.855699] msgmni has been set to 118
> [    0.861227] alg: No test for stdrng (krng)
> [    0.865651] io scheduler noop registered
> [    0.869658] io scheduler anticipatory registered (default)
> [    0.875224] io scheduler deadline registered
> [    0.879838] io scheduler cfq registered
> [    1.442231] Generic RTC Driver v1.07
> [    1.447145] Serial: MPC52xx PSC UART driver
> [    1.451885] f0002200.serial: ttyPSC2 at MMIO 0xf0002200 (irq =3D 130)
> is a MPC52xx PSC
> [    1.461497] f0002400.serial: ttyPSC3 at MMIO 0xf0002400 (irq =3D 131)
> is a MPC52xx PSC
> [    1.471257] f0002600.serial: ttyPSC4 at MMIO 0xf0002600 (irq =3D 139)
> is a MPC52xx PSC
> [    1.480866] f0002800.serial: ttyPSC5 at MMIO 0xf0002800 (irq =3D 140)
> is a MPC52xx PSC
> [    1.490461] f0002c00.serial: ttyPSC0 at MMIO 0xf0002c00 (irq =3D 132)
> is a MPC52xx PSC
> [    1.521689] brd: module loaded
> [    1.535886] loop: module loaded
> [    1.544328] mpc52xx MII bus: probed
> [    1.550220] net eth0: Using PHY at MDIO address 0
> [    1.556124] Driver 'sd' needs updating - please use bus_type methods
> [    1.563224] ata: MPC52xx IDE/ATA libata driver
> [    1.568729] scsi0 : mpc52xx_ata
> [    1.573032] ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
> [    1.751224] ata1.00: ATA-0: TRANSCEND, 20070831, max UDMA/66
> [    1.756948] ata1.00: 3915072 sectors, multi 0: LBA
> [    1.775156] ata1.00: configured for UDMA/33
> [    1.803154] ata1.00: configured for UDMA/33
> [    1.807423] ata1: EH complete
> [    1.811300] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND
>  2007 PQ: 0 ANSI: 5
> [    1.821337] sd 0:0:0:0: [sda] 3915072 512-byte hardware sectors:
> (2.00 GB/1.86 GiB)
> [    1.829333] sd 0:0:0:0: [sda] Write Protect is off
> [    1.834879] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.844851] sd 0:0:0:0: [sda] 3915072 512-byte hardware sectors:
> (2.00 GB/1.86 GiB)
> [    1.852841] sd 0:0:0:0: [sda] Write Protect is off
> [    1.858259] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.867450]  sda: sda1 sda2
> [    1.881490] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.890711] fc000000.flash: Found 1 x16 devices at 0x0 in 8-bit bank
> [    1.897222]  Amd/Fujitsu Extended Query Table at 0x0040
> [    1.902529] fc000000.flash: CFI does not contain boot bank
> location. Assuming top.
> [    1.910147] number of CFI chips: 1
> [    1.913603] cfi_cmdset_0002: Disabling erase-suspend-program due to
> code brokenness.
> [    1.922009] RedBoot partition parsing not available
> [    1.926998] Creating 4 MTD partitions on "fc000000.flash":
> [    1.932547] 0x00000000-0x00500000 : "u-boot"
> [    1.940601] 0x00500000-0x01000000 : "kernel"
> [    1.948071] 0x01000000-0x02000000 : "rootfs"
> [    1.955601] 0x02000000-0x03000000 : "application"
> [    1.964240] i2c /dev entries driver
> [    1.975775] Advanced Linux Sound Architecture Driver Version 1.0.18rc3=
.
> [    1.983814] ASoC version 0.13.2
> [    1.987668] tlv320aic23 0-001a: probing tlv320aic23 i2c device
> [    2.040451] registering ASoC codec driver:
> /soc5200@f0000000/i2c@3d00/codec@1a
> [    2.049539] ALSA device list:
> [    2.052591]   No soundcards found.
> [    2.057430] TCP cubic registered
> [    2.060765] NET: Registered protocol family 17
> [    2.066886] RPC: Registered udp transport module.
> [    2.071683] RPC: Registered tcp transport module.
> [    2.087086] EXT2-fs warning: mounting unchecked fs, running e2fsck
> is recommended
> [    2.094828] VFS: Mounted root (ext2 filesystem).
> [    2.099690] Freeing unused kernel memory: 180k init
>
> On Wed, Feb 4, 2009 at 18:54, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
>> On Wed, Feb 4, 2009 at 9:53 AM, Tobias Knutsson
>> <tobias.knutsson@gmail.com> wrote:
>>>               clock-frequency =3D <0x1e84800>;  //<0>; // From boot loa=
der
>>>               interrupts =3D <2 8 0 2 9 0 2 10 0>;
>>>               interrupt-parent =3D <&mpc5200_pic>;
>>>               bus-range =3D <0 0>;
>>>               ranges =3D <0x02000000 0 0x50000000 0x50000000 0 0x100000=
00
>>>                         0x01000000 0 0x00000000 0x60000000 0 0x01000000=
>;
>>>       };
>>>
>>> The cards' memory regions are mapped out fine to different addresses
>>> in the 0x50000000-0x60000000 range. However, the IO regions are all map=
ped
>>> to zero.
>>>
>>> Do you have any idea on what could be wrong or in which direction I
>>> should be looking?
>>
>> Hmmm.  Your ranges property looks okay to me.  The MPC5200 setup code
>> may be doing the wrong thing.  Turn on debug at the top of
>> arch/powerpc/platforms/mpc52xx/mpc52xx_pci.c and post your kernel
>> output.
>>
>> g.
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>
>
>
> --
>
> H=E4lsningar/Regards
> Tobias Knutsson
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
