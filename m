Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id B910B2C033E
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:52:39 +1000 (EST)
Date: Fri, 28 Jun 2013 14:52:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Rename and flesh out the facility
 unavailable exception handler
Message-Id: <20130628145233.fbb425ab15ecec454744a3a2@canb.auug.org.au>
In-Reply-To: <20130627141631.GA13867@concordia>
References: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
 <1372146477-4338-3-git-send-email-michael@ellerman.id.au>
 <20130627140539.5ff63bad1e7e99e5526d0f3d@canb.auug.org.au>
 <20130627141631.GA13867@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__28_Jun_2013_14_52_33_+1000_b5/T6XhPyc81Qf.o"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__28_Jun_2013_14_52_33_+1000_b5/T6XhPyc81Qf.o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 28 Jun 2013 00:16:31 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> On Thu, Jun 27, 2013 at 02:05:39PM +1000, Stephen Rothwell wrote:
> >=20
> > On Tue, 25 Jun 2013 17:47:56 +1000 Michael Ellerman <michael@ellerman.i=
d.au> wrote:
> > >
> > > -void tm_unavailable_exception(struct pt_regs *regs)
> > > +void facility_unavailable_exception(struct pt_regs *regs)
> > >  {
> > > +	static char *facility_strings[] =3D {
> > > +		"FPU",
> > > +		"VMX/VSX",
> > > +		"DSCR",
> > > +		"PMU SPRs",
> > > +		"BHRB",
> > > +		"TM",
> > > +		"AT",
> > > +		"EBB",
> > > +		"TAR",
> > > +	};
> >=20
> > Are the indexes into this array defined somewhere?  If not, can we do
> > that.  Then, can we use explicit indexed initialisers for this array?
>=20
> I'm not sure I follow.
>=20
> The mapping is defined by the definition of the "Interruption Cause"
> field of the FSCR, section 6.2.10 of PowerISA v2.07.

OK, so these numbers are externally defined:

#define FSCR_INT_CAUSE_FPU	0
...
#define FSCR_INT_CAUSE_TAR	8

(or maybe an enum)

	static char *facility_strings[] =3D {
		[ FSCR_INT_CAUSE_FPU ] =3D "FPU",
		[ FSCR_INT_CAUSE_VMX_VSX ] =3D "VMX/VSX",
		[ FSCR_INT_CAUSE_DSCR ] =3D "DSCR",
		[ FSCR_INT_CAUSE_PMU_SPRs ] =3D "PMU SPRs",
		[ FSCR_INT_CAUSE_BHRB ] =3D "BHRB",
		[ FSCR_INT_CAUSE_TM ] =3D "TM",
		[ FSCR_INT_CAUSE_AT ] =3D "AT",
		[ FSCR_INT_CAUSE_EBB ] =3D "EBB",
		[ FSCR_INT_CAUSE_TAR ] =3D "TAR",
	};

Or something similar.  Of course, then your code should cope with
facility_strings[...] being NULL.  This makes it very clear that these
things are not just "made up" for your code.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__28_Jun_2013_14_52_33_+1000_b5/T6XhPyc81Qf.o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRzRaUAAoJEECxmPOUX5FE0A0P/3jJbIZucyl1NWto3yp0MRLn
jo/1UYRde1dcXuGaMQzji4a5+vFbLYIpkFf6reewvCHbrmG7eF+8G5vBMc1mU7tT
hv2jNpPauTS8o7VZhGxADRXxT/lXuL24JlDpYhfOMjveilJbAB8sPDS3ETqZs8N8
mzUmLCvleA/pLlSTyz1YbZjSi/+arUYIfKBOTbHA2SMM5vOp2gU16kdYiQphuimB
GbkQYYYBYor6ZwTItO2NkVXBDKwgqzOcbFazMCTv+l9o1mmEuVma2sxPmFTGJUcj
p0vd+l9pExJr/xl2HDfR2l9ciAwE8wTBGy+lb40i73mtf3o6NfJDhVCR654Mqmox
xWAO5Y4Y7FLZa0AcKR4tI1GA65lgGA8AqTZj9XT+NeyeDs8qtpwa06hdW6pAB6BT
Q8C8JaSqekKVU5ikoPyHgo8R6EET9gRxz9YX/jP8We4v570s3YBvAKwmkH/IFMoD
ReL6FrbAPbLJWpSr/L2daAXkpNoJEqr/IrL57zigm6F4rsQghukBIWetdgY06Ek1
vbiPnuUOZ7FNb+DVIDr1GRTgMDXWpPCF+P97JU9dQsu8ifVeQLEV3geA36Lg8bBF
NAu/uxIP2pqkx/9eyAtlom75+WD+tw5PCi4+A+QrCMHzwmigUwzxB3dC65Cz320x
xv8vLRZ6RhQRUdDVFv9Z
=uEpB
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Jun_2013_14_52_33_+1000_b5/T6XhPyc81Qf.o--
