Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FF251A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 23:44:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, cyrilbur@gmail.com,
 sjitindarsingh@gmail.com
Subject: [PATCH] selftests/powerpc: Fix out of bounds access in TM signal test
Date: Wed,  2 Mar 2016 23:44:31 +1100
Message-Id: <1456922671-31676-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gcc helpfully points out that we're accessing past the end of the gprs
array:

  tm-signal-msr-resv.c: In function 'signal_usr1':
  tm-signal-msr-resv.c:43:37: error: array subscript is above array bounds [-Werror=array-bounds]
    ucp->uc_mcontext.regs->gpr[PT_MSR] |= (7ULL);

We haven't noticed previously because -flto was hiding it somehow.

The code is confused, PT_MSR isn't a gpr, instead it's in
uc_regs->gregs, so fix it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
index d86653f282b1..8c54d18b3e9a 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -40,7 +40,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
 #ifdef __powerpc64__
 	ucp->uc_mcontext.gp_regs[PT_MSR] |= (7ULL << 32);
 #else
-	ucp->uc_mcontext.regs->gpr[PT_MSR] |= (7ULL);
+	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
 #endif
 	/* Should segv on return becuase of invalid context */
 	segv_expected = 1;
-- 
2.5.0
