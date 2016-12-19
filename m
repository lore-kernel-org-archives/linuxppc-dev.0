Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8c4411qzDwNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:28 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so19205092pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 01/10] powerpc/64s: add exception macro that does not enable RI
Date: Tue, 20 Dec 2016 04:30:02 +1000
Message-Id: <20161219183011.28310-2-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subsequent patches will add more non-RI variant exceptions, so
create a macro for it rather than open-code it.

This does not change generated instructions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 15 +++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S     | 17 ++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9a3eee661297..b261fb4658b4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -194,6 +194,21 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
+/* _NORI variant keeps MSR_RI clear */
+#define __EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
+	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
+	LOAD_HANDLER(r12,label)						\
+	mtspr	SPRN_##h##SRR0,r12;					\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	mtspr	SPRN_##h##SRR1,r10;					\
+	h##rfid;							\
+	b	.	/* prevent speculative execution */
+
+#define EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+	__EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)
+
 #define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d39d6118c6e9..ceff7d6c0518 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -268,20 +268,11 @@ machine_check_fwnmi:
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
 	/*
-	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
-	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
-	 * used, so nested machine check corrupts it. machine_check_common
-	 * enables MSR_RI.
+	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
+	 * nested machine check corrupts it. machine_check_common enables
+	 * MSR_RI.
 	 */
-	ld	r10,PACAKMSR(r13)
-	xori	r10,r10,MSR_RI
-	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r12, machine_check_common)
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.	/* prevent speculative execution */
+	EXCEPTION_PROLOG_PSERIES_1_NORI(machine_check_common, EXC_STD)
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
-- 
2.11.0
