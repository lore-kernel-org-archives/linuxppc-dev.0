Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76E901A0B48
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:40:59 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 03/16] PCI: Clean up pci_scan_bus()
Date: Mon, 17 Nov 2014 18:21:37 +0800
Message-ID: <1416219710-26088-4-git-send-email-wangyijing@huawei.com>
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

No one uses it, clean up.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   20 --------------------
 include/linux/pci.h |    1 -
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fc99e88..0a02fc2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2125,26 +2125,6 @@ struct pci_bus *pci_scan_bus_parented(struct device *parent,
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
-					void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
-	if (b) {
-		pci_scan_child_bus(b);
-		pci_bus_add_devices(b);
-	} else {
-		pci_free_resource_list(&resources);
-	}
-	return b;
-}
-EXPORT_SYMBOL(pci_scan_bus);
-
 /**
  * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
  * @bridge: PCI bridge for the bus to scan
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5be8db4..f8045d6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -769,7 +769,6 @@ struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
 				      struct pci_ops *ops, void *sysdata);
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
-- 
1.7.1
