Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id C2ED11A0790
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2015 00:33:52 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc32: memcpy: only use dcbz once cache is enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com, sojkam1@fel.cvut.cz
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20150911143348.F1D9F1A2420@localhost.localdomain>
Date: Fri, 11 Sep 2015 16:33:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memcpy() uses instruction dcbz to speed up copy by not wasting time
loading cache line with data that will be overwritten.
Some platform like mpc52xx do no have cache active at startup and
can therefore not use memcpy(). Allthough no part of the code
explicitly uses memcpy(), GCC makes calls to it.

This patch modifies memcpy() such that at startup, memcpy()
unconditionally jumps to generic_memcpy() which doesn't use
the dcbz instruction.

Once the initial MMU is set up, in machine_init() we patch memcpy()
by replacing this inconditional jump by a NOP

Reported-by: Michal Sojka <sojkam1@fel.cvut.cz>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
changes in v2:
  Using feature-fixups instead of hardcoded call to patch_instruction()
  Handling of memset() added
changes in v3:
  Not using anymore feature-fixups
  Handling of memset() removed

 arch/powerpc/kernel/setup_32.c | 3 +++
 arch/powerpc/lib/copy_32.S     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 07831ed..362495f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,6 +39,7 @@
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/code-patching.h>
 
 #define DBG(fmt...)
 
@@ -122,6 +123,8 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
+
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 2ef50c6..da5847d 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -128,6 +128,10 @@ _GLOBAL(memset)
  * the destination area is cacheable.
  * We only use this version if the source and dest don't overlap.
  * -- paulus.
+ *
+ * During early init, cache might not be active yet, so dcbz cannot be used.
+ * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
+ * replaced by a nop once cache is active. This is done in machine_init()
  */
 _GLOBAL(memmove)
 	cmplw	0,r3,r4
@@ -135,6 +139,7 @@ _GLOBAL(memmove)
 	/* fall through */
 
 _GLOBAL(memcpy)
+	b	generic_memcpy
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
-- 
2.1.0
