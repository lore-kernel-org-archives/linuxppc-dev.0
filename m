Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc: Make NR_IRQS a CONFIG option
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40910141159l402304e9y22a6b2d7d8d79759@mail.gmail.com>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<fa686aa40910141159l402304e9y22a6b2d7d8d79759@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-62l9smU8SMSnAB72veqT"
Date: Thu, 15 Oct 2009 10:47:52 +1100
Message-Id: <1255564072.9651.10.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-62l9smU8SMSnAB72veqT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-10-14 at 12:59 -0600, Grant Likely wrote:
> On Tue, Oct 13, 2009 at 11:44 PM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > The irq_desc array consumes quite a lot of space, and for systems
> > that don't need or can't have 512 irqs it's just wasted space.
> >
> > The first 16 are reserved for ISA, so the minimum of 32 is really
> > 16 - and no one has asked for more than 512 so leave that as the
> > maximum.
>=20
> Does it really make sense to have this as a user twiddlable value?
> Especially when many users just don't have the background to know what
> an appropriate value is here and will get it wrong?  I believe your
> sparse IRQ patch has a bigger impact anyway on systems where memory is
> tight.

We have users? But yes I think it's reasonable, there's a million other
options people can fiddle with and break their kernel, I don't see that
this is much different.

The sparse IRQ patch has a bigger difference on the size of the irq_desc
array, but there are still other things that are statically sized based
on NR_IRQs. So if you're building an machine-specific kernel and you
know you're only going to have N interrupts, then this will give you a
bigger saving.

But I'm not super fussed, if other people think it's too dangerous we
can drop it.

cheers



--=-62l9smU8SMSnAB72veqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrWYyUACgkQdSjSd0sB4dIiEACfevng5ge/kWXo6vRaGEhuecgV
w4IAn1Jy0ZP2+afXb2aCY/gsypt5LcHu
=o/3T
-----END PGP SIGNATURE-----

--=-62l9smU8SMSnAB72veqT--
