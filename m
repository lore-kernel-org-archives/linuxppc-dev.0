Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 340F7DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 16:48:59 +1100 (EST)
Date: Mon, 14 Jan 2008 16:48:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-Id: <20080114164850.eaa0ff5d.sfr@canb.auug.org.au>
In-Reply-To: <20080111200742.GB696@loki.buserror.net>
References: <20080111200742.GB696@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jan_2008_16_48_50_+1100_aw6Qpg+_NHZ+rpB5"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Jan_2008_16_48_50_+1100_aw6Qpg+_NHZ+rpB5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Fri, 11 Jan 2008 14:07:42 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/82xx/ep8248e.c

> +static struct mdiobb_ops ep8248e_mdio_ops =3D {

const, please.

> +static struct of_platform_driver ep8248e_mdio_driver =3D {

	.driver =3D {

> +	.name =3D "ep8248e-mdio-bitbang",

	},

> +static const struct cpm_pin ep8248_pins[] =3D {

Could be __initdata

> +static void __init ep8248_setup_arch(void)
> +{

> +	ep8248e_bcsr_node =3D
> +		of_find_compatible_node(NULL, NULL, "fsl,ep8248e-bcsr");
> +	if (!ep8248e_bcsr_node) {
> +		printk(KERN_ERR "No bcsr in device tree\n");
> +		return;
> +	}
> +
> +	ep8248e_bcsr =3D of_iomap(ep8248e_bcsr_node, 0);
> +	if (!ep8248e_bcsr) {
> +		printk(KERN_ERR "Cannot map BCSR registers\n");

		of_node_put(ep8248e_bcsr_node);
		ep8248e_bcsr_node =3D NULL;

> +		return;

> +static int __init declare_of_platform_devices(void)
> +{
> +	if (!machine_is(ep8248))
> +		return 0;
> +
> +	of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +	of_register_platform_driver(&ep8248e_mdio_driver);
> +
> +	return 0;
> +}
> +device_initcall(declare_of_platform_devices);

machine_device_initcall(ep8248, declare_of_platform_devices);
Then remove the machine_is test above.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jan_2008_16_48_50_+1100_aw6Qpg+_NHZ+rpB5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHivfJTgG2atn1QN8RAhjKAJwKwEqbU/DfkMdSaPVeRnlVxwS5PgCZAaKP
RW9vY/1JZ1+UsqOugAkhwHA=
=WRzM
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jan_2008_16_48_50_+1100_aw6Qpg+_NHZ+rpB5--
