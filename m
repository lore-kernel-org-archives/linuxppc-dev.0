Return-Path: <sshtylyov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0BB9CDE8B3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 06:05:45 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH] siimage: fix kernel oops on PPC 44x
Date: Tue, 8 Apr 2008 00:05:03 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804080005.03683.sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix kernel oops due to machine check occuring in init_chipset_siimage() on PPC
44x platforms.  These 32-bit CPUs have 36-bit physical address and PCI I/O and
memory spaces are mapped beyond 4 GB; arch/ppc/ code has a fixup in ioremap()
that creates an illusion of the PCI I/O and memory resources being mapped below
4 GB, while arch/powerpc/ code got rid of this fixup with PPC 44x having instead
CONFIG_RESOURCES_64BIT=y -- this causes the resources to be truncated to 32-bit
'unsigned long' type in this driver, and so non-existant memory being ioremap'ed
and then accessed...

Thanks to Valentine Barshak for providing an initial patch and explanations.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/siimage.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/siimage.c
+++ linux-2.6/drivers/ide/pci/siimage.c
@@ -492,7 +492,7 @@ static void proc_reports_siimage (struct
  
 static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
 {
-	unsigned long bar5	= pci_resource_start(dev, 5);
+	resource_size_t bar5	= pci_resource_start(dev, 5);
 	unsigned long barsize	= pci_resource_len(dev, 5);
 	u8 tmpbyte	= 0;
 	void __iomem *ioaddr;
