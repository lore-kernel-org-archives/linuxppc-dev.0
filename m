Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A2C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:26:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E15206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E15206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4352xq0TGJzDqxj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kD2nTlzDqxg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:52 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3DZo1077208
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:50 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p26bsbthx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:49 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3GjDG65994830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E48E54C040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B6DF4C050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 180A8A0321
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:43 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/eeh: Add include_passed to eeh_pe_state_clear()
Date: Thu, 29 Nov 2018 14:16:39 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1543460917.git.sbobroff@linux.ibm.com>
References: <cover.1543460917.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-0012-0000-0000-000002D1CFB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-0013-0000-0000-0000210716CA
Message-Id: <1a3f721c08135287b57308bea295b0dd0ef1b45f.1543460917.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290024
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a parameter to eeh_pe_state_clear() that allows passed-through PEs
to be excluded. Update callers to always pass true so that there is no
change in behaviour.

Also refactor to use direct traversal, to allow the removal of some
boilerplate.

This is to prepare for follow-up work for passed-through devices.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h |  2 +-
 arch/powerpc/kernel/eeh.c          | 18 ++++----
 arch/powerpc/kernel/eeh_driver.c   | 20 ++++-----
 arch/powerpc/kernel/eeh_pe.c       | 68 +++++++++++++-----------------
 arch/powerpc/kernel/eeh_sysfs.c    |  2 +-
 5 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index f67da277d652..08e094eaeccf 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -59,7 +59,7 @@ int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
 void eeh_pe_mark_isolated(struct eeh_pe *pe);
-void eeh_pe_state_clear(struct eeh_pe *pe, int state);
+void eeh_pe_state_clear(struct eeh_pe *pe, int state, bool include_passed);
 void eeh_pe_state_mark_with_cfg(struct eeh_pe *pe, int state);
 void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode);
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ac8e69ee93a7..052512e58b05 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -825,13 +825,13 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 		eeh_unfreeze_pe(pe);
 		if (!(pe->type & EEH_PE_VF))
-			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, true);
 		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED, true);
 		break;
 	case pcie_hot_reset:
 		eeh_pe_mark_isolated(pe);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, true);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		if (!(pe->type & EEH_PE_VF))
@@ -840,7 +840,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		break;
 	case pcie_warm_reset:
 		eeh_pe_mark_isolated(pe);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, true);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		if (!(pe->type & EEH_PE_VF))
@@ -848,7 +848,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED | EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED | EEH_PE_CFG_BLOCKED, true);
 		return -EINVAL;
 	};
 
@@ -936,7 +936,7 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
 			__func__, state, pe->phb->global_number, pe->addr, (i + 1));
 	}
 
-	eeh_pe_state_clear(pe, reset_state);
+	eeh_pe_state_clear(pe, reset_state, true);
 	return ret;
 }
 
@@ -1380,7 +1380,7 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
 
 	ret = eeh_unfreeze_pe(pe);
 	if (!ret)
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED, true);
 	return ret;
 }
 
@@ -1640,7 +1640,7 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
 	/* The PE is still in frozen state */
 	ret = eeh_unfreeze_pe(pe);
 	if (!ret)
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED, true);
 	return ret;
 }
 
@@ -1668,7 +1668,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 	switch (option) {
 	case EEH_RESET_DEACTIVATE:
 		ret = eeh_ops->reset(pe, option);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, true);
 		if (ret)
 			break;
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0109d5d7fe63..b2687c14dc40 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -603,7 +603,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *root)
 		if (i >= 3)
 			return -EIO;
 	}
-	eeh_pe_state_clear(root, EEH_PE_ISOLATED);
+	eeh_pe_state_clear(root, EEH_PE_ISOLATED, true);
 	return 0;
 }
 
@@ -624,14 +624,14 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	/* Issue reset */
 	ret = eeh_pe_reset_full(pe);
 	if (ret) {
-		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
 		return ret;
 	}
 
 	/* Unfreeze the PE */
 	ret = eeh_clear_pe_frozen_state(pe);
 	if (ret) {
-		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
 		return ret;
 	}
 
@@ -639,7 +639,7 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
 
 	/* Clear recovery mode */
-	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+	eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
 
 	return 0;
 }
@@ -730,11 +730,11 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 			eeh_add_virt_device(edev);
 		} else {
 			if (!driver_eeh_aware)
-				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
 			pci_hp_add_devices(bus);
 		}
 	}
-	eeh_pe_state_clear(pe, EEH_PE_KEEP);
+	eeh_pe_state_clear(pe, EEH_PE_KEEP, true);
 
 	pe->tstamp = tstamp;
 	pe->freeze_count = cnt;
@@ -886,7 +886,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			 * is still in frozen state. Clear it before
 			 * resuming the PE.
 			 */
-			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+			eeh_pe_state_clear(pe, EEH_PE_ISOLATED, true);
 			result = PCI_ERS_RESULT_RECOVERED;
 		}
 	}
@@ -963,7 +963,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
 			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
 			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
 			pci_lock_rescan_remove();
@@ -973,7 +973,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			return;
 		}
 	}
-	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+	eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
 }
 
 /**
@@ -1055,7 +1055,7 @@ void eeh_handle_special_event(void)
 					continue;
 
 				/* Notify all devices to be down */
-				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
 				eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 				eeh_pe_report(
 					"error_detected(permanent failure)", pe,
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 6fa2032e0594..8b578891f27c 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -657,62 +657,52 @@ void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode)
 }
 
 /**
- * __eeh_pe_state_clear - Clear state for the PE
+ * eeh_pe_state_clear - Clear state for the PE
  * @data: EEH PE
- * @flag: state
+ * @state: state
+ * @include_passed: include passed-through devices?
  *
  * The function is used to clear the indicated state from the
  * given PE. Besides, we also clear the check count of the PE
  * as well.
  */
-static void *__eeh_pe_state_clear(struct eeh_pe *pe, void *flag)
+void eeh_pe_state_clear(struct eeh_pe *root, int state, bool include_passed)
 {
-	int state = *((int *)flag);
+	struct eeh_pe *pe;
 	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
 
-	/* Keep the state of permanently removed PE intact */
-	if (pe->state & EEH_PE_REMOVED)
-		return NULL;
+	eeh_for_each_pe(root, pe) {
+		/* Keep the state of permanently removed PE intact */
+		if (pe->state & EEH_PE_REMOVED)
+			continue;
 
-	pe->state &= ~state;
+		if (!include_passed && eeh_pe_passed(pe))
+			continue;
 
-	/*
-	 * Special treatment on clearing isolated state. Clear
-	 * check count since last isolation and put all affected
-	 * devices to normal state.
-	 */
-	if (!(state & EEH_PE_ISOLATED))
-		return NULL;
+		pe->state &= ~state;
 
-	pe->check_count = 0;
-	eeh_pe_for_each_dev(pe, edev, tmp) {
-		pdev = eeh_dev_to_pci_dev(edev);
-		if (!pdev)
+		/*
+		 * Special treatment on clearing isolated state. Clear
+		 * check count since last isolation and put all affected
+		 * devices to normal state.
+		 */
+		if (!(state & EEH_PE_ISOLATED))
 			continue;
 
-		pdev->error_state = pci_channel_io_normal;
-	}
-
-	/* Unblock PCI config access if required */
-	if (pe->state & EEH_PE_CFG_RESTRICTED)
-		pe->state &= ~EEH_PE_CFG_BLOCKED;
+		pe->check_count = 0;
+		eeh_pe_for_each_dev(pe, edev, tmp) {
+			pdev = eeh_dev_to_pci_dev(edev);
+			if (!pdev)
+				continue;
 
-	return NULL;
-}
+			pdev->error_state = pci_channel_io_normal;
+		}
 
-/**
- * eeh_pe_state_clear - Clear state for the PE and its children
- * @pe: PE
- * @state: state to be cleared
- *
- * When the PE and its children has been recovered from error,
- * we need clear the error state for that. The function is used
- * for the purpose.
- */
-void eeh_pe_state_clear(struct eeh_pe *pe, int state)
-{
-	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
+		/* Unblock PCI config access if required */
+		if (pe->state & EEH_PE_CFG_RESTRICTED)
+			pe->state &= ~EEH_PE_CFG_BLOCKED;
+	}
 }
 
 /*
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 0731d2f01dd9..3fa04dda1737 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -84,7 +84,7 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 
 	if (eeh_unfreeze_pe(edev->pe))
 		return -EIO;
-	eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED);
+	eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED, true);
 
 	return count;
 }
-- 
2.19.0.2.gcad72f5712

