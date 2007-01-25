Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A60BADDFA2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:34:03 +1100 (EST)
Subject: patch msi-abstract-msi-suspend.patch added to gregkh-2.6 tree
To: michael@ellerman.id.au, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, greg@kroah.com, gregkh@suse.de,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, shaohua.li@intel.com
From: <gregkh@suse.de>
Date: Thu, 25 Jan 2007 14:33:05 -0800
In-Reply-To: <20070125083410.631EEDE277@ozlabs.org>
Message-Id: <20070125223357.5AD0FB7967C@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: MSI: Abstract MSI suspend

to my gregkh-2.6 tree.  Its filename is

     msi-abstract-msi-suspend.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From michael@ozlabs.org  Thu Jan 25 14:14:57 2007
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:09 +1100
Subject: MSI: Abstract MSI suspend
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg Kroah-Hartman <greg@kroah.com>, Eric W. Biederman <ebiederm@xmission.com>, David S. Miller <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>
Message-ID: <20070125083410.631EEDE277@ozlabs.org>

Currently pci_disable_device() disables MSI on a device by twiddling
bits in config space via disable_msi_mode().

On some platforms that may not be appropriate, so abstract the MSI
suspend logic into pci_disable_device_msi().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c |   11 +++++++++++
 drivers/pci/pci.c |    7 +------
 drivers/pci/pci.h |    2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -272,6 +272,17 @@ void disable_msi_mode(struct pci_dev *de
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
--- gregkh-2.6.orig/drivers/pci/pci.c
+++ gregkh-2.6/drivers/pci/pci.c
@@ -772,12 +772,7 @@ pci_disable_device(struct pci_dev *dev)
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
--- gregkh-2.6.orig/drivers/pci/pci.h
+++ gregkh-2.6/drivers/pci/pci.h
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
 


Patches currently in gregkh-2.6 which might be from michael@ellerman.id.au are
