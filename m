Return-Path: <yinghai@kernel.org>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "userp1050.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F7E02C0098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 06:24:38 +1100 (EST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id
 r0RJOZ7W014859
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2013 19:24:36 GMT
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <jiang.liu@huawei.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Taku Izumi <izumi.taku@jp.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v3 20/22] PCI,
 powerpc: Kill pci_root_buses in resources reservations
Date: Sun, 27 Jan 2013 11:23:47 -0800
Message-Id: <1359314629-18651-21-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace that with hotplug-safe version iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c |   13 ++++++-------
 arch/powerpc/kernel/pci_64.c     |    8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index abc0d08..9ccecbe 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1398,11 +1398,11 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *b;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	/* Allocate and assign resources */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_allocate_bus_resources(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_bus_resources(host_bridge->bus);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
 
@@ -1410,10 +1410,9 @@ void __init pcibios_resource_survey(void)
 	 * the low IO area and the VGA memory area if they intersect the
 	 * bus available resources to avoid allocating things on top of them
 	 */
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		list_for_each_entry(b, &pci_root_buses, node)
-			pcibios_reserve_legacy_regions(b);
-	}
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		for_each_pci_host_bridge(host_bridge)
+			pcibios_reserve_legacy_regions(host_bridge->bus);
 
 	/* Now, if the platform didn't decide to blindly trust the firmware,
 	 * we proceed to assigning things that were left unassigned
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 2cbe676..f848325 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -208,9 +208,9 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 			  unsigned long in_devfn)
 {
 	struct pci_controller* hose;
-	struct list_head *ln;
-	struct pci_bus *bus = NULL;
+	struct pci_bus *bus;
 	struct device_node *hose_node;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	/* Argh ! Please forgive me for that hack, but that's the
 	 * simplest way to get existing XFree to not lockup on some
@@ -230,8 +230,8 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	 * used on pre-domains setup. We return the first match
 	 */
 
-	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		bus = pci_bus_b(ln);
+	for_each_pci_host_bridge(host_bridge) {
+		bus = host_bridge->bus;
 		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
 			break;
 		bus = NULL;
-- 
1.7.10.4
