Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA8441A174B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:03:04 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 05/20] MSI: Refactor struct msi_chip to become more common
Date: Tue, 12 Aug 2014 15:25:58 +0800
Message-ID: <1407828373-24322-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>,
 Xinwei Hu <huxinwei@huawei.com>, Yijing Wang <wangyijing@huawei.com>, "H.
 Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now there are a lot of __weak arch functions in MSI code.
These functions make MSI driver complex, It's time to
refactor it. Add .restore_irq(), .setup_irqs(), .teardown_irqs()
to make msi_chip common across all platforms.
Also replace the argument "struct pci_dev" with "struct device"
to support future Non-PCI MSI device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |    4 ++--
 drivers/pci/host/pci-tegra.c        |    3 ++-
 drivers/pci/host/pcie-designware.c  |    4 ++--
 drivers/pci/host/pcie-rcar.c        |    3 ++-
 drivers/pci/msi.c                   |    4 ++--
 include/linux/msi.h                 |    7 +++++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee1f0ba..3761e52 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -129,7 +129,7 @@ static void armada_370_xp_free_msi(int hwirq)
 	mutex_unlock(&msi_used_lock);
 }
 
-static int armada_370_xp_setup_msi_irq(struct pci_dev *pdev, 
+static int armada_370_xp_setup_msi_irq(struct device *dev,
 		struct msi_desc *desc)
 {
 	struct msi_msg msg;
@@ -164,7 +164,7 @@ static void armada_370_xp_teardown_msi_irq(unsigned int irq)
 	armada_370_xp_free_msi(hwirq);
 }
 
-static int armada_370_xp_check_msi_device(struct pci_dev *dev, 
+static int armada_370_xp_check_msi_device(struct device *dev,
 		int nvec, int type)
 {
 	/* We support MSI, but not MSI-X */
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3872bc0..a2fa0ec 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1192,9 +1192,10 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_msi_setup_irq(struct pci_dev *pdev,
+static int tegra_msi_setup_irq(struct device *dev,
 			       struct msi_desc *desc)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_chip *chip = pdev->bus->msi;
 	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct msi_msg msg;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2204456..9c3816d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -342,12 +342,12 @@ static void clear_irq(unsigned int irq)
 	msi->msi_attrib.multiple = 0;
 }
 
-static int dw_msi_setup_irq(struct pci_dev *pdev,
-			struct msi_desc *desc)
+static int dw_msi_setup_irq(struct device *dev, struct msi_desc *desc)
 {
 	int irq, pos, msgvec;
 	u16 msg_ctr;
 	struct msi_msg msg;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
 
 	if (!pp) {
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 647bc9f..fa33432 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -615,9 +615,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rcar_msi_setup_irq(struct pci_dev *pdev,
+static int rcar_msi_setup_irq(struct device *dev,
 			      struct msi_desc *desc)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_chip *chip = pdev->bus->msi;
 	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 242d775..7b7abe9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -37,7 +37,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
 
-	err = chip->setup_irq(dev, desc);
+	err = chip->setup_irq(&dev->dev, desc);
 	if (err < 0)
 		return err;
 
@@ -61,7 +61,7 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (!chip || !chip->check_device)
 		return 0;
 
-	return chip->check_device(dev, nvec, type);
+	return chip->check_device(&dev->dev, nvec, type);
 }
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a510d25..2068d25 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -72,9 +72,12 @@ struct msi_chip {
 	struct device_node *of_node;
 	struct list_head list;
 
-	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
+	int (*check_device)(struct device *dev, int nvec, int type);
+	int (*setup_irq)(struct device *dev, struct msi_desc *desc);
+	int (*setup_irqs)(struct device *dev, int nvec, int type);
 	void (*teardown_irq)(unsigned int irq);
-	int (*check_device)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_irqs)(struct device *dev);
+	void (*restore_irqs)(struct device *dev);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
