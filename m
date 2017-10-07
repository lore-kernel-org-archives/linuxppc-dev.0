Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rd710HzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:45 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rd67bkz8vDD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:45 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rd1tsCz9t73
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:45 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OZEk020323
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dek7t59y7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:42 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/18] powerpc/vas: Create cpu to vas id mapping
Date: Fri,  6 Oct 2017 19:28:09 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-10-git-send-email-sukadev@linux.vnet.ibm.com>
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
