Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BE781A2FF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 18:31:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BCE4B3578054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P8V5bi46071950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P8UdfK028443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:30:40 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V16 17/20] powerpc/powernv: Reserve additional space for IOV
 BAR, with m64_per_iov supported
Date: Wed, 25 Mar 2015 16:23:58 +0800
Message-Id: <1427271841-28749-18-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

M64 aperture size is limited on PHB3.  When the IOV BAR is too big, this
will exceed the limitation and failed to be assigned.

Introduce a different mechanism based on the IOV BAR size:

  - if IOV BAR size is smaller than 64MB, expand to total_pe
  - if IOV BAR size is bigger than 64MB, roundup power2

[bhelgaas: make dev_printk() output more consistent, use PCI_SRIOV_NUM_BARS]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 8716db4..415df85 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -182,6 +182,8 @@ struct pci_dn {
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
 	int     offset;			/* PE# for the first VF PE */
+#define M64_PER_IOV 4
+	int     m64_per_iov;
 #define IODA_INVALID_M64        (-1)
 	int     m64_wins[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5187d16..b63925f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2250,6 +2250,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	int i;
 	resource_size_t size;
 	struct pci_dn *pdn;
+	int mul, total_vfs;
 
 	if (!pdev->is_physfn || pdev->is_added)
 		return;
@@ -2260,6 +2261,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs_expanded = 0;
 
+	total_vfs = pci_sriov_get_totalvfs(pdev);
+	pdn->m64_per_iov = 1;
+	mul = phb->ioda.total_pe;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = &pdev->resource[i + PCI_IOV_RESOURCES];
+		if (!res->flags || res->parent)
+			continue;
+		if (!pnv_pci_is_mem_pref_64(res->flags)) {
+			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
+				 i, res);
+			continue;
+		}
+
+		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
+
+		/* bigger than 64M */
+		if (size > (1 << 26)) {
+			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
+				 i, res);
+			pdn->m64_per_iov = M64_PER_IOV;
+			mul = roundup_pow_of_two(total_vfs);
+			break;
+		}
+	}
+
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->flags || res->parent)
@@ -2272,12 +2299,12 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
-		res->end = res->start + size * phb->ioda.total_pe - 1;
+		res->end = res->start + size * mul - 1;
 		dev_dbg(&pdev->dev, "                       %pR\n", res);
 		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
-				i, res, phb->ioda.total_pe);
+			 i, res, mul);
 	}
-	pdn->vfs_expanded = phb->ioda.total_pe;
+	pdn->vfs_expanded = mul;
 }
 #endif /* CONFIG_PCI_IOV */
 
-- 
1.7.9.5
