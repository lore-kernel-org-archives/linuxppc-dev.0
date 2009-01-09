Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFD16DE1AC
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 08:30:43 +1100 (EST)
Subject: Re: mal_probe crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 10 Jan 2009 08:30:13 +1100
Message-Id: <1231536613.2142.74.camel@pasglop>
Mime-Version: 1.0
Cc: Sean MacLennan <smaclennan@pikatech.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-09 at 16:24 +0100, Geert Uytterhoeven wrote:
> On Fri, 9 Jan 2009, Matthias Fuchs wrote:
> > Forget my last posting! It's just a dirty work around when having a single EMAC.
> > It does not work with two EMACs like on sequoia.
> 
> Indeed. It doesn't on my sequoia :-(
> 
> I also tried reviving connectivity by adding an Intel PRO/1000 GT network card,
> but I got a machine check exception. Don't know if this is a problem with the
> PPC44x PCI code or with the e1000 driver.

Can you double check that the e1000 isn't copying the PCI resources into
a unsigned long before ioremap'ing the result, thus cropping the top
bits ?

It had a bug like that for which I sent a fix a while ago but maybe that
crept back in...

Cheers,
Ben.

> U-Boot 1.2.0-gc0c292b2 (Jun  5 2007 - 07:16:12)
> 
> CPU:   AMCC PowerPC 440EPx Rev. A at 666.666 MHz (PLB=166, OPB=83, EBC=55 MHz)
>        Security/Kasumi support
>        I2C boot EEPROM enabled
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled, PCI async ext clock used
>        32 kB I-Cache 32 kB D-Cache
> Board: Sequoia - AMCC PPC440EPx Evaluation Board, Rev. F, PCI=33 MHz
> I2C:   ready
> DTT:   1 is 223 C
> DRAM:  256 MB
> FLASH: 64 MB
> NAND:  32 MiB
> PCI:   Bus Dev VenId DevId Class Int
>         00  0c  8086  107c  0200  00
> In:    serial
> Out:   serial
> Err:   serial
> USB:   Host(int phy) Device(ext phy)
> Net:   ppc_4xx_eth0, ppc_4xx_eth1
> 
> Type "run flash_nfs" to mount root filesystem over NFS
> 
> Hit any key to stop autoboot:  0 
> Waiting for PHY auto negotiation to complete.. done
> ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
> BOOTP broadcast 1
> DHCP client bound to address 192.168.106.188
> Using ppc_4xx_eth0 device
> TFTP from server 192.168.106.200; our IP address is 192.168.106.188
> Filename '/sequoia/cuImage.sequoia'.
> Load address: 0x100000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #############################################
> done
> Bytes transferred = 1556529 (17c031 hex)
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.6.28-07939-g2150edc-dirt
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1556465 Bytes =  1.5 MB
>    Load Address: 00400000
>    Entry Point:  00400458
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> CPU clock-frequency <- 0x27bc86a4 (667MHz)
> CPU timebase-frequency <- 0x27bc86a4 (667MHz)
> /plb: clock-frequency <- 9ef21a9 (167MHz)
> /plb/opb: clock-frequency <- 4f790d4 (83MHz)
> /plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
> /plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600500: clock-frequency <- 42ecac (4MHz)
> /plb/opb/serial@ef600600: clock-frequency <- 42ecac (4MHz)
> Memory <- <0x0 0x0 0xffff000> (255MB)
> ethernet0: local-mac-address <- 00:10:ec:00:f1:df
> ethernet1: local-mac-address <- 00:10:ec:80:f1:df
> 
> zImage starting: loaded at 0x00400000 (sp: 0x0ff2ba18)
> Allocating 0x333834 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040e000:0x00735820)...done 0x31417c bytes
> 
> Linux/PowerPC load: ip=on root=/dev/nfs
> Finalizing device tree... flat tree at 0x742300
> Using PowerPC 44x Platform machine description
> Linux version 2.6.28-07939-g2150edc-dirty (geert@vixen) (gcc version 4.3.2 (GCC) ) #4 Fri Jan 9 16:05:53 CET 2009
> console [udbg0] enabled
> setup_arch: bootmem
> arch: exit
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x0000ffff
>   Normal   0x0000ffff -> 0x0000ffff
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x0000ffff
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65023
> Kernel command line: ip=on root=/dev/nfs
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> UIC2 (32 IRQ sources) at DCR 0xe0
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> clocksource: timebase mult[600000] shift[22] registered
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 256256k/262140k available (2996k kernel code, 5572k reserved, 128k data, 122k bss, 156k init)
> SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 1331.20 BogoMIPS (lpj=2662400)
> Mount-cache hash table entries: 512
> net_namespace: 716 bytes
> NET: Registered protocol family 16
>              
> PCI host bridge /plb/pci@1ec000000 (primary) ranges:
>  MEM 0x0000000180000000..0x00000001bfffffff -> 0x0000000080000000 
>   IO 0x00000001e8000000..0x00000001e800ffff -> 0x0000000000000000
>   IO 0x00000001e8800000..0x00000001ebffffff -> 0x0000000000000000
>  \--> Skipped (too many) !
> 4xx PCI DMA offset set to 0x00000000
> /plb/pci@1ec000000: Resource out of range
> PCI: Probing PCI hardware
> PCI: Hiding 4xx host bridge resources 0000:00:00.0
> pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:0c.0: PME# disabled
> bio: create slab <bio-0> at 0
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
> msgmni has been set to 501
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
> console handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
> serial8250.0: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
> serial8250.0: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
> 1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
> 1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
> 1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
> 1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
> brd: module loaded
> Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> e1000 0000:00:0c.0: enabling device (0000 -> 0003)
> Machine check in kernel mode.
> Data Read PLB Error
> Oops: Machine check, sig: 7 [#1]
> PowerPC 44x Platform
> Modules linked in:
> NIP: c0187cb8 LR: c0236300 CTR: c0187bb0
> REGS: cfff7f10 TRAP: 0214   Not tainted  (2.6.28-07939-g2150edc-dirty)
> MSR: 00029000 <EE,ME,CE>  CR: 28d6cb24  XER: 20000000
> TASK = cf818400[1] 'swapper' THREAD: cf828000
> GPR00: 00000000 cf829db0 cf818400 cf8114fc 00000004 00000000 00000002 cf829d88 
> GPR08: 00000000 d10c0008 00000000 0000000b 00001000 00108000 0ffb2400 00000001 
> GPR16: 007fff13 00400458 00800000 c032d69c c024bfc4 c0330000 cf8114fc 00000001 
> GPR24: 00000000 00000001 00000047 cf811000 cf811320 cf811000 00000001 cf83d400 
> NIP [c0187cb8] e1000_set_media_type+0x64/0xe4
> LR [c0236300] e1000_probe+0x334/0xd5c
> Call Trace:
> [cf829db0] [c02362b4] e1000_probe+0x2e8/0xd5c (unreliable)
> [cf829e10] [c015c018] local_pci_probe+0x24/0x34
> [cf829e20] [c015c240] pci_device_probe+0x84/0xa8
> [cf829e50] [c017b948] driver_probe_device+0xb4/0x1e8
> [cf829e70] [c017bb20] __driver_attach+0xa4/0xa8
> [cf829e90] [c017b0fc] bus_for_each_dev+0x70/0xac
> [cf829ec0] [c017b760] driver_attach+0x24/0x34
> [cf829ed0] [c017aa04] bus_add_driver+0x1d0/0x244
> [cf829ef0] [c017bd40] driver_register+0x70/0x160
> [cf829f10] [c015c4e8] __pci_register_driver+0x4c/0xac
> [cf829f30] [c02dfb30] e1000_init_module+0x58/0xa8
> [cf829f50] [c00013d8] do_one_initcall+0x34/0x1b0
> [cf829fc0] [c02c6178] kernel_init+0x94/0x100
> [cf829ff0] [c000da64] kernel_thread+0x50/0x6c
> Instruction dump:
> 409c0080 2f8b0010 419e006c 2b8b0010 419d005c 380bffff 2b800001 409d0074 
> 81230000 39290008 7c0004ac 7c004c2c <0c000000> 4c00012c 70000020 40820060 
> ---[ end trace 85643a8ae0783f0b ]---
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 180 seconds..
> 
> 
> With kind regards,
> 
> Geert Uytterhoeven
> Software Architect
> 
> Sony Techsoft Centre Europe
> The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
> 
> Phone:    +32 (0)2 700 8453
> Fax:      +32 (0)2 700 8622
> E-mail:   Geert.Uytterhoeven@sonycom.com
> Internet: http://www.sony-europe.com/
> 
> A division of Sony Europe (Belgium) N.V.
> VAT BE 0413.825.160 · RPR Brussels
> Fortis · BIC GEBABEBB · IBAN BE41293037680010
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
