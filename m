Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8509DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 12:27:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067D4206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 12:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D4206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W1Fg56lTzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 23:27:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VzwW3KRfzDqSH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 22:27:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44VzwV6nhhz9sSD; Fri, 29 Mar 2019 22:27:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44VzwV4HQJz9sTQ; Fri, 29 Mar 2019 22:27:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.14 30/32] powerpc/fsl: Fixed warning: orphan section
 `__btb_flush_fixup'
Date: Fri, 29 Mar 2019 22:26:18 +1100
Message-Id: <20190329112620.14489-31-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329112620.14489-1-mpe@ellerman.id.au>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Diana Craciun <diana.craciun@nxp.com>

commit 039daac5526932ec731e4499613018d263af8b3e upstream.

Fixed the following build warning:
powerpc-linux-gnu-ld: warning: orphan section `__btb_flush_fixup' from
`arch/powerpc/kernel/head_44x.o' being placed in section
`__btb_flush_fixup'.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/head_booke.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 15ac51072eb3..306e26c073a0 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -32,6 +32,16 @@
  */
 #define THREAD_NORMSAVE(offset)	(THREAD_NORMSAVES + (offset * 4))
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define BOOKE_CLEAR_BTB(reg)									\
+START_BTB_FLUSH_SECTION								\
+	BTB_FLUSH(reg)									\
+END_BTB_FLUSH_SECTION
+#else
+#define BOOKE_CLEAR_BTB(reg)
+#endif
+
+
 #define NORMAL_EXCEPTION_PROLOG(intno)						     \
 	mtspr	SPRN_SPRG_WSCRATCH0, r10;	/* save one register */	     \
 	mfspr	r10, SPRN_SPRG_THREAD;					     \
@@ -43,9 +53,7 @@
 	andi.	r11, r11, MSR_PR;	/* check whether user or kernel    */\
 	mr	r11, r1;						     \
 	beq	1f;							     \
-START_BTB_FLUSH_SECTION					\
-	BTB_FLUSH(r11)						\
-END_BTB_FLUSH_SECTION					\
+	BOOKE_CLEAR_BTB(r11)						\
 	/* if from user, start at top of this thread's kernel stack */       \
 	lwz	r11, THREAD_INFO-THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
@@ -131,9 +139,7 @@ END_BTB_FLUSH_SECTION					\
 	stw	r9,_CCR(r8);		/* save CR on stack		   */\
 	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
-START_BTB_FLUSH_SECTION								\
-	BTB_FLUSH(r10)									\
-END_BTB_FLUSH_SECTION								\
+	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-- 
2.20.1

