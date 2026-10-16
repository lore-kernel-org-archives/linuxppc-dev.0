Return-Path: <linuxppc-dev+bounces-29602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C14CCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htL2D05z3bxp;
	Fri, 16 Oct 2026 22:05:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148714;
	cv=none; b=QLjodTjfHTHusTSsX7NpeY1ufCftNE6PpaPg5M3WQQpJ9CnFU1XLlk5GWDvpwvFmwrR38snI6/3iQgxbCi5sLOq3aD9N03ScRnRekRIZ6nxaC2Y2sfDahx1gTma7P/kyuBo590S/WrZbTQxEaEgc2fQFFztfDyYm4Nf016go2LAemfc4/LPw1yup/K7lJZ/VIxTewNc8fUERtqbhnmnvH0gP+qwDjcus4NC5YChexo1H8/ex68rgPnxSqnr6seZwGdYQSE8QhANfN+I3wq6Umnymnm2BNnUCiWPaFPlvGfnEx0pDA3ZrujEmK23uJwDFKdplW0VJunD0YfP4pZ9pgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148714; c=relaxed/relaxed;
	bh=gzIMU1lprTY7s5W0f0/E0wPeOKAOuhxsm4qumfhYU5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVEUAHGLTLJrHiD5gLqyjANgcTdYdGi2SrGb2/AGxqtMXBMvu2Qx5dSjct0anGGNfMBY3c4ILEudnDSl3TCN3g24Qt3z3lx6ENuSuOZi9l8Sb4++mBZVurUQmQfemhQJ2rXWroFJwLbxbDh1loaMIm9NC7BcA+bxTgnStO9m5nAihpwANl2M55FbiZpVcNZADJWqzYBmaWqmD6ayqS/XldyYTItCICEw5yHGarfbup2f7yvK79RJn63289R5NrdVALhmslanhbovqzSFx2qX23p+g4RQPRX43ef4w8+F0p7VKWoYR6ihcPT/W6wYYz9jVlHPGxg29/LSrzdwrwgcKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AJ2y0Sn9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AJ2y0Sn9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5htK2HNZz3btt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:13 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAE8m51774771;
	Fri, 16 Oct 2026 11:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gzIMU1lprTY7s5W0f
	0/E0wPeOKAOuhxsm4qumfhYU5U=; b=AJ2y0Sn9yYdZ3rtrwQQFzJL5nB4DSLyfQ
	DsMW3maBMBPnBNCOvexmN+mL7tAlSzHL1jdhtLTMWTfAEshQGyHhH6zIG7Qbf6rT
	zACopsdTer6Oh4pboLX47cRLgzjV8yDbuD+rl+MvEbgt1yBnnqYLOmb/HiZA18oL
	//pGmRhDFW1aOMaI9JDlfke8lKiX73F829Ws1f80OsWAbFeotKSgyHdnxDgA4JYv
	Ru1FpyXEr/rL8cH51+s91x3A6iYyjqSbR0+cKogz/CxOXha5kBjN2SpTFpkDc+WE
	Mytg9J0+2bEyYEBTmpgsWGYiykiDV1p5i0b77dtU1hbcaRlwk5T/Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhxwdp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAYsbq3534812;
	Fri, 16 Oct 2026 11:04:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypqb2s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4swT47579608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285152004B;
	Fri, 16 Oct 2026 11:04:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 688C720040;
	Fri, 16 Oct 2026 11:04:51 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:51 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] powerpc/numa: Consolidate associativity lookup in parse_numa_properties
Date: Fri, 16 Oct 2026 16:34:10 +0530
Message-ID: <20261016110412.1380298-6-srikar@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX6qIn9ij9Muf7
 oS55GUmdLonBNOXNOdRGrpOCVILq/rVOhoOGg01DJcODCfnuNYWVbDnKMKV6PSkyJM7IwW2/Cxx
 VSco+ekOCj8iOxOp1V+/49uh56dR8rY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfXwB0PvEqIcSm2
 DugJ1NZ/wDKKbNgU7Lm2oo9wa8gapsTmV7xCMk9SGkiG1l8fZzzRo4NdJO2RV56V91mhVJRdb1C
 K+aUMItCShyP098E7fkUVYtK44F1fmN3FVn+mEHDvj6GhqJf3X7DRVtbTcBRvVuinQccLVkcale
 oYA2778l/TDbvrIXF2YxDyoxyEEPEYq/RX4barts63S3hRZ646zlizpzOPY0IjlfQgzYEXrcjIT
 D223Gv0ycPXrTkvJfH/X39PKBhc9str+aTRZ+yqbqWNxCBgiZCf7Cm2yGcLo/3Ldi1XQKfg21//
 Aep/y0QQKfHrDrFPNSfI4YJjRsuOEwR5XJ6SeuGBgXgwNV+JFPyrDFj5kCoiwCQN0jprP6kMECA
 W4IQL90eHKh8hM0tB9EltYSFHAi/dWjgn9FUV5kzOvuWhIDbF0MVHGIWIYL6jp4chngao3eQzRT
 56TtKLzVwkJ/O1TOTPg==
X-Proofpoint-GUID: ANmADZKCdFz1pbHFa_MSuqISLBh_XRh7
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad204db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=l-5_yRjKRVHm491GHVAA:9
X-Proofpoint-ORIG-GUID: GiBhVEH-_Sw07U0hpNdd0c4vyWharw-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160042

Refactor the CPU associativity lookup logic to reduce code nesting and
improve readability. Previously, the code had separate paths for VPHN
and device tree lookups with duplicated processing logic.

Consolidate the lookup into a unified flow:
1. Try VPHN associativity if firmware supports it
2. Fall back to device tree associativity if VPHN fails or unavailable
3. Process the associativity information once, regardless of source

No functional change is intended. Both VPHN and device tree paths
continue to work as before, with the common associativity processing
performed in one place.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index ffdb07b995a8..c2aefb60ed5a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -920,6 +920,7 @@ static int detect_and_enable_coregroup(const __be32 *associativity, int index)
 
 static int __init parse_numa_properties(void)
 {
+	bool vphn = firmware_has_feature(FW_FEATURE_VPHN);
 	struct device_node *memory, *pci;
 	int default_nid = 0, index = 0;
 	const __be32 *associativity;
@@ -951,17 +952,16 @@ static int __init parse_numa_properties(void)
 	 */
 	for_each_present_cpu(i) {
 		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
+		struct device_node *cpu = NULL;
 		int nid = NUMA_NO_NODE;
 
-		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
-
-		if (vphn_get_associativity(i, vphn_assoc) == 0) {
-			nid = associativity_to_nid(vphn_assoc);
-			initialize_form1_numa_distance(vphn_assoc);
-			index = detect_and_enable_coregroup(vphn_assoc, index);
-		} else {
-			struct device_node *cpu;
-
+		associativity = NULL;
+		if (vphn) {
+			memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
+			if (vphn_get_associativity(i, vphn_assoc) == 0)
+				associativity = vphn_assoc;
+		}
+		if (!associativity) {
 			/*
 			 * Don't fall back to default_nid yet -- we will plug
 			 * cpus into nodes once the memory scan has discovered
@@ -971,13 +971,14 @@ static int __init parse_numa_properties(void)
 			BUG_ON(!cpu);
 
 			associativity = of_get_associativity(cpu);
-			if (associativity) {
-				nid = associativity_to_nid(associativity);
-				index = detect_and_enable_coregroup(associativity, index);
-				initialize_form1_numa_distance(associativity);
-			}
-			of_node_put(cpu);
 		}
+		if (associativity) {
+			nid = associativity_to_nid(associativity);
+			initialize_form1_numa_distance(associativity);
+			index = detect_and_enable_coregroup(associativity, index);
+		}
+		if (cpu)
+			of_node_put(cpu);
 
 		/* node_set_online() is an UB if 'nid' is negative */
 		if (likely(nid >= 0) && numa_enabled)
-- 
2.47.1


