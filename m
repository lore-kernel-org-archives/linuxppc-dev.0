Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C455B1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:28:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
Date: Wed, 23 Nov 2011 14:15:51 +0000
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
In-Reply-To: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201111231415.51985.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 23 November 2011, Tanmay Inamdar wrote:
> The AppliedMicro APM8018X embedded processor targets embedded applications that
> require low power and a small footprint. It features a PowerPC 405 processor
> core built in a 65nm low-power CMOS process with a five-stage pipeline executing
> up to one instruction per cycle. The family has 128-kbytes of on-chip memory,
> a 128-bit local bus and on-chip DDR2 SDRAM controller with 16-bit interface.

Hi Tanmay,

> +#if defined(CONFIG_APM8018X)
> +#define DCRN_CPR0_ADDR	0xa
> +#define DCRN_CPR0_DATA	0xb
> +#else
>  /* 440EP Clock/Power-on Reset regs */
>  #define DCRN_CPR0_ADDR	0xc
>  #define DCRN_CPR0_DATA	0xd
> +#endif /* CONFIG_APM8018X */

This prevents you from building one kernel that runs on both APM8018X and
others. Better define a new constant name for the new registers and select
the right one at run-time.

> diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/klondike.dts
> new file mode 100644
> index 0000000..9372a52
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/klondike.dts
> @@ -0,0 +1,668 @@
> +/*
> + * Device Tree Source for AMCC Klondike (405)
> + *

The device tree file for the most part describes the chip, but partly also
the board. Have you considered splitting the soc parts into a .dtsi file
and moving all the configuration into a separate file?


> diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/configs/40x/klondike_defconfig
> new file mode 100644
> index 0000000..840f438
> --- /dev/null
> +++ b/arch/powerpc/configs/40x/klondike_defconfig
> @@ -0,0 +1,1353 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/powerpc 3.2.0-rc2 Kernel Configuration
> +#
> +# CONFIG_PPC64 is not set
> +

Please use 'make savedefconfig' to create a minimal defconfig file instead of listing
the full configuration here.

> diff --git a/arch/powerpc/include/asm/dcr-regs.h b/arch/powerpc/include/asm/dcr-regs.h
> index 380274d..c900cfd 100644
> --- a/arch/powerpc/include/asm/dcr-regs.h
> +++ b/arch/powerpc/include/asm/dcr-regs.h
> @@ -24,9 +24,18 @@
>   * of the driver main register set
>   */
>  
> +#if defined(CONFIG_APM8018X)
> +/* CPR */
> +#define DCRN_CPR0_CONFIG_ADDR	0xa
> +#define DCRN_CPR1_CONFIG_DATA	0xb
> +/* AHB */
> +#define DCRN_SDR1_CONFIG_ADDR	0xc
> +#define DCRN_SDR1_CONFIG_DATA	0xd
> +#else
>  /* CPRs (440GX and 440SP/440SPe) */
>  #define DCRN_CPR0_CONFIG_ADDR	0xc
>  #define DCRN_CPR0_CONFIG_DATA	0xd
> +#endif /* CONFIG_APM8018X */

same comment as above.

> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index edae5bb..e5c51a6 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1505,6 +1505,58 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check		= machine_check_4xx,
>  		.platform		= "ppc405",
>  	},
> +	{	/* APM80186-SK */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x7ff11432,

If you mask out the lower bits, you only need a single entry instead of
four identical ones.

> --- a/arch/powerpc/kernel/udbg_16550.c
> +++ b/arch/powerpc/kernel/udbg_16550.c
> @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iomem *addr);
>  extern u8 real_205_readb(volatile u8 __iomem  *addr);
>  extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);
>  
> +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE
> +struct NS16550 {
> +	/* this struct must be packed */
> +	unsigned char rbr;  /* 0 */ u8 s0[3];
> +	unsigned char ier;  /* 1 */ u8 s1[3];
> +	unsigned char fcr;  /* 2 */ u8 s2[3];
> +	unsigned char lcr;  /* 3 */ u8 s3[3];
> +	unsigned char mcr;  /* 4 */ u8 s4[3];
> +	unsigned char lsr;  /* 5 */ u8 s5[3];
> +	unsigned char msr;  /* 6 */ u8 s6[3];
> +	unsigned char scr;  /* 7 */ u8 s7[3];
> +};
> +#else
>  struct NS16550 {
>  	/* this struct must be packed */
>  	unsigned char rbr;  /* 0 */
> @@ -29,6 +42,7 @@ struct NS16550 {
>  	unsigned char msr;  /* 6 */
>  	unsigned char scr;  /* 7 */
>  };
> +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */
>

Same things as with the register definitions. Please make this
run-time selectable to allow build-time configurations that
support both layouts.

	Arnd
