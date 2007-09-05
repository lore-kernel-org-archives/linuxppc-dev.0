Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 237CFDDEF9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 03:31:25 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l85HUHfr027793
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 21:30:17 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l85HUGjI027790
	for linuxppc-dev@ozlabs.org; Wed, 5 Sep 2007 21:30:16 +0400
Date: Wed, 5 Sep 2007 21:30:16 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Add 64-bit resources support to pci_iomap
Message-ID: <20070905173016.GA27771@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch adds support for the 64-bit resources to the PCI
iomap code.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---

--- linux-2.6.orig/arch/powerpc/kernel/iomap.c	2007-09-04 21:15:13.000000000 +0400
+++ linux-2.6.bld/arch/powerpc/kernel/iomap.c	2007-09-05 21:06:39.000000000 +0400
@@ -119,8 +119,8 @@
 
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
 {
-	unsigned long start = pci_resource_start(dev, bar);
-	unsigned long len = pci_resource_len(dev, bar);
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
 	unsigned long flags = pci_resource_flags(dev, bar);
 
 	if (!len)
