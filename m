Return-Path: <maurosr@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406n8S4dBJzF21k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 13:11:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2N29K4v139752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:11:14 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvkgh9s44-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:11:14 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maurosr@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 20:11:13 -0600
From: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: kernel@gpiccoli.net
Subject: [PATCH] powerpc/eeh: Avoid misleading message "EEH: no capable
 adapters found"
Date: Thu, 22 Mar 2018 23:10:52 -0300
Message-Id: <1521771052-5973-1-git-send-email-maurosr@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to recent refactoring in EEH in:
commit b9fde58db7e5 ("powerpc/powernv: Rework EEH initialization on
powernv")
a misleading message was seen in the kernel message buffer:

[    0.108431] EEH: PowerNV platform initialized
[    0.589979] EEH: No capable adapters found

This happened due to the removal of the initialization delay for powernv
platform.

Even though the EEH infrastructure for the devices is eventually
initialized and still works just fine the eeh device probe step is
postponed in order to assure the PEs are created. Later
pnv_eeh_post_init does the probe devices job but at that point the
message was already shown right after eeh_init flow.

This patch introduces a new flag EEH_POSTPONED_PROBE to represent that
temporary state and avoid the message mentioned above and showing the
follow one instead:

[    0.107724] EEH: PowerNV platform initialized
[    4.844825] EEH: PCI Enhanced I/O Error Handling Enabled

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 15 ++++++++-------
 arch/powerpc/kernel/eeh.c                    |  2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 12 +++++++++++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fd37cc1..d16c3d6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -36,13 +36,14 @@
 #ifdef CONFIG_EEH
 
 /* EEH subsystem flags */
-#define EEH_ENABLED		0x01	/* EEH enabled		*/
-#define EEH_FORCE_DISABLED	0x02	/* EEH disabled		*/
-#define EEH_PROBE_MODE_DEV	0x04	/* From PCI device	*/
-#define EEH_PROBE_MODE_DEVTREE	0x08	/* From device tree	*/
-#define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid	*/
-#define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log	*/
-#define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately	*/
+#define EEH_ENABLED		0x01	/* EEH enabled			     */
+#define EEH_FORCE_DISABLED	0x02	/* EEH disabled			     */
+#define EEH_PROBE_MODE_DEV	0x04	/* From PCI device		     */
+#define EEH_PROBE_MODE_DEVTREE	0x08	/* From device tree		     */
+#define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid		     */
+#define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log		     */
+#define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately		     */
+#define EEH_POSTPONED_PROBE	0x80    /* Powernv may postpone device probe */
 
 /*
  * Delay for PE reset, all in ms
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2b9df00..179ca84 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1092,7 +1092,7 @@ static int eeh_init(void)
 
 	if (eeh_enabled())
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
-	else
+	else if (!eeh_has_flag(EEH_POSTPONED_PROBE))
 		pr_info("EEH: No capable adapters found\n");
 
 	return ret;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 33c86c1..9845460 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -223,6 +223,14 @@ int pnv_eeh_post_init(void)
 	eeh_probe_devices();
 	eeh_addr_cache_build();
 
+	if (eeh_has_flag(EEH_POSTPONED_PROBE)) {
+		eeh_clear_flag(EEH_POSTPONED_PROBE);
+		if (eeh_enabled())
+			pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
+		else
+			pr_info("EEH: No capable adapters found\n");
+	}
+
 	/* Register OPAL event notifier */
 	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
 	if (eeh_event_irq < 0) {
@@ -384,8 +392,10 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 		return NULL;
 
 	/* Skip if we haven't probed yet */
-	if (phb->ioda.pe_rmap[config_addr] == IODA_INVALID_PE)
+	if (phb->ioda.pe_rmap[config_addr] == IODA_INVALID_PE) {
+		eeh_add_flag(EEH_POSTPONED_PROBE);
 		return NULL;
+	}
 
 	/* Initialize eeh device */
 	edev->class_code = pdn->class_code;
-- 
1.8.3.1
