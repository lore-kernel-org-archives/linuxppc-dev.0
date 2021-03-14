Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 09:33:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846B64EBA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 09:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846B64EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyvWH5vLZz3dCN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 20:33:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PYTPIdaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=PYTPIdaG; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyvVq3Dtwz3cQK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 20:33:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DyvVp6K4wz9sW5; Sun, 14 Mar 2021 20:33:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615714402;
 bh=Idxr/NzP5n+pc1fhs/kKKkpLC67/vvEgVolFE639fpo=;
 h=From:To:Subject:Date:From;
 b=PYTPIdaGq1ZHe+kBq2KcYPyywfhLu2R2YAL/IOLpYtjnvxEb+p/GIokEa1JFP0YA4
 Vt/CYT1MMAZrmVixoCGY3jzFpv2jEouHudteme1LPnf0g+TcBJq2csdfR5EADppAg6
 y4eSZYjFzEbPFFsjEd14UCMYbV4dKNo35oXcVaVp1LM5H5yZ+ilb5LHontHLL05efz
 6D9uZFJIV2DbGxgwJkJQR9Btu8YnXw0gzcm0kdmS8XGcZgGOW2EaenBfULktFO/v86
 mErvZWePPkdJMvi1xYnhiiJoDkDB8FZt5WwsRsQiKbQ5iTwuqtlNmBQcpJPsbt8HTL
 0p+fARSbPkiqA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s: Fold update_current_thread_[i]amr() into their
 only callers
Date: Sun, 14 Mar 2021 20:33:20 +1100
Message-Id: <20210314093320.132331-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

lkp reported warnings in some configuration due to
update_current_thread_amr() being unused:

  arch/powerpc/mm/book3s64/pkeys.c:284:20: error: unused function 'update_current_thread_amr'
  static inline void update_current_thread_amr(u64 value)

Which is because it's only use is inside an ifdef. We could move it
inside the ifdef, but it's a single line function and only has one
caller, so just fold it in.

Similarly update_current_thread_iamr() is small and only called once,
so fold it in also.

Fixes: 48a8ab4eeb82 ("powerpc/book3s64/pkeys: Don't update SPRN_AMR when in kernel mode.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/book3s64/pkeys.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index 15dcc5ad91c5..a2d9ad138709 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -301,19 +301,6 @@ void setup_kuap(bool disabled)
 }
 #endif
 
-static inline void update_current_thread_amr(u64 value)
-{
-	current->thread.regs->amr = value;
-}
-
-static inline void update_current_thread_iamr(u64 value)
-{
-	if (!likely(pkey_execute_disable_supported))
-		return;
-
-	current->thread.regs->iamr = value;
-}
-
 #ifdef CONFIG_PPC_MEM_KEYS
 void pkey_mm_init(struct mm_struct *mm)
 {
@@ -328,7 +315,7 @@ static inline void init_amr(int pkey, u8 init_bits)
 	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
 	u64 old_amr = current_thread_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
 
-	update_current_thread_amr(old_amr | new_amr_bits);
+	current->thread.regs->amr = old_amr | new_amr_bits;
 }
 
 static inline void init_iamr(int pkey, u8 init_bits)
@@ -336,7 +323,10 @@ static inline void init_iamr(int pkey, u8 init_bits)
 	u64 new_iamr_bits = (((u64)init_bits & 0x1UL) << pkeyshift(pkey));
 	u64 old_iamr = current_thread_iamr() & ~((u64)(0x1ul) << pkeyshift(pkey));
 
-	update_current_thread_iamr(old_iamr | new_iamr_bits);
+	if (!likely(pkey_execute_disable_supported))
+		return;
+
+	current->thread.regs->iamr = old_iamr | new_iamr_bits;
 }
 
 /*
-- 
2.25.1

