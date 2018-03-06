Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH2z4FwLzF1Cf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:00:11 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NxZJa049539
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 19:00:09 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gheprjj22-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 19:00:08 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 6 Mar 2018 00:00:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w26004ao51970150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 00:00:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8D55A4055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:53:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FC57A405F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:53:02 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:53:02 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DBDCAA01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:00:01 +1100 (AEDT)
Date: Tue, 6 Mar 2018 11:00:00 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 9/9] powerpc/eeh: Add eeh_state_active() helper
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <2c6264797f9efd44679fa8c8ac4f8beb11a38c18.1520294174.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checking for a "fully active" device state requires testing two flag
bits, which is open coded in several places, so add a function to do
it.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  6 ++++++
 arch/powerpc/kernel/eeh.c                    | 19 ++++++-------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  9 ++-------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fd37cc101f4f..c2266ca61853 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -256,6 +256,12 @@ static inline void eeh_serialize_unlock(unsigned long flags)
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
+static inline bool eeh_state_active(int state)
+{
+	return (state & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
+	== (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+}
+
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2b9df0040d6b..bc640e4c5ca5 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -394,9 +394,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	/* Check PHB state */
 	ret = eeh_ops->get_state(phb_pe, NULL);
 	if ((ret < 0) ||
-	    (ret == EEH_STATE_NOT_SUPPORT) ||
-	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
-	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
+	    (ret == EEH_STATE_NOT_SUPPORT) || eeh_state_active(ret)) {
 		ret = 0;
 		goto out;
 	}
@@ -433,7 +431,6 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 int eeh_dev_check_failure(struct eeh_dev *edev)
 {
 	int ret;
-	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	unsigned long flags;
 	struct device_node *dn;
 	struct pci_dev *dev;
@@ -525,8 +522,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * state, PE is in good state.
 	 */
 	if ((ret < 0) ||
-	    (ret == EEH_STATE_NOT_SUPPORT) ||
-	    ((ret & active_flags) == active_flags)) {
+	    (ret == EEH_STATE_NOT_SUPPORT) || eeh_state_active(ret)) {
 		eeh_stats.false_positives++;
 		pe->false_positives++;
 		rc = 0;
@@ -546,8 +542,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 
 		/* Frozen parent PE ? */
 		ret = eeh_ops->get_state(parent_pe, NULL);
-		if (ret > 0 &&
-		    (ret & active_flags) != active_flags)
+		if (ret > 0 && !eeh_state_active(ret))
 			pe = parent_pe;
 
 		/* Next parent level */
@@ -888,7 +883,6 @@ static void *eeh_set_dev_freset(void *data, void *flag)
  */
 int eeh_pe_reset_full(struct eeh_pe *pe)
 {
-	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	int reset_state = (EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
 	int type = EEH_RESET_HOT;
 	unsigned int freset = 0;
@@ -919,7 +913,7 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
 
 		/* Wait until the PE is in a functioning state */
 		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if ((state & active_flags) == active_flags)
+		if (eeh_state_active(state))
 			break;
 
 		if (state < 0) {
@@ -1352,16 +1346,15 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
 	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
 	struct pci_device_id *id;
-	int flags, ret;
+	int ret;
 
 	/* Check PE state */
-	flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	ret = eeh_ops->get_state(pe, NULL);
 	if (ret < 0 || ret == EEH_STATE_NOT_SUPPORT)
 		return 0;
 
 	/* Unfrozen PE, nothing to do */
-	if ((ret & flags) == flags)
+	if (eeh_state_active(ret))
 		return 0;
 
 	/* Frozen PE, check if it needs PE level reset */
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 33c86c1a1720..ddfc3544d285 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1425,11 +1425,8 @@ static int pnv_eeh_get_pe(struct pci_controller *hose,
 	dev_pe = dev_pe->parent;
 	while (dev_pe && !(dev_pe->type & EEH_PE_PHB)) {
 		int ret;
-		int active_flags = (EEH_STATE_MMIO_ACTIVE |
-				    EEH_STATE_DMA_ACTIVE);
-
 		ret = eeh_ops->get_state(dev_pe, NULL);
-		if (ret <= 0 || (ret & active_flags) == active_flags) {
+		if (ret <= 0 || eeh_state_active(ret)) {
 			dev_pe = dev_pe->parent;
 			continue;
 		}
@@ -1463,7 +1460,6 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	struct eeh_pe *phb_pe, *parent_pe;
 	__be64 frozen_pe_no;
 	__be16 err_type, severity;
-	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	long rc;
 	int state, ret = EEH_NEXT_ERR_NONE;
 
@@ -1626,8 +1622,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 
 				/* Frozen parent PE ? */
 				state = eeh_ops->get_state(parent_pe, NULL);
-				if (state > 0 &&
-				    (state & active_flags) != active_flags)
+				if (state > 0 && !eeh_state_active(state))
 					*pe = parent_pe;
 
 				/* Next parent level */
-- 
2.16.1.74.g9b0b1f47b
