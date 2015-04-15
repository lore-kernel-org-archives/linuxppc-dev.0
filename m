Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFDDA1A0B8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 12:24:56 +1000 (AEST)
Message-ID: <1429064677.22867.715.camel@freescale.com>
Subject: Re: [v3] clk: qoriq: Add support for the FMan clock
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 14 Apr 2015 21:24:37 -0500
In-Reply-To: <1429010123-24764-1-git-send-email-igal.liberman@freescale.com>
References: <1429010123-24764-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mturquette@linaro.org, linuxppc-dev@lists.ozlabs.org, sboyd@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-14 at 14:15 +0300, Igal.Liberman wrote:
> +static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
> +{
> +	struct ccsr_guts __iomem *guts_regs = NULL;
> +	struct device_node *guts;
> +	uint32_t reg = 0;
> +	int clk_src = 0;
> +
> +	guts = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts) {
> +		pr_err("could not find GUTS node\n");
> +		return -ENODEV;
> +	}
> +
> +	guts_regs = of_iomap(guts, 0);
> +	of_node_put(guts);
> +	if (!guts_regs) {
> +		pr_err("ioremap of GUTS node failed\n");
> +		return -ENODEV;
> +	}

Error messages should include more context -- at least __func__.

-Scott
