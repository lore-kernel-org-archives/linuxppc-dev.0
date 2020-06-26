Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBDFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 10:00:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92F120679
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 10:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92F120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tXSD1X1NzDr5N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 20:00:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=bala24@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tXHT3dqhzDr1Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 19:52:37 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05Q9XRKi044626; Fri, 26 Jun 2020 05:52:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vxqm25tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 05:52:31 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05Q9XgWE045968;
 Fri, 26 Jun 2020 05:52:31 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vxqm25sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 05:52:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05Q9pXko009462;
 Fri, 26 Jun 2020 09:52:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 31uusjjsg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 09:52:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05Q9qPhn57213294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 09:52:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA08AAE045;
 Fri, 26 Jun 2020 09:52:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 218BDAE051;
 Fri, 26 Jun 2020 09:52:22 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.77.194.240])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2020 09:52:21 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v2 3/4] powerpc sstep: introduce macros to retrieve Prefix
 instruction operands
Date: Fri, 26 Jun 2020 15:21:57 +0530
Message-Id: <20200626095158.1031507-4-bala24@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200626095158.1031507-1-bala24@linux.ibm.com>
References: <20200626095158.1031507-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-26_05:2020-06-26,
 2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=508
 malwarescore=0 impostorscore=0 priorityscore=1501 cotscore=-2147483648
 spamscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260069
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
Cc: ravi.bangoria@linux.ibm.com, jniethe5@gmail.com,
 Balamuruhan S <bala24@linux.ibm.com>, paulus@samba.org, sandipan@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

retrieve prefix instruction operands RA and pc relative bit R values
using macros and adopt it in sstep.c and test_emulate_step.c.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 arch/powerpc/include/asm/sstep.h |  4 ++++
 arch/powerpc/lib/sstep.c         | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 3b01c69a44aa..325975b4ef30 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -104,6 +104,10 @@ enum instruction_type {
 
 #define MKOP(t, f, s)	((t) | (f) | SIZE(s))
 
+/* Prefix instruction operands */
+#define GET_PREFIX_RA(i)	(((i) >> 16) & 0x1f)
+#define GET_PREFIX_R(i)		((i) & (1ul << 20))
+
 struct instruction_op {
 	int type;
 	int reg;
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 5abe98216dc2..fb4c5767663d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -200,8 +200,8 @@ static nokprobe_inline unsigned long mlsd_8lsd_ea(unsigned int instr,
 	unsigned int  dd;
 	unsigned long ea, d0, d1, d;
 
-	prefix_r = instr & (1ul << 20);
-	ra = (suffix >> 16) & 0x1f;
+	prefix_r = GET_PREFIX_R(instr);
+	ra = GET_PREFIX_RA(suffix);
 
 	d0 = instr & 0x3ffff;
 	d1 = suffix & 0xffff;
@@ -1339,8 +1339,8 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	switch (opcode) {
 #ifdef __powerpc64__
 	case 1:
-		prefix_r = word & (1ul << 20);
-		ra = (suffix >> 16) & 0x1f;
+		prefix_r = GET_PREFIX_R(word);
+		ra = GET_PREFIX_RA(suffix);
 		rd = (suffix >> 21) & 0x1f;
 		op->reg = rd;
 		op->val = regs->gpr[rd];
@@ -2715,8 +2715,8 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		}
 		break;
 	case 1: /* Prefixed instructions */
-		prefix_r = word & (1ul << 20);
-		ra = (suffix >> 16) & 0x1f;
+		prefix_r = GET_PREFIX_R(word);
+		ra = GET_PREFIX_RA(suffix);
 		op->update_reg = ra;
 		rd = (suffix >> 21) & 0x1f;
 		op->reg = rd;
-- 
2.24.1

