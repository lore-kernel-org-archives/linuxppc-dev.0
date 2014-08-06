Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE00A1A02B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 18:26:38 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove unused CPU_FTRS_A2
Date: Wed,  6 Aug 2014 18:26:28 +1000
Message-Id: <1407313588-17564-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit fb5a515704d7 "Remove platforms/wsp and associated pieces" we
removed the last user of CPU_FTRS_A2, so we should remove it too.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 0fdd7eece6d9..1de5ff3b7e42 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -458,13 +458,9 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_DABRX)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
-#define CPU_FTRS_A2 (CPU_FTR_USE_TB | CPU_FTR_SMT | CPU_FTR_DBELL | \
-		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN | \
-		     CPU_FTR_ICSWX | CPU_FTR_DABRX )
-
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
-#define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500 | CPU_FTRS_A2)
+#define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
@@ -515,7 +511,7 @@ enum {
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
-#define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500 & CPU_FTRS_A2)
+#define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500)
 #else
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
-- 
1.9.1
