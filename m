Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1t6Rr6zDr39
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:46 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u185so3515343pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 07/14] powerpc/64: remove redundant instruction in
 interrupt replay
Date: Sat, 12 Aug 2017 02:39:05 +1000
Message-Id: <20170811163912.28783-8-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
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
2.13.3
