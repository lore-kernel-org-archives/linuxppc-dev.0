Return-Path: <linuxppc-dev+bounces-25817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34EEC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLL8h1PhFz2yfR;
	Thu, 13 Aug 2026 19:46:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614372;
	cv=none; b=lxl6otHL5YsUWIm1OXJKHHWGF5taMpy06Uyt0+14A29YEKdEVIv34tqj17OccSApmFZgdhCNGmfh18NmFlJOg26jsU4r2S8nE+Be7kK7ull+L9vkqrEWuFLrvIYNVdlyQdDz5R2beqLm+N4VitEkD4tWJKeuIMsLOEt6WgVuPS3vXBBAIVbvcWPbBYeZpBgBzZdOIBF51UxoJvajE979Krf0sjwEvY+urboRQsmTWtDDyI3EUfkKiAw3OrHUzndskZrMc1aMOcyt613sQ/xYdby9/J2BvKkdGs07wQBDfuCYhgdra/4H0G2AGKTfatOOxGIw5npeVYYAWaFB4v0DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614372; c=relaxed/relaxed;
	bh=32oC7LpM9idEcIM1UnB5h0gLMNWJvK3X650Zlr9EBbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao6yyUuj6d07HWGSmlv9sG6jJEu2HaWuiAykihfWuFlc/UWhAt/uMxGZXN6u+be/+AtvocKKMZBLZ2wdDVh8k7EQJUakvxWshgrNDjjvUBzeFACLDFWYGo8MMWKKjRHnJjYWfanaiS5WiD3/VPrxOCTi457yBrazvTBKqFzsoeNUvtiWGmlUQsCQHh9/vb5INdjD1Pw4GJvHkmqTroug6r28LvJs1l3J7nVZyQaRJbiDZiv4EOly0qSE0kAslGSSCrvPY9/f7GLgX3i2xUIDmE2euzZL2o9wEr266h60MoGkho1iax0RtVYDonNiSwMEe1ghSC680vBfJo6yER8IeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lP87kjYc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lP87kjYc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLL8g2Tjxz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:46:11 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D99CgK1950852;
	Thu, 13 Aug 2026 09:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=32oC7LpM9idEcIM1U
	nB5h0gLMNWJvK3X650Zlr9EBbQ=; b=lP87kjYcOKIsVEPbHX48UpkAu1vzb7rL/
	8YRoUOq1Tm2gnALC3i1OkoCxZUrrfK59Ba+ociRls3gkBCpUwBZNa/EJu6x9/aJ4
	OrH4rq5XP3APqaxFFPEhPULKLAh9d0A18HaZ8tzxV/e/o3w+/yfjKPLLx6CP9cl9
	X48MX900OI9B7CfGNHUHcRY6+l6zAYSGDvgG3Kz93ciQDtzlxDD2vMeM1wPVkWLm
	bCNsm1kjhIqlWnoVEEA9r45mRP6M8Tt2yiU1sMGblpzVNOgNG9/cnbe6MLPs4UGs
	WXsMqm3rnGoCgkGCU6YIxdEFiXLYc0qWea0notO19/JK0/myTwuKQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwe9e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:46:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D9fsPT020344;
	Thu, 13 Aug 2026 09:45:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqaky7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:45:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D9jt3b37093762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:45:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8099520043;
	Thu, 13 Aug 2026 09:45:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C82C20040;
	Thu, 13 Aug 2026 09:45:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.189])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:45:52 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/perf: Use the aggregate context switch values from vcpu struct
Date: Thu, 13 Aug 2026 15:15:31 +0530
Message-ID: <20260813094535.10083-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813094535.10083-1-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7d9258 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-rbrNTDI_eUuE96cYmgA:9
X-Proofpoint-GUID: yb0obA1nLaqbo7Vd_URmiwfqML8o0VJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX0an1HhXNGyMh
 PRrQ5jdAdoiSS2wJ1o+U+8dfztQCmrIV7ma1KqngNP7MsZa/alyipdhqLaIkRcBL3gwf+LfJaNK
 xHfWowHSQG/Jj4GN3VE6t95qMqj7imbUeyOT5QTOGbLoS7u+vdhvQbQix4+d9eOq1AF7X2lwBvP
 mOOg5Cz6R+4mB2I/19QCebgV+VThxoVtZTsxt78SxrlS1Udc+VKe70/5+KVQGzD/9o/0ZDewzpw
 MicQtx585KeoK8DyDEShbV2qir7GahlRIaJhM447vJKGFWLcPlROOeLXAraBFLH5/Z1Ri5lUU1G
 JI2Scl/R/nObHy3VBUK4G236zVY5DkozJNw4XqJgCaxqLngaoYgc8w1euyD5WAjfBUxKHQnzypz
 Q9kNkTDQNOMa3WGP8sg5BjS+TNZH1BLm4dxVSgOCxrA5yVEtVh9KEa38uLj4R0P05P21ZZs7RxE
 B4dt43GgF7vzjLXFpjg==
X-Proofpoint-ORIG-GUID: dcShKy_oNPpG9IT38IU7AkxfXhehCRPN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX+2anfcH3TdjU
 3UezvfBf0qHSSf6Dd2VGKFT55xnnYTWnKovEHJDksdp+s08JMfAJcluxji3C2Wa3c0XxmYJzouv
 BGY29bcb3RIfHxiPASAOjcZmpDPaSkU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130066

The vpa-pmu driver reports incorrect numbers in 2 scenarios:

1. The vCPU process gets rescheduled to a different host cpu
    - Incorrect numbers are observed here because the PACA is per-host cpu
      resource, and the KVM vCPUs can be rescheduled to different
      host cpus. This causes the vpa-pmu driver to subtract wrong values
      when vCPUs are rescheduled.

2. The vCPU is not running when vpa_pmu_read() is called.
    - In this case get_counter_data() returns 0, and this can result in
      negative numbers getting reported.

Fix the above issues by using the aggregate values from the vcpu
structure to capture and report the difference in counter values.

Fixes: 176cda0619b6 ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Fix the output for "perf stat --cpu ..."
2. Add stable/fixes tags

 arch/powerpc/include/asm/kvm_book3s_64.h |  3 --
 arch/powerpc/kvm/book3s_hv.c             | 45 ------------------------
 arch/powerpc/perf/vpa-pmu.c              | 24 +++++++++----
 3 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index b936e174eefd..f620e3126d68 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -691,9 +691,6 @@ void kvmhv_set_l2_counters_status(int cpu, bool status);
 u64 kvmhv_get_l1_to_l2_cs_time(void);
 u64 kvmhv_get_l2_to_l1_cs_time(void);
 u64 kvmhv_get_l2_runtime_agg(void);
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void);
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void);
-u64 kvmhv_get_l2_runtime_agg_vcpu(void);
 
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 342168b8bfc8..b9285b7f1fed 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4189,51 +4189,6 @@ u64 kvmhv_get_l2_runtime_agg(void)
 }
 EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg);
 
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l1_to_l2_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l1_to_l2_cs_time_vcpu);
-
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_to_l1_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_to_l1_cs_time_vcpu);
-
-u64 kvmhv_get_l2_runtime_agg_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_runtime_agg;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg_vcpu);
-
 #else
 int kvmhv_get_l2_counters_status(void)
 {
diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index bff4cfab7b94..e79d98447c74 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -91,7 +91,7 @@ static int vpa_pmu_event_init(struct perf_event *event)
 	return 0;
 }
 
-static unsigned long get_counter_data(struct perf_event *event)
+static unsigned long get_counter_data(struct kvm_vcpu *vcpu, struct perf_event *event)
 {
 	unsigned int config = event->attr.config;
 	u64 data;
@@ -99,19 +99,19 @@ static unsigned long get_counter_data(struct perf_event *event)
 	switch (config) {
 	case L1_TO_L2_CS_LAT:
 		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l1_to_l2_cs_time_vcpu();
+			data = vcpu->arch.l1_to_l2_cs;
 		else
 			data = kvmhv_get_l1_to_l2_cs_time();
 		break;
 	case L2_TO_L1_CS_LAT:
 		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_to_l1_cs_time_vcpu();
+			data = vcpu->arch.l2_to_l1_cs;
 		else
 			data = kvmhv_get_l2_to_l1_cs_time();
 		break;
 	case L2_RUNTIME_AGG:
 		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_runtime_agg_vcpu();
+			data = vcpu->arch.l2_runtime_agg;
 		else
 			data = kvmhv_get_l2_runtime_agg();
 		break;
@@ -126,21 +126,33 @@ static unsigned long get_counter_data(struct perf_event *event)
 static int vpa_pmu_add(struct perf_event *event, int flags)
 {
 	u64 data;
+	struct kvm_vcpu *vcpu;
 
+	vcpu = local_paca->kvm_hstate.kvm_vcpu;
+	if (!vcpu)
+		goto out;
+
+	event->pmu_private = vcpu;
 	kvmhv_set_l2_counters_status(smp_processor_id(), true);
 
-	data = get_counter_data(event);
+	data = get_counter_data(vcpu, event);
 	local64_set(&event->hw.prev_count, data);
 
+out:
 	return 0;
 }
 
 static void vpa_pmu_read(struct perf_event *event)
 {
 	u64 prev_data, new_data, final_data;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = (struct kvm_vcpu *) event->pmu_private;
+	if (!vcpu)
+		return;
 
 	prev_data = local64_read(&event->hw.prev_count);
-	new_data = get_counter_data(event);
+	new_data = get_counter_data(vcpu, event);
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
-- 
2.54.0


