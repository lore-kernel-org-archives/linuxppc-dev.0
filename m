Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qq8d1t8FzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 18:49:53 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id e185-v6so10898531ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:49:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526977424-25243-1-git-send-email-kernelfans@gmail.com>
References: <1526977424-25243-1-git-send-email-kernelfans@gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 22 May 2018 16:49:50 +0800
Message-ID: <CAFgQCTu9YGqM+SD48UuhJK4O8Ch+9fZYMen6ReRkTtf81gHpGA@mail.gmail.com>
Subject: Re: [PATCH v6 (proposal)] powerpc/cpu: enable nr_cpus for crash kernel
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I had tested this patch for P9/P8/ guest on powerKVM and powerVM. All
of them works fine.

On Tue, May 22, 2018 at 4:23 PM, Pingfan Liu <kernelfans@gmail.com> wrote:
> For kexec -p, the boot cpu can be not the cpu0, this causes the problem
> to alloc paca[]. In theory, there is no requirement to assign cpu's logical
> id as its present seq by device tree. But we have something like
> cpu_first_thread_sibling(), which makes assumption on the mapping inside
> a core. Hence partially changing the mapping, i.e. unbind the mapping of
> core while keep the mapping inside a core. After this patch, the core with
> boot-cpu will always be mapped into core 0.
>
> And at present, the code to discovery cpu spreads over two functions:
> early_init_dt_scan_cpus() and smp_setup_cpu_maps().
> This patch tries to fold smp_setup_cpu_maps() into the "previous" one
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
> v5 -> v6:
>   simplify the loop logic (Hope it can answer Benjamin's concern)
>   concentrate the cpu recovery code to early stage (Hope it can answer Michael's concern)
> Todo: (if this method is accepted)
>   fold the whole smp_setup_cpu_maps()
>
>  arch/powerpc/include/asm/smp.h     |   1 +
>  arch/powerpc/kernel/prom.c         | 123 ++++++++++++++++++++++++++++---------
>  arch/powerpc/kernel/setup-common.c |  58 ++---------------
>  drivers/of/fdt.c                   |   2 +-
>  include/linux/of_fdt.h             |   2 +
>  5 files changed, 103 insertions(+), 83 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index fac963e..80c7693 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -30,6 +30,7 @@
>  #include <asm/percpu.h>
>
>  extern int boot_cpuid;
> +extern int threads_in_core;
>  extern int spinning_secondaries;
>
>  extern void cpu_die(void);
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4922162..2ae0b4a 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -77,7 +77,6 @@ unsigned long tce_alloc_start, tce_alloc_end;
>  u64 ppc64_rma_size;
>  #endif
>  static phys_addr_t first_memblock_size;
> -static int __initdata boot_cpu_count;
>
>  static int __init early_parse_mem(char *p)
>  {
> @@ -305,6 +304,14 @@ static void __init check_cpu_feature_properties(unsigned long node)
>         }
>  }
>
> +struct bootinfo {
> +       int boot_thread_id;
> +       unsigned int cpu_cnt;
> +       int cpu_hwids[NR_CPUS];
> +       bool avail[NR_CPUS];
> +};
> +static struct bootinfo *bt_info;
> +
>  static int __init early_init_dt_scan_cpus(unsigned long node,
>                                           const char *uname, int depth,
>                                           void *data)
> @@ -312,10 +319,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>         const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>         const __be32 *prop;
>         const __be32 *intserv;
> -       int i, nthreads;
> +       int i, nthreads, maxidx;
>         int len;
> -       int found = -1;
> -       int found_thread = 0;
> +       int found_thread = -1;
> +       struct bootinfo *info = data;
> +       bool avail;
> +       int rotate_cnt, id;
>
>         /* We are scanning "cpu" nodes only */
>         if (type == NULL || strcmp(type, "cpu") != 0)
> @@ -325,8 +334,15 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>         intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
>         if (!intserv)
>                 intserv = of_get_flat_dt_prop(node, "reg", &len);
> +       avail = of_fdt_device_is_available(initial_boot_params, node);
> +#if 0
> +       //todo
> +       if (!avail)
> +               avail = !of_fdt_property_match_string(node,
> +                                       "enable-method", "spin-table");
> +#endif
>
> -       nthreads = len / sizeof(int);
> +       threads_in_core = nthreads = len / sizeof(int);
>
>         /*
>          * Now see if any of these threads match our boot cpu.
> @@ -338,9 +354,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>                  * booted proc.
>                  */
>                 if (fdt_version(initial_boot_params) >= 2) {
> +                       info->cpu_hwids[info->cpu_cnt] =
> +                                       be32_to_cpu(intserv[i]);
>                         if (be32_to_cpu(intserv[i]) ==
>                             fdt_boot_cpuid_phys(initial_boot_params)) {
> -                               found = boot_cpu_count;
>                                 found_thread = i;
>                         }
>                 } else {
> @@ -351,22 +368,37 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>                          */
>                         if (of_get_flat_dt_prop(node,
>                                         "linux,boot-cpu", NULL) != NULL)
> -                               found = boot_cpu_count;
> +                               found_thread = info->cpu_cnt;
>                 }
> +               info->avail[info->cpu_cnt] = avail;
> +
>  #ifdef CONFIG_SMP
>                 /* logical cpu id is always 0 on UP kernels */
> -               boot_cpu_count++;
> +               info->cpu_cnt++;
>  #endif
>         }
>
>         /* Not the boot CPU */
> -       if (found < 0)
> +       if (found_thread < 0)
>                 return 0;
>
> -       DBG("boot cpu: logical %d physical %d\n", found,
> +       /* always mapping boot-core to core 0 to cope with kexec -p */
> +       maxidx = info->cpu_cnt - 1;
> +       rotate_cnt = nthreads;
> +       while (rotate_cnt-- > 0) {
> +               avail = info->avail[maxidx];
> +               id = info->cpu_hwids[maxidx];
> +               for (i = maxidx; i > 0; i--) {
> +                       info->avail[i] = info->avail[i - 1];
> +                       info->cpu_hwids[i] = info->cpu_hwids[i - 1];
> +               }
> +               info->avail[i] = avail;
> +               info->cpu_hwids[i] = id;
> +       }
> +
> +       info->boot_thread_id = found_thread;
> +       DBG("boot cpu: logical %d physical %d\n", found_thread,
>             be32_to_cpu(intserv[found_thread]));
> -       boot_cpuid = found;
> -       set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
>
>         /*
>          * PAPR defines "logical" PVR values for cpus that
> @@ -675,6 +707,55 @@ static void __init tm_init(void)
>  static void tm_init(void) { }
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>
> +static void early_setup_cpu_mapping(void)
> +{
> +       unsigned int cpu, cnt;
> +       int nr_cpus_aligned;
> +
> +       bt_info = __va(memblock_alloc(sizeof(struct bootinfo),
> +                       sizeof(unsigned long)));
> +       memset(bt_info, 0, sizeof(struct bootinfo));
> +       bt_info->boot_thread_id = -1;
> +       /* Retrieve CPU related informations from the flat tree
> +        * (altivec support, boot CPU ID, ...)
> +        */
> +       of_scan_flat_dt(early_init_dt_scan_cpus, bt_info);
> +
> +       if (bt_info->boot_thread_id < 0) {
> +               pr_err("Failed to identify boot CPU !\n");
> +               BUG();
> +       }
> +
> +       boot_cpuid = bt_info->boot_thread_id;
> +       /* work around subcore mode */
> +       nr_cpus_aligned = _ALIGN_UP(nr_cpu_ids, threads_in_core);
> +       if (nr_cpus_aligned != nr_cpu_ids) {
> +               pr_info("nr_cpus is forced to be aligned up from: %d to: %d\n",
> +                       nr_cpu_ids, nr_cpus_aligned);
> +               nr_cpu_ids = nr_cpus_aligned;
> +       }
> +       cnt = (nr_cpu_ids < bt_info->cpu_cnt) ? nr_cpu_ids
> +                       : bt_info->cpu_cnt;
> +
> +       allocate_pacas();
> +       for (cpu = 0; cpu < cnt; cpu++) {
> +               set_cpu_present(cpu, bt_info->avail[cpu]);
> +               DBG("set cpu present: %d -> hwid:%d\n",
> +                       cpu, bt_info->cpu_hwids[cpu]);
> +               set_hard_smp_processor_id(cpu, bt_info->cpu_hwids[cpu]);
> +               set_cpu_possible(cpu, true);
> +       }
> +
> +#if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
> +       /* We'll later wait for secondaries to check in; there are
> +        * NCPUS-1 non-boot CPUs  :-)
> +        */
> +       spinning_secondaries = bt_info->cpu_cnt - 1;
> +#endif
> +       memblock_free(__pa(bt_info), sizeof(struct bootinfo));
> +       bt_info = NULL;
> +}
> +
>  void __init early_init_devtree(void *params)
>  {
>         phys_addr_t limit;
> @@ -745,27 +826,11 @@ void __init early_init_devtree(void *params)
>          * FIXME .. and the initrd too? */
>         move_device_tree();
>
> -       allocate_pacas();
> -
>         DBG("Scanning CPUs ...\n");
>
>         dt_cpu_ftrs_scan();
>
> -       /* Retrieve CPU related informations from the flat tree
> -        * (altivec support, boot CPU ID, ...)
> -        */
> -       of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
> -       if (boot_cpuid < 0) {
> -               printk("Failed to identify boot CPU !\n");
> -               BUG();
> -       }
> -
> -#if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
> -       /* We'll later wait for secondaries to check in; there are
> -        * NCPUS-1 non-boot CPUs  :-)
> -        */
> -       spinning_secondaries = boot_cpu_count - 1;
> -#endif
> +       early_setup_cpu_mapping();
>
>         mmu_early_init_devtree();
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 66f7cc6..46d034a 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -86,7 +86,9 @@ struct machdep_calls *machine_id;
>  EXPORT_SYMBOL(machine_id);
>
>  int boot_cpuid = -1;
> +int threads_in_core = 1;
>  EXPORT_SYMBOL_GPL(boot_cpuid);
> +EXPORT_SYMBOL_GPL(threads_in_core);
>
>  /*
>   * These are used in binfmt_elf.c to put aux entries on the stack
> @@ -460,61 +462,11 @@ void __init smp_setup_cpu_maps(void)
>  {
>         struct device_node *dn;
>         int cpu = 0;
> -       int nthreads = 1;
> -
> -       DBG("smp_setup_cpu_maps()\n");
> -
> -       for_each_node_by_type(dn, "cpu") {
> -               const __be32 *intserv;
> -               __be32 cpu_be;
> -               int j, len;
> -
> -               DBG("  * %pOF...\n", dn);
> -
> -               intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s",
> -                               &len);
> -               if (intserv) {
> -                       DBG("    ibm,ppc-interrupt-server#s -> %d threads\n",
> -                           nthreads);
> -               } else {
> -                       DBG("    no ibm,ppc-interrupt-server#s -> 1 thread\n");
> -                       intserv = of_get_property(dn, "reg", &len);
> -                       if (!intserv) {
> -                               cpu_be = cpu_to_be32(cpu);
> -                               intserv = &cpu_be;      /* assume logical == phys */
> -                               len = 4;
> -                       }
> -               }
> -
> -               nthreads = len / sizeof(int);
> -
> -               for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
> -                       bool avail;
> -
> -                       DBG("    thread %d -> cpu %d (hard id %d)\n",
> -                           j, cpu, be32_to_cpu(intserv[j]));
> -
> -                       avail = of_device_is_available(dn);
> -                       if (!avail)
> -                               avail = !of_property_match_string(dn,
> -                                               "enable-method", "spin-table");
> -
> -                       set_cpu_present(cpu, avail);
> -                       set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
> -                       set_cpu_possible(cpu, true);
> -                       cpu++;
> -               }
> -
> -               if (cpu >= nr_cpu_ids) {
> -                       of_node_put(dn);
> -                       break;
> -               }
> -       }
>
>         /* If no SMT supported, nthreads is forced to 1 */
>         if (!cpu_has_feature(CPU_FTR_SMT)) {
>                 DBG("  SMT disabled ! nthreads forced to 1\n");
> -               nthreads = 1;
> +               threads_in_core = 1;
>         }
>
>  #ifdef CONFIG_PPC64
> @@ -539,7 +491,7 @@ void __init smp_setup_cpu_maps(void)
>
>                 /* Double maxcpus for processors which have SMT capability */
>                 if (cpu_has_feature(CPU_FTR_SMT))
> -                       maxcpus *= nthreads;
> +                       maxcpus *= threads_in_core;
>
>                 if (maxcpus > nr_cpu_ids) {
>                         printk(KERN_WARNING
> @@ -565,7 +517,7 @@ void __init smp_setup_cpu_maps(void)
>          * every CPU in the system. If that is not the case, then some code
>          * here will have to be reworked
>          */
> -       cpu_init_thread_core_maps(nthreads);
> +       cpu_init_thread_core_maps(threads_in_core);
>
>         /* Now that possible cpus are set, set nr_cpu_ids for later use */
>         setup_nr_cpu_ids();
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 84aa9d6..16d6b02 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -130,7 +130,7 @@ bool of_fdt_is_big_endian(const void *blob, unsigned long node)
>         return false;
>  }
>
> -static bool of_fdt_device_is_available(const void *blob, unsigned long node)
> +bool of_fdt_device_is_available(const void *blob, unsigned long node)
>  {
>         const char *status = fdt_getprop(blob, node, "status", NULL);
>
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index b9cd9eb..28756c5 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -30,6 +30,8 @@ extern void *of_fdt_get_property(const void *blob,
>                                  int *size);
>  extern bool of_fdt_is_big_endian(const void *blob,
>                                  unsigned long node);
> +extern bool of_fdt_device_is_available(const void *blob,
> +                       unsigned long node);
>  extern int of_fdt_match(const void *blob, unsigned long node,
>                         const char *const *compat);
>  extern void *of_fdt_unflatten_tree(const unsigned long *blob,
> --
> 2.7.4
>
