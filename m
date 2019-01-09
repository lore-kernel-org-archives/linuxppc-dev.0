Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B10C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:18:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439BA206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BA206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZV7q3FDVzDq6W
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 00:18:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZV5l6NdjzDqSx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 00:16:59 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x09DG3QL115820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2019 08:16:57 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pwfr0nub6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 08:16:57 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 9 Jan 2019 13:16:55 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Jan 2019 13:16:52 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x09DGpvi25165978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 13:16:51 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BA8EAC05B;
 Wed,  9 Jan 2019 13:16:51 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBE28AC059;
 Wed,  9 Jan 2019 13:16:46 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.149.121])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jan 2019 13:16:46 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Date: Wed,  9 Jan 2019 11:16:45 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19010913-0060-0000-0000-000002F60A97
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010372; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01143981; UDB=6.00595610; IPR=6.00924243; 
 MB=3.00025049; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 13:16:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010913-0061-0000-0000-000047DB45F2
Message-Id: <1547039805-7979-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090112
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
moved a code block around and this block uses a 'msr' variable outside of
the CONFIG_PPC_TRANSACTIONAL_MEM, however the 'msr' variable is declared
inside a CONFIG_PPC_TRANSACTIONAL_MEM block, causing a possible error when
CONFIG_PPC_TRANSACTION_MEM is not defined.

	error: 'msr' undeclared (first use in this function)

This is not causing a compilation error in the mainline kernel, because
'msr' is being used as an argument of MSR_TM_ACTIVE(), which is defined as
the following when CONFIG_PPC_TRANSACTIONAL_MEM is *not* set:

	#define MSR_TM_ACTIVE(x) 0

This patch just fixes this issue avoiding the 'msr' variable usage outside
the CONFIG_PPC_TRANSACTIONAL_MEM block, avoiding trusting in the
MSR_TM_ACTIVE() definition.

Cc: stable@vger.kernel.org
Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Fixes: e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
Signed-off-by: Breno Leitao <leitao@debian.org>
---

NB: Since stable kernels didn't cherry picked 5c784c8414fba ('powerpc/tm:
Remove msr_tm_active()), MSR_TM_ACTIVE() is not defined as 0 for
CONFIG_PPC_TRANSACTIONAL_MEM=n case, thus triggering the compilation error
above.

Tested against stable kernel 4.19.13-rc2 and problem is now fixed when
CONFIG_PPC_TRANSACTIONAL_MEM=n

 arch/powerpc/kernel/signal_64.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index daa28cb72272..8fe698162ab9 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -739,11 +739,12 @@ SYSCALL_DEFINE0(rt_sigreturn)
 		if (restore_tm_sigcontexts(current, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
-	}
+	} else
 #endif
-	/* Fall through, for non-TM restore */
-	if (!MSR_TM_ACTIVE(msr)) {
+	{
 		/*
+		 * Fall through, for non-TM restore
+		 *
 		 * Unset MSR[TS] on the thread regs since MSR from user
 		 * context does not have MSR active, and recheckpoint was
 		 * not called since restore_tm_sigcontexts() was not called
-- 
2.19.0

