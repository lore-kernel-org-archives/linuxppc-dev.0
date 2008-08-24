Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E856EDDDE0
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 02:08:00 +1000 (EST)
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net
	[151.189.8.14])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 2F6B61F58BA
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 18:07:54 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 1409E11462F
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 18:07:54 +0200 (CEST)
Received: from bunny.home (dslb-088-070-072-108.pools.arcor-ip.net
	[88.70.72.108])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E372B1075FD
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 18:07:53 +0200 (CEST)
Received: from fox.home (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 2F7B425104DE
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 18:11:59 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: ppc4xx_pci: disable PCI (PnP) via fdt
Date: Sun, 24 Aug 2008 18:07:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808241807.52547.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

is it possible to disable PCI PnP via the device tree on a 4xx system?

I am working with a 440EPx board that can be system CPU (with PCI hostbridge)
or a PCI adapter board. In the latter setup I want to disable PCI PnP, 
preferred by manipulating the fdt by U-Boot. The PCI mode is 
detected by U-Boot through a GPIO signal. I do not want to remove the 
complete /plb/pci... path of the device tree for adapter mode , because I do 
not want the PCI bus to be totally invisible. lspci and friends should still 
show devices on the local PCI bus.

The 4xx PCIE fdt handling handles a 'status' and 'device_type' property.
These properties behave not the way I need and also they are only
available for PCIE. 

With arch/ppc kernels I did this by returning '1' from 
ppc_md.pci_exclude_device when PCI PnP should not be done.
Even though I could do it the same way with arch/powerpc, I hope
that there is a fdt-way.

Any ideas?

BTW, isn't it a good idea to handle the 'status' and 'device_type' property 
for PCI in the same way as for PCIE?

Matthias
