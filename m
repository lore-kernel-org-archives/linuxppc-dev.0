Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C8C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:22:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B4D20818
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 13:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B4D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q9G50RXkzF3Dv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:22:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8Ky0DdSzF39K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:41:09 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYZPS063513
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:41:07 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nk9vdk9nd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:41:07 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:41:06 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:41:03 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6Cf2tl36503732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:41:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39EB1AC05B;
 Tue,  6 Nov 2018 12:41:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEADDAC05E;
 Tue,  6 Nov 2018 12:41:00 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:41:00 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 14/14] selftests/powerpc: Adapt tm-syscall test to no
 suspend
Date: Tue,  6 Nov 2018 10:40:28 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541508028-31865-1-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18110612-0052-0000-0000-00000351212F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:41:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0053-0000-0000-00005EAC23DF
Message-Id: <1541508028-31865-15-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The Documentation/powerpc/transactional_memory.txt says:

 "Syscalls made from within a suspended transaction are performed as normal
  and the transaction is not explicitly doomed by the kernel.  However,
  what the kernel does to perform the syscall may result in the transaction
  being doomed by the hardware."

With this new TM mechanism, the syscall will continue to be executed if the
syscall happens on a suspended syscall, but, it will always be doomed now,
because the transaction will be reclaimed and recheckpointed, which causes
the transaction to be doomed.

This test expects that the transaction is not doomed, calling
getppid_tm_suspended(), which has the following body:

	FUNC_START(getppid_tm_suspended)
		tbegin.
		beq 1f
		li      r0, __NR_getppid
		tsuspend.
		sc
		tresume.
		tend.
		blr
	1:
		li      r3, -1
		blr

This will never succeed and return the syscall output because tresume
will abort the transaction, and jumps to the failure handler, returning r3
:= -1.

This patch updates the test case to not assume that a syscall inside a
suspended transaction will not be doomed, because kernel entrace will doom
any suspended transaction now on.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 454b965a2db3..1439a87eba3a 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -78,12 +78,6 @@ int tm_syscall(void)
 	timeradd(&end, &now, &end);
 
 	for (count = 0; timercmp(&now, &end, <); count++) {
-		/*
-		 * Test a syscall within a suspended transaction and verify
-		 * that it succeeds.
-		 */
-		FAIL_IF(getppid_tm(true) == -1); /* Should succeed. */
-
 		/*
 		 * Test a syscall within an active transaction and verify that
 		 * it fails with the correct failure code.
-- 
2.19.0

