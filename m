Return-Path: <liuj97@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 494B42C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 02:53:11 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id ld10so690244pab.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 09:53:09 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH v2, part 2 09/18] PCI,
 PPC: use hotplug-safe iterators to walk PCI buses
Date: Wed, 15 May 2013 00:51:53 +0800
Message-Id: <1368550322-1045-9-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Toshi Kani <toshi.kani@hp.com>,
 Jiang Liu <jiang.liu@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>,
 Yijing Wang <wangyijing@huawei.com>, Bill Pemberton <wfp5p@virginia.edu>,
 linux-pci@vger.kernel.org, Gu Zheng <guz.fnst@cn.fujitsu.com>,
 Paul Mackerras <paulus@samba.org>, Myron Stowe <myron.stowe@redhat.com>,
 Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enhance PPC architecture specific code to use hotplug-safe iterators
to walk PCI buses.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Bill Pemberton <wfp5p@virginia.edu>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/kernel/pci-common.c |  4 ++--
 arch/powerpc/kernel/pci_64.c     | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fa12ae4..26fca09 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1400,7 +1400,7 @@ void __init pcibios_resource_survey(void)
 	struct pci_bus *b;
 
 	/* Allocate and assign resources */
-	list_for_each_entry(b, &pci_root_buses, node)
+	for_each_pci_root_bus(b)
 		pcibios_allocate_bus_resources(b);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
@@ -1410,7 +1410,7 @@ void __init pcibios_resource_survey(void)
 	 * bus available resources to avoid allocating things on top of them
 	 */
 	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		list_for_each_entry(b, &pci_root_buses, node)
+		for_each_pci_root_bus(b)
 			pcibios_reserve_legacy_regions(b);
 	}
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 51a133a..a41c6dd 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -208,7 +208,6 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 			  unsigned long in_devfn)
 {
 	struct pci_controller* hose;
-	struct list_head *ln;
 	struct pci_bus *bus = NULL;
 	struct device_node *hose_node;
 
@@ -229,18 +228,16 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	/* That syscall isn't quite compatible with PCI domains, but it's
 	 * used on pre-domains setup. We return the first match
 	 */
-
-	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		bus = pci_bus_b(ln);
-		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
+	for_each_pci_root_bus(bus)
+		if (in_bus >= bus->number && in_bus <= bus->busn_res.end &&
+		    bus->dev.of_node)
 			break;
-		bus = NULL;
-	}
-	if (bus == NULL || bus->dev.of_node == NULL)
+	if (bus == NULL)
 		return -ENODEV;
 
 	hose_node = bus->dev.of_node;
 	hose = PCI_DN(hose_node)->phb;
+	pci_bus_put(bus);
 
 	switch (which) {
 	case IOBASE_BRIDGE_NUMBER:
-- 
1.8.1.2
