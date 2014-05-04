Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B878B14018C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:51 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 09:28:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5D7863578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s44N7T653408318
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:07:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s44NSjvV002681
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:28:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc/eeh: Report frozen parent PE prior to child PE
Date: Mon,  5 May 2014 09:29:03 +1000
Message-Id: <1399246144-20247-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399246144-20247-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399246144-20247-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we have the corner case of frozen parent and child PE at the
same time, we have to handle the frozen parent PE prior to the
child. Without clearning the frozen state on parent PE, the child
PE can't be recovered successfully.

The patch searches the EEH PE hierarchy tree and returns the toppest
frozen PE to be handled. It ensures the frozen parent PE will be
handled prior to child PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 | 27 ++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9f8de75..33d683a 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -357,10 +357,11 @@ out:
 int eeh_dev_check_failure(struct eeh_dev *edev)
 {
 	int ret;
+	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	unsigned long flags;
 	struct device_node *dn;
 	struct pci_dev *dev;
-	struct eeh_pe *pe;
+	struct eeh_pe *pe, *parent_pe;
 	int rc = 0;
 	const char *location;
 
@@ -438,14 +439,34 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 */
 	if ((ret < 0) ||
 	    (ret == EEH_STATE_NOT_SUPPORT) ||
-	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
-	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
+	    ((ret & active_flags) == active_flags)) {
 		eeh_stats.false_positives++;
 		pe->false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
 
+	/*
+	 * It should be corner case that the parent PE has been
+	 * put into frozen state as well. We should take care
+	 * that at first.
+	 */
+	parent_pe = pe->parent;
+	while (parent_pe) {
+		/* Hit the ceiling ? */
+		if (parent_pe->type & EEH_PE_PHB)
+			break;
+
+		/* Frozen parent PE ? */
+		ret = eeh_ops->get_state(parent_pe, NULL);
+		if (ret > 0 &&
+		    (ret & active_flags) != active_flags)
+			pe = parent_pe;
+
+		/* Next parent level */
+		parent_pe = parent_pe->parent;
+	}
+
 	eeh_stats.slot_resets++;
 
 	/* Avoid repeated reports of this failure, including problems
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index e5b88c5..65feec6 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -783,11 +783,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
-	struct eeh_pe *phb_pe;
+	struct eeh_pe *phb_pe, *parent_pe;
 	u64 frozen_pe_no;
+	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	u16 err_type, severity;
 	long rc;
-	int ret = EEH_NEXT_ERR_NONE;
+	int state, ret = EEH_NEXT_ERR_NONE;
 
 	/*
 	 * While running here, it's safe to purge the event queue.
@@ -920,6 +921,31 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		}
 
 		/*
+		 * We probably have the frozen parent PE out there and
+		 * we need have to handle frozen parent PE firstly.
+		 */
+		if (ret == EEH_NEXT_ERR_FROZEN_PE) {
+			parent_pe = (*pe)->parent;
+			while (parent_pe) {
+				/* Hit the ceiling ? */
+				if (parent_pe->type & EEH_PE_PHB)
+					break;
+
+				/* Frozen parent PE ? */
+				state = ioda_eeh_get_state(parent_pe);
+				if (state > 0 &&
+				    (state & active_flags) != active_flags)
+					*pe = parent_pe;
+
+				/* Next parent level */
+				parent_pe = parent_pe->parent;
+			}
+
+			/* We possibly migrate to another PE */
+			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
+		}
+
+		/*
 		 * If we have no errors on the specific PHB or only
 		 * informative error there, we continue poking it.
 		 * Otherwise, we need actions to be taken by upper
-- 
1.8.3.2
