Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:08 +1100
Subject: [RFC/PATCH 2/16] Remove pci_scan_msi_device()
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083409.5E9F0DE257@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_scan_msi_device() doesn't do anything anymore, so remove it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/pci_64.c |    2 --
 drivers/pci/msi.c            |    6 ------
 drivers/pci/probe.c          |    1 -
 include/linux/pci.h          |    2 --
 4 files changed, 11 deletions(-)

Index: msi/arch/powerpc/kernel/pci_64.c
===================================================================
--- msi.orig/arch/powerpc/kernel/pci_64.c
+++ msi/arch/powerpc/kernel/pci_64.c
@@ -381,8 +381,6 @@ struct pci_dev *of_create_pci_dev(struct
 
 	pci_device_add(dev, bus);
 
-	/* XXX pci_scan_msi_device(dev); */
-
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c
+++ msi/drivers/pci/msi.c
@@ -293,12 +293,6 @@ static int msi_lookup_irq(struct pci_dev
 	return -EACCES;
 }
 
-void pci_scan_msi_device(struct pci_dev *dev)
-{
-	if (!dev)
-		return;
-}
-
 #ifdef CONFIG_PM
 int pci_save_msi_state(struct pci_dev *dev)
 {
Index: msi/drivers/pci/probe.c
===================================================================
--- msi.orig/drivers/pci/probe.c
+++ msi/drivers/pci/probe.c
@@ -902,7 +902,6 @@ pci_scan_single_device(struct pci_bus *b
 		return NULL;
 
 	pci_device_add(dev, bus);
-	pci_scan_msi_device(dev);
 
 	return dev;
 }
Index: msi/include/linux/pci.h
===================================================================
--- msi.orig/include/linux/pci.h
+++ msi/include/linux/pci.h
@@ -622,7 +622,6 @@ struct msix_entry {
 
 
 #ifndef CONFIG_PCI_MSI
-static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void pci_disable_msi(struct pci_dev *dev) {}
 static inline int pci_enable_msix(struct pci_dev* dev,
@@ -630,7 +629,6 @@ static inline int pci_enable_msix(struct
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
-extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_disable_msi(struct pci_dev *dev);
 extern int pci_enable_msix(struct pci_dev* dev,
