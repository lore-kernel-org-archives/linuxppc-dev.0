Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 343181A0148
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 17:30:11 +1000 (AEST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH Part3 v11 7/9] PCI: Create pci host bridge prior to root bus
Date: Fri, 8 May 2015 15:22:57 +0800
Message-ID: <1431069779-29346-8-git-send-email-wangyijing@huawei.com>
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

Pci_host_bridge hold the domain number, we need
to assign domain number prior to root bus creation,
because root bus need to know the domain number
to check whether it's alreay exist.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   60 ++++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ed8ab7..e4ef791 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -515,7 +515,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
+static struct pci_host_bridge *pci_alloc_host_bridge(void)
 {
 	struct pci_host_bridge *bridge;
 
@@ -524,7 +524,6 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
-	bridge->bus = b;
 	return bridge;
 }
 
@@ -1902,48 +1901,51 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 {
 	int error;
 	struct pci_host_bridge *bridge;
-	struct pci_bus *b, *b2;
+	struct pci_bus *b;
 	struct resource_entry *window, *n;
 	struct resource *res;
 	resource_size_t offset;
 	char bus_addr[64];
 	char *fmt;
 
-	b = pci_alloc_bus(NULL);
-	if (!b)
-		return NULL;
-
-	b->sysdata = sysdata;
-	b->ops = ops;
-	b->number = b->busn_res.start = bus;
-	pci_bus_assign_domain_nr(b, parent);
-	b2 = pci_find_bus(pci_domain_nr(b), bus);
-	if (b2) {
-		/* If we already got to this bus through a different bridge, ignore it */
-		dev_dbg(&b2->dev, "bus already known\n");
-		goto err_out;
-	}
-
-	bridge = pci_alloc_host_bridge(b);
+	bridge = pci_alloc_host_bridge();
 	if (!bridge)
-		goto err_out;
+		return NULL;
 
-	bridge->domain = domain;
 	bridge->dev.parent = parent;
+	pci_host_assign_domain_nr(bridge, domain);
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_drvdata(&bridge->dev, sysdata);
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	dev_set_name(&bridge->dev, "pci%04x:%02x", bridge->domain, bus);
 	error = pcibios_root_bridge_prepare(bridge);
 	if (error) {
 		kfree(bridge);
-		goto err_out;
+		return NULL;
 	}
 
 	error = device_register(&bridge->dev);
 	if (error) {
 		put_device(&bridge->dev);
-		goto err_out;
+		return NULL;
 	}
+
+	b = pci_find_bus(bridge->domain, bus);
+	if (b) {
+		/* If we already got to this bus through a different bridge, ignore it */
+		dev_dbg(&b->dev, "bus already known\n");
+		goto unregister_host;
+	}
+
+	b = pci_alloc_bus(NULL);
+	if (!b)
+		goto unregister_host;
+
+	bridge->bus = b;
+	b->sysdata = sysdata;
+	b->ops = ops;
+	b->number = b->busn_res.start = bus;
+	pci_bus_assign_domain_nr(b, parent);
+
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
@@ -1956,11 +1958,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bus_prepare(bridge);
 	if (error)
-		goto class_dev_reg_err;
+		goto free_bus;
 
 	error = device_register(&b->dev);
 	if (error)
-		goto class_dev_reg_err;
+		goto free_bus;
 
 	pcibios_add_bus(b);
 
@@ -2000,11 +2002,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 
 	return b;
 
-class_dev_reg_err:
+free_bus:
+	kfree(b);
 	put_device(&bridge->dev);
+unregister_host:
 	device_unregister(&bridge->dev);
-err_out:
-	kfree(b);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
-- 
1.7.1
