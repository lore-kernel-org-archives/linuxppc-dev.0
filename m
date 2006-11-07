Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:21 +1100
Subject: [RFC/PATCH 2/7] Make some MSI-X #defines generic
In-Reply-To: <1162884080.585336.70559261997.qpush@cradle>
Message-Id: <20061107072123.CF52F67C35@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move some MSI-X #defines into pci_regs.h so they can be used
outside of drivers/pci.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi.h        |    8 --------
 include/linux/pci_regs.h |    6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

Index: msi/drivers/pci/msi.h
===================================================================
--- msi.orig/drivers/pci/msi.h
+++ msi/drivers/pci/msi.h
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
Index: msi/include/linux/pci_regs.h
===================================================================
--- msi.orig/include/linux/pci_regs.h
+++ msi/include/linux/pci_regs.h
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
