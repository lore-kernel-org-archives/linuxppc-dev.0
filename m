Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77DD91A17CF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:41:14 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 16/16] powerpc/PCI: Use pci_scan_host_bridge() to scan PCI
 bus
Date: Mon, 17 Nov 2014 18:21:50 +0800
Message-ID: <1416219710-26088-17-git-send-email-wangyijing@huawei.com>
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

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/pci-common.c |   81 ++++++++++++++++++++++---------------
 1 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e5dad9a..5b0f078 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1578,54 +1578,69 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	return of_node_get(hose->dn);
 }
 
-/**
- * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
- * @hose: Pointer to the PCI host controller instance structure
- */
-void pcibios_scan_phb(struct pci_controller *hose)
+static int pcibios_host_init_res(struct pci_host_bridge *host,
+		struct pci_host_info *info)
 {
-	LIST_HEAD(resources);
-	struct pci_bus *bus;
-	struct device_node *node = hose->dn;
-	int mode;
-
-	pr_debug("PCI: Scanning PHB %s\n", of_node_full_name(node));
+	struct pci_controller *hose = info->arg;
 
 	/* Get some IO space for the new PHB */
 	pcibios_setup_phb_io_space(hose);
-
 	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose, &resources);
+	pcibios_setup_phb_resources(hose, &host->windows);
 
 	hose->busn.start = hose->first_busno;
 	hose->busn.end	 = hose->last_busno;
 	hose->busn.flags = IORESOURCE_BUS;
-	pci_add_resource(&resources, &hose->busn);
+	pci_add_resource(&host->windows, &hose->busn);
+	return 0;
+}
 
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
-				  hose->ops, hose, &resources);
-	if (bus == NULL) {
-		pr_err("Failed to create bus for PCI domain %04x\n",
-			hose->global_number);
-		pci_free_resource_list(&resources);
-		return;
-	}
-	hose->bus = bus;
+static void pcibios_of_scan_bus(struct pci_host_bridge *host)
+{
+	int mode;
+	int max;
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
-	if (node && ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
+	if (host->node && ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(host->bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
-		of_scan_bus(node, bus);
-
+		of_scan_bus(host->node, host->bus);
+	
 	if (mode == PCI_PROBE_NORMAL) {
-		pci_bus_update_busn_res_end(bus, 255);
-		hose->last_busno = pci_scan_child_bus(bus);
-		pci_bus_update_busn_res_end(bus, hose->last_busno);
+		pci_bus_update_busn_res_end(host->bus, 255);
+		max = pci_scan_child_bus(host->bus);
+		pci_bus_update_busn_res_end(host->bus, max);
+	}
+}
+/**
+ * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
+ * @hose: Pointer to the PCI host controller instance structure
+ */
+void pcibios_scan_phb(struct pci_controller *hose)
+{
+	struct pci_host_bridge *host;
+	struct pci_host_info info;
+
+	pr_debug("PCI: Scanning PHB %s\n", of_node_full_name(hose->dn));
+
+	init_pci_host_info(&info);
+	info.arg = hose;
+	info.node = hose->dn;
+	info.init_res = pcibios_host_init_res;
+	info.of_scan_bus = pcibios_of_scan_bus;
+	/* Create an empty bus for the toplevel */
+	host = pci_scan_host_bridge(hose->parent, 
+			PCI_DOMBUS(hose->global_number,hose->first_busno),
+				  hose->ops, &info);
+	if (host == NULL) {
+		pr_err("Failed to create bus for PCI domain %04x\n",
+			hose->global_number);
+		return;
 	}
+	hose->bus = host->bus;
+	hose->last_busno = host->bus->busn_res.end;
 
 	/* Platform gets a chance to do some global fixups before
 	 * we proceed to resource allocation
@@ -1634,9 +1649,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 		ppc_md.pcibios_fixup_phb(hose);
 
 	/* Configure PCI Express settings */
-	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node)
+		list_for_each_entry(child, &host->bus->children, node)
 			pcie_bus_configure_settings(child);
 	}
 }
-- 
1.7.1
