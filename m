Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE88C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 12:33:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118A920708
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 12:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118A920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2bDq11xHzDr7G
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 22:33:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2b9F53tLzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 22:30:09 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 069C14rr083295; Thu, 9 Jul 2020 08:29:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 325ktsrtun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2020 08:29:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069CCJWI023681;
 Thu, 9 Jul 2020 12:29:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 325k1vgweu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2020 12:29:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 069CSXTE56426992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2020 12:28:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA8934203F;
 Thu,  9 Jul 2020 12:29:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D943E42041;
 Thu,  9 Jul 2020 12:29:52 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.49.147])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2020 12:29:52 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH] powerpc/watchpoint/ptrace: Introduce
 PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31
Date: Thu,  9 Jul 2020 17:59:44 +0530
Message-Id: <20200709122944.173744-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-09_06:2020-07-09,
 2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090093
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
Cc: christophe.leroy@c-s.fr, ravi.bangoria@linux.ibm.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, pedromfc@br.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31 can be used to determine
whether we are running on an ISA 3.1 compliant machine. Which is
needed to determine DAR behaviour, 512 byte boundary limit etc.
This was requested by Pedro Miraglia Franco de Carvalho for
extending watchpoint features in gdb. Note that availability of
2nd DAWR is independent of this flag and should be checked using
ppc_debug_info->num_data_bps.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/ptrace.h    | 1 +
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index f5f1ccc740fc..0a87bcd4300a 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -222,6 +222,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
 #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
 #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x0000000000000010
+#define PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31	0x0000000000000020
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 697c7e4b5877..b2de874d650b 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -52,8 +52,11 @@ void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)
 	dbginfo->sizeof_condition = 0;
 	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT)) {
 		dbginfo->features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
-		if (dawr_enabled())
+		if (dawr_enabled()) {
 			dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
+			if (cpu_has_feature(CPU_FTR_ARCH_31))
+				dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31;
+		}
 	} else {
 		dbginfo->features = 0;
 	}
-- 
2.26.2

