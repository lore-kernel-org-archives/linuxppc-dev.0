Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD7C51A040E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:26:15 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 12/27] x86/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Wed, 15 Oct 2014 11:07:00 +0800
Message-ID: <1413342435-7876-13-git-send-email-wangyijing@huawei.com>
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
 arch/x86/include/asm/pci.h     |   13 +++++++++++++
 arch/x86/kernel/apic/io_apic.c |   19 +++++++++++++++++++
 arch/x86/pci/acpi.c            |    1 +
 arch/x86/pci/common.c          |    3 +++
 4 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 0892ea0..f41b58a 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -20,6 +20,9 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
 };
 
 extern int pci_routeirq;
@@ -41,6 +44,15 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif
 
+#ifdef CONFIG_PCI_MSI
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+
+	return sd->msi_chip;
+}
+#endif
+
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
@@ -101,6 +113,7 @@ void native_teardown_msi_irq(unsigned int irq);
 void native_restore_msi_irqs(struct pci_dev *dev);
 int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 		  unsigned int irq_base, unsigned int irq_offset);
+extern struct msi_chip *x86_msi_chip;
 #else
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 29290f5..ec79b38 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3227,11 +3227,30 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return 0;
 }
 
+static int __native_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
+{
+	return native_setup_msi_irqs(dev, nvec, type);
+}
+
 void native_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
 
+static void __native_teardown_msi_irq(struct msi_chip *chip,
+		unsigned int irq)
+{
+	native_teardown_msi_irq(irq);
+}
+
+static struct msi_chip native_msi_chip = {
+	.setup_irqs = __native_setup_msi_irqs,
+	.teardown_irq = __native_teardown_msi_irq,
+};
+
+struct msi_chip *x86_msi_chip = &native_msi_chip;
+
 #ifdef CONFIG_DMAR_TABLE
 static int
 dmar_msi_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index cfd1b13..6341d6d 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -508,6 +508,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	sd = &info->sd;
 	sd->domain = domain;
+	sd->msi_chip = x86_msi_chip;
 	sd->node = node;
 	sd->companion = device;
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 7b20bcc..0b2319a 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -468,6 +468,9 @@ void pcibios_scan_root(int busnum)
 		return;
 	}
 	sd->node = x86_pci_root_bus_node(busnum);
+#ifdef CONFIG_PCI_MSI
+	sd->msi_chip = x86_msi_chip;
+#endif
 	x86_pci_root_bus_resources(busnum, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
 	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
-- 
1.7.1
