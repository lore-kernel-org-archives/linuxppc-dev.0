Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 15 Jan 2008 10:19:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
Message-Id: <20080115101936.d186329d.sfr@canb.auug.org.au>
In-Reply-To: <20080114225150.GB21940@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_10_19_36_+1100_jpJS.zyE9Rpmc9GI"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_10_19_36_+1100_jpJS.zyE9Rpmc9GI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 14 Jan 2008 15:51:50 -0700 "Mark A. Greer" <mgreer@mvista.com> wrot=
e:
>
> +static inline struct pci_controller *mv64x60_find_hose(u32 idx)
> +{
> +	struct device_node *phb;
> +	struct pci_controller *hose;
> +	const u32 *prop;
> +	int len;
> +
> +	for_each_compatible_node(phb, "pci", "marvell,mv64360-pci") {
> +		prop =3D of_get_property(phb, "cell-index", &len);
> +		if (prop && (len =3D=3D sizeof(prop)) && (*prop =3D=3D idx)) {
> +			hose =3D pci_find_hose_for_OF_device(phb);
> +			of_node_put(phb);
> +			return hose;
> +		}
> +	}
> +
> +	return NULL;
> +}

I would think that this is way to big to inline ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_10_19_36_+1100_jpJS.zyE9Rpmc9GI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi+4MTgG2atn1QN8RAlEFAJ9mitAsd0UUfPMnYzrlfogNM9apEQCfb9mE
kAVeh2qJL9ARtlKQeIHPFA8=
=XfMM
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_10_19_36_+1100_jpJS.zyE9Rpmc9GI--
