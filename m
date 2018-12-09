Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDADC07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 09:29:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13A12081C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 09:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13A12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CLWs6QTWzDr0X
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 20:29:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CLRR3pYDzDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2018 20:25:55 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB99IWD1104938
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 04:25:53 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8v5det1h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 04:25:52 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 9 Dec 2018 09:25:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 9 Dec 2018 09:25:49 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB99Pmt934734258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 09:25:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D143C4C044;
 Sun,  9 Dec 2018 09:25:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9FE74C040;
 Sun,  9 Dec 2018 09:25:47 +0000 (GMT)
Received: from SrihariSrinidhi.in.ibm.com (unknown [9.126.27.138])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun,  9 Dec 2018 09:25:47 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, acme@kernel.org
Subject: [PATCH 2/2] powerpc/perf: Update perf_regs structure to include MMCRA
Date: Sun,  9 Dec 2018 14:55:36 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544347536-19637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1544347536-19637-1-git-send-email-maddy@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120909-0012-0000-0000-000002D69FD3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120909-0013-0000-0000-0000210C0ED1
Message-Id: <1544347536-19637-2-git-send-email-maddy@linux.vnet.ibm.com>
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

On each sample, Monitor Mode Control Register A (MMCRA) content
is saved in pt_regs. MMCRA does not have a entry as-is in the pt_regs
but instead, MMCRA content is saved in the "dsisr" register of pt_regs.

Patch adds another entry to the perf_regs structure to include the "MMCRA"
printing which internally maps to the "dsisr" of pt_regs.

It also check for the MMCRA availability in the platform and present
value accordingly

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
 arch/powerpc/perf/perf_regs.c                   | 6 ++++++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
 tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
 tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
index ff91192407d1..f599064dd8dc 100644
--- a/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -47,6 +47,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
 	PERF_REG_POWERPC_SIER,
+	PERF_REG_POWERPC_MMCRA,
 	PERF_REG_POWERPC_MAX,
 };
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 5c36b3a8d47a..3349f3f8fe84 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -70,6 +70,7 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_SIER, dar),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_MMCRA, dsisr),
 };
 
 u64 perf_reg_value(struct pt_regs *regs, int idx)
@@ -83,6 +84,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	    !is_sier_available()))
 		return 0;
 
+	if (idx == PERF_REG_POWERPC_MMCRA &&
+	   (IS_ENABLED(CONFIG_FSL_EMB_PERF_EVENT) ||
+	    IS_ENABLED(CONFIG_PPC32)))
+		return 0;
+
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
index ff91192407d1..f599064dd8dc 100644
--- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -47,6 +47,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
 	PERF_REG_POWERPC_SIER,
+	PERF_REG_POWERPC_MMCRA,
 	PERF_REG_POWERPC_MAX,
 };
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 1076393e6f43..e18a3556f5e3 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -63,7 +63,8 @@ static const char *reg_names[] = {
 	[PERF_REG_POWERPC_TRAP] = "trap",
 	[PERF_REG_POWERPC_DAR] = "dar",
 	[PERF_REG_POWERPC_DSISR] = "dsisr",
-	[PERF_REG_POWERPC_SIER] = "sier"
+	[PERF_REG_POWERPC_SIER] = "sier",
+	[PERF_REG_POWERPC_MMCRA] = "mmcra"
 };
 
 static inline const char *perf_reg_name(int id)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 07fcd977d93e..34d5134681d9 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -53,6 +53,7 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
 	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
 	SMPL_REG(sier, PERF_REG_POWERPC_SIER),
+	SMPL_REG(mmcra, PERF_REG_POWERPC_MMCRA),
 	SMPL_REG_END
 };
 
-- 
2.7.4

