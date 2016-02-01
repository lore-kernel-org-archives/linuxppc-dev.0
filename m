Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28C761A0176
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 22:07:14 +1100 (AEDT)
Date: Mon, 1 Feb 2016 22:04:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 7/9] pseries: Add support for hash table resizing
Message-ID: <20160201110411.GJ23043@voom.redhat.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-8-git-send-email-david@gibson.dropbear.id.au>
 <56AF17CD.3080300@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A1+ljxmNgwU2bK8G"
In-Reply-To: <56AF17CD.3080300@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--A1+ljxmNgwU2bK8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 02:01:09PM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:54 AM, David Gibson wrote:
>=20
> > +
> > +static int pseries_lpar_resize_hpt_commit(void *data)
> > +{
> > +	struct hpt_resize_state *state =3D data;
> > +
> > +	state->commit_rc =3D plpar_resize_hpt_commit(0, state->shift);
> > +	if (state->commit_rc !=3D H_SUCCESS)
> > +		return -EIO;
> > +
> > +	/* Hypervisor has transitioned the HTAB, update our globals */
> > +	ppc64_pft_size =3D state->shift;
> > +	htab_size_bytes =3D 1UL << ppc64_pft_size;
> > +	htab_hash_mask =3D (htab_size_bytes >> 7) - 1;
> > +
> > +	return 0;
> > +}
> > +
>=20
> snip
>=20
> > +/* Must be called in user context */
> > +static int pseries_lpar_resize_hpt(unsigned long shift)
> > +{
> > +	struct hpt_resize_state state =3D {
> > +		.shift =3D shift,
> > +		.commit_rc =3D H_FUNCTION,
>=20
> > +
> > +	rc =3D stop_machine(pseries_lpar_resize_hpt_commit, &state, NULL);
>=20
> With my limited knowledge of stop_machine, wondering if the current
> or any future version of 'pseries_lpar_resize_hpt_commit' function
> can cause HPT change (page fault path) while stop is executing it.

It can, but the H_RESIZE_HPT_COMMIT hypercall is synchronous so the
cpu executing it can't make any HPT updates during it.  The
stop_machine() prevents any other cpus doing HPT updates.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A1+ljxmNgwU2bK8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWrzurAAoJEGw4ysog2bOSrHsP/08d84N9HrdqYft0PrK2IzPS
G92gEpPGpo8m79I8c0voNv/nQV1KvsWhTP8tW4ebB+kWLayRokbsMNbYrTNhfJj3
NxaIgxFD/vfFgJGcn8AqIjCfD3hlpkR21iA5jNtrBJQFqzMKAK1meYk0ZC8MAv5r
cHXr0sMUoOpXnsXGQF1oVaEdwwyaP0kGfEu2tsokM0VrCqIzPb4XLxdH9qRwv9/3
CcqL/JXSYjjg6/OUVcxc3KD4W9eUOlqp2M4cTFEWbJdN+KHBqQzwdumZWVqoRD76
Q/GsZ2pa/g3MHRVmCURHw94etDInkO+gZXPKiXAYiJyu6bbqTN9tbbZvVyd7WI8I
20/CQUOhSZ3hKG39gO0lbKZbUWS8Dxq3QzLDVMTEpD3lFfv5+Yx+8204ulSOkfZ+
ENwfbrOXnnKzYBAmm2vzEyshK3eOCVTPlqiThvoQfiaJ9zKf1BzSS2mRKYNI3IRM
ynX1nKLnvMSNCv6jgaLEn19BzV2oswSXw+epioYc+9YuF1ikcUPAfTsypg5fMJQh
HPF0tD26FYd+Sfv6lNUYIFicNh9O0wWxRMD+CvNZe3a5sz7tSkjaX7c6ZjRi4Xgc
/WorVk1+IoYwUJjnJm8GDWv1T2Wzr2zmKHGaDdgZDBcyfWyk5iD2VbLyUrcoWB9h
SM+fYaFlsW77/Q1oaFR6
=mj30
-----END PGP SIGNATURE-----

--A1+ljxmNgwU2bK8G--
