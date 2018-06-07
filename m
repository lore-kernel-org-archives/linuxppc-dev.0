Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBC2Bc7zF34H
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:55 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FOKI1121440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jf4n5hfpj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:51 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 11:25:50 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPkqq17170766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 15:25:46 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E552AE064
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:26:02 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517A0AE05C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:26:02 -0400 (EDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:26:02 -0400 (EDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 5/5] powerpc: Add PMU regset to compat_regsets
Date: Thu,  7 Jun 2018 12:25:34 -0300
In-Reply-To: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
Message-Id: <20180607152534.29427-6-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch allows setting and getting PMU registers from 32-bit
threads.
---
 arch/powerpc/kernel/ptrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2da0668a96dc..3a9c4ae65429 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2317,6 +2317,11 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = ebb_active, .get = ebb_get, .set = ebb_set
 	},
+	[REGSET_PMR] = {
+		.core_note_type = NT_PPC_PMU, .n = ELF_NPMU,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = pmu_active, .get = pmu_get, .set = pmu_set
+	},
 #endif
 };
 
-- 
2.13.6
