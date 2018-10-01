Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A27C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091ED2146D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091ED2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PCbh0b7czF3Bw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 05:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PCW85TTQzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 05:48:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91JdGlO047836
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 15:48:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mus4ta30t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 15:48:01 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 1 Oct 2018 13:48:00 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 13:47:57 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91Jlu8k41418990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 12:47:56 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5D1CBE051;
 Mon,  1 Oct 2018 13:47:56 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DA46BE04F;
 Mon,  1 Oct 2018 13:47:55 -0600 (MDT)
Received: from debra.ibm.com (unknown [9.80.236.140])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 13:47:54 -0600 (MDT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/tm: Avoid SPR flush if TM is disabled
Date: Mon,  1 Oct 2018 16:47:50 -0300
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538423270-17527-1-git-send-email-leitao@debian.org>
References: <1538423270-17527-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18100119-0016-0000-0000-000009394508
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009804; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096446; UDB=6.00566952; IPR=6.00876488; 
 MB=3.00023577; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 19:47:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100119-0017-0000-0000-0000408D0557
Message-Id: <1538423270-17527-2-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=609 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010188
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is a bug in the flush_tmregs_to_thread() function, where it forces
TM SPRs to be saved to the thread even if the TM facility is disabled.

This bug could be reproduced using a simple test case:

  mtspr(SPRN_TEXASR, XX);
  sleep until load_tm == 0
  cause a coredump
  read SPRN_TEXASR in the coredump

In this case, the coredump may contain an invalid SPR, because the
current code is flushing live SPRs (Used by the last thread with TM
active) into the current thread, overwriting the latest SPRs (which were
valid).

This patch checks if TM is enabled for current task before
saving the SPRs, otherwise, the TM is lazily disabled and the thread
value is already up-to-date and could be used directly, and saving is
not required.

Fixes: cd63f3cf1d5 ("powerpc/tm: Fix saving of TM SPRs in core dump")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..e0a2ee865032 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -138,7 +138,12 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 
 	if (MSR_TM_SUSPENDED(mfmsr())) {
 		tm_reclaim_current(TM_CAUSE_SIGNAL);
-	} else {
+	} else if (tm_enabled(tsk)) {
+		/*
+		 * Only flush TM SPRs to the thread if TM was enabled,
+		 * otherwise (TM lazily disabled), the thread already
+		 * contains the latest SPR value
+		 */
 		tm_enable();
 		tm_save_sprs(&(tsk->thread));
 	}
-- 
2.19.0

