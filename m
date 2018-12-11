Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB3C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:07:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D792084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D792084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DvFj05kxzDqR3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dv964fk0zDqkR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 09:03:54 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBBM3YqK032804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:03:52 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pampf2pdv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:03:52 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 11 Dec 2018 22:03:51 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Dec 2018 22:03:48 -0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBBM3j6C19333276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 22:03:45 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90193136053;
 Tue, 11 Dec 2018 22:03:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75C6B136055;
 Tue, 11 Dec 2018 22:03:45 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Dec 2018 22:03:45 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 1B4E9489EFAB;
 Tue, 11 Dec 2018 16:03:45 -0600 (CST)
Subject: [RFC 1/3] powerpc/numa: Conditionally online new nodes
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 11 Dec 2018 16:03:45 -0600
In-Reply-To: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121122-0036-0000-0000-00000A69161D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130389; UDB=6.00587377; IPR=6.00910522; 
 MB=3.00024658; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 22:03:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121122-0037-0000-0000-000049F0F865
Message-Id: <20181211220336.87502.24778.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-11_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110194
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
Cc: Rob Herring <robh@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 tlfalcon@linux.vnet.ibm.com, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidyan@in.ibm.com>, mwb@linux.vnet.ibm.com,
 minkim@us.ibm.com, Paul Mackerras <paulus@samba.org>,
 tyreld@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Corentin Labbe <clabbe@baylibre.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add argument to allow caller to determine whether the node identified
for a cpu after an associativity / affinity change should be inited.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h          |    2 +-
 arch/powerpc/mm/numa.c                       |    6 +++---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index a4a718d..4621f40 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -90,7 +90,7 @@ static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
 extern int start_topology_update(void);
 extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
-extern int find_and_online_cpu_nid(int cpu);
+extern int find_and_online_cpu_nid(int cpu, bool must_online);
 extern int timed_topology_update(int nsecs);
 extern void __init shared_proc_topology_init(void);
 #else
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 87f0dd0..7d6bba264 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1197,7 +1197,7 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
-int find_and_online_cpu_nid(int cpu)
+int find_and_online_cpu_nid(int cpu, bool must_online)
 {
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	int new_nid;
@@ -1210,7 +1210,7 @@ int find_and_online_cpu_nid(int cpu)
 	if (new_nid < 0 || !node_possible(new_nid))
 		new_nid = first_online_node;
 
-	if (NODE_DATA(new_nid) == NULL) {
+	if (must_online && (NODE_DATA(new_nid) == NULL)) {
 #ifdef CONFIG_MEMORY_HOTPLUG
 		/*
 		 * Need to ensure that NODE_DATA is initialized for a node from
@@ -1337,7 +1337,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 			continue;
 		}
 
-		new_nid = find_and_online_cpu_nid(cpu);
+		new_nid = find_and_online_cpu_nid(cpu, true);
 
 		if (new_nid == numa_cpu_lookup_table[cpu]) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 2f8e621..620cb57 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -366,7 +366,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
 			timed_topology_update(1);
-			find_and_online_cpu_nid(cpu);
+			find_and_online_cpu_nid(cpu, true);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;

