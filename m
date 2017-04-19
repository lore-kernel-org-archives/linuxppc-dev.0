Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w75WW5nK2zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:27:51 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c198so1589538pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 19:27:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: POWER9 remove ICSWX feature
Date: Wed, 19 Apr 2017 12:27:37 +1000
Message-Id: <20170419022738.31791-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 does not implement this instruction.

Fixes: c3ab300ea5 ("powerpc: Add POWER9 cputable entry")

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h    | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4edbc2f7569a..9c3a44bb4694 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -473,7 +473,7 @@ enum {
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
+	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
 #define CPU_FTRS_POWER9_DD1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ef4c4b8fc547..3baf821a186d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -279,7 +279,8 @@ config PPC_ICSWX
 
 	  This option enables kernel support for the PowerPC Initiate
 	  Coprocessor Store Word (icswx) coprocessor instruction on POWER7
-	  or newer processors.
+	  and POWER8 processors. POWER9 uses new copy/paste instructions
+	  to invoke the coprocessor.
 
 	  This option is only useful if you have a processor that supports
 	  the icswx coprocessor instruction. It does not have any effect
-- 
2.11.0
