Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF31C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 09:27:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B281B2081C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 09:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B281B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CLTc4fMZzDr7V
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 20:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CLRL13TNzDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 20:25:49 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB99IVPA037997
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 04:25:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8uqvyap0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 04:25:47 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 9 Dec 2018 09:25:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 9 Dec 2018 09:25:44 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB99PhiZ52035702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 09:25:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22F734C04E;
 Sun,  9 Dec 2018 09:25:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399714C044;
 Sun,  9 Dec 2018 09:25:42 +0000 (GMT)
Received: from SrihariSrinidhi.in.ibm.com (unknown [9.126.27.138])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun,  9 Dec 2018 09:25:42 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, acme@kernel.org
Subject: [PATCH v2 1/2] powerpc/perf: Update perf_regs structure to include
 SIER
Date: Sun,  9 Dec 2018 14:55:35 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18120909-0008-0000-0000-0000029EE886
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120909-0009-0000-0000-000022095944
Message-Id: <1544347536-19637-1-git-send-email-maddy@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090090
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On each sample, Sample Instruction Event Register (SIER) content
is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
but instead, SIER content is saved in the "dar" register of pt_regs.

Patch adds another entry to the perf_regs structure to include the "SIER"
printing which internally maps to the "dar" of pt_regs.

It also check for the SIER availability in the platform and present
value accordingly

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
- Added checks to address other powerpc platform when
  updating SIER register value

 arch/powerpc/include/asm/perf_event.h           | 3 +++
 arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
 arch/powerpc/perf/core-book3s.c                 | 8 ++++++++
 arch/powerpc/perf/perf_regs.c                   | 7 +++++++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
 tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
 tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
 7 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
index 8bf1b6351716..660f65b98bfb 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -37,4 +37,7 @@
 		(regs)->gpr[1] = current_stack_pointer();	\
 		asm volatile("mfmsr %0" : "=r" ((regs)->msr));	\
 	} while (0)
+
+/* To support perf_regs sier update */
+extern bool is_sier_available(void);
 #endif
diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
index 9e52c86ccbd3..ff91192407d1 100644
--- a/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_TRAP,
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_SIER,
 	PERF_REG_POWERPC_MAX,
 };
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c838ae..b4976cae1005 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -130,6 +130,14 @@ static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
 
+bool is_sier_available(void)
+{
+	if (ppmu->flags & PPMU_HAS_SIER)
+		return true;
+
+	return false;
+}
+
 static bool regs_use_siar(struct pt_regs *regs)
 {
 	/*
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 09ceea6175ba..5c36b3a8d47a 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -69,6 +69,7 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_SIER, dar),
 };
 
 u64 perf_reg_value(struct pt_regs *regs, int idx)
@@ -76,6 +77,12 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
 		return 0;
 
+	if (idx == PERF_REG_POWERPC_SIER &&
+	   (IS_ENABLED(CONFIG_FSL_EMB_PERF_EVENT) ||
+	    IS_ENABLED(CONFIG_PPC32) ||
+	    !is_sier_available()))
+		return 0;
+
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
index 9e52c86ccbd3..ff91192407d1 100644
--- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_TRAP,
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_SIER,
 	PERF_REG_POWERPC_MAX,
 };
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 00e37b106913..1076393e6f43 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -62,7 +62,8 @@ static const char *reg_names[] = {
 	[PERF_REG_POWERPC_SOFTE] = "softe",
 	[PERF_REG_POWERPC_TRAP] = "trap",
 	[PERF_REG_POWERPC_DAR] = "dar",
-	[PERF_REG_POWERPC_DSISR] = "dsisr"
+	[PERF_REG_POWERPC_DSISR] = "dsisr",
+	[PERF_REG_POWERPC_SIER] = "sier"
 };
 
 static inline const char *perf_reg_name(int id)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index ec50939b0418..07fcd977d93e 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -52,6 +52,7 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
 	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
 	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
+	SMPL_REG(sier, PERF_REG_POWERPC_SIER),
 	SMPL_REG_END
 };
 
-- 
2.7.4

