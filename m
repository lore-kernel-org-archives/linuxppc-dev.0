Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <30983.1273620594@neuling.org>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia>  <30983.1273620594@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-wnrJa93KBardFtse2eHB"
Date: Wed, 12 May 2010 10:36:05 +1000
Message-ID: <1273624565.5738.8.camel@concordia>
Mime-Version: 1.0
Cc: kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-wnrJa93KBardFtse2eHB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-12 at 09:29 +1000, Michael Neuling wrote:
>=20
> In message <1273561463.9209.138.camel@concordia> you wrote:
> >=20
> > --=3D-S056dRzmrEHDBzKyyTOs
> > Content-Type: text/plain; charset=3D"UTF-8"
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > On Tue, 2010-05-11 at 16:28 +1000, Michael Neuling wrote:
> > > Currently for kexec the PTE tear down on 1TB segment systems normally
> > > requires 3 hcalls for each PTE removal. On a machine with 32GB of
> > > memory it can take around a minute to remove all the PTEs.
> > >=3D20
> > ..
> > > -	/* TODO: Use bulk call */
> >=20
> > ...
> > > +	/* Read in batches of 4,
> > > +	 * invalidate only valid entries not in the VRMA
> > > +	 * hpte_count will be a multiple of 4
> > > +         */
> > > +	for (i =3D3D 0; i < hpte_count; i +=3D3D 4) {
> > > +		lpar_rc =3D3D plpar_pte_read_4_raw(0, i, (void *)ptes);
> > > +		if (lpar_rc !=3D3D H_SUCCESS)
> > > +			continue;
> > > +		for (j =3D3D 0; j < 4; j++){
> > > +			if ((ptes[j].pteh & HPTE_V_VRMA_MASK) =3D3D=3D3D
> > > +				HPTE_V_VRMA_MASK)
> > > +				continue;
> > > +			if (ptes[j].pteh & HPTE_V_VALID)
> > > +				plpar_pte_remove_raw(0, i + j, 0,
> > > +					&(ptes[j].pteh), &(ptes[j].ptel));
> > >  		}
> >=20
> > Have you tried using the bulk remove call, if none of the HPTEs are for
> > the VRMA? Rumour was it was slower/the-same, but that may have been
> > apocryphal.
>=20
> No, I didn't try it.
>=20
> I think the real solution is to ask FW for a new call to do it all for
> us.

Sure, you could theoretically still get a 4x speedup though by using the
bulk remove.

cheers

--=-wnrJa93KBardFtse2eHB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvp9/EACgkQdSjSd0sB4dIC+QCfTHHtIIgdcfFXnxKqQ6RhAv4T
QBEAnjbEQcouUqiDUz9k4LT3LSjWO69e
=8xkb
-----END PGP SIGNATURE-----

--=-wnrJa93KBardFtse2eHB--
