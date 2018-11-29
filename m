Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FEDC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:28:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06060206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06060206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4353022qm8zDqyc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kF57L5zDqxW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:53 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3DYTp050202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p23vu8sa2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:49 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:45 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3GjEd60096590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBB664203F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F55842047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0F73DA0306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:43 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/eeh: remove sw_state from eeh_unfreeze_pe()
Date: Thu, 29 Nov 2018 14:16:38 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1543460917.git.sbobroff@linux.ibm.com>
References: <cover.1543460917.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-4275-0000-0000-000002E8522C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-4276-0000-0000-000037F59478
Message-Id: <286fce650f5721097d28293a9861a27328e6effe.1543460917.git.sbobroff@linux.ibm.com>
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

eeh_unfreeze_pe() performs two operations: unfreezing a PE (which may
cause firmware to unfreeze child PEs as well) and de-isolating the PE
and it's children.

To simplify this and support future work, separate out the
de-isolation and perform it at the call sites (when necessary).

There should be no change in behaviour.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  2 +-
 arch/powerpc/kernel/eeh.c        | 18 ++++++++++--------
 arch/powerpc/kernel/eeh_driver.c |  2 +-
 arch/powerpc/kernel/eeh_sysfs.c  |  3 ++-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8b596d096ebe..2ff123f745cc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -293,7 +293,7 @@ void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
-int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state);
+int eeh_unfreeze_pe(struct eeh_pe *pe);
 int eeh_pe_reset_and_recover(struct eeh_pe *pe);
 int eeh_dev_open(struct pci_dev *pdev);
 void eeh_dev_release(struct pci_dev *pdev);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6cae6b56ffd6..ac8e69ee93a7 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -823,7 +823,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-		eeh_unfreeze_pe(pe, false);
+		eeh_unfreeze_pe(pe);
 		if (!(pe->type & EEH_PE_VF))
 			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
@@ -1309,7 +1309,7 @@ void eeh_remove_device(struct pci_dev *dev)
 	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
-int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state)
+int eeh_unfreeze_pe(struct eeh_pe *pe)
 {
 	int ret;
 
@@ -1327,10 +1327,6 @@ int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state)
 		return ret;
 	}
 
-	/* Clear software isolated state */
-	if (sw_state && (pe->state & EEH_PE_ISOLATED))
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
-
 	return ret;
 }
 
@@ -1382,7 +1378,10 @@ static int eeh_pe_change_owner(struct eeh_pe *pe)
 		}
 	}
 
-	return eeh_unfreeze_pe(pe, true);
+	ret = eeh_unfreeze_pe(pe);
+	if (!ret)
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+	return ret;
 }
 
 /**
@@ -1639,7 +1638,10 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
 	}
 
 	/* The PE is still in frozen state */
-	return eeh_unfreeze_pe(pe, true);
+	ret = eeh_unfreeze_pe(pe);
+	if (!ret)
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+	return ret;
 }
 
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index aa86a42d98f2..0109d5d7fe63 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -598,7 +598,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *root)
 
 	eeh_for_each_pe(root, pe) {
 		for (i = 0; i < 3; i++)
-			if (!eeh_unfreeze_pe(pe, false))
+			if (!eeh_unfreeze_pe(pe))
 				break;
 		if (i >= 3)
 			return -EIO;
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index deed906dd8f1..0731d2f01dd9 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -82,8 +82,9 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 	if (!(edev->pe->state & EEH_PE_ISOLATED))
 		return count;
 
-	if (eeh_unfreeze_pe(edev->pe, true))
+	if (eeh_unfreeze_pe(edev->pe))
 		return -EIO;
+	eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED);
 
 	return count;
 }
-- 
2.19.0.2.gcad72f5712

