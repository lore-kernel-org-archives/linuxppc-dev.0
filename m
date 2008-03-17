Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3089DDF8D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:46:46 +1100 (EST)
Date: Mon, 17 Mar 2008 17:46:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Message-ID: <20080317224627.GB3622@loki.buserror.net>
References: <47DA444E.9050507@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47DA444E.9050507@denx.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 14, 2008 at 10:24:30AM +0100, Heiko Schocher wrote:
> +	setbits16(&mpc8xx_immr->im_ioport.iop_pcso, 0x300);
> +	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_RX);
> +	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK6, CPM_CLK_TX);
> +	setbits32(&mpc8xx_immr->im_cpm.cp_pbpar, 0x300);
> +	setbits32(&mpc8xx_immr->im_cpm.cp_pbdir, 0x300);

Any particular reason not to use cpm1_set_pin() rather than those setbits?

> +static void __init mgsuvd_setup_arch(void)
> +{
> +	struct device_node *cpu;
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if (cpu != 0) {
> +		const unsigned int *fp;
> +
> +		fp = of_get_property(cpu, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(cpu);
> +	}
> +

This is obsolete and unnecessary.

> +	ROOT_DEV = Root_NFS;

Likewise.

> +static int __init mgsuvd_probe(void)
> +{
> +	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
> +					  "model", NULL);
> +	if (model == NULL)
> +		return 0;
> +	if (strcmp(model, "MGSUVD"))
> +		return 0;
> +
> +	return 1;
> +}

Check compatible (using of_flat_dt_is_compatible), not model.

-Scott
