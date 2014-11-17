Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D07D01A0B4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:40:59 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 05/16] PCI: Use pci_scan_root_bus() instead of
 pci_scan_bus_parented()
Date: Mon, 17 Nov 2014 18:21:39 +0800
Message-ID: <1416219710-26088-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, Suravee.Suthikulpanit@amd.com,
 Yijing Wang <wangyijing@huawei.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we can remove the deprecated pci_scan_bus_parented(),
and use pci_scan_root_bus() instead.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c        |   19 -------------------
 drivers/pci/xen-pcifront.c |    6 +++---
 include/linux/pci.h        |    2 --
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 97711f3..623bfff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2105,25 +2105,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-/* Deprecated; use pci_scan_root_bus() instead */
-struct pci_bus *pci_scan_bus_parented(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (b)
-		pci_scan_child_bus(b);
-	else
-		pci_free_resource_list(&resources);
-	return b;
-}
-EXPORT_SYMBOL(pci_scan_bus_parented);
-
 /**
  * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
  * @bridge: PCI bridge for the bus to scan
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 116ca37..fa2e312 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -474,8 +474,8 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd);
+	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
+				  &pcifront_bus_ops, sd, NULL);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
@@ -488,7 +488,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
-	/* pci_scan_bus_parented skips devices which do not have a have
+	/* pci_scan_root_bus skips devices which do not have a have
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
 	err = pcifront_scan_bus(pdev, domain, bus, b);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f8045d6..4daef65 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -767,8 +767,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
-- 
1.7.1
