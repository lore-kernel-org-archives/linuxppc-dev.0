Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 18:09:16 +1100
Message-Id: <1134457757.6989.195.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PCI: Export pci_cfg_space_size
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc PCI code sets up the PCI tree without doing config space
accesses in most cases, from the firmware tree. However, it still wants
to call pci_cfg_space_size() under some conditions, thus it needs to
be made non-static (though I don't see a point to export it to modules).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Greg: I don't remember if I already sent you that patch or not, if not,
then heh, here it is :) The powerpc patch that requires this one will be
going next to the powerpc git tree and -mm, with a 2.6.16 target. Let me
know if there is any objection.

Paul: You need that for the new G5 support patch that I'm sending next.

Index: linux-work/drivers/pci/probe.c
===================================================================
--- linux-work.orig/drivers/pci/probe.c	2005-11-24 17:18:45.000000000 +1100
+++ linux-work/drivers/pci/probe.c	2005-12-08 10:15:41.000000000 +1100
@@ -678,7 +678,7 @@ static void pci_release_dev(struct devic
  * reading the dword at 0x100 which must either be 0 or a valid extended
  * capability header.
  */
-static int pci_cfg_space_size(struct pci_dev *dev)
+int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
Index: linux-work/include/linux/pci.h
===================================================================
--- linux-work.orig/include/linux/pci.h	2005-11-30 10:43:15.000000000 +1100
+++ linux-work/include/linux/pci.h	2005-12-08 10:16:19.000000000 +1100
@@ -515,6 +515,7 @@ int pci_scan_bridge(struct pci_bus *bus,
 
 void pci_walk_bus(struct pci_bus *top, void (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+int pci_cfg_space_size(struct pci_dev *dev);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
