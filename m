Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:09 +1100
Subject: [RFC/PATCH 4/16] Abstract MSI suspend
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083410.631EEDE277@ozlabs.org>
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

Currently pci_disable_device() disables MSI on a device by twiddling
bits in config space via disable_msi_mode().

On some platforms that may not be appropriate, so abstract the MSI
suspend logic into pci_disable_device_msi().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi.c |   11 +++++++++++
 drivers/pci/pci.c |    7 +------
 drivers/pci/pci.h |    2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)

Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c
+++ msi/drivers/pci/msi.c
@@ -271,6 +271,17 @@ void disable_msi_mode(struct pci_dev *de
 	pci_intx(dev, 1);  /* enable intx */
 }
 
+void pci_disable_device_msi(struct pci_dev *dev)
+{
+	if (dev->msi_enabled)
+		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+			PCI_CAP_ID_MSI);
+
+	if (dev->msix_enabled)
+		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+			PCI_CAP_ID_MSIX);
+}
+
 static int msi_lookup_irq(struct pci_dev *dev, int type)
 {
 	int irq;
Index: msi/drivers/pci/pci.c
===================================================================
--- msi.orig/drivers/pci/pci.c
+++ msi/drivers/pci/pci.c
@@ -770,12 +770,7 @@ pci_disable_device(struct pci_dev *dev)
 	if (atomic_sub_return(1, &dev->enable_cnt) != 0)
 		return;
 
-	if (dev->msi_enabled)
-		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
-			PCI_CAP_ID_MSI);
-	if (dev->msix_enabled)
-		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
-			PCI_CAP_ID_MSIX);
+	pci_disable_device_msi(dev);
 
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
Index: msi/drivers/pci/pci.h
===================================================================
--- msi.orig/drivers/pci/pci.h
+++ msi/drivers/pci/pci.h
@@ -47,9 +47,11 @@ extern unsigned int pci_pm_d3_delay;
 
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
+extern void pci_disable_device_msi(struct pci_dev *dev);
 void pci_no_msi(void);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
+static inline void pci_disable_device_msi(struct pci_dev *dev) { }
 static inline void pci_no_msi(void) { }
 #endif
 
