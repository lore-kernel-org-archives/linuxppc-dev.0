Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhVzK1FcwzDr28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 16:15:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAM5E7Ww073776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:15:54 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ed0secuv3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:15:53 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 05:15:51 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, anju@linux.vnet.ibm.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/perf: Fix pmu_count to count only nest imc pmus
Date: Wed, 22 Nov 2017 10:45:38 +0530
Message-Id: <1511327739-21688-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"pmu_count" in opal_imc_counters_probe() is intended to hold
the number of successful nest imc pmu registerations. But
current code also counts other imc units like core_imc and
thread_imc. Patch add a check to count only nest imc pmus.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 21f6531fae20..b150f4deaccf 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -191,8 +191,10 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 			break;
 		}
 
-		if (!imc_pmu_create(imc_dev, pmu_count, domain))
-			pmu_count++;
+		if (!imc_pmu_create(imc_dev, pmu_count, domain)) {
+			if (domain == IMC_DOMAIN_NEST)
+				pmu_count++;
+		}
 	}
 
 	return 0;
-- 
2.7.4
