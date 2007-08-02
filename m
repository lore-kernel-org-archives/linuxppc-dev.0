Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5DD1DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:29:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KTgWd012029
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:29:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KTg1G269620
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:29:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KTgle023090
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:29:42 -0600
Date: Thu, 2 Aug 2007 15:29:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 4/6] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070802152941.579a55fa@weaponx.rchland.ibm.com>
In-Reply-To: <20070730151445.GA5075@ru.mvista.com>
References: <20070730151445.GA5075@ru.mvista.com>
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

On Mon, 30 Jul 2007 19:14:45 +0400
> +#define SPRN_CCR1 0x378
> +void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
> +{
> +	u32 cpu, plb, opb, ebc, tb, uart0, m, vco;
> +	u32 reg;
> +	u32 fwdva, fwdvb, fbdv, lfbdv, opbdv0, perdv0, spcid0, prbdv0, tmp;
> +
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLD0);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x000F0000) >> 16;
> +	fwdva = tmp ? tmp : 16;
> +	tmp = (reg & 0x00000700) >> 8;
> +	fwdvb = tmp ? tmp : 8;
> +	tmp = (reg & 0x1F000000) >> 24;
> +	fbdv = tmp ? tmp : 32;
> +	lfbdv = (reg & 0x0000007F);
> +
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_OPBD0);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x03000000) >> 24;
> +	opbdv0 = tmp ? tmp : 4;
> +
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_PERD0);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x07000000) >> 24;
> +	perdv0 = tmp ? tmp : 8;
> +
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_PRIMBD0);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x07000000) >> 24;
> +	prbdv0 = tmp ? tmp : 8;
> +
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_SCPID);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x03000000) >> 24;
> +	spcid0 = tmp ? tmp : 4;
> +
> +	/* Calculate M */
> +	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLC0);
> +	reg = mfdcr(DCRN_CPR0_DATA);
> +	tmp = (reg & 0x03000000) >> 24;
> +	if (tmp == 0) { /* PLL output */
> +		tmp = (reg & 0x20000000) >> 29;
> +		if (!tmp) /* PLLOUTA */
> +			m = fbdv * lfbdv * fwdva;
> +		else
> +			m = fbdv * lfbdv * fwdvb;
> +	}
> +	else if (tmp == 1) /* CPU output */
> +		m = fbdv * fwdva;
> +	else
> +		m = perdv0 * opbdv0 * fwdvb;
> +
> +	vco = (m * sysclk) + (m >> 1);
> +	cpu = vco / fwdva;
> +	plb = vco / fwdvb / prbdv0;
> +	opb = plb / opbdv0;
> +	ebc = plb / perdv0;
> +
> +	/* FIXME */
> +	uart0 = ser_clk;
> +
> +	/* Figure out timebase.  Either CPU or default TmrClk */
> +	asm volatile (
> +			"mfspr	%0,%1\n"
> +			:
> +			"=&r"(reg) : "i"(SPRN_CCR1));
> +	if (reg & 0x0080)
> +		tb = 25000000; /* TmrClk is 25MHz */
> +	else
> +		tb = cpu;
> +
> +	dt_fixup_cpu_clocks(cpu, tb, 0);
> +	dt_fixup_clock("/plb", plb);
> +	dt_fixup_clock("/plb/opb", opb);
> +	dt_fixup_clock("/plb/opb/ebc", ebc);
> +	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
> +	dt_fixup_clock("/plb/opb/serial@ef600400", uart0);
> +	dt_fixup_clock("/plb/opb/serial@ef600500", uart0);
> +	dt_fixup_clock("/plb/opb/serial@ef600600", uart0);
> +}

We don't need to duplicate this function in two different wrappers.
I'll move it into 4xx.c in my next round of patches, so that bamboo and
sequoia can just call a common function.

> +/* 
> + * 440EPx DDR1/2 memory controller code
> + * TODO: move to generic 44x code
> + */
> +
> +/* DDR0_02 */
> +#define DDR_START		0x1
> +#define DDR_START_SHIFT		0
> +#define DDR_MAX_CS_REG		0x3
> +#define DDR_MAX_CS_REG_SHIFT	24
> +#define DDR_MAX_COL_REG		0xf
> +#define DDR_MAX_COL_REG_SHIFT	16
> +#define DDR_MAX_ROW_REG		0xf
> +#define DDR_MAX_ROW_REG_SHIFT	8
> +/* DDR0_08 */
> +#define DDR_DDR2_MODE		0x1
> +#define DDR_DDR2_MODE_SHIFT	0
> +/* DDR0_10 */
> +#define DDR_CS_MAP		0x3
> +#define DDR_CS_MAP_SHIFT	8
> +/* DDR0_14 */
> +#define DDR_REDUC		0x1
> +#define DDR_REDUC_SHIFT		16
> +/* DDR0_42 */
> +#define DDR_APIN		0x7
> +#define DDR_APIN_SHIFT		24
> +/* DDR0_43 */
> +#define DDR_COL_SZ		0x7
> +#define DDR_COL_SZ_SHIFT	8
> +#define DDR_BANK8		0x1
> +#define DDR_BANK8_SHIFT		0
> +
> +#define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
> +
> +static void ibm440epx_fixup_memsize(void)

And we should move this at the same time.  Isn't denali used by another
CPU as well?

josh
