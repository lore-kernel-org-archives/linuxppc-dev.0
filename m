Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3BDw44MTzDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 18:46:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q85so2306167pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 01:46:56 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/asm: Mark cr0 as clobbered in mftb()
Date: Thu,  6 Jul 2017 18:46:43 +1000
Message-Id: <20170706084643.22425-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The workaround for the CELL timebase bug does not correctly mark cr0 as
being clobbered. This can result in GCC making some poor^W completely
broken optimisations.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e50e47375d6..a3b6575c7842 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1303,7 +1303,7 @@ static inline void msr_check_and_clear(unsigned long bits)
 				"	.llong 0\n"			\
 				".previous"				\
 			: "=r" (rval) \
-			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL)); \
+			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
 			rval;})
 #else
 #define mftb()		({unsigned long rval;	\
-- 
2.9.4
