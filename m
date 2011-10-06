Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E86AB708F
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Oct 2011 23:53:48 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p96CrhvR021952
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Oct 2011 07:53:44 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc/book3e-64: Fix debug support for userspace
Date: Thu,  6 Oct 2011 07:53:40 -0500
Message-Id: <1317905621-5537-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1317905621-5537-2-git-send-email-galak@kernel.crashing.org>
References: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
	<1317905621-5537-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the introduction of CONFIG_PPC_ADV_DEBUG_REGS user space debug is
broken on Book-E 64-bit parts that support delayed debug events.  When
switch_booke_debug_regs() sets DBCR0 we'll start getting debug events as
MSR_DE is also set and we aren't able to handle debug events from kernel
space.

We can remove the hack that always enables MSR_DE and loads up DBCR0 and
just utilize switch_booke_debug_regs() to get user space debug working
again.

We still need to handle critical/debug exception stacks & proper
save/restore of state for those exception levles to support debug events
from kernel space like we have on 32-bit.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg_booke.h |    2 +-
 arch/powerpc/kernel/process.c        |   22 ----------------------
 2 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 9ec0b39..4dfa21c 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -31,7 +31,7 @@
 
 #define MSR_		MSR_ME | MSR_CE
 #define MSR_KERNEL	MSR_ | MSR_64BIT
-#define MSR_USER32	MSR_ | MSR_PR | MSR_EE | MSR_DE
+#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
 #define MSR_USER64	MSR_USER32 | MSR_64BIT
 #elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a1b5981..269a309 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -486,28 +486,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
-#if defined(CONFIG_PPC_BOOK3E_64)
-	/* XXX Current Book3E code doesn't deal with kernel side DBCR0,
-	 * we always hold the user values, so we set it now.
-	 *
-	 * However, we ensure the kernel MSR:DE is appropriately cleared too
-	 * to avoid spurrious single step exceptions in the kernel.
-	 *
-	 * This will have to change to merge with the ppc32 code at some point,
-	 * but I don't like much what ppc32 is doing today so there's some
-	 * thinking needed there
-	 */
-	if ((new_thread->dbcr0 | old_thread->dbcr0) & DBCR0_IDM) {
-		u32 dbcr0;
-
-		mtmsr(mfmsr() & ~MSR_DE);
-		isync();
-		dbcr0 = mfspr(SPRN_DBCR0);
-		dbcr0 = (dbcr0 & DBCR0_EDM) | new_thread->dbcr0;
-		mtspr(SPRN_DBCR0, dbcr0);
-	}
-#endif /* CONFIG_PPC64_BOOK3E */
-
 #ifdef CONFIG_PPC64
 	/*
 	 * Collect processor utilization data per process
-- 
1.7.3.4
