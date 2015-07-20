Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 999051A2DA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 22:18:26 +1000 (AEST)
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
Subject: [PATCH part3 v12 06/10] PCI: Make pci_host_bridge hold sysdata in
 drvdata
Date: Mon, 20 Jul 2015 20:01:14 +0800
Message-ID: <1437393678-4077-7-git-send-email-wangyijing@huawei.com>
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

Now platform specific sysdata is saved in pci_bus,
and pcibios_root_bridge_prepare() need to know
the sysdata. Later, we would move pcibios_root_bridge_prepare()
prior to root bus creation, so we need to make
pci_host_bridge hold sysdata.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/pci/pci.c |    2 +-
 arch/x86/pci/acpi.c |    2 +-
 drivers/pci/probe.c |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 67ffe1f..8f79852 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -485,7 +485,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	 * that case.
 	 */
 	if (!bridge->dev.parent) {
-		struct pci_controller *controller = bridge->bus->sysdata;
+		struct pci_controller *controller = dev_get_drvdata(&bridge->dev);
 		ACPI_COMPANION_SET(&bridge->dev, controller->companion);
 	}
 	return 0;
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 629fc3b..38ce348 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -502,7 +502,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	 * that case.
 	 */
 	if (!bridge->dev.parent) {
-		struct pci_sysdata *sd = bridge->bus->sysdata;
+		struct pci_sysdata *sd = dev_get_drvdata(&bridge->dev);
 		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
 	}
 	return 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0eba126..0ae8bf2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1967,6 +1967,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 	bridge->domain = domain;
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
+	dev_set_drvdata(&bridge->dev, sysdata);
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
 	if (error) {
-- 
1.7.1
