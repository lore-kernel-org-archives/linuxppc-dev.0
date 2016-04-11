Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkKZk2x3YzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 05:17:34 +1000 (AEST)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 16:17:29 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 6EA2D1DC0071
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:17:19 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BIHPQZ20250900
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:17:25 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BJHNOv012313
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:17:24 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, nfont@linux.vnet.ibm.com
Subject: [PATCH 2/2 v3] powerpc/iommu: Remove the dependency on EEH struct in
 DDW mechanism
Date: Mon, 11 Apr 2016 16:17:23 -0300
Message-Id: <1460402243-24346-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1460402243-24346-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460402243-24346-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
changed the pci_dn struct by removing its EEH-related members.
As part of this clean-up, DDW mechanism was modified to read the device
configuration address from eeh_dev struct.

As a consequence, now if we disable EEH mechanism on kernel command-line
for example, the DDW mechanism will fail, generating a kernel oops by
dereferencing a NULL pointer (which turns to be the eeh_dev pointer).

This patch just changes the configuration address calculation on DDW
functions to a manual calculation based on pci_dn members instead of
using eeh_dev-based address.

No functional changes were made. This was tested on pSeries, both
in PHyp and qemu guest.

Fixes: 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")

Cc: stable@vger.kernel.org
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index bd98ce2..b7dfc13 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -912,7 +912,8 @@ machine_arch_initcall(pseries, find_existing_ddw_windows);
 static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 			struct ddw_query_response *query)
 {
-	struct eeh_dev *edev;
+	struct device_node *dn;
+	struct pci_dn *pdn;
 	u32 cfg_addr;
 	u64 buid;
 	int ret;
@@ -923,11 +924,10 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	 * Retrieve them from the pci device, not the node with the
 	 * dma-window property
 	 */
-	edev = pci_dev_to_eeh_dev(dev);
-	cfg_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		cfg_addr = edev->pe_config_addr;
-	buid = edev->phb->buid;
+	dn = pci_device_to_OF_node(dev);
+	pdn = PCI_DN(dn);
+	buid = pdn->phb->buid;
+	cfg_addr = (pdn->busno << 8) | pdn->devfn;
 
 	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
 		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
@@ -941,7 +941,8 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 			struct ddw_create_response *create, int page_shift,
 			int window_shift)
 {
-	struct eeh_dev *edev;
+	struct device_node *dn;
+	struct pci_dn *pdn;
 	u32 cfg_addr;
 	u64 buid;
 	int ret;
@@ -952,11 +953,10 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	 * Retrieve them from the pci device, not the node with the
 	 * dma-window property
 	 */
-	edev = pci_dev_to_eeh_dev(dev);
-	cfg_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		cfg_addr = edev->pe_config_addr;
-	buid = edev->phb->buid;
+	dn = pci_device_to_OF_node(dev);
+	pdn = PCI_DN(dn);
+	buid = pdn->phb->buid;
+	cfg_addr = (pdn->busno << 8) | pdn->devfn;
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-- 
2.1.0
