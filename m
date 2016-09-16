Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBd23mYZzDscL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GAbo6l025889
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:19 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fnp064fw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:19 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 20:40:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 562513578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8GAeAgE4915460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8GAe9Wh016525
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, benh@kernel.crashing.org,
 gwshan@linux.vnet.ibm.com
Subject: [RFC 3/3] powerpc/powernv: reset any PHBs in CAPI mode during
 initialisation
Date: Fri, 16 Sep 2016 20:39:46 +1000
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
Message-Id: <71005623da101025db530e7db25286fff97c5318.1474022276.git-series.andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we kexec into a new kernel on a machine where a PHB has been switched
into CAPI mode, we need to disable CAPI mode in the new kernel before
traffic begins to flow on the PHB and causes a machine checkstop.

During PHB initialisation, ask OPAL whether each PHB is in CAPI mode, and
if so, do a complete reset in order to disable CAPI mode.

This requires a version of skiboot that implements the
OPAL_PCI_GET_PHB_CAPI_MODE call (introduced at the same time that the
capability to disable CAPI mode during complete resets was introduced).

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Corresponding skiboot code: http://patchwork.ozlabs.org/patch/670782/
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ca5e9b5..bd76651 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3526,6 +3526,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	const __be32 *prop32;
 	int len;
 	unsigned int segno;
+	bool capi_mode = false;
 	u64 phb_id;
 	void *aux;
 	long rc;
@@ -3741,8 +3742,17 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
 	 * transactions from previous kernel.
+	 *
+	 * Additionally, if the PHB is in CAPI mode, we also need to
+	 * reset it to get it out of CAPI mode.
 	 */
-	if (is_kdump_kernel()) {
+	if (opal_check_token(OPAL_PCI_GET_PHB_CAPI_MODE) &&
+	    opal_pci_get_phb_capi_mode(phb_id) == OPAL_PHB_CAPI_MODE_CAPI) {
+		pr_info("  PHB in CAPI mode, reset required\n");
+		capi_mode = true;
+	}
+
+	if (is_kdump_kernel() || capi_mode) {
 		pr_info("  Issue PHB reset ...\n");
 		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
 		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-- 
git-series 0.8.10
