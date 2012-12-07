Return-Path: <haren@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00E0B2C00EC
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 18:50:40 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 02:50:38 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4A4D338C803B
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 02:50:35 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB77oYZC322986
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 02:50:34 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB77oYfI016538
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 02:50:34 -0500
Subject: [PATCH 5/6] powerpc: Macros for saving/restore PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Dec 2012 23:50:32 -0800
Message-ID: <1354866632.1281.18.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 5/6] powerpc: Macros for saving/restore PPR

Several macros are defined for saving and restore user defined PPR value.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |   37 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h       |   25 ++++++++++++++++++++
 arch/powerpc/include/asm/reg.h           |    1 +
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b24ca9..090fcd1 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -108,6 +108,43 @@
 #define RESTORE_LR(reg, area)
 #endif
 
+/*
+ * PPR save/restore macros used in exceptions_64s.S  
+ * Used for P7 or later processors
+ */
+#define SAVE_PPR(area, ra, rb)						\
+BEGIN_FTR_SECTION_NESTED(940)						\
+	ld	ra,PACACURRENT(r13);					\
+	ld	rb,area+EX_PPR(r13);	/* Read PPR from paca */	\
+	std	rb,TASKTHREADPPR(ra);					\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
+
+#define RESTORE_PPR_PACA(area, ra)					\
+BEGIN_FTR_SECTION_NESTED(941)						\
+	ld	ra,area+EX_PPR(r13);					\
+	mtspr	SPRN_PPR,ra;						\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
+
+/*
+ * Increase the priority on systems where PPR save/restore is not
+ * implemented/ supported.
+ */
+#define HMT_MEDIUM_PPR_DISCARD						\
+BEGIN_FTR_SECTION_NESTED(942)						\
+	HMT_MEDIUM;							\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,942)  /*non P7*/		
+
+/*
+ * Save PPR in paca whenever some register is available to use.
+ * Then increase the priority.
+ */
+#define HMT_MEDIUM_PPR_SAVE(area, ra)					\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	mfspr	ra,SPRN_PPR;						\
+	std	ra,area+EX_PPR(r13);					\
+	HMT_MEDIUM;							\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) 
+
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 376e36d..c2d0e58 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -389,6 +389,31 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	FTR_SECTION_ELSE_NESTED(848);	\
 	mtocrf (FXM), RS;		\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
+
+/*
+ * PPR restore macros used in entry_64.S
+ * Used for P7 or later processors
+ */
+#define HMT_MEDIUM_LOW_HAS_PPR						\
+BEGIN_FTR_SECTION_NESTED(944)						\
+	HMT_MEDIUM_LOW;							\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,944)
+
+#define SET_DEFAULT_THREAD_PPR(ra, rb)					\
+BEGIN_FTR_SECTION_NESTED(945)						\
+	lis	ra,INIT_PPR@highest;	/* default ppr=3 */		\
+	ld	rb,PACACURRENT(r13);					\
+	sldi	ra,ra,32;	/* 11- 13 bits are used for ppr */	\
+	std	ra,TASKTHREADPPR(rb);					\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
+
+#define RESTORE_PPR(ra, rb)						\
+BEGIN_FTR_SECTION_NESTED(946)						\
+	ld	ra,PACACURRENT(r13);					\
+	ld	rb,TASKTHREADPPR(ra);					\
+	mtspr	SPRN_PPR,rb;	/* Restore PPR */			\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
+
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1b853f7..d395426 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -289,6 +289,7 @@
 #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
 #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
+#define SPRN_PPR	0x380	/* SMT Thread status Register */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Regsiter */
-- 
1.7.1
