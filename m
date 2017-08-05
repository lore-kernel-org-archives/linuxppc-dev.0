Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqq6bBGzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:19 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so4730998pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 07/13] powerpc/64: remove redundant instruction in interrupt
 replay
Date: Sun,  6 Aug 2017 03:02:35 +1000
Message-Id: <20170805170241.22966-8-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ec67f67dafab..3f2666d24a7e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -995,7 +995,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	bl	doorbell_exception
-	b	ret_from_except
 #endif /* CONFIG_PPC_DOORBELL */
 1:	b	ret_from_except /* What else to do here ? */
  
-- 
2.11.0
