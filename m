Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9331A0A49
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 12:51:19 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 21/22] tile/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Thu, 25 Sep 2014 11:14:31 +0800
Message-ID: <1411614872-4009-22-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
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
 arch/tile/kernel/pci_gx.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index e39f9c5..4912b75 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -1485,7 +1485,7 @@ static struct irq_chip tilegx_msi_chip = {
 	/* TBD: support set_affinity. */
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int tile_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_controller *controller;
 	gxio_trio_context_t *trio_context;
@@ -1604,7 +1604,17 @@ is_64_failure:
 	return ret;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void tile_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
+
+static struct msi_chip tile_msi_chip = {
+	.setup_irq = tile_setup_msi_irq,
+	.teardown_irq = tile_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &tile_msi_chip;
+}
-- 
1.7.1
