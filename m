Return-Path: <linuxppc-dev+bounces-21950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340B5CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:28:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVd6v39NPz3bpM;
	Wed, 03 Jun 2026 16:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468087;
	cv=none; b=GujpU0ngv+JgpPG4L6wBLlLhoCUzAUeN7Ow9rSoCPZksxEun2KMOpERqRUayjmNLAxsuoIwR3O3qzdH/E9NgU/tYnEhggRTpWdUAeMWFBkYS1vpyn2ltYvGkPvL54EI1t5GG5AVqiWe9P6oTSy+y34Bm3OrDiXFrVO5osHib+eA9sr4eCEKSyYSsZylmAxNbrprl2yl2VVQausseS9dhXft8Ue4OECuBfiIkKsi21nCO3hL10zR4oTFeJYJGsf3O9fYw/T4eRdbR6wOPRGdcm0o9pmRhXDLVvhECHbmrumJ46WbsX6OEWzBOyEsVwzJSIAxxjUhUqp3tt8DtHR4J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468087; c=relaxed/relaxed;
	bh=8+nYoA+x/dvSBguuBiHUHAojnvr48ap391q1RsglkA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwZDA0al3gn6DipP0/EL57BbHGsBQ3Elx1ahfBFIlQXlTQbmVWddJXuow2xPec033CtPCQa5MQ+KOJvTl64mndcBEZOVw6yId/ct5uTiWNZh/BWkAkyunQOvF68ywwbVO2cx/1sgiSmWP99/6pw4okXdAF8AZ+/27KTHUegTt6Ai/WtgB60ZYFSfMy2BTz7b7geiYMcnwkI18zqT98Cc7loxZ0S6mp4n3anzawehgR41kjYZWV3Cw0I8ovPjuMfw5WBP82KbWSAYKd9bECycqGGnj/TPjXIREfr7B1x4980HJsgux+Hl1ESTljBBAzX1/IC9SBl6f853VcWEHND2/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tvm2SjJv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tvm2SjJv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVd6t5LnZz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:28:06 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652GCjjp3293619;
	Wed, 3 Jun 2026 06:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8+nYoA+x/dvSBguuB
	iHUHAojnvr48ap391q1RsglkA4=; b=Tvm2SjJv/7UvcCGNIGzeB6yZcwmdy34Tx
	ZwhkwXp+2KABbifjFaNYATQbNurDSgkl5ajzU0zTJmgTM9TneTj/eF4UiqPe+aiK
	/ATbkw1DMwey+FkJ6mfKfiLjFDF858ut1QKfeZ/aaJkFo84MfPbNIefns2FyGlT9
	NXzR/5hz50rKw0AZtbiowdlxC1uFJW89i6MMh56zkAUuYjYVR7C8q4PceGb/FWi7
	ubOuzUu5XcSHmga0e625K37R/KfVXkfOajlodK9vmVqHCGNtHCrsgEZDqgNKReg/
	LnsZdOZvIKGu3riBdmtT9+iaQMopYfGjD0w4oLSsQk1gPljRIu84g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahs64n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536OAS7021196;
	Wed, 3 Jun 2026 06:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhescm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536Rv4E30278130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:27:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BF642004B;
	Wed,  3 Jun 2026 06:27:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62AD320040;
	Wed,  3 Jun 2026 06:27:54 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.24.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:27:54 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 1/3] powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
Date: Wed,  3 Jun 2026 11:57:41 +0530
Message-ID: <20260603062743.1152253-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
References: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX4c1QArWfljhH
 o9R9K7dW9Pey/MGA9b+oGdXCI+tuKtbmTAXv8oe0dgw2Gj/lBO6dz2++Wqgo/l0L+zke/q6WgeH
 /nxmYQq3kPO2A8R5ZorDcKTXnq5Rk+LyRGdGZ6FJD2n4pwruApBYyRNJLoIM2Cd2rdlRfYoJNYk
 Mt5bz9PFZOP/tH0meTptlyaBExOCxMcMqdKO869z4zqnhFhx4w8GQUdiBzjsP8Lqt5JQGm57bkL
 1byzGJYLEPZrHtRS3Or1A0SBqyaQ8XctF5ZqvtBA4ip/qJhV6xg+RhrwaspBtFPwIyKsQQ3oEDp
 e5DWT8cq+n9mOF8O9F1zuO6e2hTCg0PHBId4NkXyYpUIZ1HIXcX+rNxTPk8Xln628CCCPCqUXdu
 XXtkpnLJj3clKp6KIcTNCaecHWa6EreaVw7hzgY7sMPu7PrMnrZOg9kOIrJRAMeHG2h2Wz9cmDC
 6QFSyc07BWaJlUhgzRQ==
X-Proofpoint-ORIG-GUID: xs-p6tdLRBKDoLyAJ8WU9_8v9dRYH4Cc
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1fc972 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-qzNKB2iBSQ2TZesQmUA:9
X-Proofpoint-GUID: pbHtMBC4par7jfvnfN5FHAKH4ZukmdfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

fsl_emb_pmu_del() unconditionally calls put_cpu_var(cpu_hw_events) at
the 'out:' label, but only calls the matching get_cpu_var() after the
'i < 0' early-return check. When event->hw.idx is negative the
function jumps to 'out:' without having taken get_cpu_var(), and the
trailing put_cpu_var() then issues an unmatched preempt_enable(),
underflowing preempt_count.

On a CONFIG_PREEMPT=y kernel preempt_count would underflow and
eventually present as a 'scheduling while atomic' BUG.

Move put_cpu_var() to pair with get_cpu_var() so the percpu access is
correctly bracketed and the 'out:' label only handles perf_pmu_enable.

Fixes: a11106544f33 ("powerpc/perf: e500 support")
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/perf/core-fsl-emb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 7120ab20cbfe..02b5dd74c187 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -366,9 +366,10 @@ static void fsl_emb_pmu_del(struct perf_event *event, int flags)
 
 	cpuhw->n_events--;
 
+	put_cpu_var(cpu_hw_events);
+
  out:
 	perf_pmu_enable(event->pmu);
-	put_cpu_var(cpu_hw_events);
 }
 
 static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)
-- 
2.54.0


