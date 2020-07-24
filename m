Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000AC433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:01:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15562065C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 14:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="V0FxRaGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15562065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCrTY4fD6zF10h
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 00:01:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqWC5CJKzF0cd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:17:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=V0FxRaGy; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BCqW94J72z9sSt; Fri, 24 Jul 2020 23:17:41 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqW91WDTz9sTF; Fri, 24 Jul 2020 23:17:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595596661;
 bh=O+0Z8q0ZL0zShMFabZ0f0pjR0p+WQEFB/w3w7ZcqwT0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=V0FxRaGyJR0Vwh2SrFiaGMVOoUWgHkxDsemWN1WNnyPHzmcB4uGq9J3ctme9/CeSR
 kdPvyR+IsZbx5oR4eS5CAmLR6+Cb2duhXkeSI0J51ImQnCYCJ+xtu6DM9WPD4L+dU/
 D8TceSX7be9A5g5+ryaDZjMpDSy0WguV8Y/3GuHlPluErbgxsP7RqxZzJZY5cQ4PzZ
 AIbGTCsBtC1svo+0hGFqGQ6rc9z904jDltudstuqKIYq5TWseAHYK7kyzrTbwcC4om
 XaYhmhqR1mqWYs7YPdT2ayikiClv3nIsz2Kk0TiUiK17+ASCnEgoPdTQ8lIZN7P0wj
 q+hHiDqeG+oEA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] powerpc/32s: Fix CONFIG_BOOK3S_601 uses
Date: Fri, 24 Jul 2020 23:17:24 +1000
Message-Id: <20200724131728.1643966-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724131728.1643966-1-mpe@ellerman.id.au>
References: <20200724131728.1643966-1-mpe@ellerman.id.au>
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

We have two uses of CONFIG_BOOK3S_601, which doesn't exist. Fix them
to use CONFIG_PPC_BOOK3S_601 which is the correct symbol.

Fixes: 12c3f1fd87bf ("powerpc/32s: get rid of CPU_FTR_601 feature")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

I think the bug in get_cycles() at least demonstrates that no one has
booted a 601 since v5.4. Time to drop 601?
---
 arch/powerpc/include/asm/ptrace.h | 2 +-
 arch/powerpc/include/asm/timex.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index f194339cef3b..155a197c0aa1 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -243,7 +243,7 @@ static inline void set_trap_norestart(struct pt_regs *regs)
 }
 
 #define arch_has_single_step()	(1)
-#ifndef CONFIG_BOOK3S_601
+#ifndef CONFIG_PPC_BOOK3S_601
 #define arch_has_block_step()	(true)
 #else
 #define arch_has_block_step()	(false)
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index d2d2c4bd8435..6047402b0a4d 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -17,7 +17,7 @@ typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
 {
-	if (IS_ENABLED(CONFIG_BOOK3S_601))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
 		return 0;
 
 	return mftb();
-- 
2.25.1

