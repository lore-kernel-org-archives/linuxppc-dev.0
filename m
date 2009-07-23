Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8283BB7C86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:55 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:44 +1000
Subject: [PATCH 9/20] powerpc/mm: Call mmu_context_init() from ppc64
Message-Id: <20090723055955.757B4DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our 64-bit hash context handling has no init function, but 64-bit Book3E
will use the common mmu_context_nohash.c code which does, so define an
empty inline mmu_context_init() for 64-bit server and call it from
our 64-bit setup_arch()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu_context.h |    7 ++++++-
 arch/powerpc/kernel/setup_64.c         |    4 ++++
 arch/powerpc/mm/mmu_context_hash64.c   |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu_context.h	2009-07-22 16:25:25.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu_context.h	2009-07-22 16:25:50.000000000 +1000
@@ -14,7 +14,6 @@
 /*
  * Most if the context management is out of line
  */
-extern void mmu_context_init(void);
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
 
@@ -23,6 +22,12 @@ extern void switch_stab(struct task_stru
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void mmu_context_init(void) { }
+#else
+extern void mmu_context_init(void);
+#endif
+
 /*
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched.c
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-22 16:26:23.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-22 16:26:31.000000000 +1000
@@ -534,6 +534,10 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	paging_init();
+
+	/* Initialize the MMU context management stuff */
+	mmu_context_init();
+
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
Index: linux-work/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24:43.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24:56.000000000 +1000
@@ -76,3 +76,4 @@ void destroy_context(struct mm_struct *m
 
 	mm->context.id = NO_CONTEXT;
 }
+
