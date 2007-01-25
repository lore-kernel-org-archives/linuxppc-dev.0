Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DC8ADE05B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:34:16 +1100 (EST)
Subject: patch msi-remove-pci_scan_msi_device.patch added to gregkh-2.6 tree
To: michael@ellerman.id.au, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, greg@kroah.com, gregkh@suse.de,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, shaohua.li@intel.com
From: <gregkh@suse.de>
Date: Thu, 25 Jan 2007 14:33:20 -0800
In-Reply-To: <20070125083409.5E9F0DE257@ozlabs.org>
Message-Id: <20070125223411.665E9B79237@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: MSI: Remove pci_scan_msi_device()

to my gregkh-2.6 tree.  Its filename is

     msi-remove-pci_scan_msi_device.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From owner-linux-pci@atrey.karlin.mff.cuni.cz  Thu Jan 25 14:12:48 2007
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:08 +1100
Subject: MSI: Remove pci_scan_msi_device()
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg Kroah-Hartman <greg@kroah.com>, Eric W.Biederman <ebiederm@xmission.com>, David S.Miller <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>
Message-ID: <20070125083409.5E9F0DE257@ozlabs.org>


pci_scan_msi_device() doesn't do anything anymore, so remove it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/pci_64.c |    2 --
 drivers/pci/msi.c            |    6 ------
 drivers/pci/probe.c          |    1 -
 include/linux/pci.h          |    2 --
 4 files changed, 11 deletions(-)

--- gregkh-2.6.orig/arch/powerpc/kernel/pci_64.c
+++ gregkh-2.6/arch/powerpc/kernel/pci_64.c
@@ -381,8 +381,6 @@ struct pci_dev *of_create_pci_dev(struct
 
 	pci_device_add(dev, bus);
 
-	/* XXX pci_scan_msi_device(dev); */
-
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -294,12 +294,6 @@ static int msi_lookup_irq(struct pci_dev
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
--- gregkh-2.6.orig/drivers/pci/probe.c
+++ gregkh-2.6/drivers/pci/probe.c
@@ -946,7 +946,6 @@ pci_scan_single_device(struct pci_bus *b
 		return NULL;
 
 	pci_device_add(dev, bus);
-	pci_scan_msi_device(dev);
 
 	return dev;
 }
--- gregkh-2.6.orig/include/linux/pci.h
+++ gregkh-2.6/include/linux/pci.h
@@ -626,7 +626,6 @@ struct msix_entry {
 
 
 #ifndef CONFIG_PCI_MSI
-static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void pci_disable_msi(struct pci_dev *dev) {}
 static inline int pci_enable_msix(struct pci_dev* dev,
@@ -634,7 +633,6 @@ static inline int pci_enable_msix(struct
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
-extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_disable_msi(struct pci_dev *dev);
 extern int pci_enable_msix(struct pci_dev* dev,


Patches currently in gregkh-2.6 which might be from michael@ellerman.id.au are
