Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F361A0611
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:26:33 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 20/27] MIPS/Xlr/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Wed, 15 Oct 2014 11:07:08 +0800
Message-ID: <1413342435-7876-21-git-send-email-wangyijing@huawei.com>
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

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/pci/pci-xlr.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 0dde803..0e611de 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -149,6 +149,8 @@ static struct resource nlm_pci_io_resource = {
 	.flags		= IORESOURCE_IO,
 };
 
+static struct msi_chip xlr_msi_chip;
+
 struct pci_controller nlm_pci_controller = {
 	.index		= 0,
 	.pci_ops	= &nlm_pci_ops,
@@ -156,6 +158,9 @@ struct pci_controller nlm_pci_controller = {
 	.mem_offset	= 0x00000000UL,
 	.io_resource	= &nlm_pci_io_resource,
 	.io_offset	= 0x00000000UL,
+#ifdef CONFIG_PCI_MSI
+	.msi_chip = &xlr_msi_chip,
+#endif
 };
 
 /*
@@ -214,11 +219,13 @@ static int get_irq_vector(const struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PCI_MSI
-void arch_teardown_msi_irq(unsigned int irq)
+static void xlr_teardown_msi_irq(struct msi_chip *chip,
+		unsigned int irq)
 {
 }
 
-int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+static int xlr_setup_msi_irq(struct msi_chip *chip,
+		struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	struct pci_dev *lnk;
@@ -263,6 +270,12 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	write_msi_msg(irq, &msg);
 	return 0;
 }
+
+static struct msi_chip xlr_msi_chip = {
+	.setup_irq = xlr_setup_msi_irq,
+	.teardown_irq = xlr_teardown_msi_irq,
+};
+
 #endif
 
 /* Extra ACK needed for XLR on chip PCI controller */
-- 
1.7.1
