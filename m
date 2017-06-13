Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn95B6mLWzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:06:38 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y7so21382813pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:06:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 08/13] powerpc/64s: idle hmi wakeup is unlikely
Date: Tue, 13 Jun 2017 23:05:52 +1000
Message-Id: <20170613130557.26315-9-npiggin@gmail.com>
In-Reply-To: <20170613130557.26315-1-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
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

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
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
