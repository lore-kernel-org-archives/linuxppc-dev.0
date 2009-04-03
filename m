Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AA21DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 17:51:20 +1100 (EST)
Subject: Re: [v1 PATCH 3/3] EDAC: CPC925 MC platform device setup
From: Michael Ellerman <michael@ellerman.id.au>
To: Harry Ciao <qingtao.cao@windriver.com>
In-Reply-To: <1238739044-19926-2-git-send-email-qingtao.cao@windriver.com>
References: <1238739044-19926-1-git-send-email-qingtao.cao@windriver.com>
	<1238739044-19926-2-git-send-email-qingtao.cao@windriver.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-uUVmyNjFnEr3sQ65qiVy"
Date: Fri, 03 Apr 2009 17:51:18 +1100
Message-Id: <1238741478.6802.44.camel@localhost>
Mime-Version: 1.0
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uUVmyNjFnEr3sQ65qiVy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-04-03 at 14:10 +0800, Harry Ciao wrote:
> Setup a platform device for the CPC925 Memory Controller during system
> booting up, against which CPC925 MC EDAC driver would be matched.
>=20
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  arch/powerpc/platforms/maple/setup.c |   47 ++++++++++++++++++++++++++++=
++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platform=
s/maple/setup.c
> index bfd60e4..ca8a3ff 100644
> --- a/arch/powerpc/platforms/maple/setup.c
> +++ b/arch/powerpc/platforms/maple/setup.c
> @@ -335,3 +335,50 @@ define_machine(maple) {
>  	.progress		=3D maple_progress,
>  	.power_save		=3D power4_idle,
>  };
> +
> +#ifdef CONFIG_EDAC
> +#define CPC925_MC_START		0xf8000000
> +#define CPC925_MC_END		0xf8ffffff /* sizeof 16MB */
> +/* Register a platform device for CPC925 memory controller */
> +static int __init maple_cpc925_edac_setup(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np =3D NULL;
> +	struct resource r;
> +
> +	np =3D of_find_node_by_name(NULL, "hostbridge");

This is way too generic IMHO. You're going to match on any node called
"hostbridge" on any 64-bit powerpc machine, there's a good chance there
are other firmwares out there with such a node, or will be in the
future.

Is there no compatible or model property you can look for, so you're at
least somewhat confident you're actually looking at a CPC925?

If not this should be a machine_initcall() for Maple only.

> +	if (of_address_to_resource(np, 0, &r)) {
> +		/*
> +		 * of_address_to_resource() would get the #address-cells
> +		 * and #size-cells properties for a node from its parent.
> +		 * On Maple 64bit target hostbridge parent node has specified
> +		 * both of these two properties to be 2. However, the actual
> +		 * "cell" value for host bridge node is 1. Since we can't
> +		 * fix this firmware-generated DTB, we have to setup a
> +		 * resource structure manually.
> +		 */
> +		memset(&r, 0, sizeof(r));
> +		r.start =3D CPC925_MC_START;
> +		r.end =3D CPC925_MC_END;
> +		r.name =3D "hostbridge";
> +		r.flags =3D IORESOURCE_MEM;

We do have fixups for bogus firmware including maple, look in
prom_init.c:fixup_device_tree_maple(). Although that's for actual
firmware, not a DTB.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uUVmyNjFnEr3sQ65qiVy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknVseYACgkQdSjSd0sB4dJnuACeL3vn4jakwJH10VBh25QYoJD0
8IIAnjR5Me2No6GDLVV6HdhSp7qrMGRZ
=xG/v
-----END PGP SIGNATURE-----

--=-uUVmyNjFnEr3sQ65qiVy--
