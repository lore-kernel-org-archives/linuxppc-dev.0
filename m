Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BDD15DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 10:05:16 +1100 (EST)
Date: Tue, 8 Jan 2008 10:05:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2/3] add MPC837x USB platform support
Message-Id: <20080108100504.5263632b.sfr@canb.auug.org.au>
In-Reply-To: <1199707400-23588-2-git-send-email-leoli@freescale.com>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<1199707400-23588-2-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_10_05_04_+1100_FfYD1Hvdcv2.q42+"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_10_05_04_+1100_FfYD1Hvdcv2.q42+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Just a couple of comments.

On Mon,  7 Jan 2008 20:03:19 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +static int mpc837xmds_usb_cfg(void)
> +{
>
> +	np =3D of_find_node_by_name(NULL, "usb");
> +	phy_type =3D of_get_property(np, "phy_type", NULL);

No check for np being NULL

> +	if (phy_type && !strcmp(phy_type, "ulpi")) {
> +		clrbits8(bcsr_regs + 12, BCSR12_USB_SER_PIN);
> +	} else if (phy_type && !strcmp(phy_type, "serial")) {
> +		mode =3D of_get_property(np, "dr_mode", NULL);
> +		bcsr12 =3D in_8(bcsr_regs + 12) & ~BCSR12_USB_SER_MASK;
> +		bcsr12 |=3D BCSR12_USB_SER_PIN;
> +		if (mode && !strcmp(mode, "peripheral"))
> +			bcsr12 |=3D BCSR12_USB_SER_DEVICE;
> +		out_8(bcsr_regs + 12, bcsr12);
> +	} else {
> +		printk(KERN_ERR "USB DR: unsupported PHY\n");
> +	}
> +
> +	iounmap(bcsr_regs);
> +	return 0;

No of_node_put(np)

> +#ifdef CONFIG_PPC_MPC837x
> +int mpc837x_usb_cfg(void)
> +{
>
> +	np =3D of_find_compatible_node(NULL, "usb", "fsl-usb2-dr");
> +	if (!np)
> +		return -ENODEV;
> +	prop =3D of_get_property(np, "phy_type", NULL);
> +
> +	if (strcmp(prop, "ulpi") && strcmp(prop, "serial")) {

No check for prop being NULL.

> +		printk(KERN_WARNING "837x USB PHY type not supported\n");
> +		return -EINVAL;

No of_node_put(np)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_10_05_04_+1100_FfYD1Hvdcv2.q42+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgrAlTgG2atn1QN8RApW9AJ4p62owqyLE/vlVlbFzyRAEySDP+QCfTj3z
6TwHREMq0zqNdQhAflCD9m8=
=egfn
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_10_05_04_+1100_FfYD1Hvdcv2.q42+--
