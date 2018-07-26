Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsnx6S2ZzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 05/16] powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES to
 STD_RELON_EXCEPTION
Date: Thu, 26 Jul 2018 23:07:06 +1000
Message-Id: <20180726130717.18761-6-mpe@ellerman.id.au>
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
index db8989d4dffb..5a86173c56b9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -574,7 +574,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
-#define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
+#define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 3e955889f615..cf0e1ac1149a 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -265,7 +265,7 @@ end_##sname:
 
 #define EXC_VIRT(name, start, size, realvec)				\
 	EXC_VIRT_BEGIN(name, start, size);				\
-	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
+	STD_RELON_EXCEPTION(start, realvec, name##_common);		\
 	EXC_VIRT_END(name, start, size);
 
 #define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
-- 
2.14.1
