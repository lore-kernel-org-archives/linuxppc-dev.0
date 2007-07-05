Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0F979DDF61
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170242.449250000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:06 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 33/35] Work around errata 5667
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Always keep a page mapped at EA 0. Right now it is shared among all
processes, as long as noone does a NULL pointer deref and uses the data
there, there should be no security implications. Still, this is better
not used in any kind of environment where users can't be trusted.


Index: mainline/arch/powerpc/kernel/process.c
===================================================================
--- mainline.orig/arch/powerpc/kernel/process.c
+++ mainline/arch/powerpc/kernel/process.c
@@ -330,6 +330,14 @@ struct task_struct *__switch_to(struct t
 	calculate_steal_time();
 
 	last = _switch(old_thread, new_thread);
+	/* current is still really us, just a different us :-) */
+	if (current->mm) {
+#ifdef CONFIG_PPC_HAS_HASH_64K
+		__hash_page_64K(0, _PAGE_USER|_PAGE_RW, get_vsid(current->mm->context.id, 0), &current->zero_pte.pte, 0x300, 1);
+#else
+		__hash_page_4K(0, _PAGE_USER|_PAGE_RW, get_vsid(current->mm->context.id, 0), &current->zero_pte, 0x300, 1);
+#endif
+	}
 
 	local_irq_restore(flags);
 
Index: mainline/kernel/fork.c
===================================================================
--- mainline.orig/kernel/fork.c
+++ mainline/kernel/fork.c
@@ -104,8 +104,12 @@ struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
+static struct page *zero_page;
+
 void free_task(struct task_struct *tsk)
 {
+	if (tsk->mm)
+		flush_hash_page(get_vsid(tsk->mm->context.id, 0) << 28, tsk->zero_pte, MMU_PAGE_4K, 0);
 	free_thread_info(tsk->stack);
 	rt_mutex_debug_task_free(tsk);
 	free_task_struct(tsk);
@@ -156,6 +160,8 @@ void __init fork_init(unsigned long memp
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
+
+	zero_page = alloc_page(GFP_KERNEL);
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -182,6 +188,11 @@ static struct task_struct *dup_task_stru
 #ifdef CONFIG_CC_STACKPROTECTOR
 	tsk->stack_canary = get_random_int();
 #endif
+#ifdef CONFIG_PPC_64K_PAGES
+	tsk->zero_pte.pte = mk_pte(zero_page,_PAGE_BASE|_PAGE_RW|_PAGE_USER|_PAGE_EXEC);
+#else
+	tsk->zero_pte = mk_pte(zero_page,_PAGE_BASE|_PAGE_RW|_PAGE_USER|_PAGE_EXEC);
+#endif
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
Index: mainline/include/linux/sched.h
===================================================================
--- mainline.orig/include/linux/sched.h
+++ mainline/include/linux/sched.h
@@ -863,6 +863,7 @@ struct task_struct {
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	real_pte_t zero_pte;
 
 /* task state */
 	struct linux_binfmt *binfmt;

--
