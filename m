Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 552FCDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 17:08:55 +1100 (EST)
Subject: patch msi-fix-msi_remove_pci_irq_vectors.patch added to gregkh-2.6
	tree
To: greg@kroah.com, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, gregkh@suse.de, grundler@parisc-linux.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	michael@ellerman.id.au, mingo@elte.hu, shaohua.li@intel.com,
	tony.luck@intel.com
From: <gregkh@suse.de>
Date: Wed, 31 Jan 2007 22:07:38 -0800
In-Reply-To: <m14pqbq6j1.fsf_-_@ebiederm.dsl.xmission.com>
Message-Id: <20070201060836.8ADC0B9DF4F@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: msi: Fix msi_remove_pci_irq_vectors.

to my gregkh-2.6 tree.  Its filename is

     msi-fix-msi_remove_pci_irq_vectors.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From owner-linux-pci@atrey.karlin.mff.cuni.cz  Wed Jan 31 22:00:21 2007
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 12:45:54 -0700
Subject: msi: Fix msi_remove_pci_irq_vectors.
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>, Michael Ellerman <michael@ellerman.id.au>, Grant Grundler <grundler@parisc-linux.org>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <m14pqbq6j1.fsf_-_@ebiederm.dsl.xmission.com>

Since msi_remove_pci_irq_vectors is designed to be called during
hotplug remove it is actively wrong to query the hardware and expect
meaningful results back.

To that end remove the pci_find_capability calls.  Testing
dev->msi_enabled and dev->msix_enabled gives us all of the information
we need.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -854,13 +854,10 @@ void pci_disable_msix(struct pci_dev* de
  **/
 void msi_remove_pci_irq_vectors(struct pci_dev* dev)
 {
-	int pos;
-
 	if (!pci_msi_enable || !dev)
  		return;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos > 0 && dev->msi_enabled) {
+	if (dev->msi_enabled) {
 		if (irq_has_action(dev->first_msi_irq)) {
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on MSI irq %d\n",
@@ -869,8 +866,7 @@ void msi_remove_pci_irq_vectors(struct p
 		} else /* Release MSI irq assigned to this device */
 			msi_free_irq(dev, dev->first_msi_irq);
 	}
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos > 0 && dev->msix_enabled) {
+	if (dev->msix_enabled) {
 		int irq, head, tail = 0, warning = 0;
 		void __iomem *base = NULL;
 


Patches currently in gregkh-2.6 which might be from greg@kroah.com are
