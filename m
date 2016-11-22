Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNMq325B4zDvYL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:56:47 +1100 (AEDT)
Message-Id: <d59d33a13c8956d6e2dbd228b247d3d8bc7caf1f.1479742486.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1479742486.git.christophe.leroy@c-s.fr>
References: <cover.1479742486.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc/32: stack protector: change the canary value
 per task
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Tue, 22 Nov 2016 11:49:32 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Partially copied from commit df0698be14c66 ("ARM: stack protector:
change the canary value per task")

A new random value for the canary is stored in the task struct whenever
a new task is forked.  This is meant to allow for different canary values
per task.  On powerpc, GCC expects the canary value to be found in a global
variable called __stack_chk_guard.  So this variable has to be updated
with the value stored in the task struct whenever a task switch occurs.

Because the variable GCC expects is global, this cannot work on SMP
unfortunately.  So, on SMP, the same initial canary value is kept
throughout, making this feature a bit less effective although it is still
useful.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/asm-offsets.c | 3 +++
 arch/powerpc/kernel/entry_32.S    | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index caec7bf..5c86030 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -91,6 +91,9 @@ int main(void)
 	DEFINE(TI_livepatch_sp, offsetof(struct thread_info, livepatch_sp));
 #endif
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+	DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
+#endif
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 #ifdef CONFIG_BOOKE
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3841d74..5742dbd 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -674,7 +674,11 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
 END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
-
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	lwz	r0,TSK_STACK_CANARY(r2)
+	lis	r4,__stack_chk_guard@ha
+	stw	r0,__stack_chk_guard@l(r4)
+#endif
 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
 	/* r3-r12 are destroyed -- Cort */
-- 
2.10.1
