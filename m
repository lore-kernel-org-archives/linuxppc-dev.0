Return-Path: <linuxppc-dev+bounces-21028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209F0CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:09:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJm7K09B9z2xPb;
	Mon, 18 May 2026 15:09:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779080956;
	cv=none; b=QJlE9ik51CMEhNWeTpw+XAcyQT5LX2cDXUIlQd5/peH615JIAPygxKhAQ/TWQmvrfcfiw6USkFHm1zVJax5UWBhj81XvPDrA6ezFBTPhaAZN4TwMSCsMzEPynJb5F25JoZvyym7nAl3ufJ7eGLH+e+xdDq1Y0p338osXCKqe1q/Io6MUqetNqMzM5l4HbarRJdglv4CqT/m3HnNwcv9oYNlHXiYMTxONRa8W+/4urhmU/k2vbtkky5iPUGQ3MUjtLNkZqul7/hmlvi3dq3eqiRnQMwUlaEU5U0LN+RkouEEmNNN7tFkysmI/m8tfRShUOxOK4XvPDzfWw56OBQP7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779080956; c=relaxed/relaxed;
	bh=lMu/vpDdNx6Ekr3hpvhDe81ynMbqgAMOjfYi7vjOm+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaWKD0wVxtSo3O7iUG5XdOA6i118vMaWuQeq8PXN9MhNB6ZBbBBhWnUOmLWBpA/M6NxledJUVTvtKmgInUEGs0S/gikIEV2RHxJnrv/7KDwd6IfBR5/Sa6Lru5XJlKH9c2+QzNs6BA6oDISGotwk5LBFLlQebwbvnuLNCRbYMmrXH+T2aw6oGf/Z+Og18/CEi3FqBx2X39AWozZQFJ9FY52neu8r0mB/qczShzs69t2bI7BwMxN17ozXWDBuDgbOU93R3JzIDYMgTu9OPCtv0G6Kjz5L+8PH57kITjuN683Hin6Q9eSOjGRA+cFmrgl2JYAarQwix6NhxPoxMQd9+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dv1yZRKR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dv1yZRKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJm7J0xbhz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:09:15 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HBU4p64007147;
	Mon, 18 May 2026 05:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lMu/vpDdNx6Ekr3hp
	vhDe81ynMbqgAMOjfYi7vjOm+g=; b=Dv1yZRKRNjSGTgevf9M1/H/S3YYID/QBq
	uWevtctWKgR5B9elr0UFYJP6gY1NBF9/YiZMBQL2WSsyVp5wr0bI3YO1Ny9tjWnt
	j1EWypNmeTR7az7dBnP/hhvjZAZPplTA/sherayvkqmTXxsOlVUb/EBUCvZb/eu0
	boC9zv71LiHkBC1+SSGMXiYZdXBsD2aBhG1nLbPrQKpS9qw0ENLfTvZ59RDPXK1w
	nKHgLvLYmQDat6mrbuTcxgrD8u0Ma08sd5MEy7bzkXv8rozLkLsH+lbRR/OzY4A8
	oilw9DpZLudHax+eEbh+KH5pFRNQNhCnKl5YS4xEPHDqMOmM/YoNg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havwuar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5931j026796;
	Mon, 18 May 2026 05:09:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpveyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I596Bc31850918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:09:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF6052004B;
	Mon, 18 May 2026 05:09:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333A420049;
	Mon, 18 May 2026 05:09:03 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.124.214.53])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:09:02 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 1/3] powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
Date: Mon, 18 May 2026 10:38:53 +0530
Message-ID: <20260518050855.1147242-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0NiBTYWx0ZWRfX5UZOUDpGfQKu
 BKtrDEaj304LX8VOwCorLdh2KmIGSxYqU09IihmwPCZPEJPUXZVCm43xebjeBnDMJwor7K6ymu1
 NFiTiZkAfewaeKv8ez64UyqLN6YndL9gWneXJid9tEhthvn9QDllBIQ7+KHNbsu9els1SWkxZSU
 d6psjtYY7An5oWeSzXRoPmDJtymm3gX3A17r1fJBKvoKb8hPGtWV/PNd2P5ke4qwtBG+zIYQ0Lk
 VTfqdH6hpWD5oZF6JG0ZnyXAPIOFiqpP6cP6flY76W1gdZ3GwrGJlQgxZG1AvVGb3oOw+5MeH5/
 mP5EcvaKOakUPc7qoaZsVfDnJyXUcv+/c2CovPtY3jTtXgKgcv5j4eXM70dqjVQsU0gurrBEfUV
 cFv+cdU/PlvguJcj2yd1YmeOP/lAju/dU5tt/dX4TGUfr9MGwcIjgXl3AFApQ/vYBRK2NeDKU9P
 EIjs0fLt079TAGxBHrg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0a9ef6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-qzNKB2iBSQ2TZesQmUA:9
X-Proofpoint-ORIG-GUID: R5OLhjrXBAEml8L4J0j_p_RnDPsppf7_
X-Proofpoint-GUID: 3xCLEy9P5J4PAMny0CBofMXUJhW9L5P3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180046

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

Fixes: a11106544f33c ("powerpc/perf: e500 support")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/perf/core-fsl-emb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 7120ab20cbfec..02b5dd74c187a 100644
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


