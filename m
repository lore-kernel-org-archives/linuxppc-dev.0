Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C16C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:34:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9982089A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9982089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P3DY09fmzF38y
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:34:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P2qx0rF4zF37B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 23:17:00 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91DAcS0105476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 09:16:59 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mukgejf57-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 09:16:58 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 1 Oct 2018 09:16:57 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 09:16:53 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91DGqDH31260764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 13:16:52 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485BAAE05F;
 Mon,  1 Oct 2018 09:15:12 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5292AE063;
 Mon,  1 Oct 2018 09:15:11 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.106])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 09:15:11 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id BE4E32E4140; Mon,  1 Oct 2018 18:46:49 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH v9 2/3] powerpc: Use cpu_smallcore_sibling_mask at SMT level
 on bigcores
Date: Mon,  1 Oct 2018 18:46:41 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100113-0064-0000-0000-000003581FDE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009802; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096315; UDB=6.00566874; IPR=6.00876357; 
 MB=3.00023575; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 13:16:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100113-0065-0000-0000-00003AD52B58
Message-Id: <1538399802-23582-3-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010131
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

POWER9 SMT8 cores consist of two groups of threads, where threads in
each group shares L1-cache. The scheduler is not aware of this
distinction as the current sched-domain hierarchy has all the threads
of the core defined at the SMT domain.

	SMT  [Thread siblings of the SMT8 core]
	DIE  [CPUs in the same die]
	NUMA [All the CPUs in the system]

Due to this, we can observe run-to-run variance when we run a
multi-threaded benchmark bound to a single core based on how the
scheduler spreads the software threads across the two groups in the
core.

We fix this in this patch by defining each group of threads which
share L1-cache to be the SMT level. The group of threads in the SMT8
core is defined to be the CACHE level. The sched-domain hierarchy
after this patch will be :

	SMT	[Thread siblings in the core that share L1 cache]
	CACHE 	[Thread siblings that are in the SMT8 core]
	DIE  	[CPUs in the same die]
	NUMA 	[All the CPUs in the system]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 22a14a9..356751e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1266,6 +1266,7 @@ static void add_cpu_to_masks(int cpu)
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
+	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
@@ -1291,11 +1292,13 @@ void start_secondary(void *unused)
 	/* Update topology CPU masks */
 	add_cpu_to_masks(cpu);
 
+	if (has_big_cores)
+		sibling_mask = cpu_smallcore_mask;
 	/*
 	 * Check for any shared caches. Note that this must be done on a
 	 * per-core basis because one core in the pair might be disabled.
 	 */
-	if (!cpumask_equal(cpu_l2_cache_mask(cpu), cpu_sibling_mask(cpu)))
+	if (!cpumask_equal(cpu_l2_cache_mask(cpu), sibling_mask(cpu)))
 		shared_caches = true;
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
@@ -1362,6 +1365,13 @@ static const struct cpumask *shared_cache_mask(int cpu)
 	return cpu_l2_cache_mask(cpu);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static const struct cpumask *smallcore_smt_mask(int cpu)
+{
+	return cpu_smallcore_mask(cpu);
+}
+#endif
+
 static struct sched_domain_topology_level power9_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
@@ -1389,6 +1399,13 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	shared_proc_topology_init();
 	dump_numa_cpu_topology();
 
+#ifdef CONFIG_SCHED_SMT
+	if (has_big_cores) {
+		pr_info("Using small cores at SMT level\n");
+		power9_topology[0].mask = smallcore_smt_mask;
+		powerpc_topology[0].mask = smallcore_smt_mask;
+	}
+#endif
 	/*
 	 * If any CPU detects that it's sharing a cache with another CPU then
 	 * use the deeper topology that is aware of this sharing.
-- 
1.9.4

