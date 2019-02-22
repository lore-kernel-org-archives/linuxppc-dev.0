Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE7C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:58:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353E7207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Mcs194KzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445MWK3NCKzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 17:53:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M6i2Fv056463
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:53:47 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtay1jsrn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:53:46 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Fri, 22 Feb 2019 06:53:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 06:53:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1M6rdJ08978470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 06:53:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B88AE11C050;
 Fri, 22 Feb 2019 06:53:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 720D011C04A;
 Fri, 22 Feb 2019 06:53:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 06:53:38 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: sandipan@linux.ibm.com
Subject: [PATCH v2 2/6] powerpc: sstep: Add support for darn instruction
Date: Fri, 22 Feb 2019 12:23:28 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550817742.git.sandipan@linux.ibm.com>
References: <cover.1550817742.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022206-0012-0000-0000-000002F8C4C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022206-0013-0000-0000-000021305D59
Message-Id: <bab784a6c44ec5aaa38b56f21f750e911ca62304.1550817743.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220046
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

This adds emulation support for the following integer instructions:
  * Deliver A Random Number (darn)

As suggested by Michael, this uses a raw .long for specifying the
instruction word when using inline assembly to retain compatibility
with older binutils.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 67e69ebd6c00..ab575e02f9b8 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1728,6 +1728,28 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				(int) regs->gpr[rb];
 			goto arith_done;
 
+		case 755:	/* darn */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			switch (ra & 0x3) {
+			case 0:
+				/* 32-bit conditioned */
+				asm volatile(PPC_DARN(%0, 0) : "=r" (op->val));
+				goto compute_done;
+
+			case 1:
+				/* 64-bit conditioned */
+				asm volatile(PPC_DARN(%0, 1) : "=r" (op->val));
+				goto compute_done;
+
+			case 2:
+				/* 64-bit raw */
+				asm volatile(PPC_DARN(%0, 2) : "=r" (op->val));
+				goto compute_done;
+			}
+
+			return -1;
+
 
 /*
  * Logical instructions
-- 
2.19.2

