Return-Path: <linuxppc-dev+bounces-26443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EB3C624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 12:36:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZhzq1SHtz2ytj;
	Wed, 02 Sep 2026 22:36:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788352583;
	cv=none; b=jT7JlHzxcrWhHXlZ6cUDvrhpuQnL+Nh7QrOOu9uL0nTS0VeUYfxtQfgcRA8E+ngiiVr8VhDFepvOo2s2sTEMppZsgmW/zKpTr/dyV9JNqhi79VQaj52ZOOlCPcr4LLCWCnlMXSYnd8Rciy1o6RSXMOX/2tVeCTH/bqVDbLNpuy0U8e3gLHQ+j96YVDT422VztZkuuYAxN1lA7jTgjdg3oYFY/n1vAwpLFVN41YMQWDnN+8tJlZRWOQEMEBkekw+f0QuvObSNPoY6cNdzpNpPm0yUeqDx/WHbX2/BRG3y82E58vL99JGLMV8+yVu+vgvGMhgPZ5wCo42NZO6xo0hz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788352583; c=relaxed/relaxed;
	bh=9USx7SBxQdUVBkBwlnaMqaLZsuMs+5ljn2vpYH326po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuGFf9v9358saxAyYeH7FCvCDnJ9eJdtDrAzzYMR8Pf6375fXGiU7yBOfvBFgKU/Aa1ZJdzzO1QBrISFwJR5+fBld3NrhWVOIuR0Upa2AZiSCACgbr4DIci0VDB7hYadvRAiZHKWZsL33Zho0gFQmo8dHjyycfgAqpXuWnENj+ibLiqN3bXp/oOIN5QFMDhjVYkKRZ1gRytrzrzMP+EEQ7JPwfG/dXnM3i/na2pEnk7fsTh34q8kx7FBJgkGjuOrKqIjqYJoOu65yuoZsYp9GF6XyqDiBxmtLf4o3yzMdeoWL8DDwmlAIXVLgOTOL/6O68+Jrt7S2Zqf070EzkiwHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ayzL9ECJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ayzL9ECJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZhzp23wwz2ynZ;
	Wed, 02 Sep 2026 22:36:21 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVlAx4189252;
	Wed, 2 Sep 2026 12:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9USx7SBxQdUVBkBwl
	naMqaLZsuMs+5ljn2vpYH326po=; b=ayzL9ECJCGIh8kSqSUU7JO1tN7pZ6NT6v
	4HdBCg3H6oyqN5zbCqbonH7IMtlmZ296PtxoX5yX2UdKYV3aB9lLzS8IZPt8SWv7
	iEWLp3D/okF2g3WPDPw1gmvysi6tv02NkbvlEqeH0xk4cVoiWZ0krAYpIU5udoOz
	9+1itECSfJpMNT3vNEwcl1MBYryMU7KrwPEWih5vuYU3cB4ifVbFgjlZHEUOVkBr
	UJygtoLVb+I5XNbb/e1RpwPazZXwHr/rUPzCHHodlPuLvWZe32naFmoaqvn5xMFY
	FKQwDBMhVTzy0yqWzQ3/Weqf1aoK1drUIr9k2fq5CUpjwTov/1hnw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5pd3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CU1Ki024915;
	Wed, 2 Sep 2026 12:36:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaj05w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682Ca0Of39256406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 12:36:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87A7820043;
	Wed,  2 Sep 2026 12:36:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224FA20040;
	Wed,  2 Sep 2026 12:35:57 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.111.3.140])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 12:35:56 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] powerpc/numa: Simplify find_primary_domain_index
Date: Wed,  2 Sep 2026 18:05:00 +0530
Message-ID: <20260902123458.340456-6-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902123458.340456-5-srikar@linux.ibm.com>
References: <20260902123458.340456-5-srikar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a981836 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PUaLgzmSHm3KdX723h0A:9
X-Proofpoint-GUID: HyVEp5nbC4GRYEsQGOpoOYb2ioRYH7BH
X-Proofpoint-ORIG-GUID: p9cgBGVPMIrlnbsmqXXp-URB0jLhVryp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX+Rv60LOYO/ob
 Xhhs40CxyGL6LlWn8lbyAket0vuxT+xmzZJyXjaXnpRDlnGuPFY+ZBww0M+4jnHq/JdOBnqoICD
 OVDQSDV3E2poiUqTCYrXgnAtXYTpuxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX6xchg/jDQ8uR
 qK46S+UraSCQn9tz+oqagV+QBOpwc1ApKHVb0buo0/WrgoVqmSHKprB5lmgLlPJCbI9RB2XPCye
 hRiKRwPx5ZQ7uhuQzYZFRuZrx5zgVxYwKGE2SqX53c8v4uC+9C2Rufh9g9P7Tr4ZQW282P9P3J6
 fNTkiuMAtpACjHGATdISapUvrURf8Af+I8zDtkifEx/xf1pA+DfaJd54jcEpvoIq0ie3I6ixZCo
 DgcRl8Mhyy1lgv1t/9nx3+Mwi693JMtdRoQeEZ9NgfRg1PEwp5GYSmXtFd+oNOJf6qynj49wgzY
 4+n+8usjq+jmajKBCBRXxZwfbJ1Dgv3jFwlMp/WU7Hwo87RDeNDrbtSt+JlWHBXq7dF2GLF8t1m
 SbYyyxj/3cx3cZjWXU15s0wHdWXQLdsgTZcpEMzuZ1qFYmct4UBVqKZZ+/In8kCx9KHzgEbraY5
 qqqsvp/lPJFyiBzeiBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020111

Initialize the return value once and use a single exit path in
find_primary_domain_index().

This is a small cleanup that keeps the existing behavior unchanged while
making the control flow easier to follow.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog from v1:
- Handle comments from Christophe Leroy

 arch/powerpc/mm/numa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f4cf3ae036de..c44a80d8fc11 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
 
 static int __init find_primary_domain_index(void)
 {
-	int index;
+	int index = -1;
 	struct device_node *root;
 
 	/*
@@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
 		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
 	}
 
-	of_node_put(root);
-	return index;
-
 err:
 	of_node_put(root);
-	return -1;
+	return index;
 }
 
 static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
-- 
2.43.7


