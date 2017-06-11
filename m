Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmChm6DVGzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:00:40 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w12so4683908pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 17:00:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 09/14] powerpc/64s: idle hmi wakeup is unlikely
Date: Mon, 12 Jun 2017 09:58:30 +1000
Message-Id: <20170611235835.7400-10-npiggin@gmail.com>
In-Reply-To: <20170611235835.7400-1-npiggin@gmail.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a busy system, idle wakeups can be expected from IPIs and device
interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 6305d4d7a268..32b76fb28352 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -306,7 +306,7 @@ FTR_SECTION_ELSE_NESTED(66);						\
 	rlwinm	r0,r12,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
 ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
-	bne	20f;							\
+	bne+	20f;							\
 	/* Invoke opal call to handle hmi */				\
 	ld	r2,PACATOC(r13);					\
 	ld	r1,PACAR1(r13);						\
-- 
2.11.0
