Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsny5KvmzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 06/16] powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES_OOL to
 STD_RELON_EXCEPTION_OOL
Date: Thu, 26 Jul 2018 23:07:07 +1000
Message-Id: <20180726130717.18761-7-mpe@ellerman.id.au>
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
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 arch/powerpc/include/asm/head-64.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 5a86173c56b9..1754b0cc0c2f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -578,7 +578,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	/* No guest interrupts come through here */	\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
 
-#define STD_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
+#define STD_RELON_EXCEPTION_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index cf0e1ac1149a..640d354a3ab3 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -346,7 +346,7 @@ end_##sname:
 
 #define __TRAMP_VIRT_OOL(name, realvec)					\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
+	STD_RELON_EXCEPTION_OOL(realvec, name##_common);
 
 #define EXC_VIRT_OOL(name, start, size, realvec)			\
 	__EXC_VIRT_OOL(name, start, size);				\
-- 
2.14.1
