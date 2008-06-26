Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F399DE44B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:55:13 +1000 (EST)
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1214424332-18496-1-git-send-email-timur@freescale.com>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 20:57:44 +1000
Message-Id: <1214477864.8011.466.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +struct property *of_find_next_property(const struct device_node *np,
> +	struct property *prev)
> +{
> +	struct property *next;
> +
> +	if (!np)
> +		return NULL;
> +
> +	read_lock(&devtree_lock);
> +	next = prev ? prev->next : np->properties;
> +	read_unlock(&devtree_lock);
> +
> +	return next;
> +}

Unfortunately, this isn't race free vs. removal or addition of
properties. This is fine with the intended usage (ie. retreiving
aliases) but at least that should be explained in a comment.

Cheers,
Ben.
