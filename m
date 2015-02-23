Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 671081A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:21:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Subject: [PATCH 2/3] cxl: Fix device_node reference counting
Date: Mon, 23 Feb 2015 15:21:20 +1100
Message-Id: <1424665281-25431-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
References: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
Cc: grimm@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, imunsie@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ryan Grimm <grimm@linux.vnet.ibm.com>

Commit 6f963ec2d6bf2476a16799eece920acb2100ff1c upstream.

When unbinding and rebinding the driver on a system with a card in PHB0, this
error condition is reached after a few attempts:

ERROR: Bad of_node_put() on /pciex@3fffe40000000
CPU: 0 PID: 3040 Comm: bash Not tainted 3.18.0-rc3-12545-g3627ffe #152
Call Trace:
[c000000721acb5c0] [c00000000086ef94] .dump_stack+0x84/0xb0 (unreliable)
[c000000721acb640] [c00000000073a0a8] .of_node_release+0xd8/0xe0
[c000000721acb6d0] [c00000000044bc44] .kobject_release+0x74/0xe0
[c000000721acb760] [c0000000007394fc] .of_node_put+0x1c/0x30
[c000000721acb7d0] [c000000000545cd8] .cxl_probe+0x1a98/0x1d50
[c000000721acb900] [c0000000004845a0] .local_pci_probe+0x40/0xc0
[c000000721acb980] [c000000000484998] .pci_device_probe+0x128/0x170
[c000000721acba30] [c00000000052400c] .driver_probe_device+0xac/0x2a0
[c000000721acbad0] [c000000000522468] .bind_store+0x108/0x160
[c000000721acbb70] [c000000000521448] .drv_attr_store+0x38/0x60
[c000000721acbbe0] [c000000000293840] .sysfs_kf_write+0x60/0xa0
[c000000721acbc50] [c000000000292500] .kernfs_fop_write+0x140/0x1d0
[c000000721acbcf0] [c000000000208648] .vfs_write+0xd8/0x260
[c000000721acbd90] [c000000000208b18] .SyS_write+0x58/0x100
[c000000721acbe30] [c000000000009258] syscall_exit+0x0/0x98

We are missing a call to of_node_get(). pnv_pci_to_phb_node() should
call of_node_get() otherwise np's reference count isn't incremented and
it might go away. Rename pnv_pci_to_phb_node() to pnv_pci_get_phb_node()
so it's clear it calls of_node_get().

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pnv-pci.h        | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 drivers/misc/cxl/pci.c                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f09a22fa1bd7..bfa8f8ac51fa 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -19,7 +19,7 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
 void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num);
 int pnv_cxl_get_irq_count(struct pci_dev *dev);
-struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev);
+struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev);
 
 #ifdef CONFIG_CXL_BASE
 int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fac88ed8a915..6a9a255d8058 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1460,13 +1460,13 @@ static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 
 #ifdef CONFIG_CXL_BASE
 
-struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
+struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 
-	return hose->dn;
+	return of_node_get(hose->dn);
 }
-EXPORT_SYMBOL(pnv_pci_to_phb_node);
+EXPORT_SYMBOL(pnv_pci_get_phb_node);
 
 int pnv_phb_to_cxl(struct pci_dev *dev)
 {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 184550baa8b9..eee4fd606dc1 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -316,7 +316,7 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	u64 psl_dsnctl;
 	u64 chipid;
 
-	if (!(np = pnv_pci_to_phb_node(dev)))
+	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
 
 	while (np && !(prop = of_get_property(np, "ibm,chip-id", NULL)))
-- 
2.1.0
