Return-Path: <zinosat@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11A462C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 06:59:11 +1000 (EST)
Received: by pabkq12 with SMTP id kq12so1649541pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 13:59:09 -0700 (PDT)
MIME-Version: 1.0
Sender: zinosat@gmail.com
In-Reply-To: <CAKpAL0nk-5zz2zht6suNx+BVCQtkxPFPL33uZFSuGpxT8YFFqg@mail.gmail.com>
References: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
 <89227A80-31E1-4E18-9257-6B60126E5A62@kernel.crashing.org>
 <CAKpAL0nTu9XXFgz7i5-1LmetrV05qfQcdf1zGxqHzODgQ7xjKA@mail.gmail.com>
 <CAKpAL0nk-5zz2zht6suNx+BVCQtkxPFPL33uZFSuGpxT8YFFqg@mail.gmail.com>
Date: Mon, 24 Sep 2012 22:59:09 +0200
Message-ID: <CAKpAL0m2Df6JZ=vYvhfEY5jYH9qOdMmrdmw2u2tcWAAFGv04+Q@mail.gmail.com>
Subject: Re: PCI device not working
From: Davide Viti <zinosat@tiscali.it>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=e89a8f83a3e966df6c04ca78dccc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--e89a8f83a3e966df6c04ca78dccc
Content-Type: text/plain; charset=ISO-8859-1

Here are the settings for PCI we currently have in uboot:

#define CONFIG_PCI                              1    /* Enable PCI/PCIE */
#define CONFIG_PCIE1                          1    /* PCIE controler 1
(slot 1) */
#define CONFIG_PCIE2                          1    /* PCIE controler 2
(slot 2) */
#define CONFIG_FSL_PCI_INIT               1    /* Use common FSL init code
*/
#define CONFIG_FSL_PCIE_RESET       1    /* need PCIe reset errata */
#define CONFIG_FSL_LAW                    1    /* Use common FSL init code
*/

#define CONFIG_SYS_PCIE1_ADDR        (CONFIG_SYS_CCSRBAR+0x9000)
#define CONFIG_SYS_PCIE2_ADDR        (CONFIG_SYS_CCSRBAR+0xa000)

/*
 * General PCI
 */

#define CONFIG_SYS_PCIE1_MEM_VIRT           0xA0000000
#define CONFIG_SYS_PCIE1_MEM_BUS           0xA0000000
#define CONFIG_SYS_PCIE1_MEM_PHYS         0xA0000000
#define CONFIG_SYS_PCIE1_MEM_SIZE           0x10000000
#define CONFIG_SYS_PCIE1_IO_VIRT               0xFFC10000
#define CONFIG_SYS_PCIE1_IO_BUS                0x00000000
#define CONFIG_SYS_PCIE1_IO_PHYS             0xFFC10000
#define CONFIG_SYS_PCIE1_IO_SIZE               0x00010000        /* 64k */

#define CONFIG_SYS_PCIE2_MEM_VIRT           0xB0000000
#define CONFIG_SYS_PCIE2_MEM_BUS           0xB0000000
#define CONFIG_SYS_PCIE2_MEM_PHYS         0xB0000000
#define CONFIG_SYS_PCIE2_MEM_SIZE           0x10000000
#define CONFIG_SYS_PCIE2_IO_VIRT               0xFFC00000
#define CONFIG_SYS_PCIE2_IO_BUS                0x00000000
#define CONFIG_SYS_PCIE2_IO_PHYS             0xFFC00000
#define CONFIG_SYS_PCIE2_IO_SIZE               0x00010000        /* 64k */

I'd really appreciate I you could take a look at it
Thanx alot in advance

Davide

2012/9/24 Davide Viti <zinosat@tiscali.it>

> Hi,
> does the output I've included show anything wrong or should I post
> something else to help identifying the cause of the problem?
>
> thank you in advance,
> Davide
>
> 2012/9/21 Davide Viti <zinosat@tiscali.it>
>
>> I mean there are two controllers and both of them have a device
>> "subtended" (both 0x1b65:0xabba).
>> u-boot can see both devices, linux detects only the device attached to
>> the first controller.
>>
>> Here's the output of lspci and /proc/iomem :
>>
>> root@(none):/# lspci -v
>>
>> 0000:00:00.0 Class 0604: Device 1957:0100 (rev 11)
>>
>>         Flags: bus master, fast devsel, latency 0
>>
>>         Memory at <ignored> (32-bit, non-prefetchable)
>>
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>
>>         I/O behind bridge: 00000000-00000fff
>>
>>         Memory behind bridge: a0000000-afffffff
>>
>>         Capabilities: [44] Power Management version 2
>>
>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>
>>         Capabilities: [100] Advanced Error Reporting
>>
>>
>>
>> 0000:01:00.0 Class 0280: Device 1b65:abba (rev 01)
>>
>>         Flags: bus master, fast devsel, latency 0, IRQ 16
>>
>>         Memory at a0000000 (32-bit, non-prefetchable) [size=1K]
>>
>>         Memory at a0010000 (32-bit, non-prefetchable) [size=64K]
>>
>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>
>>         Capabilities: [78] Power Management version 3
>>
>>         Capabilities: [80] Express Endpoint, MSI 00
>>
>>         Capabilities: [100] Virtual Channel <?>
>>
>>         Capabilities: [800] Advanced Error Reporting
>>
>>
>>
>> 0001:02:00.0 Class 0604: Device 1957:0100 (rev 11)
>>
>>         Flags: bus master, fast devsel, latency 0
>>
>>         Memory at <ignored> (32-bit, non-prefetchable)
>>
>>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>>
>>         I/O behind bridge: 00000000-00000fff
>>
>>         Memory behind bridge: b0000000-bfffffff
>>
>>         Capabilities: [44] Power Management version 2
>>
>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>
>>         Capabilities: [100] Advanced Error Reporting
>>
>>
>> root@(none):/# cat /proc/iomem
>>
>> a0000000-afffffff : /pcie@ffe09000
>>
>>   a0000000-afffffff : PCI Bus 0000:01
>>
>>     a0000000-a00003ff : 0000:01:00.0
>>
>>     a0010000-a001ffff : 0000:01:00.0
>>
>> b0000000-bfffffff : /pcie@ffe0a000
>>
>>   b0000000-bfffffff : PCI Bus 0001:03
>>
>> ef000000-efffffff : ef000000.nor
>>
>> ffe04500-ffe04507 : serial
>>
>> ffe04600-ffe04607 : serial
>>
>>
>> thanx for your help,
>>
>> Davide
>>
>>
>> I mean that the kernel detects the first controller and the device
>> attached to it, plus the second controller: the device on the second
>> controller is not detected (same device as the one detected on the first
>> controller)
>>
>> 2012/9/21 Kumar Gala <galak@kernel.crashing.org>
>>
>>>
>>> On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:
>>>
>>> > Hi,
>>> > I'm working on a custom board based on P1020 with two (identical) PCI
>>> devices attached;
>>> > The work is derived from another board with a single instance of that
>>> device.
>>> > The system is based on u-boot-2009.11 and Linux 2.6.34.6
>>> >
>>> > The "pci" command on u-boot, shows me both the PCI controllers and
>>> > the attached devices:
>>> >
>>> > Scanning PCI devices on bus 0
>>> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>>> > _____________________________________________________________
>>> > 00.00.00   0x1957     0x0100     Processor               0x20
>>> >
>>> > Scanning PCI devices on bus 1
>>> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>>> > _____________________________________________________________
>>> > 01.00.00   0x1b65     0xabba     Network controller      0x80
>>> >
>>> > Scanning PCI devices on bus 2
>>> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>>> > _____________________________________________________________
>>> > 02.00.00   0x1957     0x0100     Processor               0x20
>>> >
>>> > Scanning PCI devices on bus 3
>>> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>>> > _____________________________________________________________
>>> > 03.00.00   0x1b65     0xabba     Network controller      0x80
>>> >
>>> > The kernel detects only the first instance of the device.
>>>
>>> What do you mean by first instance of the device ?
>>>
>>> > Didn't get very far while looking at dts file and kernel logs, so I'm
>>> > asking for some help on narrowing down the problem.
>>> >
>>> > I'm wondering if I can assume that the problem is restricted to
>>> > kernel/dts and avoid concentrating on uboot.
>>> > I can provide any log (didn't want to post tons of details on the first
>>> > message)
>>>
>>> Probably a dts issue.
>>>
>>> What does lspci in linux say?
>>>
>>> - k
>>>
>>>
>>
>

--e89a8f83a3e966df6c04ca78dccc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Here are the settings for PCI we currently have in uboot:</div><div><b=
r></div><div>#define CONFIG_PCI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 =A0 =A0/* Enable PCI/PCIE */</div><div>#define CONFIG_PCI=
E1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =A0/* PCIE cont=
roler 1 (slot 1) */</div>
<div>#define CONFIG_PCIE2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A01 =A0 =A0/* PCIE controler 2 (slot 2) */</div><div>#define CONFIG_FSL_PC=
I_INIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0/* Use common FSL init code */<=
/div><div>#define CONFIG_FSL_PCIE_RESET =A0 =A0 =A0 1 =A0 =A0/* need PCIe r=
eset errata */</div>
<div>#define CONFIG_FSL_LAW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =
=A0/* Use common FSL init code */</div><div>=A0</div><div>#define CONFIG_SY=
S_PCIE1_ADDR =A0 =A0 =A0 =A0(CONFIG_SYS_CCSRBAR+0x9000)</div><div>#define C=
ONFIG_SYS_PCIE2_ADDR =A0 =A0 =A0 =A0(CONFIG_SYS_CCSRBAR+0xa000)</div>
<div>=A0</div><div>/*</div><div>=A0* General PCI</div><div>=A0*/</div><div>=
=A0</div><div>#define CONFIG_SYS_PCIE1_MEM_VIRT =A0 =A0 =A0 =A0 =A0 0xA0000=
000</div><div>#define CONFIG_SYS_PCIE1_MEM_BUS =A0 =A0 =A0 =A0 =A0 0xA00000=
00</div><div>#define CONFIG_SYS_PCIE1_MEM_PHYS =A0 =A0 =A0 =A0 0xA0000000</=
div>
<div>#define CONFIG_SYS_PCIE1_MEM_SIZE =A0 =A0 =A0 =A0 =A0 0x10000000</div>=
<div>#define CONFIG_SYS_PCIE1_IO_VIRT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xFFC1000=
0</div><div>#define CONFIG_SYS_PCIE1_IO_BUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x00000000</div><div>#define CONFIG_SYS_PCIE1_IO_PHYS =A0 =A0 =A0 =A0 =A0 =
=A0 0xFFC10000</div>
<div>#define CONFIG_SYS_PCIE1_IO_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0001000=
0 =A0 =A0 =A0 =A0/* 64k */</div><div>=A0</div><div>#define CONFIG_SYS_PCIE2=
_MEM_VIRT =A0 =A0 =A0 =A0 =A0 0xB0000000</div><div>#define CONFIG_SYS_PCIE2=
_MEM_BUS =A0 =A0 =A0 =A0 =A0 0xB0000000</div>
<div>#define CONFIG_SYS_PCIE2_MEM_PHYS =A0 =A0 =A0 =A0 0xB0000000</div><div=
>#define CONFIG_SYS_PCIE2_MEM_SIZE =A0 =A0 =A0 =A0 =A0 0x10000000</div><div=
>#define CONFIG_SYS_PCIE2_IO_VIRT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xFFC00000</d=
iv><div>#define CONFIG_SYS_PCIE2_IO_BUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00=
000000</div>
<div>#define CONFIG_SYS_PCIE2_IO_PHYS =A0 =A0 =A0 =A0 =A0 =A0 0xFFC00000</d=
iv><div>#define CONFIG_SYS_PCIE2_IO_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0001=
0000 =A0 =A0 =A0 =A0/* 64k */</div><div><br></div><div>I&#39;d really appre=
ciate I you could take a look at it</div>
<div>Thanx alot in advance</div><div><br></div><div>Davide</div><br><div cl=
ass=3D"gmail_quote">2012/9/24 Davide Viti <span dir=3D"ltr">&lt;<a href=3D"=
mailto:zinosat@tiscali.it" target=3D"_blank">zinosat@tiscali.it</a>&gt;</sp=
an><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im HOEnZb"><span style=3D"colo=
r:rgb(34,34,34);font-size:13px;font-family:arial,sans-serif">Hi,</span><div=
 style=3D"color:rgb(34,34,34);font-size:13px;font-family:arial,sans-serif">

does the output I&#39;ve included show anything wrong or should I post some=
thing else to help identifying the cause of the problem?</div><div style=3D=
"color:rgb(34,34,34);font-size:13px;font-family:arial,sans-serif">
<br></div><div style=3D"color:rgb(34,34,34);font-size:13px;font-family:aria=
l,sans-serif">thank you in advance,</div><div style=3D"color:rgb(34,34,34);=
font-size:13px;font-family:arial,sans-serif">
Davide</div><br></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D=
"gmail_quote">2012/9/21 Davide Viti <span dir=3D"ltr">&lt;<a href=3D"mailto=
:zinosat@tiscali.it" target=3D"_blank">zinosat@tiscali.it</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">

<div>I mean there are two controllers and both of them have a device &quot;=
subtended&quot; (both=A00x1b65:0xabba).</div><div>u-boot can see both devic=
es, linux detects only the device attached to the first controller.</div>

<div>
<br></div><div>Here&#39;s the output of lspci and /proc/iomem :</div><div><=
br></div><div><div><div><p class=3D"MsoNormal"><font face=3D"Arial"><span s=
tyle=3D"font-size:10pt">root@(none):/# lspci=20
-v</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
0000:00:00.0 Class 0604: Device=20
1957:0100 (rev 11)</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Flags: bus master, fast=20
devsel, latency 0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory at &lt;ignored&gt;=20
(32-bit, non-prefetchable)</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00,=20
secondary=3D01, subordinate=3D01, sec-latency=3D0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0 =A0I/O behind bridge:=20
00000000-00000fff</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge:=20
a0000000-afffffff</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [44] Power=20
Management version 2</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [4c]=20
Express=20
Root Port (Slot-), MSI=20
00</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100] Advanced=20
Error Reporting</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
0000:01:00.0 Class 0280: Device=20
1b65:abba (rev 01)</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Flags: bus master, fast=20
devsel, latency 0, IRQ 16</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory at a0000000 (32-bit,=20
non-prefetchable) [size=3D1K]</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory at a0010000 (32-bit,=20
non-prefetchable) [size=3D64K]</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] MSI:=20
Enable- Count=3D1/1 Maskable- 64bit+</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [78] Power=20
Management version 3</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [80] Express=20
Endpoint, MSI 00</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100] Virtual=20
Channel &lt;?&gt;</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [800] Advanced=20
Error Reporting</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
0001:02:00.0 Class 0604: Device=20
1957:0100 (rev 11)</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Flags: bus master, fast=20
devsel, latency 0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory at &lt;ignored&gt;=20
(32-bit, non-prefetchable)</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00,=20
secondary=3D03, subordinate=3D03, sec-latency=3D0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 I/O behind bridge:=20
00000000-00000fff</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge:=20
b0000000-bfffffff</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [44] Power=20
Management version 2</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [4c]=20
Express=20
Root Port (Slot-), MSI=20
00</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100] Advanced=20
Error Reporting</span></font></p><p class=3D"MsoNormal"><font face=3D"Arial=
"><span style=3D"font-size:10pt"><br></span></font></p><p class=3D"MsoNorma=
l"></p><p class=3D"MsoNormal"><font face=3D"Arial"><span lang=3D"PL" style=
=3D"font-size:10pt">root@(none):/# cat=20
/proc/iomem</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span lang=3D"PL" style=3D"font=
-size:10pt">a0000000-afffffff :=20
/pcie@ffe09000</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span lang=3D"PL" style=3D"font=
-size:10pt">=A0 </span></font><font face=3D"Arial"><span style=3D"font-size=
:10pt">a0000000-afffffff : PCI=20
Bus 0000:01</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0 a0000000-a00003ff :=20
0000:01:00.0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0=A0=A0 a0010000-a001ffff :=20
0000:01:00.0</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
b0000000-bfffffff :=20
/pcie@ffe0a000</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
=A0 b0000000-bfffffff : PCI Bus=20
0001:03</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
ef000000-efffffff :=20
ef000000.nor</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
ffe04500-ffe04507 :=20
serial</span></font></p>
<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
ffe04600-ffe04607 :=20
serial</span></font></p><p class=3D"MsoNormal"><font face=3D"Arial"><span s=
tyle=3D"font-size:10pt"><br></span></font></p></div></div><p class=3D"MsoNo=
rmal"><font face=3D"Arial"><span style=3D"font-size:10pt">thanx for your he=
lp,</span></font></p>


<p class=3D"MsoNormal"><font face=3D"Arial"><span style=3D"font-size:10pt">=
Davide</span></font></p><p class=3D"MsoNormal"><font face=3D"Arial"><span s=
tyle=3D"font-size:10pt"><br></span></font></p><p></p></div>I mean that the =
kernel detects the first controller and the device attached to it, plus the=
 second controller: the device on the second controller is not detected (sa=
me device as the one detected on the first controller)<div>

<div><br>
<div class=3D"gmail_quote">2012/9/21 Kumar Gala <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:galak@kernel.crashing.org" target=3D"_blank">galak@kernel.cras=
hing.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">


<div><br>
On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:<br>
<br>
&gt; Hi,<br>
&gt; I&#39;m working on a custom board based on P1020 with two (identical) =
PCI devices attached;<br>
&gt; The work is derived from another board with a single instance of that =
device.<br>
&gt; The system is based on u-boot-2009.11 and Linux 2.6.34.6<br>
&gt;<br>
&gt; The &quot;pci&quot; command on u-boot, shows me both the PCI controlle=
rs and<br>
&gt; the attached devices:<br>
&gt;<br>
&gt; Scanning PCI devices on bus 0<br>
&gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Cl=
ass<br>
&gt; _____________________________________________________________<br>
&gt; 00.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0x20<br>
&gt;<br>
&gt; Scanning PCI devices on bus 1<br>
&gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Cl=
ass<br>
&gt; _____________________________________________________________<br>
&gt; 01.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0 =A0 =
=A00x80<br>
&gt;<br>
&gt; Scanning PCI devices on bus 2<br>
&gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Cl=
ass<br>
&gt; _____________________________________________________________<br>
&gt; 02.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0x20<br>
&gt;<br>
&gt; Scanning PCI devices on bus 3<br>
&gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Cl=
ass<br>
&gt; _____________________________________________________________<br>
&gt; 03.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0 =A0 =
=A00x80<br>
&gt;<br>
&gt; The kernel detects only the first instance of the device.<br>
<br>
</div>What do you mean by first instance of the device ?<br>
<div><br>
&gt; Didn&#39;t get very far while looking at dts file and kernel logs, so =
I&#39;m<br>
&gt; asking for some help on narrowing down the problem.<br>
&gt;<br>
&gt; I&#39;m wondering if I can assume that the problem is restricted to<br=
>
&gt; kernel/dts and avoid concentrating on uboot.<br>
&gt; I can provide any log (didn&#39;t want to post tons of details on the =
first<br>
&gt; message)<br>
<br>
</div>Probably a dts issue.<br>
<br>
What does lspci in linux say?<br>
<span><font color=3D"#888888"><br>
- k<br>
<br>
</font></span></blockquote></div><br>
</div></div></blockquote></div><br>
</div></div></blockquote></div><br>

--e89a8f83a3e966df6c04ca78dccc--
