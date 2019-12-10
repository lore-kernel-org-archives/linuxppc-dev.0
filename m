Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C975C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 07:22:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3894206D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 07:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3894206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XBMq1Zd6zDqXM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 18:22:15 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47XBKB4wJ0zDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 18:19:55 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBA7HHUM137542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 02:19:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2drw7e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 02:19:53 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bala24@linux.ibm.com>;
 Tue, 10 Dec 2019 07:19:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Dec 2019 07:19:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBA7Jl0337879976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2019 07:19:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E61394C071;
 Tue, 10 Dec 2019 07:19:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F75A4C063;
 Tue, 10 Dec 2019 07:19:45 +0000 (GMT)
Received: from dhcp-9-120-237-107.in.ibm.com (unknown [9.120.237.107])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2019 07:19:45 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 1/3] powerpc ppc-opcode: add divde, divde_dot,
 divdeu and divdeu_dot opcodes
Date: Tue, 10 Dec 2019 12:49:02 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191210071904.31013-1-bala24@linux.ibm.com>
References: <20191210071904.31013-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121007-0028-0000-0000-000003C71A5C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121007-0029-0000-0000-0000248A4870
Message-Id: <20191210071904.31013-2-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=311
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 suspectscore=5 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100065
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
Cc: ravi.bangoria@linux.ibm.com, Balamuruhan S <bala24@linux.ibm.com>,
 paulus@samba.org, sandipan@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

include instruction opcodes for divde, divde_dot, divideu and
divideu_dot as macros.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c1df75edde44..5bfd4d13be97 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -339,6 +339,10 @@
 #define PPC_INST_DIVWU			0x7c000396
 #define PPC_INST_DIVD			0x7c0003d2
 #define PPC_INST_DIVDU			0x7c000392
+#define PPC_INST_DIVDE			0x7c000352
+#define PPC_INST_DIVDE_DOT		0x7c000353
+#define PPC_INST_DIVDEU			0x7c000312
+#define PPC_INST_DIVDEU_DOT		0x7c000313
 #define PPC_INST_RLWINM			0x54000000
 #define PPC_INST_RLWINM_DOT		0x54000001
 #define PPC_INST_RLWIMI			0x50000000
@@ -439,6 +443,18 @@
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
 					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_DIVDE(t, a, b)	stringify_in_c(.long PPC_INST_DIVDE	| \
+					___PPC_RT(t) | ___PPC_RA(a)	| \
+					___PPC_RB(b))
+#define PPC_DIVDE_DOT(t, a, b)	stringify_in_c(.long PPC_INST_DIVDE_DOT | \
+					___PPC_RT(t) | ___PPC_RA(a)	| \
+					___PPC_RB(b))
+#define PPC_DIVDEU(t, a, b)	stringify_in_c(.long PPC_INST_DIVDEU	| \
+					___PPC_RT(t) | ___PPC_RA(a)	| \
+					___PPC_RB(b))
+#define PPC_DIVDEU_DOT(t, a, b)	stringify_in_c(.long PPC_INST_DIVDEU_DOT | \
+					___PPC_RT(t) | ___PPC_RA(a)	| \
+					___PPC_RB(b))
 #define PPC_LQARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LQARX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b) | __PPC_EH(eh))
-- 
2.14.5

