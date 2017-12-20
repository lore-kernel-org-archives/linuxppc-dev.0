Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gv63vGFzF08j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sUA4168162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:48 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eybntakrs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:48 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:46 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 11/17] powerpc/64s: Avoid using EXCEPTION_PROLOG_1 macro
 in MASKABLE_*
Date: Wed, 20 Dec 2017 09:25:51 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we use both EXCEPTION_PROLOG_1 and __EXCEPTION_PROLOG_1 in
the MASKABLE_* macros. As a cleanup, this patch makes MASKABLE_* to
use only __EXCEPTION_PROLOG_1. There is not logic change.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index f9a9269df62e..b6dc05c944c5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -536,7 +536,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_STD, SOFTEN_TEST_PR)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
@@ -544,7 +544,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
@@ -565,7 +565,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
-- 
2.7.4
