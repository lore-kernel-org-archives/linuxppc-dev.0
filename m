Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D3FC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:30:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF92F206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF92F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43532S3LG7zDqfC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kG04FNzDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:53 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3DXm6044523
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:51 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p27mr8tsv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:51 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3Gk2G8061248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69D68AE04D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C595AAE053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2CE13A037D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:43 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/eeh: Improve recovery of passed-through devices
Date: Thu, 29 Nov 2018 14:16:41 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1543460917.git.sbobroff@linux.ibm.com>
References: <cover.1543460917.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-0012-0000-0000-000002D1CFB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-0013-0000-0000-0000210716CD
Message-Id: <ca5b9614dca227df55245983ba54612f9f634632.1543460917.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Currently, the EEH recovery process considers passed-through devices
as if they were not EEH-aware, which can cause them to be removed as
part of recovery.  Because device removal requires cooperation from
the guest, this may lead to the process stalling or deadlocking.
Also, if devices are removed on the host side, they will be removed
from their IOMMU group, making recovery in the guest impossible.

Therefore, alter the recovery process so that passed-through devices
are not removed but are instead left frozen (and marked isolated)
until the guest performs it's own recovery.  If firmware thaws a
passed-through PE because it's parent PE has been thawed (because it
was not passed through), re-freeze it.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h     |  2 +-
 arch/powerpc/include/asm/ppc-pci.h |  2 +-
 arch/powerpc/kernel/eeh.c          | 47 +++++++++++++++++++++++-------
 arch/powerpc/kernel/eeh_driver.c   | 32 +++++++++-----------
 drivers/vfio/vfio_spapr_eeh.c      |  6 ++--
 5 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2ff123f745cc..0b655810f32d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -300,7 +300,7 @@ void eeh_dev_release(struct pci_dev *pdev);
 struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
 int eeh_pe_set_option(struct eeh_pe *pe, int option);
 int eeh_pe_get_state(struct eeh_pe *pe);
-int eeh_pe_reset(struct eeh_pe *pe, int option);
+int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
 int eeh_pe_configure(struct eeh_pe *pe);
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 		      unsigned long addr, unsigned long mask);
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 08e094eaeccf..f191ef0d2a0a 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -53,7 +53,7 @@ void eeh_addr_cache_rmv_dev(struct pci_dev *dev);
 struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
 int eeh_pci_enable(struct eeh_pe *pe, int function);
-int eeh_pe_reset_full(struct eeh_pe *pe);
+int eeh_pe_reset_full(struct eeh_pe *pe, bool include_passed);
 void eeh_save_bars(struct eeh_dev *edev);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 052512e58b05..df02f55fdfa1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -877,6 +877,24 @@ static void *eeh_set_dev_freset(struct eeh_dev *edev, void *flag)
 	return NULL;
 }
 
+static void eeh_pe_refreeze_passed(struct eeh_pe *root)
+{
+	struct eeh_pe *pe;
+	int state;
+
+	eeh_for_each_pe(root, pe) {
+		if (eeh_pe_passed(pe)) {
+			state = eeh_ops->get_state(pe, NULL);
+			if (state &
+			   (EEH_STATE_MMIO_ACTIVE | EEH_STATE_MMIO_ENABLED)) {
+				pr_info("EEH: Passed-through PE PHB#%x-PE#%x was thawed by reset, re-freezing for safety.\n",
+					pe->phb->global_number, pe->addr);
+				eeh_pe_set_option(pe, EEH_OPT_FREEZE_PE);
+			}
+		}
+	}
+}
+
 /**
  * eeh_pe_reset_full - Complete a full reset process on the indicated PE
  * @pe: EEH PE
@@ -889,7 +907,7 @@ static void *eeh_set_dev_freset(struct eeh_dev *edev, void *flag)
  *
  * This function will attempt to reset a PE three times before failing.
  */
-int eeh_pe_reset_full(struct eeh_pe *pe)
+int eeh_pe_reset_full(struct eeh_pe *pe, bool include_passed)
 {
 	int reset_state = (EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
 	int type = EEH_RESET_HOT;
@@ -911,11 +929,11 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
 
 	/* Make three attempts at resetting the bus */
 	for (i = 0; i < 3; i++) {
-		ret = eeh_pe_reset(pe, type);
+		ret = eeh_pe_reset(pe, type, include_passed);
 		if (ret)
 			break;
 
-		ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE);
+		ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE, include_passed);
 		if (ret)
 			break;
 
@@ -936,6 +954,12 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
 			__func__, state, pe->phb->global_number, pe->addr, (i + 1));
 	}
 
+	/* Resetting the PE may have unfrozen child PEs. If those PEs have been
+	 * (potentially) passed through to a guest, re-freeze them:
+	 */
+	if (!include_passed)
+		eeh_pe_refreeze_passed(pe);
+
 	eeh_pe_state_clear(pe, reset_state, true);
 	return ret;
 }
@@ -1611,13 +1635,12 @@ int eeh_pe_get_state(struct eeh_pe *pe)
 }
 EXPORT_SYMBOL_GPL(eeh_pe_get_state);
 
-static int eeh_pe_reenable_devices(struct eeh_pe *pe)
+static int eeh_pe_reenable_devices(struct eeh_pe *pe, bool include_passed)
 {
 	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
 	int ret = 0;
 
-	/* Restore config space */
 	eeh_pe_restore_bars(pe);
 
 	/*
@@ -1638,9 +1661,13 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
 	}
 
 	/* The PE is still in frozen state */
-	ret = eeh_unfreeze_pe(pe);
+	if (include_passed || !eeh_pe_passed(pe)) {
+		ret = eeh_unfreeze_pe(pe);
+	} else
+		pr_info("EEH: Note: Leaving passthrough PHB#%x-PE#%x frozen.\n",
+			pe->phb->global_number, pe->addr);
 	if (!ret)
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED, true);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED, include_passed);
 	return ret;
 }
 
@@ -1654,7 +1681,7 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
  * indicated type, either fundamental reset or hot reset.
  * PE reset is the most important part for error recovery.
  */
-int eeh_pe_reset(struct eeh_pe *pe, int option)
+int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed)
 {
 	int ret = 0;
 
@@ -1668,11 +1695,11 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 	switch (option) {
 	case EEH_RESET_DEACTIVATE:
 		ret = eeh_ops->reset(pe, option);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, true);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED, include_passed);
 		if (ret)
 			break;
 
-		ret = eeh_pe_reenable_devices(pe);
+		ret = eeh_pe_reenable_devices(pe, include_passed);
 		break;
 	case EEH_RESET_HOT:
 	case EEH_RESET_FUNDAMENTAL:
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 61c177ebb230..ad7be478750f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -510,22 +510,11 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 	 * support EEH. So we just care about PCI devices for
 	 * simplicity here.
 	 */
-	if (!dev || (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE))
-		return NULL;
-
-	/*
-	 * We rely on count-based pcibios_release_device() to
-	 * detach permanently offlined PEs. Unfortunately, that's
-	 * not reliable enough. We might have the permanently
-	 * offlined PEs attached, but we needn't take care of
-	 * them and their child devices.
-	 */
-	if (eeh_dev_removed(edev))
+	if (!eeh_edev_actionable(edev) ||
+	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE))
 		return NULL;
 
 	if (rmv_data) {
-		if (eeh_pe_passed(edev->pe))
-			return NULL;
 		driver = eeh_pcid_get(dev);
 		if (driver) {
 			if (driver->err_handler &&
@@ -539,8 +528,8 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 	}
 
 	/* Remove it from PCI subsystem */
-	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
-		 pci_name(dev));
+	pr_info("EEH: Removing %s without EEH sensitive driver\n",
+		pci_name(dev));
 	edev->mode |= EEH_DEV_DISCONNECTED;
 	if (rmv_data)
 		rmv_data->removed_dev_count++;
@@ -624,7 +613,7 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
 
 	/* Issue reset */
-	ret = eeh_pe_reset_full(pe);
+	ret = eeh_pe_reset_full(pe, true);
 	if (ret) {
 		eeh_pe_state_clear(pe, EEH_PE_RECOVERING, true);
 		return ret;
@@ -664,6 +653,11 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	time64_t tstamp;
 	int cnt, rc;
 	struct eeh_dev *edev;
+	struct eeh_pe *tmp_pe;
+	bool any_passed = false;
+
+	eeh_for_each_pe(pe, tmp_pe)
+		any_passed |= eeh_pe_passed(tmp_pe);
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -676,7 +670,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * into pci_hp_add_devices().
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
-	if (driver_eeh_aware || (pe->type & EEH_PE_VF)) {
+	if (any_passed || driver_eeh_aware || (pe->type & EEH_PE_VF)) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 	} else {
 		pci_lock_rescan_remove();
@@ -693,7 +687,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * config accesses. So we prefer to block them. However, controlled
 	 * PCI config accesses initiated from EEH itself are allowed.
 	 */
-	rc = eeh_pe_reset_full(pe);
+	rc = eeh_pe_reset_full(pe, false);
 	if (rc)
 		return rc;
 
@@ -704,7 +698,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	eeh_pe_restore_bars(pe);
 
 	/* Clear frozen state */
-	rc = eeh_clear_pe_frozen_state(pe, true);
+	rc = eeh_clear_pe_frozen_state(pe, false);
 	if (rc) {
 		pci_unlock_rescan_remove();
 		return rc;
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 38edeb4729a9..1a742fe8f6db 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -74,13 +74,13 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 			ret = eeh_pe_get_state(pe);
 			break;
 		case VFIO_EEH_PE_RESET_DEACTIVATE:
-			ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE);
+			ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE, true);
 			break;
 		case VFIO_EEH_PE_RESET_HOT:
-			ret = eeh_pe_reset(pe, EEH_RESET_HOT);
+			ret = eeh_pe_reset(pe, EEH_RESET_HOT, true);
 			break;
 		case VFIO_EEH_PE_RESET_FUNDAMENTAL:
-			ret = eeh_pe_reset(pe, EEH_RESET_FUNDAMENTAL);
+			ret = eeh_pe_reset(pe, EEH_RESET_FUNDAMENTAL, true);
 			break;
 		case VFIO_EEH_PE_CONFIGURE:
 			ret = eeh_pe_configure(pe);
-- 
2.19.0.2.gcad72f5712

