Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E86DDDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 19:51:19 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2L8pChb001314 for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 01:51:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2L8pAa4024627
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 03:51:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Add Fixed PHY support for ucc_geth
Date: Fri, 21 Mar 2008 16:51:04 +0800
Message-ID: <989B956029373F45A0B8AF029708189001D1954D@zch01exm26.fsl.freescale.net>
In-Reply-To: <1205833615-15833-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <>
	<1205833615-15833-1-git-send-email-Joakim.Tjernlund@transmode.se>
From: "Li Yang" <LeoLi@freescale.com>
To: "Jeff Garzik" <jeff@garzik.org>
Cc: Netdev <netdev@vger.kernel.org>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]=20
> Sent: Tuesday, March 18, 2008 5:47 PM
> To: Netdev; Li Yang; Linuxppc-Embedded@Ozlabs.Org
> Cc: Joakim Tjernlund
> Subject: [PATCH] Add Fixed PHY support for ucc_geth
>=20
> The new Fixed PHY method, fixed-link property, isn't
> impl. for ucc_geth which makes fixed PHYs non functional.
> Add support for the new method to restore the Fixed PHY
> functionality.
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Signed-off-by: Li Yang <leoli@freescale.com>

---
Ps: This patch depends on the patch "ucc_geth: use correct thread number
for 10/100Mbps link" to apply, which hasn't made to Linus' tree for now
but has already been in Jeff and David's trees.

> ---
>=20
> This is a regression as fixed PHYs works in 2.6.23 and I am
> using it.
>=20
>  drivers/net/ucc_geth.c |   53=20
> +++++++++++++++++++++++++++--------------------
>  1 files changed, 30 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index ecc5712..18c8b39 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3836,6 +3836,7 @@ static int ucc_geth_probe(struct=20
> of_device* ofdev, const struct of_device_id *ma
>  	struct device_node *phy;
>  	int err, ucc_num, max_speed =3D 0;
>  	const phandle *ph;
> +	const u32 *fixed_link;
>  	const unsigned int *prop;
>  	const char *sprop;
>  	const void *mac_addr;
> @@ -3926,18 +3927,38 @@ static int ucc_geth_probe(struct=20
> of_device* ofdev, const struct of_device_id *ma
> =20
>  	ug_info->uf_info.regs =3D res.start;
>  	ug_info->uf_info.irq =3D irq_of_parse_and_map(np, 0);
> +	fixed_link =3D of_get_property(np, "fixed-link", NULL);
> +	if (fixed_link) {
> +		ug_info->mdio_bus =3D 0;
> +		ug_info->phy_address =3D fixed_link[0];
> +		phy =3D NULL;
> +	} else {
> +		ph =3D of_get_property(np, "phy-handle", NULL);
> +		phy =3D of_find_node_by_phandle(*ph);
> =20
> -	ph =3D of_get_property(np, "phy-handle", NULL);
> -	phy =3D of_find_node_by_phandle(*ph);
> +		if (phy =3D=3D NULL)
> +			return -ENODEV;
> =20
> -	if (phy =3D=3D NULL)
> -		return -ENODEV;
> +		/* set the PHY address */
> +		prop =3D of_get_property(phy, "reg", NULL);
> +		if (prop =3D=3D NULL)
> +			return -1;
> +		ug_info->phy_address =3D *prop;
> +
> +		/* Set the bus id */
> +		mdio =3D of_get_parent(phy);
> +
> +		if (mdio =3D=3D NULL)
> +			return -1;
> =20
> -	/* set the PHY address */
> -	prop =3D of_get_property(phy, "reg", NULL);
> -	if (prop =3D=3D NULL)
> -		return -1;
> -	ug_info->phy_address =3D *prop;
> +		err =3D of_address_to_resource(mdio, 0, &res);
> +		of_node_put(mdio);
> +
> +		if (err)
> +			return -1;
> +
> +		ug_info->mdio_bus =3D res.start;
> +	}
> =20
>  	/* get the phy interface type, or default to MII */
>  	prop =3D of_get_property(np, "phy-connection-type", NULL);
> @@ -3982,20 +4003,6 @@ static int ucc_geth_probe(struct=20
> of_device* ofdev, const struct of_device_id *ma
>  		ug_info->numThreadsRx =3D UCC_GETH_NUM_OF_THREADS_4;
>  	}
> =20
> -	/* Set the bus id */
> -	mdio =3D of_get_parent(phy);
> -
> -	if (mdio =3D=3D NULL)
> -		return -1;
> -
> -	err =3D of_address_to_resource(mdio, 0, &res);
> -	of_node_put(mdio);
> -
> -	if (err)
> -		return -1;
> -
> -	ug_info->mdio_bus =3D res.start;
> -
>  	if (netif_msg_probe(&debug))
>  		printk(KERN_INFO "ucc_geth: UCC%1d at 0x%8x=20
> (irq =3D %d) \n",
>  			ug_info->uf_info.ucc_num + 1,=20
> ug_info->uf_info.regs,
> --=20
> 1.5.4.3
>=20
>=20
