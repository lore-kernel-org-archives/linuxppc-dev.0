Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 952A9B7BD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:16:56 +1100 (EST)
Subject: Re: [RFC PATCH v4 2/2] powerpc: gamecube/wii: early debugging
	using usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
	<4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:16:50 +1100
Message-ID: <1260569810.16132.378.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 21:35 +0100, Albert Herranz wrote:
> Add support for using the USB Gecko adapter as an early debugging
> console on the Nintendo GameCube and Wii video game consoles.
> The USB Gecko is a 3rd party memory card interface adapter that provides
> a EXI (External Interface) to USB serial converter.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/Kconfig.debug                         |    8 +++
>  arch/powerpc/include/asm/udbg.h                    |    1 +
>  arch/powerpc/kernel/head_32.S                      |   25 +++++++++
>  arch/powerpc/kernel/udbg.c                         |    2 +
>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   56 ++++++++++++++++++++
>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
>  6 files changed, 94 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 3b10051..11e385b 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -254,6 +254,14 @@ config PPC_EARLY_DEBUG_CPM
>  	  using a CPM-based serial port.  This assumes that the bootwrapper
>  	  has run, and set up the CPM in a particular way.
>  
> +config PPC_EARLY_DEBUG_USBGECKO
> +	bool "Early debugging through the USB Gecko adapter"
> +	depends on GAMECUBE_COMMON
> +	select USBGECKO_UDBG
> +	help
> +	  Select this to enable early debugging for Nintendo GameCube/Wii
> +	  consoles via an external USB Gecko adapter.
> +
>  endchoice
>  
>  config PPC_EARLY_DEBUG_44x_PHYSLOW
> diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
> index cd21e5e..11ae699 100644
> --- a/arch/powerpc/include/asm/udbg.h
> +++ b/arch/powerpc/include/asm/udbg.h
> @@ -51,6 +51,7 @@ extern void __init udbg_init_btext(void);
>  extern void __init udbg_init_44x_as1(void);
>  extern void __init udbg_init_40x_realmode(void);
>  extern void __init udbg_init_cpm(void);
> +extern void __init udbg_init_usbgecko(void);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_UDBG_H */
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 829c3fe..00b89c0 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -164,6 +164,9 @@ __after_mmu_off:
>  #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>  	bl	setup_cpm_bat
>  #endif
> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> +	bl	setup_usbgecko_bat
> +#endif
>  
>  /*
>   * Call setup_cpu for CPU 0 and initialize 6xx Idle
> @@ -1203,6 +1206,28 @@ setup_cpm_bat:
>  	blr
>  #endif
>  
> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> +setup_usbgecko_bat:
> +	/* prepare a BAT for early io */
> +#if defined(CONFIG_GAMECUBE)
> +	lis	r8, 0x0c00
> +#elif defined(CONFIG_WII)
> +	lis	r8, 0x0d00
> +#else
> +#error Invalid platform for USB Gecko based early debugging.
> +#endif
> +	/*
> +	 * The virtual address used must match the virtual address
> +	 * associated to the fixmap entry FIX_EARLY_DEBUG_BASE.
> +	 */
> +	lis	r11, 0xfffe	/* top 128K */
> +	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
> +	ori	r11, r11, 0x3	/* 128K */
> +	mtspr	SPRN_DBAT1L, r8
> +	mtspr	SPRN_DBAT1U, r11
> +	blr
> +#endif
> +
>  #ifdef CONFIG_8260
>  /* Jump into the system reset for the rom.
>   * We first disable the MMU, and then jump to the ROM reset address.
> diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
> index fc9af47..e39cad8 100644
> --- a/arch/powerpc/kernel/udbg.c
> +++ b/arch/powerpc/kernel/udbg.c
> @@ -60,6 +60,8 @@ void __init udbg_early_init(void)
>  	udbg_init_40x_realmode();
>  #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
>  	udbg_init_cpm();
> +#elif defined(CONFIG_PPC_EARLY_DEBUG_USBGECKO)
> +	udbg_init_usbgecko();
>  #endif
>  
>  #ifdef CONFIG_PPC_EARLY_DEBUG
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> index ba4c7cc..edc956c 100644
> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> @@ -17,6 +17,7 @@
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/udbg.h>
> +#include <asm/fixmap.h>
>  
>  #include "usbgecko_udbg.h"
>  
> @@ -270,3 +271,58 @@ done:
>  		of_node_put(np);
>  	return;
>  }
> +
> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> +
> +static phys_addr_t __init ug_early_grab_io_addr(void)
> +{
> +#if defined(CONFIG_GAMECUBE)
> +	return 0x0c000000;
> +#elif defined(CONFIG_WII)
> +	return 0x0d000000;
> +#else
> +#error Invalid platform for USB Gecko based early debugging.
> +#endif
> +}
> +
> +/*
> + * USB Gecko early debug support initialization for udbg.
> + */
> +void __init udbg_init_usbgecko(void)
> +{
> +	void __iomem *early_debug_area;
> +	void __iomem *exi_io_base;
> +
> +	/*
> +	 * At this point we have a BAT already setup that enables I/O
> +	 * to the EXI hardware.
> +	 *
> +	 * The BAT uses a virtual address range reserved at the fixmap.
> +	 * This must match the virtual address configured in
> +	 * head_32.S:setup_usbgecko_bat().
> +	 */
> +	early_debug_area = (void __iomem *)__fix_to_virt(FIX_EARLY_DEBUG_BASE);
> +	exi_io_base = early_debug_area + 0x00006800;
> +
> +	/* try to detect a USB Gecko */
> +	if (!ug_udbg_probe(exi_io_base))
> +		return;
> +
> +	/* we found a USB Gecko, load udbg hooks */
> +	udbg_putc = ug_udbg_putc;
> +	udbg_getc = ug_udbg_getc;
> +	udbg_getc_poll = ug_udbg_getc_poll;
> +
> +	/*
> +	 * Prepare again the same BAT for MMU_init.
> +	 * This allows udbg I/O to continue working after the MMU is
> +	 * turned on for real.
> +	 * It is safe to continue using the same virtual address as it is
> +	 * a reserved fixmap area.
> +	 */
> +	setbat(1, (unsigned long)early_debug_area,
> +	       ug_early_grab_io_addr(), 128*1024, PAGE_KERNEL_NCG);
> +}
> +
> +#endif /* CONFIG_PPC_EARLY_DEBUG_USBGECKO */
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> index 3929de3..bb6cde4 100644
> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> @@ -27,4 +27,6 @@ static inline void __init ug_udbg_init(void)
>  
>  #endif /* CONFIG_USBGECKO_UDBG */
>  
> +void __init udbg_init_usbgecko(void);
> +
>  #endif /* __USBGECKO_UDBG_H */
