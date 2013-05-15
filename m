Return-Path: <liuj97@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DEAC2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 01:17:31 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id kq12so1589984pab.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 08:17:29 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: PCI, PPC: use hotplug-safe iterators to walk PCI buses
Date: Wed, 15 May 2013 23:17:16 +0800
Message-Id: <1368631036-7845-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368574202.31689.54.camel@pasglop>
References: <1368574202.31689.54.camel@pasglop>
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
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Bill Pemberton <wfp5p@virginia.edu>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
Hi Benjamin,
	How about this version? Use pci_bus_to_host() instead
to simplify code.
Regards!
Gerry
---
 arch/powerpc/kernel/pci-common.c |  4 ++--
 arch/powerpc/kernel/pci_64.c     | 22 ++++++++--------------
 2 files changed, 10 insertions(+), 16 deletions(-)

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
index 51a133a..8bea231 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -207,10 +207,8 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
 long sys_pciconfig_iobase(long which, unsigned long in_bus,
 			  unsigned long in_devfn)
 {
-	struct pci_controller* hose;
-	struct list_head *ln;
-	struct pci_bus *bus = NULL;
-	struct device_node *hose_node;
+	struct pci_controller* hose = NULL;
+	struct pci_bus *bus;
 
 	/* Argh ! Please forgive me for that hack, but that's the
 	 * simplest way to get existing XFree to not lockup on some
@@ -229,19 +227,15 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	/* That syscall isn't quite compatible with PCI domains, but it's
 	 * used on pre-domains setup. We return the first match
 	 */
-
-	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		bus = pci_bus_b(ln);
-		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
+	for_each_pci_root_bus(bus)
+		if (in_bus >= bus->number && in_bus <= bus->busn_res.end) {
+			hose = pci_bus_to_host(bus);
+			pci_bus_put(bus);
 			break;
-		bus = NULL;
-	}
-	if (bus == NULL || bus->dev.of_node == NULL)
+		}
+	if (hose == NULL)
 		return -ENODEV;
 
-	hose_node = bus->dev.of_node;
-	hose = PCI_DN(hose_node)->phb;
-
 	switch (which) {
 	case IOBASE_BRIDGE_NUMBER:
 		return (long)hose->first_busno;
-- 
1.8.1.2
