Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F27B51A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 13:29:59 +1100 (AEDT)
Message-ID: <1424831385.4698.53.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add power_off support for fsl platform
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 24 Feb 2015 20:29:45 -0600
In-Reply-To: <1423032421-31561-1-git-send-email-dongsheng.wang@freescale.com>
References: <1423032421-31561-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, hongtao.jia@freescale.com,
 jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-04 at 14:47 +0800, Dongsheng Wang wrote:
> +void ppc_md_fixup(void)
> +{

This name is way too generic (though it's moot since you shouldn't use
ppc_md for this).

> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-qixis");
> +	if (!np)
> +		return;
> +
> +	of_node_put(np);
> +
> +	pm_power_off = fsl_power_off;
> +	ppc_md.halt = fsl_power_off;
> +}

Please implement this as a drivers/power/reset driver, and consider
basing on top of
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/293089.html

-Scott
