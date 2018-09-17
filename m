Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DQ783kktzF2R6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 22:15:16 +1000 (AEST)
Message-Id: <7bd67c4ccdd202f2125b7fc0ed0332d0d020690b.1537186089.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
References: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/32: stack protector: change the canary value per
 task
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Sep 2018 12:15:08 +0000 (UTC)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 I would have liked to use -mstack-protector-guard=tls -mstack-protector-guard-reg=r2
 -mstack-protector-guard-offset=offsetof(struct task_struct, stack_canary) but I have
 not found how set the value of offsetof(struct task_struct, stack_canary) in Makefile.
 Any idea ?

 arch/powerpc/kernel/asm-offsets.c | 3 +++
 arch/powerpc/kernel/entry_32.S    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..cb02d23764ca 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,9 @@ int main(void)
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
+#ifdef CONFIG_CC_STACKPROTECTOR
+	DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..0cdb4170a21d 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -721,6 +721,11 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
 END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	lwz	r0, TSK_STACK_CANARY(r2)
+	lis	r4, __stack_chk_guard@ha
+	stw	r0, __stack_chk_guard@l(r4)
+#endif
 
 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
-- 
2.13.3
