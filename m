Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 833FB2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Nov 2004 02:51:55 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so308961rnf
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Nov 2004 07:51:53 -0800 (PST)
Message-ID: <1f729c48041117075151960f69@mail.gmail.com>
Date: Wed, 17 Nov 2004 16:51:53 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
In-Reply-To: <1f729c480411110036445cd8aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1f729c480411110036445cd8aa@mail.gmail.com>
Subject: Re: 2.4 -> 2.6: problem probing PCI
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am currently comparing the 2.6.9 (failing code) PCI DBG output with
the 2.4.28-rc1 (working code) DBG output:

2.6.9:
> PCI: Probing PCI hardware
> PCI: bridge rsrc 0..bfffff (100), parent c0172188
> PCI: reparented dma1 [0..1f] under PCI host bridge
> PCI: reparented pic1 [20..3f] under PCI host bridge
> PCI: reparented timer [40..5f] under PCI host bridge
> PCI: reparented dma page reg [80..8f] under PCI host bridge
> PCI: reparented pic2 [a0..bf] under PCI host bridge
> PCI: reparented dma2 [c0..df] under PCI host bridge
> PCI: bridge rsrc 80000000..fcffffff (200), parent c017216c
> PCI:0000:00:00.0: Resource 1: 00000000-00000fff (f=3D200)
> PCI: Cannot allocate resource region 1 of device 0000:00:00.0
> PCI:  parent is c01b6054: 80000000-fcffffff (f=3D200)
> PCI:0000:00:10.0: Resource 0: bffff000-bfffffff (f=3D200)
> PCI:0000:00:10.0: Resource 1: 00bfffc0-00bfffff (f=3D101)
> PCI:0000:00:10.0: Resource 2: bffc0000-bffdffff (f=3D200)
> PCI:0000:00:11.0: Resource 0: bffbf000-bffbffff (f=3D200)
> PCI:0000:00:11.0: Resource 1: 00bfff80-00bfffbf (f=3D101)
> PCI:0000:00:11.0: Resource 2: bff80000-bff9ffff (f=3D200)
> PCI:0000:00:12.0: Resource 0: bf800000-bfbfffff (f=3D1208)
> PCI:0000:00:12.0: Resource 1: bf000000-bf7fffff (f=3D200)
> PCI:0000:00:12.0: Resource 2: 00bfff70-00bfff7f (f=3D101)
> PCI:0000:00:13.0: Resource 0: 00bfff60-00bfff6f (f=3D101)
> PCI:0000:00:13.0: Resource 1: befffff0-beffffff (f=3D200)

2.4.28-rc1
PCI: Probing PCI hardware
PCI:00:00.0 Resource 1 [00000000-00000fff] is unassigned
Fixup res 1 (101) of dev 00:10.0: bfffc0 -> febfffc0
Fixup res 1 (101) of dev 00:11.0: bfff80 -> febfff80
Fixup res 2 (101) of dev 00:12.0: bfff70 -> febfff70
Fixup res 0 (101) of dev 00:13.0: bfff60 -> febfff60
PCI: bridge rsrc fe000000..febfffff (100), parent c012aee8
PCI: bridge rsrc 80000000..fcffffff (200), parent c012aecc
PCI:00:10.0: Resource 0: bffff000-bfffffff (f=3D200)
PCI:00:10.0: Resource 1: febfffc0-febfffff (f=3D101)
PCI:00:10.0: Resource 2: bffc0000-bffdffff (f=3D200)
PCI:00:11.0: Resource 0: bffbf000-bffbffff (f=3D200)
PCI:00:11.0: Resource 1: febfff80-febfffbf (f=3D101)
PCI:00:11.0: Resource 2: bff80000-bff9ffff (f=3D200)
PCI:00:12.0: Resource 0: bf800000-bfbfffff (f=3D1208)
PCI:00:12.0: Resource 1: bf000000-bf7fffff (f=3D200)
PCI:00:12.0: Resource 2: febfff70-febfff7f (f=3D101)
PCI:00:13.0: Resource 0: febfff60-febfff6f (f=3D101)
PCI:00:13.0: Resource 1: befffff0-beffffff (f=3D200)

The first important difference is that a number of fixups are no
longer performed in the 2.6.9 kernel; which account for the
differences in the PCI address ranges.

The problem seems to be in=20
arch/ppc/kernel/pci.c

When comparing (but not yet fixed), some minor changes have been made:

line 16 changed from
   if (!res->start || res->end =3D=3D 0xffffffff) {
to
   if (res->end =3D=3D 0xffffffff) {

which disables the flow to enter the body in this case.

another relevant piece of code that gets me into troubles is the
computation of the offset
                } else if (res->flags & IORESOURCE_IO) {
                        offset =3D (unsigned long) hose->io_base_virt;
                                - isa_io_base;
                }

both values are equal to 0xfe000000, giving a final offset of 0 and no
adjustment.

I tried commenting out 'isa_io_base' but this gets me in resource
allocation conflicts later on (even though I get the ranges identical
to the ones in the 2.4.28 kernel).

Anyway, insights are welcome, I'm still investigating...

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
