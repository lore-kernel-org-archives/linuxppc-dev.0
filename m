Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id 14EAC2BF45
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 19:36:32 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so41477rnf
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 00:36:28 -0800 (PST)
Message-ID: <1f729c480411110036445cd8aa@mail.gmail.com>
Date: Thu, 11 Nov 2004 09:36:28 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: 2.4 -> 2.6: problem probing PCI
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

before digging into the lower ppc specific code myself, I thought to
ask and describe my problem here first. I am currently porting a 2.4
based embedded solution to a 2.6 kernel (basically for the fun of it)
and have come accross the following:

When probing the PCI bus (of an embedded solution DBG enabled; 2.6.9):

PCI: Probing PCI hardware
PCI: bridge rsrc 0..bfffff (100), parent c0172188
PCI: reparented dma1 [0..1f] under PCI host bridge
PCI: reparented pic1 [20..3f] under PCI host bridge
PCI: reparented timer [40..5f] under PCI host bridge
PCI: reparented dma page reg [80..8f] under PCI host bridge
PCI: reparented pic2 [a0..bf] under PCI host bridge
PCI: reparented dma2 [c0..df] under PCI host bridge
PCI: bridge rsrc 80000000..fcffffff (200), parent c017216c
PCI:0000:00:00.0: Resource 1: 00000000-00000fff (f=3D200)
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
PCI:  parent is c01b6054: 80000000-fcffffff (f=3D200)
PCI:0000:00:10.0: Resource 0: bffff000-bfffffff (f=3D200)
PCI:0000:00:10.0: Resource 1: 00bfffc0-00bfffff (f=3D101)
PCI:0000:00:10.0: Resource 2: bffc0000-bffdffff (f=3D200)
PCI:0000:00:11.0: Resource 0: bffbf000-bffbffff (f=3D200)
PCI:0000:00:11.0: Resource 1: 00bfff80-00bfffbf (f=3D101)
PCI:0000:00:11.0: Resource 2: bff80000-bff9ffff (f=3D200)
PCI:0000:00:12.0: Resource 0: bf800000-bfbfffff (f=3D1208)
PCI:0000:00:12.0: Resource 1: bf000000-bf7fffff (f=3D200)
PCI:0000:00:12.0: Resource 2: 00bfff70-00bfff7f (f=3D101)
PCI:0000:00:13.0: Resource 0: 00bfff60-00bfff6f (f=3D101)
PCI:0000:00:13.0: Resource 1: befffff0-beffffff (f=3D200)

There is a problem with an FPGA register map (I assume) since:
ppc2fpga: BAR 0 (0xbfff60-0xbfff6f), len=3D16, flags=3D0x000101
ppc2fpga: BAR 1 (0xbefffff0-0xbeffffff), len=3D16, flags=3D0x000200
ppc2fpga: remapped 0xbfff60 with size 16 to 0xc3004f60


On a 2.4.28-rc1, this reads (same hardware):
ppc2fpga: BAR 0 (0xfebfff40-0xfebfff5f), len=3D32, flags=3D0x000101
ppc2fpga: BAR 1 (0xbefffff0-0xbeffffff), len=3D16, flags=3D0x000200
ppc2fpga: remapped 0xfebfff40 with size 32 to 0xfebfff40

This last one has the correct behaviour and is the one currently being
installed. Both the size and the address is wrong. When I read data
from the FPGA, I get 0xFF while it should be ASCII information (the
FPGA is the PPC watchdog).

My obvious question is now: any pointers in how to proceed in
debugging this or possible reasons for this change in behaviour?

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
