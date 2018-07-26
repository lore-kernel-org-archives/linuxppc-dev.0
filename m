Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp42Bp6zF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 11/16] powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES to
 EXCEPTION_PROLOG
Date: Thu, 26 Jul 2018 23:07:12 +1000
Message-Id: <20180726130717.18761-12-mpe@ellerman.id.au>
In-Reply-To: <20180726130717.18761-1-mpe@ellerman.id.au>
References: <20180726130717.18761-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b1c445d73165..728532c5f585 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -177,9 +177,9 @@
 	__EXCEPTION_PROLOG_2_RELON(label, h)
 
 /*
- * As EXCEPTION_PROLOG_PSERIES(), except we've already got relocation on
- * so no need to rfid.  Save lr in case we're CONFIG_RELOCATABLE, in which
- * case EXCEPTION_PROLOG_2_RELON will be using LR.
+ * As EXCEPTION_PROLOG(), except we've already got relocation on so no need to
+ * rfid. Save LR in case we're CONFIG_RELOCATABLE, in which case
+ * EXCEPTION_PROLOG_2_RELON will be using LR.
  */
 #define EXCEPTION_RELON_PROLOG(area, label, h, extra, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
@@ -343,7 +343,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_2_NORI(label, h)				\
 	__EXCEPTION_PROLOG_2_NORI(label, h)
 
-#define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
+#define EXCEPTION_PROLOG(area, label, h, extra, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
@@ -553,8 +553,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
  * Exception vectors.
  */
 #define STD_EXCEPTION(vec, label)				\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
-				 EXC_STD, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_STD, KVMTEST_PR, vec);
 
 /* Version of above for when we have to branch out-of-line */
 #define __OOL_EXCEPTION(vec, label, hdlr)			\
@@ -567,8 +566,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
-				 EXC_HV, KVMTEST_HV, vec);
+	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec);
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-- 
2.14.1
