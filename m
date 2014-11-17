Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F82E1A1E88
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:41:08 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 15/16] arm/PCI: Use pci_scan_host_bridge() instead of
 pci_scan_root_bus()
Date: Mon, 17 Nov 2014 18:21:49 +0800
Message-ID: <1416219710-26088-16-git-send-email-wangyijing@huawei.com>
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
 arch/arm/include/asm/mach/pci.h |    1 +
 arch/arm/kernel/bios32.c        |   52 +++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 370b3bd..a26eb3a 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -46,6 +46,7 @@ struct hw_pci {
 struct pci_sys_data {
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
+	u8		nr;
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
 	struct pci_bus	*bus;		/* PCI bus				*/
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 3fe56f1..535d7ec 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -426,33 +426,41 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+static int pcibios_init_resources(struct pci_host_bridge *host,
+		struct pci_host_info *info)
 {
 	int ret;
-	struct pci_host_bridge_window *window;
+	struct pci_sys_data *sys = info->arg;
+	struct pci_host_bridge_window *window, *n;
 
 	if (list_empty(&sys->resources)) {
-		pci_add_resource_offset(&sys->resources,
+		pci_add_resource_offset(&host->windows,
 			 &iomem_resource, sys->mem_offset);
+	} else {
+		list_for_each_entry_safe(window, n,
+				&sys->resources, list) {
+			list_move_tail(&window->list,
+					&host->windows);
+		}
 	}
 
-	list_for_each_entry(window, &sys->resources, list) {
+	list_for_each_entry(window, &host->windows, list) {
 		if (resource_type(window->res) == IORESOURCE_IO)
 			return 0;
 	}
 
-	sys->io_res.start = (busnr * SZ_64K) ?  : pcibios_min_io;
-	sys->io_res.end = (busnr + 1) * SZ_64K - 1;
+	sys->io_res.start = (sys->nr * SZ_64K) ?  : pcibios_min_io;
+	sys->io_res.end = (sys->nr + 1) * SZ_64K - 1;
 	sys->io_res.flags = IORESOURCE_IO;
 	sys->io_res.name = sys->io_res_name;
-	sprintf(sys->io_res_name, "PCI%d I/O", busnr);
+	sprintf(sys->io_res_name, "PCI%d I/O", sys->nr);
 
 	ret = request_resource(&ioport_resource, &sys->io_res);
 	if (ret) {
 		pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
 		return ret;
 	}
-	pci_add_resource_offset(&sys->resources, &sys->io_res,
+	pci_add_resource_offset(&host->windows, &sys->io_res,
 				sys->io_offset);
 
 	return 0;
@@ -462,8 +470,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			    struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
-	int ret;
-	int nr, busnr;
+	int ret, nr, busnr, domain;
+	struct pci_host_bridge *host;
+	struct pci_host_info info;
 
 	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
 		sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
@@ -471,6 +480,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			panic("PCI: unable to allocate sys data!");
 
 		sys->busnr   = busnr;
+		sys->nr		 = nr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
 		sys->align_resource = hw->align_resource;
@@ -482,25 +492,25 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			sys->private_data = hw->private_data[nr];
 
 		ret = hw->setup(nr, sys);
-
 		if (ret > 0) {
-			ret = pcibios_init_resources(nr, sys);
-			if (ret)  {
-				kfree(sys);
-				break;
-			}
-
+			init_pci_host_info(&info);
+			info.arg = sys;
+			info.init_res = pcibios_init_resources;
+			domain = pci_get_domain_nr(parent);
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
-			else
-				sys->bus = pci_scan_root_bus(parent, sys->busnr,
-						hw->ops, sys, &sys->resources);
+			else {
+				host = pci_scan_host_bridge(parent, 
+						PCI_DOMBUS(domain, sys->busnr),
+						hw->ops, &info);
+				if (host)
+					sys->bus = host->bus;
+			}
 
 			if (!sys->bus)
 				panic("PCI: unable to scan bus!");
 
 			busnr = sys->bus->busn_res.end + 1;
-
 			list_add(&sys->node, head);
 		} else {
 			kfree(sys);
-- 
1.7.1
