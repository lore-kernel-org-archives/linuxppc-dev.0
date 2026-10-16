Return-Path: <linuxppc-dev+bounces-29599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD69CCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htH0x1bz3bnJ;
	Fri, 16 Oct 2026 22:05:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148711;
	cv=none; b=f78JqeNZjzAijNWFcQYirT+Jvy9iWGlurJkIzNjBjcF+jK1C/ChoyQY2l6bLypt0ylTYmdpB2hqhb60gzGTTDWjsKP+T+WC7PfwykwcDv0kJWXwUCni+/lFFkwHbgNnNE6855DTjbsOreGYGeZaxQRRonaCaoMvg7vxfkk/bclNx/BeXDbSBlC357F2mQAX9umOPJzfWIVSN9uuMm7wJmE4AH/w4FttbBloNZUrl44PCj0zLkRpLQcGygk+9I4Cq4kf7dChcYxwTm3GOl+2D8gGN4ZoMGTn1Pva5/P1YNQE2FAe2cWd/so2X3YIkvg/e6A/zc2Lqx8DzzgIgwkyNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148711; c=relaxed/relaxed;
	bh=fBKzhI09b8vt7kBneGZMd23RhDzNyWtlOc6ZfphTG+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxICOKWnGn2ZIiCIVnOXLCREv/CvPWdD/bcf6oscDEUFfrPwe2sdX8cm27cabtY8HpHUJ6L7kROvl2SOVr2WIjCVHYIbKlbCu9yB1AwI1vCKWfsPrZyE3uJmLAnkO3Qfr9pjEeA5I0WXoiT4k7ESe2cNkrQ67rWwbZtcZjIM0oM8ukWcMAs06jYZv78NQ2SaZEXirrBEz+eq9bJLepnTJqkK4xp4izuI9jc4qI8T5OX7jWpFVMh8YjkEK9gAzOWU7iEarSNGANR7YihaxLMEA+EvamybW1BknKRSRHFtYZz2bDt7am1nIy9ii3/zmliwbABTldRX4Aj0A6Ksha5VAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J4utemGY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J4utemGY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5htG2sW2z30B9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:09 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAEZgq1777453;
	Fri, 16 Oct 2026 11:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fBKzhI09b8vt7kBne
	GZMd23RhDzNyWtlOc6ZfphTG+w=; b=J4utemGY90aT9tQerFiEuX7t48Jd3MWHg
	Yr2hTwXeuJeEzxOAS+betX+zqvYhRtupXX7KhT3f7Up7sUmCmA01KNm5HqgKtiby
	HyMVSSMXfJMoUX1GFmUn+t//M5cAtMGzWRrcbkRKXPkjJoPA+r5KBbqZTZeSFber
	6LTe7eUjgmTO6UyjnAwAVfydAUMlVeM7coi3178x+7pm+izePfGustaxZdoN9iZR
	lvXzb+tqjVKE1mBxgfJSlZfrUvPy3tLJgUIpCOzolsEG8rl98BZ0x5XQ1KF28/xP
	d+po1gfwlZ8W5kh7j5zMfKigovuT8utfuf/3olHFhI44Ak6bCPcHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhxwd8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAKASG2327563;
	Fri, 16 Oct 2026 11:04:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvgbf1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4laI45613418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 078A420043;
	Fri, 16 Oct 2026 11:04:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BE242004E;
	Fri, 16 Oct 2026 11:04:45 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:45 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/numa: Consolidate VPHN associativity lookup
Date: Fri, 16 Oct 2026 16:34:07 +0530
Message-ID: <20261016110412.1380298-3-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016110412.1380298-1-srikar@linux.ibm.com>
References: <20261016110412.1380298-1-srikar@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX9PEzUP/dkPBl
 hevwjp7tJXl+s/aiCshgrVVwAJqwru6JSUF+BP6ylnmBtIKsgaByiPTi3K6Qqwd1PI+WcW+d0vQ
 5MoWEPfyAcwHIogSrUb0jQMv1XtkO8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX8Y/qX6b6U0l2
 f6sxqSGmOZqtL6zCyyjoq1y1pBKuCxSORDRnDdaw/2DJ1KtF9USL1amYDV6Jvpw6OKUmzypplWn
 1XTdqd5A2Rde8itz1CBaXFN5vg1T4sLJfzFWihjarfIE8mAaUxsv7s+d1aBKvlRQzB3oEgJ4IxF
 823GkUfb3nh12Z6Lz4MDQ5lmkscpOBZSOjQtx/YYnYKBYIoef1u4i8zdJwLBXbIiORRlYdJ321m
 dbxPAFM6mCztavMbA8b1f0qpZnB5HlI5nf9r76/ilhacKi8deyC2FNNjPmMK0Yfd1FOSeBUqKRD
 9EZx1SLomiJGK+xW78GFtdmVjO937l/nn2VFLH70mwapqqrb/pirJRwQexa0X5wV47Ob7DL9hG5
 pUChB0R5EKk53olbEbn2iAaLu0HEtGN1ZOhujEYBaR08/vmnWu4XsfpptFYoFBn3a0dsMmDZg+v
 XYQHIHYiwKPTokdsWRw==
X-Proofpoint-GUID: XWe8D0p79DeD6u6SoG3AI2ceOo_YOZZw
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad204d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=fTo0Ph9v-yiTVBY_jm4A:9
X-Proofpoint-ORIG-GUID: URn1_6xF73SEu4Y99qEnHvNsMNzJKHvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160042

There are two helpers for retrieving the associativity of a virtual
processor using VPHN. The helper used during NUMA initialization also
handles the case where the CPU is not yet mapped to a logical CPU,
while the helper used for topology updates operates on a logical CPU.

Consolidate them by extending the former helper to handle both cases.
If the argument corresponds to a possible CPU, translate it to its
hardware ID; otherwise, treat it as a hardware CPU ID directly.

Rename __vphn_get_associativity() to vphn_get_associativity() and use
it for both NUMA initialization and topology updates. Return the VPHN
hypercall return code instead of converting all failures to -1, and
remove the duplicate implementation.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 54 ++++--------------------------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 09f7e7b2b192..df3b51a1beb4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -641,7 +641,7 @@ int of_drconf_to_nid_single(struct drmem_lmb *lmb)
 
 #ifdef CONFIG_PPC_SPLPAR
 
-static int __vphn_get_associativity(long lcpu, __be32 *associativity)
+static long vphn_get_associativity(unsigned long lcpu, __be32 *associativity)
 {
 	long rc, hwid;
 
@@ -665,7 +665,7 @@ static int __vphn_get_associativity(long lcpu, __be32 *associativity)
 			return 0;
 	}
 
-	return -1;
+	return rc;
 }
 
 static int vphn_get_nid(long lcpu)
@@ -673,7 +673,7 @@ static int vphn_get_nid(long lcpu)
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 
 
-	if (!__vphn_get_associativity(lcpu, associativity))
+	if (!vphn_get_associativity(lcpu, associativity))
 		return associativity_to_nid(associativity);
 
 	return NUMA_NO_NODE;
@@ -681,7 +681,7 @@ static int vphn_get_nid(long lcpu)
 }
 #else
 
-static int __vphn_get_associativity(long lcpu, __be32 *associativity)
+static long vphn_get_associativity(unsigned long lcpu, __be32 *associativity)
 {
 	return -1;
 }
@@ -951,7 +951,7 @@ static int __init parse_numa_properties(void)
 
 		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
 
-		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
+		if (vphn_get_associativity(i, vphn_assoc) == 0) {
 			nid = associativity_to_nid(vphn_assoc);
 			initialize_form1_numa_distance(vphn_assoc);
 			index = detect_and_enable_coregroup(vphn_assoc, index);
@@ -1384,43 +1384,6 @@ u64 memory_hotplug_max(void)
 #ifdef CONFIG_PPC_SPLPAR
 static int topology_inited;
 
-/*
- * Retrieve the new associativity information for a virtual processor's
- * home node.
- */
-static long vphn_get_associativity(unsigned long cpu,
-					__be32 *associativity)
-{
-	long rc;
-
-	rc = hcall_vphn(get_hard_smp_processor_id(cpu),
-				VPHN_FLAG_VCPU, associativity);
-
-	switch (rc) {
-	case H_SUCCESS:
-		pr_debug("VPHN hcall succeeded. Reset polling...\n");
-		goto out;
-
-	case H_FUNCTION:
-		pr_err_ratelimited("VPHN unsupported. Disabling polling...\n");
-		break;
-	case H_HARDWARE:
-		pr_err_ratelimited("hcall_vphn() experienced a hardware fault "
-			"preventing VPHN. Disabling polling...\n");
-		break;
-	case H_PARAMETER:
-		pr_err_ratelimited("hcall_vphn() was passed an invalid parameter. "
-			"Disabling polling...\n");
-		break;
-	default:
-		pr_err_ratelimited("hcall_vphn() returned %ld. Disabling polling...\n"
-			, rc);
-		break;
-	}
-out:
-	return rc;
-}
-
 void find_and_update_cpu_nid(int cpu)
 {
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
@@ -1449,13 +1412,6 @@ static int topology_update_init(void)
 	return 0;
 }
 device_initcall(topology_update_init);
-
-#else
-static long vphn_get_associativity(unsigned long cpu,
-					__be32 *associativity)
-{
-	return -1;
-}
 #endif /* CONFIG_PPC_SPLPAR */
 
 int cpu_to_coregroup_id(int cpu)
-- 
2.47.1


