Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcr771F5zzDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:54:42 +1000 (AEST)
Message-Id: <ae2205dedfe437e4df2dd0cc7605d62189833221.1503277387.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1503277387.git.christophe.leroy@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/4] powerpc/32: remove a NOP from memset()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 Aug 2017 16:54:38 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memset() is patched after initialisation to activate the
optimised part which uses cache instructions.

Today we have a 'b 2f' to skip the optimised patch, which then gets
replaced by a NOP, implying a useless cycle consumption.
As we have a 'bne 2f' just before, we could use that instruction
for the live patching, hence removing the need to have a
dedicated 'b 2f' to be replaced by a NOP.

This patch changes the 'bne 2f' by a 'b 2f'. During init, that
'b 2f' is then replaced by 'bne 2f'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup_32.c | 7 ++++++-
 arch/powerpc/lib/copy_32.S     | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 2f88f6cf1a42..51ebc01fff52 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -98,6 +98,9 @@ extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
 
 notrace void __init machine_init(u64 dt_ptr)
 {
+	unsigned int *addr = &memset_nocache_branch;
+	unsigned long insn;
+
 	/* Configure static keys first, now that we're relocated. */
 	setup_feature_keys();
 
@@ -105,7 +108,9 @@ notrace void __init machine_init(u64 dt_ptr)
 	udbg_early_init();
 
 	patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
-	patch_instruction(&memset_nocache_branch, PPC_INST_NOP);
+
+	insn = create_cond_branch(addr, branch_target(addr), 0x820000);
+	patch_instruction(addr, insn);	/* replace b by bne cr0 */
 
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 05aaee20590f..da425bb6b369 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -103,9 +103,12 @@ _GLOBAL(memset)
 	add	r5,r0,r5
 	subf	r6,r0,r3
 	cmplwi	0,r4,0
-	bne	2f	/* Use normal procedure if r4 is not zero */
+	/*
+	 * Skip optimised bloc until cache is enabled. Will be replaced
+	 * by 'bne' during boot to use normal procedure if r4 is not zero
+	 */
 _GLOBAL(memset_nocache_branch)
-	b	2f	/* Skip optimised bloc until cache is enabled */
+	b	2f
 
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
-- 
2.13.3
