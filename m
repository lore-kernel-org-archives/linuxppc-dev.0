Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mTpG1cmZzDrZC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 23:37:41 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79DTsjr082966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 09:37:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krmxsvvg4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 09:37:39 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 9 Aug 2018 09:37:39 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/powernv/idle: Fix build error
Date: Thu,  9 Aug 2018 19:07:20 +0530
Message-Id: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the below build error using strlcpy instead of strncpy

In function 'pnv_parse_cpuidle_dt',
    inlined from 'pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:840:7,
    inlined from '__machine_initcall_powernv_pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:870:1:
arch/powerpc/platforms/powernv/idle.c:820:3: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
   strncpy(pnv_idle_states[i].name, temp_string[i],
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PNV_IDLE_NAME_LEN);

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index ecb002c5db83..35f699ebb662 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -817,7 +817,7 @@ static int pnv_parse_cpuidle_dt(void)
 		goto out;
 	}
 	for (i = 0; i < nr_idle_states; i++)
-		strncpy(pnv_idle_states[i].name, temp_string[i],
+		strlcpy(pnv_idle_states[i].name, temp_string[i],
 			PNV_IDLE_NAME_LEN);
 	nr_pnv_idle_states = nr_idle_states;
 	rc = 0;
-- 
2.17.1
