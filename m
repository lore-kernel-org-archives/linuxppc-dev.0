Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:35 +1000
Subject: [RFC/PATCH 2/7] Make some MSIX defines generic
In-Reply-To: <1159480412.269240.988552559176.qpush@concordia>
Message-Id: <20060928215337.A17D767C5B@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make some MSIX defines generic

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi.h        |    8 --------
 include/linux/pci_regs.h |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: to-merge/drivers/pci/msi.h
===================================================================
--- to-merge.orig/drivers/pci/msi.h
+++ to-merge/drivers/pci/msi.h
@@ -8,14 +8,6 @@
 
 #include <asm/msi.h>
 
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
Index: to-merge/include/linux/pci_regs.h
===================================================================
--- to-merge.orig/include/linux/pci_regs.h
+++ to-merge/include/linux/pci_regs.h
@@ -287,6 +287,14 @@
 #define PCI_MSI_DATA_64		12	/* 16 bits of data for 64-bit devices */
 #define PCI_MSI_MASK_BIT	16	/* Mask bits register */
 
+/* MSI-X registers */
+#define PCI_MSIX_FLAGS		2	/* Various flags */
+#define  PCI_MSIX_FLAGS_ENABLE	0x8000	/* MSI-X feature enabled */
+#define  PCI_MSIX_FLAGS_FNMASK	0x4000	/* Mask entire function */
+#define  PCI_MSIX_FLAGS_QSIZE	0x07FF	/* Number of MSI-X available */
+#define  PCI_MSIX_FLAGS_BIRMASK	0x0007	/* BIR */
+#define  PCI_MSIX_FLAGS_BITMASK	0x0001	/* ??? */
+
 /* CompactPCI Hotswap Register */
 
 #define PCI_CHSWP_CSR		2	/* Control and Status Register */
