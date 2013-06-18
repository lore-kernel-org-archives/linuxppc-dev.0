Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 487DF2C02F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 06:22:56 +1000 (EST)
Message-ID: <51C0C1BC.90207@windriver.com>
Date: Tue, 18 Jun 2013 16:23:24 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete __cpuinit usage from all users
References: <1371499802-26262-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1371499802-26262-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13-06-17 04:10 PM, Paul Gortmaker wrote:
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
> 
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
> 
> This removes all the powerpc uses of the __cpuinit macros.

I see I missed a couple with a too limited regex.  I'll resend a v2
shortly.  It is up to you guys whether you want to carry this in the
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git#next
repo, or have me keep it with the arch independent __cpuinit removal
changes.  In mips for example, Ralf expected some significant tree
churn still pending and wanted to handle the conflicts himself, so
he took the mips chunk in his tree.

Thanks,
P.
--

> 
> [1] https://lkml.org/lkml/2013/5/20/589
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [This was generated against today's linux-next tree ; I'm assuming all
>  pending powerpc changes are in there currently.]
> 
>  arch/powerpc/include/asm/rtas.h        |  4 ++--
>  arch/powerpc/include/asm/vdso.h        |  2 +-
>  arch/powerpc/kernel/cacheinfo.c        | 19 +++++++++++--------
>  arch/powerpc/kernel/rtas.c             |  4 ++--
>  arch/powerpc/kernel/smp.c              |  2 +-
>  arch/powerpc/kernel/sysfs.c            |  6 +++---
>  arch/powerpc/kernel/time.c             |  1 -
>  arch/powerpc/kernel/vdso.c             |  2 +-
>  arch/powerpc/mm/44x_mmu.c              |  6 +++---
>  arch/powerpc/mm/hash_utils_64.c        |  2 +-
>  arch/powerpc/mm/mmu_context_nohash.c   |  6 +++---
>  arch/powerpc/mm/numa.c                 |  7 +++----
>  arch/powerpc/mm/tlb_nohash.c           |  2 +-
>  arch/powerpc/perf/core-book3s.c        |  4 ++--
>  arch/powerpc/platforms/44x/currituck.c |  4 ++--
>  arch/powerpc/platforms/44x/iss4xx.c    |  4 ++--
>  arch/powerpc/platforms/85xx/smp.c      |  6 +++---
>  arch/powerpc/platforms/powermac/smp.c  |  2 +-
>  arch/powerpc/platforms/powernv/smp.c   |  2 +-
>  19 files changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 34fd704..c7a8bfc 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -350,8 +350,8 @@ static inline u32 rtas_config_addr(int busno, int devfn, int reg)
>  			(devfn << 8) | (reg & 0xff);
>  }
>  
> -extern void __cpuinit rtas_give_timebase(void);
> -extern void __cpuinit rtas_take_timebase(void);
> +extern void rtas_give_timebase(void);
> +extern void rtas_take_timebase(void);
>  
>  #ifdef CONFIG_PPC_RTAS
>  static inline int page_is_rtas_user_buf(unsigned long pfn)
> diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
> index 50f261b..0d9cecd 100644
> --- a/arch/powerpc/include/asm/vdso.h
> +++ b/arch/powerpc/include/asm/vdso.h
> @@ -22,7 +22,7 @@ extern unsigned long vdso64_rt_sigtramp;
>  extern unsigned long vdso32_sigtramp;
>  extern unsigned long vdso32_rt_sigtramp;
>  
> -int __cpuinit vdso_getcpu_init(void);
> +int vdso_getcpu_init(void);
>  
>  #else /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index 92c6b00..ddaecb1 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -131,7 +131,8 @@ static const char *cache_type_string(const struct cache *cache)
>  	return cache_type_info[cache->type].name;
>  }
>  
> -static void __cpuinit cache_init(struct cache *cache, int type, int level, struct device_node *ofnode)
> +static void cache_init(struct cache *cache, int type, int level,
> +		       struct device_node *ofnode)
>  {
>  	cache->type = type;
>  	cache->level = level;
> @@ -385,7 +386,7 @@ static struct cache *__cpuinit cache_lookup_or_instantiate(struct device_node *n
>  	return cache;
>  }
>  
> -static void __cpuinit link_cache_lists(struct cache *smaller, struct cache *bigger)
> +static void link_cache_lists(struct cache *smaller, struct cache *bigger)
>  {
>  	while (smaller->next_local) {
>  		if (smaller->next_local == bigger)
> @@ -396,13 +397,13 @@ static void __cpuinit link_cache_lists(struct cache *smaller, struct cache *bigg
>  	smaller->next_local = bigger;
>  }
>  
> -static void __cpuinit do_subsidiary_caches_debugcheck(struct cache *cache)
> +static void do_subsidiary_caches_debugcheck(struct cache *cache)
>  {
>  	WARN_ON_ONCE(cache->level != 1);
>  	WARN_ON_ONCE(strcmp(cache->ofnode->type, "cpu"));
>  }
>  
> -static void __cpuinit do_subsidiary_caches(struct cache *cache)
> +static void do_subsidiary_caches(struct cache *cache)
>  {
>  	struct device_node *subcache_node;
>  	int level = cache->level;
> @@ -653,7 +654,7 @@ static struct kobj_type cache_index_type = {
>  	.default_attrs = cache_index_default_attrs,
>  };
>  
> -static void __cpuinit cacheinfo_create_index_opt_attrs(struct cache_index_dir *dir)
> +static void cacheinfo_create_index_opt_attrs(struct cache_index_dir *dir)
>  {
>  	const char *cache_name;
>  	const char *cache_type;
> @@ -696,7 +697,8 @@ static void __cpuinit cacheinfo_create_index_opt_attrs(struct cache_index_dir *d
>  	kfree(buf);
>  }
>  
> -static void __cpuinit cacheinfo_create_index_dir(struct cache *cache, int index, struct cache_dir *cache_dir)
> +static void cacheinfo_create_index_dir(struct cache *cache, int index,
> +				       struct cache_dir *cache_dir)
>  {
>  	struct cache_index_dir *index_dir;
>  	int rc;
> @@ -722,7 +724,8 @@ err:
>  	kfree(index_dir);
>  }
>  
> -static void __cpuinit cacheinfo_sysfs_populate(unsigned int cpu_id, struct cache *cache_list)
> +static void cacheinfo_sysfs_populate(unsigned int cpu_id,
> +				     struct cache *cache_list)
>  {
>  	struct cache_dir *cache_dir;
>  	struct cache *cache;
> @@ -740,7 +743,7 @@ static void __cpuinit cacheinfo_sysfs_populate(unsigned int cpu_id, struct cache
>  	}
>  }
>  
> -void __cpuinit cacheinfo_cpu_online(unsigned int cpu_id)
> +void cacheinfo_cpu_online(unsigned int cpu_id)
>  {
>  	struct cache *cache;
>  
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 52add6f..80b5ef4 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1172,7 +1172,7 @@ int __init early_init_dt_scan_rtas(unsigned long node,
>  static arch_spinlock_t timebase_lock;
>  static u64 timebase = 0;
>  
> -void __cpuinit rtas_give_timebase(void)
> +void rtas_give_timebase(void)
>  {
>  	unsigned long flags;
>  
> @@ -1189,7 +1189,7 @@ void __cpuinit rtas_give_timebase(void)
>  	local_irq_restore(flags);
>  }
>  
> -void __cpuinit rtas_take_timebase(void)
> +void rtas_take_timebase(void)
>  {
>  	while (!timebase)
>  		barrier();
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index ee7ac5e..d6f42dc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -480,7 +480,7 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
>  	secondary_ti = current_set[cpu] = ti;
>  }
>  
> -int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
>  	int rc, c;
>  
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index e68a845..27a90b9 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -341,7 +341,7 @@ static struct device_attribute pa6t_attrs[] = {
>  #endif /* HAS_PPC_PMC_PA6T */
>  #endif /* HAS_PPC_PMC_CLASSIC */
>  
> -static void __cpuinit register_cpu_online(unsigned int cpu)
> +static void register_cpu_online(unsigned int cpu)
>  {
>  	struct cpu *c = &per_cpu(cpu_devices, cpu);
>  	struct device *s = &c->dev;
> @@ -502,7 +502,7 @@ ssize_t arch_cpu_release(const char *buf, size_t count)
>  
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> -static int __cpuinit sysfs_cpu_notify(struct notifier_block *self,
> +static int sysfs_cpu_notify(struct notifier_block *self,
>  				      unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (unsigned int)(long)hcpu;
> @@ -522,7 +522,7 @@ static int __cpuinit sysfs_cpu_notify(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> -static struct notifier_block __cpuinitdata sysfs_cpu_nb = {
> +static struct notifier_block sysfs_cpu_nb = {
>  	.notifier_call	= sysfs_cpu_notify,
>  };
>  
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 5fc29ad..65ab9e9 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -631,7 +631,6 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
>  	return found;
>  }
>  
> -/* should become __cpuinit when secondary_cpu_time_init also is */
>  void start_cpu_decrementer(void)
>  {
>  #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index d4f463a..1d9c926 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -711,7 +711,7 @@ static void __init vdso_setup_syscall_map(void)
>  }
>  
>  #ifdef CONFIG_PPC64
> -int __cpuinit vdso_getcpu_init(void)
> +int vdso_getcpu_init(void)
>  {
>  	unsigned long cpu, node, val;
>  
> diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
> index 2c9441e..82b1ff7 100644
> --- a/arch/powerpc/mm/44x_mmu.c
> +++ b/arch/powerpc/mm/44x_mmu.c
> @@ -41,7 +41,7 @@ int icache_44x_need_flush;
>  
>  unsigned long tlb_47x_boltmap[1024/8];
>  
> -static void __cpuinit ppc44x_update_tlb_hwater(void)
> +static void ppc44x_update_tlb_hwater(void)
>  {
>  	extern unsigned int tlb_44x_patch_hwater_D[];
>  	extern unsigned int tlb_44x_patch_hwater_I[];
> @@ -134,7 +134,7 @@ static void __init ppc47x_update_boltmap(void)
>  /*
>   * "Pins" a 256MB TLB entry in AS0 for kernel lowmem for 47x type MMU
>   */
> -static void __cpuinit ppc47x_pin_tlb(unsigned int virt, unsigned int phys)
> +static void ppc47x_pin_tlb(unsigned int virt, unsigned int phys)
>  {
>  	unsigned int rA;
>  	int bolted;
> @@ -229,7 +229,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  }
>  
>  #ifdef CONFIG_SMP
> -void __cpuinit mmu_init_secondary(int cpu)
> +void mmu_init_secondary(int cpu)
>  {
>  	unsigned long addr;
>  	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index e303a6d..4481172 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -807,7 +807,7 @@ void __init early_init_mmu(void)
>  }
>  
>  #ifdef CONFIG_SMP
> -void __cpuinit early_init_mmu_secondary(void)
> +void early_init_mmu_secondary(void)
>  {
>  	/* Initialize hash table for that CPU */
>  	if (!firmware_has_feature(FW_FEATURE_LPAR))
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index e779642..0f149b9 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -329,8 +329,8 @@ void destroy_context(struct mm_struct *mm)
>  
>  #ifdef CONFIG_SMP
>  
> -static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
> -					    unsigned long action, void *hcpu)
> +static int mmu_context_cpu_notify(struct notifier_block *self,
> +				  unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (unsigned int)(long)hcpu;
>  
> @@ -363,7 +363,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> -static struct notifier_block __cpuinitdata mmu_context_cpu_nb = {
> +static struct notifier_block mmu_context_cpu_nb = {
>  	.notifier_call	= mmu_context_cpu_notify,
>  };
>  
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 88c0425..c792cd9 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -516,7 +516,7 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
>   * Figure out to which domain a cpu belongs and stick it there.
>   * Return the id of the domain used.
>   */
> -static int __cpuinit numa_setup_cpu(unsigned long lcpu)
> +static int numa_setup_cpu(unsigned long lcpu)
>  {
>  	int nid = 0;
>  	struct device_node *cpu = of_get_cpu_node(lcpu, NULL);
> @@ -538,8 +538,7 @@ out:
>  	return nid;
>  }
>  
> -static int __cpuinit cpu_numa_callback(struct notifier_block *nfb,
> -			     unsigned long action,
> +static int cpu_numa_callback(struct notifier_block *nfb, unsigned long action,
>  			     void *hcpu)
>  {
>  	unsigned long lcpu = (unsigned long)hcpu;
> @@ -919,7 +918,7 @@ static void __init *careful_zallocation(int nid, unsigned long size,
>  	return ret;
>  }
>  
> -static struct notifier_block __cpuinitdata ppc64_numa_nb = {
> +static struct notifier_block ppc64_numa_nb = {
>  	.notifier_call = cpu_numa_callback,
>  	.priority = 1 /* Must run before sched domains notifier. */
>  };
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index 6888cad..41cd68d 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -648,7 +648,7 @@ void __init early_init_mmu(void)
>  	__early_init_mmu(1);
>  }
>  
> -void __cpuinit early_init_mmu_secondary(void)
> +void early_init_mmu_secondary(void)
>  {
>  	__early_init_mmu(0);
>  }
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 29c6482..af94a71 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1786,7 +1786,7 @@ static void power_pmu_setup(int cpu)
>  	cpuhw->mmcr[0] = MMCR0_FC;
>  }
>  
> -static int __cpuinit
> +static int
>  power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (long)hcpu;
> @@ -1803,7 +1803,7 @@ power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu
>  	return NOTIFY_OK;
>  }
>  
> -int __cpuinit register_power_pmu(struct power_pmu *pmu)
> +int register_power_pmu(struct power_pmu *pmu)
>  {
>  	if (ppmu)
>  		return -EBUSY;		/* something's already registered */
> diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
> index ecd3890..9cef9d3 100644
> --- a/arch/powerpc/platforms/44x/currituck.c
> +++ b/arch/powerpc/platforms/44x/currituck.c
> @@ -91,12 +91,12 @@ static void __init ppc47x_init_irq(void)
>  }
>  
>  #ifdef CONFIG_SMP
> -static void __cpuinit smp_ppc47x_setup_cpu(int cpu)
> +static void smp_ppc47x_setup_cpu(int cpu)
>  {
>  	mpic_setup_this_cpu();
>  }
>  
> -static int __cpuinit smp_ppc47x_kick_cpu(int cpu)
> +static int smp_ppc47x_kick_cpu(int cpu)
>  {
>  	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
>  	const u64 *spin_table_addr_prop;
> diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
> index a28a862..4241bc8 100644
> --- a/arch/powerpc/platforms/44x/iss4xx.c
> +++ b/arch/powerpc/platforms/44x/iss4xx.c
> @@ -81,12 +81,12 @@ static void __init iss4xx_init_irq(void)
>  }
>  
>  #ifdef CONFIG_SMP
> -static void __cpuinit smp_iss4xx_setup_cpu(int cpu)
> +static void smp_iss4xx_setup_cpu(int cpu)
>  {
>  	mpic_setup_this_cpu();
>  }
>  
> -static int __cpuinit smp_iss4xx_kick_cpu(int cpu)
> +static int smp_iss4xx_kick_cpu(int cpu)
>  {
>  	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
>  	const u64 *spin_table_addr_prop;
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 6a17599..5ced4f5 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -99,7 +99,7 @@ static void mpc85xx_take_timebase(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -static void __cpuinit smp_85xx_mach_cpu_die(void)
> +static void smp_85xx_mach_cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	u32 tmp;
> @@ -141,7 +141,7 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
>  	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
>  }
>  
> -static int __cpuinit smp_85xx_kick_cpu(int nr)
> +static int smp_85xx_kick_cpu(int nr)
>  {
>  	unsigned long flags;
>  	const u64 *cpu_rel_addr;
> @@ -362,7 +362,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
>  }
>  #endif /* CONFIG_KEXEC */
>  
> -static void __cpuinit smp_85xx_setup_cpu(int cpu_nr)
> +static void smp_85xx_setup_cpu(int cpu_nr)
>  {
>  	if (smp_85xx_ops.probe == smp_mpic_probe)
>  		mpic_setup_this_cpu();
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index f921067..5cbd4d6 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -885,7 +885,7 @@ static int smp_core99_cpu_notify(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> -static struct notifier_block __cpuinitdata smp_core99_cpu_nb = {
> +static struct notifier_block smp_core99_cpu_nb = {
>  	.notifier_call	= smp_core99_cpu_notify,
>  };
>  #endif /* CONFIG_HOTPLUG_CPU */
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 88c9459..c22b2b3 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -40,7 +40,7 @@
>  #define DBG(fmt...)
>  #endif
>  
> -static void __cpuinit pnv_smp_setup_cpu(int cpu)
> +static void pnv_smp_setup_cpu(int cpu)
>  {
>  	if (cpu != boot_cpuid)
>  		xics_setup_cpu();
> 
