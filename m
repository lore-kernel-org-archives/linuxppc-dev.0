Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4421C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2872085B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2872085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q99z2RhHzF35Q
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:19:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8Kv4psWzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:41:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYR1T105879
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:41:05 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nk9xcucbw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:41:05 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:41:04 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:41:00 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CexUK63045644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CE11AC05B;
 Tue,  6 Nov 2018 12:40:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 496C3AC059;
 Tue,  6 Nov 2018 12:40:58 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:58 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 13/14] powerpc/tm: Do not restore TM without SPRs
Date: Tue,  6 Nov 2018 10:40:27 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0052-0000-0000-00000351212E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:41:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0053-0000-0000-00005EAC23DB
Message-Id: <1541508028-31865-14-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=365 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060112
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>, ldufour@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the signal context restore code enables the bit on the MSR
register without restoring the TM SPRs, which can cause undesired side
effects.

This is not correct because if TM is enabled in MSR, it means the TM SPR
registers are valid and updated, which is not correct here. In fact, the
live registers may contain previous' thread SPRs.

Functions check if the register values are valid or not through looking
if the facility is enabled at MSR, as MSR[TM] set means that the TM SPRs
are hot.

When just enabling MSR[TM] without updating the live SPRs, this can cause a
crash, since current TM SPR from previous thread will be saved on the
current thread, and might not have TEXASR[FS] set, for example.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/signal_64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 487c3b6aa2e3..156b90e8ee78 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -478,8 +478,18 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 	 * happened whilst in the signal handler and load_tm overflowed,
 	 * disabling the TM bit. In either case we can end up with an illegal
 	 * TM state leading to a TM Bad Thing when we return to userspace.
+	 *
+	 * Every time MSR_TM is enabled, mainly for the b) case, the TM SPRs
+	 * must be restored in the live registers, since the live registers
+	 * could contain garbage and later we want to read from live, since
+	 * MSR_TM is enabled, and MSR[TM] is what is used to check if the
+	 * TM SPRs live registers are valid or not.
 	 */
-	regs->msr |= MSR_TM;
+	if ((regs->msr & MSR_TM) == 0) {
+		regs->msr |= MSR_TM;
+		tm_enable();
+		tm_restore_sprs(&tsk->thread);
+	}
 
 	/* pull in MSR LE from user context */
 	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
-- 
2.19.0

