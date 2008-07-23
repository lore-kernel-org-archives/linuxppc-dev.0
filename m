Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 27E22DDFEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 21:57:42 +1000 (EST)
Message-ID: <48871D38.5030600@coritel.it>
Date: Wed, 23 Jul 2008 13:59:52 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Simon Kagstrom <simon.kagstrom@ericsson.com>
Subject: Re: Kexec on arch powerpc, device trees
References: <20080723114848.0e2d1a73@seasc0532.dyn.rnd.as.sw.ericsson.se>
In-Reply-To: <20080723114848.0e2d1a73@seasc0532.dyn.rnd.as.sw.ericsson.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Simon Kagstrom ha scritto:
> Hi!
> 
> I'm looking a bit at adding kexec support for our mpc8347-based board
> running a 2.6.21 kernel. Since the board isn't a "PPC_MULTIPLATFORM"
> one, I did a quick patch to the Kconfig file to allow enabling Kexec
> for our own board. The patch below then adds the kexec machine
> callbacks for our board, and this is enough to build.
> 
> I ran into two problems though: First, /proc/iomem did not contain any
> "System RAM", so the kexec userspace tool ended up without any usable
> memory regions and fails because of that. I thought this would be
> handled by the device tree support, where we have a node for the memory:
> 
> 	memory {
> 		device_type = "memory";
> 		reg = <00000000 20000000>;
> 	};
> 
> but apparently it isn't. Anyway, the add_ram_region_iomem() function
> adds a "System RAM" region for all "memory" nodes in the device tree.
> 
> 
> However, even after this kexec still fails:
> 
>    bash-3.1# /kexec -l /vmlinux
>    Invalid memory segment 0xc0000000 - 0xc0304fff
> 
> this time because the "System RAM" is really 0x00000000-0x20000000. If
> I use the --gamecube=1 option, kexec will load the kernel, but when
> trying to start it the board will just crash:
> 
>    bash-3.1# /kexec -e -d
>    [ 1579.005719] Starting new kernel
>    <end up in U-boot here>
> 
> So some questions: Is the --gamecube=1 option really meant to be used
> without a gamecube and should the first version really fail? Is the
> "System RAM" usage correct? Are there any similar freescale-based
> boards which have kexec support?
> 
> // Simon
> 
> Index: linux-2.6.21-standard/arch/powerpc/platforms/83xx/cmxb.c
> ===================================================================
> --- linux-2.6.21-standard.orig/arch/powerpc/platforms/83xx/cmxb.c
> +++ linux-2.6.21-standard/arch/powerpc/platforms/83xx/cmxb.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> +#include <linux/bootmem.h>
>  
>  #include <asm/system.h>
>  #include <asm/atomic.h>
> @@ -35,6 +36,7 @@
>  #include <asm/prom.h>
>  #include <asm/udbg.h>
>  #include <sysdev/fsl_soc.h>
> +#include <linux/kexec.h>
>  
>  #include "mpc83xx.h"
>  #include "cmxb.h"
> @@ -44,6 +46,31 @@ unsigned long isa_io_base = 0;
>  unsigned long isa_mem_base = 0;
>  #endif
>  
> +
> +static void add_ram_region_iomem(void)
> +{
> +	struct device_node *np;
> +	struct resource *res;
> +	struct resource of_resource;
> +
> +	for (np = NULL; (np = of_find_node_by_type(np, "memory")) != NULL;) {
> +                if (of_address_to_resource(np, 0, &of_resource)) {
> +                        printk(KERN_ERR "Could not convert memory node to resource\n");
> +                        of_node_put(np);
> +                        return;
> +                }
> +		res = alloc_bootmem(sizeof(struct resource));
> +
> +		res->name = "System RAM";
> +		res->start = of_resource.start;
> +		res->end = of_resource.end;
> +		res->flags = of_resource.flags;
> +		request_resource(&iomem_resource, res);
> +                of_node_put(np);
> +	}
> +}
> +
> +
>  /* ************************************************************************
>   *
>   * Setup the architecture
> @@ -62,6 +89,7 @@ static void __init cmxb_setup_arch(void)
>  
>  	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
>  #endif
> +        add_ram_region_iomem();
>  }
>  
>  static void __init cmxb_init_IRQ(void)
> @@ -100,4 +128,9 @@ define_machine(cmxb) {
>  	.time_init		= mpc83xx_time_init,
>  	.calibrate_decr		= generic_calibrate_decr,
>  	.progress		= udbg_progress,
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec		= default_machine_kexec,
> +	.machine_kexec_prepare	= default_machine_kexec_prepare,
> +	.machine_crash_shutdown	= default_machine_crash_shutdown,
> +#endif
>  };
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
Hi mate,

I think currently there's support for the kexec on 85xx.

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
