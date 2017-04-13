Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3bWz5WndzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 19:46:07 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i5so9792444pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 02:46:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/64s: Use relon prolog for EXC_VIRT_OOL_MASKABLE_HV
 handlers
Date: Thu, 13 Apr 2017 19:45:48 +1000
Message-Id: <20170413094548.10616-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hypervisor Virtualization and Directed Hypervisor Doorbell interrupt
handlers use the macro EXC_VIRT_OOL_MASKABLE_HV for their relocation-on
handlers, which calls MASKABLE_RELON_EXCEPTION_HV_OOL, which uses the
real mode interrupt prolog.

Use the RELON variant instead to reduce overhead.

Fixes: 1707dd1613 ("powerpc: Save CFAR before branching in interrupt entry paths")
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I was hesitant about using the Fixes: tag on this one because it's not
a correctness bug as far as I can see.

Thanks,
Nick

 arch/powerpc/include/asm/exception-64s.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 14752eee3d0c..b89c91e27dd0 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -522,7 +522,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
  * Our exception common code can be passed various "additions"
-- 
2.11.0
