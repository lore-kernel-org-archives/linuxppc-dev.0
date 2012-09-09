Return-Path: <haren@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3C1E2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 21:43:27 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 05:43:25 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 44D6D1FF003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 05:43:21 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q89BhN5g270414
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 05:43:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q89BhMvm011661
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 05:43:23 -0600
Subject: [PATCH 5/6] powerpc: Macros for saving/restore PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Sep 2012 04:43:21 -0700
Message-ID: <1347191001.3418.19.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Several macros are defined for saving and restore user defined PPR value.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |   35 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg.h           |    1 +
 2 files changed, 36 insertions(+)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index bfd3f1f..618fd18 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -62,6 +62,41 @@
 #define EXC_HV	H
 #define EXC_STD
 
+/*
+ * PPR save/restore macros - Used on P7 or later processors
+ */
+#define SAVE_PPR(area, ra, rb)						\
+BEGIN_FTR_SECTION_NESTED(940)						\
+	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
+	clrrdi	rb,r1,THREAD_SHIFT;	/* thread_info struct */	\
+	std	ra,TI_PPR(rb);		/* Save PPR in thread_info */	\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
+
+#define RESTORE_PPR(ra,rb)						\
+BEGIN_FTR_SECTION_NESTED(941)						\
+	clrrdi	ra,r1,THREAD_SHIFT;					\
+	ld	rb,TI_PPR(ra);		/* Read PPR from thread_info */	\
+	mtspr	SPRN_PPR,rb;		/* Restore PPR */		\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
+
+#define RESTORE_PPR_PACA(area,ra)					\
+BEGIN_FTR_SECTION_NESTED(942)						\
+	ld	ra,area+EX_PPR(r13);					\
+	mtspr	SPRN_PPR,ra;						\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,942)
+
+#define HMT_MEDIUM_NO_PPR						\
+BEGIN_FTR_SECTION_NESTED(944)						\
+	HMT_MEDIUM;							\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,944)  /*non P7*/		
+
+#define HMT_MEDIUM_HAS_PPR(area, ra)					\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	mfspr	ra,SPRN_PPR;						\
+	std	ra,area+EX_PPR(r13);					\
+	HMT_MEDIUM;							\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
+
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6386086..dff2f89 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -284,6 +284,7 @@
 #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
 #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
+#define SPRN_PPR	0x380	/* SMT Thread status Register */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Regsiter */
-- 
1.7.10.4
