Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACFEEDDEF8
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:08:27 +1000 (EST)
Date: Thu, 30 Aug 2007 01:38:33 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/9] 8xx: Add pin and clock setting functions.
Message-ID: <20070830013833.4c4d5d0b@localhost.localdomain>
In-Reply-To: <20070828201719.GC24260@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201719.GC24260@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:17:19 -0500
Scott Wood wrote:

> These let board code set up pins and clocks without having to
> put magic numbers directly into the registers.
> 
I personally is not fond of such idea, but it would make this more understandable eases transfer to feature_call
or qe pin setting stuff (though the latter should be reworked at some point too imho).

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/commproc.c |  201
> ++++++++++++++++++++++++++++++++++++++++
> include/asm-powerpc/commproc.h |   41 ++++++++ 2 files changed, 242
> insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/commproc.c
> b/arch/powerpc/sysdev/commproc.c index af26659..a21a292 100644
> --- a/arch/powerpc/sysdev/commproc.c
> +++ b/arch/powerpc/sysdev/commproc.c
> @@ -405,3 +405,204 @@ uint cpm_dpram_phys(u8 *addr)
>  	return (dpram_pbase + (uint)(addr - (u8 __force
> *)dpram_vbase)); }
>  EXPORT_SYMBOL(cpm_dpram_addr);
> +
> +struct cpm_ioport16 {
> +	__be16 dir, par, sor, dat, intr;
> +	__be16 res[3];
> +};
> +
Hmm. If we are using such a non-standard types, it worths at least explanation why...


> +struct cpm_ioport32 {
> +	__be32 dir, par, sor;
> +};
> +
> +static void cpm1_set_pin32(int port, int pin, int flags)
> +{
> +	struct cpm_ioport32 __iomem *iop;
> +	pin = 1 << (31 - pin);
> +
> +	if (port == 1)
Probably put here define or alike so that we wouldn't have confusion what 1/whatever port number does mean.
Or some comment explaining for PQ newcomer what's going on here. ditto below.

> +		iop = (struct cpm_ioport32 __iomem *)
> +		      &mpc8xx_immr->im_cpm.cp_pbdir;
> +	else
> +		iop = (struct cpm_ioport32 __iomem *)
> +		      &mpc8xx_immr->im_cpm.cp_pedir;
> +
> +	if (flags & CPM_PIN_OUTPUT)
> +		setbits32(&iop->dir, pin);
> +	else
> +		clrbits32(&iop->dir, pin);
> +
> +	if (!(flags & CPM_PIN_GPIO))
> +		setbits32(&iop->par, pin);
> +	else
> +		clrbits32(&iop->par, pin);
> +
> +	if (port == 4) {
> +		if (flags & CPM_PIN_SECONDARY)
> +			setbits32(&iop->sor, pin);
> +		else
> +			clrbits32(&iop->sor, pin);
> +
> +		if (flags & CPM_PIN_OPENDRAIN)
> +			setbits32(&mpc8xx_immr->im_cpm.cp_peodr,
> pin);
> +		else
> +			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr,
> pin);
> +	}
> +}
> +
> +static void cpm1_set_pin16(int port, int pin, int flags)
> +{
> +	struct cpm_ioport16 __iomem *iop =
> +		(struct cpm_ioport16 __iomem
> *)&mpc8xx_immr->im_ioport; +
> +	pin = 1 << (15 - pin);
> +
> +	if (port != 0)
> +		iop += port - 1;
> +
> +	if (flags & CPM_PIN_OUTPUT)
> +		setbits16(&iop->dir, pin);
> +	else
> +		clrbits16(&iop->dir, pin);
> +
> +	if (!(flags & CPM_PIN_GPIO))
> +		setbits16(&iop->par, pin);
> +	else
> +		clrbits16(&iop->par, pin);
> +
> +	if (port == 2) {
> +		if (flags & CPM_PIN_SECONDARY)
> +			setbits16(&iop->sor, pin);
> +		else
> +			clrbits16(&iop->sor, pin);
> +	}
> +}
> +
> +void cpm1_set_pin(int port, int pin, int flags)
> +{
> +	if (port == 1 || port == 4)
> +		cpm1_set_pin32(port, pin, flags);
> +	else
> +		cpm1_set_pin16(port, pin, flags);
> +}
> +
> +int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
> +{
> +	int shift;
> +	int i, bits = 0;
> +	u32 __iomem *reg;
> +	u32 mask = 7;
> +
gotta at least briefly explain the clue here, too. We're adding helper functions and should be ready that something somewhere
won't work as expected.

> +	u8 clk_map[][3] = {
> +		{CPM_CLK_SCC1, CPM_BRG1, 0},
> +		{CPM_CLK_SCC1, CPM_BRG2, 1},
> +		{CPM_CLK_SCC1, CPM_BRG3, 2},
> +		{CPM_CLK_SCC1, CPM_BRG4, 3},
> +		{CPM_CLK_SCC1, CPM_CLK1, 4},
> +		{CPM_CLK_SCC1, CPM_CLK2, 5},
> +		{CPM_CLK_SCC1, CPM_CLK3, 6},
> +		{CPM_CLK_SCC1, CPM_CLK4, 7},
> +
> +		{CPM_CLK_SCC2, CPM_BRG1, 0},
> +		{CPM_CLK_SCC2, CPM_BRG2, 1},
> +		{CPM_CLK_SCC2, CPM_BRG3, 2},
> +		{CPM_CLK_SCC2, CPM_BRG4, 3},
> +		{CPM_CLK_SCC2, CPM_CLK1, 4},
> +		{CPM_CLK_SCC2, CPM_CLK2, 5},
> +		{CPM_CLK_SCC2, CPM_CLK3, 6},
> +		{CPM_CLK_SCC2, CPM_CLK4, 7},
> +
> +		{CPM_CLK_SCC3, CPM_BRG1, 0},
> +		{CPM_CLK_SCC3, CPM_BRG2, 1},
> +		{CPM_CLK_SCC3, CPM_BRG3, 2},
> +		{CPM_CLK_SCC3, CPM_BRG4, 3},
> +		{CPM_CLK_SCC3, CPM_CLK5, 4},
> +		{CPM_CLK_SCC3, CPM_CLK6, 5},
> +		{CPM_CLK_SCC3, CPM_CLK7, 6},
> +		{CPM_CLK_SCC3, CPM_CLK8, 7},
> +
> +		{CPM_CLK_SCC4, CPM_BRG1, 0},
> +		{CPM_CLK_SCC4, CPM_BRG2, 1},
> +		{CPM_CLK_SCC4, CPM_BRG3, 2},
> +		{CPM_CLK_SCC4, CPM_BRG4, 3},
> +		{CPM_CLK_SCC4, CPM_CLK5, 4},
> +		{CPM_CLK_SCC4, CPM_CLK6, 5},
> +		{CPM_CLK_SCC4, CPM_CLK7, 6},
> +		{CPM_CLK_SCC4, CPM_CLK8, 7},
> +
> +		{CPM_CLK_SMC1, CPM_BRG1, 0},
> +		{CPM_CLK_SMC1, CPM_BRG2, 1},
> +		{CPM_CLK_SMC1, CPM_BRG3, 2},
> +		{CPM_CLK_SMC1, CPM_BRG4, 3},
> +		{CPM_CLK_SMC1, CPM_CLK1, 4},
> +		{CPM_CLK_SMC1, CPM_CLK2, 5},
> +		{CPM_CLK_SMC1, CPM_CLK3, 6},
> +		{CPM_CLK_SMC1, CPM_CLK4, 7},
> +
> +		{CPM_CLK_SMC2, CPM_BRG1, 0},
> +		{CPM_CLK_SMC2, CPM_BRG2, 1},
> +		{CPM_CLK_SMC2, CPM_BRG3, 2},
> +		{CPM_CLK_SMC2, CPM_BRG4, 3},
> +		{CPM_CLK_SMC2, CPM_CLK5, 4},
> +		{CPM_CLK_SMC2, CPM_CLK6, 5},
> +		{CPM_CLK_SMC2, CPM_CLK7, 6},
> +		{CPM_CLK_SMC2, CPM_CLK8, 7},
> +	};
> +
> +	switch (target) {
> +	case CPM_CLK_SCC1:
> +		reg = &mpc8xx_immr->im_cpm.cp_sicr;
> +		shift = 0;
> +		break;
> +
> +	case CPM_CLK_SCC2:
> +		reg = &mpc8xx_immr->im_cpm.cp_sicr;
> +		shift = 8;
> +		break;
> +
> +	case CPM_CLK_SCC3:
> +		reg = &mpc8xx_immr->im_cpm.cp_sicr;
> +		shift = 16;
> +		break;
> +
> +	case CPM_CLK_SCC4:
> +		reg = &mpc8xx_immr->im_cpm.cp_sicr;
> +		shift = 24;
> +		break;
> +
> +	case CPM_CLK_SMC1:
> +		reg = &mpc8xx_immr->im_cpm.cp_simode;
> +		shift = 12;
> +		break;
> +
> +	case CPM_CLK_SMC2:
> +		reg = &mpc8xx_immr->im_cpm.cp_simode;
> +		shift = 28;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "cpm1_clock_setup: invalid clock
> target\n");
> +		return -EINVAL;
> +	}
> +
> +	if (reg == &mpc8xx_immr->im_cpm.cp_sicr && mode ==
> CPM_CLK_RX)
> +		shift += 3;
> +
> +	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
> +		if (clk_map[i][0] == target && clk_map[i][1] ==
> clock) {
> +			bits = clk_map[i][2];
> +			break;
> +		}
> +	}
> +
> +	if (i == ARRAY_SIZE(clk_map)) {
> +		printk(KERN_ERR "cpm1_clock_setup: invalid clock
> combination\n");
> +		return -EINVAL;
> +	}
> +
> +	bits <<= shift;
> +	mask <<= shift;
> +	out_be32(reg, (in_be32(reg) & ~mask) | bits);
> +
> +	return 0;
> +}
> diff --git a/include/asm-powerpc/commproc.h
> b/include/asm-powerpc/commproc.h index ccb32cd..a95a434 100644
> --- a/include/asm-powerpc/commproc.h
> +++ b/include/asm-powerpc/commproc.h
> @@ -692,4 +692,45 @@ extern void cpm_free_handler(int vec);
>  #define IMAP_ADDR		(get_immrbase())
>  #define IMAP_SIZE		((uint)(64 * 1024))
>  
Pull from the dts?

> +#define CPM_PIN_INPUT     0
> +#define CPM_PIN_OUTPUT    1
> +#define CPM_PIN_PRIMARY   0
> +#define CPM_PIN_SECONDARY 2
> +#define CPM_PIN_GPIO      4
> +#define CPM_PIN_OPENDRAIN 8
> +
> +void cpm1_set_pin(int port, int pin, int flags);
> +
> +enum cpm_clk_dir {
> +	CPM_CLK_RX,
> +	CPM_CLK_TX,
> +	CPM_CLK_RTX
> +};
> +
> +enum cpm_clk_target {
> +	CPM_CLK_SCC1,
> +	CPM_CLK_SCC2,
> +	CPM_CLK_SCC3,
> +	CPM_CLK_SCC4,
> +	CPM_CLK_SMC1,
> +	CPM_CLK_SMC2,
> +};
> +
> +enum cpm_clk {
> +	CPM_BRG1,	/* Baud Rate Generator  1 */
> +	CPM_BRG2,	/* Baud Rate Generator  2 */
> +	CPM_BRG3,	/* Baud Rate Generator  3 */
> +	CPM_BRG4,	/* Baud Rate Generator  4 */
> +	CPM_CLK1,	/* Clock  1 */
> +	CPM_CLK2,	/* Clock  2 */
> +	CPM_CLK3,	/* Clock  3 */
> +	CPM_CLK4,	/* Clock  4 */
> +	CPM_CLK5,	/* Clock  5 */
> +	CPM_CLK6,	/* Clock  6 */
> +	CPM_CLK7,	/* Clock  7 */
> +	CPM_CLK8,	/* Clock  8 */
> +};
> +
> +int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode);
> +
>  #endif /* __CPM_8XX__ */


-- 
Sincerely, Vitaly
