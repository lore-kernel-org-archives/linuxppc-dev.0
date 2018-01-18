Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMz7d31v2zF0hR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 09:26:05 +1100 (AEDT)
Date: Fri, 19 Jan 2018 09:26:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20180119092603.5adb8912@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/asm-generic/bug.h:18:0,
                 from arch/powerpc/include/asm/bug.h:128,
                 from include/linux/bug.h:5,
                 from arch/powerpc/include/asm/mmu.h:126,
                 from arch/powerpc/include/asm/lppaca.h:36,
                 from arch/powerpc/include/asm/paca.h:21,
                 from arch/powerpc/include/asm/current.h:16,
                 from include/linux/sched.h:12,
                 from arch/powerpc/kernel/setup_64.c:15:
arch/powerpc/kernel/setup_64.c: In function 'init_fallback_flush':
arch/powerpc/kernel/setup_64.c:864:14: error: implicit declaration of function 'safe_stack_limit'; did you mean 'save_stack_trace'? [-Werror=implicit-function-declaration]
  limit = min(safe_stack_limit(), ppc64_rma_size);
              ^
include/linux/kernel.h:790:2: note: in definition of macro '__min'
  t1 min1 = (x);     \
  ^~
arch/powerpc/kernel/setup_64.c:864:10: note: in expansion of macro 'min'
  limit = min(safe_stack_limit(), ppc64_rma_size);
          ^~~
include/linux/kernel.h:792:16: error: comparison of distinct pointer types lacks a cast [-Werror]
  (void) (&min1 == &min2);   \
                ^
include/linux/kernel.h:801:2: note: in expansion of macro '__min'
  __min(typeof(x), typeof(y),   \
  ^~~~~
arch/powerpc/kernel/setup_64.c:864:10: note: in expansion of macro 'min'
  limit = min(safe_stack_limit(), ppc64_rma_size);
          ^~~

Caused by commit

  1af19331a3a1 ("powerpc/64s: Relax PACA address limitations")

interacting with commit

  aa8a5e0062ac ("powerpc/64s: Add support for RFI flush of L1-D cache")

from Linus' tree.

I applied the following fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 19 Jan 2018 09:21:44 +1100
Subject: [PATCH] powerpc: fix up for safe_stack_limit rename

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9e23c74896cc..f2b532f00861 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -861,7 +861,7 @@ static void init_fallback_flush(void)
 	int cpu;
 
 	l1d_size = ppc64_caches.l1d.size;
-	limit = min(safe_stack_limit(), ppc64_rma_size);
+	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	/*
 	 * Align to L1d size, and size it at 2x L1d size, to catch possible
-- 
2.15.1

-- 
Cheers,
Stephen Rothwell
