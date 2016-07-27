Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtj25y6zDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 15/21] powerpc: Remove mfvtb()
Date: Thu, 28 Jul 2016 00:18:11 +1000
Message-Id: <1469629097-30859-15-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

This function is only used by get_vtb(). They are almost the same except
the reading from the real register. Move the mfspr() to get_vtb() and
kill the function mfvtb(). With this, we can eliminate the use of
cpu_has_feature() in very core header file like reg.h. This is a
preparation for the use of jump label for cpu_has_feature().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h  | 9 ---------
 arch/powerpc/include/asm/time.h | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

v3: No change.

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d7e9ab5e4709..817c005205f0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1256,15 +1256,6 @@ static inline void msr_check_and_clear(unsigned long bits)
 		__msr_check_and_clear(bits);
 }
 
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
index 09211640a0e0..cbbeaf0a6597 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -103,7 +103,7 @@ static inline u64 get_vtb(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mfvtb();
+		return mfspr(SPRN_VTB);
 #endif
 	return 0;
 }
-- 
2.7.4
