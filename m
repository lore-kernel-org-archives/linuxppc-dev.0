Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C3C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 04:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3352083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 04:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3352083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tF645nCrzDqH5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tDx11X6jzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 15:19:01 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x14495KS129425
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Feb 2019 23:18:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qe99g8cqv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Feb 2019 23:18:59 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 4 Feb 2019 04:18:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 4 Feb 2019 04:18:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x144Ir1X8323454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Feb 2019 04:18:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67B3EA4054;
 Mon,  4 Feb 2019 04:18:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CE0EA405B;
 Mon,  4 Feb 2019 04:18:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  4 Feb 2019 04:18:51 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [RFC PATCH 4/5] powerpc: sstep: Add selftests for add[.] instruction
Date: Mon,  4 Feb 2019 09:48:38 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1549253769.git.sandipan@linux.ibm.com>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020404-0008-0000-0000-000002BAB448
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020404-0009-0000-0000-00002226C0BB
Message-Id: <40a23eba726a4b96f81a63ab836e3319a916713c.1549253769.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-04_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040033
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
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds test cases for the add[.] instruction.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep_tests.c | 194 +++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/arch/powerpc/lib/sstep_tests.c b/arch/powerpc/lib/sstep_tests.c
index a610c778044d..fe6201a2add7 100644
--- a/arch/powerpc/lib/sstep_tests.c
+++ b/arch/powerpc/lib/sstep_tests.c
@@ -49,6 +49,200 @@ static struct sstep_test tests[] = {
 			}
 		}
 	},
+	{
+		.mnemonic = "add",
+		.subtests =
+		{
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MIN",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = LONG_MAX, RB = LONG_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = LONG_MAX,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = ULONG_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = 0x1",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = 0x1,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MIN",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = INT_MAX, RB = INT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = INT_MAX,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = UINT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = 0x1",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
+				.regs =
+				{
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = 0x1,
+				}
+			}
+		}
+	},
+	{
+		.mnemonic = "add.",
+		.subtests =
+		{
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MIN",
+				.flags = IGNORE_CCR,
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MIN,
+				}
+			},
+			{
+				.descr = "RA = LONG_MIN, RB = LONG_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = LONG_MIN,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = LONG_MAX, RB = LONG_MAX",
+				.flags = IGNORE_CCR,
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = LONG_MAX,
+					.gpr[22] = LONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = ULONG_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = ULONG_MAX,
+				}
+			},
+			{
+				.descr = "RA = ULONG_MAX, RB = 0x1",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = ULONG_MAX,
+					.gpr[22] = 0x1,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MIN",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MIN,
+				}
+			},
+			{
+				.descr = "RA = INT_MIN, RB = INT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = INT_MIN,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = INT_MAX, RB = INT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = INT_MAX,
+					.gpr[22] = INT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = UINT_MAX",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = UINT_MAX,
+				}
+			},
+			{
+				.descr = "RA = UINT_MAX, RB = 0x1",
+				.instr = PPC_INST_ADD | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22) | __PPC_RC31,
+				.regs =
+				{
+					.gpr[21] = UINT_MAX,
+					.gpr[22] = 0x1,
+				}
+			}
+		}
+	},
 };
 
 int emulate_instr(struct pt_regs *regs, unsigned int instr)
-- 
2.19.2

