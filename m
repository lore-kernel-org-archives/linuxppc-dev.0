Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E12EDDEA2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 17:09:22 +1100 (EST)
Subject: patch msi-remove-msi_lock.patch added to gregkh-2.6 tree
To: greg@kroah.com, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, gregkh@suse.de, grundler@parisc-linux.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	michael@ellerman.id.au, mingo@elte.hu, shaohua.li@intel.com,
	tony.luck@intel.com
From: <gregkh@suse.de>
Date: Wed, 31 Jan 2007 22:08:19 -0800
In-Reply-To: <m18xfnq6lm.fsf_-_@ebiederm.dsl.xmission.com>
Message-Id: <20070201060916.C0D2CB9DC74@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: msi: Remove msi_lock.

to my gregkh-2.6 tree.  Its filename is

     msi-remove-msi_lock.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From owner-linux-pci@atrey.karlin.mff.cuni.cz  Wed Jan 31 21:59:53 2007
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 12:44:21 -0700
Subject: msi: Remove msi_lock.
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>, Michael Ellerman <michael@ellerman.id.au>, Grant Grundler <grundler@parisc-linux.org>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <m18xfnq6lm.fsf_-_@ebiederm.dsl.xmission.com>



With the removal of msi_lookup_irq all of the functions using msi_lock
operated on a single device and none of them could reasonably be
called on that device at the same time. 

Since what little synchronization that needs to happen needs to happen
outside of the msi functions, msi_lock could never be contended and as
such is useless and just complicates the code.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -24,7 +24,6 @@
 #include "pci.h"
 #include "msi.h"
 
-static DEFINE_SPINLOCK(msi_lock);
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
 static struct kmem_cache* msi_cachep;
 
@@ -196,11 +195,7 @@ static struct msi_desc* alloc_msi_entry(
 
 static void attach_msi_entry(struct msi_desc *entry, int irq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
 	msi_desc[irq] = entry;
-	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
 static int create_msi_irq(void)
@@ -672,7 +667,6 @@ void pci_disable_msi(struct pci_dev* dev
 	struct msi_desc *entry;
 	int pos, default_irq;
 	u16 control;
-	unsigned long flags;
 
 	if (!pci_msi_enable)
 		return;
@@ -693,21 +687,17 @@ void pci_disable_msi(struct pci_dev* dev
 
 	disable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 
-	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[dev->first_msi_irq];
 	if (!entry || !entry->dev || entry->msi_attrib.type != PCI_CAP_ID_MSI) {
-		spin_unlock_irqrestore(&msi_lock, flags);
 		return;
 	}
 	if (irq_has_action(dev->first_msi_irq)) {
-		spin_unlock_irqrestore(&msi_lock, flags);
 		printk(KERN_WARNING "PCI: %s: pci_disable_msi() called without "
 		       "free_irq() on MSI irq %d\n",
 		       pci_name(dev), dev->first_msi_irq);
 		BUG_ON(irq_has_action(dev->first_msi_irq));
 	} else {
 		default_irq = entry->msi_attrib.default_irq;
-		spin_unlock_irqrestore(&msi_lock, flags);
 		msi_free_irq(dev, dev->first_msi_irq);
 
 		/* Restore dev->irq to its default pin-assertion irq */
@@ -721,14 +711,11 @@ static int msi_free_irq(struct pci_dev* 
 	struct msi_desc *entry;
 	int head, entry_nr, type;
 	void __iomem *base;
-	unsigned long flags;
 
 	arch_teardown_msi_irq(irq);
 
-	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[irq];
 	if (!entry || entry->dev != dev) {
-		spin_unlock_irqrestore(&msi_lock, flags);
 		return -EINVAL;
 	}
 	type = entry->msi_attrib.type;
@@ -739,7 +726,6 @@ static int msi_free_irq(struct pci_dev* 
 	msi_desc[entry->link.tail]->link.head = entry->link.head;
 	entry->dev = NULL;
 	msi_desc[irq] = NULL;
-	spin_unlock_irqrestore(&msi_lock, flags);
 
 	destroy_msi_irq(irq);
 
@@ -817,7 +803,6 @@ int pci_enable_msix(struct pci_dev* dev,
 void pci_disable_msix(struct pci_dev* dev)
 {
 	int irq, head, tail = 0, warning = 0;
-	unsigned long flags;
 	int pos;
 	u16 control;
 
@@ -841,9 +826,7 @@ void pci_disable_msix(struct pci_dev* de
 
 	irq = head = dev->first_msi_irq;
 	while (head != tail) {
-		spin_lock_irqsave(&msi_lock, flags);
 		tail = msi_desc[irq]->link.tail;
-		spin_unlock_irqrestore(&msi_lock, flags);
 		if (irq_has_action(irq))
 			warning = 1;
 		else if (irq != head)	/* Release MSI-X irq */
@@ -872,7 +855,6 @@ void pci_disable_msix(struct pci_dev* de
 void msi_remove_pci_irq_vectors(struct pci_dev* dev)
 {
 	int pos;
-	unsigned long flags;
 
 	if (!pci_msi_enable || !dev)
  		return;
@@ -894,10 +876,8 @@ void msi_remove_pci_irq_vectors(struct p
 
 		irq = head = dev->first_msi_irq;
 		while (head != tail) {
-			spin_lock_irqsave(&msi_lock, flags);
 			tail = msi_desc[irq]->link.tail;
 			base = msi_desc[irq]->mask_base;
-			spin_unlock_irqrestore(&msi_lock, flags);
 			if (irq_has_action(irq))
 				warning = 1;
 			else if (irq != head) /* Release MSI-X irq */


Patches currently in gregkh-2.6 which might be from greg@kroah.com are
