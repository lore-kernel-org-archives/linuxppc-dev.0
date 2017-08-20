Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4Mw3Q04zDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx2nU106315
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:39 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cehdyg109-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:38 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHxYho34603190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHxPjF009944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:25 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 09/14] powerpc: Avoid using EXCEPTION_PROLOG_1 macro in
 MASKABLE_*
Date: Sun, 20 Aug 2017 23:28:26 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-10-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we use both EXCEPTION_PROLOG_1 and __EXCEPTION_PROLOG_1
in the MASKABLE_* macros. As a cleanup, this patch makes MASKABLE_*
to use only __EXCEPTION_PROLOG_1. There is not logic change.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index ad7340ce5c15..8750c7fb72d3 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -531,7 +531,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_STD, SOFTEN_TEST_PR)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
@@ -539,7 +539,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
@@ -560,7 +560,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
-- 
2.7.4
