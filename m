Return-Path: <tmarri@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8B0D01007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jan 2010 10:50:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to access PPC460EX SDRAM space from PCI/PCIe.
Date: Thu, 31 Dec 2009 15:50:15 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C08882EAA@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <6caf4b5a0912310055h54a6efa6ka1825f19a7f0c691@mail.gmail.com>
References: <6caf4b5a0912310055h54a6efa6ka1825f19a7f0c691@mail.gmail.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Lonsn" <lonsn2005@gmail.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It should be able to access any region in 32bit mode as long as it is
smaller than 4GB size. Usually whole SDRAM is mapped to inbound PCI
memory region.

-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] On =
Behalf
Of Lonsn
Sent: Thursday, December 31, 2009 12:55 AM
To: linuxppc-dev@lists.ozlabs.org
Cc: sr@denx.de
Subject: How to access PPC460EX SDRAM space from PCI/PCIe.

Hi:
I'm now using canyonlands board with latest u-boot and linux kernel
from DENX git.
A PCIe card is plugged in the PCIeX4 slot. The PCIe card is a PCIe-pci
bridge(PI7C9X130) plus an Altera fpga.
The PCIe card act as a PCI master and send data to SDRAM of 460EX
space (total sdram 512MB, reserve 8M for PCI write data(0x1F800000)).
Now linux can identify this card, but CPU cann't receive any data from
PCIe and no PCIe interrupt.
I know about the PCI card works in 32bit mode and doesn't support
64bit address(No pci dual address cycle support).
Does the PCI card can access PPC460EX sdram space using just 32bit
physical address(0x1F800000)?

Best regards,
Lonsn
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
