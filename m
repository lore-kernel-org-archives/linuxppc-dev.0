Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88CC11A1852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:26:36 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 23/27] arm/iop13xx/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Wed, 15 Oct 2014 11:07:11 +0800
Message-ID: <1413342435-7876-24-git-send-email-wangyijing@huawei.com>
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
 arch/arm/mach-iop13xx/include/mach/pci.h |    4 ++++
 arch/arm/mach-iop13xx/iq81340mc.c        |    3 +++
 arch/arm/mach-iop13xx/iq81340sc.c        |    5 ++++-
 arch/arm/mach-iop13xx/msi.c              |   11 +++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/pci.h b/arch/arm/mach-iop13xx/include/mach/pci.h
index 59f42b5..c87ac3a 100644
--- a/arch/arm/mach-iop13xx/include/mach/pci.h
+++ b/arch/arm/mach-iop13xx/include/mach/pci.h
@@ -11,6 +11,10 @@ void iop13xx_atu_select(struct hw_pci *plat_pci);
 void iop13xx_pci_init(void);
 void iop13xx_map_pci_memory(void);
 
+#ifdef CONFIG_PCI_MSI
+extern struct msi_chip iop13xx_msi_chip;
+#endif
+
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9cd07d3..1f499b6 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -59,6 +59,9 @@ static struct hw_pci iq81340mc_pci __initdata = {
 	.map_irq	= iq81340mc_pcix_map_irq,
 	.scan		= iop13xx_scan_bus,
 	.preinit	= iop13xx_pci_init,
+#ifdef CONFIG_PCI_MSI
+	.msi_chip	= &iop13xx_msi_chip,
+#endif
 };
 
 static int __init iq81340mc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index b3ec11c..8bdfdc5 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -60,7 +60,10 @@ static struct hw_pci iq81340sc_pci __initdata = {
 	.setup		= iop13xx_pci_setup,
 	.scan		= iop13xx_scan_bus,
 	.map_irq	= iq81340sc_atux_map_irq,
-	.preinit	= iop13xx_pci_init
+	.preinit	= iop13xx_pci_init,
+#ifdef CONFIG_PCI_MSI
+	.msi_chip	= &iop13xx_msi_chip,
+#endif
 };
 
 static int __init iq81340sc_pci_init(void)
diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
index e7730cf..3135a63 100644
--- a/arch/arm/mach-iop13xx/msi.c
+++ b/arch/arm/mach-iop13xx/msi.c
@@ -132,7 +132,8 @@ static struct irq_chip iop13xx_msi_chip = {
 	.irq_unmask = unmask_msi_irq,
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int iop13xx_setup_msi_irq(struct msi_chip *chip,
+		struct pci_dev *dev, struct msi_desc *desc)
 {
 	int id, irq = irq_alloc_desc_from(IRQ_IOP13XX_MSI_0, -1);
 	struct msi_msg msg;
@@ -159,7 +160,13 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	return 0;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void iop13xx_teardown_msi_irq(struct msi_chip *chip,
+		unsigned int irq)
 {
 	irq_free_desc(irq);
 }
+
+struct msi_chip iop13xx_chip = {
+	.setup_irq = iop13xx_setup_msi_irq,
+	.teardown_irq = iop13xx_teardown_msi_irq,
+};
-- 
1.7.1
