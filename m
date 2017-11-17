Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydnTZ585WzDrRg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 05:59:14 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAHIsBVg001560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 13:59:11 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ea4hgtn1t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 13:59:11 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Fri, 17 Nov 2017 13:59:10 -0500
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, paulus@samba.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, bsingharora@gmail.com
Subject: [PATCH v3] powerpc/powernv: Add ppc_pci_reset_phbs parameter to issue
 a PHB reset
Date: Fri, 17 Nov 2017 16:58:59 -0200
Message-Id: <20171117185859.2756-1-gpiccoli@linux.vnet.ibm.com>
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

This patch adds the ppc_pci_reset_phbs parameter to perform such reset.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---

* v3: Changed parameter name, adding prefix "ppc_" [mpe suggestion]

 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb5cd7511189..19f1b0021585 100644
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
+early_param("ppc_pci_reset_phbs", pci_reset_phbs_setup);
+
 static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
 {
 	/*
@@ -4014,9 +4023,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * If we're running in kdump kernel, the previous kernel never
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
-	 * transactions from previous kernel.
+	 * transactions from previous kernel. The ppc_pci_reset_phbs
+	 * kernel parameter will force this reset too.
 	 */
-	if (is_kdump_kernel()) {
+	if (is_kdump_kernel() || pci_reset_phbs) {
 		pr_info("  Issue PHB reset ...\n");
 		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
 		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-- 
2.15.0.rc0
