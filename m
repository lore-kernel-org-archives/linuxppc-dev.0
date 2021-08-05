Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 07:25:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42156105A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 07:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A42156105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgKrp69gGz3cVb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 17:25:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q4FyGwJv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=bharata@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=q4FyGwJv; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgKrG4Fgqz3bW6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 17:25:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17574UuR093505; Thu, 5 Aug 2021 03:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5tJqV2TtRpFHV5hpDmKcs6lf1xq1s7lkl4b/k8Mn6XY=;
 b=q4FyGwJvrJqeLq7fJaRenITEbWDv7Qh7CW0OlK86cQZa+CZhwx0UU+YnW22PNpGt3ffw
 V7n8oMfQ5Ph82UfyHfrpnUvx6YjsReKiZFr3rTr4uMlNMGBt+Bma2gG9bVGsGQrdEHfZ
 y3gBiTiFkxurIG8NTZiiR9jklqYXvtgFvSReyU7BadiBUoG19sb6NgxlwjGNNjK0CoSt
 YHXvvDADV1VoJEt7mHUIRudNoFgWBrhuqLgl1yA0/aUWNrMuxQgrooeBmkGeDg0Qxy7h
 FjXCeXlS3ABidHqHrcDjKPZAt+fztc8hwixLD2n5PN04lMQhOeq9WHd7c2ZJln0DI9G4 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3a84mv15ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Aug 2021 03:24:59 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17577pJ5104163;
 Thu, 5 Aug 2021 03:24:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3a84mv15tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Aug 2021 03:24:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17577ZoS009826;
 Thu, 5 Aug 2021 07:24:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3a4wshtrsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Aug 2021 07:24:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 1757LrUY58130888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Aug 2021 07:21:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13E8EA4051;
 Thu,  5 Aug 2021 07:24:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F49BA4083;
 Thu,  5 Aug 2021 07:24:51 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.102.2.73])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Aug 2021 07:24:50 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v0 1/5] powerpc: Define Expropriation interrupt bit to VPA
 byte offset 0xB9
Date: Thu,  5 Aug 2021 12:54:35 +0530
Message-Id: <20210805072439.501481-2-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805072439.501481-1-bharata@linux.ibm.com>
References: <20210805072439.501481-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: htbjYfQg01MmUjcbTb45wWuSqXJsVghs
X-Proofpoint-ORIG-GUID: K3UsigZW8SiYwiHSuMqSGXA_LV45opEq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-05_02:2021-08-04,
 2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108050041
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
Cc: aneesh.kumar@linux.ibm.com, Bharata B Rao <bharata@linux.ibm.com>,
 kvm@vger.kernel.org, bharata.rao@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VPA byte offset 0xB9 was named as donate_dedicated_cpu as that
was the only used bit. The Expropriation/Subvention support defines
a bit in byte offset 0xB9. Define this bit and rename the field
in VPA to a generic name.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h | 8 +++++++-
 drivers/cpuidle/cpuidle-pseries.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index c390ec377bae..57e432766f3e 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -80,7 +80,7 @@ struct lppaca {
 	u8	ebb_regs_in_use;
 	u8	reserved7[6];
 	u8	dtl_enable_mask;	/* Dispatch Trace Log mask */
-	u8	donate_dedicated_cpu;	/* Donate dedicated CPU cycles */
+	u8	byte_b9; /* Donate dedicated CPU cycles & Expropriation int */
 	u8	fpregs_in_use;
 	u8	pmcregs_in_use;
 	u8	reserved8[28];
@@ -116,6 +116,12 @@ struct lppaca {
 
 #define lppaca_of(cpu)	(*paca_ptrs[cpu]->lppaca_ptr)
 
+/*
+ * Flags for Byte offset 0xB9
+ */
+#define LPPACA_DONATE_DED_CPU_CYCLES   0x1
+#define LPPACA_EXP_INT_ENABLED         0x2
+
 /*
  * We are using a non architected field to determine if a partition is
  * shared or dedicated. This currently works on both KVM and PHYP, but
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a2b5c6f60cf0..b9d0f41c3f19 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -221,7 +221,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	u8 old_latency_hint;
 
 	pseries_idle_prolog();
-	get_lppaca()->donate_dedicated_cpu = 1;
+	get_lppaca()->byte_b9 |= LPPACA_DONATE_DED_CPU_CYCLES;
 	old_latency_hint = get_lppaca()->cede_latency_hint;
 	get_lppaca()->cede_latency_hint = cede_latency_hint[index];
 
@@ -229,7 +229,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	check_and_cede_processor();
 
 	local_irq_disable();
-	get_lppaca()->donate_dedicated_cpu = 0;
+	get_lppaca()->byte_b9 &= ~LPPACA_DONATE_DED_CPU_CYCLES;
 	get_lppaca()->cede_latency_hint = old_latency_hint;
 
 	pseries_idle_epilog();
-- 
2.31.1

