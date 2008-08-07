Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] powerpc: set up OF properties for ppc32 kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080801141414.GA1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141414.GA1161@polina.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jhCQA62aYiJVj7WcvuG/"
Date: Thu, 07 Aug 2008 20:44:27 +1000
Message-Id: <1218105867.7914.8.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jhCQA62aYiJVj7WcvuG/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-01 at 18:14 +0400, Anton Vorontsov wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>=20
> Refactor the setting of kexec OF properties, moving the common code
> from machine_kexec_64.c to machine_kexec.c where it can be used on
> both ppc64 and ppc32.  This is needed for kexec to work on ppc32
> platforms.

Hi Anton,


> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/ma=
chine_kexec.c
> index aab7688..a625673 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
...
> +
> +static int __init kexec_setup(void)
> +{
> +	struct device_node *node;
> +
> +	node =3D of_find_node_by_path("/chosen");
> +	if (!node)
> +		return -ENOENT;
> +
> +	kernel_end =3D __pa(_end);
> +	prom_add_property(node, &kernel_end_prop);
> +
> +	of_node_put(node);
> +	return 0;
> +}
> +__initcall(kexec_setup);

__initcall() is supposedly deprecated, use device_initcall() instead.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jhCQA62aYiJVj7WcvuG/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBImtILdSjSd0sB4dIRAnKSAJ97uQIDwXHsQ27y7Ggd4z6JIWWfSACeIgId
LP7urJcYSmXdtCYz8K4ftLU=
=xnkX
-----END PGP SIGNATURE-----

--=-jhCQA62aYiJVj7WcvuG/--
