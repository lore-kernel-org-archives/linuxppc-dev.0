Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB14C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B20206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B20206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4352vP11RWzDr3R
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kD24j4zDqxf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:52 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3DXEP058706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p26q8u0u3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:50 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3GkH662390324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2559A42045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6FF74203F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:45 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 358B1A0385
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:43 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] powerpc/eeh: Correct retries in eeh_pe_reset_full()
Date: Thu, 29 Nov 2018 14:16:42 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1543460917.git.sbobroff@linux.ibm.com>
References: <cover.1543460917.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-0028-0000-0000-000003231710
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-0029-0000-0000-000023DF2550
Message-Id: <157c0f87f60432aea1b79a020d8b384a5e0e7857.1543460917.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=783 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Currently, eeh_pe_reset_full() will only attempt to reset a PE more
than once if activating the reset state and deactivating it both
succeed, but later polling shows that it hasn't become active.

Change this so that it will try up to three times for any reason other
than an unrecoverable slot error and adjust the message generation so
that it's clear weather the reset has ultimately succeeded or failed.
This allows the reset to succeed in some situations where it would
currently fail.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index df02f55fdfa1..528caf857428 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -912,7 +912,7 @@ int eeh_pe_reset_full(struct eeh_pe *pe, bool include_passed)
 	int reset_state = (EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
 	int type = EEH_RESET_HOT;
 	unsigned int freset = 0;
-	int i, state, ret;
+	int i, state = 0, ret;
 
 	/*
 	 * Determine the type of reset to perform - hot or fundamental.
@@ -930,28 +930,32 @@ int eeh_pe_reset_full(struct eeh_pe *pe, bool include_passed)
 	/* Make three attempts at resetting the bus */
 	for (i = 0; i < 3; i++) {
 		ret = eeh_pe_reset(pe, type, include_passed);
-		if (ret)
-			break;
-
-		ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE, include_passed);
-		if (ret)
-			break;
+		if (!ret)
+			ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE,
+					   include_passed);
+		if (ret) {
+			ret = -EIO;
+			pr_warn("EEH: Failure %d resetting PHB#%x-PE#%x (attempt %d)\n\n",
+				state, pe->phb->global_number, pe->addr, i + 1);
+			continue;
+		}
+		if (i)
+			pr_warn("EEH: PHB#%x-PE#%x: Successful reset (attempt %d)\n",
+				pe->phb->global_number, pe->addr, i + 1);
 
 		/* Wait until the PE is in a functioning state */
 		state = eeh_wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
 		if (state < 0) {
-			pr_warn("%s: Unrecoverable slot failure on PHB#%x-PE#%x",
-				__func__, pe->phb->global_number, pe->addr);
+			pr_warn("EEH: Unrecoverable slot failure on PHB#%x-PE#%x",
+				pe->phb->global_number, pe->addr);
 			ret = -ENOTRECOVERABLE;
 			break;
 		}
 		if (eeh_state_active(state))
 			break;
-
-		/* Set error in case this is our last attempt */
-		ret = -EIO;
-		pr_warn("%s: Failure %d resetting PHB#%x-PE#%x\n (%d)\n",
-			__func__, state, pe->phb->global_number, pe->addr, (i + 1));
+		else
+			pr_warn("EEH: PHB#%x-PE#%x: Slot inactive after reset: 0x%x (attempt %d)\n",
+				pe->phb->global_number, pe->addr, state, i + 1);
 	}
 
 	/* Resetting the PE may have unfrozen child PEs. If those PEs have been
-- 
2.19.0.2.gcad72f5712

