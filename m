Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43BEB2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 00:15:16 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/6] PCI/powerpc: Use list_for_each_entry() for bus traversal
Date: Thu, 13 Feb 2014 21:14:01 +0800
Message-ID: <1392297243-61848-4-git-send-email-wangyijing@huawei.com>
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

Replace list_for_each() + pci_bus_b() with the simpler
list_for_each_entry().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/pci_64.c               |    4 +---
 arch/powerpc/platforms/pseries/pci_dlpar.c |    6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index a9e311f..2a47790 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -208,7 +208,6 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 			  unsigned long in_devfn)
 {
 	struct pci_controller* hose;
-	struct list_head *ln;
 	struct pci_bus *bus = NULL;
 	struct device_node *hose_node;
 
@@ -230,8 +229,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	 * used on pre-domains setup. We return the first match
 	 */
 
-	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, &pci_root_buses, node) {
 		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
 			break;
 		bus = NULL;
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index efe6137..203cbf0 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -37,15 +37,15 @@ find_bus_among_children(struct pci_bus *bus,
                         struct device_node *dn)
 {
 	struct pci_bus *child = NULL;
-	struct list_head *tmp;
+	struct pci_bus *tmp;
 	struct device_node *busdn;
 
 	busdn = pci_bus_to_OF_node(bus);
 	if (busdn == dn)
 		return bus;
 
-	list_for_each(tmp, &bus->children) {
-		child = find_bus_among_children(pci_bus_b(tmp), dn);
+	list_for_each_entry(tmp, &bus->children, node) {
+		child = find_bus_among_children(tmp, dn);
 		if (child)
 			break;
 	};
-- 
1.7.1
