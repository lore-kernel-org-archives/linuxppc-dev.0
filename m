Return-Path: <linuxppc-dev+bounces-19895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38264F8FA90
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 15:07:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Qgb2clmz2ypk;
	Wed, 22 Apr 2026 01:07:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776784027;
	cv=none; b=HZOfT6ob6fr6Kv8K85bCXKQpac6nlKdD6IvF4Mv/zyyqSTXB1SkSyV2QZekoqQ9fv1coV2Ptdl2s3FjzPeU68dXwQV+r/ABidC1nYIe/15Olep4xsJT6yyyv9YOdKn3ujzhd0lsjrwr7Dcj1E1CeMKYKF2v6Ie5820UBJRrmV7+oymdPEkfMLdjOEWtGu2vvrYhFtTK57xGItPU9jdS63jKYV6iDUydcIz74m5ZZ13PmwGCQIX6EqODDGItg0YXZQ4z69otiNPV4pRm/BhWZ+4bipNKZLZn9xhtJ8nHyrWkiCmJCsWDYnmOH4C5qpPpifUErUSnjX73Di4zm7pBoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776784027; c=relaxed/relaxed;
	bh=2x1xte/RY2ZOMJd4hJ1UrsNzH9McVig1FQK7G4qVTkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hdi7vhchnam2RLDxDE4wDxeWIBtsFvEMLNCTzZO8DRaYuPFcHiJx2K0jYUwdb6MbEDySP30a7YDcFNtHImxUESGvsC+0ekOqZvOGPkDvb5jaLmo8KchdnTLXdIgSzmDHLG6bX8ROosh4lY021akSsqGDX/5db//1Ks/WGZhTh3aCDl6q0oqOGthPeoRHKfmUogR58avXZc6j0vgS/S3cFIRs2Kk11TyIZ+GyTvNhZxvlb5oci63jRtDYzsgAOiuxJKsWyHAttfd5wdosisongUTgaXQ0epiC0gT3PwBVl6nZLD5NdES75rgJJKsG5K2LFSAg8d0rjSZ0TKDbNR+CAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P1d7TTP8; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P1d7TTP8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0QgZ3c0Pz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:07:05 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCtGAM1650610
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 15:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2x1xte/RY2ZOMJd4hJ1UrsNzH9McVig1FQK7G4qVT
	kQ=; b=P1d7TTP8elPJ4G7n3vXCzcQZMOZOWIR+fqTji1DZAcVIL+1q5uEJnQAn5
	l6xD2GHcMzyS1d2L29rsHhScLFaD07Em0uaiaAKVT4iMYfVX3KN4Kh+TBN2AGxU9
	wByPD1aPJLRm9EhOu9SJ4b5ufBfFoeD+xh66v0VN8TU7pibQB3J3yJAzjXKxNnIV
	m9FtB9uiyRSOGMHnaU7Y7olXiso24Ehxl+eSYeLHZoMquXc89ToPOUckg7tiPiYg
	5Kvuu8862lojVSql3aTGP06I40j1WklwzWZh/1l896RBxyWofykrB/axxn7DzN2L
	6EC/T2AA2ucqK0YPDHArLhM3/dnMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k54wbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 15:07:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LF5Nas029162
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 15:07:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg9109-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 15:07:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LF6whG46072118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:06:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99A320040;
	Tue, 21 Apr 2026 15:06:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12CB920043;
	Tue, 21 Apr 2026 15:06:57 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.39.27.248])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:06:56 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        shivani@linux.ibm.com
Subject: [PATCH] powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC marked events
Date: Tue, 21 Apr 2026 20:36:28 +0530
Message-ID: <20260421150628.96500-1-shivani@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-GUID: Vi3li3NtRY9_eEiJx2sIwqrC4EBW0O7h
X-Proofpoint-ORIG-GUID: Vi3li3NtRY9_eEiJx2sIwqrC4EBW0O7h
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e79297 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Ekv465IJch5wPuehOcwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX9q561O1116Jw
 uaNRtiPaeMEs1+2o+/drOeKD3p0k/OFuI62/nH/huhw5eNHwdjWt+lqaOy1gHkAXJ5T8lwkhSvA
 dC+x8BD11TrNHnWPfauyEIP2yJx5t6/LiFTdZ3KUQThU/CaY3eYHgis72ehOoTN6gjWgM7usASX
 urzV86ki4OBripfDQhXcGiuHfGo9jQPAiD2UTDMra5TuHUPCrWp/9iuQMnojzEuOsZJMj7jVLBG
 VGHEspAKUWntdPP8CqYXXTfjiUHIOR2u0sot0LW3Ptx993gcwbeLQ0b+7EuB8f2iHQcCL47Zzkk
 NNXFfPLH3H+/dwUWLkoA7KHeU53BxLK0ZWu4VOJszrJLmG946FpjPMSJMuLqeN9oc3Kz+2Fb6zs
 KBHmYCMWJIjILjGCqQUaAuu7v8FInlUmg6/iFMJzLHjbY0OgMYv2xm4NlMMQceQfs2usgBvqtzL
 ikm9tL5ZZ1VNa18sGdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148

The core-book3s PMU sampling code validates the SIER TYPE field
when PERF_SAMPLE_DATA_SRC is requested. The SIER TYPE field
indicates the instruction type and is only valid for
random sampling (marked events). To handle cases observed where
SIER TYPE could be zero even for marked events,validation was
added to drop such samples and increment event->lost_samples.

However, this validation was applied to all samples,
including continuous sampling. In continuous sampling mode,
the PMU does not set the SIER TYPE field, so it remains zero.
As a result, valid continuous samples were incorrectly
treated as invalid and dropped. Fixed this by gating the
SIER TYPE validation with mark_event, so the check runs only
for marked (random) events. Continuous samples now skip this
check and are recorded normally in the final data recording path.

Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src")
Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---

 arch/powerpc/perf/core-book3s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8b0081441f85..2e6adf5b95c4 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2242,6 +2242,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	const u64 last_period = event->hw.last_period;
 	s64 prev, delta, left;
 	int record = 0;
+	int mark_event = regs->dsisr & MMCRA_SAMPLE_ENABLE;
 
 	if (event->hw.state & PERF_HES_STOPPED) {
 		write_pmc(event->hw.idx, 0);
@@ -2304,9 +2305,9 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
 	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
 	 * Drop the sample if "type" has reserved values for this field with a
-	 * ISA version check.
+	 * ISA version check for marked events.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
+	if (mark_event && event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
 			ppmu->get_mem_data_src) {
 		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
 		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
-- 
2.47.3


