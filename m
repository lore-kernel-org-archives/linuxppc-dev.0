Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id 88EB0DE346
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 09:00:04 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so608898fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 16:00:02 -0700 (PDT)
Date: Sat, 19 Apr 2008 02:59:57 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] powerpc: Add 8568 PHY workaround to board code
Message-ID: <20080418225957.GA21037@zarina>
References: <1208558149-6029-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1208558149-6029-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 05:35:49PM -0500, Andy Fleming wrote:
> The 8568 MDS needs some configuration changes to the PHY in order to work
> properly.  These are done in the firmware, normally, but Linux shouldn't
> need to rely on the firmware running such things (someone could disable
> the PHY support in the firmware to save space, for instance).
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> 
> Jeff, copying you so you can see what code uses the board fixup patch.  Also,
> Kumar, note that this patch is utterly useless without the patch sent to netdev:
> Add support for board-level PHY fixups.
> 
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |  114 +++++++++++++++++++++++++++++
>  1 files changed, 114 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index 25f8bc7..b1bf06d 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
[...]

Hi Andy,

Just two fluffy comments...

> +static int __init board_fixups(void)
> +{
> +	char phy_id[BUS_ID_SIZE];
> +	struct device_node *mdio;
> +	struct resource res;
> +
> +	/* Register a workaround to fixup the clock source */
> +	mdio = of_find_node_by_name(NULL, "mdio");

MPC8568E-MDS can use either one of two mdio buses, so I'd suggest to
do fixups for both via of_find_compatible_node(), or
for_each_compatible_node().

> +	of_address_to_resource(mdio, 0, &res);
> +	snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
> +
> +	phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
> +	phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
> +
> +	/* Register a workaround for errata */
> +	snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
> +	phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);

of_node_put(mdio); is missing here, I think.

> +	return 0;
> +}
> +arch_initcall(board_fixups);

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
