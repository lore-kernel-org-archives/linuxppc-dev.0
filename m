Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F32631A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 12:20:43 +1100 (AEDT)
Date: Tue, 9 Feb 2016 10:43:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 3/9] arch/powerpc: Handle removing maybe-present bolted
 HPTEs
Message-ID: <20160209004312.GD29288@voom.bne.redhat.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
 <20160208025404.GC30807@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
In-Reply-To: <20160208025404.GC30807@oak.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 01:54:04PM +1100, Paul Mackerras wrote:
> On Fri, Jan 29, 2016 at 04:23:57PM +1100, David Gibson wrote:
> > At the moment the hpte_removebolted callback in ppc_md returns void and
> > will BUG_ON() if the hpte it's asked to remove doesn't exist in the fir=
st
> > place.  This is awkward for the case of cleaning up a mapping which was
> > partially made before failing.
> >=20
> > So, we add a return value to hpte_removebolted, and have it return ENOE=
NT
> > in the case that the HPTE to remove didn't exist in the first place.
> >=20
> > In the (sole) caller, we propagate errors in hpte_removebolted to its
> > caller to handle.  However, we handle ENOENT specially, continuing to
> > complete the unmapping over the specified range before returning the er=
ror
> > to the caller.
> >=20
> > This means that htab_remove_mapping() will work sanely on a partially
> > present mapping, removing any HPTEs which are present, while also retur=
ning
> > ENOENT to its caller in case it's important there.
> >=20
> > There are two callers of htab_remove_mapping():
> >    - In remove_section_mapping() we already WARN_ON() any error return,
> >      which is reasonable - in this case the mapping should be fully
> >      present
> >    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that=
 to
> >      just a WARN_ON() in the case of ENOENT, since failing to remove a
> >      mapping that wasn't there in the first place probably shouldn't be
> >      fatal.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> [snip]
>=20
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -269,6 +269,7 @@ int htab_remove_mapping(unsigned long vstart, unsig=
ned long vend,
> >  {
> >  	unsigned long vaddr;
> >  	unsigned int step, shift;
> > +	int rc =3D 0;
> > =20
> >  	shift =3D mmu_psize_defs[psize].shift;
> >  	step =3D 1 << shift;
> > @@ -276,10 +277,13 @@ int htab_remove_mapping(unsigned long vstart, uns=
igned long vend,
> >  	if (!ppc_md.hpte_removebolted)
> >  		return -ENODEV;
> > =20
> > -	for (vaddr =3D vstart; vaddr < vend; vaddr +=3D step)
> > -		ppc_md.hpte_removebolted(vaddr, psize, ssize);
> > +	for (vaddr =3D vstart; vaddr < vend; vaddr +=3D step) {
> > +		rc =3D ppc_md.hpte_removebolted(vaddr, psize, ssize);
> > +		if ((rc < 0) && (rc !=3D -ENOENT))
> > +			return rc;
> > +	}
> > =20
> > -	return 0;
> > +	return rc;
>=20
> This will return the rc from the last hpte_removebolted call, which
> might be 0 even if earlier calls had returned -ENOENT.  Or, if the
> last call fails with -ENOENT, this will return -ENOENT.  Is that
> exactly what you meant?  In the case where some calls to
> hpte_removebolted return -ENOENT, I would think we would want a
> consistent return value, which could be either 0 or -ENOENT, but it
> shouldn't depend on which specific calls fail with -ENOENT, in my
> opinion.

I agree.  The intention was that this returned -ENOENT iff any of the
individual calls did, but I messed up the logic; thanks for the catch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuTYgAAoJEGw4ysog2bOSXE8P/iWlaKlaDn59Gta3ZGpxhWh1
iL3AwZHDL++WX/p38fPGEZdPPg9IEkkICZbCzmZTNJOk8iUuqUfMgbj6Rp+sU9WY
cU9YRPYT5yaHVKGPVYcArYyzkjIxGZSNHChw4UMvuGef4O3tN+Rk60aqKCndB8Kn
obIDAYK+z0BDBEmU1DlsjlrW9IZ8LDKsfnzQxSRSnEjRXsIAOIwTSTa2pXxq96qt
XKOAEIrhY/AqQ9fw/4SBDwDIbwQU4LzWvIIS5iFJRXHgC/wDmhbZ4eFpwQmRDo+F
Q1aYwIMcedTMQVlRrUywy+ZDL/1J15utUjbzenokKRzehvfFwNU77MXFA076ZjDE
fGIh41eqpxXaZREDKJE86+jAAZVsxazO2apjNTUjFlxVvgVW6BLdIjL64LycEjkz
nyO/PC/BdWYejK84gF/7N5Z5EZQDifPV7y7d31Tq2wVylUiaovKAskgVeiCa51j6
+klyvAK0wLNk/NJFnWA1VLi7ihTJZR8lHQhLcl7aGwhAGAhaU9+DsF7Gik3zELzJ
H5yWKWuGcdbYwMcX+nqwGsPNzvz7d0BziE0OHkJ7IkEKM19ZboOuWrzQqGDZslcG
aB2EgXgmT+TTyue1lDdAnWb+SnDT6E1E/0Ny3xicqWY5gfsGGZFyB4xqKtoYJoy5
7qE02BMUcNyn+dqKxcUd
=RPxp
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
