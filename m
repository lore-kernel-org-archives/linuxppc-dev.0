Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99A611A0DC6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:38:50 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 17/30] PCI/powerpc: Rename pcibios_root_bridge_prepare()
Date: Wed, 21 Jan 2015 08:30:12 +0800
Message-ID: <1421800225-26230-18-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, Guan
 Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd
 Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-m68k@lists.linux-m68k.org,
 Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Liviu Dudau <liviu@dudau.co.uk>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 Jiang Liu <jiang.liu@linux.intel.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pcibios_root_bridge_prepare() in powerpc is used
to set root bus speed. Rename it to
pcibios_set_root_bus_speed() for better readability.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/machdep.h       |    2 +-
 arch/powerpc/kernel/pci-common.c         |    6 +++---
 arch/powerpc/platforms/pseries/pci.c     |    2 +-
 arch/powerpc/platforms/pseries/pseries.h |    2 +-
 arch/powerpc/platforms/pseries/setup.c   |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c8175a3..8e7f2a8 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -129,7 +129,7 @@ struct machdep_calls {
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
-	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
+	int		(*pcibios_set_root_bus_speed)(struct pci_host_bridge
 				*bridge);
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 927c3dd..c11bfed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -769,9 +769,9 @@ int pci_proc_domain(struct pci_bus *bus)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	if (ppc_md.pcibios_root_bridge_prepare)
-		return ppc_md.pcibios_root_bridge_prepare(bridge);
-
+	if (ppc_md.pcibios_set_root_bus_speed)
+		return ppc_md.pcibios_set_root_bus_speed(bridge);
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index fe16a50..af685d6 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -110,7 +110,7 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
 
-int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
+int pseries_set_root_bus_speed(struct pci_host_bridge *bridge)
 {
 	struct device_node *dn, *pdn;
 	struct pci_bus *bus;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1796c54..5d0be3a 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,7 +63,7 @@ extern int dlpar_detach_node(struct device_node *);
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
-int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
+int pseries_set_root_bus_speed(struct pci_host_bridge *bridge);
 
 unsigned long pseries_memory_block_size(void);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e445b67..b196c0d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -496,7 +496,7 @@ static void __init pSeries_setup_arch(void)
 		ppc_md.enable_pmcs = power4_enable_pmcs;
 	}
 
-	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	ppc_md.pcibios_set_root_bus_speed = pseries_set_root_bus_speed;
 
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
-- 
1.7.1
