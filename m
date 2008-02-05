Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57712DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 15:21:48 +1100 (EST)
Date: Tue, 5 Feb 2008 15:21:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] of: add alias helper functions.
Message-Id: <20080205152129.fa482b5f.sfr@canb.auug.org.au>
In-Reply-To: <20080204161604.10674.9289.stgit@trillian.secretlab.ca>
References: <20080204161604.10674.9289.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_15_21_29_+1100_blr.cDevPXK4jAK0"
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_15_21_29_+1100_blr.cDevPXK4jAK0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Mon, 04 Feb 2008 09:16:08 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Add helper functions for translating back and forth between alias
> properties and device tree nodes.

Do you have a use for this yet (I assume you do - it would be nice to
have a reason in the changelog)?

Overall looks ok, just a few comments?

Dave (Miller) is this useful for Sparc?

> +struct device_node *of_find_node_by_alias(const char *alias)
> +{
> +	struct device_node *np, *alias_np;
> +	const char *path;
> +
> +	np =3D NULL;

	struct device_node *np =3D NULL;
	struct device_node *alias_np;

> +const char *of_node_alias(struct device_node *np, const char *prefix)

> +	/* Loop over the aliases looking for a match */
> +	alias =3D NULL;
> +	for (pp =3D alias_np->properties; pp !=3D 0; pp =3D pp->next) {
                                              ^
Use NULL for pointers (or just test "pp").

> +		if (test_np =3D=3D np)
> +			alias =3D pp->name + prefix_len;
> +		of_node_put(test_np);
> +		if (alias)
> +			break;

This could be:
		of_node_put(test_np);
		if (test_np =3D=3D np) {
			alias =3D pp->name + prefix_len;
			break;
		}

As you can still test for pointer equality after dropping the ref count.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_15_21_29_+1100_blr.cDevPXK4jAK0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHp+RXTgG2atn1QN8RAmh5AJ936NF1Fqh98bF5B2AH6YCO1CwRSgCeIBz6
SD5Kk2PBWcQ67WNk54OFdyQ=
=aRFW
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_15_21_29_+1100_blr.cDevPXK4jAK0--
