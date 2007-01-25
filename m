Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:08 +1100
Subject: [RFC/PATCH 3/16] Combine pci_(save|restore)_msi/msix_state
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083409.D4EBADE25B@ozlabs.org>
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

The PCI save/restore code doesn't need to care about MSI vs MSI-X, all
it really wants is to say "save/restore all MSI(-X) info for this device".

This is borne out in the code, we call the MSI and MSI-X save routines
side by side, and similarly with the restore routines.

So combine the MSI/MSI-X routines into pci_save_msi_state() and
pci_restore_msi_state(). It is up to those routines to decide what state
needs to be saved.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi.c |   27 +++++++++++++++++++++++----
 drivers/pci/pci.c |    4 +---
 drivers/pci/pci.h |    6 ++----
 3 files changed, 26 insertions(+), 11 deletions(-)

Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c
+++ msi/drivers/pci/msi.c
@@ -294,7 +294,7 @@ static int msi_lookup_irq(struct pci_dev
 }
 
 #ifdef CONFIG_PM
-int pci_save_msi_state(struct pci_dev *dev)
+static int __pci_save_msi_state(struct pci_dev *dev)
 {
 	int pos, i = 0;
 	u16 control;
@@ -332,7 +332,7 @@ int pci_save_msi_state(struct pci_dev *d
 	return 0;
 }
 
-void pci_restore_msi_state(struct pci_dev *dev)
+static void __pci_restore_msi_state(struct pci_dev *dev)
 {
 	int i = 0, pos;
 	u16 control;
@@ -360,7 +360,7 @@ void pci_restore_msi_state(struct pci_de
 	kfree(save_state);
 }
 
-int pci_save_msix_state(struct pci_dev *dev)
+static int __pci_save_msix_state(struct pci_dev *dev)
 {
 	int pos;
 	int temp;
@@ -408,7 +408,20 @@ int pci_save_msix_state(struct pci_dev *
 	return 0;
 }
 
-void pci_restore_msix_state(struct pci_dev *dev)
+int pci_save_msi_state(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = __pci_save_msi_state(dev);
+	if (rc)
+		return rc;
+
+	rc = __pci_save_msix_state(dev);
+
+	return rc;
+}
+
+static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	u16 save;
 	int pos;
@@ -445,6 +458,12 @@ void pci_restore_msix_state(struct pci_d
 	pci_write_config_word(dev, msi_control_reg(pos), save);
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
 }
+
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	__pci_restore_msi_state(dev);
+	__pci_restore_msix_state(dev);
+}
 #endif
 
 /**
Index: msi/drivers/pci/pci.c
===================================================================
--- msi.orig/drivers/pci/pci.c
+++ msi/drivers/pci/pci.c
@@ -632,8 +632,6 @@ pci_save_state(struct pci_dev *dev)
 		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
 	if ((i = pci_save_msi_state(dev)) != 0)
 		return i;
-	if ((i = pci_save_msix_state(dev)) != 0)
-		return i;
 	if ((i = pci_save_pcie_state(dev)) != 0)
 		return i;
 	if ((i = pci_save_pcix_state(dev)) != 0)
@@ -671,7 +669,7 @@ pci_restore_state(struct pci_dev *dev)
 	}
 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
-	pci_restore_msix_state(dev);
+
 	return 0;
 }
 
Index: msi/drivers/pci/pci.h
===================================================================
--- msi.orig/drivers/pci/pci.h
+++ msi/drivers/pci/pci.h
@@ -52,17 +52,15 @@ void pci_no_msi(void);
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
 static inline void pci_no_msi(void) { }
 #endif
+
 #if defined(CONFIG_PCI_MSI) && defined(CONFIG_PM)
 int pci_save_msi_state(struct pci_dev *dev);
-int pci_save_msix_state(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
-void pci_restore_msix_state(struct pci_dev *dev);
 #else
 static inline int pci_save_msi_state(struct pci_dev *dev) { return 0; }
-static inline int pci_save_msix_state(struct pci_dev *dev) { return 0; }
 static inline void pci_restore_msi_state(struct pci_dev *dev) {}
-static inline void pci_restore_msix_state(struct pci_dev *dev) {}
 #endif
+
 static inline int pci_no_d1d2(struct pci_dev *dev)
 {
 	unsigned int parent_dstates = 0;
