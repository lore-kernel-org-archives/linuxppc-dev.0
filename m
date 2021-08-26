Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA9C432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 10:08:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62318610E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 10:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62318610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwJTR0PCVz3cLC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 20:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MMRKlfzg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=MMRKlfzg; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GwJQB4Lcqz3bXP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2021 20:05:54 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17QA2q1x168326; Thu, 26 Aug 2021 06:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YpOB85s9qts8kVDG5SLlOn194fYJ9WV6lZzZHD6I0BI=;
 b=MMRKlfzg982sSs6TLffcavqHWBPH1Jzo2EwzdaEPJLuCcqvVv8d1Awq5OhFyqwqYdP8L
 oUbZf4nyt8yAp96flA44Dpfin+lAOBNbYdJLoUo8gCcRmcmfFftpWpwGYxEyNKvXqEtv
 IJq6sdUQIvZuLLuHrEiqnbiHdUkymAESJnOCHjUty0lBrxa1PMuEumz/VopoAAma8LGN
 WkDrqe16eXNIoawo5ROlMygcinDSnXaWL/9hbcVGTi901/Nhcq7LDVjsqW9Ad6zvWono
 JhGWcx9kExXsfAOOdzNRSrf4nFYVszuhkCN/H1BFN2IBw9gEMMx+BhI8Ex3nl9anwxim +A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ap4n96mxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Aug 2021 06:05:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17QA2lmi006480;
 Thu, 26 Aug 2021 10:05:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 3ajs48h4eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Aug 2021 10:05:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 17QA5btk29032944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Aug 2021 10:05:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA890AE08B;
 Thu, 26 Aug 2021 10:05:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 148A1AE07F;
 Thu, 26 Aug 2021 10:05:33 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.43.43.205])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 26 Aug 2021 10:05:32 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 2/5] powerpc/numa: convert printk to pr_xxx
Date: Thu, 26 Aug 2021 15:35:18 +0530
Message-Id: <20210826100521.412639-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826100521.412639-1-srikar@linux.vnet.ibm.com>
References: <20210826100521.412639-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Chn1dE0-JaL81oF0bPM-2ud3Y6M6u8rM
X-Proofpoint-GUID: Chn1dE0-JaL81oF0bPM-2ud3Y6M6u8rM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-26_02:2021-08-26,
 2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260061
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Valentin Schneider <valentin.schneider@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert the remaining printk to pr_xxx
One advantage would be all prints will now have prefix "numa:" from
pr_fmt().

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
[ convert printk(KERN_ERR) to pr_warn : Suggested by Laurent Dufour ]
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5e9b777a1151..9af38b1c618b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -154,8 +154,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
 	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
 		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
 	} else {
-		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
-		       cpu, node);
+		pr_warn("WARNING: cpu %lu not found in node %d\n", cpu, node);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU || CONFIG_PPC_SPLPAR */
@@ -326,8 +325,7 @@ static int __init find_min_common_depth(void)
 		depth = of_read_number(distance_ref_points, 1);
 	} else {
 		if (distance_ref_points_depth < 2) {
-			printk(KERN_WARNING "NUMA: "
-				"short ibm,associativity-reference-points\n");
+			pr_warn("short ibm,associativity-reference-points\n");
 			goto err;
 		}
 
@@ -339,7 +337,7 @@ static int __init find_min_common_depth(void)
 	 * MAX_DISTANCE_REF_POINTS domains.
 	 */
 	if (distance_ref_points_depth > MAX_DISTANCE_REF_POINTS) {
-		printk(KERN_WARNING "NUMA: distance array capped at "
+		pr_warn("distance array capped at "
 			"%d entries\n", MAX_DISTANCE_REF_POINTS);
 		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
 	}
@@ -701,7 +699,7 @@ static int __init parse_numa_properties(void)
 	unsigned long i;
 
 	if (numa_enabled == 0) {
-		printk(KERN_WARNING "NUMA disabled by user\n");
+		pr_warn("disabled by user\n");
 		return -1;
 	}
 
@@ -716,7 +714,7 @@ static int __init parse_numa_properties(void)
 		return min_common_depth;
 	}
 
-	pr_debug("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
+	pr_debug("associativity depth for CPU/Memory: %d\n", min_common_depth);
 
 	/*
 	 * Even though we connect cpus to numa domains later in SMP
@@ -808,10 +806,8 @@ static void __init setup_nonnuma(void)
 	unsigned int nid = 0;
 	int i;
 
-	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
-	       top_of_ram, total_ram);
-	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
-	       (top_of_ram - total_ram) >> 20);
+	pr_debug("Top of RAM: 0x%lx, Total RAM: 0x%lx\n", top_of_ram, total_ram);
+	pr_debug("Memory hole size: %ldMB\n", (top_of_ram - total_ram) >> 20);
 
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
 		fake_numa_create_new_node(end_pfn, &nid);
-- 
2.18.2

