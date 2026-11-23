Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD47606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BdvnxlKU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY5Mv2Wdjz3bSK;
	Mon, 23 Nov 2026 23:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795438107;
	cv=none; b=HJzHHG31SxMXTQSN5xzToRXstEY/AVV19J+fZzS2HnfwfwveUNPXHoc3+XKY0PVGqQzUYoytq67gB0qWEByjFLLLEUfUtZpMWiSUKlzg5TN9MvVYHrYaC//IdecgP3I0dVMgJqoaktC/J3mULTVbEX9I3IDX9QAsc9U8KcbHIYXRLhRJnm4UVliID2nFHb6KC16HbYCozuihOYNMmGmZr/jJlgSWPHybHTMSHZ2RfbBYaTwYx6YtWpplf1cIXIv5Dkh73XFrqBl5fVvUD7RbPqYrefhzSHgXLMH2SMUTscZLCN8xuCgZA1mhgVh0tC5Lk93h8kOQz+45SB3wH/pmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795438107; c=relaxed/relaxed;
	bh=WtU6nCQMnkoGM0UjISxkxbffoMiC/gqctaYoXghFEpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY4VYOCjSp1HQLpbXQscTDYlbmlNjXLHcS9sfynU7XqyFoRlK6KLggSK51hZbNL33+NXM9o1y+96pdH+ErE9YngyYCnIWULAwSCdocrXr9LPCbPhNTrgjPFHhizhJxRjHihl8x4WKArgGsLASGp1rzFQk1VwbEdx0+K/karyvpC5J5XQGZ4ncWxdLD9O8ebx8cDIES3m2kNBjUb5RhbqJrW6BSV6gWFFNGrE7fuI5w/SPLvFEqvGfj9v1ryVNF0mRo/2weFeYdYq9FpR0C0iG1iOEGYQrXhJLPj5+Vqvd1azkd5SE2OHFgwJCNVHAiqaQr1/rN4SrBoyR0iZAbNdLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BdvnxlKU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BdvnxlKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY5Mt49DQz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 23:48:26 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCYhOm2361643;
	Mon, 23 Nov 2026 12:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WtU6nCQMnkoGM0UjI
	SxkxbffoMiC/gqctaYoXghFEpA=; b=BdvnxlKUTEUIGsf9Uh1kpe1xm5kAme3os
	QXR6MNyNbBmYnQMeGLhaLwMfhEBVbU0BdUo3rkWQfLuX7UwQ/0fQG2dRSzCF4kqk
	LJaaLm05JwCCUd8NymI0mn2JZ9/YN8wmPh/7Jr+aaus4LvU/baeBfRfnbfpS1bEf
	YjU7HJlGMgIgAK1/czML8K/zbuvoyLi4VYSFpegr0oTrRjlvf6ZFNyLMOXmdiaDv
	cvscEGleTCSbW6KOwTczIwVvP33H7B/p6qv5jJXeoiHxMmaxNp9A0ZlmZJduZTy2
	ZvDQaD1brRpxLN0eKAjHFoSNyUBVEoE/UCDPPx8XtMWMKyzbCCN0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4ars5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:48:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJMu73291225;
	Mon, 23 Nov 2026 12:48:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjxtsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANCm1Uu52560348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 12:48:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DA3320043;
	Mon, 23 Nov 2026 12:48:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF032004D;
	Mon, 23 Nov 2026 12:47:56 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.24.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 12:47:56 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH v3 4/4] powerpc: Skip llc_override on SPLPAR
Date: Mon, 23 Nov 2026 18:17:30 +0530
Message-ID: <20261123124730.1466978-5-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123124730.1466978-1-sshegde@linux.ibm.com>
References: <20261123124730.1466978-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfXyn9Q/gG7XILG
 cfAtvfKfX4dugHrBOLRFBRcUVsgJSmsX09DLoOSOaRbhSQe500eR2pS8FUdpnNI/CyC08rIAhEv
 gzWqBt6rq5WsG26RUCxKfzyT1yctzBc=
X-Proofpoint-GUID: Z2ccFzxBiQqLmI9IqOIQYUaq0ey9q1SL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfXxj6Jdv9wt2ge
 J5IhIH3uXeJL2LkJJX4K/HDviloWBmnbR3JQCIB5S6PTubeZI36sayL1biikCOJBxB3WHAaSp+i
 hrfYYcQ7gO13+xNde2Fsn9AVa6mrf7yiW5kodIxAjPBDh2lPyDlffMVCNt7lGwIOsS5C3/Wbxtc
 LirjHdBu6mu30ZsZAWY9ZzpIjx6a6t1P7DFggA3yoKmf0t0mx46e4YyeEwv8OtJIMxz/2qRmDjd
 GxzjyHOxFJyiAy2OS2DCHFUQVgPHPL649ZkrgNGd5Gs/HkIEyPQIO+Syxjt95dktcGxwzcRrqwb
 Sp3awf6Fsdbok6ld1m17HKLr9nxjzKZKv1il+K1CkAjOwvQiqJ1+bV1kSbi4osPAQORjXZ2K/H/
 EkPlI1GKDoTP6WHFgg6cCrCX95eU24kjZQW6RYH3bvhUkenAenQxgTgjrdkpBCJfYWU89iE5ftz
 dctrJ1cVqu9LckPkytQ==
X-Proofpoint-ORIG-GUID: L2jriY7Q1tvno5-uBIOiO1ttAZuJSc1F
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b043606 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hh2QMeoAHG2hpmyn-b8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On shared-processor LPARs, firmware exposes only the L1 cache information
to the guest. The physical L2 and L3 size and sharing information needed
to calculate the effective LLC capacity are unavailable.

Using llc_override in this configuration would leave llc_bytes at zero.
Reject the parameter on shared-processor LPARs for now.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7b9682e55c56..9b0fc661083a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1104,6 +1104,11 @@ const struct cpumask *arch_llc_mask(int cpu)
 
 static int __init set_llc_override(char *str)
 {
+	if (is_shared_processor()) {
+		pr_warn("llc_override is not supported on Shared Processor LPARs\n");
+		return 1;
+	}
+
 	if (!strcasecmp(str, "mc") && has_coregroup_support())
 		llc_override = LLC_OVERRIDE_MC;
 	else if (!strcasecmp(str, "pkg"))
-- 
2.52.0


