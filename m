Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgNXF4SglzDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:20:13 +1000 (AEST)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 21:20:09 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id EED953520078
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 20:19:55 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36NK9iH30277682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 20:20:09 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u370K67q011230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:20:06 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Subject: [PATCH 2/2 v2] powerpc/iommu: Remove the dependency on EEH struct in
 DDW mechanism
Date: Wed,  6 Apr 2016 21:20:05 -0300
Message-Id: <1459988405-13991-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index bd98ce2..3db2cea 100644
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
+	cfg_addr = (pdn->busno << 8) | (pdn->devfn);
+	buid = pdn->phb->buid;
 
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
+	cfg_addr = (pdn->busno << 8) | (pdn->devfn);
+	buid = pdn->phb->buid;
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-- 
2.1.0
