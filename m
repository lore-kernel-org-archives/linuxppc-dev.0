Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1fycu5j4o.fsf@ebiederm.dsl.xmission.com>
References: <1162884080.585336.70559261997.qpush@cradle>
	<1162885276.28571.444.camel@localhost.localdomain>
	<20061107080257.GA5874@kroah.com>
	<1162963101.20271.18.camel@localhost.localdomain>
	<m1fycu5j4o.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zJgn2N6pnxY16ppNepSd"
Date: Thu, 09 Nov 2006 10:33:56 +1100
Message-Id: <1163028836.7630.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zJgn2N6pnxY16ppNepSd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 03:26 -0700, Eric W. Biederman wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> >> Oh, and I think your first two patches can be applied now to the tree
> >> (header file changes).  Any objection to me doing this?
> >
> > There's a trivial bug in 1/7 (HT #defines), so hold back on that one
> > until I resend. The movement of MSI-X #defines is good to go. I also
> > sent you the patch to add HT_SUBCAP_OFFSET yesterday that I think is
> > ready to merge.
>=20
> Actually now that I am thinking about it I'm not at all certain about
> the HT_SUBCAP_OFFSET patch.  The basic issue is that it suggests that
> the field that specifies which type of hypertransport capability has a
> fixed number of bits.  While in reality the encoding is variable
> length.

Yeah OK, I did notice that was a bit weird, I had a quick look and
assumed that because all the HT_CAPTYPE's were #defined as byte values
it was OK.

Looking closer most of them are 5 bits, the high 5 bits, and happen to
sit next to reserved fields (which must be zero), so reading the byte
should work in practice. But for a few of them you'll get cruft in the
low bits.

I don't know what they were thinking when they decided to have 3 and 5
bit capability fields, and then specify some of them as being a byte
wide as well. Perhaps the spec committee had a big night out ;)

I was going to write a generic version of pci_find_ht_capability() (as
suggested by Segher), so along with that I'll clean up the #defines to
just be the 3 or 5 bit capability codes, and then have a shift for
getting the capability out of the byte.

Users will still need to know if they're looking for a 3 or 5 bit
capability, but we can encapsulate that in pci_find_ht_capability() and
hopefully most people won't have to see the difference.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zJgn2N6pnxY16ppNepSd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUmlkdSjSd0sB4dIRAq32AJ91Q4L+R55ZrSrTOdWNrzUL+5iKowCfRLSA
NXK86Itj45LbEKwE8a9ch+k=
=ORYz
-----END PGP SIGNATURE-----

--=-zJgn2N6pnxY16ppNepSd--
