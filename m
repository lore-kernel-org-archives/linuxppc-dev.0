Return-Path: <yinghai@kernel.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh0T247SyzDq6v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 10:19:34 +1000 (AEST)
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
 Yijing Wang <wangyijing@huawei.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: [PATCH v11 52/60] PCI: Unify skip_ioresource_align()
Date: Thu,  7 Apr 2016 17:16:05 -0700
Message-Id: <1460074573-7481-53-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are powerpc generic version and x86 local version for
skip_ioresource_align().

Move the powerpc version to setup-bus.c, and kill x86 local version.

Also kill dummy version in microblaze.

Cc: Michal Simek <monstr@monstr.eu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci-common.c | 11 +----------
 arch/x86/include/asm/pci_x86.h   |  1 -
 arch/x86/pci/common.c            |  4 ++--
 arch/x86/pci/i386.c              | 11 +----------
 drivers/pci/setup-bus.c          |  9 +++++++++
 include/linux/pci.h              |  2 ++
 6 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..2a7f4fd 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1053,15 +1053,6 @@ void pci_fixup_cardbus(struct pci_bus *bus)
 	pcibios_setup_bus_devices(bus);
 }
 
-
-static int skip_isa_ioresource_align(struct pci_dev *dev)
-{
-	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
-	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
-		return 1;
-	return 0;
-}
-
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -1082,7 +1073,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
-		if (skip_isa_ioresource_align(dev))
+		if (skip_isa_ioresource_align(dev->bus))
 			return start;
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index d08eacd2..d1f919e 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -28,7 +28,6 @@ do {						\
 #define PCI_ASSIGN_ROMS		0x1000
 #define PCI_BIOS_IRQ_SCAN	0x2000
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
-#define PCI_CAN_SKIP_ISA_ALIGN	0x8000
 #define PCI_USE__CRS		0x10000
 #define PCI_CHECK_ENABLE_AMD_MMCONF	0x20000
 #define PCI_HAS_IO_ECS		0x40000
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 381a43c..09a16b7 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -82,7 +82,7 @@ DEFINE_RAW_SPINLOCK(pci_config_lock);
 
 static int __init can_skip_ioresource_align(const struct dmi_system_id *d)
 {
-	pci_probe |= PCI_CAN_SKIP_ISA_ALIGN;
+	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 	printk(KERN_INFO "PCI: %s detected, can skip ISA alignment\n", d->ident);
 	return 0;
 }
@@ -618,7 +618,7 @@ char *__init pcibios_setup(char *str)
 		pci_routeirq = 1;
 		return NULL;
 	} else if (!strcmp(str, "skip_isa_align")) {
-		pci_probe |= PCI_CAN_SKIP_ISA_ALIGN;
+		pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 		return NULL;
 	} else if (!strcmp(str, "noioapicquirk")) {
 		noioapicquirk = 1;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 0a9f2ca..cf296f5 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -128,15 +128,6 @@ static void __init pcibios_fw_addr_list_del(void)
 	pcibios_fw_addr_done = true;
 }
 
-static int
-skip_isa_ioresource_align(struct pci_dev *dev) {
-
-	if ((pci_probe & PCI_CAN_SKIP_ISA_ALIGN) &&
-	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
-		return 1;
-	return 0;
-}
-
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -158,7 +149,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
-		if (skip_isa_ioresource_align(dev))
+		if (skip_isa_ioresource_align(dev->bus))
 			return start;
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 28dfd8e..5ba4bf5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1150,6 +1150,15 @@ static resource_size_t window_alignment(struct pci_bus *bus,
 	return max(align, arch_align);
 }
 
+int skip_isa_ioresource_align(struct pci_bus *bus)
+{
+	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
+	    !(bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
+		return 1;
+
+	return 0;
+}
+
 static resource_size_t size_aligned_for_isa(resource_size_t size)
 {
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 979be25..d7b1ceb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -765,6 +765,8 @@ static inline void pci_add_flags(int flags) { pci_flags |= flags; }
 static inline void pci_clear_flags(int flags) { pci_flags &= ~flags; }
 static inline int pci_has_flag(int flag) { return pci_flags & flag; }
 
+int skip_isa_ioresource_align(struct pci_bus *bus);
+
 void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
-- 
1.8.4.5
