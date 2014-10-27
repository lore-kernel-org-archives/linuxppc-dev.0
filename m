Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 320331A0304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 23:43:54 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 11/16] s390/MSI: Use MSI controller framework to configure
 MSI/MSI-X irq
Date: Mon, 27 Oct 2014 21:22:17 +0800
Message-ID: <1414416142-31239-12-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
References: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Sergei
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

Use MSI controller framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 arch/s390/include/asm/pci.h |    1 +
 arch/s390/pci/pci.c         |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c030900..bf14da2 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -88,6 +88,7 @@ struct zpci_dev {
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 
+	struct msi_controller *msi_ctrl;
 	/* IRQ stuff */
 	u64		msi_addr;	/* MSI address */
 	struct airq_iv *aibv;		/* adapter interrupt bit vector */
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 552b990..beed5ab 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -358,7 +358,15 @@ static void zpci_irq_handler(struct airq_struct *airq)
 	}
 }
 
-int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+struct msi_controller *pcibios_msi_controller(struct pci_bus *bus)
+{
+	struct zpci_dev *zpci = bus->sysdata;
+
+	return zpci->msi_ctrl;
+}
+
+static int zpci_setup_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *pdev, int nvec, int type)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
 	unsigned int hwirq, msi_vecs;
@@ -434,7 +442,8 @@ out:
 	return rc;
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *pdev)
+static void zpci_teardown_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
 	struct msi_desc *msi;
@@ -464,6 +473,11 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
 }
 
+static struct msi_controller zpci_msi_ctrl = {
+	.setup_irqs = zpci_setup_msi_irqs,
+	.teardown_irqs = zpci_teardown_msi_irqs,
+};
+
 static void zpci_map_resources(struct zpci_dev *zdev)
 {
 	struct pci_dev *pdev = zdev->pdev;
@@ -749,6 +763,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
 	if (ret)
 		return ret;
 
+	zdev->msi_ctrl = &zpci_msi_ctrl;
 	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
 				      zdev, &resources);
 	if (!zdev->bus) {
-- 
1.7.1
