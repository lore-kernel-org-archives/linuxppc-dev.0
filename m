Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE8FAB747C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:09:10 +1100 (EST)
Received: from mail55-tx2 (localhost [127.0.0.1])	by mail55-tx2-R.bigfish.com
 (Postfix) with ESMTP id 566102C065D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:09:08 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.252])	by
 mail55-tx2.bigfish.com (Postfix) with ESMTP id B11A53000A2	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:09:05 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] fsl_pci: Add a workaround for PCI 5 errata in MPC8548
Date: Tue, 6 Mar 2012 17:10:54 +0800
Message-ID: <1331025056-15983-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Issue:
As a master, the PCI IP block can combine a memory write to the last PCI double
word (4 bytes) of a cacheline with a 4 byte memory write to the first PCI double
word of the subsequent cacheline. This affects 32-bit PCI target devices that
blindly assert STOP on memory-write transactions, without detecting that the
data beat being transferred is the last data beat of the transaction. It can
cause a hang. PCI-X operation is not affected by this erratum.

Workaround:
Setting the bit MDS in the PCI Bus Function Register will disable the combining
of crossing cacheline boundary requests into one burst transaction. Therefore,
it can prevent the errata scenario from occurring.

Refer to PCI 5 in MPC8548 errata document.

Signed-off-by: Gong Chen <g.chen@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..9bdee6d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -31,6 +31,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
+#include <asm/mpc85xx.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
@@ -426,6 +427,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	struct resource rsrc;
 	const int *bus_range;
 	u8 progif;
+	u16 temp;
 
 	if (!of_device_is_available(dev)) {
 		pr_warning("%s: disabled\n", dev->full_name);
@@ -476,6 +478,24 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 		if (fsl_pcie_check_link(hose))
 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	} else {
+		/*
+		 * Set PBFR(PCI Bus Function Register)[10] = 1 to
+		 * disable the combining of crossing cacheline
+		 * boundary requests into one burst transaction.
+		 * PCI-X operation is not affected.
+		 * Fix erratum PCI 5 on MPC8548
+		 */
+#define PCI_BUS_FUNCTION 0x44
+#define PCI_BUS_FUNCTION_MDS 0x400	/* Master disable streaming */
+		if ((fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) &&
+		    !early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX)) {
+			early_read_config_word(hose, 0, 0,
+						PCI_BUS_FUNCTION, &temp);
+			temp |= PCI_BUS_FUNCTION_MDS;
+			early_write_config_word(hose, 0, 0,
+						PCI_BUS_FUNCTION, temp);
+		}
 	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
-- 
1.6.4.1
