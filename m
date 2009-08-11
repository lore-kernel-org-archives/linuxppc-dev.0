Return-Path: <bj@mhlabs.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2F1CBB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 09:17:28 +1000 (EST)
Received: from mhsecure.serverpowered.net (mhsecure.serverpowered.net
	[204.8.182.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A2E6DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 09:17:27 +1000 (EST)
Received: from static-65-37-93-210.nrp5.mon.ny.frontiernet.net ([65.37.93.210]
	helo=[10.0.1.36])
	by mhsecure.serverpowered.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <bj@mhlabs.com>) id 1Mazd0-0006F0-H0
	for linuxppc-dev@ozlabs.org; Tue, 11 Aug 2009 18:15:35 -0400
Message-Id: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
From: "B.J. Buchalter" <bj@mhlabs.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Problem with PCIe -> PCI bridge on MPC8377E-RDB
Date: Tue, 11 Aug 2009 18:27:03 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Folks,

I have been trying to use a PCIe FireWire card on a MPC8377E-RDB board.

I have tried this with both the LTIB/BSP (2.6.25) and the head of the  
kernel.org tree (at least from a couple of days ago).

With 2.6.25, the PCIe buss(es) don't show up at all during boot.

With 2.6.31-rc? the PCIe busses do show up, and the PCIe -> PCI bridge  
is recognized, but no devices behind the bridge are probed or  
identified.

Here is the boot log:


[    0.000000] Linux version 2.6.31-rc5-00381-g7b2aa03-dirty (adminuser@debian.virtualboximages 
) (gcc version 4.3.2 (Sourcery G++ Lite 4.3-74) ) #32 Tue Aug 11  
17:32:27 EDT 2009
[    0.000000] console [udbg0] enabled
setup_arch: bootmem
mpc837x_rdb_setup_arch()
[    0.000000] Found FSL PCI host bridge at 0x00000000e0008500.  
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@e0008500 (primary) ranges:
[    0.000000]  MEM 0x0000000090000000..0x000000009fffffff ->  
0x0000000090000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff ->  
0x0000000080000000 Prefetch
[    0.000000]   IO 0x00000000e0300000..0x00000000e03fffff ->  
0x0000000000000000
[    0.000000] No pci config register base in dev tree, using default
[    0.000000] Found FSL PCI host bridge at 0x00000000e0009000.  
Firmware bus number: 0->255
[    0.000000] PCI host bridge /pcie@e0009000  ranges:
[    0.000000]  MEM 0x00000000a8000000..0x00000000b7ffffff ->  
0x00000000a8000000
[    0.000000]   IO 0x00000000b8000000..0x00000000b87fffff ->  
0x0000000000000000
[    0.000000] No pci config register base in dev tree, using default
[    0.000000] Found FSL PCI host bridge at 0x00000000e000a000.  
Firmware bus number: 0->255
[    0.000000] PCI host bridge /pcie@e000a000  ranges:
[    0.000000]  MEM 0x00000000c8000000..0x00000000d7ffffff ->  
0x00000000c8000000
[    0.000000]   IO 0x00000000d8000000..0x00000000d87fffff ->  
0x0000000000000000

[...]

[    0.129452] PCI: Probing PCI hardware
[    0.133549] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    0.139448] pci 0000:00:00.0: PME# disabled
[    0.143727] pci 0000:00:0f.0: PME# supported from D0 D1 D2 D3hot
[    0.149624] pci 0000:00:0f.0: PME# disabled
[    0.154791] pci 0001:01:00.0: ignoring class b20 (doesn't match  
header type 01)
[    0.162100] pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot
[    0.168057] pci 0001:01:00.0: PME# disabled
[    0.202566] pci 0001:03:00.0: PCI bridge, secondary bus 0001:04
[    0.208477] pci 0001:03:00.0:   IO window: disabled
[    0.213311] pci 0001:03:00.0:   MEM window: disabled
[    0.218170] pci 0001:03:00.0:   PREFETCH window: disabled
[    0.223528] pci 0001:03:01.0: PCI bridge, secondary bus 0001:05
[    0.229399] pci 0001:03:01.0:   IO window: disabled
[    0.234239] pci 0001:03:01.0:   MEM window: disabled
[    0.239163] pci 0001:03:01.0:   PREFETCH window: disabled
[    0.244522] pci 0001:03:02.0: PCI bridge, secondary bus 0001:06
[    0.250394] pci 0001:03:02.0:   IO window: disabled
[    0.255234] pci 0001:03:02.0:   MEM window: disabled
[    0.260158] pci 0001:03:02.0:   PREFETCH window: disabled
[    0.265517] pci 0001:03:03.0: PCI bridge, secondary bus 0001:07
[    0.271389] pci 0001:03:03.0:   IO window: disabled
[    0.276229] pci 0001:03:03.0:   MEM window: disabled
[    0.281153] pci 0001:03:03.0:   PREFETCH window: disabled
[    0.286513] pci 0001:03:04.0: PCI bridge, secondary bus 0001:08
[    0.292384] pci 0001:03:04.0:   IO window: disabled
[    0.297224] pci 0001:03:04.0:   MEM window: disabled
[    0.302149] pci 0001:03:04.0:   PREFETCH window: disabled
[    0.307508] pci 0001:03:05.0: PCI bridge, secondary bus 0001:09
[    0.313380] pci 0001:03:05.0:   IO window: disabled
[    0.318220] pci 0001:03:05.0:   MEM window: disabled
[    0.323144] pci 0001:03:05.0:   PREFETCH window: disabled
[    0.328503] pci 0001:03:06.0: PCI bridge, secondary bus 0001:0a
[    0.334375] pci 0001:03:06.0:   IO window: disabled
[    0.339215] pci 0001:03:06.0:   MEM window: disabled
[    0.344139] pci 0001:03:06.0:   PREFETCH window: disabled
[    0.349498] pci 0001:03:07.0: PCI bridge, secondary bus 0001:0b
[    0.355370] pci 0001:03:07.0:   IO window: disabled
[    0.360210] pci 0001:03:07.0:   MEM window: disabled
[    0.365134] pci 0001:03:07.0:   PREFETCH window: disabled
[    0.370493] pci 0001:03:08.0: PCI bridge, secondary bus 0001:0c
[    0.376365] pci 0001:03:08.0:   IO window: disabled
[    0.381205] pci 0001:03:08.0:   MEM window: disabled
[    0.386129] pci 0001:03:08.0:   PREFETCH window: disabled
[    0.391489] pci 0001:03:09.0: PCI bridge, secondary bus 0001:0d
[    0.397360] pci 0001:03:09.0:   IO window: disabled
[    0.402200] pci 0001:03:09.0:   MEM window: disabled
[    0.407125] pci 0001:03:09.0:   PREFETCH window: disabled
[    0.412484] pci 0001:03:0a.0: PCI bridge, secondary bus 0001:0e
[    0.418356] pci 0001:03:0a.0:   IO window: disabled
[    0.423196] pci 0001:03:0a.0:   MEM window: disabled
[    0.428120] pci 0001:03:0a.0:   PREFETCH window: disabled
[    0.433479] pci 0001:03:0b.0: PCI bridge, secondary bus 0001:0f
[    0.439351] pci 0001:03:0b.0:   IO window: disabled
[    0.444191] pci 0001:03:0b.0:   MEM window: disabled
[    0.449115] pci 0001:03:0b.0:   PREFETCH window: disabled
[    0.454474] pci 0001:03:0c.0: PCI bridge, secondary bus 0001:10
[    0.460346] pci 0001:03:0c.0:   IO window: disabled
[    0.465186] pci 0001:03:0c.0:   MEM window: disabled
[    0.470110] pci 0001:03:0c.0:   PREFETCH window: disabled
[    0.475469] pci 0001:03:0d.0: PCI bridge, secondary bus 0001:11
[    0.481341] pci 0001:03:0d.0:   IO window: disabled
[    0.486181] pci 0001:03:0d.0:   MEM window: disabled
[    0.491105] pci 0001:03:0d.0:   PREFETCH window: disabled
[    0.496465] pci 0001:03:0e.0: PCI bridge, secondary bus 0001:12
[    0.502336] pci 0001:03:0e.0:   IO window: disabled
[    0.507176] pci 0001:03:0e.0:   MEM window: disabled
[    0.512101] pci 0001:03:0e.0:   PREFETCH window: disabled
[    0.517460] pci 0001:03:0f.0: PCI bridge, secondary bus 0001:13
[    0.523331] pci 0001:03:0f.0:   IO window: disabled
[    0.528172] pci 0001:03:0f.0:   MEM window: disabled
[    0.533096] pci 0001:03:0f.0:   PREFETCH window: disabled
[    0.538455] pci 0001:03:10.0: PCI bridge, secondary bus 0001:14
[    0.544327] pci 0001:03:10.0:   IO window: disabled
[    0.549167] pci 0001:03:10.0:   MEM window: disabled
[    0.554091] pci 0001:03:10.0:   PREFETCH window: disabled
[    0.559450] pci 0001:03:11.0: PCI bridge, secondary bus 0001:15
[    0.565322] pci 0001:03:11.0:   IO window: disabled
[    0.570162] pci 0001:03:11.0:   MEM window: disabled
[    0.575086] pci 0001:03:11.0:   PREFETCH window: disabled
[    0.580445] pci 0001:03:12.0: PCI bridge, secondary bus 0001:16
[    0.586317] pci 0001:03:12.0:   IO window: disabled
[    0.591157] pci 0001:03:12.0:   MEM window: disabled
[    0.596081] pci 0001:03:12.0:   PREFETCH window: disabled
[    0.601441] pci 0001:03:13.0: PCI bridge, secondary bus 0001:17
[    0.607312] pci 0001:03:13.0:   IO window: disabled
[    0.612151] pci 0001:03:13.0:   MEM window: disabled
[    0.617076] pci 0001:03:13.0:   PREFETCH window: disabled
[    0.622436] pci 0001:03:14.0: PCI bridge, secondary bus 0001:18
[    0.628308] pci 0001:03:14.0:   IO window: disabled
[    0.633148] pci 0001:03:14.0:   MEM window: disabled
[    0.638072] pci 0001:03:14.0:   PREFETCH window: disabled
[    0.643431] pci 0001:03:15.0: PCI bridge, secondary bus 0001:19
[    0.649303] pci 0001:03:15.0:   IO window: disabled
[    0.654143] pci 0001:03:15.0:   MEM window: disabled
[    0.659067] pci 0001:03:15.0:   PREFETCH window: disabled
[    0.664426] pci 0001:03:16.0: PCI bridge, secondary bus 0001:1a
[    0.670298] pci 0001:03:16.0:   IO window: disabled
[    0.675138] pci 0001:03:16.0:   MEM window: disabled
[    0.680062] pci 0001:03:16.0:   PREFETCH window: disabled
[    0.685421] pci 0001:03:17.0: PCI bridge, secondary bus 0001:1b
[    0.691293] pci 0001:03:17.0:   IO window: disabled
[    0.696133] pci 0001:03:17.0:   MEM window: disabled
[    0.701057] pci 0001:03:17.0:   PREFETCH window: disabled
[    0.706417] pci 0001:03:18.0: PCI bridge, secondary bus 0001:1c
[    0.712288] pci 0001:03:18.0:   IO window: disabled
[    0.717127] pci 0001:03:18.0:   MEM window: disabled
[    0.722053] pci 0001:03:18.0:   PREFETCH window: disabled
[    0.727412] pci 0001:03:19.0: PCI bridge, secondary bus 0001:1d
[    0.733284] pci 0001:03:19.0:   IO window: disabled
[    0.738123] pci 0001:03:19.0:   MEM window: disabled
[    0.743048] pci 0001:03:19.0:   PREFETCH window: disabled
[    0.748407] pci 0001:03:1a.0: PCI bridge, secondary bus 0001:1e
[    0.754279] pci 0001:03:1a.0:   IO window: disabled
[    0.759119] pci 0001:03:1a.0:   MEM window: disabled
[    0.764043] pci 0001:03:1a.0:   PREFETCH window: disabled
[    0.769402] pci 0001:03:1b.0: PCI bridge, secondary bus 0001:1f
[    0.775274] pci 0001:03:1b.0:   IO window: disabled
[    0.780113] pci 0001:03:1b.0:   MEM window: disabled
[    0.785038] pci 0001:03:1b.0:   PREFETCH window: disabled
[    0.790397] pci 0001:03:1c.0: PCI bridge, secondary bus 0001:20
[    0.796269] pci 0001:03:1c.0:   IO window: disabled
[    0.801109] pci 0001:03:1c.0:   MEM window: disabled
[    0.806033] pci 0001:03:1c.0:   PREFETCH window: disabled
[    0.811392] pci 0001:03:1d.0: PCI bridge, secondary bus 0001:21
[    0.817264] pci 0001:03:1d.0:   IO window: disabled
[    0.822104] pci 0001:03:1d.0:   MEM window: disabled
[    0.827029] pci 0001:03:1d.0:   PREFETCH window: disabled
[    0.832388] pci 0001:03:1e.0: PCI bridge, secondary bus 0001:22
[    0.838260] pci 0001:03:1e.0:   IO window: disabled
[    0.843100] pci 0001:03:1e.0:   MEM window: disabled
[    0.848024] pci 0001:03:1e.0:   PREFETCH window: disabled
[    0.853383] pci 0001:03:1f.0: PCI bridge, secondary bus 0001:23
[    0.859255] pci 0001:03:1f.0:   IO window: disabled
[    0.864095] pci 0001:03:1f.0:   MEM window: disabled
[    0.869019] pci 0001:03:1f.0:   PREFETCH window: disabled
[    0.874378] pci 0001:02:00.0: PCI bridge, secondary bus 0001:03
[    0.880250] pci 0001:02:00.0:   IO window: disabled
[    0.885090] pci 0001:02:00.0:   MEM window: disabled
[    0.890014] pci 0001:02:00.0:   PREFETCH window: disabled
[    0.895373] pci 0001:01:00.0: PCI bridge, secondary bus 0001:02
[    0.901245] pci 0001:01:00.0:   IO window: disabled
[    0.906084] pci 0001:01:00.0:   MEM window: disabled
[    0.911009] pci 0001:01:00.0:   PREFETCH window: disabled


and after boot:

$ lspci
0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c6  
(rev 10)
0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device  
00c6 (rev 10)
0001:02:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:01.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:02.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:03.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:04.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:05.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:06.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:07.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:08.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:09.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0a.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0b.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0c.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0d.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0e.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:0f.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:10.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:11.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:12.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:13.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:14.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:15.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:16.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:17.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:18.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:19.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1a.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1b.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1c.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1d.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1e.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)
0001:03:1f.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200 PCI  
Express-to-PCI Bridge (rev 03)

$ ls /sys/devices/pci0002:24
pci_bus:0002:24  power            uevent

$ ls -l /sys/devices/pci0002:24/pci_bus:0002:24/
-r--r--r--    1 root     root         4096 Jan 20 20:52 cpuaffinity
lrwxrwxrwx    1 root     root            0 Jan 20 20:52 device - 
 > ../../../devices/pci0002:24
-rw-------    1 root     root        65535 Jan 20 20:52 legacy_io
-rw-------    1 root     root      1048576 Jan 20 20:52 legacy_mem
drwxr-xr-x    2 root     root            0 Jan 20 20:52 power
lrwxrwxrwx    1 root     root            0 Jan 20 20:52 subsystem - 
 > ../../pci_bus
-rw-r--r--    1 root     root         4096 Jan 20 20:52 uevent

So it seems like the XIO2000(A) is being misconfigured or  
misidentified, and rather than finding the configured bus behind the  
bridge, it is doing "something else", and as a result, not finding the  
PCI OHCI FireWire controller on the PCI side of the bridge.

Unfortunately I have no real idea where to start looking at this...

Any ideas? Or is there a better place to be posting about this?

TIA,

B.J. Buchalter
