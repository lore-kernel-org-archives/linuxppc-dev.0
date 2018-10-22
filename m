Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B9C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:18:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C01420651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C01420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42f8Wc50w3zF36p
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 08:18:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42f8Tc5qXbzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 08:16:36 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9ML4G1X002463
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 17:16:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n9ny9gwg6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 17:16:33 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 22 Oct 2018 15:16:33 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 15:16:31 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9MLGUtb63832122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 14:16:30 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 156827805C;
 Mon, 22 Oct 2018 21:16:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF74978060;
 Mon, 22 Oct 2018 21:16:27 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.163.197])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 21:16:27 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: Fix ptrace tm failure
Date: Mon, 22 Oct 2018 18:16:26 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18102221-8235-0000-0000-00000E1A13E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009918; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106501; UDB=6.00573012; IPR=6.00886585; 
 MB=3.00023861; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 21:16:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102221-8236-0000-0000-00004317F0BC
Message-Id: <1540242986-7510-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-22_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=901 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220178
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
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Test ptrace-tm-spd-gpr fails on current kernel (4.19) due to a segmentation
fault that happens on the child process prior to setting cptr[2] = 1. This
causes the parent process to wait forever at 'while (!pptr[2])' and the test to
be killed by the test harness framework by timeout, thus, failing.

The segmentation fault happens because of a inline assembly being
generated as:

	0x10000355c <tm_spd_gpr+492>    lfs    f0, 0(0)

This is reading memory position 0x0 and causing the segmentation fault.

This code is being generated by ASM_LOAD_FPR_SINGLE_PRECISION(flt_4), where
flt_4 is passed to the inline assembly block as:

	[flt_4] "r" (&d)

Since the inline assembly 'r' constraint means any GPR, gpr0 is being
chosen, thus causing this issue when issuing a Load Floating-Point Single
instruction.

This patch simply changes the constraint to 'b', which specify that this
register will be used as base, and r0 is not allowed to be used, avoiding
this issue.

Other than that, removing flt_2 register from the input operands, since it
is not used by the inline assembly code at all.

Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
index 327fa943c7f3..dbdffa2e2c82 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
@@ -67,8 +67,8 @@ void tm_spd_gpr(void)
 		"3: ;"
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [gpr_1]"i"(GPR_1), [gpr_2]"i"(GPR_2), [gpr_4]"i"(GPR_4),
-		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "r" (&a),
-		[flt_2] "r" (&b), [flt_4] "r" (&d)
+		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "b" (&a),
+		[flt_4] "b" (&d)
 		: "memory", "r5", "r6", "r7",
 		"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
 		"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
-- 
2.19.0

