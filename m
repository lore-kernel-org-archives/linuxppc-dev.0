Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 96908DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 14:56:49 +1100 (EST)
Date: Tue, 6 Nov 2007 22:06:08 -0600
From: Olof Johansson <olof@lixom.net>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai,
	Ocotea, and Taishan
Message-ID: <20071107040608.GB22637@lixom.net>
References: <1416528026.20071107014041@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416528026.20071107014041@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

See comments below.


-Olof

On Wed, Nov 07, 2007 at 01:40:41AM +0300, Yuri Tikhonov wrote:
>  This patch introduces the L2_CACHE configuration option available
> for the ppc44x-based boards with L2-cache enabled.
> 
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
> 
> --
> diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
> index 1d2ca42..ad6b581 100644
> --- a/arch/ppc/platforms/4xx/Kconfig
> +++ b/arch/ppc/platforms/4xx/Kconfig
> @@ -396,4 +396,12 @@ config SERIAL_SICC_CONSOLE
>         bool
>         depends on SERIAL_SICC && UART0_TTYS1
>         default y
> +
> +config L2_CACHE
> +       bool "Enable Level-2 Cache"
> +       depends on NOT_COHERENT_CACHE && (KATMAI || TAISHAN || OCOTEA || ALPR)
> +       default y
> +       help
> +         This option enables L2-cache on ppc44x controllers.
> +         If unsure, say Y.

That's a very generic config name. Maybe something like PPC_4XX_L2_CACHE?

Is there ever a case where a user would NOT want l2 cache enabled (and
disabled permanently enough to rebuild the kernel instead of giving a
kernel command line option?)

>  endmenu
> diff --git a/arch/ppc/platforms/4xx/alpr.c b/arch/ppc/platforms/4xx/alpr.c
> index 3b6519f..0623801 100644
> --- a/arch/ppc/platforms/4xx/alpr.c
> +++ b/arch/ppc/platforms/4xx/alpr.c
> @@ -537,10 +537,12 @@ static void __init alpr_setup_arch(void)
>         printk("Prodrive ALPR port (DENX Software Engineering <sr@denx.de>)\n");
>  }
>  
> +#ifdef CONFIG_L2_CACHE
>  static void __init alpr_init(void)
>  {
>         ibm440gx_l2c_setup(&clocks);
>  }
> +#endif
>  
>  static void alpr_progress(char *buf, unsigned short val)
>  {
> @@ -567,7 +569,9 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>  #ifdef CONFIG_KGDB
>         ppc_md.early_serial_map = alpr_early_serial_map;
>  #endif
> +#ifdef CONFIG_L2_CACHE
>         ppc_md.init = alpr_init;
> +#endif

Why do you take out the above calls if the new option is selected? Seems
odd to remove something that worked(?) before.

>         ppc_md.restart = alpr_restart;
>  }
>  
> diff --git a/arch/ppc/platforms/4xx/katmai.c b/arch/ppc/platforms/4xx/katmai.c
> index d29ebf6..01f1baf 100644
> --- a/arch/ppc/platforms/4xx/katmai.c
> +++ b/arch/ppc/platforms/4xx/katmai.c
> @@ -219,6 +219,7 @@ katmai_show_cpuinfo(struct seq_file *m)
>  {
>         seq_printf(m, "vendor\t\t: AMCC\n");
>         seq_printf(m, "machine\t\t: PPC440SPe EVB (Katmai)\n");
> +       ibm440gx_show_cpuinfo(m);

This seems unrelated to this patch.

>         return 0;
>  }
> @@ -584,6 +585,13 @@ static void katmai_restart(char *cmd)
>         mtspr(SPRN_DBCR0, DBCR0_RST_CHIP);
>  }
>  
> +#ifdef CONFIG_L2_CACHE
> +static void __init katmai_init(void)
> +{
> +       ibm440gx_l2c_setup(&clocks);
> +}
> +#endif
> +
>  void __init platform_init(unsigned long r3, unsigned long r4,
>                           unsigned long r5, unsigned long r6, unsigned long r7)
>  {
> @@ -599,4 +607,7 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>         ppc_md.early_serial_map = katmai_early_serial_map;
>  #endif
>         ppc_md.restart = katmai_restart;
> +#ifdef CONFIG_L2_CACHE
> +       ppc_md.init = katmai_init;
> +#endif

See comment above. Should the above init be called for all configs, not just
when L2_CACHE is enabled?

Also, it looks like the init function is the same on every board. It would
be better to make a common function instead of duplicating it everywhere.

>  }
> diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
> index a7435aa..8b13811 100644
> --- a/arch/ppc/platforms/4xx/ocotea.c
> +++ b/arch/ppc/platforms/4xx/ocotea.c
> @@ -321,10 +321,12 @@ ocotea_setup_arch(void)
>         printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
>  }
>  
> +#ifdef CONFIG_L2_CACHE
>  static void __init ocotea_init(void)
>  {
>         ibm440gx_l2c_setup(&clocks);
>  }
> +#endif
>  
>  void __init platform_init(unsigned long r3, unsigned long r4,
>                 unsigned long r5, unsigned long r6, unsigned long r7)
> @@ -345,5 +347,7 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>  #ifdef CONFIG_KGDB
>         ppc_md.early_serial_map = ocotea_early_serial_map;
>  #endif
> +#ifdef CONFIG_L2_CACHE
>         ppc_md.init = ocotea_init;
> +#endif
>  }
> diff --git a/arch/ppc/platforms/4xx/taishan.c b/arch/ppc/platforms/4xx/taishan.c
> index f4b9435..8bb6f15 100644
> --- a/arch/ppc/platforms/4xx/taishan.c
> +++ b/arch/ppc/platforms/4xx/taishan.c
> @@ -370,10 +370,12 @@ taishan_setup_arch(void)
>         printk("AMCC PowerPC 440GX Taishan Platform\n");
>  }
>  
> +#ifdef CONFIG_L2_CACHE
>  static void __init taishan_init(void)
>  {
>         ibm440gx_l2c_setup(&clocks);
>  }
> +#endif
>  
>  void __init platform_init(unsigned long r3, unsigned long r4,
>                 unsigned long r5, unsigned long r6, unsigned long r7)
> @@ -389,6 +391,8 @@ void __init platform_init(unsigned long r3, unsigned long r4,
>  #ifdef CONFIG_KGDB
>         ppc_md.early_serial_map = taishan_early_serial_map;
>  #endif
> +#ifdef CONFIG_L2_CACHE
>         ppc_md.init = taishan_init;
> +#endif
>  }
>    
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
