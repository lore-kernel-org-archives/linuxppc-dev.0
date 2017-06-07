Return-Path: <w@1wt.eu>
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wjkn141rkzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 09:10:45 +1000 (AEST)
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux@roeck-us.net
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 078/250] powerpc: Fix build warning on 32-bit PPC
Date: Thu,  8 Jun 2017 00:57:44 +0200
Message-Id: <1496876436-32402-79-git-send-email-w@1wt.eu>
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 8ae679c4bc2ea2d16d92620da8e3e9332fa4039f upstream.

I am getting the following warning when I build kernel 4.9-git on my
PowerBook G4 with a 32-bit PPC processor:

    AS      arch/powerpc/kernel/misc_32.o
  arch/powerpc/kernel/misc_32.S:299:7: warning: "CONFIG_FSL_BOOKE" is not defined [-Wundef]

This problem is evident after commit 989cea5c14be ("kbuild: prevent
lib-ksyms.o rebuilds"); however, this change in kbuild only exposes an
error that has been in the code since 2005 when this source file was
created.  That was with commit 9994a33865f4 ("powerpc: Introduce
entry_{32,64}.S, misc_{32,64}.S, systbl.S").

The offending line does not make a lot of sense.  This error does not
seem to cause any errors in the executable, thus I am not recommending
that it be applied to any stable versions.

Thanks to Nicholas Piggin for suggesting this solution.

Fixes: 9994a33865f4 ("powerpc: Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/powerpc/kernel/misc_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index e469f30..ad8573f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -295,7 +295,7 @@ _GLOBAL(flush_instruction_cache)
 	lis	r3, KERNELBASE@h
 	iccci	0,r3
 #endif
-#elif CONFIG_FSL_BOOKE
+#elif defined(CONFIG_FSL_BOOKE)
 BEGIN_FTR_SECTION
 	mfspr   r3,SPRN_L1CSR0
 	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
-- 
2.8.0.rc2.1.gbe9624a
