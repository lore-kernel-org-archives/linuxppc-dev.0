Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHdjl4jBMzDvhM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:05:47 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEI5YDq140580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:45 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qfda9w5j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:40 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 23:35:14 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 00B481258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:36:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEI5BX927459820
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEI59PO011234
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:11 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 06/11] powerpc: Avoid using EXCEPTION_PROLOG_1 macro in
 MASKABLE_*
Date: Mon, 14 Nov 2016 23:34:47 +0530
In-Reply-To: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1479146692-15726-7-git-send-email-maddy@linux.vnet.ibm.com>
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
index 53ba672fe9dc..bcd5a7f7dafe 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -440,7 +440,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_STD, SOFTEN_TEST_PR)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
@@ -448,7 +448,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
@@ -469,7 +469,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_HV, SOFTEN_NOTEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
-- 
2.7.4
