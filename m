Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 01:50:13 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
	<445690F7.5050605@am.sony.com>
In-Reply-To: <445690F7.5050605@am.sony.com>
MIME-Version: 1.0
Message-Id: <200605020150.14152.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 May 2006 00:51, Geoff Levand wrote:
> Seems CELL_IIC is never used.  Must be some stale variable,
> so I removed it.  Arnd, could you ack this.

Yes, I used it before when there was more code shared between
Cell and pSeries, but that is no longer the case.

> Segher, a problem with your suggestion is that our
> makefiles don't have as rich a set of logical ops as the
> config files.  Its easy to express 'build A if B', but not
> so easy to do 'build A if not C'.  To make this work
> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
> so I can have constructions like this in the makefile:
> 
> obj-$(CONFIG_PPC_CELL)	+= ...
> 
> I also got rid of SPUFS_PRIV1_MMIO, since SPUFS_PRIV1_MMIO
> just meant spufs with !SOME_HYPERVISOR_THING.
> 

I guess that one should really be (SPU_FS && CELL_NATIVE),
using the option Segher suggested now.

> ===================================================================
> --- cell--alp--2.orig/arch/powerpc/Kconfig	2006-05-01 15:13:22.000000000 -0700
> +++ cell--alp--2/arch/powerpc/Kconfig	2006-05-01 15:16:38.000000000 -0700
> @@ -391,15 +391,20 @@
>  	  For more informations, refer to <http://www.970eval.com>
> 
>  config PPC_CELL
> -	bool "  Cell Broadband Processor Architecture"
> +	bool
> +	default n
> +
> +config PPC_IBM_CELL_BLADE
> +	bool "  IBM Cell Blade"
>  	depends on PPC_MULTIPLATFORM && PPC64
> +	select PPC_CELL
>  	select PPC_RTAS
>  	select MMIO_NVRAM
>  	select PPC_UDBG_16550
> 
>  config PPC_SYSTEMSIM
>  	bool "  IBM Full System Simulator (systemsim) support"
> -	depends on PPC_CELL || PPC_PSERIES || PPC_MAPLE
> +	depends on PPC_IBM_CELL_BLADE || PPC_PSERIES || PPC_MAPLE
>  	help
>  	  Support booting resulting image under IBMs Full System Simulator.
>  	  If you enable this option, you are able to select device

whoops, this one should not be there at all. Note that I updated
your previous patch as well to fit into the series for submission,
and that did not include systemsim.

> Index: cell--alp--2/arch/powerpc/platforms/cell/Kconfig
> ===================================================================
> --- cell--alp--2.orig/arch/powerpc/platforms/cell/Kconfig	2006-05-01 15:13:22.000000000 -0700
> +++ cell--alp--2/arch/powerpc/platforms/cell/Kconfig	2006-05-01 15:13:23.000000000 -0700
> @@ -11,10 +11,15 @@
>  	  or may crash other CPUs.
>  	  Say 'n' here unless you expect to run on DD2.0 only.
> 
> +config SPU_BASE
> +	bool
> +	default n
> +
>  config SPU_FS
>  	tristate "SPU file system"
>  	default m
>  	depends on PPC_CELL
> +	select SPU_BASE
>  	help
>  	  The SPU file system is used to access Synergistic Processing
>  	  Units on machines implementing the Broadband Processor
> Index: cell--alp--2/arch/powerpc/platforms/cell/Makefile
> ===================================================================
> --- cell--alp--2.orig/arch/powerpc/platforms/cell/Makefile	2006-05-01 15:13:22.000000000 -0700
> +++ cell--alp--2/arch/powerpc/platforms/cell/Makefile	2006-05-01 15:17:58.000000000 -0700
> @@ -1,14 +1,14 @@
> -obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
> -obj-y			+= pervasive.o pci.o
> -
> -obj-$(CONFIG_SMP)	+= smp.o
> +obj-$(CONFIG_PPC_CELL)		+= interrupt.o iommu.o setup.o \
> +				   spider-pic.o pervasive.o pci.o
> +ifeq ($(CONFIG_SMP),y)
> +obj-$(CONFIG_PPC_CELL)		+= smp.o
> +endif
> 
>  # needed only when building loadable spufs.ko
> -spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
> -obj-y			+= $(spufs-modular-m)
> -
> -# always needed in kernel
> -spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
> -obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
> -
> -obj-$(CONFIG_SPU_FS)	+= spufs/
> +spufs-modular-$(CONFIG_SPU_FS)	+= spu_syscalls.o
> +obj-$(CONFIG_SPU_BASE)		+= spu_callbacks.o spu_base.o \
> +				   $(spufs-modular-m)
> +ifdef CONFIG_SPU_FS
> +obj-$(CONFIG_PPC_CELL)		+= spu_priv1_mmio.o
> +endif

I guess this could then become something like

spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
					   $(spufs-modular-m) \
					   $(spu-priv1-y)

> Index: cell--alp--2/drivers/net/Kconfig
> ===================================================================
> --- cell--alp--2.orig/drivers/net/Kconfig	2006-05-01 15:13:22.000000000 -0700
> +++ cell--alp--2/drivers/net/Kconfig	2006-05-01 15:13:23.000000000 -0700
> @@ -2179,7 +2179,7 @@
> 
>  config SPIDER_NET
>  	tristate "Spider Gigabit Ethernet driver"
> -	depends on PCI && PPC_CELL
> +	depends on PCI && PPC_IBM_CELL_BLADE
>  	select FW_LOADER
>  	help
>  	  This driver supports the Gigabit Ethernet chips present on the

Hmm, I'm also no longer sure if this is right. In theory, spidernet
could be used in all sorts of products, wether they are using the
same bridge chip or just the gigabit ethernet macro from it.

For now, I guess you can just leave this one alone if you respin
the patch another time. It's disabled by default, so the dependency
can be updated the next time we get a user in _addition_ to PPC_CELL.

	Arnd <><
