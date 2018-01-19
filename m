Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNF645WNfzF0xj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 19:55:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH] powerpc/64s: Fix ps3 build error due to tlbiel_all()
Date: Fri, 19 Jan 2018 19:55:31 +1100
Message-Id: <20180119085531.7708-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent changes to TLB handling broke the PS3 build:

  arch/powerpc/include/asm/book3s/64/tlbflush.h:30: undefined reference to `.hash__tlbiel_all'

Fix it by adding an fallback version of tlbiel_all() for non-native
builds. It should never be called, due to checks in callers so it
calls BUG(). We should probably clean it up further but this will
suffice for now.

Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/tlbflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 9befb4df235c..0cac17253513 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -14,6 +14,7 @@ enum {
 	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
 };
 
+#ifdef CONFIG_PPC_NATIVE
 static inline void tlbiel_all(void)
 {
 	/*
@@ -29,6 +30,9 @@ static inline void tlbiel_all(void)
 	else
 		hash__tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
 }
+#else
+static inline void tlbiel_all(void) { BUG(); };
+#endif
 
 static inline void tlbiel_all_lpid(bool radix)
 {
-- 
2.14.3
