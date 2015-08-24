Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC7891A1DA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 21:20:56 +1000 (AEST)
Received: by ykll84 with SMTP id l84so130759520ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 04:20:54 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] powerpc: kill mfvtb()
Date: Mon, 24 Aug 2015 19:20:25 +0800
Message-Id: <1440415228-8006-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
References: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function is only used by get_vtb(). They are almost the same
except the reading from the real register. Move the mfspr() to
get_vtb() and kill the function mfvtb(). With this, we can eliminate
the use of cpu_has_feature() in very core header file like reg.h.
This is a preparation for the use of jump label for cpu_has_feature().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 arch/powerpc/include/asm/reg.h  | 9 ---------
 arch/powerpc/include/asm/time.h | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index aa1cc5f015ee..d0b5f4b63776 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1207,15 +1207,6 @@
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 
-static inline unsigned long mfvtb (void)
-{
-#ifdef CONFIG_PPC_BOOK3S_64
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mfspr(SPRN_VTB);
-#endif
-	return 0;
-}
-
 #ifdef __powerpc64__
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define mftb()		({unsigned long rval;				\
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 10fc784a2ad4..6f69828458fb 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -106,7 +106,7 @@ static inline u64 get_vtb(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mfvtb();
+		return mfspr(SPRN_VTB);
 #endif
 	return 0;
 }
-- 
2.1.0
