Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPjqs1zn8zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 17:32:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 7/9] powerpc/traps: machine_check_generic() is only used
 on 32-bit
Date: Fri, 17 Feb 2017 17:32:17 +1100
Message-Id: <1487313139-21959-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
References: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it clear that the fallback version of machine_check_generic() is
only used on 32-bit configs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5ea1bd0ed254..9315d925d49d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -599,7 +599,7 @@ int machine_check_8xx(struct pt_regs *regs)
 	return 0;
 #endif
 }
-#else
+#elif defined(CONFIG_PPC32)
 int machine_check_generic(struct pt_regs *regs)
 {
 	unsigned long reason = regs->msr;
-- 
2.7.4
