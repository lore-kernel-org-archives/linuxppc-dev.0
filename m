Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/6] powerpc: Enable sparse irq_descs on powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40910141144y1776c476uc8e26e06eb57e6ac@mail.gmail.com>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<91cec5c64da4ca31a025fc7c45d9f1b93c8b98da.1255499081.git.michael@ellerman.id.au>
	<fa686aa40910141144y1776c476uc8e26e06eb57e6ac@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-FCoKYUK7LrGZ9aySGy+f"
Date: Thu, 15 Oct 2009 10:51:16 +1100
Message-Id: <1255564276.9651.14.camel@concordia>
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


--=-FCoKYUK7LrGZ9aySGy+f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-10-14 at 12:44 -0600, Grant Likely wrote:
> On Tue, Oct 13, 2009 at 11:45 PM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > Defining CONFIG_SPARSE_IRQ enables generic code that gets rid of the
> > static irq_desc array, and replaces it with an array of pointers to
> > irq_descs.
> >
> > It also allows node local allocation of irq_descs, however we
> > currently don't have the information available to do that, so we just
> > allocate them on all on node 0.
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Why not make sparse IRQs manditory for all platforms?  Is there a
> performance concern with doing so?  From a maintenance perspective,
> I'd rather see IRQ descs manged in one way only to keep the code
> simple.

I agree on the maintenance angle. My thinking was we'd run with it
optional but default y for a release or two, and if no one complains we
can make it mandatory.

It does make some code paths bigger, and looking up an irq_desc is going
to take slightly more cycles. I don't think it's a big issue, but I
thought we should try it for a while before making it mandatory. The
code has only been tested on x86 and sh as far as I know.

cheers

ps. thanks for the review

--=-FCoKYUK7LrGZ9aySGy+f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrWY/QACgkQdSjSd0sB4dJXaQCfWc5lnHMwbG2TDY+c2d3KL6hP
TPgAnAxAtNrs/d1wd1CKnvtBX5n9p+XN
=ySgu
-----END PGP SIGNATURE-----

--=-FCoKYUK7LrGZ9aySGy+f--
