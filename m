Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 284AD2C00A4
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 16:26:30 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 10:56:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id ABADD1258044
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 10:58:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2B5QFth10748376
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 10:56:15 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2B5QInm001808
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 10:56:18 +0530
Subject: [PATCH] powerpc/book3s: Fix CFAR clobbering issue in machine check
 handler.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Mar 2014 10:56:18 +0530
Message-ID: <20140311052558.941.49346.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

While checking powersaving mode in machine check handler at 0x200, we
clobber CFAR register. Fix it by saving and restoring it during beq/bgt.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |    8 ++++++++
 arch/powerpc/kernel/exceptions-64s.S     |    5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 6683061..aeaa56c 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -147,6 +147,14 @@ BEGIN_FTR_SECTION_NESTED(943)						\
 END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 /*
+ * Set an SPR from a register if the CPU has the given feature
+ */
+#define OPT_SET_SPR(ra, spr, ftr)					\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	mtspr	spr,ra;							\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
+
+/*
  * Save a register to the PACA if the CPU has the given feature
  */
 #define OPT_SAVE_REG_TO_PACA(offset, ra, ftr)				\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 38d5073..4c34c3c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -164,13 +164,18 @@ BEGIN_FTR_SECTION
 	 */
 	mfspr	r13,SPRN_SRR1
 	rlwinm.	r13,r13,47-31,30,31
+	OPT_GET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
 	beq	9f
 
+	mfspr	r13,SPRN_SRR1
+	rlwinm.	r13,r13,47-31,30,31
 	/* waking up from powersave (nap) state */
 	cmpwi	cr1,r13,2
 	/* Total loss of HV state is fatal. let's just stay stuck here */
+	OPT_GET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
 	bgt	cr1,.
 9:
+	OPT_SET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
