Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AFE1DDE40
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:43:40 +1000 (EST)
Date: Tue, 17 Jul 2007 11:43:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: add support of the GiGE switch for mpc8313RDB
	via fixed PHY
Message-ID: <20070717164331.GC7347@ld0162-tx32.am.freescale.net>
References: <20070717004936.21700.67900.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070717004936.21700.67900.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This just comments on code style, not semantics...  I agree with Segher
that this isn't the way to do it.

On Tue, Jul 17, 2007 at 04:49:37AM +0400, Vitaly Bordug wrote:
> +#if defined(CONFIG_FIXED_MII_1000_FDX)
> +
> +static int fixed_set_link (void)
> +{
> +	struct fixed_info *phyinfo = fixed_mdio_get_phydev(0);	/* only one fixed phy on this platform */

Line length.

> +	for (np = NULL, i = 0;
> +	     (np = of_find_compatible_node(np, "mdio", "gianfar")) != NULL;
> +	     i++) {

Can't we just initialize np and i above, and use a while loop?

> +		memset(&res, 0, sizeof(res));

Not necessary.

> +		ret = of_address_to_resource(np, 0, &res);
> +		if (ret)
> +			return ret;
> +		child = of_find_compatible_node(np, "ethernet-phy","fixed");

Space after comma.

> +		if (!child)
> +			return -ENXIO;
> +		id = (u32*)of_get_property(child, "reg", NULL);

Cast not required.

> +		if (!id)
> +			return -ENXIO;
> +		break;

Why are you using a loop at all if there's a break at the end and no
continue?

> +	}
> +	snprintf(phydev->dev.bus_id, BUS_ID_SIZE, PHY_ID_FMT,  res.start, *id);

Only one space before res.start.

> +	memset(phyinfo->regs,0xff,sizeof(phyinfo->regs[0])*phyinfo->regs_num);

Spaces after commas.

-Scott
