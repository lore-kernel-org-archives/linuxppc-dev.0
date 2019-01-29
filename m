Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B616C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 06:17:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0C62148E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 06:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0C62148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pbrn6J0DzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:17:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pbq05XSTzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 17:16:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0T697Fu052642
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 01:16:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qaf7q68bq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 01:16:09 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Tue, 29 Jan 2019 06:16:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 06:16:04 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0T6G25a5243216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 06:16:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 851E511C082;
 Tue, 29 Jan 2019 06:16:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAF6611C050;
 Tue, 29 Jan 2019 06:16:00 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.223.28])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 06:16:00 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PATCH v3] cxl: Wrap iterations over afu slices inside 'afu_list_lock'
Date: Tue, 29 Jan 2019 11:45:58 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012906-0008-0000-0000-000002B74ACC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012906-0009-0000-0000-000022238BFE
Message-Id: <20190129061558.2122-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290046
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Within cxl module, iteration over array 'adapter->slices' may be racy
at few points as it might be simultaneously read during an EEH and its
contents being set to NULL while driver is being unloaded or unbound
from the adapter. This might result in a NULL pointer to 'struct afu'
being de-referenced during an EEH thereby causing a kernel oops.

This patch fixes this by making sure that all access to the array
'adapter->slices' is wrapped within the context of spin-lock
'adapter->afu_list_lock'.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v3:
* Updated a slice loop in cxl_pci_error_detectected() to ignore NULL
  slices [Fred]
* Added a NULL AFU check in cxl_pci_slot_reset() [Fred]

v2:
* Fixed a wrong comparison of non-null pointer [Fred]
* Moved a call to cxl_vphb_error_detected() within a branch that
  checks for not null AFU pointer in 'adapter->slices' [Fred]
* Removed a misleading comment in code.
---
 drivers/misc/cxl/guest.c |  2 ++
 drivers/misc/cxl/pci.c   | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 5d28d9e454f5..08f4a512afad 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -267,6 +267,7 @@ static int guest_reset(struct cxl *adapter)
 	int i, rc;
 
 	pr_devel("Adapter reset request\n");
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		if ((afu = adapter->afu[i])) {
 			pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
@@ -283,6 +284,7 @@ static int guest_reset(struct cxl *adapter)
 			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
 		}
 	}
+	spin_unlock(&adapter->afu_list_lock);
 	return rc;
 }
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c79ba1c699ad..300531d6136f 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1805,7 +1805,7 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
-	if (afu->phb == NULL)
+	if (afu == NULL || afu->phb == NULL)
 		return result;
 
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -1832,7 +1832,8 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 {
 	struct cxl *adapter = pci_get_drvdata(pdev);
 	struct cxl_afu *afu;
-	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
 	int i;
 
 	/* At this point, we could still have an interrupt pending.
@@ -1843,6 +1844,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 
 	/* If we're permanently dead, give up. */
 	if (state == pci_channel_io_perm_failure) {
+		spin_lock(&adapter->afu_list_lock);
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
 			/*
@@ -1851,6 +1853,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 			 */
 			cxl_vphb_error_detected(afu, state);
 		}
+		spin_unlock(&adapter->afu_list_lock);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -1932,11 +1935,17 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 	 *     * In slot_reset, free the old resources and allocate new ones.
 	 *     * In resume, clear the flag to allow things to start.
 	 */
+
+	/* Make sure no one else changes the afu list */
+	spin_lock(&adapter->afu_list_lock);
+
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-		afu_result = cxl_vphb_error_detected(afu, state);
+		if (afu == NULL)
+			continue;
 
+		afu_result = cxl_vphb_error_detected(afu, state);
 		cxl_context_detach_all(afu);
 		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
 		pci_deconfigure_afu(afu);
@@ -1948,6 +1957,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 			 (result == PCI_ERS_RESULT_NEED_RESET))
 			result = PCI_ERS_RESULT_NONE;
 	}
+	spin_unlock(&adapter->afu_list_lock);
 
 	/* should take the context lock here */
 	if (cxl_adapter_context_lock(adapter) != 0)
@@ -1980,14 +1990,18 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 	 */
 	cxl_adapter_context_unlock(adapter);
 
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
+		if (afu == NULL)
+			continue;
+
 		if (pci_configure_afu(afu, adapter, pdev))
-			goto err;
+			goto err_unlock;
 
 		if (cxl_afu_select_best_mode(afu))
-			goto err;
+			goto err_unlock;
 
 		if (afu->phb == NULL)
 			continue;
@@ -1999,16 +2013,16 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 			ctx = cxl_get_context(afu_dev);
 
 			if (ctx && cxl_release_context(ctx))
-				goto err;
+				goto err_unlock;
 
 			ctx = cxl_dev_context_init(afu_dev);
 			if (IS_ERR(ctx))
-				goto err;
+				goto err_unlock;
 
 			afu_dev->dev.archdata.cxl_ctx = ctx;
 
 			if (cxl_ops->afu_check_and_enable(afu))
-				goto err;
+				goto err_unlock;
 
 			afu_dev->error_state = pci_channel_io_normal;
 
@@ -2029,8 +2043,13 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 				result = PCI_ERS_RESULT_DISCONNECT;
 		}
 	}
+
+	spin_unlock(&adapter->afu_list_lock);
 	return result;
 
+err_unlock:
+	spin_unlock(&adapter->afu_list_lock);
+
 err:
 	/* All the bits that happen in both error_detected and cxl_remove
 	 * should be idempotent, so we don't need to worry about leaving a mix
@@ -2051,10 +2070,11 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 	 * This is not the place to be checking if everything came back up
 	 * properly, because there's no return value: do that in slot_reset.
 	 */
+	spin_lock(&adapter->afu_list_lock);
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-		if (afu->phb == NULL)
+		if (afu == NULL || afu->phb == NULL)
 			continue;
 
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -2063,6 +2083,7 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 				afu_dev->driver->err_handler->resume(afu_dev);
 		}
 	}
+	spin_unlock(&adapter->afu_list_lock);
 }
 
 static const struct pci_error_handlers cxl_err_handler = {
-- 
2.20.1

