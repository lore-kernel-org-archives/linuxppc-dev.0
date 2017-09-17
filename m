Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwY03tYLzDrnj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwY01vHHz8vmk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXy4Ldrz9t2f
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:53 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44OIt094574
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:51 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d103t6cft-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:50 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] powerpc/vas: Create cpu to vas id mapping
Date: Sat, 16 Sep 2017 21:05:27 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a cpu to vasid mapping so callers can specify -1 instead of
trying to find a VAS id.

Changelog[v2]
	[Michael Ellerman] Use per-cpu variables to simplify code.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index 565a487..abb7090 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -18,15 +18,18 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <asm/prom.h>
 
 #include "vas.h"
 
 static DEFINE_MUTEX(vas_mutex);
 static LIST_HEAD(vas_instances);
 
+static DEFINE_PER_CPU(int, cpu_vas_id);
+
 static int init_vas_instance(struct platform_device *pdev)
 {
-	int rc, vasid;
+	int rc, cpu, vasid;
 	struct resource *res;
 	struct vas_instance *vinst;
 	struct device_node *dn = pdev->dev.of_node;
@@ -74,6 +77,11 @@ static int init_vas_instance(struct platform_device *pdev)
 			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
 			vinst->paste_base_addr, vinst->paste_win_id_shift);
 
+	for_each_possible_cpu(cpu) {
+		if (cpu_to_chip_id(cpu) == of_get_ibm_chip_id(dn))
+			per_cpu(cpu_vas_id, cpu) = vasid;
+	}
+
 	mutex_lock(&vas_mutex);
 	list_add(&vinst->node, &vas_instances);
 	mutex_unlock(&vas_mutex);
@@ -98,6 +106,10 @@ struct vas_instance *find_vas_instance(int vasid)
 	struct vas_instance *vinst;
 
 	mutex_lock(&vas_mutex);
+
+	if (vasid == -1)
+		vasid = per_cpu(cpu_vas_id, smp_processor_id());
+
 	list_for_each(ent, &vas_instances) {
 		vinst = list_entry(ent, struct vas_instance, node);
 		if (vinst->vas_id == vasid) {
-- 
2.7.4
