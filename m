Return-Path: <linuxppc-dev+bounces-22118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B481CD6E7B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:29:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWvk55Mz2z3bpP;
	Fri, 05 Jun 2026 18:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780648173;
	cv=none; b=QkClpQgEWbBlfritJVdw3NRdM6enX9kYms4zZE1PYx7HkWDBiyvv0stVu89Rg/2m1a+qTwt7Z/AfKDDhC6EKN0yb+elVpNyD5LLQOslmJgZlo4CGC/f94CmrGxB83Kh7Iuztij6uOP3z9dma4QRakxr5zr/Lh6yx6eK/mD7X/XOiqPj5hwGiEU63q8q/YdAH7e3NfwICD1gUaavct3kNWY27jJdFNlGO0Bu+LTQ1NO9zZ8OE+t/V6rzFMo0Q0hdFlQjgR5xgsmJVJIY3Q/B561SOl4STshWZZA0g1n65ES88Pdf7UwpLbtwcEp/Tac4ue38CVVemgRsAKdWYeqsPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780648173; c=relaxed/relaxed;
	bh=8+nYoA+x/dvSBguuBiHUHAojnvr48ap391q1RsglkA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCkNzfqIES75bUBq8TYD+n9iLckqZwAQTFaFLnJ9x9/FNKvLbOZpXGncmsl//7LCjqVzrCDcoRbDrgsiPpT2siAzzN7scF+Ui/Kf6KZZp+4T3wtWye7EnTwRTUSdxN9NiiGpzf6kRNQ3q+fXhsu4KvoqQkwdu2wbqlpM8Z/HhIRRK0wnXeu591JHdde9Lb3fzDc/r4khyZNw3Py6j6bC6uYEHD0e0m4jr+PekLQNyHAG77QYm9RrXHzY8d+JId1zhyI8ZKX0yQP85IlLIoNVHBpXtzdx25fbhjdpzRlK3ZE2IIGFuaocsng7BZTLbrYk8dDopA+s58EXEM55IR1HNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fcDLrfAW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fcDLrfAW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWvk46x6kz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 18:29:32 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6551QDbb2481076;
	Fri, 5 Jun 2026 08:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8+nYoA+x/dvSBguuB
	iHUHAojnvr48ap391q1RsglkA4=; b=fcDLrfAWncaGL26q8vD1YQzOySsTmtfu3
	ONAPwXTKrbWQ1B3NkR9XPfDl/aSSxdbb0efTAbbzpdm9suJyz4DuTQOjdvsoFqNo
	ZYwdkQ2BmTB3XHOTipkTegMd8u2HWhmWsab13OKPqHkLkuOVFU9rWVYNlm60ooee
	3JejS+IM7S7BLeOp54ddjHYaJipVasa8HZQsD2EiC+3gK5UptabKTZm3VuASBEoS
	jBo70LtUWRm0bhaFFBI9f0LUa6wFw7q83Z4zxZu5nkhynd1Jqowqzx266nsAo9Bz
	ER5aXrqhYBV8s5mtX+8sQc5vicsT19zDh3HGYYcZMiYXfXwqTM8BA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqkgyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6558OHAA001863;
	Fri, 5 Jun 2026 08:29:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kgvhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6558TOfk31261190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 08:29:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039382004D;
	Fri,  5 Jun 2026 08:29:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A068020040;
	Fri,  5 Jun 2026 08:29:21 +0000 (GMT)
Received: from aboo.bl1-in.ibm.com (unknown [9.123.14.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 08:29:21 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v3 1/3] powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
Date: Fri,  5 Jun 2026 13:59:10 +0530
Message-ID: <20260605082912.305100-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082912.305100-1-aboorvad@linux.ibm.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QhuRXniilY9g37LaWRLncqNVFvaFfz-S
X-Proofpoint-GUID: Cxst93E8hevUwdl3z3Z0r8g8nkqmtq-p
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a2288e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-qzNKB2iBSQ2TZesQmUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NyBTYWx0ZWRfX8T3xz0xqONHA
 Y+D3/ur3bcWcXvoINChZj5Jgec1gfiG4bOqR+gsO/sxqOcwgylh1PRNqMmrTxJWs4SUaej0MXIS
 0VLUMmOVyOSCRP9R65n1oYl4UHr2GaVWFzSUpcDz/Cp0QbAfkTEYGADbx/VidgQWyQio5lG778f
 /2qVCedsNMZ3eDNZzOTyq3JsbJxm4pbBImvHVDylBVhpd6Zu3U/ijLuMjk/PelKE6fdwFEzYCOG
 TkIaKPNoFUfInHGm2d5esimObcgd37Hvrj5GlKlYC9YWYTE2WzAE7kuiNSgzCr2HPmBuEGv37A7
 Bvq32WH911K5rTbPKXKOIxO8H+LHuyzbiaZxLty0SxUI8C0q2p9KuRVh7qTwgLFJyhUkkRaE21g
 5gQB2yzdI66uU1i/pPzAfHw1MKECuCT4HBpBX+VcbZb/t308tjzfEu7mSLvLrD6sFzQ3a07WRRK
 /hkKC0IhSD+50LIT4lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050077

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


