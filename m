Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 6DA59B70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Sep 2010 22:52:35 +1000 (EST)
Received: by pwj1 with SMTP id 1so1348889pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 06 Sep 2010 05:52:33 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Sep 2010 18:22:33 +0530
Message-ID: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
Subject: pci_request_regions() failure
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636458c7e09ac74048f96c10a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636458c7e09ac74048f96c10a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am facing a problem while requesting pci resource. I have some data that I
am hopeful will help address the issue.

I am currently running on a MPC837xERDB board(powerpc) with a 2.6.35 kernel.
The problem is that whenever I insert the card (LatticeECP2M PCI Express
Development Kit<http://www.latticesemi.com/products/developmenthardware/developmentkits/pciexpressdevkitecp2m/index.cfm>)
in pci-express slot 0 and try to load my driver module, I get a
pci_request_regions() failure(error -EBUSY). The interesting thing is the
region that it fails for. According to /proc/iomem, slot0 has
a8000000-b7ffffff as its memory ranges. However, the memory region requested
by my device is a8000000-a803ffff and a8040000-a807ffff which falls in the
slot0 range. But after boot up when I look at /proc/iomem, there is a
already allocated resource range present there, which overlaps with the
range refined in my device, hence the pci_request_regions() fails.

Output of lspci
0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c6 (rev
21)
0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c6
(rev 21)
0001:02:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
Unknown device e250  ---> My device

Contents of /pro/iomem file
# cat /proc/iomem
80000000-8fffffff : /pci@e0008500
90000000-9fffffff : /pci@e0008500
a8000000-b7ffffff : /pcie@e0009000
  a8000000-a80fffff : PCI Bus 0001:02  ---> colprit range
c8000000-d7ffffff : /pcie@e000a000
e0004500-e0004507 : serial
e0004600-e0004607 : serial
e0023000-e0023fff : usb

Now my doubt is, who is allocating this range and why? It seem to me a
kernel bug as I also tried my device on i386 machine(opensuse, linux 2.6.35
i.e the same kernel version on powerpc board) and there everything works
fine. I don't know where to start to fix it. Please suggest.

Output of lspci

scooby:~ # lspci
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM
Controller (rev 10)
00:01.0 PCI bridge: Intel Corporation 82G33/G31/P35/P31 Express PCI Express
Root Port (rev 10)
00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
Integrated Graphics Controller (rev 10)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
2 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
3 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
(rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA
IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev
01)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B
PCI Express Gigabit Ethernet controller (rev 01)
04:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
Device e250    ----------> My device
05:06.0 Serial controller: Device 4348:3253 (rev 10)

Contents of /proc/iomem on i386 machine

cat /proc/iomem
.
.
.
fe900000-fe9fffff : PCI Bus 0000:04
   fe900000-fe93ffff : 0000:04:00.0    ------------->My device
   fe940000-fe97ffff : 0000:04:00.0    ------------->My device
fea00000-feafffff : PCI Bus 0000:03
fea00000-fea1ffff : 0000:03:00.0
fea20000-fea20fff : 0000:03:00.0
fea20000-fea20fff : r8169
.
.
.

Regards,

Ravi

--001636458c7e09ac74048f96c10a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am facing a problem while requesting pci resource.  I have som=
e data that I am hopeful will help=20

address the issue.<br><p>I am currently running on a MPC837xERDB board(powe=
rpc) with a 2.6.35 kernel. The problem is that whenever I insert the card (=
<font size=3D"2"><a href=3D"http://www.latticesemi.com/products/development=
hardware/developmentkits/pciexpressdevkitecp2m/index.cfm">LatticeECP2M PCI =
Express Development Kit</a>) </font>in pci-express slot 0 and try to load m=
y driver module, I get a=20

pci_request_regions() failure(error -EBUSY). The interesting thing is the r=
egion that it fails for.  According to /proc/iomem, slot0 has a8000000-b7ff=
ffff as its memory ranges.  However, the memory region requested by my devi=
ce is a8000000-a803ffff and a8040000-a807ffff which falls in the slot0 rang=
e. But after boot up when I look at /proc/iomem, there is a already allocat=
ed resource range present there, which overlaps with the range refined in m=
y device, hence the pci_request_regions() fails.</p>
<p>Output of lspci</p>0000:00:00.0 Power PC: Freescale Semiconductor Inc Un=
known device 00c6 (rev 21)<br>0001:01:00.0 PCI bridge: Freescale Semiconduc=
tor Inc Unknown device 00c6 (rev 21)<br>0001:02:00.0 Non-VGA unclassified d=
evice: Lattice Semiconductor Corporation Unknown device e250=A0 ---&gt; My =
device<br>
<br><p></p><p>Contents of /pro/iomem file</p># cat /proc/iomem<br>80000000-=
8fffffff : /pci@e0008500<br>90000000-9fffffff : /pci@e0008500<br>a8000000-b=
7ffffff : /pcie@e0009000<br>=A0 a8000000-a80fffff : PCI Bus 0001:02=A0 ---&=
gt; colprit range<br>
c8000000-d7ffffff : /pcie@e000a000<br>e0004500-e0004507 : serial<br>e000460=
0-e0004607 : serial<br>e0023000-e0023fff : usb<p></p><p>Now my doubt is, wh=
o is allocating this range and why? It seem to me a kernel bug as I also tr=
ied my device on i386 machine(opensuse, linux 2.6.35 i.e the same kernel ve=
rsion on powerpc board) and there everything works fine. I don&#39;t know w=
here to start to fix it. Please suggest.</p>
<p>Output of lspci<br></p><p>scooby:~ # lspci <br>
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Contr=
oller (rev 10)<br>
00:01.0 PCI bridge: Intel Corporation 82G33/G31/P35/P31 Express PCI Express=
 Root Port (rev 10)<br>
00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express Inte=
grated Graphics Controller (rev 10)<br>
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definitio=
n Audio Controller (rev 01)<br>
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port=
 1 (rev 01)<br>
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port=
 2 (rev 01)<br>
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port=
 3 (rev 01)<br>
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Con=
troller #1 (rev 01)<br>
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Con=
troller #2 (rev 01)<br>
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Con=
troller #3 (rev 01)<br>
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Con=
troller #4 (rev 01)<br>
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Co=
ntroller (rev 01)<br>
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)<br>
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interfac=
e Bridge (rev 01)<br>
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controlle=
r (rev 01)<br>
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA I=
DE Controller (rev 01)<br>
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev=
 01)<br>
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B =
PCI Express Gigabit Ethernet controller (rev 01)<br>
04:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation Devi=
ce e250=A0=A0=A0 ----------&gt; My device<br>
05:06.0 Serial controller: Device 4348:3253 (rev 10)
		=09
		</p><p></p><p>Contents of /proc/iomem on i386 machine</p><p>cat /proc/iom=
em<br>
.<br>
.<br>
.<br>
fe900000-fe9fffff : PCI Bus 0000:04 <br>=A0=A0
  fe900000-fe93ffff : 0000:04:00.0=A0=A0=A0 -------------&gt;My device<br>=
=A0=A0
  fe940000-fe97ffff : 0000:04:00.0=A0=A0=A0 -------------&gt;My device<br>
fea00000-feafffff : PCI Bus 0000:03<br>
  fea00000-fea1ffff : 0000:03:00.0<br>
  fea20000-fea20fff : 0000:03:00.0<br>
    fea20000-fea20fff : r8169<br>
.<br>
.<br>
.
		=09
		</p><p></p><p>Regards,</p><p>Ravi<br></p><p><br></p><p><br>
</p><br>

--001636458c7e09ac74048f96c10a--
