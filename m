Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 445922C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 00:15:29 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/6] PCI: Remove pci_bus_b() and use list_entry() directly
Date: Thu, 13 Feb 2014 21:14:03 +0800
Message-ID: <1392297243-61848-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>,
 linux-pcmcia@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace pci_bus_b() with list_entry(), so we can remove
pci_bus_b().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c    |    6 +++---
 drivers/pci/search.c |   10 +++++-----
 include/linux/pci.h  |    1 -
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1febe90..6f5ed88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -108,12 +108,12 @@ static bool pcie_ari_disabled;
  */
 unsigned char pci_bus_max_busnr(struct pci_bus* bus)
 {
-	struct list_head *tmp;
+	struct pci_bus *tmp;
 	unsigned char max, n;
 
 	max = bus->busn_res.end;
-	list_for_each(tmp, &bus->children) {
-		n = pci_bus_max_busnr(pci_bus_b(tmp));
+	list_for_each_entry(tmp, &bus->children, node) {
+		n = pci_bus_max_busnr(tmp);
 		if(n > max)
 			max = n;
 	}
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 3ff2ac7..4a1b972 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -54,14 +54,14 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 
 static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
 {
-	struct pci_bus* child;
-	struct list_head *tmp;
+	struct pci_bus *child;
+	struct pci_bus *tmp;
 
 	if(bus->number == busnr)
 		return bus;
 
-	list_for_each(tmp, &bus->children) {
-		child = pci_do_find_bus(pci_bus_b(tmp), busnr);
+	list_for_each_entry(tmp, &bus->children, node) {
+		child = pci_do_find_bus(tmp, busnr);
 		if(child)
 			return child;
 	}
@@ -111,7 +111,7 @@ pci_find_next_bus(const struct pci_bus *from)
 	down_read(&pci_bus_sem);
 	n = from ? from->node.next : pci_root_buses.next;
 	if (n != &pci_root_buses)
-		b = pci_bus_b(n);
+		b = list_entry(n, struct pci_bus, node);
 	up_read(&pci_bus_sem);
 	return b;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb57c89..e1b5752 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -461,7 +461,6 @@ struct pci_bus {
 	unsigned int		is_added:1;
 };
 
-#define pci_bus_b(n)	list_entry(n, struct pci_bus, node)
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
 /*
-- 
1.7.1
