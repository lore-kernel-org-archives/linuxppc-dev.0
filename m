Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4003CDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 17:46:49 +1100 (EST)
Date: Wed, 12 Nov 2008 22:46:48 -0800 (PST)
Message-Id: <20081112.224648.106631825.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/4] Add helpers for finding a device node which as a
	certain property
From: David Miller <davem@davemloft.net>
In-Reply-To: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Nov 2008 15:20:35 +1100 (EST)

> +	np = from ? from->allnext : allnodes;
> +	for (; np; np = np->allnext) {
> +		for (pp = np->properties; pp != 0; pp = pp->next) {
> +			if (of_prop_cmp(pp->name, prop_name) == 0) {
> +				goto out;
> +			}
> +		}
> +	}

We're starting to duplicate a lot of code in this file.

Perhaps split out the locked section of of_find_proeprty() into
a __of_find_property() and use that here and in of_find_property()
as well?

staitc struct property *__of_find_property(const struct device_node *np,
					   const char *name,
					   int *lenp)
{
	struct property *pp;

	for (pp = np->properties; pp != 0; pp = pp->next) {
		if (of_prop_cmp(pp->name, name) == 0) {
			if (lenp != 0)
				*lenp = pp->length;
			break;
		}
	}

	return pp;
}

struct property *of_find_property(const struct device_node *np,
				  const char *name,
				  int *lenp)
{
	struct property *pp;

	if (!np)
		return NULL;

	read_lock(&devtree_lock);
	pp = __of_find_property(np, name, lenp);
	read_unlock(&devtree_lock);

	return pp;
}
EXPORT_SYMBOL(of_find_property);
