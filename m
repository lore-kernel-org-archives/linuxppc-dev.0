Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D1DA1A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 18:03:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 3 Feb 2015 17:03:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C554357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 18:03:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t13730X738731868
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 18:03:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1372Yos005955
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 18:02:34 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com, benh@au1.ibm.com
Subject: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed limit
 after shifting
Date: Tue,  3 Feb 2015 15:01:43 +0800
Message-Id: <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20150130230803.GA6795@google.com>
References: <20150130230803.GA6795@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The actual IOV BAR range is determined by the start address and the actual
size for vf_num VFs BAR. After shifting the IOV BAR, there would be a
chance the actual end address exceed the limit and overlap with other
devices.

This patch adds a check to make sure after shifting, the range will not
overlap with other devices.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   53 ++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8456ae8..1a1e74b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -854,16 +854,18 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PCI_IOV
-static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
+static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 {
 	struct pci_dn *pdn = pci_get_pdn(dev);
 	int i;
 	struct resource *res;
 	resource_size_t size;
+	u16 vf_num;
 
 	if (!dev->is_physfn)
-		return;
+		return -EINVAL;
 
+	vf_num = pdn->vf_pes;
 	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
 		res = &dev->resource[i];
 		if (!res->flags || !res->parent)
@@ -875,11 +877,49 @@ static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
 		size = pci_iov_resource_size(dev, i);
 		res->start += size*offset;
-
 		dev_info(&dev->dev, "                 %pR\n", res);
+
+		/*
+		 * The actual IOV BAR range is determined by the start address
+		 * and the actual size for vf_num VFs BAR. The check here is
+		 * to make sure after shifting, the range will not overlap
+		 * with other device.
+		 */
+		if ((res->start + (size * vf_num)) > res->end) {
+			dev_err(&dev->dev, "VF BAR%d: %pR will conflict with"
+					" other device after shift\n");
+			goto failed;
+		}
+	}
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &dev->resource[i];
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
 		pci_update_resource(dev, i);
 	}
 	pdn->max_vfs -= offset;
+	return 0;
+
+failed:
+	for (; i >= PCI_IOV_RESOURCES; i--) {
+		res = &dev->resource[i];
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
+		size = pci_iov_resource_size(dev, i);
+		res->start += size*(-offset);
+		dev_info(&dev->dev, "                 %pR\n", res);
+	}
+	return -EBUSY;
 }
 #endif /* CONFIG_PCI_IOV */
 
@@ -1480,8 +1520,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 vf_num)
 		}
 
 		/* Do some magic shift */
-		if (pdn->m64_per_iov == 1)
-			pnv_pci_vf_resource_shift(pdev, pdn->offset);
+		if (pdn->m64_per_iov == 1) {
+			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
+			if (ret)
+				goto m64_failed;
+		}
 	}
 
 	/* Setup VF PEs */
-- 
1.7.9.5
