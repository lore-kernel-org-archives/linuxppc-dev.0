Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D09011A105A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 15:47:00 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Non relocatable system call doesn't need a
 trampoline
Date: Tue, 26 May 2015 15:46:55 +1000
Message-Id: <1432619215-13490-2-git-send-email-anton@samba.org>
In-Reply-To: <1432619215-13490-1-git-send-email-anton@samba.org>
References: <1432619215-13490-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to use a trampoline when using LOAD_HANDLER(), because the
destination needs to be in the first 64kB. An absolute branch has
no such limitations, so just jump there.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index cf8c1b5..0a0399c2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -79,7 +79,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
-	b	system_call_entry ;
+	b	system_call_common ;
 #endif
 
 /*
-- 
2.1.4
