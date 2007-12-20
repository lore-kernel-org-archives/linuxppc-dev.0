Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27EE3DDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:41:49 +1100 (EST)
Subject: patch
	pci-fix-warning-in-setup-res.c-on-32-bit-platforms-with-64-bit-resources.patch
	added to gregkh-2.6 tree
To: benh@kernel.crashing.org, greg@kroah.com, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
From: <gregkh@suse.de>
Date: Thu, 20 Dec 2007 15:37:17 -0800
In-Reply-To: <20071210063217.292B5DDE27@ozlabs.org>
Message-ID: <11981938373542@kroah.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: PCI: Fix warning in setup-res.c on 32-bit platforms with 64-bit resources

to my gregkh-2.6 tree.  Its filename is

     pci-fix-warning-in-setup-res.c-on-32-bit-platforms-with-64-bit-resources.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From benh@ozlabs.org Sun Dec  9 22:32:23 2007
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 10 Dec 2007 17:32:16 +1100
Subject: PCI: Fix warning in setup-res.c on 32-bit platforms with 64-bit resources
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
Message-ID: <20071210063217.292B5DDE27@ozlabs.org>


This adds appropriate casts to avoid a warning and print the correct
values in pr_debug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/setup-res.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -51,10 +51,12 @@ pci_update_resource(struct pci_dev *dev,
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	pr_debug("  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
+	pr_debug("  got res [%llx:%llx] bus [%llx:%llx] flags %lx for "
 		 "BAR %d of %s\n", (unsigned long long)res->start,
 		 (unsigned long long)res->end,
-		 region.start, region.end, res->flags, resno, pci_name(dev));
+		 (unsigned long long)region.start,
+		 (unsigned long long)region.end,
+		 (unsigned long)res->flags, resno, pci_name(dev));
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
 	if (res->flags & IORESOURCE_IO)


Patches currently in gregkh-2.6 which might be from benh@kernel.crashing.org are

bad/battery-class-driver.patch
driver/adb-convert-from-class_device-to-device.patch
driver/kobject-convert-hvc_console-to-use-kref-not-kobject.patch
driver/kobject-convert-hvcs-to-use-kref-not-kobject.patch
driver/kobject-convert-icom-to-use-kref-not-kobject.patch
pci/pci-fix-bus-resource-assignment-on-32-bits-with-64b-resources.patch
pci/pci-fix-warning-in-setup-res.c-on-32-bit-platforms-with-64-bit-resources.patch
usb/usb-remove-ohci-useless-masking-unmasking-of-wdh-interrupt.patch
