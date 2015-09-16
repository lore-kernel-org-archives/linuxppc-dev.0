Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id BE42A1A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 20:05:20 +1000 (AEST)
Message-Id: <ca5390a60d9249e4a02ebf0b83009f3ceceba806.1442335197.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442335197.git.christophe.leroy@c-s.fr>
References: <cover.1442335197.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/2] powerpc32: memset: only use dcbz once cache is enabled
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com, sojkam1@fel.cvut.cz
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 Sep 2015 12:04:53 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memset() uses instruction dcbz to speed up clearing by not wasting time
loading cache line with data that will be overwritten.
Some platform like mpc52xx do no have cache active at startup and
can therefore not use memset(). Allthough no part of the code
explicitly uses memset(), GCC may make calls to it.

This patch modifies memset() such that at startup, memset()
unconditionally skip the optimised bloc that uses dcbz instruction.

Once the initial MMU is set up, in machine_init() we patch memset()
by replacing this inconditional jump by a NOP

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Changes in v2:
   was part of [v2] powerpc32: memcpy/memset: only use dcbz once cache is enabled
changes in v3:
  Not using anymore feature-fixups
  Handling of memcpy() and memset() split in two patches
changes in v4:
  Skipping the optimised bloc in the middle of memset() instead of
    branching to a newly implemented simple_memset()

 arch/powerpc/kernel/setup_32.c | 3 +++
 arch/powerpc/lib/copy_32.S     | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 362495f..cdb8221 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -116,6 +116,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * This is called very early on the boot process, after a minimal
  * MMU environment has been set up but before MMU_init is called.
  */
+extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
+
 notrace void __init machine_init(u64 dt_ptr)
 {
 	lockdep_init();
@@ -124,6 +126,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	udbg_early_init();
 
 	patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
+	patch_instruction(&memset_nocache_branch, PPC_INST_NOP);
 
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index da5847d..c44df2d 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -73,6 +73,10 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
  * Use dcbz on the complete cache lines in the destination
  * to set them to zero.  This requires that the destination
  * area is cacheable.  -- paulus
+ *
+ * During early init, cache might not be active yet, so dcbz cannot be used.
+ * We therefore skip the optimised bloc that uses dcbz. This jump is
+ * replaced by a nop once cache is active. This is done in machine_init()
  */
 _GLOBAL(memset)
 	rlwimi	r4,r4,8,16,23
@@ -88,6 +92,8 @@ _GLOBAL(memset)
 	subf	r6,r0,r6
 	cmplwi	0,r4,0
 	bne	2f	/* Use normal procedure if r4 is not zero */
+_GLOBAL(memset_nocache_branch)
+	b	2f	/* Skip optimised bloc until cache is enabled */
 
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
-- 
2.1.0
