Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 666A2DDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:05:19 +1000 (EST)
Subject: [PATCH] powerpc: Fix initialization and usage of dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <1186436597.938.71.camel@localhost.localdomain>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>  <20070806115804.GA1734@suse.de>
	<1186436597.938.71.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 08:05:10 +1000
Message-Id: <1186437910.938.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Paul Mackerras <paulus@samba.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc has a couple of bugs in the usage of dma_masks that tend to
break when drivers explicitely try to set a 32 bits mask for example.

First the code that generates the pci devices from the OF device-tree
doesn't initialize the mask properly, then our implementation of
set_dma_mask() was trying to validate the -previous- mask value, not the
one passed in as an argument.

This patch should fix these.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Does this fix the problem you've noticed ?

(I do still think that sbp2 isn't the right place for that call btw :-)

Index: linux-work/include/asm-powerpc/dma-mapping.h
===================================================================
--- linux-work.orig/include/asm-powerpc/dma-mapping.h	2007-08-07 07:59:05.000000000 +1000
+++ linux-work/include/asm-powerpc/dma-mapping.h	2007-08-07 07:59:09.000000000 +1000
@@ -96,7 +96,7 @@
 		return -EIO;
 	if (dma_ops->set_dma_mask != NULL)
 		return dma_ops->set_dma_mask(dev, dma_mask);
-	if (!dev->dma_mask || !dma_supported(dev, *dev->dma_mask))
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
 	return 0;
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2007-08-07 08:00:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2007-08-07 08:00:47.000000000 +1000
@@ -372,6 +372,7 @@
 
 	dev->current_state = 4;		/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
+	dev->dma_mask = 0xffffffff;
 
 	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
