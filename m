Return-Path: <chirag@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91CB1DDF71
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 20:14:17 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6IADdVM010966
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 20:13:39 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6IAEGdm4694122
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 20:14:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6IAEGId018739
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 20:14:16 +1000
Date: Fri, 18 Jul 2008 15:41:33 +0530
From: Chirag Jog <chirag@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Message-ID: <20080718101133.GO20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1216325671.7740.359.camel@pasglop>
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2008-07-18 06:14:31]:

> 
> > All these operations are done assuming that tlb_gather_mmu disables
> > preemption and tlb_finish_mmu enables preemption again.
> > This is not true for -rt.
> > For x86, none of the code paths between tlb_gather_mmu and
> > tlb_finish_mmu access any per_cpu variables.
> > But this is not true for powerpc64 as we can see.
> > 
> > One way could be to make tlb_gather_mmu disable preemption as it does
> > in mainline but only for powerpc.
> > Although i am not sure, if this is the right step ahead.
> > 
> > I am attaching a patch below for the same.
> > I have left out the tce bits, as they are fine.
> > 
> > Note: I haven't extensively tested the patch
> 
> A better option is to make sure that a context switch does the right
> thing, flushing the pending batch. I think that's already the case,
> which means that your original patch may work, but that needs to
> be double-checked and commented properly.
> 
With the original patch, the pending batch does get flushed 
in a non-preemptable region. 
I am resending the original with just adding the necesary comments.

-Thanks,
        Chirag



Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>

Index: linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/tlb_64.c	2008-07-18 10:08:00.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c	2008-07-18 10:09:54.000000000 +0530
@@ -38,7 +38,6 @@
  * include/asm-powerpc/tlb.h file -- tgall
  */
 DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 unsigned long pte_freelist_forced_free;
 
 struct pte_freelist_batch
@@ -48,7 +47,7 @@
 	pgtable_free_t	tables[0];
 };
 
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+DEFINE_PER_CPU_LOCKED(struct pte_freelist_batch *, pte_freelist_cur);
 unsigned long pte_freelist_forced_free;
 
 #define PTE_FREELIST_SIZE \
@@ -92,24 +91,21 @@
 
 void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
 {
-	/*
-	 * This is safe since tlb_gather_mmu has disabled preemption.
-	 * tlb->cpu is set by tlb_gather_mmu as well.
-	 */
+	int cpu;
         cpumask_t local_cpumask = cpumask_of_cpu(tlb->cpu);
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
 		pgtable_free(pgf);
-		return;
+		goto cleanup;
 	}
 
 	if (*batchp == NULL) {
 		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
 		if (*batchp == NULL) {
 			pgtable_free_now(pgf);
-			return;
+			goto cleanup;
 		}
 		(*batchp)->index = 0;
 	}
@@ -118,6 +114,9 @@
 		pte_free_submit(*batchp);
 		*batchp = NULL;
 	}
+
+ cleanup:
+	put_cpu_var_locked(pte_freelist_cur, cpu);
 }
 
 /*
@@ -253,13 +252,15 @@
 
 void pte_free_finish(void)
 {
-	/* This is safe since tlb_gather_mmu has disabled preemption */
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+	int cpu;
+	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
 
-	if (*batchp == NULL)
-		return;
-	pte_free_submit(*batchp);
-	*batchp = NULL;
+	if (*batchp) {
+		pte_free_submit(*batchp);
+		*batchp = NULL;
+	}
+
+	put_cpu_var_locked(pte_freelist_cur, cpu);
 }
 
 /**
Index: linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h
===================================================================
--- linux-2.6.25.8-rt7.orig/include/asm-powerpc/tlb.h	2008-07-18 10:08:00.000000000 +0530
+++ linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h	2008-07-18 10:31:02.000000000 +0530
@@ -40,18 +40,20 @@
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
+	/* Disable preemption to ensure the pending TLB batch is flushed
+	 * before a potential context switch
+	 */
+	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
 
 	/* If there's a TLB batch pending, then we must flush it because the
 	 * pages are going to be freed and we really don't want to have a CPU
 	 * access a freed page because it has a stale TLB
 	 */
 	if (tlbbatch->index) {
-		preempt_disable();
 		__flush_tlb_pending(tlbbatch);
-		preempt_enable();
 	}
 
+	put_cpu_var(ppc64_tlb_batch);
 	pte_free_finish();
 }
 
Index: linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/platforms/pseries/iommu.c	2008-07-17 14:47:30.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c	2008-07-18 10:09:54.000000000 +0530
@@ -124,7 +124,7 @@
 	}
 }
 
-static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
+static DEFINE_PER_CPU_LOCKED(u64 *, tce_page) = NULL;
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -135,12 +135,13 @@
 	u64 *tcep;
 	u64 rpn;
 	long l, limit;
+	int cpu;
 
 	if (npages == 1)
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					   direction);
 
-	tcep = __get_cpu_var(tce_page);
+	tcep = get_cpu_var_locked(tce_page, &cpu);
 
 	/* This is safe to do since interrupts are off when we're called
 	 * from iommu_alloc{,_sg}()
@@ -148,10 +149,13 @@
 	if (!tcep) {
 		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
-		if (!tcep)
+		if (!tcep) {
+			put_cpu_var_locked(tce_page, cpu);
 			return tce_build_pSeriesLP(tbl, tcenum, npages,
 						   uaddr, direction);
-		__get_cpu_var(tce_page) = tcep;
+		}
+
+		per_cpu_var_locked(tce_page, cpu) = tcep;
 	}
 
 	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
@@ -188,6 +192,8 @@
 		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
+
+	put_cpu_var_locked(tce_page, cpu);
 }
 
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
