Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
From: Michael Ellerman <michael@ellerman.id.au>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20070606172900.GA29951@xyzzy.farnsworth.org>
References: <20070523220518.GA2312@xyzzy.farnsworth.org>
	<18022.20173.857845.49576@cargo.ozlabs.ibm.com>
	<20070606172900.GA29951@xyzzy.farnsworth.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pRC+Ru3XFeLrsCD03jIo"
Date: Fri, 08 Jun 2007 12:15:15 +1000
Message-Id: <1181268915.6026.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pRC+Ru3XFeLrsCD03jIo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-06-06 at 10:29 -0700, Dale Farnsworth wrote:
> On Wed, Jun 06, 2007 at 04:06:05PM +1000, Paul Mackerras wrote:
> > Dale Farnsworth writes:
> >=20
> > > Paul, this patch is unchanged from the one I posted 10 days ago.
> > > At that time, I saw no discussion, other than Mark's ACK.  I'd=20
> > > argue that this is a bugfix, and hope that it could go into 2.6.22.
> >=20
> > Um, it seems rather large, and in particular adds a fair bit of
> > completely new code.  Is there a simpler way of getting to an
> > acceptable point - e.g. just not use the udbg console on these boards?
>=20
> Yeah, that was the first approach I took.  Unfortunately, currently the
> udbg console is included unconditionally on arch/powerpc.  I created the
> patch below to conditionalize the use of udbg console.  I thought it a
> bit risky for 2.6.22, but I think it's the right approach long term.
>=20
> > If we don't have udbg support for them then the udbg console would
> > seem a bit pointless, no?
>=20
> There is value in that with the udbg console we do see console output
> much earlier.  While there's some new code (I didn't think it was all
> that much), the impact is limited to the single platform now using the
> mv64x60 console port, the prpmc2800.

You don't select PPC_UDBG for any of the cell platforms, which AFAICT
means you'll break early debugging on those.

I think you should be able to do this in terms of
CONFIG_PPC_EARLY_DEBUG, which already exists.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pRC+Ru3XFeLrsCD03jIo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGaLuzdSjSd0sB4dIRArWLAKC84QeiGuqTwgiU80Ra2gv+4i2zwQCeNo5D
2ARLwTldwojV8y7snp82z08=
=7mub
-----END PGP SIGNATURE-----

--=-pRC+Ru3XFeLrsCD03jIo--
