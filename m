Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 975C61A0BB9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 19:46:07 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Date: Fri, 5 Sep 2014 18:09:54 +0800
Message-ID: <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
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
 drivers/iommu/irq_remapping.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 33c4395..e75026e 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -148,6 +148,11 @@ static int irq_remapping_setup_msi_irqs(struct pci_dev *dev,
 		return do_setup_msix_irqs(dev, nvec);
 }
 
+static struct msi_chip remap_msi_chip = {
+	.setup_irqs = irq_remapping_setup_msi_irqs,
+	.teardown_irq = native_teardown_msi_irq,
+};
+
 static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
 {
 	/*
@@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
 	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
 	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
 	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
-	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
+	x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;
 	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
 	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
+	x86_msi_chip = &remap_msi_chip;
 }
 
 static __init int setup_nointremap(char *str)
-- 
1.7.1
