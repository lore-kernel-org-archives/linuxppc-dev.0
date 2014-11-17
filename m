Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E2431A1E93
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 20:41:09 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 14/16] arm/PCI: Introduce pci_get_domain_nr()
Date: Mon, 17 Nov 2014 18:21:48 +0800
Message-ID: <1416219710-26088-15-git-send-email-wangyijing@huawei.com>
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
 arch/arm/include/asm/mach/pci.h |    9 +++++++++
 arch/arm/kernel/bios32.c        |    8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index f19f627..370b3bd 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -90,6 +90,15 @@ extern void pci_map_io_early(unsigned long pfn);
 static inline void pci_map_io_early(unsigned long pfn) {}
 #endif
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+int pci_get_domain_nr(struct device *parent)
+#else
+static inline int pci_get_domain_nr(struct device *parent)
+{
+	return 0;
+}
+#endif
+
 /*
  * PCI controllers
  */
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d8c2b4e..3fe56f1 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -513,7 +513,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 static bool dt_domain_found;
 
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+int pci_get_domain_nr(struct device *parent)
 {
 	int domain = of_get_pci_domain_nr(parent->of_node);
 
@@ -526,8 +526,12 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 	} else {
 		domain = pci_get_new_domain_nr();
 	}
+	return domain;
+}
 
-	bus->domain_nr = domain;
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = pci_get_domain_nr(parent);
 }
 #endif
 
-- 
1.7.1
