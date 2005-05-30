Return-Path: <lagrange@fr.oleane.com>
Received: from relay02s.clb.oleane.net (relay02s.clb.oleane.net
	[213.56.31.143]) by ozlabs.org (Postfix) with ESMTP id 63CB1679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 20:13:41 +1000 (EST)
Received: from smtp10.clb.oleane.net (smtp10.clb.oleane.net [213.56.31.32])
	by relay02s.clb.oleane.net with ESMTP id j4UADRqP027069
	for <linuxppc-embedded@ozlabs.org>; Mon, 30 May 2005 12:13:39 +0200
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp10.clb.oleane.net with ESMTP id j4U9sfrw023882
	for <linuxppc-embedded@ozlabs.org>; Mon, 30 May 2005 11:54:45 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 30 May 2005 11:55:00 +0200
Message-ID: <000001c564fd$aa5aad60$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Embedded PowerPC with more than 2Go of RAM.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

We want to design a PCI host embedded PowerPC board with a 3Go local RAM
memory.
This processor is a MPC74xx with an internal 32 bits and an external 36 bits
address bus.

Usually, the mapping is :
0x00000000-0x80000000 : physical RAM
0x80000000-0xc0000000 : PCI memory access
0xc0000000-0xf0000000 : kernel virtual memory
0xf0000000-0xffffffff : IO area access

1) On this board, the physical memory will be :
0x00000000-0xc0000000 : physical RAM
Where could we map PCI memory space ?

2) The kernel virtual memory usually has the same size as the physical RAM
(two memory footprint for the same physical space ! ).
The kernel virtual memory will be :
0xc0000000-0x180000000 : kernel virtual memory
Where could we map IO space ?

3) Usually, all the host memory is mapped on pci bus. For a 32bits pci bus,
we could not do this.
Is it possible to only map on pci, the DMA memory area which is managed with
the kmalloc(size, GFP_DMA)
and kfree functions ? How can we set the DMA memory parameters (base address
and size) ?

Thanks for any idea

Laurent
