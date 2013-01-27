Return-Path: <yinghai@kernel.org>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "userp1050.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 944642C0160
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 06:24:48 +1100 (EST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id
 r0RJOkvd014863
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2013 19:24:46 GMT
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <jiang.liu@huawei.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Taku Izumi <izumi.taku@jp.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v3 02/22] PCI: Add dummy bus_type for pci_host_bridge
Date: Sun, 27 Jan 2013 11:23:29 -0800
Message-Id: <1359314629-18651-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Cc: linux-ia64@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Howells <dhowells@redhat.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, linux-altix@sgi.com, Doug Thompson <dougthompson@xmission.com>,
 Matt Turner <mattst88@gmail.com>, linux-edac@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Yinghai Lu <yinghai@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Need to use it for looping registered host_bridge, and kill
pci_root_buses list.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linux-altix@sgi.com
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux@itee.uq.edu.au
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/pci/pci-driver.c |   11 ++++++++++-
 drivers/pci/probe.c      |    1 +
 include/linux/pci.h      |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index acdcc3c..9fb004b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1278,11 +1278,20 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 };
 
+struct bus_type pci_host_bridge_bus_type = {
+	.name           = "pci_host_bridge",
+};
+
+static int __init pci_host_bridge_driver_init(void)
+{
+	return bus_register(&pci_host_bridge_bus_type);
+}
+postcore_initcall(pci_host_bridge_driver_init);
+
 static int __init pci_driver_init(void)
 {
 	return bus_register(&pci_bus_type);
 }
-
 postcore_initcall(pci_driver_init);
 
 EXPORT_SYMBOL_GPL(pci_add_dynid);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef50154..04ecf0d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1692,6 +1692,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 
 	bridge->dev.parent = parent;
+	bridge->dev.bus = &pci_host_bridge_bus_type;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 056d3d6..9da06ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -669,6 +669,7 @@ enum pcie_bus_config_types {
 
 extern enum pcie_bus_config_types pcie_bus_config;
 
+extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
@@ -740,6 +741,7 @@ void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
+#define dev_is_pci_host_bridge(d) ((d)->bus == &pci_host_bridge_bus_type)
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
-- 
1.7.10.4
