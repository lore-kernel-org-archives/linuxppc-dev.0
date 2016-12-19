Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtnW68vwzDwK1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:43 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ83e25134498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:41 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27e96md89n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:41 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 18:07:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 07AFB2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:36 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJ87ZH547775768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:35 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJ87ZM6028010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:35 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 06/12] powerpc: Avoid using EXCEPTION_PROLOG_1 macro in
 MASKABLE_*
Date: Mon, 19 Dec 2016 13:37:02 +0530
In-Reply-To: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1482134828-18811-7-git-send-email-maddy@linux.vnet.ibm.com>
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
index 27d75ec63b34..2a7be641ef44 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -449,7 +449,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_STD, SOFTEN_TEST_PR)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
@@ -457,7 +457,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
@@ -478,7 +478,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_HV, SOFTEN_NOTEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
-- 
2.7.4
