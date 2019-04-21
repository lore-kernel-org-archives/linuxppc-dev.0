Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090CC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:23:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F20E2077C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F20E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nFQ35GcXzDq6J
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:23:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBkb3SH7zDqMw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:22:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBkZ1s9cz9sBZ; Mon, 22 Apr 2019 00:22:46 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBkY4JY1z9sMQ; Mon, 22 Apr 2019 00:22:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 49/52] powerpc/fsl: Flush the branch predictor at
 each kernel entry (64bit)
Date: Mon, 22 Apr 2019 00:20:34 +1000
Message-Id: <20190421142037.21881-50-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Diana Craciun <diana.craciun@nxp.com>

commit 10c5e83afd4a3f01712d97d3bb1ae34d5b74a185 upstream.

In order to protect against speculation attacks on
indirect branches, the branch predictor is flushed at
kernel entry to protect for the following situations:
- userspace process attacking another userspace process
- userspace process attacking the kernel
Basically when the privillege level change (i.e. the
kernel is entered), the branch predictor state is flushed.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S       |  5 +++++
 arch/powerpc/kernel/exceptions-64e.S | 26 +++++++++++++++++++++++++-
 arch/powerpc/mm/tlb_low_64e.S        |  7 +++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 698bb51f5399..6d36a4fb4acf 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -77,6 +77,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	beq	2f			/* if from kernel mode */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	BTB_FLUSH(r10)
+END_BTB_FLUSH_SECTION
+#endif
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
 2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 5cc93f0b52ca..b6d28b1e316c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -295,7 +295,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
 	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
-1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
+1:	type##_BTB_FLUSH		\
+	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
 	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
 	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
 
@@ -327,6 +328,29 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define GEN_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		beq 1f;			\
+		BTB_FLUSH(r10)			\
+		1:		\
+	END_BTB_FLUSH_SECTION
+
+#define CRIT_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		BTB_FLUSH(r10)		\
+	END_BTB_FLUSH_SECTION
+
+#define DBG_BTB_FLUSH CRIT_BTB_FLUSH
+#define MC_BTB_FLUSH CRIT_BTB_FLUSH
+#define GDBELL_BTB_FLUSH GEN_BTB_FLUSH
+#else
+#define GEN_BTB_FLUSH
+#define CRIT_BTB_FLUSH
+#define DBG_BTB_FLUSH
+#define GDBELL_BTB_FLUSH
+#endif
+
 #define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			    \
 	EXCEPTION_PROLOG(n, intnum, GEN, addition##_GEN(n))
 
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 29d6987c37ba..5486d56da289 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -69,6 +69,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	std	r15,EX_TLB_R15(r12)
 	std	r10,EX_TLB_CR(r12)
 #ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
 	std	r7,EX_TLB_R7(r12)
 #endif
 	TLB_MISS_PROLOG_STATS
-- 
2.20.1

