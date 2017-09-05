Return-Path: <prvs=414b27ec5=jschoenh@amazon.com>
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn2mk5ymqzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 09:22:14 +1000 (AEST)
From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
 linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] PCI: Remove unused function __pci_reset_function()
Date: Wed,  6 Sep 2017 01:21:23 +0200
Message-Id: <1504653683-11543-2-git-send-email-jschoenh@amazon.de>
In-Reply-To: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
References: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last caller of __pci_reset_function() has been removed. Remove
the function as well.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 drivers/pci/pci.c   | 35 +++--------------------------------
 include/linux/pci.h |  1 -
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fdf65a6..dabcf5a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4115,35 +4115,6 @@ static void pci_dev_restore(struct pci_dev *dev)
 }
 
 /**
- * __pci_reset_function - reset a PCI device function
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * The device function is presumed to be unused when this function is called.
- * Resetting the device will make the contents of PCI configuration space
- * random, so any caller of this must be prepared to reinitialise the
- * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
- * etc.
- *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
- */
-int __pci_reset_function(struct pci_dev *dev)
-{
-	int ret;
-
-	pci_dev_lock(dev);
-	ret = __pci_reset_function_locked(dev);
-	pci_dev_unlock(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__pci_reset_function);
-
-/**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
  * @dev: PCI device to reset
@@ -4233,8 +4204,8 @@ int pci_probe_reset_function(struct pci_dev *dev)
  *
  * This function does not just reset the PCI portion of a device, but
  * clears all the state associated with the device.  This function differs
- * from __pci_reset_function in that it saves and restores device state
- * over the reset.
+ * from __pci_reset_function_locked() in that it saves and restores device state
+ * over the reset and takes the PCI device lock.
  *
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
@@ -4269,7 +4240,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  *
  * This function does not just reset the PCI portion of a device, but
  * clears all the state associated with the device.  This function differs
- * from __pci_reset_function() in that it saves and restores device state
+ * from __pci_reset_function_locked() in that it saves and restores device state
  * over the reset.  It also differs from pci_reset_function() in that it
  * requires the PCI device lock to be held.
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4acf321..b55e0cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1066,7 +1066,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 void pcie_flr(struct pci_dev *dev);
-int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
2.10.0.1.g70cd14e
