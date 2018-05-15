Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lMHW6pDmzF37h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 12:40:23 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id u6-v6so8481502pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 19:40:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: Fix for "make PACA_IRQ_HARD_DIS track MSR[EE]
 closely"
Date: Tue, 15 May 2018 12:40:12 +1000
Message-Id: <20180515024012.20157-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch "powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely"
needs an equivalent change to the 64/e interrupt handler, to set
PACA_IRQ_HARD_DIS when MSR[EE] gets cleared.

Also the original patch should be named powerpc/64: rather than 64s:.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 9b6e653e501a..9eab3ea480fa 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -956,6 +956,9 @@ kernel_dbg_exc:
 	rldicl	r10,r11,48,1		/* clear MSR_EE */
 	rotldi	r11,r10,16
 	mtspr	SPRN_SRR1,r11
+	lbz	r11,PACAIRQHAPPENED(r13)
+	ori	r11,r11,PACA_IRQ_HARD_DIS
+	stb	r11,PACAIRQHAPPENED(r13)
 	.endif
 
 	lwz	r11,PACA_EXGEN+EX_CR(r13)
-- 
2.17.0
