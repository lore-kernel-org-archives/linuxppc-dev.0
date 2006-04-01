Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17454.15381.164905.580671@cargo.ozlabs.ibm.com>
Date: Sat, 1 Apr 2006 19:38:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
In-Reply-To: <20060331161330.3c723103.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> +property_present(struct device_node *np, const char *name)
> +{
> +	struct property *pp;
> +
> +	read_lock(&devtree_lock);
> +	for (pp = np->properties; pp != 0; pp = pp->next)
> +		if (strcmp(pp->name, name) == 0) {
> +			return 1;

Ummm, did you mean to return with the devtree_lock held?  I suspect
not.  In any case, why not just use get_property or of_find_property?

Paul.
