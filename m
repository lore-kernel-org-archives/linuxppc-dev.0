Return-Path: <srs0=d6yo=3s=gmail.com=ianjiang.cn@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1qKb2Mg3zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 22:30:59 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1qKb1m4qz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 22:30:59 +1000 (AEST)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 3w1qKX1gtBz9sNW
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 22:30:56 +1000 (AEST)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id E84A540DEB39
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 05:21:10 -0700 (PDT)
Date: Mon, 10 Apr 2017 05:22:33 -0700 (MST)
From: IanJiang <ianjiang.cn@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1491826953201-121121.post@n7.nabble.com>
Subject: EEH error in doing DMA with PEX 8619
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all!

I am porting PLX driver for PEX 8619 to a power8 machine with CentOS-7.3.
The PEX 8619 is used as an NTB (Non-Transparent Bridge).

First, two DMA buffer are allocated with dma_alloc_coherent() and the
physical address are:
src: 0x 00000000_60600000
dst: 0x 00000000_60800000
Then, a DMA transfer is started and an EEH is reported in dmesg.

This DMA test is OK at an x86_64 platform.

Here are the details. Any suggestion is appreciated! 

[root@localhost ~]# uname -r
3.10.0-514.10.2.el7.ppc64le
[root@localhost ~]# cat /etc/system-release
CentOS Linux release 7.3.1611 (AltArch)
[root@localhost ~]# dmesg --clear
[root@localhost ~]# dmesg -w
[72579.982217] usb 1-1.3: USB disconnect, device number 61
[72581.516186] usb 1-1.3: new low-speed USB device number 62 using xhci_hcd
[72581.643767] usb 1-1.3: New USB device found, idVendor=04ca,
idProduct=0061
[72581.644045] usb 1-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber                                          =0
[72581.644135] usb 1-1.3: Product: USB Optical Mouse
[72581.644184] usb 1-1.3: Manufacturer: PixArt
[72581.680383] input: PixArt USB Optical Mouse as
/devices/pci0003:00/0003:00:00                                         
.0/0003:01:00.0/0003:02:09.0/0003:0d:00.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input12                                         
46
[72581.680806] hid-generic 0003:04CA:0061.04DF: input,hidraw1: USB HID v1.11
Mou                                          se [PixArt USB Optical Mouse]
on usb-0003:0d:00.0-1.3/input0

[72582.424769] Plx8000_NT:
<====================================================                                         
====>
[72582.425013] Plx8000_NT: PLX 8000_NT driver v7.25 (64-bit)
[72582.425058] Plx8000_NT: Supports Linux kernel
v3.10.0-514.10.2.el7.ppc64le
[72582.425115] Plx8000_NT: Allocated global driver object (c000003c8427cc00)
[72582.425120] Plx8000_NT: Registered driver (MajorID = 247)
[72582.425161] Plx8000_NT:    --------------------
[72582.425167] Plx8000_NT: Probe: 8619 10B5 [D1 01:00.1]
[72582.425180] Plx8000_NT: Probe: -- Unsupported Device --
[72582.425204] Plx8000_NT:    --------------------
[72582.425206] Plx8000_NT: Probe: 8619 10B5 [D1 02:01.0]
[72582.425222] Plx8000_NT: Enabled PCI device
[72582.425233] Plx8000_NT: Created Device (Plx8000_NT-0)
[72582.425235] Plx8000_NT: Start: 8619 10B5 [D1 02:01.0]
[72582.425237] Debug StartDevice 723: Reading PCI header command...
[72582.425385] Debug StartDevice 725: Reading PCI header command... =
0x100146
[72582.425445] Plx8000_NT:    Resource 00
[72582.425447] Plx8000_NT:      Type     : Memory
[72582.425452] Plx8000_NT:      PCI BAR 0: 81000000
[72582.425454] Plx8000_NT:      Phys Addr: 3FE081000000
[72582.425456] Plx8000_NT:      Size     : 20000h (128KB)
[72582.425458] Plx8000_NT:      Property : Non-Prefetchable 32-bit
[72582.425475] Plx8000_NT:      Kernel VA: d000080081480000
[72582.425478] Debug StartDevice 841: Read BAR0[0xd000080081480000] after
map...
[72582.425551] Debug StartDevice 843: Read BAR0[0xd000080081480000] after
map...                                           = 0x861910b5
[72582.425621] Plx8000_NT:    Resource 01
[72582.425622] Plx8000_NT:      Type     : Memory
[72582.425627] Plx8000_NT:      PCI BAR 2: 80000000
[72582.425629] Plx8000_NT:      Phys Addr: 3FE080000000
[72582.425631] Plx8000_NT:      Size     : 400000h (4MB)
[72582.425633] Plx8000_NT:      Property : Non-Prefetchable 32-bit
[72582.425639] Plx8000_NT:      Kernel VA: d000080084000000
[72582.425641] Debug StartDevice 849: Read BAR2[0xd000080084000000] after
map...
[72582.425727] Debug StartDevice 851: Read BAR2[0xd000080084000000] after
map...                                           = 0xf000eef3
[72582.425798] Plx8000_NT:    Resource 02
[72582.425799] Plx8000_NT:      Type     : Memory
[72582.425804] Plx8000_NT:      PCI BAR 3: 80400000
[72582.425806] Plx8000_NT:      Phys Addr: 3FE080400000
[72582.425808] Plx8000_NT:      Size     : 400000h (4MB)
[72582.425809] Plx8000_NT:      Property : Non-Prefetchable 32-bit
[72582.425813] Plx8000_NT:      Kernel VA: d000080084800000
[72582.425815] Plx8000_NT:    Resource 03
[72582.425816] Plx8000_NT:      Type     : Memory
[72582.425821] Plx8000_NT:      PCI BAR 4: 80800000
[72582.425822] Plx8000_NT:      Phys Addr: 3FE080800000
[72582.425824] Plx8000_NT:      Size     : 400000h (4MB)
[72582.425826] Plx8000_NT:      Property : Non-Prefetchable 32-bit
[72582.425830] Plx8000_NT:      Kernel VA: d000080085000000
[72582.425831] Plx8000_NT:    Resource 04
[72582.425832] Plx8000_NT:      Type     : Memory
[72582.425837] Plx8000_NT:      PCI BAR 5: 80C00000
[72582.425839] Plx8000_NT:      Phys Addr: 3FE080C00000
[72582.425841] Plx8000_NT:      Size     : 400000h (4MB)
[72582.425842] Plx8000_NT:      Property : Non-Prefetchable 32-bit
[72582.425846] Plx8000_NT:      Kernel VA: d000080085800000
[72582.425848] Debug StartDevice 862: Reading PCI header command...
[72582.425911] Debug StartDevice 864: Reading PCI header command... =
0x100146
[72582.426048] Plx8000_NT: Device 8619_10B5 = 8619 rev BA
[72582.426051] Plx8000_NT: Device in NT LEGACY mode
[72582.426053] Debug StartDevice 891: Read BAR0[0xd000080081480000] before
PlxDe                                          termineNtPortSide...
[72582.426136] Debug StartDevice 893: Read BAR0[0xd000080081480000] before
PlxDe                                          termineNtPortSide map... =
0x861910b5
[72582.426244] Plx8000_NT: NT port is VIRTUAL-side (NT base=10000h)
[72582.426246] Debug StartDevice 901: Read BAR0[0xd000080081480000] after
PlxDet                                          ermineNtPortSide...
[72582.426330] Debug StartDevice 903: Read BAR0[0xd000080081480000] after
PlxDet                                          ermineNtPortSide map... =
0x861910b5
[72582.426492] Plx8000_NT: MSI enabled, change IRQ 249 --> 499
[72582.426494] Plx8000_NT:    Resource 05
[72582.426496] Plx8000_NT:      Type     : Interrupt (MSI)
[72582.426498] Plx8000_NT:      IRQ      : 499 [1F3h]
[72582.426508] Plx8000_NT:      MSI Addr : 10000000
[72582.426513] Plx8000_NT: _00000000
[72582.426518] Plx8000_NT:      MSI Data : 0001
[72582.426538] Plx8000_NT: Installed ISR for interrupt
[72582.430260] Plx8000_NT:    --------------------
[72582.430266] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.1]
[72582.430280] Plx8000_NT: Probe: -- Unsupported Device --
[72582.430302] Plx8000_NT:    --------------------
[72582.430305] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.2]
[72582.430312] Plx8000_NT: Probe: -- Unsupported Device --
[72582.430331] Plx8000_NT:    --------------------
[72582.430334] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.3]
[72582.430341] Plx8000_NT: Probe: -- Unsupported Device --
[72582.430359] Plx8000_NT:    --------------------
[72582.430362] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.4]
[72582.430370] Plx8000_NT: Probe: -- Unsupported Device --
[72582.430418] Plx8000_NT: Attempt to allocate physical memory (8KB)
[72582.430434] Plx8000_NT: Allocated physical memory...
[72582.430436] Plx8000_NT:     CPU Phys Addr: 1fcb980000
[72582.430438] Plx8000_NT:     Bus Phys Addr: 605f0000
[72582.430440] Plx8000_NT:     Kernel VA    : c000001fcb980000
[72582.430442] Plx8000_NT:     Size         : 2000h (8KB)
[72582.430444] Plx8000_NT:    --------------------
[72582.430446] Plx8000_NT: Added: 1 device
[72582.430447] Plx8000_NT: ...driver loaded


[72584.344506] Plx8000_DMA:
<===================================================                                         
=====>
[72584.344730] Plx8000_DMA: PLX 8000_DMA driver v7.25 (64-bit)
[72584.344779] Plx8000_DMA: Supports Linux kernel
v3.10.0-514.10.2.el7.ppc64le
[72584.344838] Plx8000_DMA: Allocated global driver object
(c000003c8743e400)
[72584.344901] Plx8000_DMA: Registered driver (MajorID = 246)
[72584.345195] Plx8000_DMA:    --------------------
[72584.345248] Plx8000_DMA: Probe: 8619 10B5 [D1 01:00.1]
[72584.345307] Plx8000_DMA: Enabled PCI device
[72584.345352] PLX 8000 DMA Driver 0001:01:00.1: Using 32-bit DMA via iommu
[72584.345410] Plx8000_DMA: Set DMA bit mask to 48-bits
[72584.345459] Plx8000_DMA: Created Device (Plx8000_DMA-0)
[72584.345507] Plx8000_DMA: Start: 8619 10B5 [D1 01:00.1]
[72584.345555] Plx8000_DMA:    Resource 00
[72584.345591] Plx8000_DMA:      Type     : Memory
[72584.345643] Plx8000_DMA:      PCI BAR 0: 81820000
[72584.345690] Plx8000_DMA:      Phys Addr: 3FE081820000
[72584.345737] Plx8000_DMA:      Size     : 20000h (128KB)
[72584.345785] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
[72584.345850] Plx8000_DMA:      Kernel VA: d0000800814c0000
[72584.345946] Plx8000_DMA: Device 8619_10B5 = 8619 rev BA
[72584.346042] Plx8000_DMA: MSI enabled, change IRQ 249 --> 500
[72584.346101] Plx8000_DMA:    Resource 01
[72584.346137] Plx8000_DMA:      Type     : Interrupt (MSI)
[72584.346201] Plx8000_DMA:      IRQ      : 500 [1F4h]
[72584.346257] Plx8000_DMA:      MSI Addr : 10000000
[72584.346309] Plx8000_DMA: _00000000
[72584.346360] Plx8000_DMA:      MSI Data : 0002
[72584.346421] Plx8000_DMA: Installed ISR for interrupt
[72584.346492] Plx8000_DMA:    --------------------
[72584.346545] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.1]
[72584.346716] Plx8000_DMA: Enabled PCI device
[72584.346764] PLX 8000 DMA Driver 0003:01:00.1: Using 32-bit DMA via iommu
[72584.346824] Plx8000_DMA: Set DMA bit mask to 48-bits
[72584.346877] Plx8000_DMA: Created Device (Plx8000_DMA-1)
[72584.346925] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.1]
[72584.346974] Plx8000_DMA:    Resource 00
[72584.347011] Plx8000_DMA:      Type     : Memory
[72584.347064] Plx8000_DMA:      PCI BAR 0: 83040000
[72584.347113] Plx8000_DMA:      Phys Addr: 3FE883040000
[72584.347162] Plx8000_DMA:      Size     : 2000h (8KB)
[72584.347210] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
[72584.347540] Plx8000_DMA:      Kernel VA: d000080081500000
[72584.347682] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
[72584.347978] Plx8000_DMA: MSI enabled, change IRQ 251 --> 272
[72584.348035] Plx8000_DMA:    Resource 01
[72584.348070] Plx8000_DMA:      Type     : Interrupt (MSI)
[72584.348120] Plx8000_DMA:      IRQ      : 272 [110h]
[72584.348178] Plx8000_DMA:      MSI Addr : 10000000
[72584.348233] Plx8000_DMA: _00000000
[72584.348287] Plx8000_DMA:      MSI Data : 0010
[72584.348591] Plx8000_DMA: Installed ISR for interrupt
[72584.348679] Plx8000_DMA:    --------------------
[72584.348729] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.2]
[72584.348816] Plx8000_DMA: Enabled PCI device
[72584.348862] PLX 8000 DMA Driver 0003:01:00.2: Using 32-bit DMA via iommu
[72584.348923] Plx8000_DMA: Set DMA bit mask to 48-bits
[72584.348969] Plx8000_DMA: Created Device (Plx8000_DMA-2)
[72584.349020] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.2]
[72584.349067] Plx8000_DMA:    Resource 00
[72584.349103] Plx8000_DMA:      Type     : Memory
[72584.349157] Plx8000_DMA:      PCI BAR 0: 83042000
[72584.349204] Plx8000_DMA:      Phys Addr: 3FE883042000
[72584.349254] Plx8000_DMA:      Size     : 2000h (8KB)
[72584.349302] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
[72584.349363] Plx8000_DMA:      Kernel VA: d000080081522000
[72584.349506] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
[72584.349583] Plx8000_DMA: MSI enabled, change IRQ 251 --> 273
[72584.349644] Plx8000_DMA:    Resource 01
[72584.349678] Plx8000_DMA:      Type     : Interrupt (MSI)
[72584.349727] Plx8000_DMA:      IRQ      : 273 [111h]
[72584.349785] Plx8000_DMA:      MSI Addr : 10000000
[72584.349838] Plx8000_DMA: _00000000
[72584.349889] Plx8000_DMA:      MSI Data : 0011
[72584.349949] Plx8000_DMA: Installed ISR for interrupt
[72584.368388] Plx8000_DMA:    --------------------
[72584.391876] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.3]
[72584.425867] Plx8000_DMA: Enabled PCI device
[72584.450961] PLX 8000 DMA Driver 0003:01:00.3: Using 32-bit DMA via iommu
[72584.483472] Plx8000_DMA: Set DMA bit mask to 48-bits
[72584.509006] Plx8000_DMA: Created Device (Plx8000_DMA-3)
[72584.525950] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.3]
[72584.541772] Plx8000_DMA:    Resource 00
[72584.541812] Plx8000_DMA:      Type     : Memory
[72584.559059] Plx8000_DMA:      PCI BAR 0: 83044000
[72584.575990] Plx8000_DMA:      Phys Addr: 3FE883044000
[72584.624617] Plx8000_DMA:      Size     : 2000h (8KB)
[72584.624664] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
[72584.723477] Plx8000_DMA:      Kernel VA: d000080081544000
[72584.723649] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
[72584.763734] Plx8000_DMA: MSI enabled, change IRQ 251 --> 274
[72584.803059] Plx8000_DMA:    Resource 01
[72584.874235] Plx8000_DMA:      Type     : Interrupt (MSI)
[72584.912277] Plx8000_DMA:      IRQ      : 274 [112h]
[72584.963428] Plx8000_DMA:      MSI Addr : 10000000
[72585.026007] Plx8000_DMA: _00000000
[72585.026061] Plx8000_DMA:      MSI Data : 0012
[72585.073093] Plx8000_DMA: Installed ISR for interrupt
[72585.122892] Plx8000_DMA:    --------------------
[72585.144207] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.4]
[72585.193044] Plx8000_DMA: Enabled PCI device
[72585.193094] PLX 8000 DMA Driver 0003:01:00.4: Using 32-bit DMA via iommu
[72585.263429] Plx8000_DMA: Set DMA bit mask to 48-bits
[72585.263478] Plx8000_DMA: Created Device (Plx8000_DMA-4)
[72585.294337] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.4]
[72585.323464] Plx8000_DMA:    Resource 00
[72585.354389] Plx8000_DMA:      Type     : Memory
[72585.392937] Plx8000_DMA:      PCI BAR 0: 83046000
[72585.392987] Plx8000_DMA:      Phys Addr: 3FE883046000
[72585.414362] Plx8000_DMA:      Size     : 2000h (8KB)
[72585.462987] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
[72585.493881] Plx8000_DMA:      Kernel VA: d000080081566000
[72585.543127] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
[72585.583609] Plx8000_DMA: MSI enabled, change IRQ 251 --> 275
[72585.683382] Plx8000_DMA:    Resource 01
[72585.718783] Plx8000_DMA:      Type     : Interrupt (MSI)
[72585.775014] Plx8000_DMA:      IRQ      : 275 [113h]
[72585.815631] Plx8000_DMA:      MSI Addr : 10000000
[72585.815686] Plx8000_DMA: _00000000
[72585.893318] Plx8000_DMA:      MSI Data : 0013
[72585.933506] Plx8000_DMA: Installed ISR for interrupt
[72585.974842] Plx8000_DMA: Attempt to allocate physical memory (64KB)
[72586.033768] Plx8000_DMA: Allocated physical memory...
[72586.054260] Plx8000_DMA:     CPU Phys Addr: 1fc0db0000
[72586.102799] Plx8000_DMA:     Bus Phys Addr: 60010000
[72586.102848] Plx8000_DMA:     Kernel VA    : c000001fc0db0000
[72586.125801] Plx8000_DMA:     Size         : 10000h (64KB)
[72586.162839] Plx8000_DMA:    --------------------
[72586.183867] Plx8000_DMA: Added: 5 devices
[72586.222818] Plx8000_DMA: ...driver loaded

[72620.662060] Plx8000_NT:
[72620.662064] Plx8000_NT: Received message ==> OPEN_DEVICE
[72620.662066] Plx8000_NT: Open device (Plx8000_NT-0)...
[72620.662068] Plx8000_NT: ...device opened
[72620.662071] Plx8000_NT:
[72620.662073] Plx8000_NT: Received PLX message ===>
[72620.662074] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72620.662076] Plx8000_NT: ...Completed message
[72620.662078] Plx8000_NT:
[72620.662080] Plx8000_NT: Received PLX message ===>
[72620.662081] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72620.662085] Plx8000_NT: Criteria matched device 8619_10B5 [02:01.0]
[72620.662086] Plx8000_NT: ...Completed message
[72620.662090] Plx8000_NT:
[72620.662091] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72620.662093] Plx8000_NT: Close device (Plx8000_NT-0)...
[72620.662095] Plx8000_NT: ...device closed
[72620.662101] Plx8000_NT:
[72620.662103] Plx8000_NT: Received message ==> OPEN_DEVICE
[72620.662104] Plx8000_NT: Open device (Plx8000_NT-0)...
[72620.662106] Plx8000_NT: ...device opened
[72620.662108] Plx8000_NT:
[72620.662109] Plx8000_NT: Received PLX message ===>
[72620.662111] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72620.662112] Plx8000_NT: ...Completed message
[72620.662118] Plx8000_NT:
[72620.662119] Plx8000_NT: Received PLX message ===>
[72620.662121] Plx8000_NT: PLX_IOCTL_GET_PORT_PROPERTIES
[72620.662164] Plx8000_NT: [D1 02:01.0] P=1 T=0 MPS=512/2048 MRR=128
L=G2x4/G2x8
[72620.662166] Plx8000_NT: ...Completed message
[72620.662168] Plx8000_NT:
[72620.662170] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72620.662171] Plx8000_NT: Close device (Plx8000_NT-0)...
[72620.662173] Plx8000_NT: ...device closed
[72620.662199] Plx8000_NT:
[72620.662201] Plx8000_NT: Received message ==> OPEN_DEVICE
[72620.662203] Plx8000_NT: Open device (Plx8000_NT-0)...
[72620.662204] Plx8000_NT: ...device opened
[72620.662206] Plx8000_NT:
[72620.662208] Plx8000_NT: Received PLX message ===>
[72620.662209] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72620.662210] Plx8000_NT: ...Completed message
[72620.662212] Plx8000_NT:
[72620.662214] Plx8000_NT: Received PLX message ===>
[72620.662215] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72620.662216] Plx8000_NT: Criteria did not match any devices
[72620.662218] Plx8000_NT: ...Completed message
[72620.662220] Plx8000_NT:
[72620.662222] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72620.662223] Plx8000_NT: Close device (Plx8000_NT-0)...
[72620.662225] Plx8000_NT: ...device closed
[72620.662232] Plx8000_DMA:
[72620.662329] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72620.662514] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72620.662563] Plx8000_DMA: ...device opened
[72620.662600] Plx8000_DMA:
[72620.662626] Plx8000_DMA: Received PLX message ===>
[72620.662674] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72620.662901] Plx8000_DMA: ...Completed message
[72620.662959] PLX DMA[Dispatch_IoControl-1053]
[72620.663009] PLX DMA[Dispatch_IoControl-1061]
[72620.663057] Plx8000_DMA:
[72620.663081] Plx8000_DMA: Received PLX message ===>
[72620.663130] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72620.663193] Plx8000_DMA: Criteria matched device 8619_10B5 [01:00.1]
[72620.663255] Plx8000_DMA: ...Completed message
[72620.663303] PLX DMA[Dispatch_IoControl-1053]
[72620.663351] PLX DMA[Dispatch_IoControl-1061]
[72620.663400] Plx8000_DMA:
[72620.663425] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72620.663474] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72620.663522] Plx8000_DMA: ...device closed
[72620.663561] Plx8000_DMA:
[72620.663588] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72620.663635] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72620.663684] Plx8000_DMA: ...device opened
[72620.663721] Plx8000_DMA:
[72620.663746] Plx8000_DMA: Received PLX message ===>
[72620.663794] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72620.663853] Plx8000_DMA: ...Completed message
[72620.663900] PLX DMA[Dispatch_IoControl-1053]
[72620.663949] PLX DMA[Dispatch_IoControl-1061]
[72620.663997] Plx8000_DMA:
[72620.664024] Plx8000_DMA: Received PLX message ===>
[72620.664071] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
[72620.664162] Plx8000_DMA: [D1 01:00.1] P=0 T=0 MPS=512/2048 MRR=512
L=G2x8/G2x                                          8
[72620.664233] Plx8000_DMA: ...Completed message
[72620.664280] PLX DMA[Dispatch_IoControl-1053]
[72620.664330] PLX DMA[Dispatch_IoControl-1061]
[72620.664381] Plx8000_DMA:
[72620.664406] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72620.664454] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72620.664501] Plx8000_DMA: ...device closed
[72620.664565] Plx8000_NT:
[72620.664567] Plx8000_NT: Received message ==> OPEN_DEVICE
[72620.664568] Plx8000_NT: Open device (Plx8000_NT-0)...
[72620.664570] Plx8000_NT: ...device opened
[72620.664572] Plx8000_NT:
[72620.664573] Plx8000_NT: Received PLX message ===>
[72620.664574] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72620.664576] Plx8000_NT: ...Completed message
[72620.664578] Plx8000_NT:
[72620.664579] Plx8000_NT: Received PLX message ===>
[72620.664580] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72620.664582] Plx8000_NT: Criteria did not match any devices
[72620.664583] Plx8000_NT: ...Completed message
[72620.664586] Plx8000_NT:
[72620.664587] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72620.664589] Plx8000_NT: Close device (Plx8000_NT-0)...
[72620.664590] Plx8000_NT: ...device closed
[72620.664595] Plx8000_DMA:
[72620.664620] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72620.664669] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72620.664716] Plx8000_DMA: ...device opened
[72620.664754] Plx8000_DMA:
[72620.664779] Plx8000_DMA: Received PLX message ===>
[72620.664828] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72620.664886] Plx8000_DMA: ...Completed message
[72620.664934] PLX DMA[Dispatch_IoControl-1053]
[72620.664983] PLX DMA[Dispatch_IoControl-1061]
[72620.665031] Plx8000_DMA:
[72620.665056] Plx8000_DMA: Received PLX message ===>
[72620.665102] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72620.665164] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.1]
[72620.665223] Plx8000_DMA: ...Completed message
[72620.665272] PLX DMA[Dispatch_IoControl-1053]
[72620.665318] PLX DMA[Dispatch_IoControl-1061]
[72620.665368] Plx8000_DMA:
[72620.665393] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72620.665440] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72620.665489] Plx8000_DMA: ...device closed
[72620.665531] Plx8000_DMA:
[72620.665557] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72620.665605] Plx8000_DMA: Open device (Plx8000_DMA-1)...
[72620.665653] Plx8000_DMA: ...device opened
[72620.665689] Plx8000_DMA:
[72620.665715] Plx8000_DMA: Received PLX message ===>
[72620.665763] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72620.665834] Plx8000_DMA: ...Completed message
[72620.665886] PLX DMA[Dispatch_IoControl-1053]
[72620.665939] PLX DMA[Dispatch_IoControl-1061]
[72620.666105] Plx8000_DMA:
[72620.666140] Plx8000_DMA: Received PLX message ===>
[72620.666187] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
[72620.666301] Plx8000_DMA: [D3 01:00.1] P=0 T=0 MPS=128/2048 MRR=512
L=G3x8/G3x                                          8
[72620.666372] Plx8000_DMA: ...Completed message
[72620.666420] PLX DMA[Dispatch_IoControl-1053]
[72620.666469] PLX DMA[Dispatch_IoControl-1061]
[72620.667012] Plx8000_DMA:
[72620.667046] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72620.667097] Plx8000_DMA: Close device (Plx8000_DMA-1)...
[72620.667145] Plx8000_DMA: ...device closed
[72620.674539] Plx8000_NT:
[72620.674542] Plx8000_NT: Received message ==> OPEN_DEVICE
[72620.674544] Plx8000_NT: Open device (Plx8000_NT-0)...
[72620.674545] Plx8000_NT: ...device opened
[72620.674548] Plx8000_NT:
[72620.674550] Plx8000_NT: Received PLX message ===>
[72620.674551] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72620.674552] Plx8000_NT: ...Completed message
[72620.674555] Plx8000_NT:
[72620.674556] Plx8000_NT: Received PLX message ===>
[72620.674557] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72620.674559] Plx8000_NT: Criteria did not match any devices
[72620.674560] Plx8000_NT: ...Completed message
[72620.674563] Plx8000_NT:
[72620.674564] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72620.674566] Plx8000_NT: Close device (Plx8000_NT-0)...
[72620.674567] Plx8000_NT: ...device closed
[72620.674573] Plx8000_DMA:
[72620.688083] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72620.721345] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72620.721407] Plx8000_DMA: ...device opened
[72620.749338] Plx8000_DMA:
[72620.784093] Plx8000_DMA: Received PLX message ===>
[72620.814563] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72620.814627] Plx8000_DMA: ...Completed message
[72620.850722] PLX DMA[Dispatch_IoControl-1053]
[72620.877291] PLX DMA[Dispatch_IoControl-1061]
[72620.897461] Plx8000_DMA:
[72620.897492] Plx8000_DMA: Received PLX message ===>
[72620.910914] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72620.925179] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.2]
[72620.938493] Plx8000_DMA: ...Completed message
[72620.951754] PLX DMA[Dispatch_IoControl-1053]
[72620.951805] PLX DMA[Dispatch_IoControl-1061]
[72620.975647] Plx8000_DMA:
[72620.989780] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72621.003227] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72621.023490] Plx8000_DMA: ...device closed
[72621.023542] Plx8000_DMA:
[72621.036780] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72621.050892] Plx8000_DMA: Open device (Plx8000_DMA-2)...
[72621.071011] Plx8000_DMA: ...device opened
[72621.071052] Plx8000_DMA:
[72621.085311] Plx8000_DMA: Received PLX message ===>
[72621.101914] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72621.122340] Plx8000_DMA: ...Completed message
[72621.122389] PLX DMA[Dispatch_IoControl-1053]
[72621.136920] PLX DMA[Dispatch_IoControl-1061]
[72621.156000] Plx8000_DMA:
[72621.156026] Plx8000_DMA: Received PLX message ===>
[72621.170272] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
[72621.187182] Plx8000_DMA: [D3 01:00.2] P=0 T=0 MPS=128/2048 MRR=512
L=G3x8/G3x                                          8
[72621.203441] Plx8000_DMA: ...Completed message
[72621.243534] PLX DMA[Dispatch_IoControl-1053]
[72621.263526] PLX DMA[Dispatch_IoControl-1061]
[72621.263585] Plx8000_DMA:
[72621.295098] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72621.329212] Plx8000_DMA: Close device (Plx8000_DMA-2)...
[72621.365777] Plx8000_DMA: ...device closed
[72621.390445] Plx8000_NT:
[72621.390447] Plx8000_NT: Received message ==> OPEN_DEVICE
[72621.390449] Plx8000_NT: Open device (Plx8000_NT-0)...
[72621.390450] Plx8000_NT: ...device opened
[72621.390452] Plx8000_NT:
[72621.390454] Plx8000_NT: Received PLX message ===>
[72621.390455] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72621.390456] Plx8000_NT: ...Completed message
[72621.390459] Plx8000_NT:
[72621.390460] Plx8000_NT: Received PLX message ===>
[72621.390461] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72621.390463] Plx8000_NT: Criteria did not match any devices
[72621.390464] Plx8000_NT: ...Completed message
[72621.390467] Plx8000_NT:
[72621.390468] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72621.390469] Plx8000_NT: Close device (Plx8000_NT-0)...
[72621.390471] Plx8000_NT: ...device closed
[72621.390476] Plx8000_DMA:
[72621.390501] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72621.404723] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72621.418244] Plx8000_DMA: ...device opened
[72621.418286] Plx8000_DMA:
[72621.440859] Plx8000_DMA: Received PLX message ===>
[72621.454357] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72621.468819] Plx8000_DMA: ...Completed message
[72621.468866] PLX DMA[Dispatch_IoControl-1053]
[72621.491825] PLX DMA[Dispatch_IoControl-1061]
[72621.516713] Plx8000_DMA:
[72621.516737] Plx8000_DMA: Received PLX message ===>
[72621.537072] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72621.551432] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.3]
[72621.566411] Plx8000_DMA: ...Completed message
[72621.580141] PLX DMA[Dispatch_IoControl-1053]
[72621.594692] PLX DMA[Dispatch_IoControl-1061]
[72621.594740] Plx8000_DMA:
[72621.617798] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72621.648656] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72621.662346] Plx8000_DMA: ...device closed
[72621.662401] Plx8000_DMA:
[72621.682871] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72621.696230] Plx8000_DMA: Open device (Plx8000_DMA-3)...
[72621.710158] Plx8000_DMA: ...device opened
[72621.729888] Plx8000_DMA:
[72621.729914] Plx8000_DMA: Received PLX message ===>
[72621.746422] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72621.764337] Plx8000_DMA: ...Completed message
[72621.764386] PLX DMA[Dispatch_IoControl-1053]
[72621.783654] PLX DMA[Dispatch_IoControl-1061]
[72621.797773] Plx8000_DMA:
[72621.797800] Plx8000_DMA: Received PLX message ===>
[72621.816946] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
[72621.831298] Plx8000_DMA: [D3 01:00.3] P=0 T=0 MPS=128/2048 MRR=512
L=G3x8/G3x                                          8
[72621.838937] Plx8000_DMA: ...Completed message
[72621.859531] PLX DMA[Dispatch_IoControl-1053]
[72621.876356] PLX DMA[Dispatch_IoControl-1061]
[72621.904158] Plx8000_DMA:
[72621.904195] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72621.925981] Plx8000_DMA: Close device (Plx8000_DMA-3)...
[72621.944936] Plx8000_DMA: ...device closed
[72621.989960] Plx8000_NT:
[72621.989964] Plx8000_NT: Received message ==> OPEN_DEVICE
[72621.989966] Plx8000_NT: Open device (Plx8000_NT-0)...
[72621.989968] Plx8000_NT: ...device opened
[72621.989972] Plx8000_NT:
[72621.989973] Plx8000_NT: Received PLX message ===>
[72621.989975] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72621.989976] Plx8000_NT: ...Completed message
[72621.989979] Plx8000_NT:
[72621.989980] Plx8000_NT: Received PLX message ===>
[72621.989982] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72621.989984] Plx8000_NT: Criteria did not match any devices
[72621.989985] Plx8000_NT: ...Completed message
[72621.989988] Plx8000_NT:
[72621.989989] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72621.989991] Plx8000_NT: Close device (Plx8000_NT-0)...
[72621.989993] Plx8000_NT: ...device closed
[72621.989999] Plx8000_DMA:
[72621.990030] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72622.014908] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72622.036527] Plx8000_DMA: ...device opened
[72622.071746] Plx8000_DMA:
[72622.071776] Plx8000_DMA: Received PLX message ===>
[72622.097789] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72622.121519] Plx8000_DMA: ...Completed message
[72622.149769] PLX DMA[Dispatch_IoControl-1053]
[72622.149819] PLX DMA[Dispatch_IoControl-1061]
[72622.185960] Plx8000_DMA:
[72622.204154] Plx8000_DMA: Received PLX message ===>
[72622.204203] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72622.253643] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.4]
[72622.277435] Plx8000_DMA: ...Completed message
[72622.318961] PLX DMA[Dispatch_IoControl-1053]
[72622.334719] PLX DMA[Dispatch_IoControl-1061]
[72622.354444] Plx8000_DMA:
[72622.354472] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72622.370664] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72622.384686] Plx8000_DMA: ...device closed
[72622.405990] Plx8000_DMA:
[72622.406017] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72622.419743] Plx8000_DMA: Open device (Plx8000_DMA-4)...
[72622.439662] Plx8000_DMA: ...device opened
[72622.460550] Plx8000_DMA:
[72622.460577] Plx8000_DMA: Received PLX message ===>
[72622.474601] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72622.488847] Plx8000_DMA: ...Completed message
[72622.502673] PLX DMA[Dispatch_IoControl-1053]
[72622.502723] PLX DMA[Dispatch_IoControl-1061]
[72622.523509] Plx8000_DMA:
[72622.523535] Plx8000_DMA: Received PLX message ===>
[72622.537498] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
[72622.551921] Plx8000_DMA: [D3 01:00.4] P=0 T=0 MPS=128/2048 MRR=512
L=G3x8/G3x                                          8
[72622.584958] Plx8000_DMA: ...Completed message
[72622.585008] PLX DMA[Dispatch_IoControl-1053]
[72622.606013] PLX DMA[Dispatch_IoControl-1061]
[72622.620766] Plx8000_DMA:
[72622.620792] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72622.641251] Plx8000_DMA: Close device (Plx8000_DMA-4)...
[72622.656250] Plx8000_DMA: ...device closed
[72622.670281] Plx8000_NT:
[72622.670283] Plx8000_NT: Received message ==> OPEN_DEVICE
[72622.670284] Plx8000_NT: Open device (Plx8000_NT-0)...
[72622.670286] Plx8000_NT: ...device opened
[72622.670288] Plx8000_NT:
[72622.670289] Plx8000_NT: Received PLX message ===>
[72622.670290] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72622.670292] Plx8000_NT: ...Completed message
[72622.670294] Plx8000_NT:
[72622.670295] Plx8000_NT: Received PLX message ===>
[72622.670296] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72622.670298] Plx8000_NT: Criteria did not match any devices
[72622.670299] Plx8000_NT: ...Completed message
[72622.670301] Plx8000_NT:
[72622.670303] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72622.670304] Plx8000_NT: Close device (Plx8000_NT-0)...
[72622.670306] Plx8000_NT: ...device closed
[72622.670311] Plx8000_DMA:
[72622.670335] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72622.684743] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72622.711632] Plx8000_DMA: ...device opened
[72622.726153] Plx8000_DMA:
[72622.726179] Plx8000_DMA: Received PLX message ===>
[72622.747092] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72622.761392] Plx8000_DMA: ...Completed message
[72622.776033] PLX DMA[Dispatch_IoControl-1053]
[72622.790132] PLX DMA[Dispatch_IoControl-1061]
[72622.790180] Plx8000_DMA:
[72622.810504] Plx8000_DMA: Received PLX message ===>
[72622.828202] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72622.841923] Plx8000_DMA: Criteria did not match any devices
[72622.857254] Plx8000_DMA: ...Completed message
[72622.857303] PLX DMA[Dispatch_IoControl-1053]
[72622.878595] PLX DMA[Dispatch_IoControl-1061]
[72622.909283] Plx8000_DMA:
[72622.909311] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72622.923149] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72622.943455] Plx8000_DMA: ...device closed
[72627.408076] Plx8000_NT:
[72627.408079] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.408081] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.408083] Plx8000_NT: ...device opened
[72627.408086] Plx8000_NT:
[72627.408087] Plx8000_NT: Received PLX message ===>
[72627.408088] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.408090] Plx8000_NT: ...Completed message
[72627.408451] Plx8000_NT:
[72627.408453] Plx8000_NT: Received PLX message ===>
[72627.408454] Plx8000_NT: PLX_IOCTL_PCI_BAR_PROPERTIES
[72627.408456] Plx8000_NT:     PCI BAR 2: 80000000
[72627.408458] Plx8000_NT:     Phys Addr: 3FE080000000
[72627.408460] Plx8000_NT:     Size     : 400000h (4MB)
[72627.408462] Plx8000_NT:     Property : Non-Prefetchable 32-bit
[72627.408464] Plx8000_NT: ...Completed message
[72627.408718] Plx8000_NT:
[72627.408720] Plx8000_NT: Received PLX message ===>
[72627.408721] Plx8000_NT: PLX_IOCTL_PCI_BAR_PROPERTIES
[72627.408723] Plx8000_NT:     PCI BAR 2: 80000000
[72627.408725] Plx8000_NT:     Phys Addr: 3FE080000000
[72627.408727] Plx8000_NT:     Size     : 400000h (4MB)
[72627.408728] Plx8000_NT:     Property : Non-Prefetchable 32-bit
[72627.408730] Plx8000_NT: ...Completed message
[72627.408976] Plx8000_NT:
[72627.408978] Plx8000_NT: Received message ===> MMAP
[72627.408979] Plx8000_NT: Map PCI BAR 2...
[72627.408983] Plx8000_NT: Mapped Phys (3fe080000000) ==> User VA
(3fff784e0000)
[72627.408984] Plx8000_NT: ...Completed message
[72627.409302] Plx8000_NT:
[72627.409321] Plx8000_NT: Received PLX message ===>
[72627.409322] Plx8000_NT: PLX_IOCTL_NT_LUT_ADD
[72627.409331] Plx8000_NT: Req ID (0000) already exists in LUT #0, skipping
upda                                          te
[72627.409333] Plx8000_NT: ...Completed message
[72627.409547] Plx8000_NT:
[72627.409548] Plx8000_NT: Received PLX message ===>
[72627.409550] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
[72627.409552] Plx8000_NT: Attempt to allocate physical memory (1953KB)
[72627.409980] Plx8000_NT: Allocated physical memory...
[72627.409982] Plx8000_NT:     CPU Phys Addr: 1f9e400000
[72627.409984] Plx8000_NT:     Bus Phys Addr: 60600000
[72627.409985] Plx8000_NT:     Kernel VA    : c000001f9e400000
[72627.409987] Plx8000_NT:     Size         : 1E8480h (1MB)
[72627.409989] Plx8000_NT: ...Completed message
[72627.410061] Plx8000_NT:
[72627.410062] Plx8000_NT: Received message ===> MMAP
[72627.410065] Plx8000_NT: Mapped Phys (1f9e400000) ==> User VA
(3fff782f0000)
[72627.410066] Plx8000_NT: ...Completed message
[72627.410123] Plx8000_NT:
[72627.410124] Plx8000_NT: Received PLX message ===>
[72627.410126] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
[72627.410128] Plx8000_NT: Attempt to allocate physical memory (1953KB)
[72627.410515] Plx8000_NT: Allocated physical memory...
[72627.410517] Plx8000_NT:     CPU Phys Addr: 1f82c00000
[72627.410519] Plx8000_NT:     Bus Phys Addr: 60800000
[72627.410520] Plx8000_NT:     Kernel VA    : c000001f82c00000
[72627.410522] Plx8000_NT:     Size         : 1E8480h (1MB)
[72627.410524] Plx8000_NT: ...Completed message
[72627.410595] Plx8000_NT:
[72627.410596] Plx8000_NT: Received message ===> MMAP
[72627.410599] Plx8000_NT: Mapped Phys (1f82c00000) ==> User VA
(3fff78100000)
[72627.410600] Plx8000_NT: ...Completed message
[72627.410710] Plx8000_NT:
[72627.410711] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.410713] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.410714] Plx8000_NT: ...device opened
[72627.410717] Plx8000_NT:
[72627.410718] Plx8000_NT: Received PLX message ===>
[72627.410720] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.410721] Plx8000_NT: ...Completed message
[72627.410723] Plx8000_NT:
[72627.410725] Plx8000_NT: Received PLX message ===>
[72627.410726] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72627.410729] Plx8000_NT: Criteria matched device 8619_10B5 [02:01.0]
[72627.410730] Plx8000_NT: ...Completed message
[72627.410733] Plx8000_NT:
[72627.410734] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72627.410750] Plx8000_NT: Close device (Plx8000_NT-0)...
[72627.410752] Plx8000_NT: ...device closed
[72627.410758] Plx8000_NT:
[72627.410760] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.410761] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.410763] Plx8000_NT: ...device opened
[72627.410765] Plx8000_NT:
[72627.410766] Plx8000_NT: Received PLX message ===>
[72627.410767] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.410769] Plx8000_NT: ...Completed message
[72627.410771] Plx8000_NT:
[72627.410772] Plx8000_NT: Received PLX message ===>
[72627.410773] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72627.410775] Plx8000_NT: Criteria did not match any devices
[72627.410776] Plx8000_NT: ...Completed message
[72627.410779] Plx8000_NT:
[72627.410780] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72627.410782] Plx8000_NT: Close device (Plx8000_NT-0)...
[72627.410783] Plx8000_NT: ...device closed
[72627.410789] Plx8000_DMA:
[72627.410872] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.411088] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72627.411139] Plx8000_DMA: ...device opened
[72627.411175] Plx8000_DMA:
[72627.411197] Plx8000_DMA: Received PLX message ===>
[72627.411244] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.411470] Plx8000_DMA: ...Completed message
[72627.411519] PLX DMA[Dispatch_IoControl-1053]
[72627.411565] PLX DMA[Dispatch_IoControl-1061]
[72627.411613] Plx8000_DMA:
[72627.411639] Plx8000_DMA: Received PLX message ===>
[72627.411686] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72627.411747] Plx8000_DMA: Criteria matched device 8619_10B5 [01:00.1]
[72627.411808] Plx8000_DMA: ...Completed message
[72627.411855] PLX DMA[Dispatch_IoControl-1053]
[72627.411904] PLX DMA[Dispatch_IoControl-1061]
[72627.411953] Plx8000_DMA:
[72627.411978] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.412025] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72627.412074] Plx8000_DMA: ...device closed
[72627.412115] Plx8000_DMA:
[72627.412141] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.412187] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72627.412235] Plx8000_DMA: ...device opened
[72627.412274] Plx8000_DMA:
[72627.412299] Plx8000_DMA: Received PLX message ===>
[72627.412348] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.412408] Plx8000_DMA: ...Completed message
[72627.412457] PLX DMA[Dispatch_IoControl-1053]
[72627.412504] PLX DMA[Dispatch_IoControl-1061]
[72627.412555] Plx8000_DMA:
[72627.412580] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.412628] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72627.412676] Plx8000_DMA: ...device closed
[72627.412827] Plx8000_NT:
[72627.412829] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.412830] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.412832] Plx8000_NT: ...device opened
[72627.412834] Plx8000_NT:
[72627.412836] Plx8000_NT: Received PLX message ===>
[72627.412837] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.412838] Plx8000_NT: ...Completed message
[72627.412840] Plx8000_NT:
[72627.412842] Plx8000_NT: Received PLX message ===>
[72627.412843] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72627.412844] Plx8000_NT: Criteria did not match any devices
[72627.412846] Plx8000_NT: ...Completed message
[72627.412848] Plx8000_NT:
[72627.412850] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72627.412851] Plx8000_NT: Close device (Plx8000_NT-0)...
[72627.412853] Plx8000_NT: ...device closed
[72627.412858] Plx8000_DMA:
[72627.412885] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.412933] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72627.412981] Plx8000_DMA: ...device opened
[72627.413036] Plx8000_DMA:
[72627.413063] Plx8000_DMA: Received PLX message ===>
[72627.413110] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.413169] Plx8000_DMA: ...Completed message
[72627.413216] PLX DMA[Dispatch_IoControl-1053]
[72627.413265] PLX DMA[Dispatch_IoControl-1061]
[72627.413313] Plx8000_DMA:
[72627.413339] Plx8000_DMA: Received PLX message ===>
[72627.413389] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72627.413449] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.1]
[72627.413507] Plx8000_DMA: ...Completed message
[72627.413557] PLX DMA[Dispatch_IoControl-1053]
[72627.413606] PLX DMA[Dispatch_IoControl-1061]
[72627.413656] Plx8000_DMA:
[72627.413682] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.413731] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72627.413779] Plx8000_DMA: ...device closed
[72627.413820] Plx8000_DMA:
[72627.413847] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.413896] Plx8000_DMA: Open device (Plx8000_DMA-1)...
[72627.413943] Plx8000_DMA: ...device opened
[72627.413980] Plx8000_DMA:
[72627.414006] Plx8000_DMA: Received PLX message ===>
[72627.414056] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.414115] Plx8000_DMA: ...Completed message
[72627.414162] PLX DMA[Dispatch_IoControl-1053]
[72627.414209] PLX DMA[Dispatch_IoControl-1061]
[72627.414260] Plx8000_DMA:
[72627.414285] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.414333] Plx8000_DMA: Close device (Plx8000_DMA-1)...
[72627.414382] Plx8000_DMA: ...device closed
[72627.414531] Plx8000_NT:
[72627.414532] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.414534] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.414535] Plx8000_NT: ...device opened
[72627.414538] Plx8000_NT:
[72627.414539] Plx8000_NT: Received PLX message ===>
[72627.414541] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.414542] Plx8000_NT: ...Completed message
[72627.414544] Plx8000_NT:
[72627.414545] Plx8000_NT: Received PLX message ===>
[72627.414547] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72627.414548] Plx8000_NT: Criteria did not match any devices
[72627.414549] Plx8000_NT: ...Completed message
[72627.414552] Plx8000_NT:
[72627.414553] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72627.414555] Plx8000_NT: Close device (Plx8000_NT-0)...
[72627.414556] Plx8000_NT: ...device closed
[72627.414562] Plx8000_DMA:
[72627.414591] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.414638] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72627.414686] Plx8000_DMA: ...device opened
[72627.414743] Plx8000_DMA:
[72627.414770] Plx8000_DMA: Received PLX message ===>
[72627.414817] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.414876] Plx8000_DMA: ...Completed message
[72627.414922] PLX DMA[Dispatch_IoControl-1053]
[72627.414971] PLX DMA[Dispatch_IoControl-1061]
[72627.415020] Plx8000_DMA:
[72627.415045] Plx8000_DMA: Received PLX message ===>
[72627.415092] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72627.415153] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.2]
[72627.415210] Plx8000_DMA: ...Completed message
[72627.415260] PLX DMA[Dispatch_IoControl-1053]
[72627.425396] PLX DMA[Dispatch_IoControl-1061]
[72627.443065] Plx8000_DMA:
[72627.443140] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.459743] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72627.480544] Plx8000_DMA: ...device closed
[72627.494674] Plx8000_DMA:
[72627.494701] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.514411] Plx8000_DMA: Open device (Plx8000_DMA-2)...
[72627.528663] Plx8000_DMA: ...device opened
[72627.548088] Plx8000_DMA:
[72627.548114] Plx8000_DMA: Received PLX message ===>
[72627.562186] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.579330] Plx8000_DMA: ...Completed message
[72627.593548] PLX DMA[Dispatch_IoControl-1053]
[72627.593597] PLX DMA[Dispatch_IoControl-1061]
[72627.607342] Plx8000_DMA:
[72627.628356] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.643389] Plx8000_DMA: Close device (Plx8000_DMA-2)...
[72627.657247] Plx8000_DMA: ...device closed
[72627.657324] Plx8000_NT:
[72627.657326] Plx8000_NT: Received message ==> OPEN_DEVICE
[72627.657328] Plx8000_NT: Open device (Plx8000_NT-0)...
[72627.657330] Plx8000_NT: ...device opened
[72627.657333] Plx8000_NT:
[72627.657335] Plx8000_NT: Received PLX message ===>
[72627.657336] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72627.657338] Plx8000_NT: ...Completed message
[72627.657340] Plx8000_NT:
[72627.657342] Plx8000_NT: Received PLX message ===>
[72627.657343] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72627.657345] Plx8000_NT: Criteria did not match any devices
[72627.657346] Plx8000_NT: ...Completed message
[72627.657349] Plx8000_NT:
[72627.657350] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72627.657352] Plx8000_NT: Close device (Plx8000_NT-0)...
[72627.657354] Plx8000_NT: ...device closed
[72627.657360] Plx8000_DMA:
[72627.678335] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.691888] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72627.692097] Plx8000_DMA: ...device opened
[72627.709734] Plx8000_DMA:
[72627.729733] Plx8000_DMA: Received PLX message ===>
[72627.729781] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72627.743681] Plx8000_DMA: ...Completed message
[72627.757186] PLX DMA[Dispatch_IoControl-1053]
[72627.777240] PLX DMA[Dispatch_IoControl-1061]
[72627.790949] Plx8000_DMA:
[72627.790974] Plx8000_DMA: Received PLX message ===>
[72627.811068] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72627.825371] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.3]
[72627.842688] Plx8000_DMA: ...Completed message
[72627.863570] PLX DMA[Dispatch_IoControl-1053]
[72627.877589] PLX DMA[Dispatch_IoControl-1061]
[72627.877654] Plx8000_DMA:
[72627.891372] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72627.891421] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72627.911378] Plx8000_DMA: ...device closed
[72627.925443] Plx8000_DMA:
[72627.938921] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72627.952821] Plx8000_DMA: Open device (Plx8000_DMA-3)...
[72627.975843] Plx8000_DMA: ...device opened
[72627.975882] Plx8000_DMA:
[72627.989561] Plx8000_DMA: Received PLX message ===>
[72628.009828] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72628.009889] Plx8000_DMA: ...Completed message
[72628.017190] PLX DMA[Dispatch_IoControl-1053]
[72628.037556] PLX DMA[Dispatch_IoControl-1061]
[72628.051055] Plx8000_DMA:
[72628.051087] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72628.071215] Plx8000_DMA: Close device (Plx8000_DMA-3)...
[72628.098488] Plx8000_DMA: ...device closed
[72628.121423] Plx8000_NT:
[72628.121426] Plx8000_NT: Received message ==> OPEN_DEVICE
[72628.121428] Plx8000_NT: Open device (Plx8000_NT-0)...
[72628.121430] Plx8000_NT: ...device opened
[72628.121433] Plx8000_NT:
[72628.121434] Plx8000_NT: Received PLX message ===>
[72628.121436] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72628.121437] Plx8000_NT: ...Completed message
[72628.121440] Plx8000_NT:
[72628.121441] Plx8000_NT: Received PLX message ===>
[72628.121442] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72628.121444] Plx8000_NT: Criteria did not match any devices
[72628.121446] Plx8000_NT: ...Completed message
[72628.121448] Plx8000_NT:
[72628.121450] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72628.121451] Plx8000_NT: Close device (Plx8000_NT-0)...
[72628.121453] Plx8000_NT: ...device closed
[72628.121459] Plx8000_DMA:
[72628.121488] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72628.164427] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72628.186055] Plx8000_DMA: ...device opened
[72628.204907] Plx8000_DMA:
[72628.204933] Plx8000_DMA: Received PLX message ===>
[72628.252421] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72628.333628] Plx8000_DMA: ...Completed message
[72628.363179] PLX DMA[Dispatch_IoControl-1053]
[72628.363229] PLX DMA[Dispatch_IoControl-1061]
[72628.382823] Plx8000_DMA:
[72628.382849] Plx8000_DMA: Received PLX message ===>
[72628.411911] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72628.443037] Plx8000_DMA: Criteria matched device 87D0_10B5 [01:00.4]
[72628.456385] Plx8000_DMA: ...Completed message
[72628.479320] PLX DMA[Dispatch_IoControl-1053]
[72628.493960] PLX DMA[Dispatch_IoControl-1061]
[72628.511248] Plx8000_DMA:
[72628.511276] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72628.530758] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72628.544767] Plx8000_DMA: ...device closed
[72628.573961] Plx8000_DMA:
[72628.573985] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72628.593642] Plx8000_DMA: Open device (Plx8000_DMA-4)...
[72628.606800] Plx8000_DMA: ...device opened
[72628.626478] Plx8000_DMA:
[72628.626504] Plx8000_DMA: Received PLX message ===>
[72628.643708] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72628.657250] Plx8000_DMA: ...Completed message
[72628.670464] PLX DMA[Dispatch_IoControl-1053]
[72628.670512] PLX DMA[Dispatch_IoControl-1061]
[72628.684991] Plx8000_DMA:
[72628.704238] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72628.718952] Plx8000_DMA: Close device (Plx8000_DMA-4)...
[72628.718999] Plx8000_DMA: ...device closed
[72628.732600] Plx8000_NT:
[72628.732602] Plx8000_NT: Received message ==> OPEN_DEVICE
[72628.732604] Plx8000_NT: Open device (Plx8000_NT-0)...
[72628.732606] Plx8000_NT: ...device opened
[72628.732608] Plx8000_NT:
[72628.732610] Plx8000_NT: Received PLX message ===>
[72628.732611] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
[72628.732612] Plx8000_NT: ...Completed message
[72628.732614] Plx8000_NT:
[72628.732616] Plx8000_NT: Received PLX message ===>
[72628.732617] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
[72628.732619] Plx8000_NT: Criteria did not match any devices
[72628.732620] Plx8000_NT: ...Completed message
[72628.732623] Plx8000_NT:
[72628.732624] Plx8000_NT: Received message ==> CLOSE_DEVICE
[72628.732625] Plx8000_NT: Close device (Plx8000_NT-0)...
[72628.732627] Plx8000_NT: ...device closed
[72628.732633] Plx8000_DMA:
[72628.753385] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72628.767529] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72628.784787] Plx8000_DMA: ...device opened
[72628.784828] Plx8000_DMA:
[72628.805494] Plx8000_DMA: Received PLX message ===>
[72628.805543] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72628.819629] Plx8000_DMA: ...Completed message
[72628.834282] PLX DMA[Dispatch_IoControl-1053]
[72628.853921] PLX DMA[Dispatch_IoControl-1061]
[72628.868788] Plx8000_DMA:
[72628.868816] Plx8000_DMA: Received PLX message ===>
[72628.888760] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
[72628.903254] Plx8000_DMA: Criteria did not match any devices
[72628.920438] Plx8000_DMA: ...Completed message
[72628.941554] PLX DMA[Dispatch_IoControl-1053]
[72628.941601] PLX DMA[Dispatch_IoControl-1061]
[72628.956697] Plx8000_DMA:
[72628.956725] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72628.970183] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72628.991254] Plx8000_DMA: ...device closed
[72630.231810] Plx8000_DMA:
[72630.231839] Plx8000_DMA: Received message ==> OPEN_DEVICE
[72630.231889] Plx8000_DMA: Open device (Plx8000_DMA-0)...
[72630.231938] Plx8000_DMA: ...device opened
[72630.231976] Plx8000_DMA:
[72630.232001] Plx8000_DMA: Received PLX message ===>
[72630.232048] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
[72630.232119] Plx8000_DMA: ...Completed message
[72630.232168] PLX DMA[Dispatch_IoControl-1053]
[72630.232219] PLX DMA[Dispatch_IoControl-1061]
[72630.232380] Plx8000_NT:
[72630.232382] Plx8000_NT: Received PLX message ===>
[72630.232383] Plx8000_NT: PLX_IOCTL_NT_LUT_ADD
[72630.232392] Plx8000_NT: Req ID (0101) already exists in LUT #1, skipping
upda                                          te
[72630.232393] Plx8000_NT: ...Completed message
[72634.737738] Plx8000_DMA:
[72634.737844] Plx8000_DMA: Received PLX message ===>
[72634.738020] Plx8000_DMA: PLX_IOCTL_DMA_CHANNEL_OPEN
[72634.738084] Plx8000_DMA: Opened DMA channel 0
[72634.738132] Plx8000_DMA: ...Completed message
[72634.738179] PLX DMA[Dispatch_IoControl-1053]
[72634.738394] PLX DMA[Dispatch_IoControl-1061]
[72634.738547] Plx8000_DMA:
[72634.738574] Plx8000_DMA: Received PLX message ===>
[72634.738621] Plx8000_DMA: PLX_IOCTL_DMA_GET_PROPERTIES
[72634.738682] Plx8000_DMA: ...Completed message
[72634.738731] PLX DMA[Dispatch_IoControl-1053]
[72634.738778] PLX DMA[Dispatch_IoControl-1061]
[72634.738904] Plx8000_DMA:
[72634.738931] Plx8000_DMA: Received PLX message ===>
[72634.738978] Plx8000_DMA: PLX_IOCTL_DMA_SET_PROPERTIES
[72634.739044] Plx8000_DMA: ...Completed message
[72634.739092] PLX DMA[Dispatch_IoControl-1053]
[72634.739158] PLX DMA[Dispatch_IoControl-1061]
[72634.739270] Plx8000_DMA:
[72634.739298] Plx8000_DMA: Received PLX message ===>
[72634.739348] Plx8000_DMA: PLX_IOCTL_NOTIFICATION_REGISTER_FOR
[72634.739421] Plx8000_DMA: Registered interrupt wait object
(c000003c84638880)
[72634.739511] Plx8000_DMA: ...Completed message
[72634.739561] PLX DMA[Dispatch_IoControl-1053]
[72634.739611] PLX DMA[Dispatch_IoControl-1061]
[72634.739824] Plx8000_DMA:
[72634.739851] Plx8000_DMA: Received PLX message ===>
[72634.739910] Plx8000_DMA: PLX_IOCTL_DMA_TRANSFER_BLOCK
[72634.739984] PLX DMA[PlxDmaTransferBlock-2479]
[72634.740034] PLX DMA[PlxDmaTransferBlock-2488]
[72634.740093] PLX DMA[PlxDmaTransferBlock-2495]
[72634.740143] Plx8000_DMA: Ch 0 - DMA 00000000_60600000 -->
00000000_60800000 (                                          65536 bytes)
[72634.740215] PLX DMA[PlxDmaTransferBlock-2503]
[72634.740262] PLX DMA[PlxDmaTransferBlock-2511]
[72634.740313] PLX DMA[PlxDmaTransferBlock-2516]
[72634.740360] PLX DMA[PlxDmaTransferBlock-2521]
[72634.740408] PLX DMA[PlxDmaTransferBlock-2532]
[72634.740457] PLX DMA[PlxDmaTransferBlock-2535]
[72634.740507] PLX DMA[PlxDmaTransferBlock-2539]
[72634.740555] PLX DMA[PlxDmaTransferBlock-2550]
[72634.740606] PLX DMA[PlxDmaTransferBlock-2557]
[72634.740654] PLX DMA[PlxDmaTransferBlock-2562]
[72634.740702] Plx8000_DMA: Start DMA transfer...
[72634.740747] PLX DMA[PlxDmaTransferBlock-2565]
[72634.740795] PLX DMA[PlxDmaTransferBlock-2569]
[72634.740840] EEH: Frozen PE#1 on PHB#1 detected
[72634.740845] EEH: PE location: Slot4, PHB location: N/A
[72634.741951] EEH: This PCI device has failed 1 times in the last hour
[72634.741952] EEH: Notify device drivers to shutdown
[72634.741960] EEH: Collect temporary log
[72634.742033] EEH: of node=0001:01:00:0
[72634.742036] EEH: PCI device/vendor: 861910b5
[72634.742038] EEH: PCI cmd/status register: 00100547
[72634.742040] EEH: Bridge secondary status: 0000
[72634.742042] EEH: Bridge control: 0002
[72634.742043] EEH: PCI-E capabilities and status follow:
[72634.742052] EEH: PCI-E 00: 0052a410 00008004 00000046 0000cc82
[72634.742060] EEH: PCI-E 10: 00820000 00000000 00000000 00000000
[72634.742060] EEH: PCI-E 20: 00000000
[72634.742061] EEH: PCI-E AER capability register set follows:
[72634.742070] EEH: PCI-E AER 00: 13810001 00000000 00000000 00062030
[72634.742077] EEH: PCI-E AER 10: 00000000 00002000 000000ff 00000000
[72634.742084] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
[72634.742086] EEH: PCI-E AER 30: 00000000 0e0e0e0e
[72634.742087] EEH: of node=0001:01:00:1
[72634.742089] EEH: PCI device/vendor: 861910b5
[72634.742091] EEH: PCI cmd/status register: 10100546
[72634.742092] EEH: PCI-E capabilities and status follow:
[72634.742100] EEH: PCI-E 00: 0002a410 00008fe4 0020204e 0000cc82
[72634.742107] EEH: PCI-E 10: 00820000 00000000 00000000 00000000
[72634.742108] EEH: PCI-E 20: 00000000
[72634.742109] EEH: PCI-E AER capability register set follows:
[72634.742117] EEH: PCI-E AER 00: 1f410001 00000000 00000000 00062030
[72634.742124] EEH: PCI-E AER 10: 00000000 00002000 000001ff 00000000
[72634.742131] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
[72634.742133] EEH: PCI-E AER 30: 00000000 00000000
[72634.742134] EEH: of node=0001:02:01:0
[72634.742136] EEH: PCI device/vendor: 861910b5
[72634.742138] EEH: PCI cmd/status register: 00100546
[72634.742138] EEH: PCI-E capabilities and status follow:
[72634.742147] EEH: PCI-E 00: 0002a410 00008fc4 0000004e 0100cc82
[72634.742154] EEH: PCI-E 10: 00420000 00000000 00000000 00000000
[72634.742155] EEH: PCI-E 20: 00000000
[72634.742155] EEH: PCI-E AER capability register set follows:
[72634.742164] EEH: PCI-E AER 00: 14810001 00000000 00000000 00062030
[72634.742170] EEH: PCI-E AER 10: 00000000 00002000 000001ff 00000000
[72634.742177] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
[72634.742179] EEH: PCI-E AER 30: 00000000 00000000
[72634.742181] PHB3 PHB#1 Diag-data (Version: 1)
[72634.742182] brdgCtl:     00000002
[72634.742183] RootSts:     0002004f 00400000 f0820008 00100147 00002800
[72634.742184] RootErrSts:  00000000 00008000 00000000
[72634.742185] PhbSts:      0000001c00000000 0000001c00000000
[72634.742186] Lem:         0000000004000000 42498e327f502eae
0000000000000000
[72634.742189] InAErr:      0000000000004000 0000000000004000
8000000060600001 8                                          400000000000001
[72634.742190] PE[  1] A/B: 8200302500000000 8000000060600000
[72634.742191] EEH: Enable I/O for affected devices
[72634.742206] EEH: Notify device drivers to resume I/O
[72634.742207] EEH: Enabled DMA for affected devices
[72634.742217] EEH: Notify device driver to resume
[72635.074164] Plx8000_DMA: ...Completed message
[72635.117262] PLX DMA[Dispatch_IoControl-1053]
[72635.130943] PLX DMA[Dispatch_IoControl-1061]
[72635.131023] Plx8000_DMA:
[72635.145274] Plx8000_DMA: Received PLX message ===>
[72635.164247] Plx8000_DMA: PLX_IOCTL_NOTIFICATION_WAIT
[72635.180391] Plx8000_DMA: Waiting for Interrupt wait object
(c000003c84638880)                                           to wake-up
[72638.205655] Plx8000_DMA: Timeout waiting for interrupt
[72638.205851] Plx8000_DMA: ...Completed message
[72638.205949] PLX DMA[Dispatch_IoControl-1053]
[72638.205997] PLX DMA[Dispatch_IoControl-1061]
[72638.206083] Plx8000_DMA:
[72638.206108] Plx8000_DMA: Received PLX message ===>
[72638.206322] Plx8000_DMA: PLX_IOCTL_NOTIFICATION_CANCEL
[72638.206381] Plx8000_DMA: Removing interrupt wait object
(c000003c84638880)...
[72638.206456] Plx8000_DMA: ...Completed message
[72638.206506] PLX DMA[Dispatch_IoControl-1053]
[72638.206555] PLX DMA[Dispatch_IoControl-1061]
[72638.206617] Plx8000_DMA:
[72638.206643] Plx8000_DMA: Received PLX message ===>
[72638.206693] Plx8000_DMA: PLX_IOCTL_DMA_CHANNEL_CLOSE
[72638.206753] Plx8000_DMA: Closing DMA channel 0...
[72638.206801] Plx8000_DMA: ...Completed message
[72638.206849] PLX DMA[Dispatch_IoControl-1053]
[72638.206900] PLX DMA[Dispatch_IoControl-1061]
[72638.206962] Plx8000_DMA:
[72638.206988] Plx8000_DMA: Received message ==> CLOSE_DEVICE
[72638.207038] Plx8000_DMA: Close device (Plx8000_DMA-0)...
[72638.207087] Plx8000_DMA: ...device closed
[72638.352005] usb 1-1.3: USB disconnect, device number 62
[72639.885645] usb 1-1.3: new low-speed USB device number 63 using xhci_hcd
[72640.013182] usb 1-1.3: New USB device found, idVendor=04ca,
idProduct=0061
[72640.013455] usb 1-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber                                          =0
[72640.013529] usb 1-1.3: Product: USB Optical Mouse
[72640.013579] usb 1-1.3: Manufacturer: PixArt
[72640.018497] input: PixArt USB Optical Mouse as
/devices/pci0003:00/0003:00:00                                         
.0/0003:01:00.0/0003:02:09.0/0003:0d:00.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input12                                         
47
[72640.018877] hid-generic 0003:04CA:0061.04E0: input,hidraw1: USB HID v1.11
Mou                                          se [PixArt USB Optical Mouse]
on usb-0003:0d:00.0-1.3/input0
[72641.324398] Plx8000_NT:
[72641.324403] Plx8000_NT: Received PLX message ===>
[72641.324404] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_FREE
[72641.324467] Plx8000_NT: Released physical memory at 1f9e400000h (1MB)
[72641.324469] Plx8000_NT: ...Completed message
[72641.324487] Plx8000_NT:
[72641.324488] Plx8000_NT: Received PLX message ===>
[72641.324490] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_FREE
[72641.324549] Plx8000_NT: Released physical memory at 1f82c00000h (1MB)
[72641.324551] Plx8000_NT: ...Completed message




--
View this message in context: http://linuxppc.10917.n7.nabble.com/EEH-error-in-doing-DMA-with-PEX-8619-tp121121.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
