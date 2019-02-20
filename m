Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A0BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:02:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FB82087B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FB82087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4447p21xFzzDqGW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 18:02:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4447hF4RWQzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:57:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K6oE4J018588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:57:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qs1ys0846-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:57:15 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 20 Feb 2019 06:57:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 06:57:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K6v8lZ27394128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 06:57:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81FC0AE055;
 Wed, 20 Feb 2019 06:57:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5916EAE051;
 Wed, 20 Feb 2019 06:57:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Feb 2019 06:57:07 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc: sstep: Add tests for add[.] instruction
Date: Wed, 20 Feb 2019 12:26:59 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550645549.git.sandipan@linux.ibm.com>
References: <cover.1550645549.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022006-0016-0000-0000-000002589085
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022006-0017-0000-0000-000032B2D823
Message-Id: <6c36ab4efd053c387b6585ac7193b87cf717d02e.1550645549.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=704 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200048
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
Cc: naveen.n.rao@linux.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 ravi.bangoria@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds test cases for the add[.] instruction.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/test_emulate_step.c | 176 +++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 3d7f7bae51cc..bf88b20e53d7 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -49,6 +49,10 @@
 					___PPC_RA(a) | ___PPC_RB(b))
 #define TEST_LXVD2X(s, a, b)	(PPC_INST_LXVD2X | VSX_XX1((s), R##a, R##b))
 #define TEST_STXVD2X(s, a, b)	(PPC_INST_STXVD2X | VSX_XX1((s), R##a, R##b))
+#define TEST_ADD(t, a, b)	(PPC_INST_ADD | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_ADD_DOT(t, a, b)	(PPC_INST_ADD | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b) | 0x1)
 
 #define MAX_SUBTESTS	16
 
@@ -473,6 +477,178 @@ static struct compute_test compute_tests[] = {
 				}
 			}
 		}
+	},
+	{
+		.mnemonic = "add",
+		.subtests = {
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MIN",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = LONG_MAX, RB = LONG_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MAX,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = ULONG_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = 0x1",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = 0x1,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MIN",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = INT_MAX, RB = INT_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MAX,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = UINT_MAX",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = 0x1",
+				.instr = TEST_ADD(20, 21, 22),
+				.regs = {
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = 0x1,
+				}
+			}
+		}
+	},
+	{
+		.mnemonic = "add.",
+		.subtests = {
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MIN",
+				.flags = IGNORE_CCR,
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MAX",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = LONG_MAX, RB = LONG_MAX",
+				.flags = IGNORE_CCR,
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = LONG_MAX,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = ULONG_MAX",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = 0x1",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = 0x1,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MIN",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MAX",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = INT_MAX, RB = INT_MAX",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = INT_MAX,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = UINT_MAX",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = 0x1",
+				.instr = TEST_ADD_DOT(20, 21, 22),
+				.regs = {
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = 0x1,
+				}
+			}
+		}
 	}
 };
 
-- 
2.19.2

