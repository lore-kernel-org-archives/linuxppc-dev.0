Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C2E72C03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:13:00 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 05:12:56 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D357B1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:05:44 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6NBB6cG351228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:11:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6NBB438023619
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:11:05 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] powerpc/eeh: Tranverse EEH devices with safe mode
Date: Tue, 23 Jul 2013 19:10:51 +0800
Message-Id: <1374577856-1712-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
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
