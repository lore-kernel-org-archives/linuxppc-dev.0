Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsnt6G49zDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 02/16] powerpc/64s: Move SET_SCRATCH0() into
 EXCEPTION_RELON_PROLOG_PSERIES()
Date: Thu, 26 Jul 2018 23:07:03 +1000
Message-Id: <20180726130717.18761-3-mpe@ellerman.id.au>
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

EXCEPTION_RELON_PROLOG_PSERIES() only has two users,
STD_RELON_EXCEPTION_PSERIES() and STD_RELON_EXCEPTION_HV() both of
which "call" SET_SCRATCH0(), so just move SET_SCRATCH0() into
EXCEPTION_RELON_PROLOG_PSERIES().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index d6932990be15..a3027ef75500 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -182,6 +182,7 @@
  * case EXCEPTION_RELON_PROLOG_PSERIES_1 will be using lr.
  */
 #define EXCEPTION_RELON_PROLOG_PSERIES(area, label, h, extra, vec)	\
+	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
@@ -575,7 +576,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
 	/* No guest interrupts come through here */	\
-	SET_SCRATCH0(r13);		/* save r13 */	\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
 
 #define STD_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
@@ -583,7 +583,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	SET_SCRATCH0(r13);	/* save r13 */		\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label,	\
 				       EXC_HV, KVMTEST_HV, vec);
 
-- 
2.14.1
