Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsnv1vLSzF0fW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 03/16] powerpc/64s: Rename STD_EXCEPTION_PSERIES to
 STD_EXCEPTION
Date: Thu, 26 Jul 2018 23:07:04 +1000
Message-Id: <20180726130717.18761-4-mpe@ellerman.id.au>
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

The "PSERIES" in STD_EXCEPTION_PSERIES is to differentiate the macros
from the legacy iSeries versions, which are called
STD_EXCEPTION_ISERIES. It is not anything to do with pseries vs
powernv or powermac etc.

We removed the legacy iSeries code in 2012, in commit 8ee3e0d69623x
("powerpc: Remove the main legacy iSerie platform code").

So remove "PSERIES" from the macros.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 arch/powerpc/include/asm/head-64.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a3027ef75500..9aeafb4d4ff7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -552,7 +552,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(vec, label)			\
+#define STD_EXCEPTION(vec, label)				\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
 				 EXC_STD, KVMTEST_PR, vec);	\
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 7e0e93f24cb7..66ea28dc21dd 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -260,7 +260,7 @@ end_##sname:
 
 #define EXC_REAL(name, start, size)					\
 	EXC_REAL_BEGIN(name, start, size);				\
-	STD_EXCEPTION_PSERIES(start, name##_common);			\
+	STD_EXCEPTION(start, name##_common);				\
 	EXC_REAL_END(name, start, size);
 
 #define EXC_VIRT(name, start, size, realvec)				\
-- 
2.14.1
