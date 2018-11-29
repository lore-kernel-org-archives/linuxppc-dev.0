Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84564C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA42B20834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA42B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4352mT10yjzDqxt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kC5jdKzDqxd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:51 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3Dadq076092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:49 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p22mckx55-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:49 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3Giel2032012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F0FB4C059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A6254C04A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0A4EFA0300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:43 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc/eeh: Cleanup eeh_pe_clear_frozen_state()
Date: Thu, 29 Nov 2018 14:16:37 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1543460917.git.sbobroff@linux.ibm.com>
References: <cover.1543460917.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-0020-0000-0000-000002EF540D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-0021-0000-0000-0000213EB0F9
Message-Id: <44d3c23aa1c58abb6e1790e68b34e613a7ec6909.1543460917.git.sbobroff@linux.ibm.com>
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

The 'clear_sw_state' parameter for eeh_pe_clear_frozen_state() is
redundant because it has no effect (except in the rare case of a
hardware error part way through unfreezing a tree of PEs, where it
would dangerously allow partial de-isolation before returning
failure).

It is passed down to __eeh_pe_clear_frozen_state(), and from there to
eeh_unfreeze_pe(), where it causes EEH_PE_ISOLATED to be removed
from the state of each PE during the traversal.  However, when the
traversal finishes, EEH_PE_ISOLATED is unconditionally removed by a
call to eeh_pe_state_clear() regardless of the parameter's value.

So remove the flag and pass false to eeh_unfreeze_pe() (to avoid the
rare case described above, as it was before the flag was introduced).
Also, perform the recursion directly in the function and eliminate a
bit of boilerplate.

There should be no change in functionality, except as mentioned above.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 40 +++++++++++---------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9446248eb6b8..aa86a42d98f2 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -591,34 +591,20 @@ static void *eeh_pe_detach_dev(struct eeh_pe *pe, void *userdata)
  * PE reset (for 3 times), we try to clear the frozen state
  * for 3 times as well.
  */
-static void *__eeh_clear_pe_frozen_state(struct eeh_pe *pe, void *flag)
+static int eeh_clear_pe_frozen_state(struct eeh_pe *root)
 {
-	bool clear_sw_state = *(bool *)flag;
-	int i, rc = 1;
-
-	for (i = 0; rc && i < 3; i++)
-		rc = eeh_unfreeze_pe(pe, clear_sw_state);
+	struct eeh_pe *pe;
+	int i;
 
-	/* Stop immediately on any errors */
-	if (rc) {
-		pr_warn("%s: Failure %d unfreezing PHB#%x-PE#%x\n",
-			__func__, rc, pe->phb->global_number, pe->addr);
-		return (void *)pe;
+	eeh_for_each_pe(root, pe) {
+		for (i = 0; i < 3; i++)
+			if (!eeh_unfreeze_pe(pe, false))
+				break;
+		if (i >= 3)
+			return -EIO;
 	}
-
-	return NULL;
-}
-
-static int eeh_clear_pe_frozen_state(struct eeh_pe *pe,
-				     bool clear_sw_state)
-{
-	void *rc;
-
-	rc = eeh_pe_traverse(pe, __eeh_clear_pe_frozen_state, &clear_sw_state);
-	if (!rc)
-		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
-
-	return rc ? -EIO : 0;
+	eeh_pe_state_clear(root, EEH_PE_ISOLATED);
+	return 0;
 }
 
 int eeh_pe_reset_and_recover(struct eeh_pe *pe)
@@ -643,7 +629,7 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	}
 
 	/* Unfreeze the PE */
-	ret = eeh_clear_pe_frozen_state(pe, true);
+	ret = eeh_clear_pe_frozen_state(pe);
 	if (ret) {
 		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		return ret;
@@ -716,7 +702,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	eeh_pe_restore_bars(pe);
 
 	/* Clear frozen state */
-	rc = eeh_clear_pe_frozen_state(pe, false);
+	rc = eeh_clear_pe_frozen_state(pe);
 	if (rc) {
 		pci_unlock_rescan_remove();
 		return rc;
-- 
2.19.0.2.gcad72f5712

