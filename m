Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlCwt2TCGzDwKh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 14:07:10 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id u15so34951340oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 19:07:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, driver-devel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix build warning on 32-bit PPC - bisected to commit
 989cea5c14be
Date: Thu, 22 Dec 2016 21:06:53 -0600
Message-Id: <20161223030653.30178-1-Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am getting the following warning when I build kernel 4.9-git on my
PowerBook G4 with a 32-bit PPC processor:

  AS      arch/powerpc/kernel/misc_32.o
arch/powerpc/kernel/misc_32.S:299:7: warning: "CONFIG_FSL_BOOKE" is not defined [-Wundef]

This problem is evident after commit 989cea5c14be ("kbuild: prevent
lib-ksyms.o rebuilds"); however, this change in kbuild only exposes an
error that has been in the code since 2005 when this source file was
created. That was with commit 9994a33865f4 ("powerpc: Introduce
entry_{32,64}.S, misc_{32,64}.S, systbl.S"). The offending line is
way does not make a lot of sense. This error does not seem to cause any
errors in the executable, thus I am not recommending that it be applied
to any stable versions.

Thanks to Nicholas Piggin for suggesting this solution.

Fixes: 9994a33865f4 ("powerpc: Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/misc_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 1863324..84db14e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -296,7 +296,7 @@ _GLOBAL(flush_instruction_cache)
 	lis	r3, KERNELBASE@h
 	iccci	0,r3
 #endif
-#elif CONFIG_FSL_BOOKE
+#elif defined(CONFIG_FSL_BOOKE)
 BEGIN_FTR_SECTION
 	mfspr   r3,SPRN_L1CSR0
 	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
-- 
2.10.2
