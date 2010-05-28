Return-Path: <lagrange@fr.oleane.com>
Received: from smtp-out05.msg.oleane.net (smtp-out05.msg.oleane.net
	[62.161.7.3]) by ozlabs.org (Postfix) with ESMTP id 62A3DB7D1D
	for <linuxppc-dev@ozlabs.org>; Sat, 29 May 2010 14:34:31 +1000 (EST)
Received: from smtp01.msg.oleane.net (smtp01.mail.priv [172.17.20.110])
	by smtp-out05.msg.oleane.net with ESMTP id o4SF5VJw029696
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:05:31 +0200
Received: from GEGE6600V (iconcept-gw.rain.fr [194.2.96.216]) (authenticated)
	by smtp01.msg.oleane.net (MTA) with ESMTP id o4SEj1MN006952
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:45:01 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Linux 2.6.x:  arch powerpc: PCI DMA allocation misunderstandings
Date: Fri, 28 May 2010 16:44:54 +0200
Message-ID: <001401cafe74$5a8864b0$a501a8c0@GEGE6600V>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000901caab49$98517d00$a501a8c0@GEGE6600V>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

I use a 82xx or 85xx host platform with a Linux 2.6.24 or 2.2.31.

On this host, I want to write a PCI driver for a target PMC device
wich only supports 30bits (1GB) DMA addressing.
The PMC device is the master of the DMA transfers from/to the host memory.

In the host driver, I begin to set the two DMA masks with 
 - pci_set_dma_mask(pdev, DMA_BIT_MASK(30)) and
 - pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(30))

Then I allocate DMA buffers in the host memory with
 - pci_alloc_consistent or
 - pci_pool_create and pci_pool_alloc

My problem is that the alloc functions return physical addresses
which are coherent with 32bits but not with the wanted 30bits.

The allocations seem to work like a kmalloc with a GFP_DMA flag.
On powerpc architecture, GFP_DMA preserves the allocations on 32bits
unlike on x86 architecture which restrict the allocations on 24bits.

I don't understand why it is recommended to use the PCI DMA API
with the DMA masks if the final allocator is only able to 
use a GFP_DMA-like restriction and not a real provided mask.

Surely I missed something...
Any idea would be welcome.

Thanks
Laurent
