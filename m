Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B4C31A0981
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:40:57 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support default
 IO/MEM resources
Date: Mon, 17 Nov 2014 18:21:35 +0800
Message-ID: <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Yijing Wang <wangyijing0307@gmail.com>, Suravee.Suthikulpanit@amd.com,
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

From: Yijing Wang <wangyijing0307@gmail.com>

Pci_scan_root_bus(), pci_scan_bus() and pci_scan_bus_parented()
are very similar. But the latter two use the default
io/mem resources. Enhance pci_scan_root_bus() to support
default io/mem resources, then we could use
pci_scan_root_bus() instead of them, and clean them up.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5ed9930..fc99e88 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2069,15 +2069,23 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	struct pci_host_bridge_window *window;
 	bool found = false;
 	struct pci_bus *b;
+	LIST_HEAD(default_res);
 	int max;
 
-	list_for_each_entry(window, resources, list)
-		if (window->res->flags & IORESOURCE_BUS) {
-			found = true;
-			break;
-		}
+	if (!resources) {
+		pci_add_resource(&default_res, &ioport_resource);
+		pci_add_resource(&default_res, &iomem_resource);
+		pci_add_resource(&default_res, &busn_resource);
+	} else {
+		list_for_each_entry(window, resources, list)
+			if (window->res->flags & IORESOURCE_BUS) {
+				found = true;
+				break;
+			}
+	}
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, 
+			resources ? resources : &default_res);
 	if (!b)
 		return NULL;
 
-- 
1.7.1
