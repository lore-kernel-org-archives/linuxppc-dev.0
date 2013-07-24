Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBE2B2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:17 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 22:25:13 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D71FC38C8063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:09 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PARc33554576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2P9BE031425
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:10 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] powerpc/eeh: Tranverse EEH devices with safe mode
Date: Wed, 24 Jul 2013 10:24:56 +0800
Message-Id: <1374632701-20972-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we're transversing EEH devices by list_for_each_entry().
That's not safe enough because the EEH devices might be removed from
its parent PE while doing iteration. The patch replaces that with
list_for_each_entry_safe().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    4 ++--
 arch/powerpc/kernel/eeh.c      |    4 ++--
 arch/powerpc/kernel/eeh_pe.c   |   10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2ce22d7..e8c411b 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -74,8 +74,8 @@ struct eeh_pe {
 	struct list_head child;		/* Child PEs			*/
 };
 
-#define eeh_pe_for_each_dev(pe, edev) \
-		list_for_each_entry(edev, &pe->edevs, list)
+#define eeh_pe_for_each_dev(pe, edev, tmp) \
+		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
 /*
  * The struct is used to trace EEH state for the associated
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ce81477..56bd458 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -231,7 +231,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 {
 	size_t loglen = 0;
-	struct eeh_dev *edev;
+	struct eeh_dev *edev, *tmp;
 	bool valid_cfg_log = true;
 
 	/*
@@ -251,7 +251,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 		eeh_pe_restore_bars(pe);
 
 		pci_regs_buf[0] = 0;
-		eeh_pe_for_each_dev(pe, edev) {
+		eeh_pe_for_each_dev(pe, edev, tmp) {
 			loglen += eeh_gather_pci_data(edev, pci_regs_buf + loglen,
 						      EEH_PCI_REGS_LOG_LEN - loglen);
 		}
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 32ef409..c8b815e 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -176,7 +176,7 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag)
 {
 	struct eeh_pe *pe;
-	struct eeh_dev *edev;
+	struct eeh_dev *edev, *tmp;
 	void *ret;
 
 	if (!root) {
@@ -186,7 +186,7 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 
 	/* Traverse root PE */
 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
-		eeh_pe_for_each_dev(pe, edev) {
+		eeh_pe_for_each_dev(pe, edev, tmp) {
 			ret = fn(edev, flag);
 			if (ret)
 				return ret;
@@ -501,7 +501,7 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
 	int state = *((int *)flag);
-	struct eeh_dev *tmp;
+	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
 
 	/*
@@ -511,8 +511,8 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
 	 * the PCI device driver.
 	 */
 	pe->state |= state;
-	eeh_pe_for_each_dev(pe, tmp) {
-		pdev = eeh_dev_to_pci_dev(tmp);
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
 		if (pdev)
 			pdev->error_state = pci_channel_io_frozen;
 	}
-- 
1.7.5.4
