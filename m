Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 4C6E068667
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Nov 2005 10:29:41 +1100 (EST)
Date: Tue, 1 Nov 2005 16:29:39 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20051101162939.G30577@cox.net>
References: <20051012153817.D370D353A4F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051012153817.D370D353A4F@atlas.denx.de>;
	from wd@denx.de on Wed, Oct 12, 2005 at 05:38:17PM +0200
Cc: llandre <r&d2@dave-tech.it>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] ppc32: Add initial support for DAVE "PPChameleon"
	board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2005 at 05:38:17PM +0200, Wolfgang Denk wrote:
> the following patch (against current kernel.org tree) adds suport for
> the "PPChameleon" modules / eval boards manufactured by DAVE s.r.l.

See comments below.
 
> +config PPChameleonEVB
> +	bool "PPChameleonEVB"
> +	help
> +	  This option enables support for the DAVE 405EP evaluation board.
> +

It's unusual to have a mixed case config option. Is there a better
option that makes sense? PP_CHAM_EVB?

>  /* DCR defines */
> -#define DCRN_CPMSR_BASE         0x0BA
> -#define DCRN_CPMFR_BASE         0x0B9
> +#define DCRN_CPMSR_BASE		0x0BA
> +#define DCRN_CPMFR_BASE		0x0B9

Please drop these whitespace changes.

> -#define IBM_CPM_GPT             0x80000000      /* GPT interface */
> -#define IBM_CPM_PCI             0x40000000      /* PCI bridge */
> -#define IBM_CPM_UIC             0x00010000      /* Universal Int Controller */
> -#define IBM_CPM_CPU             0x00008000      /* processor core */
> -#define IBM_CPM_EBC             0x00002000      /* EBC controller */
> -#define IBM_CPM_SDRAM0          0x00004000      /* SDRAM memory controller */
> -#define IBM_CPM_GPIO0           0x00001000      /* General Purpose IO */
> -#define IBM_CPM_TMRCLK          0x00000400      /* CPU timers */
> -#define IBM_CPM_PLB             0x00000100      /* PLB bus arbiter */
> -#define IBM_CPM_OPB             0x00000080      /* PLB to OPB bridge */
> -#define IBM_CPM_DMA             0x00000040      /* DMA controller */
> -#define IBM_CPM_IIC0            0x00000010      /* IIC interface */
> -#define IBM_CPM_UART1           0x00000002      /* serial port 0 */
> -#define IBM_CPM_UART0           0x00000001      /* serial port 1 */
> +#define IBM_CPM_GPT		0x80000000      /* GPT interface */
> +#define IBM_CPM_PCI		0x40000000      /* PCI bridge */
> +#define IBM_CPM_UIC		0x00010000      /* Universal Int Controller */
> +#define IBM_CPM_CPU		0x00008000      /* processor core */
> +#define IBM_CPM_EBC		0x00002000      /* EBC controller */
> +#define IBM_CPM_SDRAM0		0x00004000      /* SDRAM memory controller */
> +#define IBM_CPM_GPIO0		0x00001000      /* General Purpose IO */
> +#define IBM_CPM_TMRCLK		0x00000400      /* CPU timers */
> +#define IBM_CPM_PLB		0x00000100      /* PLB bus arbiter */
> +#define IBM_CPM_OPB		0x00000080      /* PLB to OPB bridge */
> +#define IBM_CPM_DMA		0x00000040      /* DMA controller */
> +#define IBM_CPM_IIC0		0x00000010      /* IIC interface */
> +#define IBM_CPM_UART1		0x00000002      /* serial port 0 */
> +#define IBM_CPM_UART0		0x00000001      /* serial port 1 */

Same here, if whitespace chanes are important submit them separately.

> diff --git a/arch/ppc/platforms/4xx/ppchameleon.c b/arch/ppc/platforms/4xx/ppchameleon.c
> new file mode 100644
> --- /dev/null

<snip>

> +#if defined(CONFIG_BIOS_FIXUP)
> +void __init bios_fixup (struct pci_controller *hose, struct pcil0_regs *pcip)

<snip>

You don't use this bios_fixup garbage in this port (at least according
to your defconfig) so just drop it.

As an aside, this stuff is pretty awful and has been since 405 first
came into the tree. If the basic functionality were required, a new
port should simply reprogram the pci host bridge and let the pci
subsystem place the BARs.

-Matt
