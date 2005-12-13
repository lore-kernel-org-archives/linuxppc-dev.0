Return-Path: <gregkh@suse.de>
To: benh@kernel.crashing.org, greg@kroah.com, gregkh@suse.de,
	linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org, paulus@samba.org
From: <gregkh@suse.de>
Date: Tue, 13 Dec 2005 11:48:48 -0800
In-Reply-To: <1134457757.6989.195.camel@gaston>
Message-ID: <1EmG8m-7MQ-00@press.kroah.org>
Subject: patch pci-export-pci_cfg_space_size.patch added to gregkh-2.6 tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH] PCI: Export pci_cfg_space_size

to my gregkh-2.6 tree.  Its filename is

     pci-export-pci_cfg_space_size.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from benh@kernel.crashing.org are

i2c/i2c-drop-driver-owner-and-name-04-macintosh.patch
pci/pci-export-pci_cfg_space_size.patch


>From benh@kernel.crashing.org Mon Dec 12 23:16:21 2005
Subject: [PATCH] PCI: Export pci_cfg_space_size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Tue, 13 Dec 2005 18:09:16 +1100
Message-Id: <1134457757.6989.195.camel@gaston>

The powerpc PCI code sets up the PCI tree without doing config space
accesses in most cases, from the firmware tree. However, it still wants
to call pci_cfg_space_size() under some conditions, thus it needs to
be made non-static (though I don't see a point to export it to modules).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/probe.c |    2 +-
 include/linux/pci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/pci/probe.c
+++ gregkh-2.6/drivers/pci/probe.c
@@ -717,7 +717,7 @@ static void pci_release_dev(struct devic
  * reading the dword at 0x100 which must either be 0 or a valid extended
  * capability header.
  */
-static int pci_cfg_space_size(struct pci_dev *dev)
+int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
--- gregkh-2.6.orig/include/linux/pci.h
+++ gregkh-2.6/include/linux/pci.h
@@ -514,6 +514,7 @@ int pci_scan_bridge(struct pci_bus *bus,
 
 void pci_walk_bus(struct pci_bus *top, void (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+int pci_cfg_space_size(struct pci_dev *dev);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
