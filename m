Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E2D21A0725
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:51:33 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 15:51:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 299A72BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:23 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6G5Rcbh41943130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:27:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6G5oLXP014088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/eeh: Selectively enable IO for error log
Date: Wed, 16 Jul 2014 15:50:15 +1000
Message-Id: <1405489819-26211-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the experiment I did, PCI config access is blocked
on P7IOC frozen PE by hardware, but PHB3 doesn't do that. That
means we always get 0xFF's while dumping PCI config space of the
frozen PE on P7IOC. We don't have the problem on PHB3. So we have
to enable I/O prioir to collecting error log. Otherwise, meaningless
0xFF's are always returned.

The patch fixes it by EEH flag (EEH_ENABLE_IO_FOR_LOG), which is
selectively set to indicate the case for: P7IOC on PowerNV platform,
pSeries platform.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  9 +++++----
 arch/powerpc/kernel/eeh.c                    |  2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 16 ++++++++++++++++
 arch/powerpc/platforms/pseries/eeh_pseries.c |  2 +-
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ca8aada..494c3ff 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -34,10 +34,11 @@ struct device_node;
 #ifdef CONFIG_EEH
 
 /* EEH subsystem flags */
-#define EEH_ENABLED		0x1	/* EEH enabled		*/
-#define EEH_FORCE_DISABLED	0x2	/* EEH disabled		*/
-#define EEH_PROBE_MODE_DEV	0x4	/* From PCI device	*/
-#define EEH_PROBE_MODE_DEVTREE	0x8	/* From device tree	*/
+#define EEH_ENABLED		0x01	/* EEH enabled		*/
+#define EEH_FORCE_DISABLED	0x02	/* EEH disabled		*/
+#define EEH_PROBE_MODE_DEV	0x04	/* From PCI device	*/
+#define EEH_PROBE_MODE_DEVTREE	0x08	/* From device tree	*/
+#define EEH_ENABLE_IO_FOR_LOG	0x10	/* Enable IO for log	*/
 
 /*
  * Delay for PE reset, all in ms
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 65a163f..aa33656 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -252,7 +252,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	 * 0xFF's is always returned from PCI config space.
 	 */
 	if (!(pe->type & EEH_PE_PHB)) {
-		if (eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
+		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG))
 			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 		eeh_ops->configure_bridge(pe);
 		eeh_pe_restore_bars(pe);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ba134ac..740c396 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -45,6 +45,9 @@
  */
 static int powernv_eeh_init(void)
 {
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+
 	/* We require OPALv3 */
 	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
 		pr_warning("%s: OPALv3 is required !\n", __func__);
@@ -54,6 +57,19 @@ static int powernv_eeh_init(void)
 	/* Set probe mode */
 	eeh_add_flag(EEH_PROBE_MODE_DEV);
 
+	/*
+	 * P7IOC blocks PCI config access to frozen PE, but PHB3
+	 * doesn't do that. So we have to selectively enable I/O
+	 * prior to collecting error log.
+	 */
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+
+		if (phb->model == PNV_PHB_MODEL_P7IOC)
+			eeh_add_flag(EEH_ENABLE_IO_FOR_LOG);
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index f173705..1e15cdd 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -128,7 +128,7 @@ static int pseries_eeh_init(void)
 	}
 
 	/* Set EEH probe mode */
-	eeh_add_flag(EEH_PROBE_MODE_DEVTREE);
+	eeh_add_flag(EEH_PROBE_MODE_DEVTREE | EEH_ENABLE_IO_FOR_LOG);
 
 	return 0;
 }
-- 
1.8.3.2
