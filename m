Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 923892C0335
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:00:47 +1000 (EST)
Received: from mail100-co9 (localhost [127.0.0.1])	by
 mail100-co9-R.bigfish.com (Postfix) with ESMTP id 5187BB00314	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 17:00:43 +0000 (UTC)
Received: from CO9EHSMHS007.bigfish.com (unknown [10.236.132.230])	by
 mail100-co9.bigfish.com (Postfix) with ESMTP id 9412E940051	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 17:00:40 +0000 (UTC)
Message-ID: <1380301237.24959.397.camel@snotra.buserror.net>
Subject: Re: [PATCH V5 1/2] powerpc/85xx: Add QE common init function
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Fri, 27 Sep 2013 12:00:37 -0500
In-Reply-To: <1380188253-4710-1-git-send-email-X.Xie@freescale.com>
References: <1380188253-4710-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 17:37 +0800, Xie Xiaobo wrote:
> +#ifdef CONFIG_QUICC_ENGINE
> +void __init mpc85xx_qe_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!np) {
> +		np = of_find_node_by_name(NULL, "qe");
> +		if (!np) {
> +			pr_err("%s: Could not find Quicc Engine node\n",
> +					__func__);
> +			return;
> +		}
> +	}
> +
> +	qe_reset();
> +	of_node_put(np);

You're missing the of_device_is_available() check:

> -	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!np) {
> -		np = of_find_node_by_name(NULL, "qe");
> -		if (!np)
> -			return;
> -	}
> -
> -	if (!of_device_is_available(np)) {
> -		of_node_put(np);
> -		return;
> -	}
> -
> -	qe_reset();
> -	of_node_put(np);

-Scott
