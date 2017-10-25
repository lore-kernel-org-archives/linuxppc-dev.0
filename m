Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMYtX65SWzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:28:04 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9PFQgA9046961
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 11:28:02 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dtua6fhxp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 11:28:01 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 25 Oct 2017 09:28:01 -0600
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue a
 PHB reset
Date: Wed, 25 Oct 2017 13:27:54 -0200
Message-Id: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During a kdump kernel boot in PowerPC, we request a reset of the PHBs
to the FW. It makes sense, since if we are booting a kdump kernel it
means we had some trouble before and we cannot rely in the adapters'
health; they could be in a bad state, hence the reset is needed.

But this reset is useful not only in kdump - there are situations,
specially when debugging drivers, that we could break an adapter in
a way it requires such reset. One can tell to just go ahead and
reboot the machine, but happens that many times doing kexec is much
faster, and so preferable than a full power cycle.

This patch adds the pci_reset_phbs parameter to perform such reset
when desired by the user.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
v2: changed name of the parameter [ben/mpe suggestion].

The patch was implemented against powerpc/next.

 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb5cd7511189..6070e0d4a7f3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -89,6 +89,7 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 }
 
 static bool pnv_iommu_bypass_disabled __read_mostly;
+static bool pci_reset_phbs __read_mostly;
 
 static int __init iommu_setup(char *str)
 {
@@ -110,6 +111,14 @@ static int __init iommu_setup(char *str)
 }
 early_param("iommu", iommu_setup);
 
+static int __init pci_reset_phbs_setup(char *str)
+{
+	pci_reset_phbs = true;
+	return 0;
+}
+
+early_param("pci_reset_phbs", pci_reset_phbs_setup);
+
 static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
 {
 	/*
@@ -4014,9 +4023,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * If we're running in kdump kernel, the previous kernel never
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
-	 * transactions from previous kernel.
+	 * transactions from previous kernel. The pci_reset_phbs
+	 * kernel parameter will force this reset too.
 	 */
-	if (is_kdump_kernel()) {
+	if (is_kdump_kernel() || pci_reset_phbs) {
 		pr_info("  Issue PHB reset ...\n");
 		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
 		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-- 
2.15.0.rc0
