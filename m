Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22A041A03F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:26:14 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
Date: Wed, 15 Oct 2014 11:06:53 +0800
Message-ID: <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Liviu Dudau <liviu@dudau.co.uk>,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Save msi chip in pci_sys_data instead of assign
msi chip to every pci bus in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pci-tegra.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3d43874..5af0525 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void tegra_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
-
-		bus->msi = &pcie->msi.chip;
-	}
-}
-
 static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(sys);
@@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 
 	memset(&hw, 0, sizeof(hw));
 
+#ifdef CONFIG_PCI_MSI
+	hw.msi_chip = &pcie->msi.chip;
+#endif
 	hw.nr_controllers = 1;
 	hw.private_data = (void **)&pcie;
 	hw.setup = tegra_pcie_setup;
 	hw.map_irq = tegra_pcie_map_irq;
-	hw.add_bus = tegra_pcie_add_bus;
 	hw.scan = tegra_pcie_scan_bus;
 	hw.ops = &tegra_pcie_ops;
 
-- 
1.7.1
