Return-Path: <nacc@us.ibm.com>
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 6/7] ppc/pseries: iommu cleanup
Date: Mon, 18 Oct 2010 10:27:03 -0700
Message-Id: <1287422825-14999-7-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need to initialize per-cpu pointer to NULL, it is the default.

Direct dma ops and no setup are the defaults, no need to set for
iommu-off.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/pseries/iommu.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a77bcae..9184db3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -140,7 +140,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	return ret;
 }
 
-static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
+static DEFINE_PER_CPU(u64 *, tce_page);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -589,13 +589,8 @@ static struct notifier_block iommu_reconfig_nb = {
 /* These are called very early. */
 void iommu_init_early_pSeries(void)
 {
-	if (of_chosen && of_get_property(of_chosen, "linux,iommu-off", NULL)) {
-		/* Direct I/O, IOMMU off */
-		ppc_md.pci_dma_dev_setup = NULL;
-		ppc_md.pci_dma_bus_setup = NULL;
-		set_pci_dma_ops(&dma_direct_ops);
+	if (of_chosen && of_get_property(of_chosen, "linux,iommu-off", NULL))
 		return;
-	}
 
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
-- 
1.7.1
