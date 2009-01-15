Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id F1762DE2C3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 18:25:33 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so388678ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 23:25:32 -0800 (PST)
Message-ID: <fa686aa40901142325w21801911q6684211de4ba3e6e@mail.gmail.com>
Date: Thu, 15 Jan 2009 00:25:32 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Michael Ellerman" <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Replace ppc_md.progress() uses with
	ppc_progress()
In-Reply-To: <94dcfe83586ea8e762fcd76b8351d20fd348af83.1232001793.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
	<94dcfe83586ea8e762fcd76b8351d20fd348af83.1232001793.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 14, 2009 at 11:43 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/powerpc/kernel/setup_32.c                    |   11 +++++------
>  arch/powerpc/mm/init_32.c                         |   15 +++++----------
>  arch/powerpc/mm/ppc_mmu_32.c                      |    8 ++++----
>  arch/powerpc/platforms/52xx/efika.c               |    3 +--
>  arch/powerpc/platforms/52xx/lite5200.c            |    3 +--
>  arch/powerpc/platforms/52xx/mpc5200_simple.c      |    3 +--
>  arch/powerpc/platforms/82xx/ep8248e.c             |    6 ++----
>  arch/powerpc/platforms/82xx/mgcoge.c              |    6 ++----
>  arch/powerpc/platforms/82xx/mpc8272_ads.c         |    6 ++----
>  arch/powerpc/platforms/82xx/pq2fads.c             |    6 ++----
>  arch/powerpc/platforms/83xx/asp834x.c             |    3 +--
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc832x_mds.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc834x_itx.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc834x_mds.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc836x_mds.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc837x_mds.c         |    3 +--
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c         |    3 +--
>  arch/powerpc/platforms/83xx/sbc834x.c             |    3 +--
>  arch/powerpc/platforms/85xx/ksi8560.c             |    3 +--
>  arch/powerpc/platforms/85xx/mpc8536_ds.c          |    3 +--
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    3 +--
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   13 +++++--------
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c          |    3 +--
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    3 +--
>  arch/powerpc/platforms/85xx/sbc8548.c             |    3 +--
>  arch/powerpc/platforms/85xx/sbc8560.c             |    3 +--
>  arch/powerpc/platforms/85xx/stx_gp3.c             |    3 +--
>  arch/powerpc/platforms/85xx/tqm85xx.c             |    3 +--
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c        |    3 +--
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    3 +--
>  arch/powerpc/platforms/86xx/sbc8641d.c            |    3 +--
>  arch/powerpc/platforms/chrp/setup.c               |    5 ++---
>  arch/powerpc/platforms/embedded6xx/holly.c        |    6 ++----
>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    7 +++----
>  arch/powerpc/platforms/powermac/smp.c             |   18 ++++++++----------
>  arch/powerpc/platforms/pseries/setup.c            |    4 ++--
>  39 files changed, 70 insertions(+), 119 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 9e1ca74..a1caaa9 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -139,8 +139,7 @@ notrace void __init machine_init(unsigned long dt_ptr)
>            cpu_has_feature(CPU_FTR_CAN_NAP))
>                ppc_md.power_save = e500_idle;
>  #endif
> -       if (ppc_md.progress)
> -               ppc_md.progress("id mach(): done", 0x200);
> +       ppc_progress("id mach(): done", 0x200);
>  }
>
>  #ifdef CONFIG_BOOKE_WDT
> @@ -219,8 +218,7 @@ EXPORT_SYMBOL(nvram_sync);
>  int __init ppc_init(void)
>  {
>        /* clear the progress line */
> -       if (ppc_md.progress)
> -               ppc_md.progress("             ", 0xffff);
> +       ppc_progress("             ", 0xffff);
>
>        /* call platform init */
>        if (ppc_md.init != NULL) {
> @@ -322,7 +320,7 @@ void __init setup_arch(char **cmdline_p)
>
>        /* set up the bootmem stuff with available memory */
>        do_init_bootmem();
> -       if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
> +       ppc_progress("setup_arch: bootmem", 0x3eab);
>
>  #ifdef CONFIG_DUMMY_CONSOLE
>        conswitchp = &dummy_con;
> @@ -330,7 +328,8 @@ void __init setup_arch(char **cmdline_p)
>
>        if (ppc_md.setup_arch)
>                ppc_md.setup_arch();
> -       if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
> +
> +       ppc_progress("arch: exit", 0x3eab);
>
>        paging_init();
>
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 666a5e8..d1bd21e 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -119,8 +119,7 @@ void MMU_setup(void)
>  */
>  void __init MMU_init(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("MMU:enter", 0x111);
> +       ppc_progress("MMU:enter", 0x111);
>
>        /* 601 can only access 16MB at the moment */
>        if (PVR_VER(mfspr(SPRN_PVR)) == 1)
> @@ -159,13 +158,11 @@ void __init MMU_init(void)
>        }
>
>        /* Initialize the MMU hardware */
> -       if (ppc_md.progress)
> -               ppc_md.progress("MMU:hw init", 0x300);
> +       ppc_progress("MMU:hw init", 0x300);
>        MMU_init_hw();
>
>        /* Map in all of RAM starting at KERNELBASE */
> -       if (ppc_md.progress)
> -               ppc_md.progress("MMU:mapin", 0x301);
> +       ppc_progress("MMU:mapin", 0x301);
>        mapin_ram();
>
>  #ifdef CONFIG_HIGHMEM
> @@ -176,11 +173,9 @@ void __init MMU_init(void)
>        ioremap_bot = ioremap_base;
>
>        /* Map in I/O resources */
> -       if (ppc_md.progress)
> -               ppc_md.progress("MMU:setio", 0x302);
> +       ppc_progress("MMU:setio", 0x302);
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("MMU:exit", 0x211);
> +       ppc_progress("MMU:exit", 0x211);
>
>        /* From now on, btext is no longer BAT mapped if it was at all */
>  #ifdef CONFIG_BOOTX_TEXT
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index 45d9253..c1a298c 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -204,7 +204,7 @@ void __init MMU_init_hw(void)
>                return;
>        }
>
> -       if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);
> +       ppc_progress("hash:enter", 0x105);
>
>  #define LG_HPTEG_SIZE  6               /* 64 bytes per HPTEG */
>  #define SDR1_LOW_BITS  ((n_hpteg - 1) >> 10)
> @@ -228,7 +228,7 @@ void __init MMU_init_hw(void)
>        /*
>         * Find some memory for the hash table.
>         */
> -       if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
> +       ppc_progress("hash:find piece", 0x322);
>        Hash = __va(lmb_alloc_base(Hash_size, Hash_size,
>                                   __initial_memory_limit_addr));
>        cacheable_memzero(Hash, Hash_size);
> @@ -243,7 +243,7 @@ void __init MMU_init_hw(void)
>        /*
>         * Patch up the instructions in hashtable.S:create_hpte
>         */
> -       if ( ppc_md.progress ) ppc_md.progress("hash:patch", 0x345);
> +       ppc_progress("hash:patch", 0x345);
>        Hash_mask = n_hpteg - 1;
>        hmask = Hash_mask >> (16 - LG_HPTEG_SIZE);
>        mb2 = mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
> @@ -276,5 +276,5 @@ void __init MMU_init_hw(void)
>        flush_icache_range((unsigned long) &flush_hash_patch_A[0],
>                           (unsigned long) &flush_hash_patch_B[1]);
>
> -       if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
> +       ppc_progress("hash:done", 0x205);
>  }
> diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
> index a2068fa..4b0d689 100644
> --- a/arch/powerpc/platforms/52xx/efika.c
> +++ b/arch/powerpc/platforms/52xx/efika.c
> @@ -190,8 +190,7 @@ static void __init efika_setup_arch(void)
>        mpc52xx_pm_init();
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
> +       ppc_progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
>  }
>
>  static int __init efika_probe(void)
> diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
> index 6d584f4..7d86669 100644
> --- a/arch/powerpc/platforms/52xx/lite5200.c
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -149,8 +149,7 @@ static void lite5200_resume_finish(void __iomem *mbar)
>
>  static void __init lite5200_setup_arch(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("lite5200_setup_arch()", 0);
> +       ppc_progress("lite5200_setup_arch()", 0);
>
>        /* Map important registers from the internal memory map */
>        mpc52xx_map_common_devices();
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> index a3bda0b..5d76177 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -36,8 +36,7 @@
>  */
>  static void __init mpc5200_simple_setup_arch(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc5200_simple_setup_arch()", 0);
> +       ppc_progress("mpc5200_simple_setup_arch()", 0);
>
>        /* Map important registers from the internal memory map */
>        mpc52xx_map_common_devices();
> diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
> index 0eb6d7f..7daef42 100644
> --- a/arch/powerpc/platforms/82xx/ep8248e.c
> +++ b/arch/powerpc/platforms/82xx/ep8248e.c
> @@ -252,8 +252,7 @@ static void __init init_ioports(void)
>
>  static void __init ep8248e_setup_arch(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("ep8248e_setup_arch()", 0);
> +       ppc_progress("ep8248e_setup_arch()", 0);
>
>        cpm2_reset();
>
> @@ -283,8 +282,7 @@ static void __init ep8248e_setup_arch(void)
>
>        init_ioports();
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("ep8248e_setup_arch(), finish", 0);
> +       ppc_progress("ep8248e_setup_arch(), finish", 0);
>  }
>
>  static  __initdata struct of_device_id of_bus_ids[] = {
> diff --git a/arch/powerpc/platforms/82xx/mgcoge.c b/arch/powerpc/platforms/82xx/mgcoge.c
> index c2af169..30b7952 100644
> --- a/arch/powerpc/platforms/82xx/mgcoge.c
> +++ b/arch/powerpc/platforms/82xx/mgcoge.c
> @@ -78,8 +78,7 @@ static void __init init_ioports(void)
>
>  static void __init mgcoge_setup_arch(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("mgcoge_setup_arch()", 0);
> +       ppc_progress("mgcoge_setup_arch()", 0);
>
>        cpm2_reset();
>
> @@ -90,8 +89,7 @@ static void __init mgcoge_setup_arch(void)
>
>        init_ioports();
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mgcoge_setup_arch(), finish", 0);
> +       ppc_progress("mgcoge_setup_arch(), finish", 0);
>  }
>
>  static  __initdata struct of_device_id of_bus_ids[] = {
> diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
> index 8054c68..42fd93c 100644
> --- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
> +++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
> @@ -126,8 +126,7 @@ static void __init mpc8272_ads_setup_arch(void)
>        struct device_node *np;
>        __be32 __iomem *bcsr;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc8272_ads_setup_arch()", 0);
> +       ppc_progress("mpc8272_ads_setup_arch()", 0);
>
>        cpm2_reset();
>
> @@ -155,8 +154,7 @@ static void __init mpc8272_ads_setup_arch(void)
>        init_ioports();
>        pq2_init_pci();
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
> +       ppc_progress("mpc8272_ads_setup_arch(), finish", 0);
>  }
>
>  static struct of_device_id __initdata of_bus_ids[] = {
> diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
> index e1dceee..44a3153 100644
> --- a/arch/powerpc/platforms/82xx/pq2fads.c
> +++ b/arch/powerpc/platforms/82xx/pq2fads.c
> @@ -118,8 +118,7 @@ static void __init pq2fads_setup_arch(void)
>        struct device_node *np;
>        __be32 __iomem *bcsr;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("pq2fads_setup_arch()", 0);
> +       ppc_progress("pq2fads_setup_arch()", 0);
>
>        cpm2_reset();
>
> @@ -153,8 +152,7 @@ static void __init pq2fads_setup_arch(void)
>
>        pq2_init_pci();
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("pq2fads_setup_arch(), finish", 0);
> +       ppc_progress("pq2fads_setup_arch(), finish", 0);
>  }
>
>  /*
> diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
> index bb30d67..2ee392d 100644
> --- a/arch/powerpc/platforms/83xx/asp834x.c
> +++ b/arch/powerpc/platforms/83xx/asp834x.c
> @@ -30,8 +30,7 @@
>  */
>  static void __init asp834x_setup_arch(void)
>  {
> -       if (ppc_md.progress)
> -               ppc_md.progress("asp834x_setup_arch()", 0);
> +       ppc_progress("asp834x_setup_arch()", 0);
>
>        mpc834x_usb_cfg();
>  }
> diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> index 5177bdd..4e378f1 100644
> --- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> @@ -32,8 +32,7 @@ static void __init mpc831x_rdb_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc831x_rdb_setup_arch()", 0);
> +       ppc_progress("mpc831x_rdb_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> index ec0b401..079e60f 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -59,8 +59,7 @@ static void __init mpc832x_sys_setup_arch(void)
>        struct device_node *np;
>        u8 __iomem *bcsr_regs = NULL;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc832x_sys_setup_arch()", 0);
> +       ppc_progress("mpc832x_sys_setup_arch()", 0);
>
>        /* Map BCSR area */
>        np = of_find_node_by_name(NULL, "bcsr");
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> index 2a1295f..3d9d7f1 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -92,8 +92,7 @@ static void __init mpc832x_rdb_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc832x_rdb_setup_arch()", 0);
> +       ppc_progress("mpc832x_rdb_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> index 76092d3..1d8b887 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -62,8 +62,7 @@ static void __init mpc834x_itx_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc834x_itx_setup_arch()", 0);
> +       ppc_progress("mpc834x_itx_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
> index fc3f2ed..fbd70a9 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
> @@ -81,8 +81,7 @@ static void __init mpc834x_mds_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc834x_mds_setup_arch()", 0);
> +       ppc_progress("mpc834x_mds_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> index 09e9d6f..7f33105 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> @@ -67,8 +67,7 @@ static void __init mpc836x_mds_setup_arch(void)
>        struct device_node *np;
>        u8 __iomem *bcsr_regs = NULL;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc836x_mds_setup_arch()", 0);
> +       ppc_progress("mpc836x_mds_setup_arch()", 0);
>
>        /* Map BCSR area */
>        np = of_find_node_by_name(NULL, "bcsr");
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> index b0090aa..6174bd8 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> @@ -44,8 +44,7 @@ static void __init mpc836x_rdk_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> +       ppc_progress("mpc836x_rdk_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> index 530ef99..0970544 100644
> --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> @@ -80,8 +80,7 @@ static void __init mpc837x_mds_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc837x_mds_setup_arch()", 0);
> +       ppc_progress("mpc837x_mds_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
> diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> index 1d09654..c5a987d 100644
> --- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
> @@ -32,8 +32,7 @@ static void __init mpc837x_rdb_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc837x_rdb_setup_arch()", 0);
> +       ppc_progress("mpc837x_rdb_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
> index 156c4e2..70c2ab2 100644
> --- a/arch/powerpc/platforms/83xx/sbc834x.c
> +++ b/arch/powerpc/platforms/83xx/sbc834x.c
> @@ -52,8 +52,7 @@ static void __init sbc834x_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("sbc834x_setup_arch()", 0);
> +       ppc_progress("sbc834x_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
> index 81cee7b..9938c95 100644
> --- a/arch/powerpc/platforms/85xx/ksi8560.c
> +++ b/arch/powerpc/platforms/85xx/ksi8560.c
> @@ -181,8 +181,7 @@ static void __init ksi8560_setup_arch(void)
>        else
>                printk(KERN_ERR "Can't find CPLD in device tree\n");
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("ksi8560_setup_arch()", 0);
> +       ppc_progress("ksi8560_setup_arch()", 0);
>
>  #ifdef CONFIG_CPM2
>        cpm2_reset();
> diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
> index 1bf5aef..17397cb 100644
> --- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
> @@ -67,8 +67,7 @@ static void __init mpc8536_ds_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc8536_ds_setup_arch()", 0);
> +       ppc_progress("mpc8536_ds_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_node_by_type(np, "pci") {
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> index 21f0090..b83976c 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -188,8 +188,7 @@ static void __init mpc85xx_ads_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
> +       ppc_progress("mpc85xx_ads_setup_arch()", 0);
>
>  #ifdef CONFIG_CPM2
>        cpm2_reset();
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index aeb6a5b..15b35e2 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -269,22 +269,19 @@ machine_device_initcall(mpc85xx_cds, mpc85xx_cds_8259_attach);
>  */
>  static void __init mpc85xx_cds_setup_arch(void)
>  {
> +       char buf[40];
>  #ifdef CONFIG_PCI
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
> +       ppc_progress("mpc85xx_cds_setup_arch()", 0);
>
>        cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
>        cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
>
> -       if (ppc_md.progress) {
> -               char buf[40];
> -               snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
> -                               cadmus[CM_VER], cds_pci_slot);
> -               ppc_md.progress(buf, 0);
> -       }
> +       snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
> +                cadmus[CM_VER], cds_pci_slot);
> +       ppc_progress(buf, 0);
>
>  #ifdef CONFIG_PCI
>        for_each_node_by_type(np, "pci") {
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 7326d90..1101911 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -157,8 +157,7 @@ static void __init mpc85xx_ds_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
> +       ppc_progress("mpc85xx_ds_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_node_by_type(np, "pci") {
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index 658a36f..abd01df 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -156,8 +156,7 @@ static void __init mpc85xx_mds_setup_arch(void)
>        struct device_node *np;
>        static u8 __iomem *bcsr_regs = NULL;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
> +       ppc_progress("mpc85xx_mds_setup_arch()", 0);
>
>        /* Map BCSR area */
>        np = of_find_node_by_name(NULL, "bcsr");
> diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
> index 7ec77ce..7fca09a 100644
> --- a/arch/powerpc/platforms/85xx/sbc8548.c
> +++ b/arch/powerpc/platforms/85xx/sbc8548.c
> @@ -114,8 +114,7 @@ static void __init sbc8548_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("sbc8548_setup_arch()", 0);
> +       ppc_progress("sbc8548_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_node_by_type(np, "pci") {
> diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
> index 472f254..fbee89e 100644
> --- a/arch/powerpc/platforms/85xx/sbc8560.c
> +++ b/arch/powerpc/platforms/85xx/sbc8560.c
> @@ -177,8 +177,7 @@ static void __init sbc8560_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("sbc8560_setup_arch()", 0);
> +       ppc_progress("sbc8560_setup_arch()", 0);
>
>  #ifdef CONFIG_CPM2
>        cpm2_reset();
> diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
> index 0cca8f5..0d9aa32 100644
> --- a/arch/powerpc/platforms/85xx/stx_gp3.c
> +++ b/arch/powerpc/platforms/85xx/stx_gp3.c
> @@ -114,8 +114,7 @@ static void __init stx_gp3_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("stx_gp3_setup_arch()", 0);
> +       ppc_progress("stx_gp3_setup_arch()", 0);
>
>  #ifdef CONFIG_CPM2
>        cpm2_reset();
> diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
> index 2933a8e..0f7a399 100644
> --- a/arch/powerpc/platforms/85xx/tqm85xx.c
> +++ b/arch/powerpc/platforms/85xx/tqm85xx.c
> @@ -112,8 +112,7 @@ static void __init tqm85xx_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("tqm85xx_setup_arch()", 0);
> +       ppc_progress("tqm85xx_setup_arch()", 0);
>
>  #ifdef CONFIG_CPM2
>        cpm2_reset();
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> index e8d54ac..34bb86e 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -221,8 +221,7 @@ static void __init mpc86xx_hpcd_setup_arch(void)
>        struct device_node *np;
>        unsigned char *pixis;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc86xx_hpcd_setup_arch()", 0);
> +       ppc_progress("mpc86xx_hpcd_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_node_by_type(np, "pci") {
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> index 27e0e68..0e7d30d 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -73,8 +73,7 @@ mpc86xx_hpcn_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
> +       ppc_progress("mpc86xx_hpcn_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
> diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
> index 5fd7ed4..68b4550 100644
> --- a/arch/powerpc/platforms/86xx/sbc8641d.c
> +++ b/arch/powerpc/platforms/86xx/sbc8641d.c
> @@ -44,8 +44,7 @@ sbc8641_setup_arch(void)
>        struct device_node *np;
>  #endif
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("sbc8641_setup_arch()", 0);
> +       ppc_progress("sbc8641_setup_arch()", 0);
>
>  #ifdef CONFIG_PCI
>        for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie")
> diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> index 272d79a..a237d56 100644
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -361,7 +361,7 @@ void __init chrp_setup_arch(void)
>         * Print the banner, then scroll down so boot progress
>         * can be printed.  -- Cort
>         */
> -       if (ppc_md.progress) ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0x0);
> +       ppc_progress("Linux/PPC "UTS_RELEASE"\n", 0x0);
>  }
>
>  void
> @@ -617,8 +617,7 @@ chrp_init2(void)
>        }
>        of_node_put(device);
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("  Have fun!    ", 0x7777);
> +       ppc_progress("  Have fun!    ", 0x7777);
>  }
>
>  static int __init chrp_probe(void)
> diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
> index b21fde5..20bbcae 100644
> --- a/arch/powerpc/platforms/embedded6xx/holly.c
> +++ b/arch/powerpc/platforms/embedded6xx/holly.c
> @@ -114,8 +114,7 @@ static void __init holly_setup_arch(void)
>  {
>        struct device_node *np;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("holly_setup_arch():set_bridge", 0);
> +       ppc_progress("holly_setup_arch():set_bridge", 0);
>
>        tsi108_csr_vir_base = get_vir_csrbase();
>
> @@ -127,8 +126,7 @@ static void __init holly_setup_arch(void)
>                tsi108_setup_pci(np, HOLLY_PCI_CFG_PHYS, 1);
>
>        ppc_md.pci_exclude_device = holly_exclude_device;
> -       if (ppc_md.progress)
> -               ppc_md.progress("tsi108: resources set", 0x100);
> +       ppc_progress("tsi108: resources set", 0x100);
>
>        printk(KERN_INFO "PPC750GX/CL Platform\n");
>  }
> diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> index 7a2ba39..e42cbf9 100644
> --- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> +++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> @@ -65,8 +65,8 @@ int mpc7448_hpc2_exclude_device(struct pci_controller *hose,
>  static void __init mpc7448_hpc2_setup_arch(void)
>  {
>        struct device_node *np;
> -       if (ppc_md.progress)
> -               ppc_md.progress("mpc7448_hpc2_setup_arch():set_bridge", 0);
> +
> +       ppc_progress("mpc7448_hpc2_setup_arch():set_bridge", 0);
>
>        tsi108_csr_vir_base = get_vir_csrbase();
>
> @@ -76,8 +76,7 @@ static void __init mpc7448_hpc2_setup_arch(void)
>                tsi108_setup_pci(np, MPC7448HPC2_PCI_CFG_PHYS, 0);
>
>        ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
> -       if (ppc_md.progress)
> -               ppc_md.progress("tsi108: resources set", 0x100);
> +       ppc_progress("tsi108: resources set", 0x100);
>  #endif
>
>        printk(KERN_INFO "MPC7448HPC2 (TAIGA) Platform\n");
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index bd8817b..c0e1c46 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -241,7 +241,7 @@ static void __init psurge_quad_init(void)
>  {
>        int procbits;
>
> -       if (ppc_md.progress) ppc_md.progress("psurge_quad_init", 0x351);
> +       ppc_progress("psurge_quad_init", 0x351);
>        procbits = ~PSURGE_QUAD_IN(PSURGE_QUAD_WHICH_CPU);
>        if (psurge_type == PSURGE_QUAD_ICEGRASS)
>                PSURGE_QUAD_BIS(PSURGE_QUAD_RESET_CTL, procbits);
> @@ -321,7 +321,7 @@ static int __init smp_psurge_probe(void)
>                set_hard_smp_processor_id(i, i);
>        }
>
> -       if (ppc_md.progress) ppc_md.progress("smp_psurge_probe - done", 0x352);
> +       ppc_progress("smp_psurge_probe - done", 0x352);
>
>        return ncpus;
>  }
> @@ -337,7 +337,7 @@ static void __init smp_psurge_kick_cpu(int nr)
>                asm volatile("dcbf 0,%0" : : "r" (a) : "memory");
>        asm volatile("sync");
>
> -       if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu", 0x353);
> +       ppc_progress("smp_psurge_kick_cpu", 0x353);
>
>        out_be32(psurge_start, start);
>        mb();
> @@ -350,7 +350,7 @@ static void __init smp_psurge_kick_cpu(int nr)
>                barrier();
>        psurge_clr_ipi(nr);
>
> -       if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu - done", 0x354);
> +       ppc_progress("smp_psurge_kick_cpu - done", 0x354);
>  }
>
>  /*
> @@ -753,7 +753,7 @@ static int __init smp_core99_probe(void)
>        struct device_node *cpus;
>        int ncpus = 0;
>
> -       if (ppc_md.progress) ppc_md.progress("smp_core99_probe", 0x345);
> +       ppc_progress("smp_core99_probe", 0x345);
>
>        /* Count CPUs in the device-tree */
>                for (cpus = NULL; (cpus = of_find_node_by_type(cpus, "cpu")) != NULL;)
> @@ -792,8 +792,7 @@ static void __devinit smp_core99_kick_cpu(int nr)
>        if (nr < 0 || nr > 3)
>                return;
>
> -       if (ppc_md.progress)
> -               ppc_md.progress("smp_core99_kick_cpu", 0x346);
> +       ppc_progress("smp_core99_kick_cpu", 0x346);
>
>        local_irq_save(flags);
>
> @@ -821,7 +820,7 @@ static void __devinit smp_core99_kick_cpu(int nr)
>        flush_icache_range((unsigned long) vector, (unsigned long) vector + 4);
>
>        local_irq_restore(flags);
> -       if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu done", 0x347);
> +       ppc_progress("smp_core99_kick_cpu done", 0x347);
>  }
>
>  static void __devinit smp_core99_setup_cpu(int cpu_nr)
> @@ -851,8 +850,7 @@ static void __devinit smp_core99_setup_cpu(int cpu_nr)
>                        g5_phy_disable_cpu1();
>  #endif /* CONFIG_PPC64 */
>
> -               if (ppc_md.progress)
> -                       ppc_md.progress("core99_setup_cpu 0 done", 0x349);
> +               ppc_progress("core99_setup_cpu 0 done", 0x349);
>        }
>  }
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index ec34170..325130b 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -298,8 +298,8 @@ static void __init pSeries_setup_arch(void)
>  static int __init pSeries_init_panel(void)
>  {
>        /* Manually leave the kernel version on the panel. */
> -       ppc_md.progress("Linux ppc64\n", 0);
> -       ppc_md.progress(init_utsname()->version, 0);
> +       ppc_progress("Linux ppc64\n", 0);
> +       ppc_progress(init_utsname()->version, 0);
>
>        return 0;
>  }
> --
> 1.5.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
