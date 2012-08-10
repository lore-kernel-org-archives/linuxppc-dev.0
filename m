Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AF182C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 05:40:27 +1000 (EST)
Message-ID: <5025639F.4070203@freescale.com>
Date: Fri, 10 Aug 2012 14:40:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <Dongsheng.wang@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
In-Reply-To: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: kumar.gala@freescale.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2012 12:54 AM, Dongsheng.wang@freescale.com wrote:
> +static const struct of_device_id mpic_timer_ids[] = {
> +	{ .compatible = "open-pic,global-timer", },
> +	{ .compatible = "fsl,global-timer", },
> +	{},
> +};
> +
> +static int __init mpic_timer_init(void)
> +{
> +	struct device_node *np = NULL;
> +
> +	for_each_node_by_type(np, "open-pic")
> +		if (of_match_node(mpic_timer_ids, np))
> +			group_init(np);
> +
> +	if (list_empty(&group_list))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +arch_initcall(mpic_timer_init);
> 

Where do you distinguish an FSL timer from an openpic timer?  I thought
openpic timers didn't support cascading.

Oh, and don't probe by device_type.

-Scott
