Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZ7V00KkzDrdS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:31:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6SMFF061609
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:31:00 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 251b8rcf8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:59 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:00:56 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3CB87394006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6Ue1O20840484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:40 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6UbHW031648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:40 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 07/12] powerpc: Add new _EXCEPTION_PROLOG_1 macro
Date: Thu, 25 Aug 2016 11:59:58 +0530
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472106603-23336-8-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out the EXCPETION_PROLOG_1 macro, so that STD_EXCEPTION_*
and MASKABLE_EXCEPTION will have separate version. This is needed
to support addition of new parameter "bitmask" for MASKABLE_* macros
to specify the interrupt mask.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 75e262466b85..dd3253bd0d8e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -161,18 +161,40 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
 
-#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+#define __EXCEPTION_PROLOG_1_PRE(area)					\
 	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	SAVE_CTR(r10, area);						\
-	mfcr	r9;							\
-	extra(vec);							\
+	mfcr	r9;
+
+#define __EXCEPTION_PROLOG_1_POST(area)					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
 	GET_SCRATCH0(r10);						\
 	std	r10,area+EX_R13(r13)
+
+/*
+ * This version of the EXCEPTION_PROLOG_1 will carry
+ * addition parameter called "bitmask" to support
+ * checking of the interrupt maskable level in the SOFTEN_TEST.
+ * Intended to be used in MASKABLE_EXCPETION_* macros.
+ */
+#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+	__EXCEPTION_PROLOG_1_PRE(area);					\
+	extra(vec);							\
+	__EXCEPTION_PROLOG_1_POST(area);
+
+/*
+ * This version of the EXCEPTION_PROLOG_1 is intended
+ * to be used in STD_EXCEPTION* macros
+ */
+#define _EXCEPTION_PROLOG_1(area, extra, vec)				\
+	__EXCEPTION_PROLOG_1_PRE(area);					\
+	extra(vec);							\
+	__EXCEPTION_PROLOG_1_POST(area);
+
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
-	__EXCEPTION_PROLOG_1(area, extra, vec)
+	_EXCEPTION_PROLOG_1(area, extra, vec)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
-- 
2.7.4
