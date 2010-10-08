Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 033C710095A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HH8Rn029887
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:17:08 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXbDA130798
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:33:37 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98HXaRf021197
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:36 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 06/11] ppc: checking for pdn->parent is redundant
Date: Fri,  8 Oct 2010 10:33:07 -0700
Message-Id: <1286559192-10898-7-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device tree root is never a pci bus, and will not have a
PCI_DN(pdn), so the check for PCI_DN added in
650f7b3b2f0ead0673e90452cf3dedde97c537ba makes the check for pdn->parent
redundant and it can be removed.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8ab32da..0ae5a60 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -530,10 +530,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	}
 	pr_debug("  parent is %s\n", pdn->full_name);
 
-	/* Check for parent == NULL so we don't try to setup the empty EADS
-	 * slots on POWER4 machines.
-	 */
-	if (dma_window == NULL || pdn->parent == NULL) {
+	if (dma_window == NULL) {
 		pr_debug("  no dma window for device, linking to parent\n");
 		set_iommu_table_base(&dev->dev, PCI_DN(pdn)->iommu_table);
 		return;
-- 
1.7.1
