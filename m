Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABD54B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 00:17:19 +1000 (EST)
Message-ID: <4ABA2DE2.6000601@kernel.org>
Date: Wed, 23 Sep 2009 23:17:06 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
In-Reply-To: <4AB9DD8F.1040305@kernel.org>
Content-Type: multipart/mixed; boundary="------------000900040907070003040208"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000900040907070003040208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
>> One workaround i have found for this problem is to disable IPv6.
>> With IPv6 disabled the machine boots OK. Till a reliable solution
>> is available for this issue, i will keep IPv6 disabled in my configs.
> 
> I'm think it's most likely caused by some code accessing invalid
> percpu address.  I'm currently writing up access validator.  Should be
> done in several hours.  So, ipv6 it is.  I couldn't reproduce your
> problem here.  I'll give ipv6 a shot.

Can you please apply the attached patch and see whether anything
interesting shows up in the kernel log?

Thanks.

-- 
tejun

--------------000900040907070003040208
Content-Type: text/plain;
 name="pcpu-verify"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcpu-verify"

---
 arch/ia64/include/asm/sn/arch.h  |    4 -
 arch/powerpc/mm/stab.c           |    4 -
 arch/x86/kernel/cpu/cpu_debug.c  |   12 ++--
 arch/x86/kernel/cpu/perf_event.c |    4 -
 include/asm-generic/percpu.h     |   23 +++++---
 include/linux/percpu-defs.h      |    6 ++
 include/linux/percpu.h           |    7 ++
 kernel/softirq.c                 |    8 +-
 lib/Kconfig.debug                |   17 +++++
 mm/percpu.c                      |  112 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 173 insertions(+), 24 deletions(-)

Index: work/arch/ia64/include/asm/sn/arch.h
===================================================================
--- work.orig/arch/ia64/include/asm/sn/arch.h
+++ work/arch/ia64/include/asm/sn/arch.h
@@ -71,8 +71,8 @@ DECLARE_PER_CPU(struct sn_hub_info_s, __
  * Compact node ID to nasid mappings kept in the per-cpu data areas of each
  * cpu.
  */
-DECLARE_PER_CPU(short, __sn_cnodeid_to_nasid[MAX_COMPACT_NODES]);
-#define sn_cnodeid_to_nasid	(&__get_cpu_var(__sn_cnodeid_to_nasid[0]))
+DECLARE_PER_CPU(short [MAX_COMPACT_NODES], __sn_cnodeid_to_nasid);
+#define sn_cnodeid_to_nasid	(&__get_cpu_var(__sn_cnodeid_to_nasid)[0])
 
 
 extern u8 sn_partition_id;
Index: work/arch/powerpc/mm/stab.c
===================================================================
--- work.orig/arch/powerpc/mm/stab.c
+++ work/arch/powerpc/mm/stab.c
@@ -138,7 +138,7 @@ static int __ste_allocate(unsigned long
 	if (!is_kernel_addr(ea)) {
 		offset = __get_cpu_var(stab_cache_ptr);
 		if (offset < NR_STAB_CACHE_ENTRIES)
-			__get_cpu_var(stab_cache[offset++]) = stab_entry;
+			__get_cpu_var(stab_cache)[offset++] = stab_entry;
 		else
 			offset = NR_STAB_CACHE_ENTRIES+1;
 		__get_cpu_var(stab_cache_ptr) = offset;
@@ -185,7 +185,7 @@ void switch_stab(struct task_struct *tsk
 		int i;
 
 		for (i = 0; i < offset; i++) {
-			ste = stab + __get_cpu_var(stab_cache[i]);
+			ste = stab + __get_cpu_var(stab_cache)[i];
 			ste->esid_data = 0; /* invalidate entry */
 		}
 	} else {
Index: work/arch/x86/kernel/cpu/cpu_debug.c
===================================================================
--- work.orig/arch/x86/kernel/cpu/cpu_debug.c
+++ work/arch/x86/kernel/cpu/cpu_debug.c
@@ -531,7 +531,7 @@ static int cpu_create_file(unsigned cpu,
 
 	/* Already intialized */
 	if (file == CPU_INDEX_BIT)
-		if (per_cpu(cpu_arr[type].init, cpu))
+		if (per_cpu(cpu_arr, cpu)[type].init)
 			return 0;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -543,7 +543,7 @@ static int cpu_create_file(unsigned cpu,
 	priv->reg = reg;
 	priv->file = file;
 	mutex_lock(&cpu_debug_lock);
-	per_cpu(priv_arr[type], cpu) = priv;
+	per_cpu(priv_arr, cpu)[type] = priv;
 	per_cpu(cpu_priv_count, cpu)++;
 	mutex_unlock(&cpu_debug_lock);
 
@@ -552,10 +552,10 @@ static int cpu_create_file(unsigned cpu,
 				    dentry, (void *)priv, &cpu_fops);
 	else {
 		debugfs_create_file(cpu_base[type].name, S_IRUGO,
-				    per_cpu(cpu_arr[type].dentry, cpu),
+				    per_cpu(cpu_arr, cpu)[type].dentry,
 				    (void *)priv, &cpu_fops);
 		mutex_lock(&cpu_debug_lock);
-		per_cpu(cpu_arr[type].init, cpu) = 1;
+		per_cpu(cpu_arr, cpu)[type].init = 1;
 		mutex_unlock(&cpu_debug_lock);
 	}
 
@@ -615,7 +615,7 @@ static int cpu_init_allreg(unsigned cpu,
 		if (!is_typeflag_valid(cpu, cpu_base[type].flag))
 			continue;
 		cpu_dentry = debugfs_create_dir(cpu_base[type].name, dentry);
-		per_cpu(cpu_arr[type].dentry, cpu) = cpu_dentry;
+		per_cpu(cpu_arr, cpu)[type].dentry = cpu_dentry;
 
 		if (type < CPU_TSS_BIT)
 			err = cpu_init_msr(cpu, type, cpu_dentry);
@@ -677,7 +677,7 @@ static void __exit cpu_debug_exit(void)
 
 	for (cpu = 0; cpu <  nr_cpu_ids; cpu++)
 		for (i = 0; i < per_cpu(cpu_priv_count, cpu); i++)
-			kfree(per_cpu(priv_arr[i], cpu));
+			kfree(per_cpu(priv_arr, cpu)[i]);
 }
 
 module_init(cpu_debug_init);
Index: work/arch/x86/kernel/cpu/perf_event.c
===================================================================
--- work.orig/arch/x86/kernel/cpu/perf_event.c
+++ work/arch/x86/kernel/cpu/perf_event.c
@@ -1253,7 +1253,7 @@ x86_perf_event_set_period(struct perf_ev
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
+	per_cpu(pmc_prev_left, smp_processor_id())[idx] = left;
 
 	/*
 	 * The hw event starts counting from this event offset,
@@ -1470,7 +1470,7 @@ void perf_event_print_debug(void)
 		rdmsrl(x86_pmu.eventsel + idx, pmc_ctrl);
 		rdmsrl(x86_pmu.perfctr  + idx, pmc_count);
 
-		prev_left = per_cpu(pmc_prev_left[idx], cpu);
+		prev_left = per_cpu(pmc_prev_left, cpu)[idx];
 
 		pr_info("CPU#%d:   gen-PMC%d ctrl:  %016llx\n",
 			cpu, idx, pmc_ctrl);
Index: work/include/asm-generic/percpu.h
===================================================================
--- work.orig/include/asm-generic/percpu.h
+++ work/include/asm-generic/percpu.h
@@ -49,13 +49,22 @@ extern unsigned long __per_cpu_offset[NR
  * established ways to produce a usable pointer from the percpu variable
  * offset.
  */
-#define per_cpu(var, cpu) \
-	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), per_cpu_offset(cpu)))
-#define __get_cpu_var(var) \
-	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), my_cpu_offset))
-#define __raw_get_cpu_var(var) \
-	(*SHIFT_PERCPU_PTR(&per_cpu_var(var), __my_cpu_offset))
-
+#define per_cpu(var, cpu)	(*({					\
+	typeof(&per_cpu_var(var)) __pcpu_ptr__ = &per_cpu_var(var);	\
+	unsigned int __pcpu_cpu__ = (cpu);				\
+	pcpu_verify_access(__pcpu_ptr__, __pcpu_cpu__);			\
+	SHIFT_PERCPU_PTR(__pcpu_ptr__, per_cpu_offset(__pcpu_cpu__));	\
+}))
+#define __get_cpu_var(var)	(*({					\
+	typeof(&per_cpu_var(var)) __pcpu_ptr__ = &per_cpu_var(var);	\
+	pcpu_verify_access(__pcpu_ptr__, NR_CPUS);			\
+	SHIFT_PERCPU_PTR(__pcpu_ptr__, my_cpu_offset);			\
+}))
+#define __raw_get_cpu_var(var)	(*({					\
+	typeof(&per_cpu_var(var)) __pcpu_ptr__ = &per_cpu_var(var);	\
+	pcpu_verify_access(__pcpu_ptr__, NR_CPUS);			\
+	SHIFT_PERCPU_PTR(__pcpu_ptr__, __my_cpu_offset);		\
+}))
 
 #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 extern void setup_per_cpu_areas(void);
Index: work/include/linux/percpu-defs.h
===================================================================
--- work.orig/include/linux/percpu-defs.h
+++ work/include/linux/percpu-defs.h
@@ -7,6 +7,12 @@
  */
 #define per_cpu_var(var) per_cpu__##var
 
+#ifdef CONFIG_DEBUG_VERIFY_PER_CPU
+extern void pcpu_verify_access(void *ptr, unsigned int cpu);
+#else
+#define pcpu_verify_access(ptr, cpu)	do {} while (0)
+#endif
+
 /*
  * Base implementations of per-CPU variable declarations and definitions, where
  * the section in which the variable is to be placed is provided by the
Index: work/include/linux/percpu.h
===================================================================
--- work.orig/include/linux/percpu.h
+++ work/include/linux/percpu.h
@@ -127,7 +127,12 @@ extern int __init pcpu_page_first_chunk(
  * dynamically allocated. Non-atomic access to the current CPU's
  * version should probably be combined with get_cpu()/put_cpu().
  */
-#define per_cpu_ptr(ptr, cpu)	SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)))
+#define per_cpu_ptr(ptr, cpu)	({					\
+	typeof(ptr) __pcpu_ptr__ = (ptr);				\
+	unsigned int __pcpu_cpu__ = (cpu);				\
+	pcpu_verify_access(__pcpu_ptr__, __pcpu_cpu__);			\
+	SHIFT_PERCPU_PTR(__pcpu_ptr__, per_cpu_offset((__pcpu_cpu__)));	\
+})
 
 extern void *__alloc_reserved_percpu(size_t size, size_t align);
 
Index: work/kernel/softirq.c
===================================================================
--- work.orig/kernel/softirq.c
+++ work/kernel/softirq.c
@@ -560,7 +560,7 @@ EXPORT_PER_CPU_SYMBOL(softirq_work_list)
 
 static void __local_trigger(struct call_single_data *cp, int softirq)
 {
-	struct list_head *head = &__get_cpu_var(softirq_work_list[softirq]);
+	struct list_head *head = &__get_cpu_var(softirq_work_list)[softirq];
 
 	list_add_tail(&cp->list, head);
 
@@ -656,13 +656,13 @@ static int __cpuinit remote_softirq_cpu_
 
 		local_irq_disable();
 		for (i = 0; i < NR_SOFTIRQS; i++) {
-			struct list_head *head = &per_cpu(softirq_work_list[i], cpu);
+			struct list_head *head = &per_cpu(softirq_work_list, cpu)[i];
 			struct list_head *local_head;
 
 			if (list_empty(head))
 				continue;
 
-			local_head = &__get_cpu_var(softirq_work_list[i]);
+			local_head = &__get_cpu_var(softirq_work_list)[i];
 			list_splice_init(head, local_head);
 			raise_softirq_irqoff(i);
 		}
@@ -688,7 +688,7 @@ void __init softirq_init(void)
 		per_cpu(tasklet_hi_vec, cpu).tail =
 			&per_cpu(tasklet_hi_vec, cpu).head;
 		for (i = 0; i < NR_SOFTIRQS; i++)
-			INIT_LIST_HEAD(&per_cpu(softirq_work_list[i], cpu));
+			INIT_LIST_HEAD(&per_cpu(softirq_work_list, cpu)[i]);
 	}
 
 	register_hotcpu_notifier(&remote_softirq_cpu_notifier);
Index: work/lib/Kconfig.debug
===================================================================
--- work.orig/lib/Kconfig.debug
+++ work/lib/Kconfig.debug
@@ -805,6 +805,21 @@ config DEBUG_BLOCK_EXT_DEVT
 
 	  Say N if you are unsure.
 
+config DEBUG_VERIFY_PER_CPU
+	bool "Verify per-cpu accesses"
+	depends on DEBUG_KERNEL
+	depends on SMP
+	help
+
+	  This option makes percpu access macros to verify the
+	  specified processor and percpu variable offset on each
+	  access.  This helps catching percpu variable access bugs
+	  which may cause corruption on unrelated memory region making
+	  it very difficult to catch at the cost of making percpu
+	  accesses considerably slow.
+
+	  Say N if you are unsure.
+
 config DEBUG_FORCE_WEAK_PER_CPU
 	bool "Force weak per-cpu definitions"
 	depends on DEBUG_KERNEL
@@ -820,6 +835,8 @@ config DEBUG_FORCE_WEAK_PER_CPU
 	  To ensure that generic code follows the above rules, this
 	  option forces all percpu variables to be defined as weak.
 
+	  Say N if you are unsure.
+
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_KERNEL
Index: work/mm/percpu.c
===================================================================
--- work.orig/mm/percpu.c
+++ work/mm/percpu.c
@@ -1241,6 +1241,118 @@ void free_percpu(void *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
+#ifdef CONFIG_DEBUG_VERIFY_PER_CPU
+static struct pcpu_chunk *pcpu_verify_match_chunk(void *addr)
+{
+	void *first_start = pcpu_first_chunk->base_addr;
+	struct pcpu_chunk *chunk;
+	int slot;
+
+	/* is it in the first chunk? */
+	if (addr >= first_start && addr < first_start + pcpu_unit_size) {
+		/* is it in the reserved area? */
+		if (addr < first_start + pcpu_reserved_chunk_limit)
+			return pcpu_reserved_chunk;
+		return pcpu_first_chunk;
+	}
+
+	/* walk each dynamic chunk */
+	for (slot = 0; slot < pcpu_nr_slots; slot++)
+		list_for_each_entry(chunk, &pcpu_slot[slot], list)
+			if (addr >= chunk->base_addr &&
+			    addr < chunk->base_addr + pcpu_unit_size)
+				return chunk;
+	return NULL;
+}
+
+void pcpu_verify_access(void *ptr, unsigned int cpu)
+{
+	static bool verifying[NR_CPUS];
+	static int warn_limit = 10;
+	char cbuf[80], obuf[160];
+	void *addr = __pcpu_ptr_to_addr(ptr);
+	bool is_static = false;
+	struct pcpu_chunk *chunk;
+	unsigned long flags;
+	int i, addr_off, off, len, end;
+
+	/* not been initialized yet or whined enough already */
+	if (unlikely(!pcpu_first_chunk || !warn_limit))
+		return;
+
+	/* don't re-enter */
+	preempt_disable();
+	if (verifying[raw_smp_processor_id()]) {
+		preempt_enable_no_resched();
+		return;
+	}
+	verifying[raw_smp_processor_id()] = true;
+
+	cbuf[0] = '\0';
+	obuf[0] = '\0';
+
+	if (unlikely(cpu < NR_CPUS && !cpu_possible(cpu)) && warn_limit)
+		snprintf(cbuf, sizeof(cbuf), "invalid cpu %u", cpu);
+
+	/*
+	 * We can enter this function from weird places and have no
+	 * way to reliably avoid deadlock.  If lock is available, grab
+	 * it and verify.  If not, just let it go through.
+	 */
+	if (!spin_trylock_irqsave(&pcpu_lock, flags))
+		goto out;
+
+	chunk = pcpu_verify_match_chunk(addr);
+	if (!chunk) {
+		snprintf(obuf, sizeof(obuf),
+			 "no matching chunk ptr=%p addr=%p", ptr, addr);
+		goto out_unlock;
+	}
+
+	addr_off = addr - chunk->base_addr;
+	if (chunk->base_addr == pcpu_first_chunk->base_addr)
+		if (chunk == pcpu_reserved_chunk || addr_off < -chunk->map[0])
+			is_static = true;
+
+	for (i = 0, off = 0; i < chunk->map_used; i++, off = end) {
+		len = chunk->map[i];
+		end = off + abs(len);
+
+		if (addr_off == off) {
+			if (unlikely(len > 0))
+				snprintf(obuf, sizeof(obuf),
+					 "free area accessed ptr=%p addr=%p "
+					 "off=%d len=%d", ptr, addr, off, len);
+			break;
+		}
+		if (!is_static && off < addr_off && addr_off < end) {
+			snprintf(obuf, sizeof(obuf),
+				 "%sarea accessed in the middle ptr=%p "
+				 "addr=%p:%d off=%d len=%d",
+				 len > 0 ? "free " : "",
+				 ptr, addr, addr_off, off, abs(len));
+			break;
+		}
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&pcpu_lock, flags);
+out:
+	if (unlikely(cbuf[0] || obuf[0])) {
+		printk(KERN_ERR "PERCPU: %s%s%s\n",
+		       cbuf, cbuf[0] ? ", " : "", obuf);
+		dump_stack();
+		if (!--warn_limit)
+			printk(KERN_WARNING "PERCPU: access warning limit "
+			       "reached, turning off access validation\n");
+	}
+
+	verifying[raw_smp_processor_id()] = false;
+	preempt_enable_no_resched();
+}
+EXPORT_SYMBOL_GPL(pcpu_verify_access);
+#endif	/* CONFIG_DEBUG_VERIFY_PER_CPU */
+
 static inline size_t pcpu_calc_fc_sizes(size_t static_size,
 					size_t reserved_size,
 					ssize_t *dyn_sizep)

--------------000900040907070003040208--
