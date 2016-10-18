Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sypjq3vC5zDt0V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 19:52:31 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9I8n1WC036598
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:52:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 265ffj2ynm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:52:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Oct 2016 02:52:28 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix numa topology console print
Date: Tue, 18 Oct 2016 14:22:14 +0530
Message-Id: <20161018085214.20428-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With recent update to printk, we get console output like below

[    0.550639] Brought up 160 CPUs
[    0.550718] Node 0 CPUs:
[    0.550721]  0
[    0.550754] -39

[    0.550794] Node 1 CPUs:
[    0.550798]  40
[    0.550817] -79

[    0.550856] Node 16 CPUs:
[    0.550860]  80
[    0.550880] -119

[    0.550917] Node 17 CPUs:
[    0.550923]  120
[    0.550942] -159

Fix this by using proper printk args

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 75b9cd6150cc..c8fd54ec40e4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -845,7 +845,7 @@ void __init dump_numa_cpu_topology(void)
 		return;
 
 	for_each_online_node(node) {
-		printk(KERN_DEBUG "Node %d CPUs:", node);
+		pr_info("Node %d CPUs:", node);
 
 		count = 0;
 		/*
@@ -856,18 +856,18 @@ void __init dump_numa_cpu_topology(void)
 			if (cpumask_test_cpu(cpu,
 					node_to_cpumask_map[node])) {
 				if (count == 0)
-					printk(" %u", cpu);
+					pr_cont(" %u", cpu);
 				++count;
 			} else {
 				if (count > 1)
-					printk("-%u", cpu - 1);
+					pr_cont("-%u", cpu - 1);
 				count = 0;
 			}
 		}
 
 		if (count > 1)
-			printk("-%u", nr_cpu_ids - 1);
-		printk("\n");
+			pr_cont("-%u", nr_cpu_ids - 1);
+		pr_cont("\n");
 	}
 }
 
@@ -882,7 +882,7 @@ static void __init dump_numa_memory_topology(void)
 	for_each_online_node(node) {
 		unsigned long i;
 
-		printk(KERN_DEBUG "Node %d Memory:", node);
+		pr_info("Node %d Memory:", node);
 
 		count = 0;
 
@@ -890,18 +890,18 @@ static void __init dump_numa_memory_topology(void)
 		     i += (1 << SECTION_SIZE_BITS)) {
 			if (early_pfn_to_nid(i >> PAGE_SHIFT) == node) {
 				if (count == 0)
-					printk(" 0x%lx", i);
+					pr_cont(" 0x%lx", i);
 				++count;
 			} else {
 				if (count > 0)
-					printk("-0x%lx", i);
+					pr_cont("-0x%lx", i);
 				count = 0;
 			}
 		}
 
 		if (count > 0)
-			printk("-0x%lx", i);
-		printk("\n");
+			pr_cont("-0x%lx", i);
+		pr_cont("\n");
 	}
 }
 
-- 
2.10.1
