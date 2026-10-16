Return-Path: <linuxppc-dev+bounces-29600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7A2CCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htJ6DXsz3bt2;
	Fri, 16 Oct 2026 22:05:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148712;
	cv=none; b=UxHvU0DYECv5Is0zNdHtEHd5AicC5fQjMb5OpFrQXnhUHZp7RoqBmAnftvPxkefTa2gglnjw1mZFTd6mkzOL7Nw8WndD0EfOzjTgJR+YM/hiunoa8HlqmWzkpFzg+AI0ovUKuiGPIQgoWjJmc64hoDv1psQwJx0Z6HcMHhPr/zP5eYWScmLEytAczNLgg3CKgqy+/kZCIX+vSksm+0jahYPCIeMevTqwFNW0OgwzLlY/XKOJm3RP3wleK7nbnvQLM8vqsbvRpl1qWwy5lndo6fK57q6BO7fT9BnWVjCZoC0yFAgLX0lkltgO7b82HDiA4jmdMh8GqjDxsLYyZoIQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148712; c=relaxed/relaxed;
	bh=O1/k7BEPWedblCgRIKV+dMiPtjVo72vwqXg/OCQ9JYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhrL6/n/pdWMi5OMfSSq/hVAzAdtNOydR7+3+YGn/mFjfhRn22LPY8KvML1Es8qbqH/3sdK0jmBPbNol1GoXlydJyy7m8B1Iscp/V2beWPLPmwiFvCN6N4QxfwQL+Uelo14IqEQGWHyWrAckdS4wVYLcrU7+q/g3Y1K7HAKwFzBn7QU9Tnjy313gmZ8IC50+3DouveRKvCpGagzNTLMzdLnrudyyjwv2syQADEhBWoAO/qxWaOScad+l73czLcgTu4DpEO9jJdUSEx9MBtK8gczG1mqmtmMHWCcw8qbY2m8pY1+HEspYwCOIV4GQBR4e0o6NyivDu1mBgmAZ9mT6Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YdvaZ8OY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YdvaZ8OY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5htJ1w8Sz30B9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:12 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAEItT3635226;
	Fri, 16 Oct 2026 11:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O1/k7BEPWedblCgRI
	KV+dMiPtjVo72vwqXg/OCQ9JYA=; b=YdvaZ8OYv13n9uYyLrIC5XC1rK2fthdy9
	578xWbto+5ScOaerniy0yuyE2H5fSxq4KHItP9tDTgtE9u2xuqDUa0KIEIgVNte0
	xbKdtWt7WqohD83tNb87312XXkTWrzDUVzfu9lcmblpmFWlgMr5VBTZZnm47NJ4r
	+gzwMpCqyAHqoglsFVpjJZWiXp6mVovp2YPA8FDfz62cB/8ATmov/6glQPIES+ng
	CEPYeLKtFsq7/atL2CAWpB8bwU3359DLnpK60JohtxKKX78iSK9OiMPyeyLKQrbr
	lMUzkjMuQvN9CSmsjYkcp6xh/X7MVPMjsPSvYWjCRpyoop53xXRhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugxwj6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAK3u62327450;
	Fri, 16 Oct 2026 11:04:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvgbf2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4p7X50659720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C0E520040;
	Fri, 16 Oct 2026 11:04:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB622004F;
	Fri, 16 Oct 2026 11:04:49 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:49 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] powerpc/numa: Allow coregroup detection when NUMA is disabled
Date: Fri, 16 Oct 2026 16:34:09 +0530
Message-ID: <20261016110412.1380298-5-srikar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ad204d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=EcGycqTSA_H_-Od9rUwA:9
X-Proofpoint-GUID: Aih-8uAAJBTbB3RdtG_ttuGEeIeQXkTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX8cB4CdSuYopP
 zgcWi+BIsjicvBnbVybuMFJjdM/QghjyI5NMKO3ctOSJjh44EyzWP+KjkoXQ6+48m/VucP9q2cE
 +onQRs58fTaBcAdPbmVoWAwaAL9S+R/dF000sI4KuTveebD70ejOMxj/2QfanGxMaRjHni/loTx
 vgsLdbRePz87skRDkn42g0Ee+oxaV1I/p4YD1q/+eIyuJAUIIMPwzU/L1Q5Jjy/ssK/6tVcP8at
 elvZ1qHilb1r5Kx3aL2K5/n3K5QniAANkUsBcEXwoaCesLXhPCkRjpncrA+5feugfPmQXm9bF+a
 qZro3y81tTDzj0uNgX16xb4IaijQT7Xsz8L74hTQvL51UGgeU4KcCbBGn1yc1oxnNtmkSflFeq0
 GJXq99AFdj09G6EvoLT6bwqIkwI8WMBgErzOMmCWQkgw4rCKAIeWnoiX8/fkem11fTQ27pTvH02
 BFx5VQ3jYJHgpS94SdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX+OJV/POAaKAj
 k3cumFAewXrvZf1PEi5xeJVOagB5bNG9g1QF61nFoOZxNG+emqSp/9IMI79ho05QS9JhgvDhgFU
 9mXGkmIWSX8Ju5XKlMpqpu+KmpAdwUI=
X-Proofpoint-ORIG-GUID: Z353TaMdnjwHGalThy0w42LRVzZCnhjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042

parse_numa_properties() currently returns immediately when NUMA is
disabled, which also prevents CPU associativity from being parsed for
coregroup information.

Move the numa_enabled check after CPU associativity processing so that
coregroup topology can still be detected. Keep node onlining conditional
on NUMA being enabled and return before processing memory and PCI NUMA
information when NUMA is disabled.

This allows coregroup topology to be initialized independently of NUMA
node topology.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 7cb37cb0c5db..ffdb07b995a8 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -925,11 +925,6 @@ static int __init parse_numa_properties(void)
 	const __be32 *associativity;
 	unsigned long i;
 
-	if (numa_enabled == 0) {
-		pr_warn("disabled by user\n");
-		return -1;
-	}
-
 	primary_domain_index = find_primary_domain_index();
 
 	if (primary_domain_index < 0) {
@@ -985,10 +980,15 @@ static int __init parse_numa_properties(void)
 		}
 
 		/* node_set_online() is an UB if 'nid' is negative */
-		if (likely(nid >= 0))
+		if (likely(nid >= 0) && numa_enabled)
 			node_set_online(nid);
 	}
 
+	if (numa_enabled == 0) {
+		pr_warn("disabled by user\n");
+		return -1;
+	}
+
 	get_n_mem_cells(&n_mem_addr_cells, &n_mem_size_cells);
 
 	for_each_node_by_type(memory, "memory") {
-- 
2.47.1


