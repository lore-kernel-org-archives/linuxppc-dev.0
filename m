Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:48 +1000
Subject: [PATCH 13/21] powerpc: Always apply DABR changes on context switches
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051553.3C69CDDF4A@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the #ifdef CONFIG_PPC64 around setting the DABR.

The actual setting of the SPR inside of the set_dabr() function is dependant
on CONFIG_PPC64 || CONFIG_6xx but you can always provide a ppc_md hook to
override that. We should improve support for different HW breakpoints
facilities but this is a first step.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/process.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-cell/arch/powerpc/kernel/process.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/process.c	2007-05-30 16:22:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/process.c	2007-05-30 16:28:08.000000000 +1000
@@ -219,22 +219,26 @@ void discard_lazy_cpu_state(void)
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_PPC_MERGE		/* XXX for now */
 int set_dabr(unsigned long dabr)
 {
+#ifdef CONFIG_PPC_MERGE		/* XXX for now */
 	if (ppc_md.set_dabr)
 		return ppc_md.set_dabr(dabr);
+#endif
 
+	/* XXX should we have a CPU_FTR_HAS_DABR ? */
+#if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
 	mtspr(SPRN_DABR, dabr);
+#endif
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
-static DEFINE_PER_CPU(unsigned long, current_dabr);
 #endif
 
+static DEFINE_PER_CPU(unsigned long, current_dabr);
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
@@ -299,12 +303,10 @@ struct task_struct *__switch_to(struct t
 
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_PPC64	/* for now */
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr)) {
 		set_dabr(new->thread.dabr);
 		__get_cpu_var(current_dabr) = new->thread.dabr;
 	}
-#endif /* CONFIG_PPC64 */
 
 	new_thread = &new->thread;
 	old_thread = &current->thread;
@@ -473,12 +475,10 @@ void flush_thread(void)
 
 	discard_lazy_cpu_state();
 
-#ifdef CONFIG_PPC64	/* for now */
 	if (current->thread.dabr) {
 		current->thread.dabr = 0;
 		set_dabr(0);
 	}
-#endif
 }
 
 void
