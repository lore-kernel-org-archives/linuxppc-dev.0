Return-Path: <Tony_Hardie@net.com>
Received: from mx03.net.com (mx03.net.com [134.56.3.133])
	by ozlabs.org (Postfix) with ESMTP id 11D7267B7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 07:44:08 +1000 (EST)
Received: from mx01-int.net.com (mx01-int.net.com [134.56.112.13])
	by mx03.net.com (Switch-3.1.8/Switch-3.1.7) with ESMTP id
	k6PL8Msi015079 for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 14:08:22 -0700 (PDT)
Received: from fmt-ex01.net.com (fmt-ex01.net.com [134.56.112.251])
	by mx01-int.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	k6PLDArK025964 for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 14:13:11 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PPC 82xx (MPC8270) PCI host bridge resource allocation issue
Date: Tue, 25 Jul 2006 14:13:09 -0700
Message-ID: <CE711B0E5D7A1A4096A808997E008329018067C5@fmt-ex01.net.com>
From: "Tony Hardie" <Tony_Hardie@net.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hiya, (we are running a custom board very similar to pq2fads)

I am having some issues with the resource allocation of the host bus in
2.6.17.3 where by on startup the kernel complains below the lines:
[    8.824450] PCI: Cannot allocate resource region 0 of device
0000:00:00.0
[    8.843507] PCI: Cannot allocate resource region 1 of device
0000:00:00.0
We are using the same memory map (did'nt) override the pq2fads code

I also output lspci. What should it be doing here? How do I correct
this?

Cheers
Tony


[    0.000000] PCI Autoconfig: Found Bus 0, Device 17, Function 0
[    0.000000] PCI Autoconfig: BAR 0x10, Mem size=3D0x1000,
address=3D0xaffff000
[    0.000000] PCI Autoconfig: BAR 0x14, Mem size=3D0x8000,
address=3D0xafff0000
[    0.000000] PCI Autoconfig: Found Bus 0, Device 18, Function 0
[    0.000000] PCI Autoconfig: BAR 0x10, Mem size=3D0x10000,
address=3D0xaffe0000
[    0.000000] PCI Autoconfig: Found Bus 0, Device 19, Function 0
[    0.000000] PCI Autoconfig: BAR 0x10, Mem size=3D0x100000,
address=3D0xafe00000
[    0.000000] PCI Autoconfig: Found Bus 0, Device 20, Function 0
[    0.000000] PCI Autoconfig: BAR 0x10, Mem size=3D0x100000,
address=3D0xafd00000
[    0.000000] PCI Autoconfig: BAR 0x14, Mem size=3D0x100000,
address=3D0xafc00000
[    0.000000] arch/ppc/platforms/netcom_stix.c: configuring brgc1
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=3DttyCPM0,115200
root=3D/dev/mtdblock1 rootfstype=3Djffs2 init=3D/linuxrc rw
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    8.607666] cpm_uart: console: compat mode
[    8.731735] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    8.738628] Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
[    8.758208] Memory: 127488k available (1544k kernel code, 700k data,
96k init, 0k highmem)
[    8.785841] Mount-cache hash table entries: 512
[    8.791590] NET: Registered protocol family 16
[    8.795039] PCI: Probing PCI hardware
[    8.800789] PCI: bridge rsrc 0..1ffffff (101), parent c01b86b4
[    8.805075] PCI: bridge rsrc 80000000..9fffffff (1200), parent
c01b86d0
[    8.811662] PCI: bridge rsrc a0000000..afffffff (200), parent
c01b86d0
[    8.818187] PCI:0000:00:00.0: Resource 0: 00000000-0001ffff (f=3D200)
[    8.824450] PCI: Cannot allocate resource region 0 of device
0000:00:00.0
[    8.831240] PCI:  parent is c024a070: a0000000-afffffff (f=3D200)
[    8.837156] PCI:0000:00:00.0: Resource 1: 00000000-07ffffff =
(f=3D1208)
[    8.843507] PCI: Cannot allocate resource region 1 of device
0000:00:00.0
[    8.850301] PCI:  parent is c024a054: 80000000-9fffffff (f=3D1200)
[    8.856309] PCI:0000:00:11.0: Resource 0: affff000-afffffff (f=3D200)
[    8.862575] PCI:0000:00:11.0: Resource 1: afff0000-afff7fff (f=3D200)
[    8.868847] PCI:0000:00:12.0: Resource 0: affe0000-affeffff (f=3D200)
[    8.875115] PCI:0000:00:13.0: Resource 0: afe00000-afefffff (f=3D200)
[    8.881382] PCI:0000:00:14.0: Resource 0: afd00000-afdfffff (f=3D200)
[    8.887643] PCI:0000:00:14.0: Resource 1: afc00000-afcfffff (f=3D200)

00:00.0 Host bridge: Motorola MPC8265A/8266/8272/8270/8280 (rev 20)
        Flags: bus master, 66Mhz, fast devsel, latency 248
        Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [48] #06 [0000]

00:11.0 Bridge: Texas Instruments PCI2040 PCI to DSP Bridge Controller
        Flags: medium devsel, IRQ 19
        Memory at 00000000affff000 (32-bit, non-prefetchable) =
[size=3D4K]
        Memory at 00000000afff0000 (32-bit, non-prefetchable) =
[size=3D32K]
        Capabilities: [50] Power Management version 1

00:12.0 Co-processor: Broadcom Corporation BCM5823 Crypto Accelerator
(rev 01)
        Subsystem: Broadcom Corporation: Unknown device 0200
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 20
        Memory at 00000000affe0000 (32-bit, non-prefetchable) =
[size=3D64K]
        Capabilities: [48] Power Management version 2

00:13.0 Network controller: Agere Systems T8110 H.100/H.110 TDM switch
(rev 04)
        Flags: bus master, medium devsel, latency 128, IRQ 22
        Memory at 00000000afe00000 (32-bit, non-prefetchable) =
[size=3D1M]

00:14.0 Bridge: NET (Network Equipment Technologies) STIX 4 Port T1/E1
Card (rev 04)
        Subsystem: NET (Network Equipment Technologies) STIX 4 Port
T1/E1 Card
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 23
        Memory at 00000000afd00000 (32-bit, non-prefetchable) =
[size=3D1M]
        Memory at 00000000afc00000 (32-bit, non-prefetchable) =
[size=3D1M]
        Capabilities: [dc] Power Management version 1
        Capabilities: [e4] #06 [0094]
        Capabilities: [e8] Vital Product Data

Tony Hardie B.Sc
VX Software Architect
Net.com
6900 Paseo Padre Parkway
Fremont
CA, 94555
Ph: 510-574-2386
Mob: 510-449-4339
