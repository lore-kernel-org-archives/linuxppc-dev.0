Return-Path: <linuxppc-dev+bounces-20142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4973FF8861
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 04:47:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3rfB63Vmz2yrT;
	Mon, 27 Apr 2026 14:47:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777265266;
	cv=none; b=kScrJzXdDsCwVUb1GOXvgkeKsabz5JaJyuTBWJMRlAgJaRZMhCUjCM5Qmqs7CB7xEglRlmag7OQIwyJJOH45Npo5kknvNf/FVk73hnQE3fpANR5+OMkjomZ3qJlUMIbt7xaynugbjFHp1pmEvEDAs5UMKDYOByDrLNwJZyIctDCNLY7Rutz8Vz6bZVlXF31IllazEuZBhYiH3KSjemhHSNCJX6L3hYr8fiX4d+8tS0Mz1gn9X7VQbNIZDGKRG/znpKX+/5dNMYDrP5pmM/97Mt8XkRiXx965WxiIIak1gc2ogHUjcOp/rqy37RzeRYM3VdkDAlvZuO/RF1K1Pg86eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777265266; c=relaxed/relaxed;
	bh=dGiRNOyVUmIWVk4F1dtCEHUVSdZD9zV14kqCI+HQ5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0SkfOJEfZRJHCpGXtudxI41mZE9xvXrVMlPKuNT+uRUutFmYtKzjhpyGoGFJknC58xhdHmhC72KBCB9z+J5ceAT/tOIAw8620e5N54Qq9LNfF7JZH9vdg80uTs8R3whohNgm9NxB8xf+DH1PJF/o785o8nEnncGh9wfplDtpJU1vXU43An4h6ZeX0iRfbK32LeKGpmde4OG2lU9OnngEqZnmLVhU59fEjOCgBlQF0Pugr5fBrHeQTOsesHNg+VKiFW82gHO5KNHxFFkfoO0xUfG9IhAeFDde/taxOGcCi3vo3E+iVsuGerICY1mVjqNzeoFzDK5KIg4SGcfJl1s+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j9vDzH0F; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j9vDzH0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3rf973HFz2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:47:45 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNF8BG3347495;
	Mon, 27 Apr 2026 04:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dGiRNOyVUmIWVk4F1
	dtCEHUVSdZD9zV14kqCI+HQ5tE=; b=j9vDzH0Fda/eFHVX4iYVNv2yKFbuCOz/2
	na3A1WqLU9gPP/XRiwijt3U2ijUEU+mxLD/DRSWlpdaUpwuyBR02Re92Q3+56gyd
	tLFr0g9Ej5yOEC0QyXleQ1k6+nA3iJyKxJkSZMpoUAvie5oYAOEYmhR6YIylIsxi
	LWG1cICU0nYEb9UrghpCf2O2F5wetzPOfD79HmBa8sHyqc63CLN6dWgjbyAD4dK+
	AqZKFaZDtSYcAWcpY7HP9Lr/p48iqgbn/S7AGEHzA/TN8ImMnScgfwNs+HZxDfzZ
	51P20+GgxiBVkhkHkcsC/ywn6TWd86JZEtsNFtlx4ZQCNqNY4R17Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1je725-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R4cjdo028421;
	Mon, 27 Apr 2026 04:47:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xjupew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R4laZa55247294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 04:47:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A85620043;
	Mon, 27 Apr 2026 04:47:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A461E20040;
	Mon, 27 Apr 2026 04:47:34 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com (unknown [9.123.5.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 04:47:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org, Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 2/4] powerpc: Simplify cpumask api usage for cpuinfo display
Date: Mon, 27 Apr 2026 10:17:13 +0530
Message-ID: <20260427044715.559137-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0OCBTYWx0ZWRfX0OaDGhOeNei1
 iLIY4ThYGYegtUXewLql1PHQi4upCvjm4o2pWMUqY368MLpBTd3ejfZwFlK0NGEUlBS5vcanyN5
 2A4iAUR+HC3OMoMfjEFN8YKCxee4o2jOL5+1+YlXhNLAiqsIWhEha/9QaTc8gyQNicIkp5wC5Kh
 L5afj2yF8TuEf29kDIPlIkQq9J6WQnHjmwM92HJcDw8VtZ2eGd18mxiL0/AvjV4yn6fwXE916uc
 4gviuaRALt6Q2gFnQNipX7r6m3Xh+sWDvYGtzIFK37K9TRSymRUByndcODAIzvXnml4vqBbpNVS
 VvQ6BTKETBixMcaC0Sk/ABc1sDeF7LtSm4oktkoscg1a4b6IyE77IwRaMPDCIADyIMrgsjF9fUu
 t7q7ef3u6pKm1v6y2w6fZCLpDOSS0Gmpcxs73WDWo1pz9iwzWkoFggvPFX4LimEnI6IcfINa1ub
 ORVGT10s7Bjveqd+F0g==
X-Proofpoint-GUID: Upc1uyxRodZwEuuCzkjlZBPKai3cfcaD
X-Proofpoint-ORIG-GUID: 07IOpZuYhTq1HjwiYw6gPJX601WCmKBm
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69eeea6d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=1TO9j2vGO00jYUTp9YQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270048

- cpumask_next can take -1 as valid argument. So simplify cpuinfo
  iterator.

- Use cpumask_last to find if this_cpu is last online CPU.

/proc/cpuinfo shows same info with patch.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/setup-common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8a86b0efcb1c..aecabe9cf139 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -323,7 +323,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_putc(m, '\n');
 
 	/* If this is the last cpu, print the summary */
-	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
+	if (cpu_id == cpumask_last(cpu_online_mask))
 		show_cpuinfo_summary(m);
 
 	return 0;
@@ -331,10 +331,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	if (*pos == 0)	/* just in case, cpu 0 is not the first */
-		*pos = cpumask_first(cpu_online_mask);
-	else
-		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return (void *)(unsigned long)(*pos + 1);
 	return NULL;
-- 
2.47.3


