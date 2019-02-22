Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD07C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 07:08:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0EF207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 07:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0EF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445MrF1p0JzDqRm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 18:08:29 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445MXn1mHkzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 17:55:05 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M6sPik012534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:55:03 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qt96e6jvn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:55:03 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Fri, 22 Feb 2019 06:55:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 06:54:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1M6svqH29229074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 06:54:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DD48AE045;
 Fri, 22 Feb 2019 06:54:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21FF8AE04D;
 Fri, 22 Feb 2019 06:54:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 06:54:55 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v2 1/6] powerpc: sstep: Add support for maddhd, maddhdu,
 maddld instructions
Date: Fri, 22 Feb 2019 12:24:47 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550817742.git.sandipan@linux.ibm.com>
References: <cover.1550817742.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022206-4275-0000-0000-000003128A90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022206-4276-0000-0000-00003820C0C0
Message-Id:
 <d2a6e5ff179fcb351f79f87e156168d50a3e091c.1550817742.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220047
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190222065447.m5ZZq2M98OMmSC2ctTHgLRwMtSPZB2sXUZF5TTZI3fs@z>

This adds emulation support for the following integer instructions:
  * Multiply-Add High Doubleword (maddhd)
  * Multiply-Add High Doubleword Unsigned (maddhdu)
  * Multiply-Add Low Doubleword (maddld)

As suggested by Michael, this uses a raw .long for specifying the
instruction word when using inline assembly to retain compatibility
with older binutils.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 15 +++++++++++-
 arch/powerpc/lib/sstep.c              | 35 ++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 19a8834e0398..d0b2d8534a62 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -334,6 +334,9 @@
 #define PPC_INST_MULLW			0x7c0001d6
 #define PPC_INST_MULHWU			0x7c000016
 #define PPC_INST_MULLI			0x1c000000
+#define PPC_INST_MADDHD			0x10000030
+#define PPC_INST_MADDHDU		0x10000031
+#define PPC_INST_MADDLD			0x10000033
 #define PPC_INST_DIVWU			0x7c000396
 #define PPC_INST_DIVD			0x7c0003d2
 #define PPC_INST_RLWINM			0x54000000
@@ -376,6 +379,7 @@
 /* macros to insert fields into opcodes */
 #define ___PPC_RA(a)	(((a) & 0x1f) << 16)
 #define ___PPC_RB(b)	(((b) & 0x1f) << 11)
+#define ___PPC_RC(c)	(((c) & 0x1f) << 6)
 #define ___PPC_RS(s)	(((s) & 0x1f) << 21)
 #define ___PPC_RT(t)	___PPC_RS(t)
 #define ___PPC_R(r)	(((r) & 0x1) << 16)
@@ -395,7 +399,7 @@
 #define __PPC_WS(w)	(((w) & 0x1f) << 11)
 #define __PPC_SH(s)	__PPC_WS(s)
 #define __PPC_SH64(s)	(__PPC_SH(s) | (((s) & 0x20) >> 4))
-#define __PPC_MB(s)	(((s) & 0x1f) << 6)
+#define __PPC_MB(s)	___PPC_RC(s)
 #define __PPC_ME(s)	(((s) & 0x1f) << 1)
 #define __PPC_MB64(s)	(__PPC_MB(s) | ((s) & 0x20))
 #define __PPC_ME64(s)	__PPC_MB64(s)
@@ -437,6 +441,15 @@
 #define PPC_STQCX(t, a, b)	stringify_in_c(.long PPC_INST_STQCX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b))
+#define PPC_MADDHD(t, a, b, c)	stringify_in_c(.long PPC_INST_MADDHD | \
+					___PPC_RT(t) | ___PPC_RA(a)  | \
+					___PPC_RB(b) | ___PPC_RC(c))
+#define PPC_MADDHDU(t, a, b, c)	stringify_in_c(.long PPC_INST_MADDHDU | \
+					___PPC_RT(t) | ___PPC_RA(a)   | \
+					___PPC_RB(b) | ___PPC_RC(c))
+#define PPC_MADDLD(t, a, b, c)	stringify_in_c(.long PPC_INST_MADDLD | \
+					___PPC_RT(t) | ___PPC_RA(a)  | \
+					___PPC_RB(b) | ___PPC_RC(c))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					___PPC_RB(b))
 #define PPC_MSGSYNC		stringify_in_c(.long PPC_INST_MSGSYNC)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d81568f783e5..67e69ebd6c00 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rd, spr, u;
+	unsigned int opcode, ra, rb, rc, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
@@ -1292,6 +1292,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (instr >> 21) & 0x1f;
 	ra = (instr >> 16) & 0x1f;
 	rb = (instr >> 11) & 0x1f;
+	rc = (instr >> 6) & 0x1f;
 
 	switch (opcode) {
 #ifdef __powerpc64__
@@ -1305,6 +1306,38 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			goto trap;
 		return 1;
 
+#ifdef __powerpc64__
+	case 4:
+		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+			return -1;
+
+		switch (instr & 0x3f) {
+		case 48:	/* maddhd */
+			asm volatile(PPC_MADDHD(%0, %1, %2, %3) :
+				     "=r" (op->val) : "r" (regs->gpr[ra]),
+				     "r" (regs->gpr[rb]), "r" (regs->gpr[rc]));
+			goto compute_done;
+
+		case 49:	/* maddhdu */
+			asm volatile(PPC_MADDHDU(%0, %1, %2, %3) :
+				     "=r" (op->val) : "r" (regs->gpr[ra]),
+				     "r" (regs->gpr[rb]), "r" (regs->gpr[rc]));
+			goto compute_done;
+
+		case 51:	/* maddld */
+			asm volatile(PPC_MADDLD(%0, %1, %2, %3) :
+				     "=r" (op->val) : "r" (regs->gpr[ra]),
+				     "r" (regs->gpr[rb]), "r" (regs->gpr[rc]));
+			goto compute_done;
+		}
+
+		/*
+		 * There are other instructions from ISA 3.0 with the same
+		 * primary opcode which do not have emulation support yet.
+		 */
+		return -1;
+#endif
+
 	case 7:		/* mulli */
 		op->val = regs->gpr[ra] * (short) instr;
 		goto compute_done;
-- 
2.19.2

