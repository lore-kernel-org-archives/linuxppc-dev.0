Return-Path: <lagrange@fr.oleane.com>
Received: from relay01s.ntr.oleane.net (relay01s.ntr.oleane.net [194.2.8.82])
	by ozlabs.org (Postfix) with ESMTP id 615042BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 07:51:58 +1100 (EST)
Received: from smtp1.clb.oleane.net (smtp1.clb.oleane.net [213.56.31.17])
	by relay01s.ntr.oleane.net with ESMTP id iAPA9ogx012097
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Nov 2004 11:10:08 +0100
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp1.clb.oleane.net with ESMTP id iAP9ujvo005094
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Nov 2004 10:56:47 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 25 Nov 2004 10:59:28 +0100
Message-ID: <000001c4d2d5$758dc9b0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Questions about PCI resources in Linux 2.4.25 for MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I ported a MPC8260 custom LSP from Linux 2.4.18 to Linux 2.4.25 and
I discovered something strange in the last kernel.

In the file arch/ppc/kernel/setup.c, the function "setup_arch" runs this new
code :

    code_resource.start   = virt_to_bus((void *)PAGE_OFFSET);
    code_resource.end    = virt_to_bus(&_etext)-1;
    data_resource.start   = virt_to_bus(&_etext);
    data_resource.end    = virt_to_bus(&_edata)-1;
    request_resource(&iomem_resource, &code_resource);
    request_resource(&iomem_resource, &data_resource);

This code seems to reserve PCI resources for the kernel code and data.

Has anybody an idea why these resources are added and needed ?
To detect future PCI conflicts ? To preserve from external PCI accesses ?

If the board sdram is not mapped on PCI at 0x00000000, these resources
generate problems when scanning pci bus and discovering sdram space
in own pci bridge header space.

Is there a new rule to set sdram board to 0x00000000 instead of 0x80000000
while enumerating PCI.

Thanks for your ideas.
 Laurent
