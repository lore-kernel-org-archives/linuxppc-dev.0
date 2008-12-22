Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F335BDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 04:12:12 +1100 (EST)
Date: Mon, 22 Dec 2008 20:12:09 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Message-ID: <20081222171209.GA22890@oksana.dev.rtsoft.ru>
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 05, 2008 at 07:55:04PM +0300, Anton Vorontsov wrote:
> Some 83xx boards were not ready for the optional QUICC Engine support.
> 
> This patch fixes following build errors:
> 
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb308): undefined reference to `par_io_data_set'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb334): undefined reference to `par_io_data_set'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb408): undefined reference to `qe_ic_get_high_irq'
> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0xb478): undefined reference to `qe_ic_get_low_irq'
> arch/powerpc/platforms/built-in.o: In function `mpc832x_spi_init':
> mpc832x_rdb.c:(.init.text+0x574c): undefined reference to `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x5768): undefined reference to `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x5784): undefined reference to `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x57a0): undefined reference to `par_io_config_pin'
> mpc832x_rdb.c:(.init.text+0x57bc): undefined reference to `par_io_config_pin'
> arch/powerpc/platforms/built-in.o:mpc832x_rdb.c:(.init.text+0x57d8): more undefined references to `par_io_config_pin' follow
> arch/powerpc/platforms/built-in.o: In function `mpc836x_rdk_init_IRQ':
> mpc836x_rdk.c:(.init.text+0x5e84): undefined reference to `qe_ic_init'
> arch/powerpc/platforms/built-in.o: In function `mpc836x_rdk_setup_arch':
> mpc836x_rdk.c:(.init.text+0x5f10): undefined reference to `qe_reset'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Kumar,

After all I think we should apply this version.

Soon I'll send cleanup patches for all QE boards to remove need
for most #ifdefs.

But so far let's be consistent and do what other boards are doing.

Thanks,

> This patch implements traditional way of !QE case handling.
> Alternative version is coming (w/o ifdefs in the board files).
> 
> p.s. I don't know if it is 2.6.28 material...
> 
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |    3 ++-
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c |    6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> index 0300268..7e20e91 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -38,6 +38,7 @@
>  #define DBG(fmt...)
>  #endif
>  
> +#ifdef CONFIG_QUICC_ENGINE
>  static void mpc83xx_spi_activate_cs(u8 cs, u8 polarity)
>  {
>  	pr_debug("%s %d %d\n", __func__, cs, polarity);
> @@ -77,8 +78,8 @@ static int __init mpc832x_spi_init(void)
>  			    mpc83xx_spi_activate_cs,
>  			    mpc83xx_spi_deactivate_cs);
>  }
> -
>  machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);
> +#endif /* CONFIG_QUICC_ENGINE */
>  
>  /* ************************************************************************
>   *
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> index a5273bb..b0090aa 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> @@ -51,8 +51,9 @@ static void __init mpc836x_rdk_setup_arch(void)
>  	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
>  		mpc83xx_add_bridge(np);
>  #endif
> -
> +#ifdef CONFIG_QUICC_ENGINE
>  	qe_reset();
> +#endif
>  }
>  
>  static void __init mpc836x_rdk_init_IRQ(void)
> @@ -71,13 +72,14 @@ static void __init mpc836x_rdk_init_IRQ(void)
>  	 */
>  	ipic_set_default_priority();
>  	of_node_put(np);
> -
> +#ifdef CONFIG_QUICC_ENGINE
>  	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
>  	if (!np)
>  		return;
>  
>  	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
>  	of_node_put(np);
> +#endif
>  }
>  
>  /*
> -- 
> 1.5.6.5
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
