Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AFD13DDE10
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:35:33 +1000 (EST)
Date: Fri, 2 May 2008 18:49:29 -0500
From: Olof Johansson <olof@lixom.net>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] powerpc: Add 8568 PHY workarounds to board code
Message-ID: <20080502234927.GC28587@lixom.net>
References: <1209751422-25634-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1209751422-25634-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, May 02, 2008 at 01:03:42PM -0500, Andy Fleming wrote:
> +static int __init board_fixups(void)
> +{
> +	char phy_id[BUS_ID_SIZE];
> +	char *compstrs[2] = {"fsl,gianfar-mdio", "fsl,ucc-mdio"};
> +	struct device_node *mdio;
> +	struct resource res;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
> +		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
> +
> +		of_address_to_resource(mdio, 0, &res);
> +		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
> +
> +		phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
> +		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
> +
> +		/* Register a workaround for errata */
> +		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
> +		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
> +
> +		of_node_put(mdio);
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(board_fixups);

Are you sure you want to run this workaround on all boards that happen
to be built-in?  I.e. shouldn't you be checked for what board you are
running on, since the compatible strings you match on seem generic?


-Olof
