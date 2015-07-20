Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286241A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 22:13:28 +1000 (AEST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, Russell King
 <linux@arm.linux.org.uk>, <dja@axtens.net>,
 <linux-xtensa@linux-xtensa.org>, <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, <linux-mips@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rusty Russell <rusty@rustcorp.com.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
 <linux-ia64@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-am33-list@redhat.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Yijing Wang
 <wangyijing@huawei.com>
Subject: [PATCH part3 v12 02/10] PCI: Move pci_bus_assign_domain_nr()
 declaration into drivers/pci/pci.h
Date: Mon, 20 Jul 2015 20:01:10 +0800
Message-ID: <1437393678-4077-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
References: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_bus_assign_domain_nr() is only called in probe.c,
Move pci_bus_assign_domain_nr() declaration into
drivers/pci/pci.h.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.h   |    9 +++++++++
 include/linux/pci.h |    6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4ff0ff1..02192aa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,4 +335,13 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
+#else
+static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
+					struct device *parent)
+{
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 50c0c47..f7e4204 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1337,12 +1337,6 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
-#else
-static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
-					struct device *parent)
-{
-}
 #endif
 
 /* some architectures require additional setup to direct VGA traffic */
-- 
1.7.1
