Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 505E167E82
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 05:32:09 +1100 (EST)
Subject: patch pci-make-some-msi-x-defines-generic.patch added to gregkh-2.6
	tree
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	davem@davemloft.net, ebiederm@xmission.com, greg@kroah.com,
	gregkh@suse.de, michael@ellerman.id.au, moilanen@austin.ibm.com,
	segher@kernel.crashing.org
From: <gregkh@suse.de>
Date: Mon, 13 Nov 2006 10:31:04 -0800
In-Reply-To: <20061107072123.CF52F67C35@ozlabs.org>
Message-Id: <20061113183157.5942C9D3091@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: PCI: Make some MSI-X #defines generic

to my gregkh-2.6 tree.  Its filename is

     pci-make-some-msi-x-defines-generic.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From michael@ozlabs.org Mon Nov  6 23:21:30 2006
To: <linuxppc-dev@ozlabs.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	Jake Moilanen <moilanen@austin.ibm.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Eric W. Biederman <ebiederm@xmission.com>,
	David S. Miller <davem@davemloft.net>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:21 +1100
Subject: PCI: Make some MSI-X #defines generic
Message-Id: <20061107072123.CF52F67C35@ozlabs.org>

Move some MSI-X #defines into pci_regs.h so they can be used
outside of drivers/pci.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.h        |    8 --------
 include/linux/pci_regs.h |    6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.h
+++ gregkh-2.6/drivers/pci/msi.h
@@ -6,14 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-/*
- * MSI-X Address Register
- */
-#define PCI_MSIX_FLAGS_QSIZE		0x7FF
-#define PCI_MSIX_FLAGS_ENABLE		(1 << 15)
-#define PCI_MSIX_FLAGS_BIRMASK		(7 << 0)
-#define PCI_MSIX_FLAGS_BITMASK		(1 << 0)
-
 #define PCI_MSIX_ENTRY_SIZE			16
 #define  PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET	0
 #define  PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET	4
--- gregkh-2.6.orig/include/linux/pci_regs.h
+++ gregkh-2.6/include/linux/pci_regs.h
@@ -292,6 +292,12 @@
 #define PCI_MSI_DATA_64		12	/* 16 bits of data for 64-bit devices */
 #define PCI_MSI_MASK_BIT	16	/* Mask bits register */
 
+/* MSI-X registers (these are at offset PCI_MSI_FLAGS) */
+#define PCI_MSIX_FLAGS_QSIZE	0x7FF
+#define PCI_MSIX_FLAGS_ENABLE	(1 << 15)
+#define PCI_MSIX_FLAGS_BIRMASK	(7 << 0)
+#define PCI_MSIX_FLAGS_BITMASK	(1 << 0)
+
 /* CompactPCI Hotswap Register */
 
 #define PCI_CHSWP_CSR		2	/* Control and Status Register */


Patches currently in gregkh-2.6 which might be from linuxppc-dev@ozlabs.org are

pci/pci-make-some-msi-x-defines-generic.patch
