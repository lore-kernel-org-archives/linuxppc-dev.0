Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] [POWERPC] pasemi: Implement MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071212072310.GA3173@lixom.net>
References: <20071212063406.GA786@lixom.net>
	<20071212064446.GB786@lixom.net> <1197442179.24356.3.camel@concordia>
	<20071212072310.GA3173@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Am8mlh/QF8l+5VciBOGM"
Date: Thu, 13 Dec 2007 09:51:11 +1100
Message-Id: <1197499871.7695.9.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Am8mlh/QF8l+5VciBOGM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-12 at 01:23 -0600, Olof Johansson wrote:
> On Wed, Dec 12, 2007 at 05:49:39PM +1100, Michael Ellerman wrote:
> > Before the ugliness spreads .. I'm pretty sure we can get this from the
> > chip_data of the virq - I haven't fixed it though because I wasn't sure
> > if using chip_data was kosher or not.
>=20
> Hmm, maybe.
>=20
> I can forsee MSI and legacy interrupts being handled by different irq
> hosts on systems where they are cascaded, so I'm not 100% sure that's a
> workable way to do it (I assume you'd look it up through the pci_dev's
> legacy irq field, right?).

No you're right that won't work, what I had in mind would work for
teardown, we could get the mpic from the chip_data of each virq.

But for setup we need to know which mpic to create the mapping on
_before_ it's mapped (obviously) so using chip_data doesn't work. And
yeah, guessing based on the legacy irq of the pci_dev would not be safe.

The only safe way to do it I think would be to walk up the interrupt
tree and find the interrupt controller node, then do an irq_find_host(),
but that's a lot of fuss to save one static variable :)

Patch looks good otherwise.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Am8mlh/QF8l+5VciBOGM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYGXfdSjSd0sB4dIRAuJxAKCRXiU4bFBBMCv0gJbeJS6P19cZGgCfXVpM
4ZcNe18wzlpV/GwQTFSMEIs=
=9Vy7
-----END PGP SIGNATURE-----

--=-Am8mlh/QF8l+5VciBOGM--
