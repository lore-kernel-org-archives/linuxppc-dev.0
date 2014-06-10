Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C695F1A00D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:18 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 11:57:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CD9FE2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:15 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1ZGkx10551712
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:35:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1vERm024795
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:15 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 13/17] powerpc/powernv: shift VF resource with an offset
Date: Tue, 10 Jun 2014 09:56:35 +0800
Message-Id: <1402365399-5121-14-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powrnv platform, resource position in M64 implies the PE# the resource
belongs to. In some particular case, adjustment of a resource is necessary to
locate it to a correct position in M64.

This patch introduce a function to shift the 'real' VF BAR address according to
an offset.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b0ac851..e46c5bf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci_regs.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/string.h>
@@ -544,6 +545,35 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	return 10;
 }
 
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
+{
+	struct pci_dn *pdn = pci_get_pdn(dev);
+	int i;
+	struct resource *res;
+	resource_size_t size;
+
+	if (dev->is_physfn) {
+		for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+			res = dev->resource + PCI_IOV_RESOURCES + i;
+			if (!res->flags || !res->parent)
+				continue;
+
+			if (!is_mem_pref_64_type(res->flags))
+				continue;
+
+			dev_info(&dev->dev, "PowerNV: Shifting VF BAR %pR to\n", res);
+			size = pci_sriov_resource_size(dev, PCI_IOV_RESOURCES + i);
+			res->start += size*offset;
+
+			dev_info(&dev->dev, "                         %pR\n", res);
+			pci_update_resource(dev, PCI_IOV_RESOURCES + i);
+		}
+		pdn->vfs -= offset;
+	}
+}
+#endif /* CONFIG_PCI_IOV */
+
 #if 0
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
-- 
1.7.9.5
