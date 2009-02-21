Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (stargate.chelsio.com [12.22.49.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1DB4DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 12:34:28 +1100 (EST)
Received: from maui.asicdesigners.com (maui.asicdesigners.com [10.192.180.15])
	by stargate.chelsio.com (8.13.1/8.13.1) with SMTP id n1L1YNoH027550
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 17:34:23 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C993C4.9FC09EA6"
Subject: ioremap fails for a device in PCI-E slot on AMCC katmai board
Date: Fri, 20 Feb 2009 17:35:05 -0800
Message-ID: <8A71B368A89016469F72CD08050AD33402D57562@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C993C4.9FC09EA6
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C993C4.9FC09EA6"


------_=_NextPart_002_01C993C4.9FC09EA6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=20

=20

I am trying to get Chelsio's 10G T3 adapter working on Katmai board.=20

When I load the driver (or have it built in to the kernel) I get
following error.

=20

-bash-3.2# insmod cxgb3.ko

__ioremap(): phys addr 0x8000000 is RAM lr e2f21030

cxgb3 0000:11:00.0: cannot map device registers

cxgb3: probe of 0000:11:00.0 failed with error -12

=20

I also tried another pci-e card just as an experiment and that also
failed

myri10ge: Version 1.4.3-1.378

myri10ge 0000:11:00.0: enabling device (0000 -> 0002)

myri10ge 0000:11:00.0: ioremap failed for 16777216 bytes at 0x0

=20

I am using 2.6.28 kernel with katmai config file from kernel.

I have also tried the latest denx kernel which gave same results.=20

=20

Following are the values when I added some printks.

cxgb3:      mmio_start 0x08000000, mmio_len 4096, dev reg addr
0x00000000

kernel:     __ioremap:high mem, virtual 0xe0000000 physical 0x20000000

=20

Looks like the mmio_start value is low hence the call fails. This does
not seem to be a driver issue.=20

=20

Is there something that I am missing in kernel config? any other hints=20

on how to overcome this problem?=20

=20

Below is the boot log, lspci output, and the snippets of the code where
failure happens. config file is attached.

Please let me know if any other information is required.

=20

Thanks

Shubhada

=20

****************************************************

cxgb3_main.c:

        mmio_start =3D pci_resource_start(pdev, 0);

        mmio_len =3D pci_resource_len(pdev, 0);

        ai =3D t3_get_adapter_info(ent->driver_data);

=20

      .....................

=20

        adapter->regs =3D ioremap_nocache(mmio_start, mmio_len);

        if (!adapter->regs) {

                dev_err(&pdev->dev,

                        "cannot map device registers\n");

                err =3D -ENOMEM;

      }

****************************************************

arch/powerpc/mm/pgtable_32.c

        /*

         * Don't allow anybody to remap normal RAM that we're using.

         * mem_init() sets high_memory so only do the check after that.

         */

=20

        if (mem_init_done && (p < virt_to_phys(high_memory))) {

                printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",

                       (unsigned long long)p,
__builtin_return_address(0));

                return NULL;

        }

****************************************************

lspci output=20

=20

0000:11:00.0 Class 0200: Unknown device 1425:0030

        Subsystem: Unknown device 1425:0001

        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-

        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

        Interrupt: pin A routed to IRQ 18

        Region 0: Memory at e08000000 (64-bit, non-prefetchable)
[size=3D4K]

        Region 2: Memory at e00000000 (64-bit, non-prefetchable)
[size=3D128M]

        Region 4: Memory at e08001000 (64-bit, non-prefetchable)
[size=3D4K]

        [virtual] Expansion ROM at e0c000000 [disabled] [size=3D64K]

        Capabilities: [40] Power Management version 3

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)

                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+
Queue=3D0/5 Enable-

                Address: 0000000000000000  Data: 0000

        Capabilities: [58] Express Endpoint IRQ 0

                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag+

                Device: Latency L0s <64ns, L1 <1us

                Device: AtnBtn- AtnInd- PwrInd-

                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-

                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+

                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes

                Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s L1,
Port 0

                Link: Latency L0s unlimited, L1 unlimited

                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-

                Link: Speed 2.5Gb/s, Width x8

        Capabilities: [94] Vital Product Data

        Capabilities: [9c] MSI-X: Enable- Mask- TabSize=3D32

                Vector table: BAR=3D4 offset=3D00000000

                PBA: BAR=3D4 offset=3D00000800

        Capabilities: [100] Device Serial Number 01-00-00-00-01-00-00-00

        Capabilities: [300] Advanced Error Reporting

=20

****************************************************

Following is the log while booting the kernel.=20

Using PowerPC 44x Platform machine description

Linux version 2.6.28 (root@california) (gcc version 4.2.2) #22 Fri Feb
20 15:48:41 PST 2009

console [udbg0] enabled

setup_arch: bootmem

arch: exit

Zone PFN ranges:

  DMA      0x00000000 -> 0x00020000

  Normal   0x00020000 -> 0x00020000

  HighMem  0x00020000 -> 0x00020000

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

    0: 0x00000000 -> 0x00020000

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
130048

Kernel command line: root=3D/dev/nfs rw
nfsroot=3D10.192.165.106:/opt/eldk4.1/eldk4.2/ppc_4xx,tcp,v3
ip=3D10.192.164.166:10.192.165.106:10.192.160.10

UIC0 (32 IRQ sources) at DCR 0xc0

UIC1 (32 IRQ sources) at DCR 0xd0

UIC2 (32 IRQ sources) at DCR 0xe0

UIC3 (32 IRQ sources) at DCR 0xf0

PID hash table entries: 2048 (order: 11, 8192 bytes)

clocksource: timebase mult[500000] shift[22] registered

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Memory: 516224k/524288k available (2796k kernel code, 7640k reserved,
128k data, 129k bss, 144k init)

SLUB: Genslabs=3D10, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1

Calibrating delay loop... 1597.44 BogoMIPS (lpj=3D3194880)

Mount-cache hash table entries: 512

net_namespace: 288 bytes

NET: Registered protocol family 16

            =20

PCIE0: Checking link...

PCIE0: Device detected, waiting for link...

PCIE0: link is up !

PCI host bridge /plb/pciex@d00000000 (primary) ranges:

 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000=20

  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000

4xx PCI DMA offset set to 0x00000000

PCIE0: successfully set as root-complex

PCIE1: Checking link...

PCIE1: No device detected.

PCI host bridge /plb/pciex@d20000000 (primary) ranges:

 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000=20

  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000

4xx PCI DMA offset set to 0x00000000

PCIE1: successfully set as root-complex

PCIE2: Checking link...

PCIE2: No device detected.

PCI host bridge /plb/pciex@d40000000 (primary) ranges:

 MEM 0x0000000f00000000..0x0000000f7fffffff -> 0x0000000080000000=20

  IO 0x0000000f80020000..0x0000000f8002ffff -> 0x0000000000000000

4xx PCI DMA offset set to 0x00000000

PCIE2: successfully set as root-complex

PCI host bridge /plb/pci@c0ec00000 (primary) ranges:

 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000=20

  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000

4xx PCI DMA offset set to 0x00000000

PCI: Probing PCI hardware

PCI: Hiding 4xx host bridge resources 0000:10:00.0

pci 0000:11:00.0: PME# supported from D0 D3hot

pci 0000:11:00.0: PME# disabled

PCI: Hiding 4xx host bridge resources 0001:20:00.0

PCI: Hiding 4xx host bridge resources 0002:30:00.0

pci 0000:10:00.0: PCI bridge, secondary bus 0000:11

pci 0000:10:00.0:   IO window: disabled

pci 0000:10:00.0:   MEM window: 0x80000000-0x8bffffff

pci 0000:10:00.0:   PREFETCH window: 0x0000008c000000-0x0000008c0fffff

pci 0001:20:00.0: PCI bridge, secondary bus 0001:21

pci 0001:20:00.0:   IO window: disabled

pci 0001:20:00.0:   MEM window: disabled

pci 0001:20:00.0:   PREFETCH window: disabled

pci 0002:30:00.0: PCI bridge, secondary bus 0002:31

pci 0002:30:00.0:   IO window: disabled

pci 0002:30:00.0:   MEM window: disabled

pci 0002:30:00.0:   PREFETCH window: disabled

bus: 10 index 0 io port: [0xff080000-0xff08ffff]

bus: 10 index 1 mmio: [0xe00000000-0xe7fffffff]

bus: 11 index 0 mmio: [0xff080000-0xff080fff]

bus: 11 index 1 mmio: [0xe00000000-0xe0bffffff]

bus: 11 index 2 mmio: [0xe0c000000-0xe0c0fffff]

bus: 11 index 3 mmio: [0x0-0x0]

bus: 20 index 0 io port: [0xff0a0000-0xff0affff]

bus: 20 index 1 mmio: [0xe80000000-0xeffffffff]

bus: 21 index 0 mmio: [0xff0a0000-0xff0a0fff]

bus: 21 index 1 mmio: [0xe00000000-0xe000fffff]

bus: 21 index 2 mmio: [0xe00000000-0xe000fffff]

bus: 21 index 3 mmio: [0x0-0x0]

bus: 30 index 0 io port: [0xff0c0000-0xff0cffff]

bus: 30 index 1 mmio: [0xf00000000-0xf7fffffff]

bus: 31 index 0 mmio: [0xff0c0000-0xff0c0fff]

bus: 31 index 1 mmio: [0xe80000000-0xe800fffff]

bus: 31 index 2 mmio: [0xe80000000-0xe800fffff]

bus: 31 index 3 mmio: [0x0-0x0]

bus: 00 index 0 io port: [0x00-0xffff]

bus: 00 index 1 mmio: [0xd80000000-0xdffffffff]

NET: Registered protocol family 2

IP route cache hash table entries: 16384 (order: 4, 65536 bytes)

TCP established hash table entries: 65536 (order: 7, 524288 bytes)

TCP bind hash table entries: 65536 (order: 6, 262144 bytes)

TCP: Hash tables configured (established 65536 bind 65536)

TCP reno registered

NET: Registered protocol family 1

msgmni has been set to 1009

alg: No test for stdrng (krng)

io scheduler noop registered

io scheduler anticipatory registered (default)

io scheduler deadline registered

io scheduler cfq registered

pcieport-driver 0000:10:00.0: found MSI capability

pcieport-driver 0001:20:00.0: found MSI capability

pcieport-driver 0002:30:00.0: found MSI capability

aer: probe of 0000:10:00.0:pcie01 failed with error -38

aer: probe of 0001:20:00.0:pcie01 failed with error -38

aer: probe of 0002:30:00.0:pcie01 failed with error -38

Serial: 8250/16550 driver4 ports, IRQ sharing enabled

serial8250.0: ttyS0 at MMIO 0x4f0000200 (irq =3D 19) is a 16550A

                                                              console
handover: boot [udbg0] -> real [ttyS0]

serial8250.0: ttyS1 at MMIO 0x4f0000300 (irq =3D 20) is a 16550A

serial8250.0: ttyS2 at MMIO 0x4f0000600 (irq =3D 21) is a 16550A

4f0000200.serial: ttyS0 at MMIO 0x4f0000200 (irq =3D 19) is a 16550A

4f0000300.serial: ttyS1 at MMIO 0x4f0000300 (irq =3D 20) is a 16550A

4f0000600.serial: ttyS2 at MMIO 0x4f0000600 (irq =3D 21) is a 16550A

brd: module loaded

Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI

Copyright (c) 1999-2006 Intel Corporation.

e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6

e1000e: Copyright (c) 1999-2008 Intel Corporation.

PPC 4xx OCP EMAC driver, version 3.54

MAL v2 /plb/mcmal, 2 TX channels, 1 RX channels

eth0: EMAC-0 /plb/opb/ethernet@10000800, MAC 00:01:73:77:56:64

eth0: found Generic MII PHY (0x01)

TCP cubic registered

NET: Registered protocol family 17

RPC: Registered udp transport module.

RPC: Registered tcp transport module.

eth0: link is down

IP-Config: Complete:

     device=3Deth0, addr=3D10.192.164.166, mask=3D255.255.240.0,
gw=3D10.192.160.1,

     host=3Dppcb1, domain=3D, nis-domain=3D(none),

     bootserver=3D10.192.165.106, rootserver=3D10.192.165.106, =
rootpath=3D

Looking up port of RPC 100003/3 on 10.192.165.106

eth0: link is up, 100 FDX, pause enabled

Looking up port of RPC 100005/3 on 10.192.165.106

VFS: Mounted root (nfs filesystem).

Freeing unused kernel memory: 144k init

modprobe: FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such
file or directory

=20

modprobe: FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such
file or directory

=20

INIT: version 2.86 booting

                Welcome to DENX Embedded Linux Environment

                Press 'I' to enter interactive startup.

modprobe: FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such
file or directory

=20

modprobe: FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such
file or directory

=20

Cannot access the Hardware Clock via any known method.

Use the --debug option to see the details of our search for an access
method.

Setting clock : Thu Jan  1 01:00:06 CET 1970 [  OK  ]

Building the cache [  OK  ]

Setting hostname ppcb1:  [  OK  ]

Mounting local filesystems:  [  OK  ]

Enabling /etc/fstab swaps:  [  OK  ]

INIT: Entering runlevel: 3

Entering non-interactive startup

FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such file or
directory

Bringing up loopback interface:  [  OK  ]

FATAL: Could not load /lib/modules/2.6.28/modules.dep: No such file or
directory

Starting system logger: [  OK  ]

Starting kernel logger: [  OK  ]

Starting rpcbind: [  OK  ]

Mounting NFS filesystems:  [  OK  ]

Mounting other filesystems:  [  OK  ]

Starting xinetd: [  OK  ]

=20

DENX ELDK version 4.2 build 2008-04-01

Linux 2.6.28 on a ppc

=20


------_=_NextPart_002_01C993C4.9FC09EA6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:st=3D"&#1;" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hi =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I am trying to get =
Chelsio's
10G T3 adapter working on Katmai board. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>When I load the =
driver (or
have it built in to the kernel) I get following =
error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-bash-3.2# insmod =
cxgb3.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>__ioremap(): phys =
addr
0x8000000 is RAM lr e2f21030<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>cxgb3 0000:11:00.0: =
cannot
map device registers<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>cxgb3: probe of =
0000:11:00.0
failed with error -12<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I also tried =
another pci-e
card just as an experiment and that also =
failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>myri10ge: Version
1.4.3-1.378<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>myri10ge =
0000:11:00.0:
enabling device (0000 -&gt; 0002)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>myri10ge =
0000:11:00.0:
ioremap failed for 16777216 bytes at 0x0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I am using 2.6.28 =
kernel
with katmai config file from kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I have also tried =
the latest
denx kernel which gave same results. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Following are the =
values
when I added some printks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>cxgb3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmio_start
0x08000000, mmio_len 4096, dev reg addr =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>kernel:&nbsp;&nbsp;&nbsp;&nbsp; __ioremap:high
mem, virtual 0xe0000000 physical 0x20000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Looks like the =
mmio_start
value is low hence the call fails. This does not seem to be a driver =
issue. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Is there something =
that I am
missing in kernel config? any other hints <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>on how to overcome =
this
problem? <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Below is the boot =
log, lspci
output, and the snippets of the code where failure happens. config file =
is
attached.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Please let me know =
if any
other information is required.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Shubhada<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>****************************************************<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>cxgb3_main.c:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
mmio_start =3D pci_resource_start(pdev, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
mmio_len =3D pci_resource_len(pdev, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ai =3D =
t3_get_adapter_info(ent-&gt;driver_data);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.....................<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
adapter-&gt;regs =3D ioremap_nocache(mmio_start, =
mmio_len);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (!adapter-&gt;regs) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
dev_err(&amp;pdev-&gt;dev,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;cannot map device =
registers\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
err =3D -ENOMEM;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>****************************************************<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>arch/powerpc/mm/pgtable_32.c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/*<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
* Don't allow anybody to remap normal RAM that we're =
using.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
* mem_init() sets high_memory so only do the check after =
that.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
*/<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (mem_init_done &amp;&amp; (p &lt; virt_to_phys(high_memory))) =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
printk(&quot;__ioremap(): phys addr 0x%llx is RAM lr =
%p\n&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(unsigned long long)p, =
__builtin_return_address(0));<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
return NULL;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>****************************************************<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>lspci output =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>0000:11:00.0 Class =
0200:
Unknown device 1425:0030<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Subsystem: Unknown device 1425:0001<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping-
SERR- FastB2B-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt;TAbort- =
&lt;TAbort-
&lt;MAbort- &gt;SERR- &lt;PERR-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Interrupt: pin A routed to IRQ 18<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Region 0: Memory at e08000000 (64-bit, non-prefetchable) =
[size=3D4K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Region 2: Memory at e00000000 (64-bit, non-prefetchable) =
[size=3D128M]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Region 4: Memory at e08001000 (64-bit, non-prefetchable) =
[size=3D4K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[virtual] Expansion ROM at e0c000000 [disabled] =
[size=3D64K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [40] Power Management version =
3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1-,D2-,D3hot+,D3cold-)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ =
Queue=3D0/5 Enable-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Address: 0000000000000000&nbsp; Data: 0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [58] Express Endpoint IRQ 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: Supported: MaxPayload 128 bytes, PhantFunc 0, =
ExtTag+<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: Latency L0s &lt;64ns, L1 &lt;1us<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: AtnBtn- AtnInd- PwrInd-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: Errors: Correctable- Non-Fatal- Fatal- =
Unsupported-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- =
NoSnoop+<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Device: MaxPayload 128 bytes, MaxReadReq 512 =
bytes<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s L1, Port =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Link: Latency L0s unlimited, L1 unlimited<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Link: ASPM Disabled RCB 64 bytes CommClk- =
ExtSynch-<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Link: Speed 2.5Gb/s, Width x8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [94] Vital Product Data<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [9c] MSI-X: Enable- Mask- =
TabSize=3D32<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Vector table: BAR=3D4 offset=3D00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
PBA: BAR=3D4 offset=3D00000800<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [100] Device Serial Number =
01-00-00-00-01-00-00-00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [300] Advanced Error =
Reporting<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>****************************************************<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Following is the =
log while
booting the kernel. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Using PowerPC 44x =
Platform
machine description<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux version =
2.6.28
(root@california) (gcc version 4.2.2) #22 Fri Feb 20 15:48:41 PST =
2009<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>console [udbg0] =
enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>setup_arch: =
bootmem<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>arch: =
exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Zone PFN =
ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; =
</span></font><font
size=3D2 face=3D"Courier New"><span lang=3DPT-BR =
style=3D'font-size:10.0pt;font-family:
"Courier New"'>DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; =
0x00020000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DPT-BR style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;
Normal&nbsp;&nbsp; 0x00020000 -&gt; =
0x00020000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DPT-BR style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; =
</span></font><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>HighMem&nbsp;
0x00020000 -&gt; 0x00020000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Movable zone start =
PFN for
each node<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>early_node_map[1] =
active PFN
ranges<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
0:
0x00000000 -&gt; 0x00020000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Built 1 zonelists =
in Zone
order, mobility grouping on.&nbsp; Total pages: =
130048<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Kernel command =
line:
root=3D/dev/nfs rw =
nfsroot=3D10.192.165.106:/opt/eldk4.1/eldk4.2/ppc_4xx,tcp,v3
ip=3D10.192.164.166:10.192.165.106:10.192.160.10<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>UIC0 (32 IRQ =
sources) at DCR
0xc0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>UIC1 (32 IRQ =
sources) at DCR
0xd0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>UIC2 (32 IRQ =
sources) at DCR
0xe0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>UIC3 (32 IRQ =
sources) at DCR
0xf0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PID hash table =
entries: 2048
(order: 11, 8192 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>clocksource: =
timebase
mult[500000] shift[22] registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Dentry cache hash =
table
entries: 65536 (order: 6, 262144 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Inode-cache hash =
table
entries: 32768 (order: 5, 131072 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Memory: =
516224k/524288k
available (2796k kernel code, 7640k reserved, 128k data, 129k bss, 144k =
init)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SLUB: =
Genslabs=3D10,
HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, =
Nodes=3D1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calibrating delay =
loop...
1597.44 BogoMIPS (lpj=3D3194880)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Mount-cache hash =
table entries:
512<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>net_namespace: 288 =
bytes<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Registered =
protocol
family 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE0: Checking =
link...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE0: Device =
detected,
waiting for link...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE0: link is up =
!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI host bridge
/plb/pciex@d00000000 (primary) ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3D"Courier New"><span lang=3DPT-BR =
style=3D'font-size:10.0pt;font-family:
"Courier New"'>MEM 0x0000000e00000000..0x0000000e7fffffff -&gt;
0x0000000080000000 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DPT-BR style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; =
IO
0x0000000f80000000..0x0000000f8000ffff -&gt; =
0x0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4xx PCI DMA offset =
set to
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE0: successfully =
set as
root-complex<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE1: Checking =
link...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE1: No device =
detected.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI host bridge
/plb/pciex@d20000000 (primary) ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;MEM
0x0000000e80000000..0x0000000effffffff -&gt; 0x0000000080000000 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; IO
0x0000000f80010000..0x0000000f8001ffff -&gt; =
0x0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4xx PCI DMA offset =
set to
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE1: successfully =
set as
root-complex<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE2: Checking =
link...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE2: No device =
detected.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI host bridge
/plb/pciex@d40000000 (primary) ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;MEM
0x0000000f00000000..0x0000000f7fffffff -&gt; 0x0000000080000000 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; IO
0x0000000f80020000..0x0000000f8002ffff -&gt; =
0x0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4xx PCI DMA offset =
set to
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCIE2: successfully =
set as
root-complex<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI host bridge
/plb/pci@c0ec00000 (primary) ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;MEM
0x0000000d80000000..0x0000000dffffffff -&gt; 0x0000000080000000 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; IO
0x0000000c08000000..0x0000000c0800ffff -&gt; =
0x0000000000000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4xx PCI DMA offset =
set to
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Probing PCI =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Hiding 4xx =
host bridge
resources 0000:10:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci 0000:11:00.0: =
PME#
supported from D0 D3hot<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci 0000:11:00.0: =
PME#
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Hiding 4xx =
host bridge
resources 0001:20:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Hiding 4xx =
host bridge
resources 0002:30:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci 0000:10:00.0: =
PCI
bridge, secondary bus 0000:11<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0000:10:00.0:&nbsp;&nbsp; IO window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0000:10:00.0:&nbsp;&nbsp; MEM window: =
0x80000000-0x8bffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0000:10:00.0:&nbsp;&nbsp; PREFETCH window: =
0x0000008c000000-0x0000008c0fffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci 0001:20:00.0: =
PCI
bridge, secondary bus 0001:21<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0001:20:00.0:&nbsp;&nbsp; IO window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0001:20:00.0:&nbsp;&nbsp; MEM window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0001:20:00.0:&nbsp;&nbsp; PREFETCH window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci 0002:30:00.0: =
PCI
bridge, secondary bus 0002:31<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0002:30:00.0:&nbsp;&nbsp; IO window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0002:30:00.0:&nbsp;&nbsp; MEM window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pci
0002:30:00.0:&nbsp;&nbsp; PREFETCH window: =
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 10 index 0 io =
port:
[0xff080000-0xff08ffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 10 index 1 =
mmio:
[0xe00000000-0xe7fffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 11 index 0 =
mmio:
[0xff080000-0xff080fff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 11 index 1 =
mmio:
[0xe00000000-0xe0bffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 11 index 2 =
mmio:
[0xe0c000000-0xe0c0fffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 11 index 3 =
mmio:
[0x0-0x0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 20 index 0 io =
port:
[0xff0a0000-0xff0affff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 20 index 1 =
mmio:
[0xe80000000-0xeffffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 21 index 0 =
mmio:
[0xff0a0000-0xff0a0fff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 21 index 1 =
mmio:
[0xe00000000-0xe000fffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 21 index 2 =
mmio:
[0xe00000000-0xe000fffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 21 index 3 =
mmio:
[0x0-0x0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 30 index 0 io =
port:
[0xff0c0000-0xff0cffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 30 index 1 =
mmio:
[0xf00000000-0xf7fffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 31 index 0 =
mmio: [0xff0c0000-0xff0c0fff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 31 index 1 =
mmio:
[0xe80000000-0xe800fffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 31 index 2 =
mmio:
[0xe80000000-0xe800fffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 31 index 3 =
mmio:
[0x0-0x0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 00 index 0 io =
port:
[0x00-0xffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bus: 00 index 1 =
mmio:
[0xd80000000-0xdffffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Registered =
protocol
family 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>IP route cache hash =
table
entries: 16384 (order: 4, 65536 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP established =
hash table
entries: 65536 (order: 7, 524288 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP bind hash table =
entries:
65536 (order: 6, 262144 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP: Hash tables =
configured
(established 65536 bind 65536)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP <st1:City =
w:st=3D"on"><st1:place
 w:st=3D"on">reno</st1:place></st1:City> =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Registered =
protocol
family 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>msgmni has been set =
to 1009<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>alg: No test for =
stdrng
(krng)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler noop =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
anticipatory
registered (default)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
deadline
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler cfq =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pcieport-driver
0000:10:00.0: found MSI capability<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pcieport-driver
0001:20:00.0: found MSI capability<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>pcieport-driver
0002:30:00.0: found MSI capability<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>aer: probe of
0000:10:00.0:pcie01 failed with error -38<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>aer: probe of
0001:20:00.0:pcie01 failed with error -38<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>aer: probe of
0002:30:00.0:pcie01 failed with error -38<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Serial: 8250/16550 =
driver4
ports, IRQ sharing enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>serial8250.0: ttyS0 =
at MMIO
0x4f0000200 (irq =3D 19) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;console
handover: boot [udbg0] -&gt; real [ttyS0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>serial8250.0: ttyS1 =
at MMIO
0x4f0000300 (irq =3D 20) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>serial8250.0: ttyS2 =
at MMIO
0x4f0000600 (irq =3D 21) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4f0000200.serial: =
ttyS0 at
MMIO 0x4f0000200 (irq =3D 19) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4f0000300.serial: =
ttyS1 at
MMIO 0x4f0000300 (irq =3D 20) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>4f0000600.serial: =
ttyS2 at
MMIO 0x4f0000600 (irq =3D 21) is a 16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>brd: module =
loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Intel(R) PRO/1000 =
Network
Driver - version 7.3.20-k3-NAPI<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Copyright (c) =
1999-2006
Intel Corporation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>e1000e: Intel(R) =
PRO/1000
Network Driver - 0.3.3.3-k6<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>e1000e: Copyright =
(c)
1999-2008 Intel Corporation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PPC 4xx OCP EMAC =
driver,
version 3.54<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>MAL v2 /plb/mcmal, =
2 TX
channels, 1 RX channels<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: EMAC-0
/plb/opb/ethernet@10000800, MAC =
00:01:73:77:56:64<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: found Generic =
MII PHY
(0x01)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP cubic =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Registered =
protocol
family 17<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RPC: Registered udp
transport module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RPC: Registered tcp
transport module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: link is =
down<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>IP-Config: =
Complete:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;
device=3Deth0, addr=3D10.192.164.166, mask=3D255.255.240.0, =
gw=3D10.192.160.1,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;
host=3Dppcb1, domain=3D, =
nis-domain=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;
bootserver=3D10.192.165.106, rootserver=3D10.192.165.106, =
rootpath=3D<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Looking up =
<st1:place w:st=3D"on"><st1:PlaceType
 w:st=3D"on">port</st1:PlaceType> of <st1:PlaceName =
w:st=3D"on">RPC</st1:PlaceName></st1:place>
100003/3 on 10.192.165.106<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: link is up, =
100 FDX,
pause enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Looking up =
<st1:place w:st=3D"on"><st1:PlaceType
 w:st=3D"on">port</st1:PlaceType> of <st1:PlaceName =
w:st=3D"on">RPC</st1:PlaceName></st1:place>
100005/3 on 10.192.165.106<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>VFS: Mounted root =
(nfs
filesystem).<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Freeing unused =
kernel
memory: 144k init<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>modprobe: FATAL: =
Could not
load /lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>modprobe: FATAL: =
Could not
load /lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>INIT: version 2.86 =
booting<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Welcome to DENX Embedded Linux Environment<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
Press 'I' to enter interactive startup.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>modprobe: FATAL: =
Could not
load /lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>modprobe: FATAL: =
Could not
load /lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Cannot access the =
Hardware
Clock via any known method.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Use the --debug =
option to
see the details of our search for an access =
method.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Setting clock : Thu
Jan&nbsp; 1 01:00:06 CET 1970 [&nbsp; OK&nbsp; =
]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Building the cache =
[&nbsp;
OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Setting hostname
ppcb1:&nbsp; [&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Mounting local
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Enabling /etc/fstab =
swaps:&nbsp;
[&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>INIT: Entering =
runlevel: 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Entering =
non-interactive
startup<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>FATAL: Could not =
load
/lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Bringing up =
loopback
interface:&nbsp; [&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>FATAL: Could not =
load
/lib/modules/2.6.28/modules.dep: No such file or =
directory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Starting system =
logger:
[&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Starting kernel =
logger:
[&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Starting rpcbind: =
[&nbsp;
OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Mounting NFS
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Mounting other
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Starting xinetd: =
[&nbsp;
OK&nbsp; ]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>DENX ELDK version =
4.2 build
2008-04-01<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux 2.6.28 on a =
ppc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C993C4.9FC09EA6--

------_=_NextPart_001_01C993C4.9FC09EA6
Content-Type: application/octet-stream;
	name="config-2.6.28-katmai"
Content-Transfer-Encoding: base64
Content-Description: config-2.6.28-katmai
Content-Disposition: attachment;
	filename="config-2.6.28-katmai"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yOAojIEZyaSBGZWIgMjAgMTc6MTg6MzkgMjAwOQojCiMg
Q09ORklHX1BQQzY0IGlzIG5vdCBzZXQKCiMKIyBQcm9jZXNzb3Igc3VwcG9ydAojCiMgQ09ORklH
XzZ4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ184NXh4IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
Xzh4eCBpcyBub3Qgc2V0CiMgQ09ORklHXzQweCBpcyBub3Qgc2V0CkNPTkZJR180NHg9eQojIENP
TkZJR19FMjAwIGlzIG5vdCBzZXQKQ09ORklHXzR4eD15CkNPTkZJR19CT09LRT15CkNPTkZJR19Q
VEVfNjRCSVQ9eQpDT05GSUdfUEhZU182NEJJVD15CiMgQ09ORklHX1BQQ19NTV9TTElDRVMgaXMg
bm90IHNldApDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFPXkKQ09ORklHX1BQQzMyPXkKQ09ORklH
X1dPUkRfU0laRT0zMgpDT05GSUdfQVJDSF9QSFlTX0FERFJfVF82NEJJVD15CkNPTkZJR19NTVU9
eQpDT05GSUdfR0VORVJJQ19DTU9TX1VQREFURT15CkNPTkZJR19HRU5FUklDX1RJTUU9eQpDT05G
SUdfR0VORVJJQ19USU1FX1ZTWVNDQUxMPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFM9eQpD
T05GSUdfR0VORVJJQ19IQVJESVJRUz15CiMgQ09ORklHX0hBVkVfU0VUVVBfUEVSX0NQVV9BUkVB
IGlzIG5vdCBzZXQKQ09ORklHX0lSUV9QRVJfQ1BVPXkKQ09ORklHX1NUQUNLVFJBQ0VfU1VQUE9S
VD15CkNPTkZJR19IQVZFX0xBVEVOQ1lUT1BfU1VQUE9SVD15CkNPTkZJR19MT0NLREVQX1NVUFBP
UlQ9eQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfQVJDSF9IQVNfSUxP
RzJfVTMyPXkKQ09ORklHX0dFTkVSSUNfSFdFSUdIVD15CkNPTkZJR19HRU5FUklDX0NBTElCUkFU
RV9ERUxBWT15CkNPTkZJR19HRU5FUklDX0ZJTkRfTkVYVF9CSVQ9eQpDT05GSUdfR0VORVJJQ19H
UElPPXkKIyBDT05GSUdfQVJDSF9OT19WSVJUX1RPX0JVUyBpcyBub3Qgc2V0CkNPTkZJR19QUEM9
eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0dFTkVSSUNfTlZSQU09eQpDT05GSUdfU0NI
RURfTk9fTk9fT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09ORklHX0FSQ0hfTUFZX0hBVkVfUENfRkRD
PXkKQ09ORklHX1BQQ19PRj15CkNPTkZJR19PRj15CkNPTkZJR19QUENfVURCR18xNjU1MD15CiMg
Q09ORklHX0dFTkVSSUNfVEJTWU5DIGlzIG5vdCBzZXQKQ09ORklHX0FVRElUX0FSQ0g9eQpDT05G
SUdfR0VORVJJQ19CVUc9eQojIENPTkZJR19ERUZBVUxUX1VJTUFHRSBpcyBub3Qgc2V0CkNPTkZJ
R19QUENfRENSX05BVElWRT15CiMgQ09ORklHX1BQQ19EQ1JfTU1JTyBpcyBub3Qgc2V0CkNPTkZJ
R19QUENfRENSPXkKQ09ORklHX0RFRkNPTkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVOQU1FX1JF
TEVBU0UvLmNvbmZpZyIKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0VYUEVSSU1FTlRBTD15
CkNPTkZJR19CUk9LRU5fT05fU01QPXkKQ09ORklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgpDT05G
SUdfTE9DQUxWRVJTSU9OPSIiCkNPTkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJR19TV0FQ
PXkKQ09ORklHX1NZU1ZJUEM9eQpDT05GSUdfU1lTVklQQ19TWVNDVEw9eQpDT05GSUdfUE9TSVhf
TVFVRVVFPXkKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RB
U0tTVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVRElUIGlzIG5vdCBzZXQKIyBDT05GSUdfSUtD
T05GSUcgaXMgbm90IHNldApDT05GSUdfTE9HX0JVRl9TSElGVD0xNAojIENPTkZJR19DR1JPVVBT
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1JPVVBfU0NIRUQgaXMgbm90IHNldApDT05GSUdfU1lTRlNf
REVQUkVDQVRFRD15CkNPTkZJR19TWVNGU19ERVBSRUNBVEVEX1YyPXkKIyBDT05GSUdfUkVMQVkg
aXMgbm90IHNldAojIENPTkZJR19OQU1FU1BBQ0VTIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZf
SU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKIyBDT05GSUdfQ0NfT1BUSU1JWkVf
Rk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0VNQkVEREVEPXkKQ09O
RklHX1NZU0NUTF9TWVNDQUxMPXkKQ09ORklHX0tBTExTWU1TPXkKIyBDT05GSUdfS0FMTFNZTVNf
QUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfS0FMTFNZTVNfRVhUUkFfUEFTUyBpcyBub3Qgc2V0CkNP
TkZJR19IT1RQTFVHPXkKQ09ORklHX1BSSU5USz15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NP
UkU9eQpDT05GSUdfQ09NUEFUX0JSSz15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9
eQpDT05GSUdfQU5PTl9JTk9ERVM9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpD
T05GSUdfVElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX0FJ
Tz15CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CkNPTkZJR19QQ0lfUVVJUktTPXkKQ09ORklH
X1NMVUJfREVCVUc9eQojIENPTkZJR19TTEFCIGlzIG5vdCBzZXQKQ09ORklHX1NMVUI9eQojIENP
TkZJR19TTE9CIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUFSS0VSUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX09QUk9GSUxFPXkKQ09ORklHX0tQUk9C
RVM9eQpDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNPTkZJR19LUkVU
UFJPQkVTPXkKQ09ORklHX0hBVkVfSU9SRU1BUF9QUk9UPXkKQ09ORklHX0hBVkVfS1BST0JFUz15
CkNPTkZJR19IQVZFX0tSRVRQUk9CRVM9eQpDT05GSUdfSEFWRV9BUkNIX1RSQUNFSE9PSz15CiMg
Q09ORklHX0hBVkVfR0VORVJJQ19ETUFfQ09IRVJFTlQgaXMgbm90IHNldApDT05GSUdfU0xBQklO
Rk89eQpDT05GSUdfUlRfTVVURVhFUz15CiMgQ09ORklHX1RJTllfU0hNRU0gaXMgbm90IHNldApD
T05GSUdfQkFTRV9TTUFMTD0wCkNPTkZJR19NT0RVTEVTPXkKIyBDT05GSUdfTU9EVUxFX0ZPUkNF
X0xPQUQgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9G
T1JDRV9VTkxPQUQgaXMgbm90IHNldAojIENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMg
Q09ORklHX01PRFVMRV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKQ09O
RklHX0JMT0NLPXkKQ09ORklHX0xCRD15CiMgQ09ORklHX0JMS19ERVZfSU9fVFJBQ0UgaXMgbm90
IHNldAojIENPTkZJR19MU0YgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0JTRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfSU5URUdSSVRZIGlzIG5vdCBzZXQKCiMKIyBJTyBTY2hlZHVs
ZXJzCiMKQ09ORklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0FTPXkKQ09ORklHX0lP
U0NIRURfREVBRExJTkU9eQpDT05GSUdfSU9TQ0hFRF9DRlE9eQpDT05GSUdfREVGQVVMVF9BUz15
CiMgQ09ORklHX0RFRkFVTFRfREVBRExJTkUgaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX0NG
USBpcyBub3Qgc2V0CiMgQ09ORklHX0RFRkFVTFRfTk9PUCBpcyBub3Qgc2V0CkNPTkZJR19ERUZB
VUxUX0lPU0NIRUQ9ImFudGljaXBhdG9yeSIKQ09ORklHX0NMQVNTSUNfUkNVPXkKIyBDT05GSUdf
RlJFRVpFUiBpcyBub3Qgc2V0CkNPTkZJR19QUEM0eHhfUENJX0VYUFJFU1M9eQoKIwojIFBsYXRm
b3JtIHN1cHBvcnQKIwojIENPTkZJR19QUENfQ0VMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19D
RUxMX05BVElWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BRMkFEUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0JBTUJPTyBpcyBub3Qgc2V0CiMgQ09ORklHX0VCT05ZIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FN
NDQwRVAgaXMgbm90IHNldAojIENPTkZJR19TRVFVT0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFJ
U0hBTiBpcyBub3Qgc2V0CkNPTkZJR19LQVRNQUk9eQojIENPTkZJR19SQUlOSUVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV0FSUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NBTllPTkxBTkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0xBQ0lFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1lPU0VNSVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1ZJUlRFWDQ0MF9H
RU5FUklDX0JPQVJEIGlzIG5vdCBzZXQKQ09ORklHX1BQQzQ0eF9TSU1QTEU9eQpDT05GSUdfUFBD
NHh4X0dQSU89eQpDT05GSUdfNDQwU1BlPXkKIyBDT05GSUdfSVBJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX01QSUMgaXMgbm90IHNldAojIENPTkZJR19NUElDX1dFSVJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX0k4MjU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX1JUQVMgaXMgbm90IHNldAojIENP
TkZJR19NTUlPX05WUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzEwNiBpcyBub3Qgc2V0
CiMgQ09ORklHX1BQQ185NzBfTkFQIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0lORElSRUNUX0lP
IGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJQ19JT01BUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQ
VV9GUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNMX1VMSTE1NzUgaXMgbm90IHNldAoKIwojIEtl
cm5lbCBvcHRpb25zCiMKIyBDT05GSUdfSElHSE1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX05PX0ha
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElHSF9SRVNfVElNRVJTIGlzIG5vdCBzZXQKQ09ORklHX0dF
TkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQojIENPTkZJR19IWl8xMDAgaXMgbm90IHNldApDT05G
SUdfSFpfMjUwPXkKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMTAwMCBp
cyBub3Qgc2V0CkNPTkZJR19IWj0yNTAKIyBDT05GSUdfU0NIRURfSFJUSUNLIGlzIG5vdCBzZXQK
Q09ORklHX1BSRUVNUFRfTk9ORT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19CSU5GTVRfRUxGPXkKIyBDT05G
SUdfQ09SRV9EVU1QX0RFRkFVTFRfRUxGX0hFQURFUlMgaXMgbm90IHNldAojIENPTkZJR19IQVZF
X0FPVVQgaXMgbm90IHNldAojIENPTkZJR19CSU5GTVRfTUlTQyBpcyBub3Qgc2V0CiMgQ09ORklH
X01BVEhfRU1VTEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfSEVMUEVSIGlzIG5vdCBz
ZXQKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9IT1RQTFVHPXkKQ09ORklHX0FSQ0hfSEFTX1dB
TEtfTUVNT1JZPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9IT1RSRU1PVkU9eQpDT05GSUdf
QVJDSF9GTEFUTUVNX0VOQUJMRT15CkNPTkZJR19BUkNIX1BPUFVMQVRFU19OT0RFX01BUD15CkNP
TkZJR19TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklHX0ZMQVRNRU1fTUFOVUFMPXkKIyBDT05G
SUdfRElTQ09OVElHTUVNX01BTlVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRU1FTV9NQU5V
QUwgaXMgbm90IHNldApDT05GSUdfRkxBVE1FTT15CkNPTkZJR19GTEFUX05PREVfTUVNX01BUD15
CkNPTkZJR19QQUdFRkxBR1NfRVhURU5ERUQ9eQpDT05GSUdfU1BMSVRfUFRMT0NLX0NQVVM9NApD
T05GSUdfTUlHUkFUSU9OPXkKQ09ORklHX1JFU09VUkNFU182NEJJVD15CkNPTkZJR19QSFlTX0FE
RFJfVF82NEJJVD15CkNPTkZJR19aT05FX0RNQV9GTEFHPTEKQ09ORklHX0JPVU5DRT15CkNPTkZJ
R19WSVJUX1RPX0JVUz15CkNPTkZJR19VTkVWSUNUQUJMRV9MUlU9eQpDT05GSUdfRk9SQ0VfTUFY
X1pPTkVPUkRFUj0xMQpDT05GSUdfUFJPQ19ERVZJQ0VUUkVFPXkKQ09ORklHX0NNRExJTkVfQk9P
TD15CkNPTkZJR19DTURMSU5FPSJyb290PS9kZXYvbmZzIHJ3IG5mc3Jvb3Q9MTAuMTkyLjE2NS4x
MDY6L29wdC9lbGRrNC4xL2VsZGs0LjIvcHBjXzR4eCx0Y3AsdjMgaXA9MTAuMTkyLjE2NC4xNjY6
MTAuMTkyLjE2NS4xMDY6MTAuMTkyLjE2MC4xOjI1NS4yNTUuMjQwLjA6cHBjYjE6ZXRoMDpvZmYg
Y29uc29sZT10dHlTMCwxMTUyMDAiCkNPTkZJR19FWFRSQV9UQVJHRVRTPSIiCkNPTkZJR19TRUND
T01QPXkKQ09ORklHX0lTQV9ETUFfQVBJPXkKCiMKIyBCdXMgb3B0aW9ucwojCkNPTkZJR19aT05F
X0RNQT15CkNPTkZJR19QUENfSU5ESVJFQ1RfUENJPXkKQ09ORklHXzR4eF9TT0M9eQpDT05GSUdf
UFBDX1BDSV9DSE9JQ0U9eQpDT05GSUdfUENJPXkKQ09ORklHX1BDSV9ET01BSU5TPXkKQ09ORklH
X1BDSV9TWVNDQUxMPXkKQ09ORklHX1BDSUVQT1JUQlVTPXkKQ09ORklHX1BDSUVBRVI9eQojIENP
TkZJR19QQ0lFQVNQTSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1NVUFBPUlRTX01TST15CkNPTkZJ
R19QQ0lfTVNJPXkKQ09ORklHX1BDSV9MRUdBQ1k9eQpDT05GSUdfUENJX0RFQlVHPXkKIyBDT05G
SUdfUENDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAojIENP
TkZJR19IQVNfUkFQSURJTyBpcyBub3Qgc2V0CgojCiMgQWR2YW5jZWQgc2V0dXAKIwojIENPTkZJ
R19BRFZBTkNFRF9PUFRJT05TIGlzIG5vdCBzZXQKCiMKIyBEZWZhdWx0IHNldHRpbmdzIGZvciBh
ZHZhbmNlZCBjb25maWd1cmF0aW9uIG9wdGlvbnMgYXJlIHVzZWQKIwpDT05GSUdfTE9XTUVNX1NJ
WkU9MHgzMDAwMDAwMApDT05GSUdfUEFHRV9PRkZTRVQ9MHhjMDAwMDAwMApDT05GSUdfS0VSTkVM
X1NUQVJUPTB4YzAwMDAwMDAKQ09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MDAwMDAwMDAKQ09ORklH
X1RBU0tfU0laRT0weGMwMDAwMDAwCkNPTkZJR19DT05TSVNURU5UX1NUQVJUPTB4ZmYxMDAwMDAK
Q09ORklHX0NPTlNJU1RFTlRfU0laRT0weDAwMjAwMDAwCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdv
cmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQojIENPTkZJR19QQUNLRVRfTU1BUCBpcyBu
b3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19J
TkVUPXkKIyBDT05GSUdfSVBfTVVMVElDQVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfQURWQU5D
RURfUk9VVEVSIGlzIG5vdCBzZXQKQ09ORklHX0lQX0ZJQl9IQVNIPXkKQ09ORklHX0lQX1BOUD15
CkNPTkZJR19JUF9QTlBfREhDUD15CkNPTkZJR19JUF9QTlBfQk9PVFA9eQojIENPTkZJR19JUF9Q
TlBfUkFSUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0lQR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZ
Tl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90IHNldAojIENP
TkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9UVU5ORUwgaXMg
bm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fTU9ERV9UUkFOU1BPUlQgaXMgbm90IHNldAojIENP
TkZJR19JTkVUX1hGUk1fTU9ERV9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1f
TU9ERV9CRUVUIGlzIG5vdCBzZXQKQ09ORklHX0lORVRfTFJPPXkKQ09ORklHX0lORVRfRElBRz15
CkNPTkZJR19JTkVUX1RDUF9ESUFHPXkKIyBDT05GSUdfVENQX0NPTkdfQURWQU5DRUQgaXMgbm90
IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3Vi
aWMiCiMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldAojIENPTkZJR19JUFY2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAg
aXMgbm90IHNldAojIENPTkZJR19USVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZMQU5fODAyMVEgaXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90IHNl
dAojIENPTkZJR19MTEMyIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBC
IGlzIG5vdCBzZXQKIyBDT05GSUdfRUNPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOX1JPVVRF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hFRCBpcyBub3Qgc2V0CgojCiMgTmV0d29yayB0
ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9UQ1BQ
Uk9CRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FO
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNldAojIENPTkZJR19QSE9ORVQgaXMgbm90IHNl
dAojIENPTkZJR19XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JGS0lMTCBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF85UCBpcyBub3Qgc2V0CgojCiMgRGV2aWNlIERyaXZlcnMKIwoKIwojIEdl
bmVyaWMgRHJpdmVyIE9wdGlvbnMKIwpDT05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9o
b3RwbHVnIgpDT05GSUdfU1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxE
PXkKQ09ORklHX0ZXX0xPQURFUj15CkNPTkZJR19GSVJNV0FSRV9JTl9LRVJORUw9eQpDT05GSUdf
RVhUUkFfRklSTVdBUkU9IiIKIyBDT05GSUdfREVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfREVWUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTX0hZUEVSVklTT1IgaXMgbm90
IHNldApDT05GSUdfQ09OTkVDVE9SPXkKQ09ORklHX1BST0NfRVZFTlRTPXkKIyBDT05GSUdfTVRE
IGlzIG5vdCBzZXQKQ09ORklHX09GX0RFVklDRT15CkNPTkZJR19PRl9HUElPPXkKIyBDT05GSUdf
UEFSUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9GRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BR
X0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ09XX0NPTU1P
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JM
S19ERVZfTkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TWDggaXMgbm90IHNldApDT05G
SUdfQkxLX0RFVl9SQU09eQpDT05GSUdfQkxLX0RFVl9SQU1fQ09VTlQ9MTYKQ09ORklHX0JMS19E
RVZfUkFNX1NJWkU9MzUwMDAKIyBDT05GSUdfQkxLX0RFVl9YSVAgaXMgbm90IHNldAojIENPTkZJ
R19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWElMSU5YX1NZU0FDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSEQg
aXMgbm90IHNldApDT05GSUdfTUlTQ19ERVZJQ0VTPXkKIyBDT05GSUdfUEhBTlRPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9JT0M0IGlz
IG5vdCBzZXQKIyBDT05GSUdfVElGTV9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5DTE9TVVJF
X1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBfSUxPIGlzIG5vdCBzZXQKIyBDT05GSUdf
QzJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfSURFPXkKIyBDT05GSUdfSURFIGlzIG5vdCBz
ZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTkVUTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQSBpcyBub3Qgc2V0
CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJ
RUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKCiMKIyBFbmFibGUgb25seSBvbmUgb2YgdGhl
IHR3byBzdGFja3MsIHVubGVzcyB5b3Uga25vdyB3aGF0IHlvdSBhcmUgZG9pbmcKIwojIENPTkZJ
R19GSVJFV0lSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUUxMzk0IGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJPIGlzIG5vdCBzZXQKQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTPXkKIyBDT05GSUdfTUFD
X0VNVU1PVVNFQlROIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lOREZBUk0gaXMgbm90IHNldApDT05G
SUdfTkVUREVWSUNFUz15CiMgQ09ORklHX0RVTU1ZIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9ORElO
RyBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZMQU4gaXMgbm90IHNldAojIENPTkZJR19FUVVBTEla
RVIgaXMgbm90IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19WRVRIIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElCIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9FVEhFUk5FVD15CkNPTkZJR19NSUk9eQojIENPTkZJR19IQVBQWU1FQUwg
aXMgbm90IHNldAojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldAojIENPTkZJR19DQVNTSU5JIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1RVTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfSFAxMDAgaXMgbm90IHNldApDT05GSUdfSUJNX05F
V19FTUFDPXkKQ09ORklHX0lCTV9ORVdfRU1BQ19SWEI9MTI4CkNPTkZJR19JQk1fTkVXX0VNQUNf
VFhCPTY0CkNPTkZJR19JQk1fTkVXX0VNQUNfUE9MTF9XRUlHSFQ9MzIKQ09ORklHX0lCTV9ORVdf
RU1BQ19SWF9DT1BZX1RIUkVTSE9MRD0yNTYKQ09ORklHX0lCTV9ORVdfRU1BQ19SWF9TS0JfSEVB
RFJPT009MAojIENPTkZJR19JQk1fTkVXX0VNQUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19J
Qk1fTkVXX0VNQUNfWk1JSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19SR01JSSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19UQUggaXMgbm90IHNldApDT05GSUdfSUJN
X05FV19FTUFDX0VNQUM0PXkKIyBDT05GSUdfSUJNX05FV19FTUFDX05PX0ZMT1dfQ1RSTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19NQUxfQ0xSX0lDSU5UU1RBVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19NQUxfQ09NTU9OX0VSUiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9QQ0kgaXMgbm90IHNldApDT05GSUdfQjQ0PXkKQ09ORklHX0I0NF9QQ0lfQVVUT1NFTEVD
VD15CkNPTkZJR19CNDRfUENJQ09SRV9BVVRPU0VMRUNUPXkKQ09ORklHX0I0NF9QQ0k9eQojIENP
TkZJR19BVEwyIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVl8xMDAwPXkKIyBDT05GSUdfQUNFTklD
IGlzIG5vdCBzZXQKIyBDT05GSUdfREwySyBpcyBub3Qgc2V0CkNPTkZJR19FMTAwMD15CkNPTkZJ
R19FMTAwMEU9eQojIENPTkZJR19JUDEwMDAgaXMgbm90IHNldAojIENPTkZJR19JR0IgaXMgbm90
IHNldAojIENPTkZJR19OUzgzODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFNQUNISSBpcyBub3Qg
c2V0CiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1I4MTY5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0tHRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NLWTIgaXMgbm90IHNldAojIENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNldAoj
IENPTkZJR19USUdPTjMgaXMgbm90IHNldAojIENPTkZJR19CTlgyIGlzIG5vdCBzZXQKIyBDT05G
SUdfUUxBM1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTDEgaXMgbm90IHNldAojIENPTkZJR19B
VEwxRSBpcyBub3Qgc2V0CiMgQ09ORklHX0pNRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZfMTAw
MDA9eQojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hFTFNJT19UMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0VOSUMgaXMgbm90IHNldAojIENPTkZJR19JWEdCRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lYR0IgaXMgbm90IHNldAojIENPTkZJR19TMklPIGlzIG5vdCBzZXQKQ09O
RklHX01ZUkkxMEdFPXkKIyBDT05GSUdfTkVUWEVOX05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX05J
VSBpcyBub3Qgc2V0CiMgQ09ORklHX01MWDRfRU4gaXMgbm90IHNldAojIENPTkZJR19NTFg0X0NP
UkUgaXMgbm90IHNldAojIENPTkZJR19URUhVVEkgaXMgbm90IHNldAojIENPTkZJR19CTlgyWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1FMR0UgaXMgbm90IHNldAojIENPTkZJR19TRkMgaXMgbm90IHNl
dAojIENPTkZJR19UUiBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3MgTEFOCiMKIyBDT05GSUdfV0xB
Tl9QUkU4MDIxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fODAyMTEgaXMgbm90IHNldAojIENP
TkZJR19JV0xXSUZJX0xFRFMgaXMgbm90IHNldAojIENPTkZJR19XQU4gaXMgbm90IHNldAojIENP
TkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNldAojIENPTkZJR19Q
UFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUQ09OU09M
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9M
TF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0lO
UFVUIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwojIENPTkZJR19TRVJJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2
aWNlcwojCiMgQ09ORklHX1ZUIGlzIG5vdCBzZXQKQ09ORklHX0RFVktNRU09eQojIENPTkZJR19T
RVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAojIENPTkZJR19OT1pPTUkgaXMgbm90IHNldAoK
IwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84
MjUwX0NPTlNPTEU9eQojIENPTkZJR19TRVJJQUxfODI1MF9QQ0kgaXMgbm90IHNldApDT05GSUdf
U0VSSUFMXzgyNTBfTlJfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00
CkNPTkZJR19TRVJJQUxfODI1MF9FWFRFTkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllf
UE9SVFMgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKIyBDT05GSUdf
U0VSSUFMXzgyNTBfREVURUNUX0lSUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JT
QSBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklH
X1NFUklBTF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19T
RVJJQUxfQ09SRV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNPTkZJ
R19TRVJJQUxfT0ZfUExBVEZPUk09eQpDT05GSUdfVU5JWDk4X1BUWVM9eQpDT05GSUdfTEVHQUNZ
X1BUWVM9eQpDT05GSUdfTEVHQUNZX1BUWV9DT1VOVD0yNTYKIyBDT05GSUdfSVBNSV9IQU5ETEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZSQU0g
aXMgbm90IHNldAojIENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMg
bm90IHNldAojIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIg
aXMgbm90IHNldAojIENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKQ09ORklHX0RFVlBPUlQ9eQoj
IENPTkZJR19JMkMgaXMgbm90IHNldAojIENPTkZJR19TUEkgaXMgbm90IHNldApDT05GSUdfQVJD
SF9XQU5UX09QVElPTkFMX0dQSU9MSUI9eQpDT05GSUdfQVJDSF9SRVFVSVJFX0dQSU9MSUI9eQpD
T05GSUdfR1BJT0xJQj15CiMgQ09ORklHX0RFQlVHX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19H
UElPX1NZU0ZTIGlzIG5vdCBzZXQKCiMKIyBNZW1vcnkgbWFwcGVkIEdQSU8gZXhwYW5kZXJzOgoj
CiMgQ09ORklHX0dQSU9fWElMSU5YIGlzIG5vdCBzZXQKCiMKIyBJMkMgR1BJTyBleHBhbmRlcnM6
CiMKCiMKIyBQQ0kgR1BJTyBleHBhbmRlcnM6CiMKIyBDT05GSUdfR1BJT19CVDhYWCBpcyBub3Qg
c2V0CgojCiMgU1BJIEdQSU8gZXhwYW5kZXJzOgojCiMgQ09ORklHX1cxIGlzIG5vdCBzZXQKIyBD
T05GSUdfUE9XRVJfU1VQUExZIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdNT04gaXMgbm90IHNldAoj
IENPTkZJR19USEVSTUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9IV01PTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9QT1NTSUJMRT15Cgoj
CiMgU29uaWNzIFNpbGljb24gQmFja3BsYW5lCiMKQ09ORklHX1NTQj15CkNPTkZJR19TU0JfU1BS
T009eQpDT05GSUdfU1NCX1BDSUhPU1RfUE9TU0lCTEU9eQpDT05GSUdfU1NCX1BDSUhPU1Q9eQoj
IENPTkZJR19TU0JfQjQzX1BDSV9CUklER0UgaXMgbm90IHNldAojIENPTkZJR19TU0JfU0lMRU5U
IGlzIG5vdCBzZXQKIyBDT05GSUdfU1NCX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9EUklW
RVJfUENJQ09SRV9QT1NTSUJMRT15CkNPTkZJR19TU0JfRFJJVkVSX1BDSUNPUkU9eQoKIwojIE11
bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19NRkRfQ09SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9TTTUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0hUQ19QQVNJQzMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfVE1JTyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUiBpcyBu
b3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMKCiMKIyBNdWx0aW1lZGlhIGNvcmUgc3Vw
cG9ydAojCiMgQ09ORklHX1ZJREVPX0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0RWQl9DT1JFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklERU9fTUVESUEgaXMgbm90IHNldAoKIwojIE11bHRpbWVkaWEg
ZHJpdmVycwojCkNPTkZJR19EQUI9eQoKIwojIEdyYXBoaWNzIHN1cHBvcnQKIwojIENPTkZJR19B
R1AgaXMgbm90IHNldAojIENPTkZJR19EUk0gaXMgbm90IHNldAojIENPTkZJR19WR0FTVEFURSBp
cyBub3Qgc2V0CkNPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTD1tCiMgQ09ORklHX0ZCIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xDRF9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBEaXNw
bGF5IGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfRElTUExBWV9TVVBQT1JUIGlzIG5vdCBzZXQK
IyBDT05GSUdfU09VTkQgaXMgbm90IHNldApDT05GSUdfVVNCX1NVUFBPUlQ9eQpDT05GSUdfVVNC
X0FSQ0hfSEFTX0hDRD15CkNPTkZJR19VU0JfQVJDSF9IQVNfT0hDST15CkNPTkZJR19VU0JfQVJD
SF9IQVNfRUhDST15CiMgQ09ORklHX1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfV0hJ
VEVMSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09UR19CTEFDS0xJU1RfSFVCIGlzIG5vdCBz
ZXQKCiMKIyBFbmFibGUgSG9zdCBvciBHYWRnZXQgc3VwcG9ydCB0byBzZWUgSW52ZW50cmEgb3B0
aW9ucwojCgojCiMgTk9URTogVVNCX1NUT1JBR0UgZGVwZW5kcyBvbiBTQ1NJIGJ1dCBCTEtfREVW
X1NEIG1heSBhbHNvIGJlIG5lZWRlZDsKIwojIENPTkZJR19VU0JfR0FER0VUIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVdCIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUVNU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQK
IyBDT05GSUdfRURBQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RNQURFVklDRVMgaXMgbm90IHNldAojIENPTkZJR19VSU8gaXMgbm90IHNldAojIENP
TkZJR19TVEFHSU5HIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRVhUMl9G
Uz15CiMgQ09ORklHX0VYVDJfRlNfWEFUVFIgaXMgbm90IHNldAojIENPTkZJR19FWFQyX0ZTX1hJ
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlMgaXMgbm90IHNldAojIENPTkZJR19FWFQ0X0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19GU19QT1NJWF9BQ0wgaXMgbm90IHNldApDT05GSUdfRklM
RV9MT0NLSU5HPXkKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT0NGUzJfRlMg
aXMgbm90IHNldApDT05GSUdfRE5PVElGWT15CkNPTkZJR19JTk9USUZZPXkKQ09ORklHX0lOT1RJ
RllfVVNFUj15CiMgQ09ORklHX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVUT0ZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVVUT0ZTNF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0VfRlMg
aXMgbm90IHNldAoKIwojIENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwojIENPTkZJR19JU085NjYw
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVURGX0ZTIGlzIG5vdCBzZXQKCiMKIyBET1MvRkFUL05U
IEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfTVNET1NfRlMgaXMgbm90IHNldAojIENPTkZJR19WRkFU
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRGU19GUyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZp
bGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19Q
Uk9DX1NZU0NUTD15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CkNPTkZJR19TWVNGUz15CkNP
TkZJR19UTVBGUz15CiMgQ09ORklHX1RNUEZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklH
X0hVR0VUTEJfUEFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5vdCBzZXQK
CiMKIyBNaXNjZWxsYW5lb3VzIGZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfQURGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FGRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19IRlNQTFVTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0
CkNPTkZJR19DUkFNRlM9eQojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlO
SVhfRlMgaXMgbm90IHNldAojIENPTkZJR19PTUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JP
TUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VG
U19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNURU1TPXkKQ09ORklHX05GU19G
Uz15CkNPTkZJR19ORlNfVjM9eQojIENPTkZJR19ORlNfVjNfQUNMIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZTX1Y0IGlzIG5vdCBzZXQKQ09ORklHX1JPT1RfTkZTPXkKIyBDT05GSUdfTkZTRCBpcyBu
b3Qgc2V0CkNPTkZJR19MT0NLRD15CkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19ORlNfQ09NTU9O
PXkKQ09ORklHX1NVTlJQQz15CiMgQ09ORklHX1NVTlJQQ19SRUdJU1RFUl9WNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JQQ1NFQ19HU1NfS1JCNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JQQ1NFQ19HU1Nf
U1BLTTMgaXMgbm90IHNldAojIENPTkZJR19TTUJfRlMgaXMgbm90IHNldAojIENPTkZJR19DSUZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkNQX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FGU19GUyBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVz
CiMKIyBDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BB
UlRJVElPTj15CiMgQ09ORklHX05MUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RMTSBpcyBub3Qgc2V0
CgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19CSVRSRVZFUlNFPXkKIyBDT05GSUdfQ1JD
X0NDSVRUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMTYgaXMgbm90IHNldAojIENPTkZJR19DUkNf
VDEwRElGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDX0lUVV9UIGlzIG5vdCBzZXQKQ09ORklHX0NS
QzMyPXkKIyBDT05GSUdfQ1JDNyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkNSQzMyQyBpcyBub3Qg
c2V0CkNPTkZJR19aTElCX0lORkxBVEU9eQpDT05GSUdfUExJU1Q9eQpDT05GSUdfSEFTX0lPTUVN
PXkKQ09ORklHX0hBU19JT1BPUlQ9eQpDT05GSUdfSEFTX0RNQT15CkNPTkZJR19IQVZFX0xNQj15
CgojCiMgS2VybmVsIGhhY2tpbmcKIwojIENPTkZJR19QUklOVEtfVElNRSBpcyBub3Qgc2V0CkNP
TkZJR19FTkFCTEVfV0FSTl9ERVBSRUNBVEVEPXkKQ09ORklHX0VOQUJMRV9NVVNUX0NIRUNLPXkK
Q09ORklHX0ZSQU1FX1dBUk49MTAyNApDT05GSUdfTUFHSUNfU1lTUlE9eQojIENPTkZJR19VTlVT
RURfU1lNQk9MUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSEVBREVSU19DSEVDSyBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19LRVJORUw9eQojIENPTkZJ
R19ERUJVR19TSElSUSBpcyBub3Qgc2V0CkNPTkZJR19ERVRFQ1RfU09GVExPQ0tVUD15CiMgQ09O
RklHX0JPT1RQQVJBTV9TT0ZUTE9DS1VQX1BBTklDIGlzIG5vdCBzZXQKQ09ORklHX0JPT1RQQVJB
TV9TT0ZUTE9DS1VQX1BBTklDX1ZBTFVFPTAKQ09ORklHX1NDSEVEX0RFQlVHPXkKIyBDT05GSUdf
U0NIRURTVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RJTUVSX1NUQVRTIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfT0JKRUNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NMVUJfREVCVUdfT04gaXMg
bm90IHNldAojIENPTkZJR19TTFVCX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUlRf
TVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX01VVEVYX1RFU1RFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTVVURVhFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLX1NMRUVQIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfTE9DS0lOR19BUElfU0VMRlRFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
S09CSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0UgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19JTkZPIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVk0gaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19XUklURUNPVU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTUVN
T1JZX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfU0cgaXMgbm90IHNldAojIENPTkZJR19CT09UX1BSSU5US19ERUxBWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JDVV9UT1JUVVJFX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SQ1VfQ1BV
X1NUQUxMX0RFVEVDVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfS1BST0JFU19TQU5JVFlfVEVTVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tUUkFDRV9TRUxGX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19ERUJVR19CTE9DS19FWFRfREVWVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xLRFRNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFURU5DWVRP
UCBpcyBub3Qgc2V0CkNPTkZJR19TWVNDVExfU1lTQ0FMTF9DSEVDSz15CkNPTkZJR19IQVZFX0ZV
TkNUSU9OX1RSQUNFUj15CgojCiMgVHJhY2VycwojCiMgQ09ORklHX0ZVTkNUSU9OX1RSQUNFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTlRF
WFRfU1dJVENIX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JPT1RfVFJBQ0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1RBQ0tfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfRFlOQU1JQ19QUklO
VEtfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKQ09ORklHX0hB
VkVfQVJDSF9LR0RCPXkKIyBDT05GSUdfS0dEQiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NU
QUNLT1ZFUkZMT1cgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREVfUEFU
Q0hJTkdfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19GVFJfRklYVVBfU0VMRlRFU1QgaXMg
bm90IHNldAojIENPTkZJR19NU0lfQklUTUFQX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
WE1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSUVNUQUNLUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JE
SV9TV0lUQ0ggaXMgbm90IHNldAojIENPTkZJR19QUENfRUFSTFlfREVCVUcgaXMgbm90IHNldAoK
IwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWUZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFlfRklMRV9DQVBBQklMSVRJRVMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPPXkK
CiMKIyBDcnlwdG8gY29yZSBvciBoZWxwZXIKIwojIENPTkZJR19DUllQVE9fRklQUyBpcyBub3Qg
c2V0CkNPTkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklH
X0NSWVBUT19BRUFEMj15CkNPTkZJR19DUllQVE9fQkxLQ0lQSEVSPXkKQ09ORklHX0NSWVBUT19C
TEtDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19IQVNIMj15CkNPTkZJR19DUllQVE9fUk5HMj15CkNP
TkZJR19DUllQVE9fTUFOQUdFUj15CkNPTkZJR19DUllQVE9fTUFOQUdFUjI9eQojIENPTkZJR19D
UllQVE9fR0YxMjhNVUwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTlVMTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19DUllQVEQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVVUSEVO
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19URVNUIGlzIG5vdCBzZXQKCiMKIyBBdXRoZW50
aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lhdGVkIERhdGEKIwojIENPTkZJR19DUllQVE9f
Q0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0dDTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19TRVFJViBpcyBub3Qgc2V0CgojCiMgQmxvY2sgbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0NC
Qz15CiMgQ09ORklHX0NSWVBUT19DVFIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1RTIGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19FQ0I9eQojIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBz
ZXQKQ09ORklHX0NSWVBUT19QQ0JDPXkKIyBDT05GSUdfQ1JZUFRPX1hUUyBpcyBub3Qgc2V0Cgoj
CiMgSGFzaCBtb2RlcwojCiMgQ09ORklHX0NSWVBUT19ITUFDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1hDQkMgaXMgbm90IHNldAoKIwojIERpZ2VzdAojCiMgQ09ORklHX0NSWVBUT19DUkMz
MkMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTUQ0IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBU
T19NRDU9eQojIENPTkZJR19DUllQVE9fTUlDSEFFTF9NSUMgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fUk1EMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDE2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19STUQyNTYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUk1EMzIw
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTEgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fU0hBMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTUxMiBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19UR1IxOTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fV1A1MTIgaXMg
bm90IHNldAoKIwojIENpcGhlcnMKIwojIENPTkZJR19DUllQVE9fQUVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0FOVUJJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUkM0IGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMT1dGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0NBTUVMTElBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0NBU1Q2IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19ERVM9eQojIENPTkZJ
R19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tIQVpBRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19TQUxTQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NF
RUQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VSUEVOVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19URUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBub3Qgc2V0
CgojCiMgQ29tcHJlc3Npb24KIwojIENPTkZJR19DUllQVE9fREVGTEFURSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19MWk8gaXMgbm90IHNldAoKIwojIFJhbmRvbSBOdW1iZXIgR2VuZXJhdGlv
bgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5HIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19I
Vz15CiMgQ09ORklHX0NSWVBUT19ERVZfSElGTl83OTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
X0NMT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfVklSVFVBTElaQVRJT04gaXMgbm90IHNldAo=

------_=_NextPart_001_01C993C4.9FC09EA6--
