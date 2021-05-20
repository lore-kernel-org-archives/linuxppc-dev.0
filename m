Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C00C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 15:46:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF0161006
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 15:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF0161006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmDby3f4zz30BP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 01:46:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gG74zBdS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=gG74zBdS; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmDZw0bVRz2yyr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 01:45:11 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14KFY4Wq042959; Thu, 20 May 2021 11:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O3LTjLvnvpRfSr2gi+A2eHyNcMQBogw+nIGtw2ZpKv4=;
 b=gG74zBdSdkv3Nw0PxacbFEnIqE40Dl7xj29jbe0flk6Qy43PsiOzm1cCc5AKHDp/y6d2
 xFNP4vvVer6Y30IK8qkTSZiMCr7CYses2bewi9HzA83QPWj4fFIvV8lXQuoNRgSnHCrI
 F2N/dM14oyEkyWLxA/l0T/pDm3Q9Z6LzbbaXPkpoGWUBnaQ4kr2Z58J/usFun0F0bMCs
 7xNXFxBIwhj2vM/TdnwYHA3HNf3lLs/f3a06l0KbBw1gdWxBo/EFV937qgOZSTz9HO6N
 sZJoSFyjDfNLg2QtlJjpQB7vJtkO7BjWMXYWYRU1mc+/SkH4egMDVQX+dZwk/Jx01jiK bQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 38nsh32pjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 May 2021 11:44:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KFZijH001035;
 Thu, 20 May 2021 15:44:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 38j5jgtqe9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 May 2021 15:44:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 14KFigRN29884784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 15:44:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D846EA4057;
 Thu, 20 May 2021 15:44:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA4B6A405B;
 Thu, 20 May 2021 15:44:38 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.77.198.25])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 May 2021 15:44:38 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] sched/topology: Allow archs to populate distance map
Date: Thu, 20 May 2021 21:14:25 +0530
Message-Id: <20210520154427.1041031-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210520154427.1041031-1-srikar@linux.vnet.ibm.com>
References: <20210520154427.1041031-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uswc7z40ZiUMTjbxOD-lu-HFEtsc7t8U
X-Proofpoint-ORIG-GUID: uswc7z40ZiUMTjbxOD-lu-HFEtsc7t8U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-20_04:2021-05-20,
 2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=919 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200104
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
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Rik van Riel <riel@surriel.com>,
 linuxppc-dev@lists.ozlabs.org, Scott Cheloha <cheloha@linux.ibm.com>,
 Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Mel Gorman <mgorman@techsingularity.net>,
 Valentin Schneider <valentin.schneider@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently scheduler populates the distance map by looking at distance
of each node from all other nodes. This should work for most
architectures and platforms.

However there are some architectures like POWER that may not expose
the distance of nodes that are not yet onlined because those resources
are not yet allocated to the OS instance. Such architectures have
other means to provide valid distance data for the current platform.

For example distance info from numactl from a fully populated 8 node
system at boot may look like this.

node distances:
node   0   1   2   3   4   5   6   7
  0:  10  20  40  40  40  40  40  40
  1:  20  10  40  40  40  40  40  40
  2:  40  40  10  20  40  40  40  40
  3:  40  40  20  10  40  40  40  40
  4:  40  40  40  40  10  20  40  40
  5:  40  40  40  40  20  10  40  40
  6:  40  40  40  40  40  40  10  20
  7:  40  40  40  40  40  40  20  10

However the same system when only two nodes are online at boot, then the
numa topology will look like
node distances:
node   0   1
  0:  10  20
  1:  20  10

It may be implementation dependent on what node_distance(0,3) where
node 0 is online and node 3 is offline. In POWER case, it returns
LOCAL_DISTANCE(10). Here at boot the scheduler would assume that the max
distance between nodes is 20. However that would not be true.

When Nodes are onlined and CPUs from those nodes are hotplugged,
the max node distance would be 40.

To handle such scenarios, let scheduler allow architectures to populate
the distance map. Architectures that like to populate the distance map
can overload arch_populate_distance_map().

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Scott Cheloha <cheloha@linux.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Reported-by: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 053115b55f89..ccb9aff59add 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1630,6 +1630,26 @@ static void init_numa_topology_type(void)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+#ifndef arch_populate_distance_map
+static int arch_populate_distance_map(unsigned long *distance_map)
+{
+	int i, j;
+
+	for (i = 0; i < nr_node_ids; i++) {
+		for (j = 0; j < nr_node_ids; j++) {
+			int distance = node_distance(i, j);
+
+			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
+				sched_numa_warn("Invalid distance value range");
+				return -1;
+			}
+			bitmap_set(distance_map, distance, 1);
+		}
+	}
+	return 0;
+}
+#endif
+
 void sched_init_numa(void)
 {
 	struct sched_domain_topology_level *tl;
@@ -1646,18 +1666,10 @@ void sched_init_numa(void)
 		return;
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
-	for (i = 0; i < nr_node_ids; i++) {
-		for (j = 0; j < nr_node_ids; j++) {
-			int distance = node_distance(i, j);
 
-			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
-				sched_numa_warn("Invalid distance value range");
-				return;
-			}
+	if (arch_populate_distance_map(distance_map))
+		return;
 
-			bitmap_set(distance_map, distance, 1);
-		}
-	}
 	/*
 	 * We can now figure out how many unique distance values there are and
 	 * allocate memory accordingly.
-- 
2.27.0

