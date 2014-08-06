Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25FB91A021A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 15:42:21 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add POWER8 features to CPU_FTRS_POSSIBLE/ALWAYS
Date: Wed,  6 Aug 2014 15:42:17 +1000
Message-Id: <1407303737-29529-1-git-send-email-mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have been a bit slack about updating the CPU_FTRS_POSSIBLE and
CPU_FTRS_ALWAYS masks. When we added POWER8, and also POWER8E we forgot
to update the ALWAYS mask. And when we added POWER8_DD1 we forgot to
update both the POSSIBLE and ALWAYS masks.

Luckily this hasn't caused any actual bugs AFAICS. Failing to update the
ALWAYS mask just forgoes a potential optimisation opportunity. Failing
to update the POSSIBLE mask for POWER8_DD1 is also OK because it only
removes a bit rather than adding any.

Regardless they should all be in both masks so as to avoid any future
bugs when the set of ALWAYS/POSSIBLE bits changes, or the masks
themselves change.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index af5598688daf..d696eeb2def0 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -458,7 +458,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
-	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
+	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
+	     CPU_FTRS_PA6T | CPU_FTR_VSX)
 #endif
 #else
 enum {
@@ -508,7 +509,8 @@ enum {
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER4 & CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
-	     CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
+	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
+	     CPU_FTRS_POWER8_DD1 & CPU_FTRS_POSSIBLE)
 #endif
 #else
 enum {
-- 
1.9.1
