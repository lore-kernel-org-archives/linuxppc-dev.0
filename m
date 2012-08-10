Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E54E92C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 06:37:50 +1000 (EST)
Message-ID: <50257116.3030207@freescale.com>
Date: Fri, 10 Aug 2012 15:37:42 -0500
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
> +static int group_get_freq(struct group_priv *priv)
> +{
> +	if (priv->flags & FSL_GLOBAL_TIMER) {
> +		ccbfreq = fsl_get_sys_freq();
> +		priv->timerfreq = ccbfreq;
> +	} else {
> +		priv->timerfreq = in_be32(priv->group_tfrr);
> +	}

FSL MPICs have TFRR too.  I'm not sure that the lack of fsl,mpic is a
good indication that TFRR is being set (e.g. we have old device trees
for FSL chips with U-Boot that are labelled as ordinary openpics).

> +
> +	if (priv->timerfreq <= 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}

timerfreq is unsigned.  It can never be < 0.

> +
> +static int group_init_regmap(struct device_node *np, struct group_priv *priv)
> +{
> +	priv->group_tfrr = of_iomap(np, 0);
> +	if (!priv->group_tfrr) {
> +		pr_err("%s: cannot ioremap tfrr address.\n",
> +				np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	priv->regs = of_iomap(np, 1);
> +	if (!priv->regs) {
> +		pr_err("%s: cannot ioremap timer register address.\n",
> +				np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (!(priv->flags & FSL_GLOBAL_TIMER))
> +		return 0;
> +
> +	priv->group_tcr = of_iomap(np, 2);
> +	if (!priv->group_tcr) {
> +		pr_err("%s: cannot ioremap tcr address.\n", np->full_name);
> +		return -EINVAL;
> +	}

This is not compatible with existing mpic timer nodes.

> +	p = of_get_property(np, "available-ranges", &len);
> +	if (p && len % (2 * sizeof(u32)) != 0) {
> +		pr_err("%s: malformed fsl,available-ranges property.\n",
> +				np->full_name);
> +		return -EINVAL;
> +	}

You need to support fsl,available-ranges since that's in an accepted
binding and people could have partitioned setups already using it.

You also have a mismatch between the property you check and the error
string.

-Scott
