Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34D5B1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 17:30:11 +1000 (AEST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH Part3 v11 4/9] PCI: Introduce pci_host_assign_domain_nr() to
 assign domain
Date: Fri, 8 May 2015 15:22:54 +0800
Message-ID: <1431069779-29346-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1431069779-29346-1-git-send-email-wangyijing@huawei.com>
References: <1431069779-29346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liviu Dudau <liviu@dudau.co.uk>, linux-ia64@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce pci_host_assign_domain_nr() to save domain number
in pci_host_bridge.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |   24 +++++++++++++++++++-----
 drivers/pci/pci.h |    1 +
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7bf27e8..46a0240 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4506,10 +4506,10 @@ static int pci_get_new_domain_nr(void)
 	return atomic_inc_return(&__domain_nr);
 }
 
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int pci_assign_domain_nr(struct device *dev)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = of_get_pci_domain_nr(dev->of_node);
 
 	/*
 	 * Check DT domain and use_dt_domains values.
@@ -4543,16 +4543,30 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
 	} else {
-		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node->full_name);
+		dev_err(dev, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
+			dev->of_node->full_name);
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = pci_assign_domain_nr(parent);
 }
 #endif
 #endif
 
+void pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain)
+{
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	host->domain = pci_assign_domain_nr(host->dev.parent);
+#else
+	host->domain = domain;
+#endif
+}
+
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bc3e79a..c2e1a6b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -334,4 +334,5 @@ static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
 }
 #endif
 
+void pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain);
 #endif /* DRIVERS_PCI_H */
-- 
1.7.1
